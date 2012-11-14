<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="/WEB-INF/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/WEB-INF/common/meta.jsp"%>
<%@ page import="com.opensymphony.xwork2.util.*"%>

<title>查看留言</title>
<link rel="stylesheet" href="${ctx}/css/validationEngine.jquery.css"
	type="text/css" media="screen" title="no title" charset="utf-8" />
<link rel="stylesheet" href="${ctx}/css/public.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/common.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/master.css" type="text/css" />
<script src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script src="${ctx}/js/jquery.layout-1.2.0.js"></script>
<script src="${ctx}/js/jquery.validationEngine-cn.js"
	type="text/javascript"></script>
</head>
<page:applyDecorator name="popwindow" title="查看留言">
	<page:param name="width">350px;</page:param>
	<page:param name="topBtn_index_1">1</page:param>
	<page:param name="topBtn_id_1">closeId</page:param>
	<page:param name="topBtn_css_1">win-ico win-close</page:param>
	<page:param name="content">
		<ul class="fieldlist-n">
			<li>
				<span class="field">创建时间：</span><s:property value='createTime'/>
			</li>
			<li>
				<span class="field">到期时间：</span><s:property value='endData'/>
			</li>
			<li>
				<span class="field">留言人：</span><s:property value='user'/>
			</li>
			<li>
				<span class="field">主题：</span><s:property value='topic'/>
			</li>
			<li>
				<span class="field">留言内容：</span><s:property value='content'/>
			</li>
		</ul>
	</page:param>
</page:applyDecorator>
<script type="text/javascript">
$("#closeId").click(function (){
	window.close();
})
</script>