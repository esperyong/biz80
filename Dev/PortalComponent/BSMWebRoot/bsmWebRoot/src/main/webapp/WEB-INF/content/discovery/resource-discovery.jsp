<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mocha.bsm.system.SystemContext"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html>
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<%@ include file="/WEB-INF/common/userinfo.jsp" %>
<%@ include file="/WEB-INF/common/loading.jsp" %>
<title>发现页面</title>
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/validationEngine.jquery.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js" ></script>
<script type="text/javascript" src="${ctx}/js/component/cfncc.js" ></script>
<script type="text/javascript" src="${ctx}/js/jquery.validationEngine-cn.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery.validationEngine.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery.countdown.js" ></script>
<script type="text/javascript" src="${ctx}/js/jquery.blockUI.js" ></script>
<script type="text/javascript" src="${ctx}/js/component/accordionPanel/accordionPanel.js"></script>
<script type="text/javascript" src="${ctx}/js/component/combobox/simplebox.js"></script>
<script type="text/javascript" src="${ctx}/js/component/panel/panel.js"></script>
<script type="text/javascript" src="${ctx}/js/component/gridPanel/grid.js"></script>
<script type="text/javascript" src="${ctx}/js/component/gridPanel/indexgrid.js"></script>
<script type="text/javascript" src="${ctx}/js/component/comm/winopen.js"></script>
<script type="text/javascript" src="${ctx}/js/component/toast/Toast.js"></script>
<script type="text/javascript" src="${ctx}/js/component/popwindow/popwin.js"></script>
<script type="text/javascript" src="${ctx}/js/discovery/resource-discovery.js" ></script>
<script type="text/javascript">
var contextPath = "${ctx}";
var isDiscovering = false;
$(function(){
	SimpleBox.renderToUseWrap([{wrapId:null, selectId:"domainId", maxHeight:60}]);
	SimpleBox.renderToUseWrap([{wrapId:null, selectId:"serverId", maxHeight:60}]);
	SimpleBox.renderToUseWrap([{wrapId:null, selectId:"discoveryWay", maxHeight:60}]);
	window.setInterval("setFrameHeight()", 200);
});
function replaceInstance(instanceId){
	var popCon=confirm_box(); 
	popCon.setContentText("资源已存在，是否替换已有资源？");
	popCon.show();
	popCon.setConfirm_listener(function(){
		popCon.hide();
		$("#loading_text").html('资源替换中，请稍后...');
		$.blockUI({message:$('#loading')});
		$("#replaceInstanceId").val(instanceId);
		var formObj = document.getElementById("form1");
		formObj.target = "iframe_discovery";
		formObj.action = "resource-result-replaceinstance.action";
		formObj.submit();
	});
	popCon.setCancle_listener(function(){
		popCon.hide();
		$("#resultFont").show();
		$("#sp_disc_result").show();
		window.frames["iframe_discovery"].$("#discoveryFail").show();
		window.frames["iframe_discovery"].setHeight();
	});
	popCon.setClose_listener(function(){
		popCon.hide();
		$("#resultFont").show();
		$("#sp_disc_result").show();
		window.frames["iframe_discovery"].$("#discoveryFail").show();
		window.frames["iframe_discovery"].setHeight();
	});
}
function setFrameHeight(){
	var iframe = parent.document.getElementById("iframe_right");
	try{
		var bHeight = iframe.contentWindow.document.body.scrollHeight;
		var dHeight = iframe.contentWindow.document.documentElement.scrollHeight;
		var height = Math.max(bHeight, dHeight);
		var outHeight = parent.window.screen.availHeight-100;
		if(height >= outHeight){
			iframe.height =  height;
		}else{
			iframe.height = outHeight;
		}
	}catch (e){}
}
</script>
</head>
<body>
<div id="find-right">
<s:form id="form1" name="form1" method="post" enctype="multipart/form-data">
<input type="hidden" name="dmsRelaDomain" id="dmsRelaDomain" value="${dmsRelaDomain }"/>
<input type="hidden" name="page_mark" id="page_mark" value="resource-discovery"/>
<input type="hidden" name="resourceIdStr" id="resourceIdStr" value="${resourceIdStr }"/>
<input type="hidden" name="suffix" id="suffix" value="${suffix }"/>
<input type="hidden" name="resourceId" id="resourceId" value="${resourceId }"/>
<input type="hidden" name="isNetDevDiscoveryWay" id="isNetDevDiscoveryWay" value="${isNetDevDiscoveryWay }"/>
<input type="hidden" name="replaceInstanceId" id="replaceInstanceId">
		<div class="h1"><span class="title">资源发现</span></div>
		
		<s:if test="isNetDevDiscoveryWay">
			<div id="divNetworkHelp" class="h2"><span class="ico ico-note"></span>使用SNMP方式统一发现路由器、交换机、防火墙等网络设备。</div>
		</s:if>
		
		<page:applyDecorator name="accordionPanel">
			<page:param name="id">panel_disc_domain</page:param>
			<page:param name="title">选择所属<%=domainPageName%></page:param>
			<page:param name="height"></page:param>
			<page:param name="width">690px</page:param>
			<page:param name="cls">fold</page:param>
			<page:param name="display">false</page:param>

		  	<page:param name="content">
				<ul class="fieldlist">
					<li>
						<span class="field-max" style="padding-top:5px; float: left;">所属<%=domainPageName%>：</span>
						<s:select id="domainId" name="domainId" list="allDomainList" listKey="ID" listValue="name" value="%{domainId}"></s:select>
					</li>
				</ul>
			</page:param>		  
		</page:applyDecorator>
		
		<div id="dmsDiv" <%if (SystemContext.isStandAlone()) {out.print("style='display:none'");}%>>
		<page:applyDecorator name="accordionPanel">
			<page:param name="id">panel_disc_server</page:param>
			<page:param name="title">选择DMS</page:param>
			<page:param name="height"></page:param>
			<page:param name="width">690px</page:param>
			<page:param name="cls">fold</page:param>
			<page:param name="display">false</page:param>

		  	<page:param name="content">
				<ul class="fieldlist">
					<li>
						<span class="field-max" style="padding-top:5px; float: left;">DMS：</span>	
						<span><s:select id="serverId" name="serverId" validate="funcCall[serverEmpty]" list="allServerList" listKey="id" listValue="name" value="%{serverId}"></s:select></span><span class="red">*</span>
					</li>
				</ul>
			</page:param>		  
		</page:applyDecorator>
		</div>
		<div <s:if test="discoveryWays.size == 0">style="display:none;"</s:if> >
		<page:applyDecorator name="accordionPanel">
			<page:param name="id">panel_disc_way</page:param>
			<page:param name="title">选择发现方式</page:param>
			<page:param name="height"></page:param>
			<page:param name="width">690px</page:param>
			<page:param name="cls">fold</page:param>
			<page:param name="display">false</page:param>

		  	<page:param name="content">
				<ul class="fieldlist">
					<li>
						<span class="field-max" style="padding-top:5px; float: left;">发现方式： </span>
						<s:select id="discoveryWay" name="discoveryWay" list="discoveryWays" listKey="id" listValue="name" value="resourceId"></s:select>
					</li>
				</ul>
			</page:param>		  
		</page:applyDecorator>
		</div>
		
		<page:applyDecorator name="accordionPanel">  
			<page:param name="id">panel_disc_info</page:param>
			<page:param name="title">填写发现信息</page:param>
			<page:param name="height"></page:param>
			<page:param name="width">690px</page:param>
			<page:param name="cls">fold</page:param>
			<page:param name="display"></page:param>
			
			<page:param name="topBtn_Index_1">1</page:param>
			<!-- <page:param name="topBtn_Id_1">a_disc_help</page:param>-->
			<page:param name="topBtn_div_1"><span id="a_disc_help" class="right"><span class="ico ico-search"/></span><a style="cursor: pointer;">发现前提</a></span></page:param>
		  
		  	<page:param name="content">
				<div id="disc_info">
					<s:iterator value="discInfoGroups" id="discInfos">
						<s:if test="discGroupId != null">
							<div class="h4">
								<s:property value="discGroupName"/>&nbsp;
							</div>
						</s:if>
						<ul class="fieldlist">
							<s:iterator value="discInfos" >
								<li>
									<span class="field" style="padding-top:5px; float: left; width: 120px"><s:property value="displayName"/></span><span class="field" style="padding-top:5px; float: left; width: 15px"><s:text name="i18n.discovery.colon"/></span>${fieldHTML}<s:if test="notNull"><span class="red">*</span></s:if><s:if test="helpInfo != null"><span class="ico ico-what" title="<s:property value="helpInfo"/>"></span></s:if>
								</li>
							</s:iterator>
						</ul>
					</s:iterator>
					<ul>
						<div class="margin3 t-right">
							<span class="black-btn-l" id="sp_discover"><span class="btn-r"><span class="btn-m"><a >发现</a></span></span></span>
						</div>
					</ul>
				</div>
			</page:param>		  
		</page:applyDecorator>
