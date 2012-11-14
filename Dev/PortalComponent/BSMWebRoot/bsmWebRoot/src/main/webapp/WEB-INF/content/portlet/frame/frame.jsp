<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/WEB-INF/common/userinfo.jsp" %>
<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js" ></script>
<script type="text/javascript" src="${ctx}/js/component/cfncc.js" ></script>
<script type="text/javascript" src="${ctx}/js/component/panel/panel.js"></script>
<script type="text/javascript" src="${ctx}/js/component/gridPanel/grid.js"></script>
<script type="text/javascript" src="${ctx}/js/component/gridPanel/indexgrid.js"></script>
</head>
<body>
<div  id="frame" >
<s:iterator id="url" value="urls" status="st">
	<div style="width:48%"  id="url_<s:property value="#st.index"/>" class="margin8 left">
	<iframe name="url_iframe_<s:property value="#st.index"/>" src="${url}<%=userId%>" id="url_iframe_<s:property value="#st.index"/>"  frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="280px" scrolling="no"></iframe>
	</div>
</s:iterator>
</div>
</body>
</html>