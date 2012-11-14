<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<style type="text/css">
  elli.{width:100%;overflow:hidden;white-space:nowrap;text-overflow:ellipsis;display:block;}
</style>
<div id="childDiv" class="rightcontent" style="height:474px;overflow:hidden;">
	<s:action name="childdetail!detailinfos" namespace="/detail" executeResult="true" flush="false">
	 <s:param name="parentInstanceId">${parentInstanceId}</s:param>
	 <s:param name="childResourceId">${childResourceId}</s:param>
	 <s:param name="currentPage">1</s:param>
	</s:action>
</div>
<script type="text/javascript">
$.unblockUI();
</script>
