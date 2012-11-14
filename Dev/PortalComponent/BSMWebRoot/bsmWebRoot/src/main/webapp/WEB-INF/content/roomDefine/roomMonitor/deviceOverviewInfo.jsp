<!-- 机房-机房监控-设备一览 deviceOverviewInfo.jsp -->
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>设备一览</title>
<link rel="stylesheet" href="${ctx}/css/portal02.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/common.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/public.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/UIComponent.css" type="text/css" /> 
<script type="text/javascript" src="${ctx}/js/component/comm/winopen.js"></script>
<script type="text/javascript" src="${ctx}/js/component/menu/menu.js"></script>

</head>
<body >
<form id="deviceOverviewID" action="" name="deviceOverviewForm" method="post" namespace="/roomDefine">
<div style="overflow:hidden;width:100%;">
<ul>
<li>
	<span id="lamp-greenICO" class="lamp lamp-green"></span><span style="color:#fff">:</span><span style="color:#fff;cursor: pointer" id="lamp-greenID"><s:property value="lampGreen" /></span>
	<span id="lamp-greenblackICO" class="lamp lamp-greenblack"></span><span style="color:#fff">:</span><span style="color:#fff;cursor: pointer" id="lamp-greenblackID"><s:property value="lampGreenblack" /></span>
	<span id="lamp-greenredICO" style=" background-color:#000000;height:16px;" class="lampshine-blackbg-ico lampshine-blackbg-ico-greenred"></span><span style="color:#fff">:</span><span style="color:#fff;cursor: pointer" id="lamp-greenredID"><s:property value="lampGreenred" /></span>
	<span id="lamp-greenredblackICO" style=" background-color:#000000;height:16px;" class="lampshine-blackbg-ico lampshine-blackbg-ico-alert-greenred"></span><span style="color:#fff">:</span><span style="color:#fff;cursor: pointer" id="lamp-greenredblackID"><s:property value="lampGreenredblack" /></span>
	<span id="lamp-greenyelICO" style=" background-color:#000000;height:16px;" class="lampshine-blackbg-ico lampshine-blackbg-ico-greenyellow"></span><span style="color:#fff">:</span><span style="color:#fff;cursor: pointer" id="lamp-greenyelID"><s:property value="lampGreenyel" /></span>
	<span id="lamp-greenyelblackICO" style=" background-color:#000000;height:16px;" class="lampshine-blackbg-ico lampshine-blackbg-ico-alert-greenyellow"></span><span style="color:#fff">:</span><span style="color:#fff;cursor: pointer" id="lamp-greenyelblackID"><s:property value="lampGreenyelblack" /></span>
	<span id="lamp-greenwhiteICO" style=" background-color:#000000;height:16px;" class="lampshine-blackbg-ico lampshine-blackbg-ico-greengray"></span><span style="color:#fff">:</span><span style="color:#fff;cursor: pointer" id="lamp-greenwhiteID"><s:property value="lampGreenwhite" /></span>
	<span id="lamp-greenwhiteblackICO" style=" background-color:#000000;height:16px;" class="lampshine-blackbg-ico lampshine-blackbg-ico-alert-greengray"></span><span style="color:#fff">:</span><span style="color:#fff;cursor: pointer" id="lamp-greenwhiteblackID"><s:property value="lampGreenwhiteblack" /></span>
	<span id="lamp-redICO" class="lamp lamp-red"></span><span style="color:#fff">:</span><span style="color:#fff;cursor: pointer" id="lamp-redID"><s:property value="lampRed" /></span>
	<span id="lamp-grayICO" class="lamp lamp-gray"></span><span style="color:#fff">:</span><span style="color:#fff;cursor: pointer" id="lamp-grayID"><s:property value="lampGray" /></span>
	<span id="ico-stopICO" class="ico ico-stop" style="cursor: pointer"></span><span style="color:#fff">:</span><span style="color:#fff;cursor: pointer" id="ico-stopID"><s:property value="icoStop" /></span>
</li>
<li style="height:25px">
<!--	<span class="black-btn-l f-right" ><span class="btn-r"><span class="btn-m"><a id="batchId">批量操作</a></span></span></span>-->
<!--	<span class="black-btn-l f-right" ><span class="btn-r"><span class="btn-m"><a id="flushId">刷新页面</a></span></span></span>-->
	
	<s:select id="chooseDev" name="chooseDev" class="validate[required]"  list="resGroups" listKey="key" listValue="value">
		<!-- 
		<option value="all" >请选择设备类型</option>
		<s:iterator value="capacityMap" id="map" >
			 <option value="<s:property value="#map.key" />" ><s:property value="#map.value" /></option>
		</s:iterator>
		 -->
	</s:select>
  		<select id="chooseSearchType" name="chooseSearchType" class="">
  		<option value="ipAddress" >IP地址</option>
		<option value="devName" >设备名称</option>
		<option value="room_jigui" >机柜号</option>
		<option value="room_deviceNo" >设备号</option>
	</select>
  	<input type="text" id="inputName" name="inputName" />
  	<span id="searchView" class="ico" title="搜索" ></span>
</li>
</ul>
	
