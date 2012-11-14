<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<%@ include file="/WEB-INF/common/meta.jsp"%>
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css" />
</head>
<body>
<p class="fold-top-title">检测结果</p>
<table  class="grayhead-table grayborder table-width100" id="result_table">
	<tr class="fold-greybg">
		<td class="gray-bottom" width="20%">脚本名称</td>
		<td class="gray-bottom" width="5%">：</td>
		<td class="gray-bottom" width="75%">
		<div style="width: 260px; text-overflow: ellipsis; overflow: hidden;">
			<nobr><font title="<s:property value="testResult.scriptName"/>"><s:property value="testResult.scriptName"/></font></nobr></div>
		</td>
	</tr>
	<tr class="fold-greybg">
		<td class="gray-bottom">是否执行</td>
		<td class="gray-bottom">：</td>
		<td class="gray-bottom">
			<div style="width: 100px; text-overflow: ellipsis; overflow: hidden;">
			<nobr>
			<s:if test="testResult.flag == 'true'">
				<span class="ico ico-checkmark" style="cursor:none;"></span>
			</s:if>
			<s:else>
				<span class="ico ico-delete2" style="cursor:none;"></span>
			</s:else>
			</nobr></div>
		</td>
	</tr>
	<tr class="fold-greybg">
		<td class="gray-bottom">执行结果</td>
		<td class="gray-bottom">：</td>
		<td class="gray-bottom">
			<div style="width: 260px; text-overflow: ellipsis; overflow: hidden;">
			<nobr><font title="<s:property value="testResult.exeResult"/>"><s:property value="testResult.exeResult"/></font></nobr></div>
		</td>
	</tr>
	<tr class="fold-greybg">
		<td class="gray-bottom">返回值</td>
		<td class="gray-bottom">：</td>
		<td class="gray-bottom">
			<div style="width: 260px; text-overflow: ellipsis; overflow: hidden;">
			<nobr><font title="<s:property value="testResult.returnValue"/>"><s:property value="testResult.returnValue"/></font></nobr></div>
		</td>
	</tr>
</table>
<div class="margin3"><span class="win-button" id="ok"><span class="win-button-border"><a>关闭</a></span></span></div>
</body>
<script>
$(function() {
	$("#ok").click(function(){
		panelClose();
	});
	function panelClose() {
		panel.close("close");
		panel = null;
	}
});
</script>
</html>