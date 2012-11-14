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
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title>业务服务管理首页</title>

<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js"></script>

<script src="${ctx}/js/component/cfncc.js" type="text/javascript"></script>
<script src="${ctx}/js/component/popwin.js" type="text/javascript"></script>

<script type="text/javascript" src="${ctx}/js/bizservice/common.js"></script>
<script language="javascript">
	function f_loadLeftPage(){
		$('frame[name="leftFrame"]').attr("src", "${ctx}/bizsm/bizservice/ui/bizmanagement-navigate");
	}
</script>
</head>
<frameset style="background-image:url('${ctx}/images/all-bg.jpg')" rows="*,25" cols="*" frameborder="NO" scrolling="NO" border="0" framespacing="0">
	<frameset style="background-image:url('${ctx}/images/all-bg.jpg')" rows="*" cols="31,*" frameborder="NO" border="0" framespacing="0">
	  <frame  name="leftFrame" scrolling="NO" noresize style="height:100%;background-image:none;background-color:transparent;" allowtransparency="true" src="/netfocus/test.html"/>
	  <frame  name="rightFrame" scrolling="NO" noresize style="height:100%;width:100%;background-image:none;background-color:transparent;" allowtransparency="true" src="/netfocus/test.html"/>
	</frameset>
	<frame style="background-image:none;background-color:transparent;" onload="javascript:f_loadLeftPage();" allowtransparency="true" src="${ctx}/bizsm/bizservice/ui/bizservice-status-bar" name="bottomFrame" scrolling="NO" noresize >
</frameset>

</html>
