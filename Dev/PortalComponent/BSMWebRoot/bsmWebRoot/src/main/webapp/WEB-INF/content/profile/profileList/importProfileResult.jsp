<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<div class="margin8">
<table class="gray-table table-width100 table-grayborder">
	<tr>
		<th width="30%"><span>预计导入策略</span></th>
		<th width="5%"><span>：</span></th>
		<th width="15%"><span>${totalNum.total}</span></th>
		<th width="30%">&nbsp;</th>
		<th width="5%">&nbsp;</th>
		<th width="15%">&nbsp;</th>
	</tr>
	<tr>
		<td><span>导入成功</span></td>
		<td>：</td>
		<td>${totalNum.success}</td>
		<td><span>其中名称重复</span></td>
		<td>：</td>
		<td>${totalNum.repeatName}</td>
	</tr>
	<tr>
		<td><span>导入失败</span></td>
		<td>：</td>
		<td><span style="color: red;">${totalNum.failure}</span></td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
</table>
</div>
</body>
</html>