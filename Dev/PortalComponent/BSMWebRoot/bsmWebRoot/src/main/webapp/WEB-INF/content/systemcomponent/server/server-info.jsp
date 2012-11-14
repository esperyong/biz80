<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html>
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>Agent</title>
<link href="${ctx}/css/portal.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
var serverId = '${serverId}';
//alert('${healthStatus}');
var tp = new TabPanel( {
	id:"infoTab",
    listeners:{
	    change:function(tab) {
			var url = "/pureportal/systemcomponent/server-update.action?serverId=" + serverId;
			if (tab.id == "setup") {
				url = "/pureportal/systemcomponent/server-setup.action?serverId=" + serverId;
			} else if (tab.id == "version") {
				url = "/pureportal/systemcomponent/server-version.action?serverId=" + serverId;
			}
	     	tp.loadContent(1, {url:url});
	    }
	}
} )
</script>
</head>
<body>

<page:applyDecorator name="tabPanel">
	<page:param name="id">infoTab</page:param>
	<page:param name="width">99%</page:param>
	<page:param name="tabBarWidth">400</page:param>
	<page:param name="cls">tab-grounp</page:param>
	<page:param name="current">1</page:param>
	<s:if test="healthStatus!='gray'">
	<page:param name="tabHander">[{text:"常规信息",id:"update"},{text:"设置",id:"setup"}]</page:param>
	</s:if>
	<s:else>
	<page:param name="tabHander">[{text:"常规信息",id:"update"}]</page:param>
	</s:else>
	<page:param name="content">
		<s:action name="server-update" namespace="/systemcomponent" executeResult="true" ignoreContextParams="false" flush="false">
		</s:action>
	</page:param>
</page:applyDecorator>

</body>
</html>