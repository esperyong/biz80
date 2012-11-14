<!-- WEB-INF\content\location\view\relation-map.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<%@ include file="/WEB-INF/common/meta.jsp" %>

<s:if test="location.focusMapId!=null">
	<iframe id="netFocus" src="/netfocus/modules/flash/node_doubleclick_openmap.jsp?mapId=${location.focusMapId}"
		scrolling="no" frameborder="0" marginheight="0" marginwidth="0" width="100%" height="100%" allowtransparency="true" style="position:absolute;left:0px;background-color:transparent;"></iframe>
</div>
</s:if>
<s:else>
没有关联拓扑图
</s:else>