</div>  
<page:applyDecorator name="indexgrid">  
	<page:param name="id">deviceViewTableId</page:param>
	<page:param name="width">540px</page:param>
	<page:param name="lineHeight">25</page:param>
	<page:param name="linenum">20</page:param>
	<page:param name="tableCls">grid-black</page:param>
	<!--<page:param name="gridhead">[{colId:"resourceId",text:"<input type='checkbox' name='checkAll' id='checkAllId' style='cursor:pointer' />"},{colId:"resourceState",text:"状态"},{colId:"devName",text:"设备名称"},{colId:"ipAddress",text:"IP地址"},{colId:"deviceType",text:"设备类型"},{colId:"jiguiNo",text:"机柜号"},{colId:"jikuangNo",text:"机框号"},{colId:"deviceNo",text:"设备号"},{colId:"cpu",text:"CPU利用率"},{colId:"memory",text:"内存利用率"},{colId:"interfaced",text:"接口"},{colId:"beiban",text:"背板"},{colId:"view",text:"可视化"},{colId:"operator",text:"操作"}]</page:param>-->
	<page:param name="gridhead">[{colId:"resourceState",text:"状态"},{colId:"devName",text:"设备名称"},{colId:"ipAddress",text:"IP地址"},{colId:"deviceType",text:"设备类型"},{colId:"jiguiNo",text:"机柜号"},{colId:"jikuangNo",text:"机框号"},{colId:"deviceNo",text:"设备号"},{colId:"notes",text:"备注"},{colId:"cpu",text:"CPU利用率"},{colId:"memory",text:"内存利用率"},{colId:"interfaced",text:"接口"},{colId:"beiban",text:"背板"},{colId:"view",text:"可视化"},{colId:"operator",text:"操作"}]</page:param>
	<page:param name="gridcontent"><s:property value="resourceData" escape="false" /> </page:param>
