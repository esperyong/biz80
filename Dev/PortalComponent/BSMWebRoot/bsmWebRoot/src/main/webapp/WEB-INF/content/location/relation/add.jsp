<!-- WEB-INF\content\location\relation\add.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mocha.bsm.location.enums.EquipmentTypeEnum" %>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base target="_self">
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>添加设备</title>
<link href="${ctxCss}/master.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/public.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/UIComponent.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/validationEngine.jquery.css" rel="stylesheet" type="text/css" media="screen" title="no title" charset="utf-8" />
<script src="${ctxJs}/jquery-1.4.2.min.js" type="text/javascript"></script>
<script src="${ctxJs}/jquery.select.js" type="text/javascript"></script>
<script src="${ctxJs}/jquery.validationEngine-cn.js" type="text/javascript"></script>
<script src="${ctxJs}/jquery.validationEngine.js" type="text/javascript"></script>
<script type="text/javascript">
<s:if test="#request.succeed == true">
	//新建区域完成，刷新父页面
	if(opener && opener.loadContent){
		opener.loadContent("${ctx}/location/relation/device!showAssociateFixing.action");
	}
	window.close();
</s:if>
</script>
</head>

<body >
<page:applyDecorator name="popwindow"  title="添加设备">
	
	<page:param name="width">400px</page:param>
	<page:param name="topBtn_index_1">1</page:param>
	<page:param name="topBtn_id_1">closeId</page:param>
	<page:param name="topBtn_css_1">win-ico win-close</page:param>
	
	<page:param name="bottomBtn_index_1">1</page:param>
	<page:param name="bottomBtn_id_1">submit</page:param>
	<page:param name="bottomBtn_text_1">确定</page:param>
	
	<page:param name="bottomBtn_index_2">2</page:param>
	<page:param name="bottomBtn_id_2">cancel</page:param>
	<page:param name="bottomBtn_text_2">取消</page:param>
	
	<page:param name="content">
	<s:form id="addForm" action="/location/relation/device!add.action">
		<s:hidden name="equipment.domain" id="domain"/>
		<s:hidden name="equipment.id" id="equipment_id"/>
		<s:hidden name="equipment.resurceType" id="equipment_resurceType"/>
		<ul class="fieldlist-n">
			<li class="gray-bottom"><s:radio name="add_type" list="#{'add':'新增设备','select':'选择已有设备'}" listKey="key" listValue="value"/></li>
			<li id="equipType"><span class="field">设备类型</span>
				<s:select id="resurceType"
				list="#{'network':'网络设备','pc':'服务器/PC'}" cssStyle="width:131px;"></s:select></li>
			<li id="selpc" style="display:none;"><span class="field">服务器/PC</span>&nbsp;
				 <s:select id="pc" list="hostMap" listKey="key" listValue="value" cssStyle="width:131px;"></s:select></li>
			<li id="selnetwork"><span class="field">网络设备</span> 
				 <s:select id="network" list="networkMap" listKey="key" listValue="value" cssStyle="width:131px;"></s:select></li>
			<li><span class="field">设备名称</span>
				<s:textfield name="equipment.equipName" id="equipment_equipName" cssClass="validate[required]"></s:textfield><span class="red">*</span><span title="选择设备" class="ico" style="background-image:url('${ctx}/images/ico/chaxunt.gif');"></span></li>
			<li><span class="field">设备IP</span>&nbsp;
				<s:textfield name="equipment.ip" id="equipment_ip" cssClass="validate[required,ipAddress]"></s:textfield><span class="red">*</span></li>
			<li><span class="field">MAC地址</span>
				<s:textfield name="equipment.mac" id="equipment_mac"></s:textfield></li>
			<li><span class="field">地区</span>
				<s:select name="equipment.area" id="area" list="#{'':'请选择'}" cssStyle="width:131px;"></s:select></li>
			<li><span class="field">大楼</span>
				<s:select name="equipment.builder" id="builder" list="#{'':'请选择'}" cssStyle="width:131px;"></s:select></li>
			<li><span class="field">楼层</span>
				<s:select name="equipment.floor" id="floor" list="#{'':'请选择'}" cssStyle="width:131px;"></s:select></li>
			<li><span class="field">房间</span>
				<s:select name="equipment.room" id="room" list="#{'':'请选择'}" cssStyle="width:131px;"></s:select></li>
			<li><span class="field">上联IP</span>&nbsp;
				<s:textfield name="equipment.upIp" id="upIp"></s:textfield></li>
			<li><span class="field">上联端口</span>
				<s:textfield name="equipment.upPort"></s:textfield></li>
			<li><span class="field">墙面端口号</span>
				<s:textfield name="equipment.wallNumber"></s:textfield></li>
			<!-- 
			<li><span class="field">机柜号</span>
				<s:textfield name="equipment.cabinetNumb"></s:textfield></li>
			<li><span class="field">机框号</span>
				<s:textfield name="equipment.frameNumb"></s:textfield></li>
			-->
			<li><span class="field">设备号</span>
				<s:textfield name="equipment.equipNumber"></s:textfield></li>
			<li><span class="field">用户名</span>
				<s:textfield name="equipment.adminName"></s:textfield></li>
			<li><span class="field">工位号</span>
				<s:textfield name="equipment.workNumber"></s:textfield></li>
			<li><span class="field">所属部门</span>
				<s:textfield name="equipment.dept"></s:textfield></li>
			<li><span class="field">备注</span>
				<s:textarea name="equipment.description"></s:textarea>
			</li>
		</ul>
	</s:form>
	</page:param>
