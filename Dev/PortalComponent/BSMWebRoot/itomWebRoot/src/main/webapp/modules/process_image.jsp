<%--
	modules/_process_image.jsp
	author: wangtao@mochasoft.com.cn
	Description: 服务水平管理 - 流程图
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" errorPage="/modules/common/error.jsp"%>
<jsp:directive.page import="com.mocha.dev.ReqRes"/>
<jsp:directive.page import="com.mocha.bsm.itom.mgr.XmlCommunication"/>
<%@ include file="/modules/common/security.jsp"%>
<%@ taglib uri="/mochatag" prefix="mt"%>
<%
   ReqRes rr = new ReqRes(request, response);
   rr.encoding("UTF-8").nocache().security();
   String workformId = request.getParameter("workformId");
   String userId = request.getParameter("userId");
   String itomDomainId = request.getParameter("itomDomainId");


   String remark = XmlCommunication.getInstance().query_process_remark(workformId, userId, itomDomainId);
   remark = remark.replaceAll("\n","<br/>").replaceAll(" ","&nbsp;").replaceAll("\r\n","<br/>");
%>
<html>
<head>
<title>流程图</title>
<link href="<%=cssRootPath %>/liye.css" rel="stylesheet" type="text/css">
<link href="<%=cssRootPath %>/liye1.css" rel="stylesheet" type="text/css">
<link href="<%=cssRootPath %>/css.css" rel="stylesheet" type="text/css">
</head>
<body>
<center>
<mt:tableHead title='<%=i18n.key("流程图") %>' width="880" alt='<%=i18n.key("close") %>' imgurl="<%=imgRootPath%>"/>
<table width="852" border="0" cellspacing="0" cellpadding="0">
<tr>
<td align="center" class="full-gray">
 <table width="100%" cellspacing="0" cellpadding="0">
       <tr>
         <td width="29%" height="23" bgcolor="#EAEEF1" class="title-detail-blue" style="padding-left:12px">
         <div align="left"><span class="title-detail-blue">备注</span>&nbsp;</div>
         </td>
       </tr>
       <tr>
         <td height="150">
         <table width="100%" border="0" cellspacing="0" cellpadding="0">
     		<tr>
      			<td style="padding-left:12px">
                <div><%if(remark != null && !"-".equals(remark)){out.print(remark); }%></div>
       		</td>
      		</tr>
 		 </table>
         <table width="100%"  border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td height="6">&nbsp;</td>
            </tr>
         </table>
        </td>
       </tr>
 </table>
</td>
</tr>
</table>
<table width="100%"  border="0" cellspacing="0" cellpadding="0">
             <tr>
               <td height="6">&nbsp;</td>
             </tr>
</table>
<table width="852" border="0" cellspacing="0" cellpadding="0">
<tr>
<td align="center" class="full-gray">
 <table width="100%" cellspacing="0" cellpadding="0">
       <tr>
         <td width="29%" height="23" bgcolor="#EAEEF1" class="title-detail-blue" style="padding-left:12px">
         <div align="left"><span class="title-detail-blue">流程图</span>&nbsp;</div>
         </td>
       </tr>
       <tr>
         <td height="23" align="center">
         <table width="100%"  border="0" cellspacing="0" cellpadding="0">
             <tr>
               <td height="6">&nbsp;</td>
             </tr>
         </table>
         <table width="100%" border="0" cellspacing="0" cellpadding="0">
     		<tr>
      			<td align="center">
                <div style="width:850px;OVERFLOW-X:auto;">
	   				<image src="_image.jsp?workformId=<%=workformId%>&userId=<%=userId%>&userDomainId=<%=itomDomainId %>">
				</div>
       		</td>
      		</tr>
 		 </table>
         <table width="100%"  border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td height="6">&nbsp;</td>
            </tr>
         </table>
        </td>
       </tr>
 </table>
</td>
</tr>
</table>

<mt:tableFoot width="880" imgurl="<%=imgRootPath%>"/>
</center>
</body>
</html>