</page:applyDecorator>
<div id="pageover" style="overflow:hidden;width:100%" ></div>
<input type="hidden" name="roomId" id="roomId" value="<s:property value='roomId' />" />
<input type="hidden" id="deleteDevIds" name="deleteDevIds" value="" />
<input type="hidden" id="sortIdHidden" name="sortIdHidden" value="" />
<input type="hidden" id="sortColIdHidden" name="sortColIdHidden" value="" />
<input type="hidden" id="pageIdHidden" name="pageIdHidden" value="" />
<input type="hidden" id="statusCssHidden" name="statusCssHidden" value="" />
</form>
<iframe name="submitIframe" id="submitIframeId" frameborder="0" scrolling="no" height="0" width="0" src=""></iframe>
</body>
</html>
<script type="text/javascript">
var path = "${ctx}";
var instanceId;
var ip;
var nodeId;
var locationId;
var currentPage = '1';
var pageSize = '<s:property value="pageCount" />';
var isFocusShow = '<s:property value="isFocusShow" />';
var isLocationShow = '<s:property value="isLocationShow" />';
var isBizsmShow = '<s:property value="isBizsmShow" />';
var businessPanel;
//$.unblockUI();
if (parent.unBolck){
	window.parent.unBolck();
}
var roomMenu = new MenuContext({
    x: 20,
    y: 100,
    width: 150,
    plugins:[duojimnue],
    listeners: {
        click: function(id) {
            //alert(id)
        }
    }
});
var roomEquipmentArray = [[
{
    text: "未确认告警",
    id: "unrecognizedAlarm",
    listeners: {
        click: function() {
              var url = path + "/detail/insalarmoverview.action?resInstanceId=" + instanceId;
              winOpen({url:url,width:1000,height:600,name:'detailAlarm'});
        }
    }
},
/*{
    text: "未提交工单",
    id: "failsSubmitWorkOrders",
    listeners: {
        click: function() {}
    }
},*/
{
  text: "工具", 
  id: "tools", 
  childMenu: {
    width: 150, 
    menus: [
      [
        {
          text: "Ping", 
          id: "Ping",
           listeners: {
            click: function(){
                 var url = "/netfocus/modules/tool/ping_tools.jsp?ip="+ip;
                
                 winOpen({url:url,width:800,height:520,name:'toolsPing'});
            }
          }
        }, 
        {
          text: "TelNet", 
          id: "TelNet", 
          listeners: {
            click: function(){
                      var url = "/netfocus/applet/telnetApplet.jsp?address="+ip;
                      winOpen({url:url,width:800,height:600,name:'toolsTelnet'});
            }
          }
        }, 
        {
          text: "MIB", 
          id: "MIB", 
          listeners: {
            click: function(){
                     var url = "/netfocus/applet/MIBApplet.jsp?address="+ip;
                     winOpen({url:url,width:800,height:600,name:'toolsMIB'});
            }
          }
        }, 
        {
          text: "SNMP Test", 
          id: "SNMP", 
          listeners: {
            click: function(){
                    var url = "/netfocus/modules/tool/snmptest.jsp?ip="+ip;
                    winOpen({url:url,width:800,height:520,name:'toolsSnmptest'});
            }
          }
        }, 
        {
          text: "TraceRoute", 
          id: "TraceRoute", 
          listeners: {
            click: function(){
                    var url = "/netfocus/modules/tool/traceroute_tools.jsp?ip="+ip;
                   winOpen({url:url,width:800,height:520,name:'toolsTraceroute'});
            }
          }
        }
      ]
    ]
  }
}
,
{
    text: "诊断",
    id: "diagnose",
    listeners: {
        click: function() {
              var url = path + "/discovery/resource-instance-diagnose!diagnose.action?instanceId=" + instanceId; 
              winOpen({url:url,width:690,height:415,name:'detailDiagnose'});
        }
    }
}
], [
{
    text: "物理位置",
    id: "physicalLocation",
    //disable: (isLocationShow=='true'?true:false),
    //disablePrompt:(isLocationShow!='true'?"无物理位置License，请联络摩卡软件获取购买相关License的信息。":""),
    listeners: {
        click: function() {
		//if(isLocationShow=='true'){
		    var url = path + "/detail/detailoperate!locationInfo.action?instanceId=" + instanceId;
		    winOpen({url:url,width:343,height:335,name:'toolsPhylocation'});
		//}else{
			//alert("无物理位置License，请联络摩卡软件获取购买相关License的信息。");
    	//}
             
        }
    }
},
/*
{
    text: "接口定位",
    id: "InterfaceLocalization",
    listeners: {
        click: function() {}
    }
},*/
{
    text: "下联设备",
    id: "bottomAlliedEquipment",
    disable: (isFocusShow=='true'?true:false),
    disablePrompt:(isFocusShow!='true'?"无网络拓扑License，请联络摩卡软件获取购买相关License的信息。":""),
    listeners: {
        click: function() {
        if(isFocusShow=='true'){
        	if(nodeId!=null){
                var equipUrl = "/netfocus/netfocus.do?action=position@getdowndevinfo&nodeID="+nodeId;
                   winOpen({url:equipUrl,width:1000,height:610,scrollable:true,name:'detailEquipment'});
             }
        }else{
			alert("无网络拓扑License，请联络摩卡软件获取购买相关License的信息。");
        }
        }
    }
},
{
    text: "拓扑定位",
    id: "topologyLocation",
    disable: (isFocusShow=='true'?true:false),
    disablePrompt:(isFocusShow!='true'?"无网络拓扑License，请联络摩卡软件获取购买相关License的信息。":""),
    listeners: {
        click: function() {
			if(isFocusShow=='true'){
             var url = "/netfocus/flash/focusonnetwork60.jsp?userid=user-000000000000001"  + "&instanceId=" + instanceId;
             winOpen({url:url,width:800,height:600,name:'detailTopolocation'});
			}else{
				alert("无网络拓扑License，请联络摩卡软件获取购买相关License的信息。");
	        }
        }
    }
},
{
    text: "关联业务服务",
    id: "associatedBusinessService",
    disable: isBizsmShow=='true'?true:false,
    disablePrompt:(isBizsmShow!='true'?"无业务服务License，请联络摩卡软件获取购买相关License的信息。":""),
    listeners: {
        click: function() {
	 		if(isBizsmShow=='true'){
     			//var url = path+"/monitor/monitorList!businessService.action?instanceId=" + instanceId;
    			//winOpen({url:url,width:800,height:600,name:'bizsmlocation'});
	 			var url = path + "/monitor/monitorList!businessService.action?instanceId=" + instanceId;
	 		    if (businessPanel == null) {
	 		        var div = document.getElementById("totalDivId");
	 		        var top = (document.documentElement.clientHeight) / 2;
	 		        var left = (document.documentElement.clientWidth) / 2;
	 		       businessPanel = new winPanel({
	 		            type: "POST",
	 		            url: url,
	 		            width: 300,
	 		            x: left - 150,
	 		            y: top - 150,
	 		            isautoclose: true,
	 		            closeAction: "close",
	 		            listeners: {
	 		                closeAfter: function() {
	 		                   businessPanel = null;
	 		                },
	 		                loadAfter: function() {}
	 		            }
	 		        },
	 		        {
	 		            winpanel_DomStruFn: "blackLayer_winpanel_DomStruFn"
	 		        });
	 		    }
	 		    			
	 		}else{
    			alert("无业务服务License，请联络摩卡软件获取购买相关License的信息。");
    	    }
    	}
    }
}/*,
{
    text: "CMDB",
    id: "CMDB",
    listeners: {
        click: function() {}
    }
}*/]];


var page = new Pagination({
    applyId: "pageover",
    listeners: {
    pageClick: function(page) {
	$("#pageIdHidden").val(page);
    var sort=$("#sortIdHidden").val();
    var sortCol=$("#sortColIdHidden").val();
    var roomId = $("#roomId").val();
    var statusCss = $("#statusCssHidden").val();
    var result = $("form").serialize()+"&curPageCount=" + page  + "&colId=" + sort + "&sortType=" + sortCol+"&statusCss="+statusCss;
    var url = "";
    if(null != statusCss && "" != statusCss && "undefined" != statusCss){//根据状态灯过滤
    	url="${ctx}/roomDefine/DeviceOverviewVisit!searchOneStateDevice.action";
    }else{
	    url="${ctx}/roomDefine/DeviceOverviewVisit!searchDeviceMethod.action";
    }
    //alert(result);
	//var url="${ctx}/roomDefine/DeviceOverviewVisit!searchDeviceMethod.action";
            $.ajax({
                type: "POST",
                dataType: 'json',
        		data:result, 
        		url: url,
                success: function(data, textStatus) {
            		var resourceData = data.resourceData;
    				gp.loadGridData(resourceData);
                }
            });
        }
    }
});
page.pageing(pageSize,1);

