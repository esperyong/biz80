<!-- WEB-INF\content\location\status\defineStatus.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mocha.bsm.location.enums.EquipmentTypeEnum" %>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<%@ include file="/WEB-INF/common/loading.jsp" %>
<link href="${ctxCss}/public.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/UIComponent.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/master.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/validationEngine.jquery.css" rel="stylesheet" type="text/css" media="screen" title="no title" charset="utf-8" />
<script src="${ctxJs}/jquery-1.4.2.min.js" type="text/javascript"></script>
<script src="${ctxJs}/jquery.validationEngine-cn.js" type="text/javascript"></script>
<script src="${ctxJs}/jquery.validationEngine.js" type="text/javascript"></script>
<script src="${ctxJs}/component/cfncc.js"></script>
<script src="${ctxJs}/component/tabPanel/tab.js"></script>
<script src="${ctxJs}/component/gridPanel/grid.js"></script>
<script src="${ctxJs}/component/gridPanel/indexgrid.js"></script>
<script src="${ctxJs}/component/toast/Toast.js"></script>
<script src="${ctxJs}/location/dialogResize.js"></script>
<script src="${ctxJs}/jquery.blockUI.js" type="text/javascript"></script>
<!-- 以前的代码可以选择全部和部分
<div class="h1 font-white"><span  class="bold">参与状态计算的设备：</span></div>
<div id="all_div" class="font-white"><input name="area" type="radio" value="0"/><span>所有关联设备。其中，任一设备不可用，区域状态异常<span class="lamp lamp-red"></span>；并且，任一设备状态为未知时，区域状态表现为
		<select>
			<option value="<%=com.mocha.bsm.location.enums.LocationStatusEnum.all_no_unknown %>">正常</option>
			<option value="<%=com.mocha.bsm.location.enums.LocationStatusEnum.all_unknown %>">异常</option>
	    </select></span></div>
<div id="part_div" class="font-white"><input name="area" type="radio" value="1"/><span>部分关联设备。其中，所选设备中任一设备不可用，区域状态异常<span class="lamp lamp-red"></span>；并且，任一设备状态为未知时，区域状态表现为
				<select>
			<option value="<%=com.mocha.bsm.location.enums.LocationStatusEnum.part_no_unknown %>">正常</option>
			<option value="<%=com.mocha.bsm.location.enums.LocationStatusEnum.part_unknown %>">异常</option>
	    </select></span></div>
 -->
 
 <!-- 新需求只有部分状态的设置 -->
 <div class="h1 font-white" style="margin-top: 5px;">
 <img src="${ctx }/images/alpha-icon.gif" align="absmiddle">&nbsp;
 <span  class="bold">说明：区域/子区域状态由关联设备决定。</span></div>
<div id="part_div_state" class="font-white" style="margin-top: 5px;padding-left: 20px;">
<span class="lamp lamp-red"></span><span style="color: red;">异常</span><span>：
<input type="checkbox" value="part_no_unknown" checked="checked" disabled="disabled">任一关联设备不可用
<input type="checkbox" value="part_unknown">任一关联设备未知
</span>
<br/>
</div>
<div id="part_div" class="font-white" style="margin-top: 5px;margin-bottom: 10px;padding-left: 20px;">
<span class="lamp lamp-green"></span><span style="color:green;">正常</span><span>：
&nbsp;&nbsp;&nbsp;不符合异常则状态正常
</span>
<br/>
</div>
 
