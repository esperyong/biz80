<!-- WEB-INF\content\location\design\label-attribute.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Arrays" %>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base target="_self">
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>标注属性</title>
<link href="${ctxCss}/public.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/UIComponent.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/master.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/validationEngine.jquery.css" rel="stylesheet" type="text/css" media="screen" title="no title" charset="utf-8" />
<script src="${ctxJs}/jquery-1.4.2.min.js" type="text/javascript"></script>
<script src="${ctxJs}/jquery.validationEngine-cn.js" type="text/javascript"></script>
<script src="${ctxJs}/jquery.validationEngine.js" type="text/javascript"></script>
<script src="${ctxJs}/component/cfncc.js"></script>
<script src="${ctxJs}/component/tabPanel/tab.js"></script>
<script src="${ctxJs}/component/panel/panel.js" type="text/javascript"></script>
<script src="${ctxJs}/component/accordionPanel/accordionPanel.js" type="text/javascript"></script>
<script src="${ctxJs}/component/accordionPanel/accordionAddSubPanel.js" type="text/javascript"></script>
<script src="${ctxJs}/component/toast/Toast.js"></script>
<script src="${ctxJs}/location/define/locations.js"></script>
<script type="text/javascript">

$(document).ready(function() {
	var panel = null;
	var tp = new TabPanel({id:"mytab"});

	$("#submit").click(function(){
		opener.saveProperty({
		    type:$("#component_type").val(),
		    locationId:$("#component_locationId").val(),
		    componentId:$("#component_componentId").val(),
		    componentName:replaceXmlSpecialStr($("#component_componentName").val()),
		    isDoubleClick:$("input[name='component.isDoubleClick']:checked").length>0?
	    			 $("input[name='component.isDoubleClick']:checked").val():"",
	    	clickLocationId:$("#component_clickLocationId").val(),
	    	statusType:$("input[name='component.statusType']:checked").val()
		});
		window.close();
	});
	$("#cancel").click(function(){
		window.close();
	});

	$("#closeId").click(function(){
		window.close();
	});
	
	$("#apply").click(function(){
		$("#submit").click();
	});
	
	$("#browseLocation").click(function(){
		var location = window.showModalDialog("${ctx}/location/define/location!selectLocation.action","help=no;status=no;scroll=yes;center=yes");
		if(location){
			$("#component_clickLocationId").val(location.id);
			$("#component_clickLocationName").val(location.name);
		}
	});
	
	setRadioValue("component.statusType", "${component.statusType}"==""?"1":"${component.statusType}");
});

function setRadioValue(radioName, value){
	$("input[name='"+radioName+"']").each(function(){
		if(this.value==value){
			this.checked = true;
		}
	});
}
</script>
</head>
<body >

<page:applyDecorator name="popwindow"  title="标注属性">
	
	<page:param name="width">510px</page:param>
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
	
<ul class="fieldlist-n">
		<s:hidden name="component.type" id="component_type"/>
		<s:hidden name="component.locationId" id="component_locationId"/>
		<s:hidden name="component.componentId" id="component_componentId"/>
		
	<li><span>标注文本：</span>
		<s:textfield name="component.componentName" id="component_componentName"></s:textfield>
	</li>
	<li>
		<s:checkboxlist name="component.isDoubleClick" list="#{'true': '双击时打开区域：'}"/>
		<s:hidden name="component.clickLocationId" id="component_clickLocationId"/>
		<s:textfield name="component.clickLocationName" id="component_clickLocationName"></s:textfield>
		<span class="black-btn-l" id="browseLocation"><span class="btn-r"><span class="btn-m"><a>浏览</a></span></span></span><br>

		<span>状态显示方式：</span>
		<s:radio name="component.statusType" list="#{'1':'使用状态灯', '2':'填充颜色' }" />
	</li>
</ul>

	</page:param>
</page:applyDecorator>

</body>
</html>