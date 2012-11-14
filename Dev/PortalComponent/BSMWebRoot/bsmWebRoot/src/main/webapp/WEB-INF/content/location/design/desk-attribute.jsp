<!-- WEB-INF\content\location\design\desk-attribute.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Arrays" %>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base target="_self">
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>工位属性</title>
<link href="${ctxCss}/public.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/UIComponent.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/master.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/public.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/button-module.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/validationEngine.jquery.css" rel="stylesheet" type="text/css" media="screen" title="no title" charset="utf-8" />
<script src="${ctxJs}/jquery-1.4.2.min.js" type="text/javascript"></script>
<script src="${ctxJs}/jquery.validationEngine-cn.js" type="text/javascript"></script>
<script src="${ctxJs}/jquery.validationEngine.js" type="text/javascript"></script>
<script src="${ctxJs}/component/cfncc.js"></script>
<script src="${ctxJs}/component/tabPanel/tab.js"></script>
<script src="${ctxJs}/component/panel/panel.js" type="text/javascript"></script>
<script src="${ctxJs}/component/accordionPanel/accordionPanel.js" type="text/javascript"></script>
<script src="${ctxJs}/component/accordionPanel/accordionAddSubPanel.js" type="text/javascript"></script>
<script src="${ctxJs}/component/toast/Toast.js"></script>
<script src="${ctxJs}/location/define/locations.js"></script>
<script type="text/javascript"><!--
var equipment;
$(document).ready(function() {
	var panel = null;
	var tp = new TabPanel({id:"mytab"});
	
	$("#submit").click(function(){
		opener.saveProperty({
		    type:$("#component_type").val(),
		    locationId:$("#component_locationId").val(),
		    imageId:$("#component_imageId").val(),
		    componentId:$("#component_componentId").val(),
		    componentName:replaceXmlSpecialStr($("#component_componentName").val()),
		    position:$("#component_position").val(),
		    workLabel:$("input[name='component.workLabel']:checked").length>0?
	    			 $("input[name='component.workLabel']:checked").val():"",
	    	wallNumber:$("input[name='component.wallNumber']:checked").length>0?
	    			$("input[name='component.wallNumber']:checked").val():"",
	    	upPort:$("input[name='component.upPort']:checked").length>0?
	    			$("input[name='component.upPort']:checked").val():"",
		    relationResId:$("#component_relationResId").val(),
		    isRelationRes:$("input[name='component.isRelationRes']:checked").val(),
		    isDoubleClick:$("input[name='component.isDoubleClick']:checked").length>0?
	    			 $("input[name='component.isDoubleClick']:checked").val():"",
	    	clickType:$("input[name='component.clickType']:checked").val(),
	    	clickResId:$("#component_clickResId").val(),
	    	clickURL:replaceXmlSpecialStr($("#component_clickURL").val()),
		    statusType:$("input[name='component.statusType']:checked").val()
		   
		});
		window.close();
	});
	$("input[name='component.statusType'][value='${component.statusType}']").attr("checked","checked");
	
	$("#cancel").click(function(){
		window.close();
	});

	$("#closeId").click(function(){
		window.close();
	});
	
	/*
	$("#apply").click(function(){
		$("#submit").click();
	});
	*/
	// 设置选择资源事件
	$("span[name=seleceEquipment]").click(function(){
		var t_equipment = window.showModalDialog("${ctx}/location/relation/device!showSelectEquipment.action?location.locationId=${component.locationId}","help=no;status=no;scroll=yes;center=yes");
		if(t_equipment){
			// 关联资源
			if(this.res=="component_relationRes"){
				equipment = t_equipment;
				// 设置工位样式
				setSeatStyle();
			}
			$("#"+this.res+"Id").val(t_equipment.id);
			$("#"+this.res+"Name").val(t_equipment.equipName);
		}
	});
	$("input[name=component.isRelationRes]").click(function(){
		setRelationStyle(this.value);
	});
	// 设置工位标注改变事件
	$("#component_componentName").change(function(){
		setWorkLabel(this.value);
	});
	// 设置工位标注改变事件
	$("input[name=component.workLabel]").change(function(){
		if(equipment){
			if(this.value=="workNumber"){
				setWorkLabel(equipment.workNumber);
			} else {
				setWorkLabel(equipment.adminName);
			}
		}
	})
	// 设置墙面端口号事件
	$("input[name=component.wallNumber]").change(function(){
		if(equipment){
			setWallNumber(this.checked?equipment.wallNumber:"");
		}
	})
	// 设置上联端口号事件
	$("input[name=component.upPort]").change(function(){
		setUpPort(this.checked+"");
	})
	// 初始化页面默认选项
	init();
	// 初始化工位预览样式
	initSeatStyle();
});
// 初始化页面选项
function init(){

	// 设置当前选择的图片的名称
	$("#imageName").html($("img[id='${component.imageId}']").attr("name"))
	setRelationStyle("${component.isRelationRes}");
	setRadioValue("component.isRelationRes","${component.isRelationRes}"==""?"":"${component.isRelationRes}");
	setRadioValue("component.workLabel", "${component.workLabel}"==""?"":"${component.workLabel}");
	setRadioValue("component.clickType", "${component.clickType}"==""?"":"${component.clickType}");
}
// 初始化工位预览样式
function initSeatStyle(){
	setSeatImage("${ctx}/location/design/designImage!getImage.action?designImage.id=${component.imageId}");
	setUpPort("${component.upPort}");
	// 不关联设备
	if("false"=="${component.isRelationRes}"){
		setWorkLabel("${component.relationResName}");
	} else {
		if(""!="${component.relationResId}"){
			getEquipmentById("${component.relationResId}",function(){
				// 设置工位标注
				if("workNumber"=="${component.workLabel}"){
					setWorkLabel(equipment.workNumber);
				} else {
					setWorkLabel(equipment.adminName);
				}
				// 设置墙面端口号显示
				if("true"=="${component.wallNumber}"){
					setWallNumber(equipment.wallNumber);
				}
			});
		}
	}
}
// 设置工位预览样式
function setSeatStyle(){
	if(equipment){
		// 设置工位标注
		if($("input[name='component.workLabel']:checked").val()=="workNumber"){
			setWorkLabel(equipment.workNumber);
			
		} else {
			setWorkLabel(equipment.adminName);
		}
		// 设置干墙面端口号
		if($("input[name='component.wallNumber']:checked").val()){
			setWallNumber(equipment.wallNumber);
		}
		// 上联端口号 
		setUpPort($("input[name='component.upPort']:checked").val());
	}
}
// 设备单选按钮选择项
function setRadioValue(radioName, value){
	$("input[name='"+radioName+"']").each(function(){
		if(this.value==value){
			this.checked = true;
		}
	});
}
// 设置关联设备显示样式
function setRelationStyle(show){
	if(show=="true"){
		$("#component_componentName").val("").hide();
		$("#res").show();
		$("#resContent").show(); //将一个li里面的内容分为两个里面而增加的
		$("#position").hide();
		$("#positionContent").hide(); //将一个li里面的内容分为两个里面而增加的
		$("#component_relationResName").attr("class","validate[required]");
		$("#workRadio").show();
		$("#wordDisplay").show();
		$("#wordDisplayContent").show(); //将一个li里面的内容分为两个里面而增加的
	} else {
		$("#component_componentName").show();
		$("#res").hide();
		$("#resContent").hide(); //将一个li里面的内容分为两个里面而增加的
		$("#position").show();
		$("#positionContent").show(); //将一个li里面的内容分为两个里面而增加的
		$("#component_relationResId").val("");
		$("#component_relationResName").val("").attr("class","");
		$("#workRadio").hide();
		$("#wordDisplay").hide();
		$("#wordDisplayContent").hide(); //将一个li里面的内容分为两个里面而增加的
		// 清除工位信息
		equipment = null;
		setWorkLabel("");
		setWallNumber("");
		setUpPort("");
	}
}
// 得到设备对象
function getEquipmentById(eid,callback){
	$.ajax({
		url: 		"${ctx}/location/relation/device!getEquipmentById.action",
		data:		"equipment.id=" + eid,
		dataType: 	"json",
		cache:		false,
		success: function(data, textStatus){
			equipment = data.equipment;
			
			if(typeof callback == "function"){
				callback();
			}
		}
	});
}
// 替换图片
function replaceImage(image){
	$("#component_imageId").val(image.id);
	$("#imageName").html(image.name);
	$("#currentImage").attr("src",image.src);
	setSeatImage(image.src);
}
// 设置工位背景图片
function setSeatImage(imageUrl){
	$("#seat_div").css("background","url("+imageUrl+") no-repeat 0px 0px");
}
// 设置墙面端口号
function setWallNumber(num){
	$("#wallNumber_div").html(num);
}
// 设置上联端口
function setUpPort(show){
	if(show=="true"){
		$("#upPort_div").show();
	} else {
		$("#upPort_div").hide();
	}
}
// 设置工位标注
function setWorkLabel(text){
	$("#workLabel_div").html(text);
}
--></script>
</head>
<body >
<page:applyDecorator name="popwindow"  title="工位属性">
	
	<page:param name="width">510px</page:param>
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

