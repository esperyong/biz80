<%@ page language="java" contentType="text/html;charset=UTF-8" errorPage="/modules/common/error.jsp"%>
<jsp:directive.page import="com.mocha.bsm.itom.util.EnDecode"/>
<%@ include file="/modules/common/security.jsp"%>
<%	request.setCharacterEncoding("UTF-8");
    String promptType = request.getParameter("promptType");//提示窗口类别;
    String prompt = request.getParameter("prompt");//提示窗口信息名称。
    String promptCoding = request.getParameter("promptCoding");//提示编码信息
    String scriptCmd = request.getParameter("scriptCmd");//javascript命令行(注:在命令行前加window.dialogArguments);
    if (null != scriptCmd && !"".equals(scriptCmd)) {
    	//scriptCmd = "" + scriptCmd;
    }

    //提示窗口信息值。
    String promptValue = "";
    if (null != promptCoding && !"".equals(promptCoding) && !"null".equals(promptCoding) && !"undefined".equals(promptCoding)) {
    	promptValue = EnDecode.stringDecode(promptCoding);
    } else {
    	promptValue = i18n.key(prompt);
    }
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><%=i18n.key("TISHI_KEY")%></title>
<link href="<%=cssRootPath %>/common.css" rel="stylesheet" type="text/css">
</head>
<body>
<%if("shortAlert".equalsIgnoreCase(promptType)){%>
<table width="247" height="135"  border="1" cellpadding="0" cellspacing="0" bgcolor="#F6F7FC">
	<tr>
		<td height="133" align="center">
		<table width="90%"  border="0" cellspacing="0" cellpadding="0">
	      <tr align="left">
	        <td width="33%"><img src="<%=imgRootPath%>/prompt.gif" width="32" height="32"></td>
	        <td width="67%" height="60"><%=promptValue%></td>
	      </tr>
	    </table>
	    <table width="90%" border="0" cellspacing="0" cellpadding="0">
	    	<tr>
	    		<td align="center" style="cursor:hand;" onclick='<%=scriptCmd%>;window.close();'>
			    <table width="0%" cellpadding="0" cellspacing="0">
		            <tr>
		              <td><img src="<%=imgRootPath%>/left.jpg" width="6" height="22"></td>
		              <td width="60" background="<%=imgRootPath%>/mid.jpg"><div align="center"><span class="zi"><%=i18n.key("CONFIRM") %></span></div></td>
		              <td><img src="<%=imgRootPath%>/right.jpg" width="6" height="22"></td>
		            </tr>
		        </table>
		        </td>
	    	</tr>
	    	</table>
	  </td>
	</tr>
</table>
<%}else if("longAlert".equalsIgnoreCase(promptType)){%>
<table width="419" height="135"  border="0" cellpadding="0" cellspacing="0" bgcolor="#F6F7FC">
	<tr>
		<td height="133" align="center">
			<table width="90%"  border="0" cellspacing="0" cellpadding="0">
				<tr align="left">
					<td width="60"><img src="<%=imgRootPath%>/prompt.gif" width="32" height="32"></td>
					<td width="320" height="60" style="word-break:break-all"><%=promptValue%></td>
				</tr>
			</table>
			<table width="90%"  border="0" cellspacing="0" cellpadding="0">
	    	<tr>
	    		<td align="center" style="cursor:hand;" onclick='<%=scriptCmd%>;window.close();'>
			    <table width="0%" cellpadding="0" cellspacing="0">
		            <tr>
		              <td><img src="<%=imgRootPath%>/left.jpg" width="6" height="22"></td>
		              <td width="60" background="<%=imgRootPath%>/mid.jpg"><div align="center"><span class="zi"><%=i18n.key("CONFIRM") %></span></div></td>
		              <td><img src="<%=imgRootPath%>/right.jpg" width="6" height="22"></td>
		            </tr>
		        </table>
		        </td>
	    	</tr>
	    	</table>
		</td>
	</tr>
</table>
<%}else if("yesOrNo".equalsIgnoreCase(promptType)){%>
<table width="419" height="135"  border="0" cellpadding="0" cellspacing="0" bgcolor="#F6F7FC">
	<tr>
		<td height="133" align="center">
			<table width="90%" border="0" cellspacing="0" cellpadding="0">
				<tr align="left">
					<td width="60"><img src="<%=imgRootPath%>/tishi.gif" width="39" height="40"></td>
					<td width="320" height="60" style="word-break:break-all"><%=promptValue%></td>
				</tr>
			</table>
			<table width="90%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td>&nbsp;</td>
					<td align="right" width="72" style="cursor:hand" onclick="<%=scriptCmd%>;return_value(true);window.close();">
						<table width="0%" cellpadding="0" cellspacing="0">
				            <tr>
				              <td><img src="<%=imgRootPath%>/left.jpg" width="6" height="22"></td>
				              <td width="60" background="<%=imgRootPath%>/mid.jpg"><div align="center"><span class="zi"><%=i18n.key("YES") %></span></div></td>
				              <td><img src="<%=imgRootPath%>/right.jpg" width="6" height="22"></td>
				            </tr>
			        	</table>
			        </td>
			        <td width="10">&nbsp;</td>
			        <td align="right" width="72" style="cursor:hand" onclick="return_value(false);window.close();return false;">
						<table width="0%" cellpadding="0" cellspacing="0">
				            <tr>
				              <td><img src="<%=imgRootPath%>/left.jpg" width="6" height="22"></td>
				              <td width="60" background="<%=imgRootPath%>/mid.jpg"><div align="center"><span class="zi"><%=i18n.key("NO") %></span></div></td>
				              <td><img src="<%=imgRootPath%>/right.jpg" width="6" height="22"></td>
				            </tr>
				        </table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<%}%>
</body>
</html>
<script>
function return_value(value){
	window.returnValue = value;
	//window.close();
}
</script>
