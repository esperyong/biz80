<%--  
 *************************************************************************
 * @source  : add-model.jsp
 * @desc    : Mocha BSM 8.0
 *------------------------------------------------------------------------
 * VER  DATE         AUTHOR      DESCRIPTION
 * ---  -----------  ----------  -----------------------------------------
 * 1.0  2011.5.11	 huaf     	 新增模型
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
<title>新增模型</title>
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
</head>
<script>
	var ctx= "${ctx}";
	if("<s:property value='tip' />"=="success"){
		returnValue="success";
		window.close();
	}
</script>
<body>
	<page:applyDecorator name="popwindow"  title="新增模型">
	
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

	<form id="formID">
		<div><span class="sub-panel-tips" style="line-height:20px;"></span>新增的资源模型应用于当前版本，不保证适用于所有版本。</div>
		<s:hidden name="resourceCategoryId" value="%resourceCategoryId"/>
		<fieldset class="blue-border-nblock">
		    <legend>基本信息</legend>
				<ul class="fieldlist-n">
					<li>
						<span class="field-middle" style="width:125px;">设备类型</span><span>：</span>
						<select id="devicefristsTypeId" >
						<s:iterator value="deviceTypes" id="map">
							<option value="<s:property value="#map.key" />" ><s:property value="#map.value" /></option>
						</s:iterator>
						</select>
						<s:if test="deviceSecondTypes!=null && !deviceSecondTypes.isEmpty()">
						<select id="deviceSecondTypeId">
						<s:iterator value="deviceSecondTypes" id="map">
							<option value="<s:property value="#map.key" />" ><s:property value="#map.value" /></option>
						</s:iterator>
						</select>
						</s:if>
						<s:if test="deviceThridTypes!=null && !deviceThridTypes.isEmpty()">
						<select id="deviceThridTypeId">
						<s:iterator value="deviceThridTypes" id="map">
							<option value="<s:property value="#map.key" />" ><s:property value="#map.value" /></option>
						</s:iterator>
						</select>
						</s:if>
						<s:hidden id="resourceCategroupId" name="module.resourceCategroupId" />
					</li>
					<li>
						<span class="field-middle" style="width:125px;">模型显示名称</span><span>：</span>
						<s:textfield name="module.resourceName" cssClass="validate[required,noSpecialStr,length[0,30,模型名称]]"></s:textfield><span class="red">*</span>
						<br>
						<span class="field" style="color:red;width:100%;">*&nbsp;(模型显示名称，在需要显示监控模型的地方显示。如：华为交换机、Cisco路由器。)</span>
					</li>
					<li><span class="field-middle" style="width:125px;">备注</span><span>：</span>
						<s:textarea style="width:230px;height:80px;scrolling:auto;" name="module.resourceDescription" cssClass="validate[length[0,200,备注]]"></s:textarea>
					</li>
				</ul>
		</fieldset>
		<fieldset class="blue-border-nblock">
		    <legend>取值信息</legend>
				<ul class="fieldlist-n">
					<li>
						<span class="sub-panel-tips" style="line-height:20px;"></span>定义脚本返回值格式，资源名称必须是返回值的第一行第一列。
					</li>
					<li>
						<span class="field-middle" style="width:125px;">对应脚本</span><span>：</span>
						<s:textfield name="scriptTemplateIdForModule" readonly="true" cssClass="validate[required]"></s:textfield><span class="red">*</span><span id="selectScript" style="cursor:hand" class="tree-panel-ico tree-panel-ico-search"></span>
						<s:hidden name="module.scriptTemplateId"/>
					</li>
					<li>
						<span class="field-middle" style="width:125px;">脚本列分隔符</span><span>：</span>
						<s:textfield name="module.dataSeperator" size="5" cssClass="validate[required,length[0,5],myNoSpecialStr]" value=","></s:textfield><span class="red">*</span>
					</li>
					<li>
						<span class="field-middle" style="width:125px;">资源实例名称返回值</span><span>：</span>
						<s:textfield name="module.dataRow" size="3" readOnly="true" cssClass="validate[required,length[0,2],onlyNumber]" value="1"></s:textfield>行
						<s:textfield name="module.dataColumn" size="3" readOnly="true" cssClass="validate[required,length[0,2],onlyNumber]" value="1"></s:textfield>列<span class="red">(资源名称必须是返回值的第一行第一列。)</span>
					</li>
				</ul>
		</fieldset>
   	</form>

	</page:param>