<page:applyDecorator name="tabPanel">  
	<page:param name="id">mytab</page:param>
	<page:param name="width">498</page:param>
	<page:param name="tabBarWidth">498</page:param>
	<page:param name="cls">tab-grounp</page:param>
	<page:param name="background">white</page:param>
	<page:param name="current">1</page:param>
	<page:param name="tabHander">[{text:"设置节点",id:"picture"},{text:"替换图片",id:"backdrop"}]</page:param>
	<page:param name="content_1">
<ul class="fieldlist-n">
<!-- <li><span>节点名称：</span> -->
		<s:hidden name="component.type" id="component_type"/>
		<s:hidden name="component.locationId" id="component_locationId"/>
		<s:hidden name="component.imageId" id="component_imageId"/>
		<s:hidden name="component.componentId" id="component_componentId"/>
<!-- </li> -->
	<li>
		<input type="radio" name="component.isRelationRes" checked value="false">不关联资源，使用”工具栏->添加形状“中的自定义形状表示状态。<br>
	</li>
	<li>
		<input type="radio" name="component.isRelationRes" value="true">关联资源。<br>
	</li>
</ul>
<ul class="fieldlist-n">
	<li id="res" style="float: left;">
		<span>选择资源：</span>
		<s:hidden name="component.relationResId" id="component_relationResId"/>
	</li>
	<li id="resContent" style="float:left;padding-left:20px;">
		<s:textfield name="component.relationResName" id="component_relationResName"></s:textfield>
		<span class="red">*</span>
		<span class="black-btn-l" name="seleceEquipment" res="component_relationRes"><span class="btn-r"><span class="btn-m"><a>浏览</a></span></span></span>
	</li>