var panel;
var viewInterFace;

var gp;
var oldStatucCss="";
function ajaxLoadListFun(event) {
	var statusCss = event.data.deng;
	var roomId = $("#roomId").val();
	var catalog =$("#chooseDev option:selected").val();
	var sort=$("#sortIdHidden").val();
    var sortCol=$("#sortColIdHidden").val();
    var pageVal = $("#pageIdHidden").val();

    if (oldStatucCss == statusCss){
    	statusCss = "";
    }
    oldStatucCss = statusCss;
    
    if(null == pageVal || "" == pageVal){
    	pageVal = '<s:property value="curPageCount" />';
   	}
    var result = $("form").serialize()+"&curPageCount=" + pageVal  + "&colId=" + sort + "&sortType=" + sortCol+"&statusCss="+statusCss;
    var url;
	if (statusCss!=""){
		url = "${ctx}/roomDefine/DeviceOverviewVisit!searchOneStateDevice.action";	
	}else{
		url="${ctx}/roomDefine/DeviceOverviewVisit!searchDeviceMethod.action";
	}
     
    
	$.ajax({
		type: "post",
		dataType:'json', //接受数据格式 
		cache:false,
		data:result,
		url: url,
		beforeSend: function(XMLHttpRequest){
		//ShowLoading();
		},
		success: function(data, textStatus){
			var resourceData = data.resourceData;
			gp.loadGridData(resourceData);
			page.pageing(data.pageCount,1);
			$("#statusCssHidden").val(data.statusCss);
		},
		complete: function(XMLHttpRequest, textStatus){
		//HideLoading();
		},
		error: function(){
		//请求出错处理
			alert("error");
		}
		});
}
$("document").ready(function() {
	$("#lamp-greenID").bind("click",{deng:"lamp lamp-green"},ajaxLoadListFun);
	$("#lamp-greenblackID").bind("click",{deng:"lamp lamp-greenblack"},ajaxLoadListFun);
	$("#lamp-greenredID").bind("click",{deng:"lampshine-ico lampshine-ico-greenred"},ajaxLoadListFun);
	$("#lamp-greenredblackID").bind("click",{deng:"lampshine-ico lampshine-ico-alert-greenred"},ajaxLoadListFun);
	$("#lamp-greenyelID").bind("click",{deng:"lampshine-ico lampshine-ico-greenyellow"},ajaxLoadListFun);
	$("#lamp-greenyelblackID").bind("click",{deng:"lampshine-ico lampshine-ico-alert-greenyellow"},ajaxLoadListFun);
	$("#lamp-greenwhiteID").bind("click",{deng:"lampshine-ico lampshine-ico-greengray"},ajaxLoadListFun);
	$("#lamp-greenwhiteblackID").bind("click",{deng:"lampshine-ico lampshine-ico-alert-greengray"},ajaxLoadListFun);
	$("#lamp-redID").bind("click",{deng:"lamp lamp-red"},ajaxLoadListFun);
	$("#lamp-grayID").bind("click",{deng:"lamp lamp-gray"},ajaxLoadListFun);
	$("#ico-stopID").bind("click",{deng:"ico-stop"},ajaxLoadListFun);

	$("#lamp-greenICO").bind("mouseover",{rem:'<span class="lamp lamp-green" ></span><span>当前资源可用。</span>'},mousesuspension);
	$("#lamp-greenICO").bind("mouseout",mouseOutsuspension);
	$("#lamp-greenblackICO").bind("mouseover",{rem:'<span class="lamp lamp-greenblack" ></span><span>1.当前资源可用；2.资源或其组件配置变更。</span>'},mousesuspension);
	$("#lamp-greenblackICO").bind("mouseout",mouseOutsuspension);
	$("#lamp-greenredICO").bind("mouseover",{rem:'<span class="lampshine-blackbg-ico lampshine-blackbg-ico-greenred" ></span><span>1.当前资源可用；2.资源或其组件的性能出现问题，一个或多个性能指标违反红色阈值，或某些组件不可用；3.无配置变更。</span>'},mousesuspension);
	$("#lamp-greenredICO").bind("mouseout",mouseOutsuspension);
	$("#lamp-greenredblackICO").bind("mouseover",{rem:'<span class="lampshine-blackbg-ico lampshine-blackbg-ico-alert-greenred" ></span><span>1.当前资源可用；2.资源或其组件的性能出现问题，一个或多个性能指标违反红色阈值，或某些组件不可用；3.资源或其组件有配置变更。</span>'},mousesuspension);
	$("#lamp-greenredblackICO").bind("mouseout",mouseOutsuspension);
	$("#lamp-greenyelICO").bind("mouseover",{rem:'<span class="lampshine-blackbg-ico lampshine-blackbg-ico-greenyellow" ></span><span>1.当前资源可用；2.资源或其组件的性能出现问题，一个或多个性能指标违反黄色阈值；3.无配置变更。</span>'},mousesuspension);
	$("#lamp-greenyelICO").bind("mouseout",mouseOutsuspension);
	$("#lamp-greenyelblackICO").bind("mouseover",{rem:'<span class="lampshine-blackbg-ico lampshine-blackbg-ico-alert-greenyellow" ></span><span>1.当前资源可用；2.资源或其组件的性能出现问题，一个或多个性能指标违反黄色阈值；3.资源或其组件配置变更。</span>'},mousesuspension);
	$("#lamp-greenyelblackICO").bind("mouseout",mouseOutsuspension);
	$("#lamp-greenwhiteICO").bind("mouseover",{rem:'<span class="lampshine-blackbg-ico lampshine-blackbg-ico-greengray" ></span><span>1.当前资源可用；2.资源或其组件的性能出现问题，一个或多个性能指标未知；3.无配置变更。</span></span>'},mousesuspension);
	$("#lamp-greenwhiteICO").bind("mouseout",mouseOutsuspension);
	$("#lamp-greenwhiteblackICO").bind("mouseover",{rem:'<span class="lampshine-blackbg-ico lampshine-blackbg-ico-alert-greengray" ></span><span>1.当前资源可用；2.资源或其组件的性能出现问题，一个或多个性能指标未知；3.资源或其组件配置变更。</span>'},mousesuspension);
	$("#lamp-greenwhiteblackICO").bind("mouseout",mouseOutsuspension);
	$("#lamp-redICO").bind("mouseover",{rem:'<span class="lamp lamp-red" ></span><span>当前资源不可用。</span>'},mousesuspension);
	$("#lamp-redICO").bind("mouseout",mouseOutsuspension);
	$("#lamp-grayICO").bind("mouseover",{rem:'<span class="lamp lamp-gray" ></span><span>当前资源可用性未知。</span>'},mousesuspension);
	$("#lamp-grayICO").bind("mouseout",mouseOutsuspension);
	$("#ico-stopICO").bind("mouseover",{rem:'<span class="ico ico-stop" ></span><span>当前资源未监控。</span>'},mousesuspension);
	$("#ico-stopICO").bind("mouseout",mouseOutsuspension);
	
	$("#checkAllId").click(function() {
		if($(this).attr("checked")) {
			$("[name='checkOne']").attr("checked",'true');//全选
		}else {
			$("[name='checkOne']").removeAttr("checked");//取消全选
		}
  	});
  	
	$("#searchView").click(function (){
		var result = $("form").serialize();
		var url="${ctx}/roomDefine/DeviceOverviewVisit!searchDeviceMethod.action";
		ajaxSearchDeviceListFun(result,url);
	}); 
	 
	gp = new GridPanel({id:"deviceViewTableId",
	    unit:"%",
	    columnWidth:{/*resourceId:3,*/resourceState:5,devName:10,ipAddress:13,deviceType:8,jiguiNo:5,jikuangNo:5,deviceNo:5,notes:5,cpu:8,memory:8,interfaced:6,beiban:6,view:7,operator:9},
	    plugins:[SortPluginIndex],
            sortColumns:[{
    	        index: "devName",
    	        defSorttype: "up"
    	    },{
    	        index: "ipAddress"
    	    },{
    	    	index: "jiguiNo"
            },{
    	    	index: "deviceNo"
            }],
            sortLisntenr:function($sort){
	    	var sort=$sort.colId;
       	    var sortCol=$sort.sorttype;
    		$("#sortIdHidden").val(sort);
    		$("#sortColIdHidden").val(sortCol);
       	    //var resourceId = $("#resourceId").val();
       	    //var capacityId = $("#capacityId").val();
       	 	var page = $("#pageIdHidden").val();
       	 	if(null == page || "" == page){
           	    page = '<s:property value="curPageCount" />';
           	}
       	 var statusCss = $("#statusCssHidden").val();
       	 var result = $("form").serialize()+"&curPageCount=" + page  + "&colId=" + sort + "&sortType=" + sortCol+"&statusCss="+statusCss;
         var url = "${ctx}/roomDefine/DeviceOverviewVisit!searchDeviceMethod.action";
       	    var roomId = $("#roomIdHidden").val();
	            $.ajax({
	                type: "POST",
	                dataType: 'json',
	                data:result,
	             	url:url,
	                success: function(data, textStatus) {
	        			var resourceData = data.resourceData;
	        			gp.loadGridData(resourceData);
	                }
	            });
            },
			contextMenu:function(td){
		    }
        },{gridpanel_DomStruFn:"index_gridpanel_DomStruFn",gridpanel_DomCtrlFn:"index_gridpanel_DomCtrlFn",gridpanel_ComponetFn:"index_gridpanel_ComponetFn"}
        );
	gp.rend([/*{index:"resourceId",fn:function(td){
		if(td.html!="" && td.html!=" ") {
        	$checkbox = $('<input type="checkbox" style="cursor:pointer" name="checkOne" value="'+td.html+'"/>');
	        $checkbox.bind("click",function(){
		        	 //alert($(this).attr("checked"));
	         		 //alert($(this).val());
	        });
	    	return $checkbox;
        }else{
			return null;
        }
     	}
   		},*/{index:"resourceState",fn:function(td){
   			if(td.html!="" && td.html!=" ") {

   				var thval = td.html;
	            var arr= new Array();
	            if(thval != null && (thval.indexOf("##")!=-1)){
	            	arr = thval.split("##");
	            }

	            if(arr[0]==null || arr[0]=="null"){
     				return null;
                }
   	   			
   	   			if(td.html.indexOf("ico-stop")!= -1){
   	   				$span = $('<span name="stateSpan" class="ico '+arr[1]+'"  />');
   	   	   	   	}else{
   	   	   			$span = $('<span style="cursor:pointer" name="stateSpan" class="'+arr[1]+'" title="浏览状态详细信息" />');
		   	   	   	$span.bind("click",function(e){
						window.open(path+"/monitor/resourceStateDetail.action?instanceId="+arr[0],"_blank","width=630,height=538");
			   			}
			   		);	
      	   	   	}

   	   			return $span;
   	        }else{
   				return null;
   	        }
	        	
   	     	}
   	   	},{index:"devName",fn:function(td){
	   		if(td.html!="" && td.html!=" ") {

   				var thval = td.html;
	            var arr= new Array();
	            if(thval != null && (thval.indexOf("##")!=-1)){
	            	arr = thval.split("##");
	            }

	            if(arr[0]==null || arr[0]=="null"){
     				return null;
                }

	            var porinterStyle='';
				if (arr[2] != "ico ico-stop"){
					porinterStyle = 'style="cursor:pointer"';
				}
                
	            $span = $('<span '+porinterStyle+' name="devname" title="'+arr[1]+'">'+arr[1]+'</span>');
	            if (arr[2] != "ico ico-stop"){
		            $span.bind("click",function(e){
		            	var url = "${ctx}/detail/resourcedetail.action?instanceId=" + arr[0];
		                winOpen({url:url,width:980,height:600,scrollable:false,name:'resdetail_'+arr[0]});
						//window.open(path+"${ctx}/detail/resourcedetail.action?instanceId="+arr[0],"_blank","width=980,height=600");
			   			}
			   		);
	            }

	            return $span;
             }else{
				return null;
             }
   	   		}
		  },{index:"notes",fn:function(td){
				if (td.html!="" && td.html!=" "){
					var thval = td.html;
					/*
		            var arr= new Array();
		            if(thval != null && (thval.indexOf("##")!=-1)){
		            	arr = thval.split("##");
		            }
		            if(arr[0]==null || arr[0]=="null"){
		            	return null;
	                }
	                */

		            $span = $('<span class="ico ico-file" title="备注"></span>');

		            $span.bind("click",function(event){
		            	 var arr = td.html.split("##");
		   		        	var roomId = $('#roomIdHidden').val();
		   		        	
		   		        	if(panel){panel.close("close");}
		   		        	
		   		        	var widthVal=event.pageX+10; 
		   		        	var heightVal=event.pageY+10; 
		   		        	if(event.pageX+280 > document.documentElement.clientWidth){
		   		        		widthVal = document.documentElement.clientWidth-280;
		   		        	}
		   		        	if(event.pageY+400 > screen.height){
		   		        		heightVal = screen.height-400;
		   		        	}

							if(arr[1] == "-"){
								arr[1] = ""
							}
							   		        	
		   		        	if(arr[0]);
		   		    		 panel = new winPanel({
						        url:encodeURI("${ctx}/roomDefine/EditNote.action?deviceId=" + arr[0] +"&note=" + arr[1]),
						        width:280,
						        x:widthVal,
						        y:heightVal,
						        isDrag:false,
						        isautoclose: true, 
						        closeAction: "close",
						        listeners:{
						          closeAfter:function(){
							          panel = null;
							      },
							      loadAfter:function(){
							    		function cc(){
							    			if(window.panel){panel.close("close");}
							    		}
							    		$("#closepanelId").click(cc);
							    		$("#e_desc").focus().click(function(event){
							    			event.stopPropagation();
							    		});
							      }
						        }
			   				},{winpanel_DomStruFn:"blackLayer_winpanel_DomStruFn"});
			        });
				    return $span;
				}else{
					return null;
				}
			  }
		  },{index:"cpu",fn:function(td){
   	   			if(td.html!="" && td.html!=" ") {
					   	   	   			
	   	   			var thval = td.html;
		            var arr= new Array();
		            if(thval != null && (thval.indexOf("##")!=-1)){
		            	arr = thval.split("##");
		            }
		            if(arr[0]==null || arr[0]=="null"){
		            	return null;
	                }
	                if(arr[1]=="red"){
	                	
	                	$span = '<span style="text-align: left; width: 50%; display:inline-block;color:#ff0000;font-weight:700;">'+arr[0]+'</span>';
	                	$span += '<span  title="点击查看实时分析"  class="ico ico-percent" name="cpuAnalysis" instanceId="' + arr[2] + '"rowIndex="' + td.rowIndex + '"></span>';
		            }else if(arr[1]=="green"){
		            	$span = '<span style="text-align: left; width: 50%; display: inline-block; color: #00D605; font-weight: 700;">'+arr[0]+'</span>';
		            	$span += '<span title="点击查看实时分析"  class="ico ico-percent" name="cpuAnalysis" instanceId="' + arr[2] + '"rowIndex="' + td.rowIndex + '"></span>';
			        }else if(arr[1]=="yellow"){
			        	$span = '<span style="color:#FFFF00">'+arr[0]+'</span>';
				    }else{
				    	$span = '<span>'+arr[0]+'</span>';
					}
	                

	                
				    return $span;
   	   	   		}else{
					return null;
   	   	   	   	}	
   	   	 	}
   	   	},{index:"memory",fn:function(td){
   	   			if(td.html!="" && td.html!=" ") {
	   	   			var thval = td.html;
		            var arr= new Array();
		            if(thval != null && (thval.indexOf("##")!=-1)){
		            	arr = thval.split("##");
		            }
	
		            if(arr[0]==null || arr[0]=="null"){
		            	return null;
	                }
	                if(arr[1]=="red"){
	                	$span = '<span style="text-align:left;width:50%;display:inline-block;font-weight:700;color:#ff0000;" >'+arr[0]+'</span>';
	                	$span += '<span title="点击查看实时分析" class="ico ico-percent" name="cpuAnalysis" instanceId="' + arr[2] + '"rowIndex="' + td.rowIndex + '"></span>';
		            }else if(arr[1]=="green"){
		            	$span = '<span style="text-align: left; width: 50%; display: inline-block; color:#00D605; font-weight: 700;">'+arr[0]+'</span>';
		            	$span += '<span title="点击查看实时分析" class="ico ico-percent" name="cpuAnalysis" instanceId="' + arr[2] + '"rowIndex="' + td.rowIndex + '"></span>';
			        }else if(arr[1]=="yellow"){
			        	$span = '<span style="text-align: left; width: 50%; display: inline-block; color: #00D605; font-weight: 700;">'+arr[0]+'</span>';
			        	$span += '<span title="点击查看实时分析" class="ico ico-percent" name="cpuAnalysis" instanceId="' + arr[2] + '"rowIndex="' + td.rowIndex + '"></span>';
				    }else{
				    	$span = '<span>'+arr[0]+'</span>';
					}
	                
				    return $span;
   	   	   		}else{
					return null;
   	   	   	   	}	
   	   	 	}
   	   	},{index:"interfaced",fn:function(td){
	         if(td.html!="" && td.html!=" ") {
	             var thval = td.html;
	             var arr= new Array();
	             if(thval != null && (thval.indexOf("##")!=-1)) {
	              arr = thval.split("##");
	                   }
	                   if(arr[0]==null || arr[0]=="null" || arr[arr.length-1]=="ico ico-stop"){
	          				 return null;
	                      }
	                      if(arr[2]=='true'){
	              var $span = $('<span class="ico ico-interface" val="'+td.html+'"></span>');
	              $span.bind("click",function(e){
	               if (viewInterFace == null) {
	                          viewInterFace = new winPanel({
	                              type: "POST",
	                              url: path + "/monitor/resourceStateDetail!viewInterFace.action?instanceId="+arr[0],
	                              width: 440,
	                              x: e.pageX - 300,
	                              isautoclose: true,
	                              y: e.pageY,
	                              closeAction: "close",
	                              listeners: {
	                                  closeAfter: function() {
	                                      viewInterFace = null;
	                                  },
	                                  loadAfter: function() {
	                                  }
	                              }
	                          },
	                          {
	                              winpanel_DomStruFn: "blackLayer_winpanel_DomStruFn"
	                          });
	                      }  
	                    });
	              return $span;
	                      }else{
	                    return null;
	                   }
	                  }else{
	             return null;
	                  }
	                }
	        },{index:"ipAddress",fn:function(td){
   				if(td.html!="" && td.html!=" ") {
   	   				var ipStr = td.html+"";
   	   				//ipStr = ipStr.substring(2,ipStr.length-2);

   	   				var ipArr = ipStr.split(",");
   	   				
   	   				if (ipArr.length > 1){
   	   	   				var selectID="";
   	   	   				for(var thisNum=0;thisNum<ipArr[0].split(".").length;thisNum++){
   	   	   					selectID += ipArr[0].split(".")[thisNum];
   	   	   	   			}
   	   					$select = $('<select id="'+selectID+'" iconIndex="0" iconClass="ico ico-right" iconTitle=""></select>');
	   	   				for (var i=0;i<ipArr.length;i++){
	   	   					$("<option value='"+i+"'>"+ipArr[i]+"</option>").appendTo($select)//添加下拉框的option	
	   	   	   			}
	   	   	   			return $select;
   	   	   			}else{
   	   	   				$span = $('<span>'+ipArr[0]+'</span>');
  						return $span; 
   	   	   	   		}
   	   			}else{
   	   				return null;
   	   	   		}
   				
   	   			
   	   		}
   	   	},{index:"beiban",fn:function(td){
   			if(td.html!="" && td.html!=" ") {
   	   			
   				var $span = $('<span class="ico ico-backplane" val="'+td.html+'"></span>');
   				var thval = td.html;
   				var arr= new Array();
   				if(thval != null && (thval.indexOf("##")!=-1)) {
   					arr = thval.split("##");
   	   	   		}
   	   	   		
   	   	   		if(arr[0]==null || arr[0]=="null" || arr[2]=="ico ico-stop" ){
					return null;
   	   	   	   	}
   				$span.bind("click",function(event){
   					winOpen({url:"/netfocus/netfocus.do?action=optservice@getnode&nodeId="+ arr[0]+"&forward=/modules/flash/backboard.jsp",width:1000,height:610,name:'backboard'});	   				
   		        });
   				return $span;
   	        }else{
   				return null;
   	        }
   	     	}
		},{index:"view",fn:function(td){
   			if(td.html!="" && td.html!=" ") {
   				var $span = $('<span class="ico ico-vm" val="'+td.html+'"></span>');
   				var thval = td.html;
   				var arr= new Array();
   				if(thval != null && (thval.indexOf("##")!=-1)) {
   					arr = thval.split("##");
   	   	   		}
   	   	   		if(arr[0]==null || arr[arr.length-1]=="ico ico-stop"){
					return null;
   	   	   	   	}
   	   	  		$span.bind("click",function(event){
					winOpen({url:arr[0],width:1000,height:900,name:'visual'});	   				
		        });
		        if (arr[2]=="true"){
			        
		        	return $span;
			    }else{
					return null;
				}
   				
   	        }else{
   				return null;
   	        }
   	     	}
		},{index:"operator",fn:function(td){
   			if(td.html!="" && td.html!=" ") {
   	   			var arr =td.html.split("##"); 
   	   			if (arr[arr.length-1]=="ico ico-stop"){
					return null;
   	   	   		}
   	        	var $span = $('<span class="ico ico-t-right" name="stateSpan" val="'+td.html+'"/>');
   		        $span.bind("click",function(e){
   		        	var temp = $(this).attr("val");
   		        	var arr= new Array();
   	   				if(temp != null && (temp.indexOf("##")!=-1)) {
   	   					arr = temp.split("##");
   	   	   	   		}
   	   				instanceId = arr[0];
   	   				ip = arr[1];
   	   				nodeId = arr[2];
   	   				locationId = arr[3];
   		        	roomMenu.addMenuItems(roomEquipmentArray);
   		         roomMenu.position(e.clientX - 170, e.clientY);
   		        });
   		    
		        
   		    	//return $span;
   		    	return $span;
   	        }else{
   				return null;
   	        }
   	     	}
		}
	   ]);	
	//SimpleBox.renderAll();
});

