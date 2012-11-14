<!-- WEB-INF\content\location\relation\reload.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript">

<s:if test="#request.uploadFlag == 'success'">
//alert("文件上传成功");
</s:if>
<s:if test="#request.uploadFlag == 'fileIsNull'">
parent.showMess("请选择上传文件");
</s:if>
<s:if test="#request.uploadFlag == 'noFiatFileType'">
parent.showMess("请选择正确的文件类型，支持的文件类型为${request.fiatType}");
</s:if>
<s:if test="#request.uploadFlag == 'overrunFileSize'">
alert('${FileSize}');
parent.showMess("上传文件大小不能超过" + ('${FileSize}'/(1024*1024)) + "M");
</s:if>

	parent.reloadContent();
</script>
</head>
</html>