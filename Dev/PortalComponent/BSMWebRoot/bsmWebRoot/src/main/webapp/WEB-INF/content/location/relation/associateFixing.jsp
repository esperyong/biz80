<!-- WEB-INF\content\location\relation\associateFixing.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page import="com.mocha.bsm.location.enums.EquipmentTypeEnum" %>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<%@ include file="/WEB-INF/common/meta.jsp"%>
<s:set name="pageIndex" value="1"/>
<s:set name="pageSize" value="15"/>
<script type="text/javascript">

	var networkType = "<%=EquipmentTypeEnum.networkdevice %>";
	var serverType = "<%=EquipmentTypeEnum.host_server %>";
	var pcType = "<%=EquipmentTypeEnum.host_pc%>";
	var resType = networkType;
	var tp = null;
	$(document).ready(function () {

		tp = new TabPanel({id:"mytab",isclear:true,
				listeners:{
			        change:function(tab){
						$.blockUI({message:$('#loading')});
				        resType = tab.id=="networkdevice"?networkType
				        		 :tab.id=="server"?serverType
				        		 :tab.id=="pc"?pcType:pcType;
				        loalDevices(resType,false);
			        }
	        	}}
				); 
	});
	
	// 重新加载关联设备
	function loalDevices(type,isChange){
		var index = type==networkType? 1 
					:type==serverType? 2
					:type==pcType? 3 : 1;
		tp.loadContent(index,
						{url:"${ctx}/location/relation/device!devices.action"
							+"?location.locationId=" + locationId + "&resType=" + type
							+ "&pageData.pageIndex=" + ${pageIndex}
							+ "&pageData.pageSize=" + ${pageSize},callback:$.unblockUI},
						isChange);
	}

	function showMess(str){
		var toast = new Toast({position:"CT"});
		toast.addMessage(str);
	}
	
</script>
<page:applyDecorator name="tabPanel">
	<page:param name="id">mytab</page:param>
	<page:param name="width">100%</page:param>
	<page:param name="height">100%</page:param>
	<page:param name="tabBarWidth">420</page:param>
	<page:param name="cls">tab-grounp</page:param>
	<page:param name="current">1</page:param>
	<page:param name="tabHander">[{text:"网络设备",id:"networkdevice"},{text:"服务器",id:"server"},{text:"PC",id:"pc"}]</page:param>
<!-- s:if test="equipments!=null&&equipments.size>0" -->
	<page:param name="blackButton">[{text:"批量添加",id:"batchAdd"},{text:"添加",id:"add"},{text:"导入",id:"import"},{text:"导出",id:"export"},{text:"删除",id:"delete"},{text:"批量编辑",id:"batchEdit"}]</page:param>
	<page:param name="content_1">
		<s:action name="device!devices" namespace="/location/relation"
			executeResult="true" ignoreContextParams="true">
			<s:param name="pageData.pageIndex" value="#pageIndex"></s:param>
			<s:param name="pageData.pageSize" value="#pageSize"></s:param>
		</s:action>
<script type="text/javascript">
	$(document).ready(function () {
	    $("#add").click(function(){
	    	window.open("${ctx}/location/relation/device!add.action?location.locationId="+locationId);
	    });
	    $("#batchAdd").click(function(){
	    	window.open("${ctx}/location/relation/device!batchAdd.action?location.locationId="+locationId);
	    });
	    $("#batchEdit").click(function(){
	    	var $equipmentIds=$("input[name='equipmentIds']:checked");
	    	if($equipmentIds.length>0){

	    		window.open("${ctx}/location/relation/device!batchEdit.action?location.locationId="+locationId+"&"+$equipmentIds.serialize());
	    	} else {
	    		showMess("请至少选择一项");
	    	}
	    });
	    $("#delete").click(function(){
	    var $equipmentIds=$("input[name='equipmentIds']:checked");
	    	if($equipmentIds.length>0){
	    		var confirm_batdel = new confirm_box({text:"该操作不可恢复，是否确认删除？"});
	    		confirm_batdel.show();
	    		confirm_batdel.setConfirm_listener(function(){
	    		confirm_batdel.hide();
		    	$.ajax({
					url: 		ctx + "/location/relation/device!delete.action",
					data:		"location.locationId="+locationId + "&" + $("input[name='equipmentIds']:checked").serialize(),
					dataType: 	"html",
					cache:		false,
					success: function(data, textStatus){
		    		showMess("删除成功");
						loalDevices(resType,false)
					}
		    	});
		    	confirm_batdel.setCancle_listener(function(){
		    		confirm_batdel.hide();
				});
			});
			}else{
				showMess("请至少选择一项");
			}
	    });
	    $("#import").click(function(){
	    	var r_value = window.showModalDialog("${ctx}/location/relation/importDevices.action?location.locationId="+locationId,null,"help=no;status=no;scroll=no;center=yes");
			loadLocations();
	    });
	    
	    $("#export").click(function(){
	    	
	    	var elemIF = document.createElement("iframe");   
	    	elemIF.src = "${ctx}/location/relation/device!exportExcel.action?location.locationId="+locationId+"&resType="+resType+"&"+$("input[name='equipmentIds']:checked").serialize();
	    	elemIF.style.display = "none";   
	    	document.body.appendChild(elemIF);
	    	window.setTimeout(function(){
	    		document.body.removeChild(elemIF);
	    	},1000)
	    });
	});
	
</script>
	</page:param>
<%-- /s:if -->
<s:else>
	<page:param name="content_1">
	<div>
	    <p class="alpha"  id="batchAdd1">
	    	<img src="${ctx }/images/alpha-icon.gif" align="absmiddle">&nbsp;选择已有设备</p>
	    	<ul class="font-white">
	    		<li>选择已发现的设备，并编辑设备的位置信息和工位号，所属用户等信息。</li>
	    	</ul>
	    <br />
		<p class="alpha" id="uploadtemplate">
			<img src="${ctx }/images/alpha-icon.gif" align="absmiddle">&nbsp;导入设备。</p>
			<ul class="font-white">
	    		<li>使用Excel导入设备，并同时根据Excel内容创建子区域。导入的设备可以匹配已发现的设备。</li>
	    	</ul>
	</div>
	<script type="text/javascript">
		$(document).ready(function () {
			$("#uploadtemplate").click(function(){
				var r_value = window.showModalDialog("${ctx}/location/relation/importDevices.action",null,"help=no;status=no;scroll=no;center=yes");
				location.reload();
			});
			$("#batchAdd1").click(function(){
				window.showModalDialog("${ctx}/location/relation/device!batchAdd.action?location.locationId="+locationId);
				loadContent("${ctx}/location/relation/device!showAssociateFixing.action");
			});
		});
	</script>
	</page:param>
</s:else>
 --%>
	<page:param name="content_2">
	</page:param>
	<page:param name="content_3">
	</page:param>
</page:applyDecorator>