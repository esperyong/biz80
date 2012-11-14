<!-- WEB-INF\content\location\relation\batchEdit.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base target="_self">
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>批量编辑设备信息</title>
<link href="${ctxCss}/public.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/UIComponent.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/master.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/validationEngine.jquery.css" rel="stylesheet" type="text/css" media="screen" title="no title" charset="utf-8" />
<script src="${ctxJs}/jquery-1.4.2.min.js" type="text/javascript"></script>
<script src="${ctxJs}/jquery.select.js" type="text/javascript"></script>
<script src="${ctxJs}/jquery.validationEngine-cn.js" type="text/javascript"></script>
<script src="${ctxJs}/jquery.validationEngine.js" type="text/javascript"></script>
<script type="text/javascript">
<s:if test="#request.succeed == true">

	opener.loalDevices("${resType}",true);
	// 新建区域完成，刷新父页面
	window.returnValue="刷新区域树";
	window.close();
</s:if>

	var currentlocation = "${location.locationId}";
	var lIds = ["domain","area","builder","floor","room"];
	var locationCheckbox = ["areaUpdate","builderUpdate","floorUpdate","roomUpdate"];
	//表单验证
	$(document).ready(function() {
		/*$(":input[type=text]").each(function(i){
			this.style.width="200px";
		});*/
		$("#addForm").validationEngine({
			promptPosition:"centerRight", 
			validationEventTriggers:"keyup blur change",
			inlineValidation: true,
			scroll:false,
			success:false
		});
		
		$("#closeId").click(function (){
			window.close();
		});
		
		$("#submit").click(function (){
			$("#addForm").submit();
		});
		
		$("#cancel").click(function(){
			window.close();
		});
		// 设置修改标识
		$(":checkbox").change(function(){
			$(this).nextAll().get(1).disabled=!this.checked;
		});
		
		initLoactions();
		
		setLocationChangeEvent();
	});
	// 设备物理位置级别选中
	function setLocationCheckBox(elem){
		var index = 0;
		// 找到是哪一级物理位置触发的事件
		for(var i=0; i<locationCheckbox.length; i++){
			if(elem.id==locationCheckbox[i]){
				index = i;
				break;
			}
		}
		if(elem.checked){
			// 从低级到高级全部选中
			for(index--;index>=0;index--){
				$("#"+locationCheckbox[index]).attr("checked",true).change();
			}
		} else {
			// 从高级到低级全部取消选中
			for(var i=0;index<locationCheckbox.length;index++){
				$("#"+locationCheckbox[index]).attr("checked",false).change();
			}
		}
	}
	// 设置物理位置级联事件
	function setLocationChangeEvent(){
		
		for(var i=0;i<lIds.length;i++){
			$("#"+lIds[i]).change(function(){loadAllLocationSelect(this.id);});
		}
	}
	
	// 递归加载子节点
	function loadAllLocationSelect(selId){
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
	}
	
	// 加载子区域，locationId父节点ID，selectId子节点下拉列表框ID，callback回调方法
	function loadChild(locationId,selectId,callback){
		//初始化下级选择框
		$.ajax({
			url: 		"${ctx}/location/define/location!child.action",
			data:		"location.locationId=" + locationId,
			dataType: 	"json",
			cache:		false,
			success: function(data, textStatus){
				$("#"+selectId).clearAll()
				.addOption("请选择","")
				.addOptions(data.locations?data.locations:[], "locationId", "name");
				if(typeof callback == "function"){
					callback();
				}
			}
		});
	}
	
	//初始化物理位置选择框选项
	function initLoactions(){
		$.ajax({
			url: 		"${ctx}/location/define/location!parents.action",
			data:		"location.locationId=" + currentlocation,
			dataType: 	"json",
			cache:		false,
			success: function(data, textStatus){
				// 当前节点所有父节点及当前节点
				var lcoations = data.locations?data.locations:[];
				lcoations.push(data.location)

				$("#domain").val(lcoations[0].locationId);
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
			}
		});
	}
</script>
</head>

<body >
<page:applyDecorator name="popwindow"  title="批量编辑设备信息">
	
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
	<s:form id="addForm" action="/location/relation/device!batchEdit.action">
		<s:hidden name="resType" id="resType"/>	
		<s:hidden name="equipment.domain" id="domain"/>
		<s:hidden name="equipmentIds"></s:hidden>
		<ul class="fieldlist-n">
		<li class="gray-bottom">
		<span style="font-weight: bolder;">请选择本次要修改的项，未选中的项保留原有数据：</span>
		</li>
			<li>
				<input type="checkbox" id="areaUpdate" value="true" onclick="setLocationCheckBox(this)"/>
				<span class="field">地区:</span>
				<s:select name="equipment.area" id="area" list="#{'':'请选择'}" disabled="true"></s:select>
			</li>
			<li>
				<input type="checkbox" id="builderUpdate" value="true" onclick="setLocationCheckBox(this)"/>
				<span class="field">大楼:</span>
				<s:select name="equipment.builder" id="builder" list="#{'':'请选择'}" disabled="true"></s:select>
			</li>
			<li>
				<input type="checkbox" id="floorUpdate" value="true" onclick="setLocationCheckBox(this)"/>
				<span class="field">楼层:</span>
				<s:select name="equipment.floor" id="floor" list="#{'':'请选择'}" disabled="true"></s:select>
			</li>
			<li>
				<input type="checkbox" id="roomUpdate" value="true" onclick="setLocationCheckBox(this)"/>
				<span class="field">房间:</span>
				<s:select name="equipment.room" id="room" list="#{'':'请选择'}" disabled="true"></s:select>
			</li>
			<!-- 
			<li>
				<input type="checkbox" id="cabinetNumbUpdate" value="true"/>
				<span class="field">机柜号:</span>
				<s:textfield name="equipment.cabinetNumb" disabled="true"></s:textfield>
			</li>
			<li>
				<input type="checkbox" id="frameNumbUpdate" value="true"/>
				<span class="field">机框号:</span>
				<s:textfield name="equipment.frameNumb" disabled="true"></s:textfield>
			</li>
			 -->
			<li>
				<input type="checkbox" id="equipNumberUpdate" value="true"/>
				<span class="field">设备号:</span>
				<s:textfield name="equipment.equipNumber" disabled="true"></s:textfield>
			</li>
			<li>
				<input type="checkbox" id="adminNameUpdate" value="true"/>
				<span class="field">用户名:</span>
				<s:textfield name="equipment.adminName" disabled="true"></s:textfield>
			</li>
			<li>
				<input type="checkbox" id="deptUpdate" value="true"/>
				<span class="field">所属部门:</span>
				<s:textfield name="equipment.dept" disabled="true"></s:textfield>
			</li>
		</ul>
	</s:form>
	</page:param>
</page:applyDecorator>
</body>
</html>