function ajaxSearchDeviceListFun(result,url) {
	$.ajax({
		type: "post",
		dataType:'json', //接受数据格式 
		cache:false,
		data:result, 
		url: url,
		beforeSend: function(XMLHttpRequest){
		//ShowLoading();
		},
		success: function(data, textStatus){
			var resourceData = data.resourceData;
			page.pageing(data.pageCount,1);
			gp.loadGridData(resourceData);
		},
		complete: function(XMLHttpRequest, textStatus){
		//HideLoading();
		},
		error: function(){
		//请求出错处理
			alert("error");
		}
		});
}

var panel = null;
function mousesuspension(event){
	panel = new winPanel({
		        html:event.data.rem,
		        width:300,
		        isDrag:false,
		        x:event.clientX+10,
		        y:event.clientY+20
		},{
		winpanel_DomStruFn:"blackLayer_winpanel_DomStruFn"
		}); 

	
}
function mouseOutsuspension(event){
	if (panel != null){
		panel.close();
	}
}

//cpu和内存利用率实时分析层调用
var avgCpuRTAnalysis;

$("#deviceViewTableId span[name='cpuAnalysis']").bind('click',function(e) { 
	var self = this;
	var icoId = $(this).attr("instanceId");
    var rowIndex = $(this).attr("rowIndex");
	if (this.avgCpuRTAnalysis == null) {
	    this.avgCpuRTAnalysis = new winPanel({
	        type: "POST",
	        url: path + "/report/real/realManage!loadMonitorFlash.action",
	        width: 420,
	        x: e.pageX - 300,
	        isautoclose: true,
	        y: e.pageY,
	        closeAction: "close",
	        listeners: {
	            closeAfter: function() {
	             stopRefresh();
	                self.avgCpuRTAnalysis = null;
	            },
	            loadAfter: function() {
	              var documentHeight = document.body.clientHeight;
	                 var panelY = e.pageY+5;
	                 var panelHeight = self.avgCpuRTAnalysis.getHeight();
	                 if( panelHeight+panelY > documentHeight){
	                     panelY = e.pageY-5-panelHeight;
	                 }
	                 self.avgCpuRTAnalysis.setY(panelY);
	                 popShowFlash("DeviceAvgCPUUtil",icoId,"cpu利用率(%)实时分析","%");
	            }
	        }
	    },
	    {
	        winpanel_DomStruFn: "blackLayer_winpanel_DomStruFn"
	    });
	}
});

</script>