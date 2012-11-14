<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<html>
<head>
	<title></title>
	<%@ include file="/WEB-INF/common/meta.jsp"%>
	<style type="text/css" media="screen">
	html,body {
		height: 100%;
	}
	
	body {
		margin: 0;
		padding: 0;
		overflow: auto;
		text-align: center;
		background-color: #ffffff;
	}
	
	#flashContent {
		display: none;
	}
	</style>
		 <script type="text/javascript">
				// 6889_Avaya_adv:avaya资源不显示应用的cpu和内存使用率
				var resourceId = "${resourceId}";
		   //flash 注册完成之后，通知html
		   function flashLoaded() {
		     setWatchStatus();
		     //showWindowAppFullView();
		   }
		
		   function showWindowAppFullView() {
		     //var str = '<s:property value="hostViewXml" escape="false" />';
		     //根据id获取flash实例，在这里id是CallAsFromJs，可以从Embed
		     //var flash = (navigator.appName.indexOf ("Microsoft") !=-1)?window["AppFullView"]:document["AppFullView"];
		     //调用ActionScript注册的回调方法
		     //flash.showWindowAppFullView(str);
		   }
		   
		   //向flash传递参数，设置仪表参数
		   function setWatchStatus() {
		     //根据id获取flash实例，在这里id是CallAsFromJs，可以从Embed
		     var flash = (navigator.appName.indexOf ("Microsoft") !=-1)?window["AppFullView"]:document["AppFullView"];
		     //调用ActionScript注册的回调方法
		     //参数依次：最小值，最大值，当前值，名称，单位, 绿色区域最大值， 黄色区域最大值，红色区域最大值,状态
		     var cpuMetricName = "${cpu.metricName}";
		     if(!cpuMetricName){
		       cpuMetricName = "<s:text name="detail.syscpu" />";
		     }
		     var cpuMetricId = "<s:property value="cpu.metricId" />";
		     var cpuCurrentValue = "<s:property value="cpu.currentValue" />";
		     var cpuState = "<s:property value="cpu.state" />";
		     var cpuYellowValue = "<s:property value="cpu.yellowValue" />";
		     var cpuRedValue = "<s:property value="cpu.redValue" />";
		     var cpuColor = "<s:property value="cpu.color" />";

         var memMetricName = "${mem.metricName}";
         if(!memMetricName){
           memMetricName = "<s:text name="detail.sysmem" />";
         }
         var memMetricId = "<s:property value="mem.metricId" />";
		     var memCurrentValue = "<s:property value="mem.currentValue" />";
		     var memState = "<s:property value="mem.state" />";
		     var memYellowValue = "<s:property value="mem.yellowValue" />";
		     var memRedValue = "<s:property value="mem.redValue" />";
		     var memColor = "<s:property value="mem.color" />";

         var appcpuMetricName = "${appCpu.metricName}";
         if(!appcpuMetricName){
           appcpuMetricName = "<s:text name="detail.appcpu" />";
         }
		     var appCpuMetricId = "<s:property value="appCpu.metricId" />";
		     var appCpuCurrentValue = "<s:property value="appCpu.currentValue" />";
		     var appCpuState = "<s:property value="appCpu.state" />";
		     var appCpuYellowValue = "<s:property value="appCpu.yellowValue" />";
		     var appCpuRedValue = "<s:property value="appCpu.redValue" />";
		     var appCpuColor = "<s:property value="appCpu.color" />";
		
		     var appmemMetricName = "${appMem.metricName}";
		     if(!appmemMetricName){
		       appmemMetricName = "<s:text name="detail.appmem" />";
		     }
		     var appMemMetricId = "<s:property value="appMem.metricId" />";
		     var appMemCurrentValue = "<s:property value="appMem.currentValue" />";
		     var appMemState = "<s:property value="appMem.state" />";
		     var appMemYellowValue = "<s:property value="appMem.yellowValue" />";
		     var appMemRedValue = "<s:property value="appMem.redValue" />";
		     var appMemColor = "<s:property value="appMem.color" />";
		     
		     //应用CPU利用率
		     //应用内存利用率
         // 仪表盘翻板取值url
         var url = "${ctx}/detail/summarized!overviewSummarized.action?instanceId=<s:property value="instanceId" />&freq=1h&metricId=";
		     flash.addWatch(0, 100, cpuCurrentValue, cpuMetricName,"%",cpuYellowValue,cpuRedValue,100,cpuState,url+cpuMetricId,"<s:text name="detail.cpuutilization" />",cpuColor);
		     if(resourceId!='6889_Avaya_adv'){
		       flash.addWatch(0, 100, appCpuCurrentValue, appcpuMetricName,"%",appCpuYellowValue,appCpuRedValue,100,appCpuState,url+appCpuMetricId,"<s:text name="detail.cpuutilization" />",appCpuColor);
		     }
		     flash.addWatch(0, 100,memCurrentValue , memMetricName, "%",memYellowValue,memRedValue,100,memState,url+memMetricId,"<s:text name="detail.memutilization" />",memColor);
		     if(resourceId!='6889_Avaya_adv'){
		       flash.addWatch(0, 100,appMemCurrentValue , appmemMetricName, "%",appMemYellowValue,appMemRedValue,100,appMemState,url+appMemMetricId,"<s:text name="detail.memutilization" />",appMemColor);
		     }
		   }
		   if(window.$ && $.unblockUI){
		     $.unblockUI();
		   }
		 </script>
		<link rel="stylesheet" type="text/css"
			href="${ctxFlash}/resourcedetail/history/history.css" />
		<script type="text/javascript"
			src="${ctxFlash}/resourcedetail/history/history.js"></script>
		<script type="text/javascript" src="${ctxFlash}/swfobject.js"></script>
	</head>
<body>
<div id="flash2" style="padding-left: 22px; padding-top: 18px;height:100%;width:100%;">
  <div id="suspendContent"><script type="text/javascript">
		      <!-- For version detection, set to min. required Flash Player version, or 0 (or 0.0.0), for no version detection. --> 
		      var swfVersionStr = "10.0.0";
		      <!-- To use express install, set to playerProductInstall.swf, otherwise the empty string. -->
		      var xiSwfUrlStr = "${ctxFlash}/resourcedetail/playerProductInstall.swf";
		      var flashvars = {};
		      var url = "${ctx}/detail/appinfo__Overview.action?instanceId=<s:property value="instanceId" />&now=<%=new java.util.Date().getTime()%>";
		      flashvars.dataurl = url;
		      var params = {};
		      params.quality = "high";
		      params.bgcolor = "#ffffff";
		      params.wmode = "transparent";
		      params.allowscriptaccess = "sameDomain";
		      params.allowfullscreen = "true";
		      var attributes = {};
		      attributes.id = "AppFullView";
		      attributes.name = "AppFullView";
		      attributes.align = "middle";
		      swfobject.embedSWF("${ctxFlash}/resourcedetail/AppFullView.swf", "suspendContent", 
		          "100%", "100%", 
		          swfVersionStr, xiSwfUrlStr, 
		          flashvars, params, attributes);
		      <!-- JavaScript enabled so display the flashContent div in case it is not replaced with a swf object. -->
		      swfobject.createCSS("#flashContent", "display:block;text-align:left;");
		    </script>

    <p>To view this page ensure that Adobe Flash Player version 10.0.0 or greater is installed.</p>
  </div>
</div>
</body>
</html>
