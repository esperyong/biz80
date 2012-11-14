<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<%@ page import="com.mocha.bsm.detail.util.Constants"%>
<html>
<head>
<%@ include file="/WEB-INF/common/meta.jsp"%>
<title><s:text name="detail.page.wintitle" /></title>
<link rel="stylesheet" type="text/css" href="${ctxCss}/master.css" />
<link rel="stylesheet" type="text/css" href="${ctxCss}/public.css" />
<link rel="stylesheet" type="text/css" href="${ctxCss}/UIComponent.css" />
<script type="text/javascript" src="${ctxJs}/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="${ctxJs}/component/cfncc.js"></script>
<script type="text/javascript" src="${ctxJs}/jquery.blockUI.js"></script>
<script type="text/javascript" src="${ctxJs}/component/popwindow/popwin.js"></script>
</head>

<body>
  <script type="text/javascript">
	  if(window.$ && $.unblockUI){
	    $.unblockUI();
	  }
    function closeWin(){
      try{
        window.close();
        top.window.close();
      }catch(e){}
    }
    var result = "<%=request.getParameter("result")%>";
    if(result == "<%=Constants.ACTION_RESULT_NONEXIST%>"){
      var _information = new information({text:"<s:text name="detail.msg.resnonexist" />", confirm_listener:closeWin, close_listener:closeWin});
      _information.show();
    }else if(result == "<%=Constants.ACTION_RESULT_NONMONITOR%>"){
      var _information = new information({text:"<s:text name="detail.msg.resnonmonitor" />", confirm_listener:closeWin, close_listener:closeWin});
      _information.show();
    }else if(result == "<%=Constants.ACTION_RESULT_NONPERMISSION%>"){
      var _information = new information({text:"<s:text name="detail.msg.nonpermission" />", confirm_listener:closeWin, close_listener:closeWin});
      _information.show();
    }
    // 刷新父页面
    if(opener && opener.Monitor && opener.Monitor.refresh){
      opener.Monitor.refresh();
    }
  </script>
</body>
</html>
