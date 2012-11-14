<%@ page language="java" contentType="text/html;charset=UTF-8" isErrorPage="true" %>
<%@ include file="/modules/common/security.jsp"%>

<html>
<head>
<title><%=i18n.key("error.title") %></title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>

<body>
<table width="600" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td colspan="2">&nbsp;</td>
  </tr>
  <tr >
    <td width="217" height="37" align="right"><strong>
      <input id="b1" name="Button" type="button" value='<%=i18n.key("error.back") %>'  onClick="history.back();"
		  style=" background-color:#FFCC33; font-size:12; padding-top:3 ">
    <img src="<%=request.getContextPath()%>/modules/errorpage/210.jpg" width="48" height="52" align="middle"></strong></td>
    <td width="383"><strong><%=i18n.key("error.program") %>

    </strong></td>
  </tr>
  <tr>
    <td colspan="2" align="center"><hr size="1" noshade></td>
  </tr>
  <tr>
    <td colspan="2">
    <strong><%=i18n.key("error.messages") %></strong>
<%
    String mess=exception.getMessage();
    if(mess==null) mess=i18n.key("error.unknow");
    out.print(mess);
%>
	</td>
  </tr>

  <%
    if(true){ // isDebug
%>
  <tr>
    <td colspan="2" align="center"><table width="93%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td><input id="b1" name="Button" type="button" value='<%=i18n.key("error.messages") %>'  onClick="showStack();"
		  style=" background-color:#FFCC33; font-size:12; padding-top:3 ">
		  <!--input id="b1" name="Button" type="button" value="打开tomcat工作文件夹"  onClick="showWorkDir();"
		  style=" background-color:#FFCC33; font-size:12; padding-top:3 "--></td>
        </tr>
      </table>
        <div id="stack" style="height:1; overflow:hidden">
          <table width="93%" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
              <td><br><strong><%=i18n.key("error.stack.messages") %></strong></td>
            </tr>
            <tr>
              <td><font color="#99CC99">
                <%
	java.io.CharArrayWriter cw = new java.io.CharArrayWriter();
	java.io.PrintWriter pw = new java.io.PrintWriter(cw,true); exception.printStackTrace(pw);
	out.println(cw.toString());
%>
              </font></td>
            </tr>
            <tr>
              <td>&nbsp;</td>
            </tr>
          </table>
      </div></td>
  </tr>
  <%
    }
%>
</table>
<script language="javascript">
function showStack(){
	b1.disabled=true;
	stack.style.height="500";
	stack.style.display="";
}
function showWorkDir(){

}
</script>
</body>
</html>
