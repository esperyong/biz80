<%--  
 *************************************************************************
 * @source  : add-metric.jsp
 * @desc    : Mocha BSM 8.0
 *------------------------------------------------------------------------
 * VER  DATE         AUTHOR      DESCRIPTION
 * ---  -----------  ----------  -----------------------------------------
 * 1.0  2011.5.18	 huaf     	 新增指标
 * ----------- ----------  -----------------------------------------------
 * Copyright(c) 2011 mochasoft,  All rights reserved.
 *************************************************************************
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base target="_self">
<%@ include file="/WEB-INF/common/meta.jsp" %>
<s:if test="metricId != null">
	<s:set name="action" value="\"/scriptmonitor/repository/scriptRepository!updateScriptGroup.action\"" scope="request"/>
	<s:set name="titleName" value="\"编辑指标\"" scope="request"/>
</s:if>
<s:else>
	<s:set name="action" value="\"/scriptmonitor/repository/scriptRepository!addScriptGroup.action\"" scope="request"/>
	<s:set name="titleName" value="\"新增指标\"" scope="request"/>
</s:else>
<title>${titleName}</title>
<link href="${ctxCss}/public.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/UIComponent.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/master.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/validationEngine.jquery.css" rel="stylesheet" type="text/css" media="screen" title="no title" charset="utf-8" />
<script src="${ctxJs}/jquery-1.4.2.min.js" type="text/javascript"></script>
<script src="${ctxJs}/jquery.validationEngine-cn.js" type="text/javascript"></script>
<script src="${ctxJs}/jquery.validationEngine.js" type="text/javascript"></script>
<script src="${ctxJs}/component/cfncc.js"></script>
<script src="${ctxJs}/component/tabPanel/tab.js"></script>
<script src="${ctxJs}/component/gridPanel/grid.js"></script>
<script src="${ctxJs}/component/gridPanel/indexgrid.js"></script>
<script src="${ctxJs}/component/toast/Toast.js"></script>
<script src="${ctxJs}/location/dialogResize.js"></script>
<script src="${ctxJs}/component/panel/panel.js"></script>
<script type="text/javascript" src="${ctx}/js/scriptmonitor/modolExtension.js"></script>

</head>
<script>
	var ctx= "${ctx}";
	if("<s:property value='tip' />"=="success"){
		window.returnValue="success";
		window.close();
	}
