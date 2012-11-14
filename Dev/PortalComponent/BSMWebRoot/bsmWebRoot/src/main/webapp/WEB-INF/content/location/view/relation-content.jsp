<!-- WEB-INF\content\location\view\relation-content.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<s:if test="location.type!=@com.mocha.bsm.location.enums.LocationTypeEnum@LOCATION_DOMAIN.key">
</s:if>
<ul class="sub">
	<li class="subtitle">设备列表</li>
	<li class="subcontent">
		<img id="devices" src="${ctxImages}/devices.JPG " style="cursor:hand"><!--图片宽度需在160*90以内-->
	</li>
</ul>

<s:if test="netLicense=='yes'">
	<s:if test="location.type==@com.mocha.bsm.location.enums.LocationTypeEnum@LOCATION_FLOOR.key ||
	 location.type==@com.mocha.bsm.location.enums.LocationTypeEnum@LOCATION_OFFICE.key || 
	 location.type==@com.mocha.bsm.location.enums.LocationTypeEnum@LOCATION_ROOM.key">
	
	<ul class="sub">
		<li class="subtitle">二层网络拓扑图</li>
		<li class="subcontent">
			
				<s:if test="location.focusMapId!=null">
					<img id="netMap" src="${ctxImages}/netMap.JPG" style="cursor:hand"><!--图片宽度需在160*90以内-->
				</s:if>
				<s:else>
					没有关联拓扑
				</s:else>
		</li>
	</ul>
	</s:if>

<!--
	<ul id="roomUl" class="sub" style="display:none">
		<li class="subtitle">二层网络拓扑图</li>
		<li class="subcontent">
					<img id="roomNetMap" src="${ctxImages}/netMap.JPG" style="cursor:hand;display:none;">
					<span id="noRoomMap" style="display:none;">没有关联拓扑</span>
		</li>
	</ul>
	-->
</s:if>

<s:if test="location.type==@com.mocha.bsm.location.enums.LocationTypeEnum@LOCATION_FLOOR.key">
<ul class="sub">
	<li class="subtitle">布电图</li>
	<li class="subcontent">
		<s:set name="location" value="location"/>
		<s:bean name="com.mocha.bsm.action.location.relation.ElectricityMapAction" var="eleMap">
			<s:param name="location" value="location"/>
			<s:if test="getLoctiontPictureFile()!=null">
				<img id="picture" src="${ctx}/location/relation/electricityMap!downloadPicture.action?location.locationId=${location.locationId}" width="160" height="90" style="cursor:hand">
			</s:if>
			<s:else>
				没有布电图
			</s:else>
		</s:bean>
	</li>
</ul>
</s:if>
<script type="text/javascript">
	//浏览器宽度
 var sw = document.body.scrollWidth;
 var dwidth = 830;
 var xw = (sw-dwidth)/2