</ul>
<ul class="fieldlist-n">
	<li style="float: left;">
		<span>工位标注：</span>
	</li>
	<li style="float:left;padding-left:20px;">
		<span id="workRadio"><s:radio name="component.workLabel" list="#{'workNumber':'工位号','userName':'用户名','':'设备名'}"></s:radio></span>
		<s:textfield name="component.componentName" id="component_componentName"></s:textfield>
	</li>
</ul>
<ul class="fieldlist-n">
	<li id="wordDisplay" style="float: left;">
		<span>工位同时展现：</span>
	</li>
	<li id="wordDisplayContent" style="float:left;padding-left:20px;">
		<s:checkboxlist name="component.wallNumber" list="#{'true': '墙面端口号'}"/>
		<s:checkboxlist name="component.upPort" list="#{'true': '上联端口号'}"/>
	</li>
</ul>
<ul class="fieldlist-n">
	<li id="position" style="float: left;"><span>显示位置：</span>
	</li>
	<li id="positionContent" style="float:left;padding-left:20px;">
		<s:select name="component.position" id="component_position" list="#{'down':'节点下方'}"></s:select>
	</li>
</ul>
<!--
<ul class="fieldlist-n">
	<li style="float: left;">
		<span>工位预览：</span>
	</li>
	<li style="float:left;padding-left:20px;">
		<div class="seat" id="seat_div">
		  <div class="number" id="wallNumber_div"></div>
		  <div class="port-gray" id="upPort_div"></div>
		  <div class="name" id="workLabel_div"></div>
		</div>
	</li>
