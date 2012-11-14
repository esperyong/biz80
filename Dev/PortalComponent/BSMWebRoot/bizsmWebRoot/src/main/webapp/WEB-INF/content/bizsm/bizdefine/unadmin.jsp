<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@taglib prefix="decorator"
 uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@taglib prefix="page" uri="http://www.opensymphony.com/sitemesh/page"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!-- 
	author:qiaozheng
	description:无权限访问
	uri:{domainContextPath}/bizsm/bizservice/ui/bizservice-list
 -->
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>业务服务列表</title>

<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js"></script>

<script src="${ctx}/js/component/cfncc.js" type="text/javascript"></script>

<script language="javascript">
	var realWidth = 0, realHeight = 0;

	$(function(){
		realWidth = document.body.clientWidth;
		realHeight = document.body.clientHeight;

		//$('#nodata_div').css("width", realWidth);
		//$('#nodata_div').css("height", realHeight);
	});
		
</script>
</head>
<body>
		<div id="nodata_div" style="position:relative;top:250px;width:100%;height:100%;text-align:center;vertical-align:middle;">
			<img src="${ctx}/images/ico/nodata-ico.png" border="0">&nbsp;&nbsp;<span style="color:white;font-weight:900;">您没有权限定义业务服务</span>
		</div>
</body>
</html>