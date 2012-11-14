<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<page:applyDecorator name="tabPanel">
	<page:param name="id">resourceTab</page:param>
	<page:param name="width"></page:param>
	<page:param name="tabBarWidth"></page:param>
	<page:param name="cls">tab-grounp</page:param>
	<page:param name="current">1</page:param>
	<page:param name="tabHander">${pageJson}</page:param>
	<page:param name="content">
		<s:action name="resManage!resQuery" namespace="/resourcemanage" executeResult="true" ignoreContextParams="true" flush="false">
			<s:param name="pageQueryVO.domainId" value="pageQueryVO.domainId"/>
			<s:param name="pageQueryVO.workGroupId" value="pageQueryVO.workGroupId"/>
		</s:action>
	</page:param>
</page:applyDecorator>
<input type="hidden" name="pageQueryVO.domainId" value="${pageQueryVO.domainId}" id="domainIdmain"/>
<input type="hidden" name="pageQueryVO.workGroupId" value="${pageQueryVO.workGroupId}" id="workGroupIdmain"/>
<script type="text/javascript">
$(document).ready(function(){
	var tp = new TabPanel({id:"resourceTab",
		listeners:{
	        change:function(tab){
				$.blockUI({message:$('#loading')});
        		var domainId = $("#domainIdmain").val();
        		var workGroupId = $("#workGroupIdmain").val();
	        	var url="resManage!resQuery.action?pageQueryVO.domainId=" + domainId + "&pageQueryVO.workGroupId=" + workGroupId + "&pageQueryVO.resType=" + tab.id;
	        	tp.loadContent(1,{url:"${ctx}/resourcemanage/"+url,callback:function(){$.unblockUI();}});
	        }
    	}}
	);
});
</script>