<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html> 
  <head>
    <title></title>         
    <%@ include file="/WEB-INF/common/meta.jsp" %>
    <style type="text/css" media="screen"> 
      html, body  { height:100%; }
      body { margin:0; padding:0; overflow:auto; text-align:center; background-color: #ffffff; }   
      #flashContent { display:none; }
    </style>
    <script type="text/javascript">
	    //flash 注册完成之后，通知html
	    function flashLoaded() {
	      setWatchStatus();
	      showWindowHostFullView();
	    }
	
	    function showWindowHostFullView() {
				var str = '<s:property value="hostViewXml" escape="false" />';
				//根据id获取flash实例，在这里id是CallAsFromJs，可以从Embed
			  var flash = (navigator.appName.indexOf ("Microsoft") !=-1)?window["HostFullView"]:document["HostFullView"];
			  //调用ActionScript注册的回调方法
			  flash.showWindowHostFullView(str);
	    }
	    
	    //向flash传递参数，设置仪表参数
	    function setWatchStatus() {
				//根据id获取flash实例，在这里id是CallAsFromJs，可以从Embed
				var flash = (navigator.appName.indexOf ("Microsoft") !=-1)?window["HostFullView"]:document["HostFullView"];
				//调用ActionScript注册的回调方法
				//参数依次：最小值，最大值，当前值，名称，单位, 绿色区域最大值， 黄色区域最大值，红色区域最大值,状态
				var cpuMetricId = "<s:property value="cpu.metricId" />";
	      var cpuCurrentValue = "<s:property value="cpu.currentValue" />";
	      var cpuState = "<s:property value="cpu.state" />";
	      var cpuYellowValue = "<s:property value="cpu.yellowValue" />";
	      var cpuRedValue = "<s:property value="cpu.redValue" />";
	      var cpuColor = "<s:property value="cpu.color" />";

	      var memMetricId = "<s:property value="mem.metricId" />";
	      var memCurrentValue = "<s:property value="mem.currentValue" />";
        var memState = "<s:property value="mem.state" />";
	      var memYellowValue = "<s:property value="mem.yellowValue" />";
	      var memRedValue = "<s:property value="mem.redValue" />";
	      var memColor = "<s:property value="mem.color" />";
	      //var diskValue = "<s:property value="diskUtilization.currentValue" />";
        //var diskUtilizationState = "<s:property value="diskUtilization.state" />";

        var pingMetricName = "${delayPing.metricName}";
        if(!pingMetricName){
          pingMetricName = "<s:text name="detail.pingdelay" />";
        }
        var pingMetricId = "<s:property value="delayPing.metricId" />";
        var trafficCurrentValue = "<s:property value="delayPing.currentValue" />";
        var trafficState = "<s:property value="delayPing.state" />";
        var trafficYellowValue = "<s:property value="delayPing.yellowValue" />";
        var trafficRedValue = "<s:property value="delayPing.redValue" />";
        var trafficUnit = "${delayPing.unit}";
        var trafficMax = "<s:property value="delayPing.maxValue" />";
        var pingColor = "<s:property value="delayPing.color" />";

        // 仪表盘翻板取值url
        var url = "${ctx}/detail/summarized!overviewSummarized.action?instanceId=<s:property value="instanceId" />&freq=1h&metricId=";
        flash.addWatch(0, 100, cpuCurrentValue, "<s:text name="detail.cpuutilization" />","%",cpuYellowValue,cpuRedValue,100,cpuState,url+cpuMetricId,"<s:text name="detail.cpuutilization" />",cpuColor);
        flash.addWatch(0, 100,memCurrentValue , "<s:text name="detail.memutilization" />", "%",memYellowValue,memRedValue,100,memState,url+memMetricId,"<s:text name="detail.memutilization" />",memColor);
        //flash.addWatch(0, 100, diskValue, "硬盘利用率", "%",100,100,100,diskUtilizationState);
        flash.addWatch(0, trafficMax, trafficCurrentValue, pingMetricName, trafficUnit,trafficYellowValue,trafficRedValue,trafficMax,trafficState,url+pingMetricId,pingMetricName,pingColor);
	    }
      if(window.$ && $.unblockUI){
        $.unblockUI();
      }
    </script>
    <link rel="stylesheet" type="text/css" href="${ctxFlash}/resourcedetail/history/history.css" />
    <script type="text/javascript" src="${ctxFlash}/resourcedetail/history/history.js"></script>
    <script type="text/javascript" src="${ctxFlash}/swfobject.js"></script>
    <script type="text/javascript">
      <!-- For version detection, set to min. required Flash Player version, or 0 (or 0.0.0), for no version detection. --> 
      var swfVersionStr = "10.0.0";
      <!-- To use express install, set to playerProductInstall.swf, otherwise the empty string. -->
      var xiSwfUrlStr = "${ctxFlash}/resourcedetail/playerProductInstall.swf";
      var flashvars = {};
      var params = {};
      params.quality = "high";
      params.bgcolor = "#ffffff";
      params.wmode = "transparent";
      params.allowscriptaccess = "sameDomain";
      params.allowfullscreen = "true";
      var attributes = {};
      attributes.id = "HostFullView";
      attributes.name = "HostFullView";
      attributes.align = "middle";
      swfobject.embedSWF("${ctxFlash}/resourcedetail/HostFullView.swf", "flashContent", 
          "100%", "100%", 
          swfVersionStr, xiSwfUrlStr, 
          flashvars, params, attributes);
			<!-- JavaScript enabled so display the flashContent div in case it is not replaced with a swf object. -->
			swfobject.createCSS("#flashContent", "display:block;text-align:left;");
    </script>
  </head>
  <body>
    <div id="flashContent">
      <p>To view this page ensure that Adobe Flash Player version 10.0.0 or greater is installed.</p>
    </div>
   </body>
</html>
