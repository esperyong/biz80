<!-- WEB-INF\content\location\relation\network.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mocha.bsm.location.enums.EquipmentTypeEnum" %>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<%@ include file="/WEB-INF/common/meta.jsp" %>

<form id="form1">
<s:hidden name="location.locationId" />
<div class="font-white">
<span>请选择关联的拓扑：<s:select name="location.focusMapId" id="location_focusMapId" value="location.focusMapId" list="networks" listKey="mapId" listValue="mapName" headerKey="" headerValue="请选择" onchange="selectFocusMap()"></s:select>
<span class="gray-btn-l"><span class="btn-r"><span class="btn-m" id="stop"><a>重置</a></span></span></span>
<span class="gray-btn-l"><span class="btn-r"><span class="btn-m" id="save"><a>保存</a></span></span></span>
</span>
</div>
<div>
<iframe id="netFocus" src="/netfocus/modules/flash/node_doubleclick_openmap.jsp?mapId=${location.focusMapId}"
	scrolling="no" frameborder="0" marginheight="0" marginwidth="0" width="100%" height="100%" allowtransparency="true" style="position:absolute;left:0px;background-color:transparent;"></iframe>
</div>

</form>

<script type="text/javascript">
var toast=null;
$(document).ready(function () {
		toast = new Toast({position:"CT"});
	});
	
	function selectFocusMap(){
		$("#netFocus").attr("src","/netfocus/modules/flash/node_doubleclick_openmap.jsp?mapId="+$("#location_focusMapId").val());	
	}
	

	$("#stop").click(function(){
		//$("#form1")[0].reset();
		$("#location_focusMapId").attr("value","");
		$.ajax({
			url:		"${ctx}/location/relation/network!updateFocusMapId.action?location.focusMapId=",
			data:		$("#form1").serialize(),
			dataType:	"json",
			cache:		false,
			success:	function(data, textStatus){
				
					toast.addMessage("重置成功。");
					$("#netFocus").attr("src","/netfocus/modules/flash/node_doubleclick_openmap.jsp?mapId=")
				
			}
		});
	});
	
	$("#save").click(function(){
		
		$.ajax({
			url:		"${ctx}/location/relation/network!updateFocusMapId.action",
			data:		$("#form1").serialize(),
			dataType:	"json",
			cache:		false,
			success:	function(data, textStatus){
				if(data.location &&  data.location.focusMapId){
					toast.addMessage("保存成功。");
					//$("#netFocus").attr("src","/netfocus/modules/flash/node_doubleclick_openmap.jsp?mapId="+$("#location_focusMapId").val())
				} else {
					toast.addMessage("请选择关联拓扑后再保存。");
				}
			}
		});
	});

</script>