</script>
<body>
	<page:applyDecorator name="popwindow"  title="${titleName}">
	
	<page:param name="width">600px;</page:param>
	<page:param name="topBtn_index_1">1</page:param>
	<page:param name="topBtn_id_1">closeId</page:param>
	<page:param name="topBtn_css_1">win-ico win-close</page:param>
	
	<page:param name="bottomBtn_index_1">1</page:param>
	<page:param name="bottomBtn_id_1">submit</page:param>
	<page:param name="bottomBtn_text_1">确定</page:param>
	
	<page:param name="bottomBtn_index_2">2</page:param>
	<page:param name="bottomBtn_id_2">cancel</page:param>
	<page:param name="bottomBtn_text_2">取消</page:param>
	
	<page:param name="content">
	<div style="height:450px;overflow:auto">
	<form id="formID">
		<div><span class="sub-panel-tips" style="line-height:20px;"></span>新增的资源模型应用于当前版本，不保证适用于所有版本。</div>
		<s:hidden name="resourceCategoryId" value="%resourceCategoryId"/>
		<fieldset class="blue-border-nblock">
		    <legend>基本信息</legend>
				<ul class="fieldlist-n">
					<li>
						<span class="field-middle" style="width:125px;">指标类型</span><span>：</span>
						<s:if test="null!=metric && null!=metric.metricType">
							<span><s:text name="ScriptMonitor.%{metric.metricType}"/></span>
							<s:hidden name="metric.metricType" value="%{metric.metricType}"/>
						</s:if>
						<s:else>
							<select name="metric.metricType">
							<s:iterator value="metricTypes" id="map">
								<option value="<s:property value="#map.key" />" ><s:property value="#map.value" /></option>
							</s:iterator>
							</select>
						</s:else>
					</li>
					<li>
						<span class="field-middle" style="width:125px;">指标显示名称</span><span>：</span>
						<s:textfield name="metric.metricName" value="%{metric.metricName}" cssClass="validate[required,noSpecialStr,length[0,30,指标名称]]"></s:textfield><span class="red">*</span>
					</li>
					<li><span class="field-middle" style="width:125px;">指标描述</span><span>：</span>
						<s:textarea style="width:230px;height:80px;scrolling:auto;" name="metric.description" value="%{metric.description}" cssClass="validate[length[0,200,备注]]"></s:textarea>
					</li>
				</ul>
		</fieldset>
		<fieldset class="blue-border-nblock">
		    <legend>取值信息</legend>
				<ul class="fieldlist-n">
					<li>
						<span class="sub-panel-tips" style="line-height:20px;"></span>定义脚本返回值格式，资源实例的名称必须是返回值的第一列，多个资源实例返回多行。
					</li>
					<li>
						<span class="field-middle" style="width:125px;">对应脚本</span><span>：</span>
						<s:textfield name="scriptTemplateIdForModule" readonly="true" cssClass="validate[required]"></s:textfield><span class="red">*</span><span id="selectScript" style="cursor:hand" class="tree-panel-ico tree-panel-ico-search"></span>
						<s:hidden name="metric.scriptTemplateId" value="%{metric.scriptTemplateId}"/>
					</li>
					<li>
						<span class="field-middle" style="width:125px;">脚本列分隔符</span><span>：</span>
						<s:if test="metric == null || metric.dataSeperator == null">
							<s:textfield name="metric.dataSeperator"  value=","  size="5" cssClass="validate[required,length[1,5],myNoSpecialStr]"></s:textfield><span class="red">*</span>
						</s:if>
						<s:else>
							<s:textfield name="metric.dataSeperator"  value="%{metric.dataSeperator}"  size="5" cssClass="validate[required,length[1,5],myNoSpecialStr]"></s:textfield><span class="red">*</span>
						</s:else>
						
					</li>
					<li>
						<span class="field-middle" style="width:125px;">指标值对应脚本返回值</span><span>：</span>
						<s:if test="parentId == null || parentId ==''">
							<s:if test="metric == null || metric.dataRow == 0">
								<s:textfield name="metric.dataRow" size="3" value="1" cssClass="validate[required,length[0,2],greaterZeroNumber]"></s:textfield>行<span class="red">*</span>
							</s:if>
							<s:else>
								<s:textfield name="metric.dataRow" size="3" value="%{metric.dataRow}" cssClass="validate[required,length[0,2],greaterZeroNumber]"></s:textfield>行<span class="red">*</span>
							</s:else>
						</s:if>
						<s:if test="metric == null || metric.dataColumn == 0">
							<s:textfield name="metric.dataColumn" size="3" value="1" cssClass="validate[required,length[0,2],greaterZeroNumber]"></s:textfield>列<span class="red">*</span>
						</s:if>
						<s:else>
							<s:textfield name="metric.dataColumn" size="3" value="%{metric.dataColumn}" cssClass="validate[required,length[0,2],greaterZeroNumber]"></s:textfield>列<span class="red">*</span>
						</s:else>
					</li>
					<li>
						<span class="field-middle" style="width:125px;">指标值类型</span><span>：</span>
						<s:radio list="#{'1':'数字','2':'文本'}" name="threshold"
						       id="threshold" value="1"
						       required="true" />
						<s:hidden id="thresholdTypeVal" name="metric.thresholdType" value="%{metric.thresholdType}"/>  
					</li>
					<li>
						<span class="field-middle" style="width:125px;">指标单位</span><span>：</span>
						<s:textfield name="metric.unit"  value="%{metric.unit}"  size="5" ></s:textfield>
					</li>
					<li>
						<span id="setValueInfo" class="red" style="width:600px;"></span>
					</li>
				</ul>
		</fieldset>
		<div id="paramValues"></div>
		<s:hidden id="resourceId" name="metric.resourceId" value="%{resourceId}"/>
		<s:hidden name="metric.metricId" value="%{metricId}"/>
		<s:hidden name="isExtension" value="%{resourceModule.extension}"/>
		<s:hidden name="resourceName" value="%{resourceModule.resourceName}"/>
   	</form>
   	</div>
	</page:param>
