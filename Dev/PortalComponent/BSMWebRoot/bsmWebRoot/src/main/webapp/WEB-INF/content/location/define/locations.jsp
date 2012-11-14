<!-- EB-INF\content\location\define\locations.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<%@ include file="/WEB-INF/common/loading.jsp" %>
<!-- 全部物理位置  WEB-INF\content\location\define\locations.jsp -->
	<div id="layoutwestId" style="height:100%;overflow:hidden">
		<div class="left-panel-open" id="leftId">
			<div class="left-panel-l" id="leftpanelId">
				<div class="left-panel-r">
					<div class="left-panel-m">
						<span class="left-panel-title">物理位置定义</span>
					</div>	
				</div>
			</div>
			<div class="left-panel-content" style="height:100%;">
				<div class="location-panel-content">
					<div class="add-button1"><span title="添加" class="r-ico r-ico-add"></span><span title="导入" class="ico ico-import right"></span></div>
					<div style="height:590px;width:200px">
					<div id="treeDiv" style="overflow-x:auto;overflow-y:auto;height:100%;margin:4px;width:195px;">
			<s:set name="treeName" value="'LocationTree'"/>
			<s:if test="!locations.isEmpty()">
				<s:bean var="nodeStyle" name="com.mocha.bsm.action.location.define.util.LoctionDefineStyle"/>
				<s:bean var="treeHelper" name="com.mocha.bsm.action.location.define.util.LocationTreeHelper">
					<s:param name="nodeStyle" value="#nodeStyle"/>
					<s:property value="getTreeHtml(#treeName,locations)" escape="false"/>
				</s:bean>
			</s:if>
			<s:else>
					<div class="add-button2"><span>请点击 <img src="${ctx}/images/add-button1.gif"> 按钮新建一个区域</span></div>
			</s:else>
					</div></div>
				  	<div class="clear"></div>
				</div>
			</div>
		</div>
	</div>
	
<script type="text/javascript">
	var tree;
	$(document).ready(function () {
	//$('#treeDiv').parent().height(document.body.offsetHeight-142);
	$("#layoutwestId")[0].style.height="100%";
	$("#leftId").width(220).css("height","100%");
	
		$("#layoutwestId").width(220);
		$("#leftpanelId").height(40);
		$("#leftId").width(215);
		$(".ico.ico-import").click(function(){
			var r_value = window.showModalDialog("${ctx}/location/relation/importDevices.action",window,"help=no;status=no;scroll=no;center=yes");
			loadLocations();
		});
		$(".r-ico.r-ico-add").click(createDomain);


		// 指定树的事件
		tree = new Tree({id:"${treeName}",listeners:{
		  nodeClick:function(node){
			  $.ajax({
					url: 		"${ctx}/location/define/location!getLocationById.action",
					data:		"location.locationId="+node.getId(),
					dataType: 	"json",
					cache:		false,
					success: function(data, textStatus){
						if(data.location.type=="<%=com.mocha.bsm.location.enums.LocationTypeEnum.LOCATION_ROOM.getKey()%>"){
							$("#handles").find("*").unbind();

							var str='<div class="h1 font-white" style="font-weight:700;width:520px; margin:170px auto;"><input type="hidden" id="noid" value="'+node.getId()+'"/><a href="javascript:synchroDate()"><img id="uploadtemplate" src="${ctx }/images/alpha-button-synchro.png" border="0"></a><p class="alpha" style="margin-top:10px;">点击按钮“同步机房的关联设备”，将机房已定义数据同步带物理位置中，并在物理位置一览进行查看。</p><br/><p class="alpha" style="margin-top:10px;">注意：如果要对机房数据进行编辑，请到“全景机房-机房定义”中进行操作。</p></div>';
							$("#handles").html(str);
							//$("#handles").html("<div class='h1 font-white' style='font-size:50px;font-weight:700;width:300px; margin:230px auto;'><span class=\"bold\">请在\"机房管理-机房定义11\"中编辑此机房信息。</span></div>");
							$("#content").find("*").unbind();
							$("#content").html("");
						} else {
							loadHandles(node.getId());
						}
					}
			  });
			  
		  }
		
		  ,
		  toolClick:function(node){
		  	  if(node.parent().getId()=="root"){
			  mc.position(event.x,event.y)
			  mc.addMenuItems([[{ico:"delete",text:"删除",id:"del",listeners:{
					click:function(){
				  		$(".buttonmenu").hide();
						delLocation(node.getId());
					  }
				}},{ico:"add",text:"编辑",id:"edit",listeners:{
					click:function(){
						$(".buttonmenu").hide();
						updateLocation(node.getId())
					  }
				}},{ico:"export",text:"导出物理位置拓扑",id:"export",listeners:{
					click:function(){
					$(".buttonmenu").hide();
					exportLocation(node.getId());
				  }
				}},{ico:"import",text:"导入物理位置拓扑",id:"import",listeners:{
				click:function(){
					$(".buttonmenu").hide();
					importNoteMap(node.getId());
				  }
				}}/*,{ico:"add",text:"新建子区域",id:"edit",listeners:{
					click:function(){
						createLocation(node.getId())
					  }
				}}*/
				]]);
				}
		  }
		  }}); 

		
	});

	function exportLocation(locationId){
			window.location.href="${ctx}/location/design/locationExport!exports.action?locationId="+locationId;
		}	
	// 设置默认选中节点
	function setCurrentNode(locationId){
		var node=tree.getNodeById(locationId);
		node.setCurrentNode();
		node.expend();
		
	}


	function synchroDate(){
		$.blockUI({message:$('#loading')});
			$.ajax({
			url: 		"${ctx}/location/relation/relationRoomDevice!relationDevices.action",
			data:		"locationId="+$("#noid").val(),
			dataType: 	"json",
			cache:		false,
			success: function(data, textStatus){
				$.unblockUI();
				showMess("同步成功！");
				//var noid = $("#noid").val();
				//$("li[nodeid='"+noid+"']").click();
			},error: function(e){
        			alert(e);
        		}
			
	  });
		}
	function showMess(str){
		var toast = new Toast({position:"CT"});
		toast.addMessage(str);
	}
	
	function clickSpean(){
		loadLocations();
	}
	
</script>