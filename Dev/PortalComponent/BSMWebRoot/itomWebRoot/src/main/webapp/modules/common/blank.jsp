<!-- modules/common/blank.jsp -->
<%--
	author: wangtao@mochasoft.com.cn
	Description: 服务水平管理 - 无数据显示
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<jsp:directive.page import="com.mocha.dev.ReqRes"/>
<%@ include file="/modules/common/security.jsp"%>

<%
	request.getSession().removeAttribute("currentTime");
	request.getSession().removeAttribute("total");

   ReqRes rr = new ReqRes(request, response);
   rr.encoding("UTF-8").nocache().security();
%>
<html>
  <head>
    <title></title>
  </head>
  <link href="<%=cssRootPath %>/liye.css" rel="stylesheet" type="text/css">
  <link href="<%=cssRootPath %>/liye1.css" rel="stylesheet" type="text/css">
  <body>
  <br><br><br><br>
   <table width="100%" align="center">
   	<tr>
   	 <td valign="middle" class="lanzi_x" align="center" style="padding-top: 5px;">
   	 	<IMG src="<%=imgRootPath%>/ico-infor.jpg"><br>
		<%=i18n.key("nodata") %>
		<br><br><br><br><br><br><br>
   	 </td>
   	</tr>
   </table>
  </body>
</html>