var panel;
$(document).ready(function () {
	$(document).ready(function () {
		var win;
		/*
		if("${location.type}" == "location_room"){
			$.ajax({
            type: "POST",
            dataType: 'json',
            data: "locationId=${location.locationId}",
            url: "${ctx}/location/relation/relationRoomDevice!mapIdByRoom.action",
            success: function(data, textStatus) {
    			if(data.focusMapId != null && data.focusMapId != ""){
        			$("#roomUl").show();
        			$("#roomNetMap").show();
        			$("#roomNetMap").click(function(){
        				panel = new winPanel({
        			        url:"/netfocus/modules/flash/node_doubleclick_openmap.jsp?mapId="+data.focusMapId,
        			        width:dwidth,
        			        height:500,
        					color:"#383838",
        			        x:xw,
        			        y:30,
        			        isDrag:false,
        					isautoclose:true
        				},{winpanel_DomStruFn:"blackLayer_winpanel_DomStruFn"});
        			});
        		}else{
					$("#roomUl").show();
					$("#noRoomMap").show();
				}
            }
        });

		}
		*/
		
		$("#devices").click(function(){
		
		
		if("${location.type}"=="<%=com.mocha.bsm.location.enums.LocationTypeEnum.LOCATION_ROOM.getKey()%>" && "${location.flashType}" != "2D"){
			dwidth=dwidth-50;
			var r_value = window.showModalDialog("${ctx}/location/relation/device!devices.action?resType=&location.locationId=${location.locationId }",window,"help=no;status=no;scroll=no;center=yes;dialogWidth="+dwidth+"px;dialogHeight=360px");
		//win=window.open("${ctx}/location/relation/device!devices.action?resType=&location.locationId=${location.locationId }","open_image_1");
			return;
			}
			if("${location.flashType}" == "<%=com.mocha.bsm.location.enums.LocationMapTypeEnum.MAP3D.getKey()%>"){
			dwidth=dwidth-50;
			var r_value = window.showModalDialog("${ctx}/location/relation/device!devices.action?resType=&location.locationId=${location.locationId }",window,"help=no;status=no;scroll=no;center=yes;dialogWidth="+dwidth+"px;dialogHeight=360px");
			//window.open("${ctx}/location/relation/device!devices.action?resType=&location.locationId=${location.locationId }","open_image_1","width=dwidth,height=360");
			return;
			}
			panel = new winPanel({
		        url:"${ctx}/location/relation/device!devices.action?resType=&location.locationId=${location.locationId }",
		        width:dwidth,
        	color:"#383838",
        		x:xw,
        		y:50,
		        isDrag:false,
				isautoclose:true
			},{winpanel_DomStruFn:"blackLayer_winpanel_DomStruFn"});
				
			
		});

		
		
		$("#netMap").click(function(){
			if("${location.type}"=="<%=com.mocha.bsm.location.enums.LocationTypeEnum.LOCATION_ROOM.getKey()%>" && "${location.flashType}" != "2D"){
			dwidth=dwidth-50;
			var r_value = window.showModalDialog("/netfocus/modules/flash/node_doubleclick_openmap.jsp?mapId=${location.focusMapId}",window,"help=no;status=no;scroll=no;center=yes;dialogWidth="+dwidth+"px;dialogHeight=500px");
			return;
			}
			if("${location.flashType}" == "<%=com.mocha.bsm.location.enums.LocationMapTypeEnum.MAP3D.getKey()%>"){
			dwidth=dwidth-50;
			var r_value = window.showModalDialog("/netfocus/modules/flash/node_doubleclick_openmap.jsp?mapId=${location.focusMapId}",window,"help=no;status=no;scroll=no;center=yes;dialogWidth="+dwidth+"px;dialogHeight=500px");
			return;
			}
			if("${location.type}" == "location_room"){
				$.ajax({
	            type: "POST",
	            dataType: 'json',
	            data: "locationId=${location.locationId}",
	            url: "${ctx}/location/relation/relationRoomDevice!mapIdByRoom.action",
	            success: function(data, textStatus) {
	    					if(data.focusMapId != null && data.focusMapId != ""){
	        				panel = new winPanel({
	        			        url:"/netfocus/modules/flash/node_doubleclick_openmap.jsp?mapId="+data.focusMapId,
	        			        width:dwidth,
	        			        height:500,
	        					color:"#383838",
	        			        x:xw,
	        			        y:30,
	        			        isDrag:false,
	        					isautoclose:true
	        				},{winpanel_DomStruFn:"blackLayer_winpanel_DomStruFn"});
	               }
	          	 }
				});
			}else{
				panel = new winPanel({
			        url:"/netfocus/modules/flash/node_doubleclick_openmap.jsp?mapId=${location.focusMapId}",
			        width:dwidth,
	        		height:500,
	        		color:"#383838",
	        		x:xw,
	        		y:30,
			        isDrag:false,
					isautoclose:true
					},{winpanel_DomStruFn:"blackLayer_winpanel_DomStruFn"});
				}
			});
				
			
		
		
		$("#picture").click(function(){
			if("${location.type}"=="<%=com.mocha.bsm.location.enums.LocationTypeEnum.LOCATION_ROOM.getKey()%>" && "${location.flashType}" != "2D"){
			dwidth=dwidth-50;
			var r_value = window.showModalDialog("${ctx}/location/relation/electricityMap!showRelationMap.action?location.locationId=${location.locationId }",window,"help=no;status=no;scroll=no;center=yes;dialogWidth="+dwidth+"px;dialogHeight=500px");
			return;
			}
			if("${location.flashType}" == "<%=com.mocha.bsm.location.enums.LocationMapTypeEnum.MAP3D.getKey()%>"){
			dwidth=dwidth-50;
			var r_value = window.showModalDialog("${ctx}/location/relation/electricityMap!showRelationMap.action?location.locationId=${location.locationId }",window,"help=no;status=no;scroll=no;center=yes;dialogWidth="+dwidth+"px;dialogHeight=500px");
			return;
			}
			panel = new winPanel({
		        url:"${ctx}/location/relation/electricityMap!showRelationMap.action?location.locationId=${location.locationId }",
		        width:dwidth,
		        x:xw,
		        y:30,
		        isDrag:false,
				isautoclose:true
			},{winpanel_DomStruFn:"blackLayer_winpanel_DomStruFn"});
				
		});
	});
});
</script>