</page:applyDecorator>
</body>
<script>
	var dataParam="resourceId="+$("#resourceId").val()+"&metricId=<s:property value='metricId'/>";
	$(document).ready(function(){
		$("#formID").validationEngine({
			promptPosition:"centerRight", 
			validationEventTriggers:"blur",
			inlineValidation: true,
			scroll:false,
			success:false
		});
		$.validationEngineLanguage.allRules.greaterZeroNumber={
				"regex":"/^[1-9]+$/",                
				"alertText":"* 请输入大于0的数字."
		}
		$.validationEngineLanguage.allRules.myNoSpecialStr={
				"regex":"/^$|^[^:;'&#<>()%*?！|\"^*]+$/",
				"alertText":"<font color='red'>*</font> ^^^不能输入非法字符  : ; ' & # < > ( ) % * ? ！ | &quot; ^"
		}
		$("#cancel").bind("click",function(){
			window.close();
		});
		$(".win-close").bind("click",function(){
			window.close();
		});
		$("#submit").bind("click",function(){
			$("#formID").attr("action","${ctx}/scriptmonitor/repository/addMetric!saveMetric.action");
			$("#formID").submit();
		});
		$(".win-close").bind("click",function(){
			window.close();
		});
		$("input[name='threshold']").bind("click",function(){
			$("#thresholdTypeVal").val($(this).val());
		});
		if(!$("#thresholdTypeVal").val() || $("#thresholdTypeVal").val()==0){
			$("#thresholdTypeVal").val($("input[name='threshold']").val());
		}else{
			var value = $("#thresholdTypeVal").val();
			$("input[name='threshold']").get(value-1).checked=true;
		}
		var scritpId = $("input[name=metric.scriptTemplateId]").val();
		$("#selectScript").click(function (){
			var url;
			if(scritpId){
				url = "${ctx}/scriptmonitor/repository/scriptMonitor!queryScriptRepository.action?scriptTemplateId="+scritpId;
			}else{
				url = "${ctx}/scriptmonitor/repository/scriptMonitor!queryScriptRepository.action";
			}
			scritpId = window.showModalDialog(url,"help=no;status=no;scroll=yes;center=yes");
			if(scritpId){
				getScriptTemplateFun(scritpId,dataParam,"metric","${resourceModule.extension}",$("input[name=resourceName]").val(),"${resourceId}","${metricId}");
			}
		});
		var scriptTemplateId = $("input[name=metric.scriptTemplateId]").val();
		getScriptTemplateFun(scriptTemplateId,dataParam,"metric","${resourceModule.extension}",$("input[name=resourceName]").val(),"${resourceId}","${metricId}");
	
		$("select[name=metric.metricType]").bind("change",function(){
			setDefaultValInfoFun($("select[name=metric.metricType]").val());
		});
		setDefaultValInfoFun();
	});
	//设置默认域值提示信息。
	function setDefaultValInfoFun(type){
		var metricType;
		if(type){
			metricType = type;
		}else{
			metricType = "<s:property value='metric.metricType' />";
		}
		if(metricType && metricType == "<s:property value='@com.mocha.bsm.script.monitor.obj.extension.ResourceMetric@METRIC_AVAIL'/>"){
			$("#setValueInfo").html("*可用性指标，增加描述：*注意，指标的默认监控频度为1分钟，可在资源-监控策略中修改。");
		}else if(metricType && metricType == "<s:property value='@com.mocha.bsm.script.monitor.obj.extension.ResourceMetric@METRIC_PERF'/>"){
			$("#setValueInfo").html("*性能指标，增加描述：*注意，指标的默认阈值为60和90，频度为5分钟，可在资源-监控策略中修改。 如果指标值类型为文本，默认阈值为：Error，Warning。");
		}else if(!metricType){
			$("#setValueInfo").html("*注意，指标的默认监控频度为1分钟，可在资源-监控策略中修改。");
		}else{
			$("#setValueInfo").html("");
		}
	}
</script>
</html>