</page:applyDecorator>
</body>
<script type="text/javascript">
	// 物理位置父子节点ID顺序列表
	var lIds = ["area","builder","floor","room"];
	//表单验证
	$(document).ready(function() {

		$("#addForm").validationEngine({
			promptPosition:"centerRight", 
			validationEventTriggers:"keyup blur change",
			inlineValidation: false,
			scroll:false,
			success:false
		});
		
		$("#closeId").click(function (){
			window.close();
		});
		
		$("#submit").click(function (){
			/*
			if($("#equipment_resurceType").val()==""){
				$("#equipment_resurceType").val($("#resurceType").val());
			}
			*/
			var rtpid = $("#resurceType").val();
			$("#equipment_resurceType").val($("#"+rtpid).val());
			
			$("input[disabled]").attr("disabled","");
			$("#addForm").submit();
		});
		
		$("#cancel").click(function(){
			window.close();
		});
		// 设置上联IP检查
		$("#upIp").change(function(){
			if(this.value==""){
				$("#upIp").attr("class","");
			} else {
				$("#upIp").attr("class","validate[required,ipAddress]")
			}
		});
		
		$("#resurceType").change(function(){
				if(this.value == "pc"){
				$("#selpc").show();
				$("#selnetwork").hide();
			}else{
				$("#selpc").hide();
				$("#selnetwork").show();
			}
		});
		
		$(":radio[name=\"add_type\"]").click(function(){
			if(this.value=="select"){
				$("#addForm").attr("action","${ctx}/location/relation/device!edit.action")
				$(".ico").first().show();
				$("#equipment_mac").attr("class","");
				$("#equipType").hide();
				$("#selnetwork").hide();
				$("#selpc").hide();
				$("#equipment_resurceType").attr("disabled","disabled");
				$("#equipment_equipName").attr("disabled","disabled");
				$("#equipment_ip").attr("disabled","disabled");
				$("#equipment_mac").attr("disabled","disabled");
			} else {
				$("#addForm").attr("action","${ctx}/location/relation/device!add.action")
				$(".ico").first().hide();
				$("#equipment_mac").attr("class","validate[required]");
				$("#equipType").show();
				var et = $("#resurceType").val();
				$("#sel"+et).show();
				$("#equipment_resurceType").attr("disabled","");
				$("#equipment_equipName").attr("disabled","");
				$("#equipment_ip").attr("disabled","");
				$("#equipment_mac").attr("disabled","");
			}
		}).first().attr("checked",true);
		
		$(".ico").first().css("display","none").click(function(){
			var object = window.showModalDialog("${ctx}/location/relation/device!showSelectEquipment.action?location.locationId=${location.locationId}&unRelation=true");
			if(object){
				$("#equipment_id").val(object.id);
				var ips = object.ip;
				var ip = ips.split(",");
				$("#equipment_ip").val(ip[0]);
				$("#equipment_mac").val(object.mac);
				$("#equipment_equipName").val(object.equipName);
				$("#equipment_resurceType").val(object.resurceType);
			}
		});
		
		initLoactions();
		
		setLocationChangeEvent();
		
		
	});
	
	// 设置物理位置级联事件
	function setLocationChangeEvent(){
		
		for(var i=0;i<lIds.length;i++){
			$("#"+lIds[i]).change(function(){loadAllLocationSelect(this.id);});
		}
	}
	
	// 递归加载子节点
	function loadAllLocationSelect(selId){
		/*
		var childs = new Array();
		for(var n=0;n<lIds.length;n++){
			if(lIds[n]==selId){
				childs=lIds.slice(n);
				break;	
			}
		}
		// 包含子节点
		if(childs.length>1){
			// 清空下拉列表框选项，设置为不可用状态
			for(var m=1;m<childs.length;m++){
				$("#"+childs[m]).clearAll().addOption("请选择","");
			}
			if($("#"+childs[0]).val()!=""){
				
				// 加载子节点
				loadChild($("#"+childs[0]).val(),childs[1],function(){
					if($("#"+childs[1]).size()>0){
						$("#"+childs[1]);
						
						loadAllLocationSelect(childs[1]);
					}
				});
			}
		}
		*/
		var selValue=$("#"+selId).val();
		var selid=$("#"+selId).attr("id");
		if(selValue != ""){
			loadChild(selValue,selid);
		}else{
			var parentId = parentNote(selId);
			loadChild(parentId.val,parentId.notetype);
		}
	}
	
	// 加载子区域，locationId父节点ID，notetype子节的类型（标签的id），callback回调方法
	function loadChild(locationId,notetype,callback){
		//初始化下级选择框
		$.ajax({
			url: 		"${ctx}/location/define/location!child.action",
			data:		"location.locationId=" + locationId,
			dataType: 	"json",
			cache:		false,
			success: function(data, textStatus){
					cleanSelect(notetype);
					setChildNote(data.locations);
				if(typeof callback == "function"){
					callback();
				}
			}
		});
	}
	
	//获得最近的父节点的value（value是locationId）和类型（就是控件的id）
	function parentNote(childNoteId){
			if(childNoteId == "room"){
				if($("#floor").val() != "")return {'val':$("#floor").val(),'notetype':'floor'};
				if($("#builder").val() != "")return {'val':$("#builder").val(),'notetype':'builder'};
				if($("#area").val() != "")return {'val':$("#area").val(),'notetype':'area'};
				if($("#domain").val() != "")return {'val':$("#domain").val(),'notetype':'domain'};
			}else if(childNoteId == "floor"){
				if($("#builder").val() != "")return {'val':$("#builder").val(),'notetype':'builder'};
				if($("#area").val() != "")return {'val':$("#area").val(),'notetype':'area'};
				if($("#domain").val() != "")return {'val':$("#domain").val(),'notetype':'domain'};
			}else if(childNoteId == "builder"){
				if($("#area").val() != "")return {'val':$("#area").val(),'notetype':'area'};
				if($("#domain").val() != "")return {'val':$("#domain").val(),'notetype':'domain'};
			}else if(childNoteId == "area"){
				if($("#domain").val() != "")return {'val':$("#domain").val(),'notetype':'domain'};
			}
		}

	//java中的类型和select标签的id对应的转换
	function noteIdBytype(noteType){
		if(noteType == "location_area"){
				noteType="area";
			}
			if(noteType == "location_builder"){
				noteType="builder";
			}
			if(noteType == "location_floor"){
				noteType="floor";
			}
			if(noteType == "location_room" || noteType == "location_office"){
				noteType="room";
			}
			return noteType;
	}

	//将子节点根据类型插入到select当中
	function setChildNote(locations){
		if(locations!=null){
			for(var i=0;i<locations.length;i++){
				var noteId = noteIdBytype(locations[i].type);
				$("#"+noteId).addOption(locations[i].name,locations[i].locationId);
			}
			}
			
	}

	//清空select的方法，清空子节点的select
	function cleanSelect(noteType){
			if(noteType == "location_domain" || noteType == "domain"){
				$("#area").clearAll().addOption("请选择","");
				$("#builder").clearAll().addOption("请选择","");
				$("#floor").clearAll().addOption("请选择","");
				$("#room").clearAll().addOption("请选择","");
			}else if(noteType == "location_area" || noteType == "area"){
				$("#builder").clearAll().addOption("请选择","");
				$("#floor").clearAll().addOption("请选择","");
				$("#room").clearAll().addOption("请选择","");
			}else if(noteType == "location_builder" || noteType == "builder"){
				$("#floor").clearAll().addOption("请选择","");
				$("#room").clearAll().addOption("请选择","");
			}else if(noteType == "location_floor" || noteType == "floor"){
				$("#room").clearAll().addOption("请选择","");
				}
		}
	
	// 初始化加载子区域，locationId父节点ID，i为循环的个数，locas所有的父节点和自己，callback回调方法
	function loadChildNote(locationId,i,locas,callback){
		
		//初始化下级选择框
		$.ajax({
			url: 		"${ctx}/location/define/location!child.action",
			data:		"location.locationId=" + locationId,
			dataType: 	"json",
			cache:		false,
			success: function(data, textStatus){
				if(data.locations !=null&&data.locations.length != 0){
					cleanSelect(locas[i].type);
					setChildNote(data.locations);
				}
				if(typeof callback == "function"){
					callback(i+1,locas);
				}
			}
		});
	}

	//回调方法但是此方法是递归调用结束的条件要看i的值
	var loadBack=function (i,locas){
			if( i != locas.length ){
				loadChildNote(locas[i].locationId,i,locas,loadBack);
				}else{
					for(var j=0;j<locas.length;j++){
												if(j!=0){
													var noteType=noteIdBytype(locas[j].type);
													$("#"+noteType).setSelectedValue(locas[j].locationId);
												}
										}
					}
		}
	
	//初始化物理位置选择框选项
	function initLoactions(){
		$.ajax({
			url: 		"${ctx}/location/define/location!parents.action",
			data:		"location.locationId=${location.locationId}",
			dataType: 	"json",
			cache:		false,
			success: function(data, textStatus){
				// 当前节点所有父节点及当前节点
				var lcoations = data.locations?data.locations:[];
				lcoations.push(data.location)
				
				$("#domain").val(lcoations[0].locationId);
				loadBack(0,lcoations);
				/*
				//初始化区域选择框
				if(lcoations.length>1){
					loadChild(lcoations[0].locationId,"area",function(){
						$("#area").setSelectedValue(lcoations[1].locationId);
					});
					if(lcoations.length==2){
						loadChild(lcoations[1].locationId,"builder",null);
					}
				} else {
					loadChild(lcoations[0].locationId,"area",null);
				}
				//初始化大楼选择框
				if(lcoations.length>2){
					loadChild(lcoations[1].locationId,"builder",function(){
						$("#builder").setSelectedValue(lcoations[2].locationId);
					});
					if(lcoations.length==3){
						loadChild(lcoations[2].locationId,"floor",null);
					}
				}
				//初始化楼层选择框
				if(lcoations.length>3){
					loadChild(lcoations[2].locationId,"floor",function(){
						$("#floor").setSelectedValue(lcoations[3].locationId);
					});
					if(lcoations.length==4){
						loadChild(lcoations[3].locationId,"room",null);
					}
				}
				//初始化房间选择框
				if(lcoations.length>4){
					loadChild(lcoations[3].locationId,"room",function(){
						$("#room").setSelectedValue(lcoations[4].locationId);
					});
				}
				*/
			}
		});
	}
</script>
</html>