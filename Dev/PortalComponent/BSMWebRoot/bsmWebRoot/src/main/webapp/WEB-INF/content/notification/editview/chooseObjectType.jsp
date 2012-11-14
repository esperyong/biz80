<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/WEB-INF/common/meta.jsp"%>
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" ></link>
<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css" ></link>
<link href="${ctx}/css/jquery-ui/treeview.css" rel="stylesheet" type="text/css" ></link>
<script type="text/javascript">
path = '${ctx}';
</script>
<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script src="${ctx}/js/component/cfncc.js"></script>
<script src="${ctx}/js/component/treeView/tree.js"></script>
<script type="text/javascript" src="${ctx}/js/notification/comm.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery.blockUI.js"></script>
<style>
.treeview{
	overflow:hidden;
}
</style>
</head>
<body>
<%@ include file="/WEB-INF/common/loading.jsp"%>
<script type="text/javascript">
	$.blockUI({message:$('#loading')});
</script>
<page:applyDecorator name="popwindow"  title="实时告警视图">
	<page:param name="width">500px;</page:param>
	<page:param name="height">450px;</page:param>
	<page:param name="topBtn_index_1">1</page:param>
	<page:param name="topBtn_id_1">win-close</page:param>
	<page:param name="topBtn_title_1">关闭</page:param>
	<page:param name="topBtn_css_1">win-ico win-close</page:param>
	
	<page:param name="bottomBtn_index_1">1</page:param>
	<page:param name="bottomBtn_id_1">confirm_button</page:param>
	<page:param name="bottomBtn_text_1">确定</page:param>
	
	<page:param name="bottomBtn_index_2">2</page:param>
	<page:param name="bottomBtn_id_2">cancel_button</page:param>
	<page:param name="bottomBtn_text_2">取消</page:param>
	<page:param name="content">
	<div style="height:450px;overflow-y:auto;overflow-x:hidden;">
		${objTypeTree}
	</div>
	</page:param>
</page:applyDecorator>
<script type="text/javascript">
var tree = new Tree({id : "leftObjectTypeTree"});
$.unblockUI();
$(function(){
	$("#confirm_button").click(function(){
		var checkedNodes = tree.getNodeById("selectAll").getCheckedNodes(true);//只获取叶子节点
		var nameArray = [];
		var idsArray = [];
		$.each(checkedNodes,function(i,e){
			idsArray.push(e.getId());
			nameArray.push(e.getText());
		});
		opener.fillObjTypes && opener.fillObjTypes(nameArray,idsArray);
		$.blockUI({message:$('#loading')});
		closeWin();
	});
	
})
</script>
</body>
</head>