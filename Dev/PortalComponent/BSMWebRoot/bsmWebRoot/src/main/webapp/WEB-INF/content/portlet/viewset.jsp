<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/WEB-INF/common/meta.jsp"%>
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/validationEngine.jquery.css"
	type="text/css" media="screen" title="no title" charset="utf-8" />
<link href="${ctx}/css/jquery-ui/jquery.ui.treeview.css"
	rel="stylesheet" type="text/css"></link>
<title>资源设置</title>
<script type="text/javascript">
	var path = "${ctx}";
</script>
<script src="${ctxJs}/jquery-1.4.2.min.js"></script>
<script src="${ctxJs}/jquery.blockUI.js"></script>
<script src="${ctx}/js/component/cfncc.js"></script>
<script src="${ctx}/js/component/treeView/tree.js"></script>
<script src="${ctx}/js/component/menu/menu.js"></script>
<script src="${ctx}/js/component/accordionPanel/accordionPanel.js"></script>
<script src="${ctx}/js/component/accordionPanel/accordionAddSubPanel.js"></script>
<script src="${ctx}/js/component/panel/panel.js"></script>
<script src="${ctx}/js/component/toast/Toast.js"></script>
<script src="${ctx}/js/component/slider/slider.js"></script>
<script src="${ctxJs}/jquery.validationEngine.js"></script>
<script src="${ctxJs}/jquery.validationEngine-cn.js"></script>
<script src="${ctxJs}/profile/comm.js"></script>
<script src="${ctxJs}/component/comm/winopen.js"></script>
<script src="${ctx}/js/component/popwindow/popwin.js"></script>
<style type="text/css">
.focus {
	border: 1px solid #f00;
	background: #fcc;
}

#metricSetting table td {
	vertical-align: middle;
	text-align: center;
}

#metricSetting table th {
	vertical-align: middle;
	text-align: center;
}
</style>
<script type="text/javascript">
	$(document).ready(function() {
		$("#confirm_button").click(function() {
			submitForm();
		});
		initRadio("resource_type", "${resource_type}");
		initRadio("view_type", "${view_type}");
		var userid = "${userid}";
	});
	//初始化单选按钮
	function initRadio(name, value) {
		var radios = $("input[name='" + name + "']");
		for ( var i = 0; i < radios.length; i++) //循环
		{
			if (radios[i].value == value) //比较值
			{
				radios[i].checked = true; //修改选中状态
				break; //停止循环
			}
		}
	}
	//提交表单数据
	function submitForm() {
		var ajaxParam = $("#form").serialize();
		var parentWin = window.dialogArguments;
		$.ajax({
			type : "POST",
			dataType : 'json',
			url : "${ctx}/portlet/resources!saveViewSet.action",
			data : ajaxParam,
			success : function(data, textStatus) {
				try {
					parentWin.rewrite(data);
				} catch (e) {
				}
				window.close();
			},
			fail : function(data, textStatus) {
				alert('fail');
			}
		});
	}
</script>
</head>
<body>
	<s:form id="form" method="POST">
		<input type="hidden" name="userid" id="userid" value="${userid}" />
		<page:applyDecorator name="popwindow" title="资源设置">
			<page:param name="width">250px;</page:param>
			<page:param name="topBtn_index_1">1</page:param>
			<page:param name="topBtn_id_1">win-close</page:param>
			<page:param name="topBtn_css_1">win-ico win-close</page:param>
			<page:param name="topBtn_title_1">关闭</page:param>

			<page:param name="bottomBtn_index_1">1</page:param>
			<page:param name="bottomBtn_id_1">confirm_button</page:param>
			<page:param name="bottomBtn_text_1">确定</page:param>

			<page:param name="bottomBtn_index_2">2</page:param>
			<page:param name="bottomBtn_id_2">cancel_button</page:param>
			<page:param name="bottomBtn_text_2">取消</page:param>

			<page:param name="content">
				<div>
					<br> &nbsp;&nbsp;<span class="textalign bold">资源范围:</span><br>
					&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="resource_type"
						id="Resource_radio" value="Resource" />全部<br>
					&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="resource_type"
						id="Resource_radio" value="host" />主机<br>
					&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="resource_type"
						id="Resource_radio" value="networkdevice" />网络设备<br>
					&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="resource_type"
						id="Resource_radio" value="storage" />存储设备<br>
					&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="resource_type"
						id="Resource_radio" value="application" />应用<br>
					&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="resource_type"
						id="Resource_radio" value="other" />其它<br>
					<br> &nbsp;&nbsp;<span class="textalign bold">状态展现:</span><br>
					&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="view_type"
						id="view_radio" value="metricstate" />按可用性和性能状态展现<br>
					&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="view_type"
						id="view_radio" value="changestate" />按配置变更状态展现 <br>
				</div>
			</page:param>
		</page:applyDecorator>
	</s:form>
</body>
</html>