</page:applyDecorator>
</body>
<script>
	$(document).ready(function(){
		$("#formID").validationEngine({
			promptPosition:"centerRight", 
			validationEventTriggers:"blur",
			inlineValidation: true,
			scroll:false,
			success:false
		});
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
			setCategroupIdFun();
			$("#formID").attr("action","${ctx}/scriptmonitor/repository/addModel!saveModel.action");
			$("#formID").submit();
		});
		var scritpId = $("input[name=module.scriptTemplateId]").val();
		$("#selectScript").click(function (){
			var url;
			if(scritpId){
				url = "${ctx}/scriptmonitor/repository/scriptMonitor!queryScriptRepository.action?scriptTemplateId="+scritpId;
			}else{
				url = "${ctx}/scriptmonitor/repository/scriptMonitor!queryScriptRepository.action";
			}
			scritpId = window.showModalDialog(url,"help=no;status=no;scroll=yes;center=yes");
			if(scritpId){
				$.ajax({
					url:		"${ctx}/scriptmonitor/repository/scriptTemplate!selectScriptById.action",
					data:		"scriptTemplate.id="+scritpId,
					dataType:	"json",
					cache:		false,
					success: function(data, textStatus){
						if(data.scriptTemplate){
							$("input[name=scriptTemplateIdForModule]").val(data.scriptTemplate.name);
							$("input[name=module.scriptTemplateId]").val(data.scriptTemplate.id);
						}
					}
				});
			}	
		});
		$("#devicefristsTypeId").change(function(){
			changeFristSelectFun($(this).val());
		});
		$("#deviceSecondTypeId").change(function(){
			changeSecondSelectFun($(this).val());
		});
		setCategroupIdFun();
	});
	function setCategroupIdFun(){
		if($("#deviceThridTypeId option:selected").val()&&!$("#deviceThridTypeId").is(":hidden")){
			$("#resourceCategroupId").val($("#deviceThridTypeId option:selected").val());
		}else if($("#deviceSecondTypeId option:selected").val()&&!$("#deviceSecondTypeId").is(":hidden")){
			$("#resourceCategroupId").val($("#deviceSecondTypeId option:selected").val());
		}else{
			$("#resourceCategroupId").val($("#devicefristsTypeId option:selected").val());
		}
	}
	function changeFristSelectFun(resourceCategoryId){
		var $secondSelect = $("#deviceSecondTypeId");
		var $thridSelect = $("#deviceThridTypeId");
		$.ajax({
			url:		"${ctx}/scriptmonitor/repository/addModel!findResourceCategory.action",
			data:		"resourceCategoryId="+resourceCategoryId,
			dataType:	"json",
			cache:		false,
			success: function(data, textStatus){
				var ids = data.categoryIds;
				var maps = data.deviceTypes;
				if(ids){
					$secondSelect.show();
					$secondSelect.empty();
					for(var i=0;i<ids.length;i++){
						$secondSelect.append("<option value='"+ids[i]+"'>"+maps[ids[i]]+"</option>");
					}
					changeSecondSelectFun(ids[0]);
				}else{
					$secondSelect.hide();
					$thridSelect.hide();
				}
			}
		});
	}
	
	function changeSecondSelectFun(resourceCategoryId){
		var $thridSelect = $("#deviceThridTypeId");
		$.ajax({
			url:		"${ctx}/scriptmonitor/repository/addModel!findResourceCategory.action",
			data:		"resourceCategoryId="+resourceCategoryId,
			dataType:	"json",
			cache:		false,
			success: function(data, textStatus){
				var ids = data.categoryIds;
				var maps = data.deviceTypes;
				if(ids){
					$thridSelect.show();
					$thridSelect.empty();
					for(var i=0;i<ids.length;i++){
						$thridSelect.append("<option value='"+ids[i]+"'>"+maps[ids[i]]+"</option>");
					}
				}else{
					$thridSelect.hide();
				}
			}
		});
	}
	
</script>
</html>