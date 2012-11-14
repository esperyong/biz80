<!-- WEB-INF\content\location\design\basic-attribute.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Arrays" %>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base target="_self">
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>基本形状</title>
<link href="${ctxCss}/portal.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/public.css" rel="stylesheet" type="text/css">
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css">
<link href="${ctx}/css/validationEngine.jquery.css" rel="stylesheet" type="text/css" media="screen" title="no title" charset="utf-8" />
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
<script type="text/javascript">


$(document).ready(function() {
	var panel = null;
	var tp = new TabPanel({id:"mytab"});

	$("#submit").click(function(){
		opener.saveProperty({
		    type:$("#component_type").val(),
		    locationId:$("#component_locationId").val(),
		    componentId:$("#component_componentId").val(),
		    componentName:replaceXmlSpecialStr($("#component_componentName").val()),
		    position:$("#component_position").val(),
		    isRelationRes:$("input[name='component.isRelationRes']:checked").length>0?
	    			 $("input[name='component.isRelationRes']:checked").val():"",
		    relationResId:$("#component_relationResId").val(),
		    statusMetricType:$("input[name='component.statusMetricType']:checked").val(),
		    statusType:$("input[name='component.statusType']:checked").val(),
		    isDoubleClick:$("input[name='component.isDoubleClick']:checked").length>0?
	    			 $("input[name='component.isDoubleClick']:checked").val():"",
	    	clickType:$("input[name='component.clickType']:checked").val(),
	    	clickResId:$("#component_clickResId").val(),
	    	clickURL:$("#component_clickURL").val(),
	    	clickLocationId:$("#component_clickLocationId").val()
		});
		window.close();
	});
	$("#cancel").click(function(){
		window.close();
	});

	$("#closeId").click(function(){
		window.close();
	});
	
	$("#apply").click(function(){
		$("#submit").click();
	});
	
	$("#browseLocation").click(function(){
		var location = window.showModalDialog("${ctx}/location/define/location!selectLocation.action","help=no;status=no;scroll=yes;center=yes");
		if(location){
			$("#component_clickLocationId").val(location.id);
			$("#component_clickLocationName").val(location.name);
		}
	});
	
	// 设置选择资源事件
	$("span[name=seleceEquipment]").click(function(){
		var equipment = window.showModalDialog("${ctx}/location/relation/device!showSelectEquipment.action?location.locationId=${component.locationId}","help=no;status=no;scroll=yes;center=yes");
		if(equipment){
			$("#"+this.res+"Id").val(equipment.id);
			$("#"+this.res+"Name").val(equipment.equipName);
		}
	});
	//设置选择资源事件
	$("span[id=seleceClickEquipment]").click(function(){
		var equipment = window.showModalDialog("${ctx}/location/relation/device!showSelectEquipment.action?location.locationId=${component.locationId}","help=no;status=no;scroll=yes;center=yes");
		if(equipment){
			$("#"+this.res+"Id").val(equipment.id);
			$("#"+this.res+"Name").val(equipment.equipName);
		}
	});
	// 初始化页面选项
	init();
});

function init(){

	setRadioValue("component.clickType", "${component.clickType}"==""?"locationPage":"${component.clickType}");
	setRadioValue("component.statusType", "${component.statusType}"==""?"2":"${component.statusType}");
	
	$("input[name='component.statusMetricType']").each(function(){
		$(this).before("<br/>");
	});
}

function setRadioValue(radioName, value){
	$("input[name='"+radioName+"']").each(function(){
		if(this.value==value){
			this.checked = true;
		}
	});
}
</script>
</head>
<body >

