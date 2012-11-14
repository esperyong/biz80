<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<%@ include file="/WEB-INF/common/meta.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript" src="${ctx}/flash/swfobject.js"></script>
<script type="text/javascript" src="${ctxJs}/component/comm/winopen.js"></script>
<body style="background-color:transparent">
	<!-- flash-->
	<div id="bizsm" style="width:100%;height:100%">
	<p>To view this page ensure that Adobe Flash Player version 10.0.0
	or greater is installed.</p>
	<script type="text/javascript"> 
			//加载悬浮flash
			<!-- For version detection, set to min. required Flash Player version, or 0 (or 0.0.0), for no version detection. --> 
            var swfVersionStr = "10.0.0";
            <!-- To use express install, set to playerProductInstall.swf, otherwise the empty string. -->
            var xiSwfUrlStr = "${ctx}/flash/playerProductInstall.swf";
            //alert(xiSwfUrlStr);
            var flashvars = {};
            var params = {};
            params.quality = "high";
            params.bgcolor = "#202020";
            params.allowscriptaccess = "sameDomain";
            params.allowfullscreen = "true";
            params.isBrowse = "true";
            params.allowfullscreen = "true";
            params.wmode = 'transparent';
            flashvars.isBrowse="true";
            flashvars.serviceId="<s:property value='serviceId'/>";
            flashvars.serverPath="<%=request.getScheme() + "://" + request.getServerName()
        		+ ":" + request.getServerPort()%>${ctx}/room/RoomUnifyServlet";
            var attributes = {};
            attributes.id = "MachineTopologyService";
            attributes.name = "MachineTopologyService";
            attributes.align = "middle";
            
            swfobject.embedSWF(
                "${ctx}/flash/MachineTopologyService.swf", "bizsm", 
                "100%", "100%", 
                swfVersionStr, xiSwfUrlStr, 
                flashvars, params, attributes);
			<!-- JavaScript enabled so display the flashContent div in case it is not replaced with a swf object. -->
	</script></div>
</body>

<script type="text/javascript"> 
//详细信息页面调用
function resourceDetail(resId,type,parentId){
	var url
	var thisWidth = screen.availWidth-100;
	if (type=="equipment"){
		url = "${ctx}/detail/resourcedetail.action?instanceId=" + resId;
		  winOpen({url:url,width:980,height:600,scrollable:false,name:'resdetail_'+resId});  
	}else if(type=="room"){
		url = "${ctx}/roomDefine/MonitorVisit!showRoom.action?roomId=" + resId+"&topOffset=0";
		window.open(url,null,"width="+thisWidth+",height=600,top=20,left=20");
	}else if(type=="jigui"){
		url = "${ctx}/roomDefine/MonitorVisit!showRoom.action?roomId=" + parentId+"&topOffset=0&nodeId="+resId;
		window.open(url,null,"width="+thisWidth+",height=600,top=20,left=20");
	}
}

</script>





