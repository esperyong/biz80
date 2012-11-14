<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!-- 
	author:qiaozheng
	description:业务服务管理首页
	uri:{domainContextPath}/bizsm/bizservice/ui/bizmanagement-main
 -->
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>业务服务管理首页</title>
<link rel="Shortcut icon" type="image/x-icon" href="${ctx}/bizserviceico.ico">
<link rel="icon" href="${ctx}/bizserviceico.ico" type="image/x-icon" />
</head>
<frameset rows="596,*" cols="*" frameborder="NO" border="0" framespacing="0">
	<frameset rows="*" cols="31,*" frameborder="NO" border="0" framespacing="0">
	  <frame  name="leftFrame" scrolling="NO" noresize src="${ctx}/bizsm/bizservice/ui/bizmanagement-navigate"/>
	  <frame  name="rightFrame" scrolling="NO" noresize src=""/>
	</frameset>
	<frame src="${ctx}/bizsm/bizservice/ui/bizservice-status-bar" name="bottomFrame" scrolling="NO" noresize >
</frameset>

<noframes>
  <body topmargin="120">
  </body>
</noframes>
</html>
