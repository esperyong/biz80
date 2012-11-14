<!-- 应用树applicationTree.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<s:property value="treeStr" escape="false" />
<script type="text/javascript">
Monitor.Resource.left.application.pointId = '<s:property value="pointId"/>';
Monitor.Resource.left.application.pointLevel = '<s:property value="pointLevel"/>';
Monitor.Resource.left.application.monitor = '<s:property value="monitor"/>';
Monitor.Resource.left.application.whichTree = '<s:property value="whichTree"/>';
Monitor.Resource.left.application.whichGrid = '<s:property value="whichGrid"/>';
Monitor.Resource.left.application.currentTree = '<s:property value="currentTree"/>';
Monitor.Resource.left.application.currentResourceTree = '<s:property value="currentResourceTree"/>';
</script>

