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
      }
      
      //向flash传递参数，设置仪表参数
      function setWatchStatus() {
        //根据id获取flash实例，在这里id是CallAsFromJs，可以从Embed
        var flash = (navigator.appName.indexOf ("Microsoft") !=-1)?window["NetFullView"]:document["NetFullView"];
        //调用ActionScript注册的回调方法
        //参数依次：最小值，最大值，当前值，名称，单位, 绿色区域最大值， 黄色区域最大值，红色区域最大值,状态,翻板最近一小时取值url,翻板分组
        var cpuMetricName = "${cpu.metricName}";
        if(!cpuMetricName){
          cpuMetricName = "<s:text name="detail.cpuutilization" />";
        }
        var cpuMetricId = "<s:property value="cpu.metricId" />";
        var cpuCurrentValue = "<s:property value="cpu.currentValue" />";
        var cpuState = "<s:property value="cpu.state" />";
        var cpuYellowValue = "<s:property value="cpu.yellowValue" />";
        var cpuRedValue = "<s:property value="cpu.redValue" />";
        var cpuColor = "<s:property value="cpu.color" />";

        var memMetricName = "${mem.metricName}";
        if(!memMetricName){
          memMetricName = "<s:text name="detail.memutilization" />";
        }
        var memMetricId = "<s:property value="mem.metricId" />";
        var memCurrentValue = "<s:property value="mem.currentValue" />";
        var memState = "<s:property value="mem.state" />";
        var memYellowValue = "<s:property value="mem.yellowValue" />";
        var memRedValue = "<s:property value="mem.redValue" />";
        var memColor = "<s:property value="mem.color" />";

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
        flash.addWatch(0, 100, cpuCurrentValue, cpuMetricName,"%",cpuYellowValue,cpuRedValue,100,cpuState,url+cpuMetricId,cpuMetricName,cpuColor);
        flash.addWatch(0, 100,memCurrentValue , memMetricName, "%",memYellowValue,memRedValue,100,memState,url+memMetricId,memMetricName,memColor);
        flash.addWatch(0, trafficMax, trafficCurrentValue, pingMetricName, trafficUnit,trafficYellowValue,trafficRedValue,trafficMax,trafficState,url+pingMetricId,pingMetricName,pingColor);
      }
      //背板点击接口flash调用的js事件
      function showIfDetail(ifInstanceId){
        var url = "${ctx}/detail/ifdetail.action?ifInstanceId="+ifInstanceId;
        var ifDetailPanel = new winPanel({
          id:"ifDetailPanel",
          isautoclose:true,
          isDrag:false,
          width:340,
          x:440,
          y:100,
          url:url
          },{
          winpanel_DomStruFn:"blackLayer_winpanel_DomStruFn"
        });
        setTimeout(function(){closeItemArray.push(ifDetailPanel)},500);
      }
      //真实背板
      function openRealBackboard(nodeId){
        if(nodeId){
          winOpen({url:"/netfocus/netfocus.do?action=optservice@getnode&nodeId=" + nodeId + "&forward=/modules/flash/backboard.jsp",width:1000,height:610,name:'backboard'});
        }else{
          var _information = new information({text:"此资源不在拓扑中。"});
          _information.show(); 
        }
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
      //alert("${ctx}/detail/backboardinfo__Overview.action?instanceId=<s:property value="instanceId" />");
      flashvars.dataurl = "${ctx}/detail/backboardinfo__Overview.action?instanceId=<s:property value="instanceId" />";
      var params = {};
      params.quality = "high";
      params.bgcolor = "#ffffff";
      params.wmode = "transparent";
      params.allowscriptaccess = "sameDomain";
      params.allowfullscreen = "true";
      var attributes = {};
      attributes.id = "NetFullView";
      attributes.name = "NetFullView";
      attributes.align = "middle";
      swfobject.embedSWF("${ctxFlash}/resourcedetail/NetFullView.swf", "flashContent", 
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
