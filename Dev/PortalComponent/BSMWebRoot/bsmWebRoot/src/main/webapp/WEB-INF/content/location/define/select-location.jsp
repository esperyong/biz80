<!-- WEB-INF\content\location\define\select-location.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>选择物理位置</title>
<link href="${ctxCss}/public.css" rel="stylesheet" type="text/css" />
<link href="${ctxCss}/jquery-ui/treeview.css" rel="stylesheet" type="text/css" />
<link href="${ctxCss}/button-module.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/public.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/UIComponent.css" rel="stylesheet" type="text/css">
<script src="${ctxJs}/jquery-1.4.2.min.js"></script>
<script src="${ctxJs}/component/cfncc.js"></script>
<script src="${ctxJs}/component/treeView/tree.js"></script>
<script src="${ctxJs}/location/dialogResize.js"></script>
</head>
<body >
<page:applyDecorator name="popwindow"  title="物理位置">
	
	<page:param name="width">400px</page:param>
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

			<s:set name="treeName" value="'LocationTree'"/>
			<s:if test="!locations.isEmpty()">
				<s:bean var="nodeStyle" name="com.mocha.bsm.action.location.define.util.LoctionSeleteStyle"/>
				<s:bean var="treeHelper" name="com.mocha.bsm.action.location.define.util.LocationTreeHelper">
					<s:param name="nodeStyle" value="#nodeStyle"/>
					<s:property value="getTreeHtml(#treeName,locations)" escape="false"/>
				</s:bean>
			</s:if>
			<s:else>
					<span>没有物理位置</span></div>
			</s:else>

	</page:param>
</page:applyDecorator>

<script type="text/javascript">
	var locationId = "";
	var locationNmae = "";
	$(document).ready(function () {
		// 指定树的事件
		var tree = new Tree({id:"${treeName}",listeners:{
								  nodeClick:function(node){
									  locationId = node.getId();
									  locationNmae = node.getText();
								  }
		  					}}); 
		
		$("#closeId").click(function (){
			window.close();
		});
		$("#cancel").click(function (){
			window.close();
		});
		
		$("#submit").click(function (){
			window.returnValue={id:locationId, name:locationNmae};
			window.close();
		});
	});
</script>
</body>
</html>