<div class="panel-gray" style="display:none;z-index:1;width:99%;">
	<div class="panel-gray-top">
		<span class="panel-gray-title">参与状态计算的设备列表</span>
	</div>
	<div class="panel-gray-content" style="z-index:1">
	  	<page:applyDecorator name="tabPanel">  
			<page:param name="id">mytab</page:param>
			<page:param name="width">100%</page:param>
			<page:param name="tabBarWidth">100%</page:param>
			<page:param name="cls">tab-grounp</page:param>
			<page:param name="current">1</page:param>
			<!-- <page:param name="tabHander">[{text:"网络设备",id:"networkdevice"},{text:"服务器",id:"server"},{text:"PC",id:"pc"}]</page:param> -->
			<page:param name="tabHander">[{text:"网络设备",id:"networkdevice"},{text:"服务器",id:"server"}]</page:param> 
			<page:param name="content_1">
		   		<s:action name="status!statusDevices" namespace="/location/status"
					executeResult="true" ignoreContextParams="true" />
			</page:param>
			<page:param name="content_2">
			</page:param>
			<page:param name="content_3">
			</page:param>
		</page:applyDecorator>
	</div>
</div>

<script type="text/javascript">

	var networkType = "<%=EquipmentTypeEnum.networkdevice %>";
	var serverType = "<%=EquipmentTypeEnum.host_server %>";
	var pcType = "<%=EquipmentTypeEnum.host_pc %>";
	var resType = pcType;
	var all_no_unknown = "<%=com.mocha.bsm.location.enums.LocationStatusEnum.all_no_unknown %>";
	var all_unknown = "<%=com.mocha.bsm.location.enums.LocationStatusEnum.all_unknown %>";
	var part_no_unknown = "<%=com.mocha.bsm.location.enums.LocationStatusEnum.part_no_unknown %>";
	var part_unknown = "<%=com.mocha.bsm.location.enums.LocationStatusEnum.part_unknown %>";
	var $all_inputs;
	var $part_inputs;

	$(document).ready(function(){
		
		//$all_inputs = $(":input",$("#all_div"));
		//$part_inputs = $(":input",$("#part_div"));
		
		$part_inputs = $(":input",$("#part_div_state"));
		
		var tp = new TabPanel({id:"mytab",isclear:true,listeners:{

	        change:function(tab){
			$.blockUI({message:$('#loading')});
		        resType = tab.id=="networkdevice"?networkType
		        		 :tab.id=="server"?serverType
		        		 :tab.id=="pc"?pcType:pcType;
	        	tp.loadContent(tab.index,{url:"${ctx}/location/status/status!statusDevices.action?location.locationId=" + locationId + "&resType=" + resType,callback:$.unblockUI});
	        }}});

	    // 根据当前物理位置状态，设置页面状态
	    pageState("${location.statusModel}");
	    
	    // 注册状态改变事件
	    //$all_inputs.change(changeState);
	    $part_inputs.change(changeState);
	    
		//$(".panel-gray").width("750");
		
	});
	
	//根据状态选项设置页面选项
	function pageState(locationStat){
		$(".panel-gray").show();
		if(locationStat==part_unknown){
			$part_inputs.get(1).checked=true;
		}else if(locationStat==part_no_unknown){
			$part_inputs.get(1).checked=false;
			}
		/*
		if(locationStat==all_no_unknown || locationStat==all_unknown){
			
			$(".panel-gray").hide();
			$all_inputs.get(0).checked=true;
			$all_inputs.get(1).value=locationStat;
		} else {
			
			$(".panel-gray").show();
			$part_inputs.get(0).checked=true;
			$part_inputs.get(1).value=locationStat;
		}*/
	}
	
	function changeState(){
		$(".panel-gray").show();
		if($part_inputs.get(1).checked==true){
			state = $part_inputs.get(1).value;
		}else{
			state = $part_inputs.get(0).value;
			}
		/*
		var state = all_no_unknown;
		if($all_inputs.get(0).checked==true){
			$(".panel-gray").hide();
			state = $all_inputs.get(1).value;
		} else {
			$(".panel-gray").show();
			state = $part_inputs.get(1).value;
		}
		*/
		$.ajax({
			url: 		ctx + "/location/status/status!changeStatus.action",
			data:		"location.locationId=" + locationId +"&location.statusModel=" + state,
			cache:		false
		});
	}
</script>