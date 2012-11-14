<!-- WEB-INF\content\location\design\location-attribute.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Arrays" %>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base target="_self">
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>节点属性</title>
<link href="${ctxCss}/public.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/UIComponent.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/master.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/common.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/button-module.css" rel="stylesheet" type="text/css">
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
	new AccordionPanel({id:"defaultImage"},
			{DomStruFn:"addsub_accordionpanel_DomStruFn",
			DomCtrlFn:"addsub_accordionpanel_DomCtrlFn"
				});
	new AccordionPanel({id:"customImage"},
			{DomStruFn:"addsub_accordionpanel_DomStruFn",
			DomCtrlFn:"addsub_accordionpanel_DomCtrlFn"
				});
	$("#submit").click(function(){
		opener.saveProperty({
		    type:$("#component_type").val(),
		    locationId:$("#component_locationId").val(),
		    imageId:$("#component_imageId").val(),
		    componentId:$("#component_componentId").val(),
		    componentName:replaceXmlSpecialStr($("#component_componentName").val()),
		    position:$("#component_position").val(),
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
	
	$("input[name='component.statusType'][value='${component.statusType}']").attr("checked","checked");
	
	$("#browseLocation").click(function(){
		var lId = $("#component_locationId").val();
		var location = window.showModalDialog("${ctx}/location/define/location!selectLocation.action?location.locationId="+lId,null,"help=no;status=no;scroll=no;center=yes");
		if(location){
			$("#component_clickLocationId").val(location.id);
			$("#component_clickLocationName").val(location.name);
		}
	});
	
	// 设置当前选择的图片的名称
	$("#imageName").html($("img[id='${component.imageId}']").attr("name"))
});

function replaceImage(image){
	$("#component_imageId").val(image.id);
	$("#imageName").html(image.name);
	$("[name='currentImage']").each(function(){
		this.src=image.src;
	})
}
</script>
</head>
<body >

<page:applyDecorator name="popwindow"  title="节点属性">
	
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
	
	<page:applyDecorator name="tabPanel">  
		<page:param name="id">mytab</page:param>
		<page:param name="width">498</page:param>
		<page:param name="tabBarWidth">498</page:param>
		<page:param name="cls">tab-grounp</page:param>
		<page:param name="background">white</page:param>
		<page:param name="current">1</page:param>
		<page:param name="tabHander">[{text:"设置节点",id:"picture"},{text:"替换图片",id:"backdrop"}]</page:param>
		<page:param name="content_1">
		
		<ul class="fieldlist-n">
			<li><span>节点类型：</span>
				<s:hidden name="component.type" id="component_type"/>
				<s:hidden name="component.componentId" id="component_componentId"/>
				<s:hidden name="component.locationId" id="component_locationId"/>
				<s:hidden name="component.imageId" id="component_imageId"/>
				<s:property value="%{getText(designImageType.value)}"/>
			</li>
			<li><span>节点名称：</span>
				<s:textfield name="component.componentName" id="component_componentName"></s:textfield>
			</li>
			<li><span>名称显示位置：</span>
				<s:select name="component.position" id="component_position" list="#{'down':'节点下方', 'up':'节点上方' }"></s:select>
			</li>
			<!--
			<li>
				<span>预览：</span>
				<img name="currentImage" src="${ctx}/location/design/designImage!getImage.action?designImage.id=${component.imageId}" height="40" width="40"/>
			</li>
			-->
			<li>
				<s:checkboxlist name="component.isDoubleClick" list="#{'true': '双击时打开区域：'}"/>
				<s:textfield name="component.clickLocationName" id="component_clickLocationName"></s:textfield>
				<span class="black-btn-l" id="browseLocation"><span class="btn-r"><span class="btn-m"><a>浏览</a></span></span></span>
				<s:hidden name="component.clickLocationId" id="component_clickLocationId"/>
			</li>
			<li>
				<span>状态显示方式：</span><s:radio name="component.statusType" value="0" list="#{'0':'不使用状态灯','1':'使用状态灯'}" />
			</li>
		</ul>
	
		</page:param>
		<page:param name="content_2">
		<ul class="fieldlist-n">
			<li><span>
			<page:applyDecorator name="accordionAddSubPanel">  
			<page:param name="id">defaultImage</page:param>
			<page:param name="title">默认图片</page:param>
			<page:param name="width">370px</page:param>
			<page:param name="cls">fold-blue</page:param>
			<page:param name="content">
				<div class="img-show" style="width: 370px;">
			<ul>
				<s:iterator value="images" id="image">
					<s:if test="isdefault">
						<s:if test="type == designImageType.key">
					<li>
						<img id="${id }" name="${name }" onClick="replaceImage(this)" src="${ctx}/location/design/designImage!getImage.action?designImage.id=${id}" height="40" width="40"/>
						<span class="more">${name }</span>
					</li>
						</s:if>
					</s:if>
				</s:iterator>
			</ul>
			</div>
			</page:param>
	    	</page:applyDecorator>
	    	<page:applyDecorator name="accordionAddSubPanel">  
			<page:param name="id">customImage</page:param>
			<page:param name="title">自定义</page:param>
			<page:param name="width">370px</page:param>
			<page:param name="cls">fold-blue</page:param>
			<page:param name="content">
			<div class="img-show" style="width: 370px;">
			<ul>
				<s:iterator value="images" id="image">
					<s:if test="!isdefault">
					<li>
						<img id="${id }" name="${name }" onClick="replaceImage(this)" src="${ctx}/location/design/designImage!getImage.action?designImage.id=${id}" height="40" width="40"/>
						<span class="more">${name }</span>
					</li>
					</s:if>
				</s:iterator>
			</ul>
			</div>
			</page:param>
	    	</page:applyDecorator>
	    	</span>
	    	<span style="vertical-align:top">
	    		<img name="currentImage" src="${ctx}/location/design/designImage!getImage.action?designImage.id=${component.imageId}" height="40" width="40"/><br>
	    		当前使用：<span id="imageName"></span>
	    	</span>
			</li>
		</ul>
			
		</page:param>
	</page:applyDecorator>

	</page:param>
</page:applyDecorator>
</body>
</html>