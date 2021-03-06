<!-- WEB-INF\content\scriptmonitor\repository\input-scriptParamter.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base target="_self">
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>执行脚本</title>

<link href="${ctxCss}/public.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/UIComponent.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/master.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/validationEngine.jquery.css" rel="stylesheet" type="text/css" media="screen" title="no title" charset="utf-8" />
<script src="${ctxJs}/jquery-1.4.2.min.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/js/jquery.blockUI.js"></script>
<script src="${ctxJs}/jquery.validationEngine-cn.js" type="text/javascript"></script>
<script src="${ctxJs}/jquery.validationEngine.js" type="text/javascript"></script>
<script src="${ctxJs}/location/dialogResize.js"></script>
<script src="${ctxJs}/scriptmonitor/scriptRepositorys.js"></script>
<script type="text/javascript">
	var tmp="";
	//表单验证
	$(document).ready(function() {
		$("#addForm").validationEngine({
			promptPosition:"centerRight", 
			validationEventTriggers:"keyup blur change",
			inlineValidation: true,
			scroll:false,
			success:false
		});
		
		$("#closeId,#cancel").click(function(){
			window.close()
		});
		
		executeScript();

	});
	
	function executeScript(){
		$.blockUI({message:$('#loading')});
		$.ajax({
				url:		"${ctx}/scriptmonitor/repository/scriptPropfile!runScript.action",
				data:		$("#addForm").serialize(),
				dataType:	"json",
				cache:		false,
				success:	function(data, textStatus){
					var resultContent="",resultInfo="";
					if(data.runResult.code=="<%=com.mocha.bsm.script.monitor.obj.ScriptRunResult.SUCCESS%>"){
						resultInfo = "<span class=\"ico ico-right\"/>";
						resultContent += "<textarea name=\"t1\" cols=\"92\" rows=\"7\">";
						for(var i=0; i<data.runResult.content.length; i++){
							resultContent+=data.runResult.content[i]+"\n";
						}
						resultContent +="</textarea>";
					} else{
						resultInfo = "<span style=\"width:400px;color:red;word-wrap:break-word;\">"+data.runResult.errorMessage+"</span>";
						resultContent += "<textarea name=\"t1\" cols=\"92\" rows=\"6\">";
						for(var i=0; i<data.runResult.content.length; i++){
							resultContent+=data.runResult.content[i]+"\n";
						}
						resultContent +="</textarea>";
					}
					$("#scriptResult").html("脚本执行结果：" + resultInfo);
					$("#resultDiv").html("脚本返回值：" + resultContent);
					$.unblockUI();
					dialogResize();
				}
			});
	}
</script>
</head>

<body >
<div class="loading" id="loading" style="display:none;">
	 <div class="loading-l">
	  <div class="loading-r">
	    <div class="loading-m">
	       <span class="loading-img">正在执行，请稍候...</span> 
	    </div>
	  </div>
	  </div>
</div>
<div id="addParameterDiv">
<page:applyDecorator name="popwindow"  title="执行脚本">
	
	<page:param name="width">520px</page:param>
	<page:param name="topBtn_index_1">1</page:param>
	<page:param name="topBtn_id_1">closeId</page:param>
	<page:param name="topBtn_css_1">win-ico win-close</page:param>
	

	
	<page:param name="content">
	
	<s:form id="addForm">
		<s:hidden name="scriptProfile.scriptId" value="%{scriptProfile.scriptId}"/>
		
		<s:if test="parameters!=null">
			<div><span class="sub-panel-tips" style="line-height:20px;"></span>输入脚本参数，执行脚本，测试脚本是否能够返回成功。</div>
			<table cellspacing="5">
				<s:iterator value="parameters" status="status" id="parametersList">
					  <tr>
						<s:hidden name="scriptProfile.sptParameterList[%{#status.index}].parameterId" value="%{proParameterId}"/>
						<td>
							<span><s:property value='parameteName'/></span>
						</td>
						<td><span>：</span></td>
						<td>
							<input readonly type="hidden" name="scriptProfile.sptParameterList[<s:property value="#status.index"/>].parameterValue" value="<s:property value='proParameterValue'/>"/>
							<s:property value='proParameterValue'/>
						</td>
					 </tr>
				</s:iterator>
			</table>
		</s:if>
		<s:else>
			<ul class="fieldlist-n"><li>没有参数</li></ul>
		</s:else>
	</s:form>
	
	<div id="scriptResult" style="margin:5px 0px 5px 5px;"></div>
	<div id="resultDiv" style="margin:5px 0px 5px 5px;max-height:500px;width:500px;overflow:auto;"></div>
	</page:param>
</page:applyDecorator>
</div>
</body>
</html>