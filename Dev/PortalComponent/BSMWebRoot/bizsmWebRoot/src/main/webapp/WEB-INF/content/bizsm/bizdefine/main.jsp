<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@taglib prefix="decorator"
 uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@taglib prefix="page" uri="http://www.opensymphony.com/sitemesh/page"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!--
	author:qiaozheng
	description:业务服务定义首页
	uri:{domainContextPath}/bizsm/bizservice/ui/bizdefine-main
 -->
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>服务定义首页</title>
<link rel="Shortcut icon" type="image/x-icon" href="${ctx}/imac.ico">
<link rel="icon" href="${ctx}/imac.ico" type="image/x-icon" />

<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/portal.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/portal02.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />

<link href="${ctx}/css/jquery-ui/jquery.ui.toolbar.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/jquery-ui/jquery.ui.toolmenu.css" rel="stylesheet" type="text/css" />

<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css" />


<style type="text/css" media="screen">
	html, body	{ height:100%; }
	body { margin:0; padding:0; overflow:auto; text-align:center;
		   background-color: #ffffff; }
	#flashContent { display:none; }
</style>

<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js"></script>

<script src="${ctx}/js/component/cfncc.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/js/component/popwin.js"></script>
<script type="text/javascript" src="${ctx}/js/bizservice/common.js"></script>

<script language="javascript">
	function f_hideLeftFrame(){
	  document.all.frameMain.cols = "8,*";
	  document.all.frameMain.frameBorder = 0 ;
	  //imgHideToc.style.display="none";
	  //imgDispToc.style.display="block";
	  //top.rightFrame.f_rePaintPBoxPositon();
	}
	function f_showLeftFrame(){
	  document.all.frameMain.cols = "238,*";
	  document.all.frameMain.frameBorder = 1;
	  //imgDispToc.style.display="none";
	  //imgHideToc.style.display="block";
	}
	function f_loadBizLeftFrame(){
		$('frame[name="leftFrame"]').attr("src", "${ctx}/bizsm/bizservice/ui/bizservice-list");
	}
</script>
</head>
	<frameset name="frameMain" frameborder="NO" scrolling="NO" border="0" framespacing="0" cols="238,*" rows="*" MARGINWIDTH="0" MARGINHEIGHT="0" LEFTMARGIN="0" TOPMARGIN="0">
	  <frame  name="leftFrame" scrolling="NO" noresize style="height:100%;background-image:none;background-color:transparent;" src="/netfocus/test.html"/>
	  <frame  name="rightFrame" scrolling="NO" noresize style="height:100%;background-image:none;background-color:transparent;" src="${ctx}/bizsm/bizservice/ui/bizdefine-top" onload="javascript:f_loadBizLeftFrame();"/>
	</frameset>
</html>