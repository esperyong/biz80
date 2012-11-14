<%--  
 *************************************************************************
 * @source  : add-sysoid-page.jsp
 * @desc    : Mocha BSM 8.0
 *------------------------------------------------------------------------
 * VER  DATE         AUTHOR      DESCRIPTION
 * ---  -----------  ----------  -----------------------------------------
 * 1.0  2011.5.18	 huaf     	添加型号配置
 * ----------- ----------  -----------------------------------------------
 * Copyright(c) 2011 mochasoft,  All rights reserved.
 *************************************************************************
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<%@ include file="/WEB-INF/common/meta.jsp" %>
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
<script>
	if("<s:property value='operateState'/>"!=""){
		if("<s:property value='operateState'/>"=="true"){
			window.returnValue="<s:property value='sysObjectID.resource'/>";
		}
		window.close();
	}
</script>
</head>
<body>
	<page:applyDecorator name="popwindow"  title="型号配置">
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
			<ul class="fieldlist-n">
				<li>
					<span class="field-middle" style="width:125px;">资源</span><span>：</span>
					<select name="sysObjectID.resource">
						<s:iterator value="resourceTypes" id="map">
							<option value="<s:property value="#map.key"/>"><s:property value="#map.value"/></option>
						</s:iterator>
					</select>
				</li>
				<li>
					<span class="field-middle" style="width:125px;">SysObjectID</span><span>：</span>
					<s:textfield name="sysObjectID.oid" cssClass="validate[required,noSpecialStr,length[0,30,SysObjectID],ajax[isNameExist]]"></s:textfield><span class="red">*</span>			
				</li>
				<li>
					<span class="field-middle" style="width:125px;">类型</span><span>：</span>
					<select id="selectType" name="sysObjectID.type" >
					<s:iterator value="types" id="map">
						<s:if test="#map.key == #sysObjectID.type">
							<option value="<s:property value="#map.key" />" selected><s:property value="#map.value" /></option>
						</s:if><s:else>
							<option value="<s:property value="#map.key"/>" ><s:property value="#map.value" /></option>
						</s:else>
					</s:iterator>
					</select>
					<select id="selectOS" style="display:none;">
					<s:iterator value="osTypes" id="map">
						<s:if test="#map.key == #sysObjectID.os">
							<option value="<s:property value="#map.key" />" selected><s:property value="#map.value" /></option>
						</s:if><s:else>
							<option value="<s:property value="#map.key"/>" ><s:property value="#map.value" /></option>
						</s:else>
					</s:iterator>
					</select>
					<s:hidden id="osId" name="sysObjectID.os" value="%{sysObjectID.os}"/>
				</li>
				<li>
					<span class="field-middle" style="width:125px;">厂商</span><span>：</span>
					<s:textfield name="sysObjectID.vender" cssClass="validate[required,noSpecialStr,length[0,30,厂商]]" value="%{sysObjectID.vender}"></s:textfield><span class="red">*</span>
				</li>
				<li>
					<span class="field-middle" style="width:125px;">型号</span><span>：</span>
					<s:textfield name="sysObjectID.model" cssClass="validate[required,noSpecialStr,length[0,30,型号]]" value="%{sysObjectID.model}"></s:textfield><span class="red">*</span>
				</li>
				<li>
					<span class="field-middle" style="width:125px;">描述</span><span>：</span>
					<s:textarea style="width:230px;height:80px;scrolling:auto;" name="sysObjectID.desc"  cssClass="validate[length[0,200,描述]]" value="%{sysObjectID.desc}"></s:textarea>
				</li>
			</ul>
   	</form>
	</page:param>
</page:applyDecorator>
<script>
$(document).ready(function(){
	$("#formID").validationEngine({
		promptPosition:"centerRight", 
		validationEventTriggers:"blur",
		inlineValidation: true,
		scroll:false,
		success:false
	});
	$.validationEngineLanguage.allRules.isNameExist={
   		"file":"${ctx}/monitorsetting/model/sysoidSetting!vaildSameName.action",
   	    "alertTextLoad":"* 正在验证，请等待",
   	    "alertText":"SysObjectID已经存在"
   	}	
	$(".win-close,#cancel").bind("click",function(){
		window.close();
	});
	$("#submit").bind("click",function(){
		setOSValueFun();
		$("#formID").attr("action","${ctx}/monitorsetting/model/sysoidSetting!saveSysOid.action");
		$("#formID").submit();
	});
	$("#selectType").bind("change",function(){
		changeTypeFun();
	});
	changeTypeFun();
});
function setOSValueFun(){
	var $selectType = $("#selectType");
	var $selectOS = $("#selectOS");
	var $osId = $("#osId");
	if($selectOS.css("display") == "none"){
		$osId.val($selectType.val());
	}else{
		$osId.val($selectOS.val());
	}
}
function changeTypeFun(){
	var $selectOS = $("#selectOS");
	if($("#selectType").val()=="Host"){
		$selectOS.show();
	}else{
		$selectOS.hide();
	}
}
</script>
</body>
</html>