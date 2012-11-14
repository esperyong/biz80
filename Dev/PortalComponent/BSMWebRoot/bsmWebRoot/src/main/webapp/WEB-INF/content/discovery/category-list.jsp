<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html>
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title><s:text name="discovery.page"/></title>
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<style type="text/css">
#div_resource_list .elli-name{text-overflow:ellipsis;white-space:nowrap;overflow:hidden; word-spacing:normal; word-break:normal;}
</style>
<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js" ></script>
<script type="text/javascript" src="${ctx}/js/component/cfncc.js" ></script>
<script type="text/javascript" src="${ctx}/js/discovery/category-list.js" ></script>
<script language="javascript">
var licenseJson = $.parseJSON('${licenseJson}');
var common_device_resourceId = '${commonDeviceResourceId}';

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
window.setInterval("setFrameHeight()", 200);
</script>
</head> 
<body>
<form id="formname" name="formname" method="post" action="resource-discovery.action">
	<input type="hidden" id="resourceIdStr" name="resourceIdStr" />
	<input type="hidden" id="suffix" name="suffix" />
	<input type="hidden" id="isNetDevDiscoveryWay" name="isNetDevDiscoveryWay" value="false"/>
	<div id="find-right">
		<div class="find-right-w">
			<h2>设备</h2>
			<ul>
				<li id="host"><a id="a_Host" class="find-rico find-rico-zhuji"></a></li>
				<li id="networkdevice"><a id="a_NetworkDevices" class="find-rico find-rico-wlsb"></a></li>
				<!-- <li id="wirelessap"><a id="a_wirelessap" class="find-rico find-rico-ap"></a></li>  -->
				<li id="storage"><a id="a_StorageDevices" class="find-rico find-rico-ccsb"></a></li>
			</ul>
			<!-- div -->
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
				<li id="Avaya"><a id="a_Avaya" licenseKey="<s:property value="@com.mocha.bsm.resourcediscovery.util.ConfigManager@MODULE_LICENSE_KEY_MONTIOR2" />" class="find-rico find-rico-avaya"></a></li>
				<li id="StandardGroup"><a id="a_StandardGroup" licenseKey="<s:property value="@com.mocha.bsm.resourcediscovery.util.ConfigManager@MODULE_LICENSE_KEY_MONTIOR3" />" class="find-rico find-rico-bzff"></a></li>
				<!-- 暂时去掉HA -->
				<!-- li id="HAGroup"><a id="a_HAGroup" class="find-rico find-rico-ha"></a></li> -->
			</ul>
		</div>
		<!-- 永久去掉Tivoli模型， 2010-5-31
		<div class="find-right-w">
			<h2>其他</h2>
			<ul>
				<li id="IBMTivoli"><a id="a_IBMTivoli" class="find-rico find-rico-ibm"></a></li>
			</ul>
		</div>
		 -->
	</div>
</form>
</body>
</html>