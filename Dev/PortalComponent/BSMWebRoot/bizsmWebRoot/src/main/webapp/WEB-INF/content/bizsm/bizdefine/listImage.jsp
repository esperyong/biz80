<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<!-- 
 author:liuyong
 description:image列表
 uri:{domainContextPath}/imagefolder/{folderId}/image/
 -->
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>image列表</title>
</head>
<body>
 <h2>folder <s:property value="model.folderId"/>'s images</h2>
 <ul>  
 	<li class="folder"><s:property value="model.folderId"/></li>
	<s:iterator value="model.images" status="status">
				<li class="image">
					<a href="${ctx}<s:property value="uri"/>" uri="<s:property value="uri"/>" <s:iterator value="imageMeta"><s:property value="key"/>="<s:property value="value"/>" </s:iterator>>
						<s:property value="name"/>
					</a>
				</li>
	</s:iterator>
 </ul>
</body>
</html>
