<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<link rel="stylesheet" href="${ctx}/css/validationEngine.jquery.css" 
	type="text/css" media="screen" title="no title" charset="utf-8" />
<link rel="stylesheet" href="${ctx}/css/common.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/UIComponent.css" type="text/css" /> 
<link rel="stylesheet" href="${ctx}/css/public.css" type="text/css" ></link>
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<%@ page import="com.opensymphony.xwork2.util.*"%>
<title>提示</title>

<script type="text/javascript"
	src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="${ctx}/js/component/cfncc.js"></script>
<script type="text/javascript" src="${ctx}/js/component/popwindow/popwin.js" ></script>
</head>
<body>
</body>
<script type="text/javascript">
	$(document).ready(function() {
			//alert(window.opener.window.parentVairous);
			var _confirm = new confirm_box({text:"是否确认执行此操作？"});
				 _confirm.setContentText("是否确认执行此操作？");
				 _confirm.offset({top:0,left:0});
				 _confirm.setConfirm_listener(function(){
					//window.dialogArguments.delRoomExcuse('<s:property value="roomId"/>');
					window.opener.delRoomExcuse('<s:property value="roomId"/>');
					_confirm.hide();
					window.close();
				 });
				_confirm.setCancle_listener(function(){
					window.close();
				});
				_confirm.show();	
	});
</script>
</html>