<page:applyDecorator name="popwindow"  title="基本属性">
	
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
	<ul class="fieldlist-n">
		<li style="float:left;">
			<span>节点名称：</span>
		</li>
		<li style="float:left;padding-left:20px;">
			<s:hidden name="component.type" id="component_type"/>
			<s:hidden name="component.locationId" id="component_locationId"/>
			<s:hidden name="component.componentId" id="component_componentId"/>
			<s:textfield name="component.componentName" id="component_componentName"></s:textfield>
		</li>
	</ul>
	<ul class="fieldlist-n">
		<li style="float:left;">
			<span>显示位置：</span>
		</li>
		<li style="float:left;padding-left:20px;">
			<s:select name="component.position" id="component_position" list="#{'down':'节点下方', 'up':'节点上方' }"></s:select>
		</li>
	</ul>
	<ul class="fieldlist-n">
		
		<li>
			<s:checkboxlist name="component.isRelationRes" list="#{'true': '关联资源'}"/>
		</li>
	</ul>
	<ul class="fieldlist-n">
		<li style="float:left;">
			<span>选择资源：</span>
		</li>
		<li style="float:left;padding-left:20px;">
			<s:hidden name="component.relationResId" id="component_relationResId"/>
			<s:textfield name="component.relationResName" id="component_relationResName"></s:textfield>
			<span class="black-btn-l" name="seleceEquipment" res="component_relationRes"><span class="btn-r"><span class="btn-m"><a>浏览</a></span></span></span>
		</li>
	</ul>
	<ul class="fieldlist-n">
		<li style="float:left;"><br/>
			<span>状态灯表示：</span>
		</li>
		<li style="float:left;padding-left:10px;">
			<s:radio name="component.statusMetricType" list="statusList" value="'res_avail'" listKey="key" listValue="%{getText(value)}"></s:radio>
		</li>
	</ul>
	<ul class="fieldlist-n">
		<li style="float:left;">
			<span>状态显示方式：</span>
		</li>
		<li style="float:left;padding-left:10px;">
			<s:radio name="component.statusType" list="#{'2':'填充颜色', '3':'边框改变颜色' }" value="2"/>
		</li>
	</ul>
	<ul class="fieldlist-n">
		<li>
			<s:checkboxlist name="component.isDoubleClick" list="#{'true': '双击时进行打开操作'}"/>
		</li>
	</ul>
	<ul class="fieldlist-n">
		<li style="float:left;">
			<span>双击时打开：</span>
		</li>
		<li style="float:left;padding-left:10px;line-heigth:0px;">
			<input type="radio" name="component.clickType" value="locationPage" checked="true"
				onclick="$('#component_clickResId,#component_clickResName,#component_clickURL').val('')">
		</li>
		<li style="float:left;">
		子区域
		</li>
	</ul>
	<ul class="fieldlist-n">
		<li style="float:left;width:76px;">
		</li>
		<li style="float:left;padding-left:10px;">指定子区域：	</li>
		<li style="float:left;">
		<s:hidden name="component.clickLocationId" id="component_clickLocationId"/>
			<s:textfield name="component.clickLocationName" id="component_clickLocationName"></s:textfield>
			<span class="black-btn-l" id="browseLocation"><span class="btn-r"><span class="btn-m">
			<a>浏览</a></span></span></span>
		</li>
	</ul>
	<ul class="fieldlist-n">
		<li style="float:left;width:76px;">
		</li>
		<li style="float:left;padding-left:10px;line-heigth:0px;">
			<input type="radio" name="component.clickType" value="resPage"
				onclick="$('#component_clickLocationId,#component_clickLocationName,#component_clickURL').val('')">
		</li>
		<li style="float:left;">
		资源详细信息页面
		</li>
	</ul>
	<ul class="fieldlist-n">
		<li style="float:left;width:76px;">
		</li>
		<li style="float:left;padding-left:21px;">指定资源：</li>
		<li style="float:left;">
			<s:hidden name="component.clickResId" id="component_clickResId"/>
			<s:textfield name="component.clickResName" id="component_clickResName"></s:textfield>
			<span class="black-btn-l" id="seleceClickEquipment" res="component_clickRes"><span class="btn-r"><span class="btn-m">
			<a>浏览</a></span></span></span>
		</li>
	</ul>
	<ul class="fieldlist-n">
		<li style="float:left;width:76px;">
		</li>
		<li style="float:left;padding-left:10px;line-heigth:0px;">
			<input type="radio" name="component.clickType" value="urlPage"
				onclick="$('#component_clickResId,#component_clickResName,#component_clickLocationId,#component_clickLocationName').val('')">
		</li>
		<li style="float:left;">
		打开URL
		</li>
	</ul>
	<ul class="fieldlist-n">
		<li style="float:left;width:76px;">
		</li>
		<li style="float:left;padding-left:21px;">
			指定URL：
		</li>
		<li style="float:left;">
			<input type="text" name="component.clickURL" id="component_clickURL" valiue="${(component.clickURL eq 'null'?'':component.clickURL)}"/>
		</li>
	</ul>
	</page:param>
</page:applyDecorator>

</body>
</html>