<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html>
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>登录</title>
<meta name="decorator" content="headfoot" /> 
</head>
<body>
<form action="${ctx}/myportal/__ac0x3login/__tpaction">

<input type="text" name="username" id="username"></input>
<input type="password" name="password" id="password"></input>
<input type="submit" />

</form>


</body>
</html>