</s:form>
<div id="div_disc_result" style="display:none">
    <page:applyDecorator name="accordionPanel">  
		<page:param name="id">panel_disc_result</page:param>
		<page:param name="title">发现及监控</page:param>
		<page:param name="height"></page:param>
		<page:param name="width">690px</page:param>
		<page:param name="cls">fold</page:param>
		<page:param name="display"></page:param>
		
	  	<page:param name="content">
			<page:applyDecorator name="resource-discovering">
				<page:param name="timeField">发现时间</page:param>
				<page:param name="resultField">发现结果</page:param>
			</page:applyDecorator>
		</page:param>		  
	</page:applyDecorator>
</div>
	
	<div class="t-right">
		<!-- <span class="black-btn-l" id="sp_discover"><span class="btn-r"><span class="btn-m"><a >发现</a></span></span></span>  -->
		<span class="black-btn-l right" id="sp_finish" style="display:none"><span class="btn-r"><span class="btn-m"><a >完成并退出</a></span></span></span>
		<span class="black-btn-l right" id="sp_continue" style="display:none"><span class="btn-r"><span class="btn-m"><a >继续发现</a></span></span></span>
		<span class="black-btn-l right" id="sp_monitor" style="display:none"><span class="btn-r"><span class="btn-m"><a >加入监控</a></span></span></span>
	</div>

</body>
</html>