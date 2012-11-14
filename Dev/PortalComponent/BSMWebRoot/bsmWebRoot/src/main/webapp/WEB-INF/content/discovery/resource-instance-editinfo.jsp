<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/WEB-INF/common/loading.jsp" %>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html>
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>变更发现信息</title>
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/validationEngine.jquery.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js" ></script>
<script type="text/javascript" src="${ctx}/js/component/cfncc.js" ></script>
<script type="text/javascript" src="${ctx}/js/jquery.validationEngine-cn.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery.validationEngine.js"></script>
<script type="text/javascript" src="${ctx}/js/component/accordionPanel/accordionPanel.js"></script>
<script type="text/javascript" src="${ctx}/js/component/panel/panel.js"></script>
<script type="text/javascript" src="${ctx}/js/component/gridPanel/grid.js"></script>
<script type="text/javascript" src="${ctx}/js/component/gridPanel/indexgrid.js"></script>
<script type="text/javascript" src="${ctx}/js/component/combobox/simplebox.js"></script>
<script type="text/javascript" src="${ctx}/js/component/comm/winopen.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery.blockUI.js"></script>
<script type="text/javascript" src="${ctx}/js/discovery/resource-discovery.js" ></script>
<script type="text/javascript">
$(document).ready(function() {

	<s:if test="success == true">
		window.close();
	</s:if> 
	<s:else>
	$("#sp_cancel").bind("click", function() {
		window.close();
	});
	$("#sp_ok").bind("click", function() {
		if(!$.validate($("#form1"),{promptPosition:"centerRight"})){
	    	return;
	    }
		
		// TODO temp
		$.blockUI({message:$('#loading')});
		
		var formObj = document.getElementById("form1");
		formObj.action = "resource-instance-editinfosubmit.action?instanceId=${instanceId}"+"&isChangePwd="+changeArr.join(",");
		formObj.submit();
	});
	</s:else>
	$("#closeId").bind("click", function() {
		window.close();
	});
	$("#loading_text").html('<s:text name="page.loading.msg" />');
});
</script>
</head>
<body>
<input type="hidden" id="domainId" name="domainId" value="${domainId }">
<s:if test="discInfoGroups == null || discInfoGroups.size == 0">

	<page:applyDecorator name="popwindow" title="变更发现信息">

		<page:param name="width">100%</page:param>
		<page:param name="topBtn_index_1">1</page:param>
		<page:param name="topBtn_id_1">closeId</page:param>
		<page:param name="topBtn_css_1">win-ico win-close</page:param>
		<page:param name="topBtn_title_1">关闭</page:param>

		<page:param name="bottomBtn_index_1">1</page:param>
		<page:param name="bottomBtn_id_1">sp_cancel</page:param>
		<page:param name="bottomBtn_text_1">关闭</page:param>

		<page:param name="content">
			<div class="roundedform-content">
				<table class="hundred" align="center" height="200px"><tbody><tr>
				<td class="nodata vertical-middle" style="text-align:center;"><span class="nodata-l"><span class="nodata-r"><span class="nodata-m">
				<span class="icon">当前无数据</span> </span></span></span>
				</td>
				</tr></tbody></table>
	        </div>
		</page:param>
	</page:applyDecorator>
			
</s:if>
<s:else>
	<page:applyDecorator name="popwindow"  title="变更发现信息">
	  
	  <page:param name="width">600px</page:param>
	  <page:param name="topBtn_index_1">1</page:param>
	  <page:param name="topBtn_id_1">closeId</page:param>
	  <page:param name="topBtn_css_1">win-ico win-close</page:param>
	  <page:param name="topBtn_title_1">关闭</page:param>
	    
	    <page:param name="bottomBtn_index_1">1</page:param>
		<page:param name="bottomBtn_id_1">sp_ok</page:param>
		<page:param name="bottomBtn_text_1">确定</page:param>
		
		<page:param name="bottomBtn_index_2">2</page:param>
		<page:param name="bottomBtn_id_2">sp_cancel</page:param>
		<page:param name="bottomBtn_text_2">取消</page:param>
		
	  <page:param name="content">
	
		<div style="position:relative;height:240px;overflow-x:hidden;overflow-y:auto;">
		  <div class="greywhite-border padding5">
				<div class="h2"><span class="ico ico-note-blue"></span>说明：当设备的发现信息变更时，请及时更新，否则将无法取值。 </div>
				<s:action name="resource-instance-discoveryinfo" executeResult="true" namespace="/discovery" flush="false">
					<s:param name="resourceId" value="resourceId" />
					<s:param name="instanceId" value="instanceId" />
				</s:action>
		  </div>
		</div>
		<!-- 
		<iframe id="iframe_discovery" name="iframe_discovery" src="" scrolling="no"	frameborder="0" 
				marginheight="0" marginwidth="0" width="100%" ></iframe>
		 -->
	  </page:param>
	</page:applyDecorator>
</s:else>

</body>
</html>