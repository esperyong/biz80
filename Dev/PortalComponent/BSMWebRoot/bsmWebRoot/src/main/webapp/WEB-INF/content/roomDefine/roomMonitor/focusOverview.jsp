<!-- 机房-机房监控-告警管理alarmOverview.jsp -->
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>告警管理</title>
<link rel="stylesheet" href="${ctx}/css/public.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/portal02.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/common.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/UIComponent.css" type="text/css" /> 
<script type="text/javascript" src="${ctx}/js/component/cfncc.js"></script>
<script type="text/javascript" src="${ctx}/js/component/panel/panel.js"></script>
<script type="text/javascript" src="${ctx}/js/component/gridPanel/grid.js"></script>
<script type="text/javascript" src="${ctx}/js/component/gridPanel/indexgrid.js"></script>
<script type="text/javascript" src="${ctx}/js/component/toast/Toast.js"></script>
<script type="text/javascript" src="${ctx}/js/component/menu/menu.js"></script>
<script type="text/javascript" src="${ctx}/js/component/gridPanel/page.js"></script>
<script language="javascript" type="text/javascript" src="${ctx}/js/component/date/WdatePicker.js"></script>
</head>
<div id="focusList">
		<ul>
			<s:iterator value="focusMap" id="map">
				<input type="button" id="<s:property value="#map.key"/>" value="<s:property value="#map.value"/>" onclick="focusOverviewFun('<s:property value="#map.key" />');" style="cursor:pointer"></input>
			</s:iterator>
		</ul>	
	</div>
<iframe id="focusFrame" name="focusFrame" src="" scrolling="no"
					frameborder="0" marginheight="0" marginwidth="0" width="100%" height="91%" allowtransparency="true" style="position:absolute;top:55px;left:0px;background-color:transparent"></iframe>
	<input type="hidden" id="focusId" name="focusId" value="ud"/>
	

<script type="text/javascript">
/**
 * 网络拓扑
 */
function focusOverviewFun(focusId) {
	$("#focusFrame").attr("src","/netfocus/modules/flash/node_doubleclick_openmap.jsp?mapId="+focusId);
}

focusOverviewFun("<s:property value='defaultFocusId'/>");


</script>