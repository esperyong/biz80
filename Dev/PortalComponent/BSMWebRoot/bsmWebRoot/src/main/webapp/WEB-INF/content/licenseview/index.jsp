<!-- WEB-INF\content\scriptmonitor\licenseview\index.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<html>
<head>
<base target="_self">
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>软件许可</title>
<link href="${ctxCss}/master.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/UIComponent.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/public.css" rel="stylesheet" type="text/css">
<script src="${ctxJs}/jquery-1.4.2.min.js" type="text/javascript"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#closeId,#closeBt").click(function (){
			window.close();
		});
	});
</script>
</head>
<body>
	<page:applyDecorator name="popwindow"  title="软件许可">
			<page:param name="width">600px</page:param>
			<page:param name="height">550px</page:param>
			
			<page:param name="topBtn_index_1">1</page:param>
			<page:param name="topBtn_id_1">closeId</page:param>
			<page:param name="topBtn_css_1">win-ico win-close</page:param>
			
			<page:param name="bottomBtn_index_1">1</page:param>
			<page:param name="bottomBtn_id_1">closeBt</page:param>
			<page:param name="bottomBtn_text_1">关闭</page:param>
				
			<page:param name="content">
				<div style="height:520px;text-align:center;margin-left:10px;margin-right:10px;margin-top:20px;background-color:#F9F9F9;">
					<div  style="width:550px;text-align:left;padding-left:10px;padding-top:10px;">
						<span style="padding-right:50px;">产品信息</span><span>：</span><span>${version}</span>
					</div>
					<div style="width:550px;text-align:left;margin-top:10px;margin-bottom:10px;padding-left:10px;">
						<span style="padding-right:25px;">有效模块信息</span><span>：</span>
					</div>	
					<div style="width:560px;text-align:left;margin-bottom:10px;">
						<table class="black-grid-greyborder">
							 <tr>
							 	<th align="center" style="width:150px;">模块编号</th>
							   	<th align="center" style="width:250px;">描述</th>
							   	<th align="center" style="width:80px;">数量</th>
							   	<th align="center" style="width:80px;">剩余数量</th>
							 </tr>
							 <s:iterator value="voList">
								 <tr>
								 	<td>${moduleNumber}</td>
								 	<td><div style="width:250px;word-break:normal;">${desc}</div></td>
								 	<s:if test="showCount">
									 	<td rowspan="${rowSpan}" class="aligncenter">${count}</td>
									 	<td rowspan="${rowSpan}" class="aligncenter">${leftCount}</td>
								 	</s:if>
								 </tr>
							 </s:iterator>
						</table>
					</div>
				</div>
			</page:param>
	</page:applyDecorator>
</body>	
</html>