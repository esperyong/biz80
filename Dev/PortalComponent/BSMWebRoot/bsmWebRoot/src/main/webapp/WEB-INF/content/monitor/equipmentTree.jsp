<!-- 设备树 equipmentTree.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<s:property value="treeStr" escape="false" />
<script type="text/javascript">
Monitor.Resource.left.equipment.pointId = '<s:property value="pointId"/>';
Monitor.Resource.left.equipment.pointLevel = '<s:property value="pointLevel"/>';
Monitor.Resource.left.equipment.monitor = '<s:property value="monitor"/>';
Monitor.Resource.left.equipment.whichTree = '<s:property value="whichTree"/>';
Monitor.Resource.left.equipment.whichGrid = '<s:property value="whichGrid"/>';
Monitor.Resource.left.equipment.currentTree = '<s:property value="currentTree"/>';
Monitor.Resource.left.equipment.currentResourceTree = '<s:property value="currentResourceTree"/>';
</script>
