<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!--
	author:qiaozheng
	description:业务服务状态统计栏
	uri:{domainContextPath}/bizsm/bizservice/ui/bizservice-status-bar
 -->
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>ToolService</title>
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/service.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/portal02.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js"></script>

<script src="${ctx}/js/component/cfncc.js" type="text/javascript"></script>

<script type="text/javascript" src="${ctx}/js/component/toolBar/j-dynamic-statusbar.js"></script>

<script type="text/javascript" src="${ctx}/flash/bizsm/swfobject.js"></script>

<script type="text/javascript" src="${ctx}/js/blazeds-ajax/FABridge.js"></script>
<script type="text/javascript" src="${ctx}/js/blazeds-ajax/FDMSLib.js"></script>

<script type="text/javascript" src="${ctx}/js/bizservice/common.js"></script>

<script language="javascript">

	var jStatusbar = new JDynamicStatusbar({id: "jStatusbar-bizService", label: "业务服务"});

	$(function() {

		//jStatusbar.setAllValues(statusMap);
		/*
		var redObjArray = new Array();
		redObjArray.push({id:"red-1", name:"red-1"});

		var yellowObjArray = new Array();
		yellowObjArray.push({id:"yellow-1", name:"yellow-1"});
		yellowObjArray.push({id:"yellow-2", name:"yellow-2"});
		yellowObjArray.push({id:"yellow-3", name:"yellow-3"});

		var greenObjArray = new Array();
		greenObjArray.push({id:"green-1", name:"green-1"});
		greenObjArray.push({id:"green-2", name:"green-2"});
		greenObjArray.push({id:"green-3", name:"green-3"});
		greenObjArray.push({id:"green-4", name:"green-4"});
		greenObjArray.push({id:"green-5", name:"green-5"});

		var grayObjArray = new Array();
		grayObjArray.push({id:"gray-1", name:"gray-1"});
		grayObjArray.push({id:"gray-2", name:"gray-2"});
		grayObjArray.push({id:"gray-3", name:"gray-3"});
		grayObjArray.push({id:"gray-4", name:"gray-4"});
		grayObjArray.push({id:"gray-5", name:"gray-5"});
		grayObjArray.push({id:"gray-6", name:"gray-6"});

		jStatusbar.setColorStatus("red", redObjArray);
		jStatusbar.setColorStatus("yellow", yellowObjArray);
		jStatusbar.setColorStatus("green", greenObjArray);
		jStatusbar.setColorStatus("gray", grayObjArray);
		*/
		jStatusbar.appendToContainer("body");
		
		//页面第一次打开时,读取Cache里的业务服务状态等信息.
		window.setTimeout(function(){
			//执行AJAX请求,获取cache中业务服务状态等信息 /bizservicecache/.xml
			$.get('${ctx}/bizservicecache/.xml',{},function(data){
				//将获取的服务状态数据绑定到组件上
				f_bindStatusData(data);
			});
		}, 1000);

	});



	function disConnectAll(){
		consumer = new Consumer();
	  if(consumer && consumer.getChannelSet()){
		  consumer.getChannelSet().disconnectAll();
	  }
	}

	window.onbeforeunload = disConnectAll;

	function getChannelSet(){
	   var set = new ChannelSet();
	   var arr  = new Array();
	   var channel = new AMFChannel("biz_longpolling","${ctx}/messagebroker/amflongpolling");
	   set.addChannel(channel);

	   channel = new AMFChannel("biz_polling","${ctx}/messagebroker/amfpolling");
	   set.addChannel(channel);
	   return set;
	}


	/*
	* Once the bridge indicates that it is ready, we can proceed to
	* load the data.
	*/
	function fdmsLibraryReady(){
		//alert("fdmsLibraryReady");
		consumer = new Consumer();
		consumer.setDestination("bizservice-state-feed");
		consumer.addEventListener("message", messageHandler);
		var selector = "BIZSERVICE_ID IN ('ALL')";
		consumer.setSelector(selector);
		consumer.setChannelSet(getChannelSet());
		consumer.subscribe();

	}
	function messageHandler(event){
		var bodyObj = event.getMessage().getBody();
		var dataDom = func_asXMLDom(bodyObj);
		//将MQ上每次发送的服务状态数据绑定到组件上
		f_bindStatusData(dataDom);
		
	}
	function f_bindStatusData(dataDom){
		var $serviceData = $(dataDom).find('BizServices:first>BizService');
		//alert($serviceData.size());

		var redObjArray = new Array();
		var yellowObjArray = new Array();
		var greenObjArray = new Array();
		var grayObjArray = new Array();

		$serviceData.each(function(i){
			var $thisService = $(this);

			var moniteredTemp = "false";
			var $monitered = $thisService.find('>monitered');
			if($monitered.size() > 0){
				moniteredTemp = $monitered.text();
			}
			if(moniteredTemp == "false"){
				return true;
			}

			var stateTemp = $thisService.find('>monitoredState').text();
			var bizIDTemp = $thisService.find('>bizId').text();
			var nameTemp = $thisService.find('>name').text();


			if(stateTemp == "SERIOUS"){
				redObjArray.push({id:bizIDTemp, name:nameTemp});
			}else if(stateTemp == "WARNING"){
				yellowObjArray.push({id:bizIDTemp, name:nameTemp});
			}else if(stateTemp == "NORMAL"){
				greenObjArray.push({id:bizIDTemp, name:nameTemp});
			}else if(stateTemp == "UNKNOWN"){
				grayObjArray.push({id:bizIDTemp, name:nameTemp});
			}

		});

		jStatusbar.setColorStatus("red", redObjArray);
		jStatusbar.setColorStatus("yellow", yellowObjArray);
		jStatusbar.setColorStatus("green", greenObjArray);
		jStatusbar.setColorStatus("gray", grayObjArray);
	}
	/*
	function messageHandler(event){
		var bodyObj = event.getMessage().getBody();
		var $data = $(bodyObj);
		//var $data = $(event.getMessage());

		var $serviceData = $($data).find('BizService');
		//alert($serviceData.size());

		var redObjArray = new Array();
		var yellowObjArray = new Array();
		var greenObjArray = new Array();
		var grayObjArray = new Array();

		$serviceData.each(function(i){
			var $thisService = $(this);

			alert($thisService.find('monitoredState').size());
			alert($thisService.filter('monitoredState').size());

			var stateTemp = $thisService.filter('monitoredState').text();
			var bizIDTemp = $thisService.filter('bizId').text();
			var nameTemp = $thisService.filter('name').text();

			if(stateTemp == "SERIOUS"){
				redObjArray.push({id:bizIDTemp, name:nameTemp});
			}else if(stateTemp == "WARNING"){
				yellowObjArray.push({id:bizIDTemp, name:nameTemp});
			}else if(stateTemp == "NORMAL"){
				greenObjArray.push({id:bizIDTemp, name:nameTemp});
			}else if(stateTemp == "UNKNOWN"){
				grayObjArray.push({id:bizIDTemp, name:nameTemp});
			}

		});
		jStatusbar.setColorStatus("red", redObjArray);
		jStatusbar.setColorStatus("yellow", yellowObjArray);
		jStatusbar.setColorStatus("green", greenObjArray);
		jStatusbar.setColorStatus("gray", grayObjArray);
	}
	*/

	//FABridge.addInitializationCallback("example", fdmsLibraryReady);
	FDMSLibrary.addInitializationCallback("flash", fdmsLibraryReady);

	var swfVersionStr = "10.0.0";
	var xiSwfUrlStr = "playerProductInstall.swf";
	var flashvars = {};
	flashvars["bridgeName"] = "example";

	var params = {};
	params.quality = "high";
	params.bgcolor = "#ffffff";
	params.allowscriptaccess = "sameDomain";
	params.allowfullscreen = "true";


	var attributes = {};
	attributes.id = "FDMSBridge";
	attributes.name = "FDMSBridge";
	attributes.align = "middle";
	swfobject.embedSWF(
		"${ctx}/js/blazeds-ajax/FDMSBridge.swf", "flashContent",
		"0", "0",
		swfVersionStr, xiSwfUrlStr,
		flashvars, params, attributes);
	swfobject.createCSS("#flashContent", "display:block;text-align:left;");

</script>
</head>
<body>
<div id="flashContent" style="display:none;width:0px;height:0px"></div>
</body>
</html>
