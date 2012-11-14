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
		
		$("#closeId").click(function(){
			window.close()
		});
		
		<s:if test="scriptTemplate.scriptParameters == null">
			executeScript();
		</s:if>
	});
	
	function executeScript(){
		$.blockUI({message:$('#loading')});
		$.ajax({
				url:		"${ctx}/scriptmonitor/repository/scriptTemplate!runScripte.action",
				data:		$("#addForm").serialize(),
				dataType:	"json",
				cache:		false,
				success:	function(data, textStatus){
					var resultContent;
					if(data.runResult.code=="<%=com.mocha.bsm.script.monitor.obj.ScriptRunResult.SUCCESS%>"){
						resultContent = "<span class=\"ico ico-right\"/><br/>";
						resultContent += "<br>脚本返回值:<br>";
						resultContent += "<textarea name=\"t1\" cols=\"85\" rows=\"7\">";
						for(var i=0; i<data.runResult.content.length; i++){
							resultContent+=data.runResult.content[i]+"\n";
						}
						resultContent +="</textarea>";
					} else{
						resultContent = "<br><div style=\"width:400px;color:red;word-wrap:break-word;\">"+data.runResult.errorMessage+"</div><br>";
						resultContent += "<br>脚本返回值:<br>";
						resultContent += "<textarea name=\"t1\" cols=\"85\" rows=\"7\">";
						for(var i=0; i<data.runResult.content.length; i++){
							resultContent+=data.runResult.content[i]+"\n";
						}
						resultContent +="</textarea>";
					}
					$("#resultDiv").html("<HR>执行结果：" + resultContent);
					$.unblockUI();
					dialogResize();
				}
			});
	}
</script>
</head>

<body>
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
	<page:param name="width">500px</page:param>
	<page:param name="topBtn_index_1">1</page:param>
	<page:param name="topBtn_id_1">closeId</page:param>
	<page:param name="topBtn_css_1">win-ico win-close</page:param>	
	<page:param name="content">
	
	<s:form id="addForm">
		<s:hidden name="scriptTemplate.id" value="%{scriptTemplate.id}"></s:hidden>
		<s:hidden name="scriptTemplate.repositoryId" value="%{scriptTemplate.repositoryId}"></s:hidden>
		<s:hidden name="scriptTemplate.groupId" value="%{scriptTemplate.groupId}"></s:hidden>
		<s:hidden name="scriptTemplate.name" value="%{scriptTemplate.name}"></s:hidden>
		<s:hidden name="scriptTemplate.filePath" value="%{scriptTemplate.filePath}"></s:hidden>
		
		<s:if test="scriptTemplate.scriptParameters!=null">
			<div style="padding-left:20px;padding-top:5px"><span class="sub-panel-tips" style="line-height:20px;"></span>输入脚本参数，执行脚本，测试脚本是否能够返回成功。</div>
			<div style="padding-left:20px;padding-top:10px" >
			<table cellspacing="0">
				<s:iterator value="scriptTemplate.scriptParameters">
					<tr >
						<s:hidden name="parameterIds" value="%{parameter.key}"></s:hidden>
						<td align="right">
							<div style="width:100px;height:20px;text-overflow:ellipsis;white-space:nowrap; overflow:hidden; "  title="${parameter.name}" >
								${parameter.name}
							</div>
						</td>
						<td align="left" width="40px" height="20px"><strong>：</strong></td>
						<td>
							<s:textfield name="%{parameter.key}" style="width:180px" value="%{parameter.defaultValue}"></s:textfield>
						</td>
					 </tr>
				</s:iterator>	
			</table>
		</div>	
			<div  style="width:480px;text-align:right" ><span onclick="executeScript();" class="gray-btn-l" title="执行"><span class="btn-r"><span class="btn-m"><a>执行</a></span></span></span>
			</div>
		</s:if>
		<s:else>
			<ul class="fieldlist-n"><li>没有参数</li></ul>
		</s:else>
	</s:form>
	<div id="resultDiv" style="margin-left:10px;max-height:500px;width:470px;overflow:auto;"></div>
	</page:param>
</page:applyDecorator>
</div>
</body>
</html>