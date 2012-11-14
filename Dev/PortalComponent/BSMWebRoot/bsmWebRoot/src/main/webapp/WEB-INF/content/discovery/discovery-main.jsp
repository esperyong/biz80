<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html>
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title><s:text name="discovery.page"/></title>
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js" ></script>
<script type="text/javascript" src="${ctx}/js/component/cfncc.js" ></script>
<script type="text/javascript" src="${ctx}/js/component/comm/winopen.js"></script>
<script type="text/javascript" src="${ctx}/js/component/popwindow/popwin.js"></script>
<script type="text/javascript" src="${ctxJs}/jquery.blockUI.js"></script>
<script type="text/javascript" src="${ctx}/js/discovery/discovery-main.js" ></script>
<script type="text/javascript">
var configMgrRole = ${configMgrRole};
var licenseJson = $.parseJSON('${licenseJson}');
function resizeFrameHeight() {
	var ifm= document.getElementById("iframe_right");
	var subWeb = document.frames ? document.frames["iframe_right"].document : ifm.contentDocument;
	if(ifm != null && subWeb != null) {
		if (subWeb.body.scrollHeight > 600) {
	   		ifm.height = subWeb.body.scrollHeight + 10;
		} else {
		   	ifm.height = 600;
		}
	}
};
</script>
</head>
<body onunload="refreshMonitorPage();" >
<page:applyDecorator name="popwindow"  title="发现">
  
	<page:param name="width">900px</page:param>
	<page:param name="topBtn_index_1">1</page:param>
	<page:param name="topBtn_id_1">closeId</page:param>
	<page:param name="topBtn_css_1">win-ico win-close</page:param>
  	<page:param name="topBtn_title_1">关闭</page:param>
	
	<page:param name="content">
  
		<div id="find">
			<div id="find-left">
				<div id="div_config" class="find-ico-group">
					<h2 id="h2_config" style="cursor: pointer;">发现配置</h2>
					<ul id="ul_config" style="display:none;height:555px;">
						<s:if test="configMgrRole != true" >
							<li><a id="a_navigate_allocation" licenseKey='<s:property value="@com.mocha.bsm.resourcediscovery.util.ConfigManager@MODULE_LICENSE_KEY_NETMANAGE" />' class="find-ico find-ico-allocation"></a></li>
						</s:if>
						<li><a id="a_navigate_initialise" class="find-ico find-ico-initialise"></a></li>
						<s:if test="configMgrRole != true" >
							<li><a id="a_navigate_report" licenseKey='<s:property value="@com.mocha.bsm.resourcediscovery.util.ConfigManager@MODULE_LICENSE_KEY_NETMANAGE" />' class="find-ico find-ico-report"></a></li>
						</s:if>
						
					</ul>
				</div>
				<div id="div_auto" class="find-ico-group">
					<h2 id="h2_auto" style="cursor: pointer;">自动发现</h2>
					<ul id="ul_auto" >
						<s:if test="configMgrRole != true" >
							<li><a id="a_navigate_all" licenseKey='<s:property value="@com.mocha.bsm.resourcediscovery.util.ConfigManager@MODULE_LICENSE_KEY_NETMANAGE" />' class="find-ico find-ico-all"></a></li>
							<li><a id="a_navigate_extend" licenseKey='<s:property value="@com.mocha.bsm.resourcediscovery.util.ConfigManager@MODULE_LICENSE_KEY_NETMANAGE" />' class="find-ico find-ico-extend"></a></li>
						</s:if>
						<li><a id="a_navigate_subnet" licenseKey='<s:property value="@com.mocha.bsm.resourcediscovery.util.ConfigManager@MODULE_LICENSE_KEY_NETMANAGE" />' class="find-ico find-ico-subnet"></a></li>
						<li><a id="a_navigate_segment" licenseKey='<s:property value="@com.mocha.bsm.resourcediscovery.util.ConfigManager@MODULE_LICENSE_KEY_NETMANAGE" />' class="find-ico find-ico-segment"></a></li>
						<li><a id="a_navigate_resource" class="find-ico find-ico-resource"></a></li>
						<!-- li><a id="a_navigate_excel" class="find-ico find-ico-batch-operation"></a></li> -->
						<s:if test="configMgrRole != true" >
						<li><a id="a_navigate_autoadd" licenseKey='<s:property value="@com.mocha.bsm.resourcediscovery.util.ConfigManager@MODULE_LICENSE_KEY_NETMANAGE" />' class="find-ico find-ico-autoadd"></a></li>
						</s:if>
					</ul>
				</div>
				<div id="div_manual" class="find-ico-group">
					<h2 id="h2_manual" style="cursor: pointer;">手工添加</h2>
					<ul id="ul_manual" style="display:none;height:555px;">
					  <li><a id="a_navigate_single_add" class="find-ico find-ico-add-one"></a></li>
						<li><a id="a_navigate_batch_add" class="find-ico find-ico-batch-add"></a></li>
					</ul>
				</div>
			</div>
			
			<div id="find-right">
				<iframe id="iframe_right" name="iframe_right" src="category-list.action" scrolling="no"
					frameborder="0" marginheight="0" marginwidth="0" width="100%"  onLoad="resizeFrameHeight();" ></iframe>
			</div>
			 
			<!--
			<div id="find-right">
				<div class="find-right-w">
					<h2>设备</h2>
					<ul>
						<li id="Host"><a id="a_Host" class="find-rico find-rico-zhuji"></a></li>
						<li id="NetworkDevices"><a id="a_NetworkDevices" class="find-rico find-rico-wlsb"></a></li>
						<li id="WirelessAP"><a id="a_WirelessAP" class="find-rico find-rico-ap"></a></li>
						<li id="StorageDevices"><a id="a_StorageDevices" class="find-rico find-rico-ccsb"></a></li>
						<li id="General"><a id="a_General" class="find-rico find-rico-tysb"></a></li>
					</ul>
				</div>
				<div class="find-right-w">
					<h2>应用</h2>
					<ul>
						<li id="Database"><a id="a_Database" class="find-rico find-rico-database"></a></li>
						<li id="DirectoryServer"><a id="a_DirectoryServer" class="find-rico find-rico-directory"></a></li>
						<li id="J2EEAppServer"><a id="a_J2EEAppServer" class="find-rico find-rico-j2ee"></a></li>
						<li id="LotusDomino"><a id="a_LotusDomino" class="find-rico find-rico-lotus"></a></li>
						<li id="mailserver"><a id="a_mailserver" class="find-rico find-rico-mail"></a></li>
						<li id="Middleware"><a id="a_Middleware" class="find-rico find-rico-zhongjj"></a></li>
						<li id="WebServer"><a id="a_WebServer" class="find-rico find-rico-web"></a></li>
					</ul>		
				</div>
				<div class="find-right-w">
					<h2>业务系统</h2>
					<ul>
						<li id="HAGroup"><a id="a_HAGroup" class="find-rico find-rico-ha"></a></li>
					</ul>
				</div>
				<div class="find-right-w">
					<h2>标准服务</h2>
					<ul>
						<li id="StandardGroup"><a id="a_StandardGroup" class="find-rico find-rico-bzff"></a></li>
					</ul>
				</div>
				<div class="find-right-w">
					<h2>其他</h2>
					<ul>
						<li id="Link"><a id="a_Link" class="find-rico find-rico-link"></a></li>
						<li id="IBMTivoli"><a id="a_IBMTivoli" class="find-rico find-rico-ibm"></a></li>
					</ul>
				</div>
			</div>
			-->
		</div>

	</page:param>
</page:applyDecorator>
</body>
</html>