</ul>
-->
<ul class="fieldlist-n">
<s:checkboxlist name="component.isDoubleClick" list="#{'true': '双击时进行打开操作'}"/><br>
</ul>
<ul class="fieldlist-n">
	<li style="float: left;">
		<span>双击时打开：</span>
	</li>
	<li style="float:left;padding-left:20px;">
		<input type="radio" name="component.clickType" value="resPage" onclick="$('#component_clickURL').val('')" checked>资源详细信息页面
	</li>
</ul>
<ul class="fieldlist-n">
	<li style="float: left;width:76px;">
	</li>
	<li style="float:left;padding-left:20px;">
		指定资源：
		<s:hidden name="component.clickResId" id="component_clickResId"/>
		<s:textfield name="component.clickResName" id="component_clickResName"></s:textfield>
		<span class="black-btn-l" name="seleceEquipment" res="component_clickRes"><span class="btn-r"><span class="btn-m"><a>浏览</a></span></span></span>
	</li>
</ul>
<ul class="fieldlist-n">
	<li style="float: left;width:76px;">
	</li>
	<li style="float:left;padding-left:20px;">
		<input type="radio" name="component.clickType" value="urlPage" onclick="$('#component_clickResId,#component_clickResName').val('')">打开URL
	</li>
</ul>
<ul class="fieldlist-n">
	<li style="float: left;width:76px;">
	</li>
	<li style="float:left;padding-left:20px;">
		指定URL：<s:textfield name="component.clickURL" id="component_clickURL"></s:textfield>
	</li>
</ul>
<ul class="fieldlist-n">
	<li style="float: left;">
		<span>状态显示方式：</span>
	</li>
	<li style="float:left;padding-left:20px;">
		<s:radio name="component.statusType" value="0" list="#{'0':'不使用状态灯','1':'使用状态灯'}" />
	</li>
</ul>

	</page:param>
	<page:param name="content_2">
		<ul class="fieldlist-n">
			<li><span>
			<page:applyDecorator name="accordionAddSubPanel">  
			<page:param name="id">defaultImage</page:param>
			<page:param name="title">默认图片</page:param>
			<page:param name="width">370px</page:param>
			<page:param name="cls">fold-blue</page:param>
			<page:param name="content">
			<div class="img-show" style="width: 370px;">
			<ul>
				<s:iterator value="images" id="image">
				
					<s:if test="isdefault">
					<s:if test="type == designImageType.key">
					<li>
						<img id="${id }" name="${name }" onClick="replaceImage(this)" src="${ctx}/location/design/designImage!getImage.action?designImage.id=${id}" height="40" width="40"/>
						${name }
					</li>
					</s:if>
					</s:if>
				</s:iterator>
			</ul>
			</div>
			</page:param>
	    	</page:applyDecorator>
	    	<page:applyDecorator name="accordionAddSubPanel">  
			<page:param name="id">customImage</page:param>
			<page:param name="title">自定义</page:param>
			<page:param name="width">370px</page:param>
			<page:param name="cls">fold-blue</page:param>
			<page:param name="content">
			<div class="img-show" style="width: 370px;">
			<ul>
				<s:iterator value="images" id="image">
					<s:if test="!isdefault">
					<li>
						<img id="${id }" name="${name }" onClick="replaceImage(this)" src="${ctx}/location/design/designImage!getImage.action?designImage.id=${id}" height="40" width="40"/>
						${name }
					</li>
					</s:if>
				</s:iterator>
			</ul>
			</div>
			</page:param>
	    	</page:applyDecorator>
	    	</span>
	    	<span style="vertical-align:top">
	    		<img id="currentImage" src="${ctx}/location/design/designImage!getImage.action?designImage.id=${component.imageId}" height="40" width="40"/><br>
	    		当前使用：<span id="imageName"></span>
	    	</span>
			</li>
		</ul>
	</page:param>
</page:applyDecorator>

	</page:param>
</page:applyDecorator>

</body>
</html>