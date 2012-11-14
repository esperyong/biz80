<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<div class="resources-search f-relative vertical-middle">
	<s:form id="query-form">
	  <div class="select" style="margin-top: 3px;">
	  <s:if test="pageQueryVO.domainId == '-1'">
	  	  <span><s:select list="%{@com.mocha.bsm.resourcemanage.common.QueryConditionFactory@queryTypes()}" name="pageQueryVO.queryType" id="queryType" listKey="key" listValue="value" cssStyle="width:100px;"/></span>
	  	  <span id="queryTypeList"><s:hidden name="pageQueryVO.domainId" id="domainId"/><s:select list="%{@com.mocha.bsm.resourcemanage.common.QueryConditionFactory@resGroups()}" name="pageQueryVO.resGroup" listKey="key" listValue="value" headerKey="-1" headerValue="全部类型" cssStyle="width:200px;"/></span>
		  <%-- <span><s:select list="%{@com.mocha.bsm.resourcemanage.common.QueryConditionFactory@userDomains()}" name="pageQueryVO.domainId" id="domainId" listKey="key" listValue="value" headerKey="-1" headerValue="选择域"/></span>
		  <span><s:select list="%{@com.mocha.bsm.resourcemanage.common.QueryConditionFactory@dms()}" name="pageQueryVO.dms" id="dms" listKey="key" listValue="value" headerKey="-1" headerValue="选择DMS"/></span> --%>
	  </s:if>
	  <s:if test="pageQueryVO.domainId != '-1'">
	  	<span><s:select list="%{@com.mocha.bsm.resourcemanage.common.QueryConditionFactory@resGroups()}" name="pageQueryVO.resGroup" listKey="key" listValue="value" headerKey="-1" headerValue="全部类型" cssStyle="width:250px;"/></span>
	  </s:if>
	  <span><s:select list="#{'ip':'IP地址','name':'名称'}" name="pageQueryVO.queryName" listKey="key" listValue="value"/></span>
	  <span><s:textfield name="pageQueryVO.queryValue" cssStyle="width:80px"/></span><span class="ico"></span>
	  </div>
	  <s:if test="pageQueryVO.domainId != '-1'">
	  	<s:hidden name="pageQueryVO.domainId" id="domainId"/>
	  </s:if>
  	  <s:hidden name="pageQueryVO.workGroupId" id="workGroupId"/>
  	  <s:hidden name="pageQueryVO.resType" id="resType"/>
	</s:form>
	<s:if test="(pageQueryVO.workGroupId == null) || (pageQueryVO.workGroupId == '')">
  		<div class="button"><span class="black-btn02-l black-btn02-l-blank"><span class="btn-r"><span class="btn-m"><a id="res_export">导出</a></span></span></span> <span class="black-btn02-l  black-btn02-l-blank"><span class="btn-r"><span class="btn-m" id="batchOperateAndselectico"><a id="batchOperate">批量操作</a><a class="selectico"></a></span></span></span><!--<span class="black-btn02-l  black-btn02-l-blank"><span class="btn-r"><span class="btn-m"><a id="discovery">发现</a></span></span></span>--></div>
  	</s:if>
  	<s:else>
  		<div class="button"><span class="black-btn02-l  black-btn02-l-blank"><span class="btn-r"><span class="btn-m"><a id="remove">移出</a></span></span></span><span class="black-btn02-l  black-btn02-l-blank"><span class="btn-r"><span class="btn-m"><a id="distribute">添加资源</a></span></span></span></div>
  	</s:else>
</div>
<div id="resource-list-div">
	<s:action name="resManage!resList" namespace="/resourcemanage" executeResult="true" ignoreContextParams="true" flush="false">
		<s:param name="pageQueryVO.domainId" value="pageQueryVO.domainId"/>
		<s:param name="pageQueryVO.workGroupId" value="pageQueryVO.workGroupId"/>
	</s:action>
</div>
<script type="text/javascript"><!--
var batchOperateMenu;
var win;
var win2;
var win3;
var info;
var rangeName = '<%=com.mocha.bsm.resourcemanage.common.RangeName.rangeName() %>';
var isStandAlone = <%=com.mocha.bsm.system.SystemContext.isStandAlone()%>;
$(document).ready(function(){
	var toast = new Toast({position:"CT"});
	$(".ico").bind("click", function(){
		search();
	});

	$("#distribute").bind("click", function(){
		openDistributeRes();
	});
	
	$("#remove").bind("click", function(){
		removeRes(toast);
	});

	//发现按钮 
//	$("#discovery").bind("click", function(){
//		if(isStandAlone) {
//			openDiscovery();
//		} else {
//			$.ajax({
//				type:"GET",
//				dataType:'json',
//				url:"${ctx}/resourcemanage/resManage!dmsList.action",
//				data:"pageQueryVO.domainId=",
//				success:function(data, textStatus){
//					var dmsList = (new Function("return "+data.dmsJson))();
//					if(dmsList.length > 0) {
//						openDiscovery();
//					} else {
//						info.show();
//					}
//				}
//			});
//		}
//	});

	$("#res_export").bind("click", function(){
		win3.setConfirm_listener(function(){
			win3.hide();
			exportRes();
		});
		win3.show();
	});
	
	var $queryType = $("#queryType");
	$queryType.bind("change", function(event) { 
		var val = $(this).val();
		$.ajax({
			type: "GET",
			dataType:'json',
			url: "${ctx}/resourcemanage/resManage!changeQueryTypeList.action",
			data: "pageQueryVO.queryType=" + val,
			success: function(data, textStatus){
				var queryTypeList = (new Function("return "+data.queryTypeJson))();
				$queryTypeList = $("#queryTypeList");
				$queryTypeList.html("");
				var arr = new Array;
				var domainId = $("#domainIdmain").val();
				var selectId;
				if("dms" == val){
					selectId = "dmsId";
					arr.push("<input type='hidden' name='pageQueryVO.domainId' id='domainId' value='"+domainId+"'/>");
					arr.push("<select id="+selectId+" name='pageQueryVO.dms' style='width:200px;'>");
					arr.push("<option value='-1'>全部DMS</option>");
				}else if("domain" == val){
					selectId = "domainId";
					arr.push("<select name='pageQueryVO.domainId' id="+selectId+" style='width:200px;'>");
					arr.push("<option value='-1'>全部" + rangeName + "</option>");
				}else{
					selectId = "resGroupId";
					arr.push("<input type='hidden' name='pageQueryVO.domainId' id='domainId' value='"+domainId+"'/>");
					arr.push("<select id="+selectId+" name='pageQueryVO.resGroup' style='width:200px;'>");
					arr.push("<option value='-1'>全部类型</option>");
				}
				for(var i = 0; i < queryTypeList.length; i++){
					arr.push("<option value='"+queryTypeList[i].key+"'>"+queryTypeList[i].value+"</option>"); 
				}
				arr.push("</select>");
				$queryTypeList.append(arr.join(""));
				var selectIdArray = new Array;
				selectIdArray.push(selectId);
				SimpleBox.renderTo(selectIdArray)
			}
		});
		return false; 
	})

	info = new information({text:'请先初始化系统，在‘系统管理->系统部署’中发现Agent并注册系统服务CMS/DCH/DMS。'});
	win = new confirm_box({title:'提示',text:'是否确认执行此操作？',cancle_listener:function(){win.hide();}});
	win2 = new confirm_box({title:'提示',text:'此操作不可恢复。是否确认执行此操作？',cancle_listener:function(){win2.hide();}});
	win3 = new confirm_box({title:'提示',text:'最多能导出最近1000条记录，是否继续？',cancle_listener:function(){win3.hide();}});
	
	var moveDomain = {text:"迁移" + rangeName,id:"moveDomain",listeners:{click:function() {
		batchOperateMenu.hide();
		if(!validate(toast)) {return;}
		var distDomainId = openMoveDomain();
		if(distDomainId == undefined || distDomainId == ""){
			return;
		}
		win.setConfirm_listener(function(){
			win.hide();
			$("#distDomainId").val(distDomainId);
			var ajaxParam = $("#res-list-query").serialize();
			$.ajax({
				type:"POST",
				dataType:'json',
				url:"${ctx}/resourcemanage/resBatchOpertation!moveDomain.action",
				data:ajaxParam,
				success:function(){
					search();
				}
			});
		});
		win.show();
	}}};
	var distributeDomain = {text:"分配" + rangeName,id:"distributeDomain",listeners:{click:function() {
		batchOperateMenu.hide();
		if(!validate(toast)) {return;}
		var distDomainId = openDistributeDomain();
		if(distDomainId == undefined || distDomainId == ""){
			return;
		}
		win.setConfirm_listener(function(){
			win.hide();
			$("#distDomainId").val(distDomainId);
			var ajaxParam = $("#res-list-query").serialize();
			$.ajax({
				type:"POST",
				dataType:'json',
				url:"${ctx}/resourcemanage/resBatchOpertation!distributeDomain.action",
				data:ajaxParam,
				success:function(){
					search();
				}
			});
		});
		win.show();
	}}};
	var moveDMS = {text:"迁移DMS",id:"moveDMS",listeners:{click:function() {
		batchOperateMenu.hide();
		if(!validate(toast)) {return;}
		$.ajax({
			type: "POST",
			dataType:'json',
			url: "${ctx}/resourcemanage/resBatchOpertation!validateDms.action",
			success: function(data, textStatus){
				var flag = data.validateDms;
				if("true" == flag) {
					toast.addMessage("系统正在进行DMS资源迁移，此操作请稍后再执行。");
				}else{
					var distDmsId = openMoveDms1();
					if(distDmsId == undefined || distDmsId == ""){
						return;
					}
					$("#distDmsId").val(distDmsId);
					openMoveDms2();
				}
			}
		});
	}}};

	var distributeWorkGroup = {text:"分配工作组",id:"distributeWorkGroup",listeners:{click:function() {
		batchOperateMenu.hide();
		if(!validate(toast)) {return;}
		var workGroupId = openDistributeWorkGroup();
		if(workGroupId == undefined || workGroupId == ""){
			return;
		}
		win.setConfirm_listener(function(){
			win.hide();
			$("#distWorkGroupId").val(workGroupId);
			var ajaxParam = $("#res-list-query").serialize();
			$.ajax({
				type:"POST",
				dataType:'json',
				url:"${ctx}/resourcemanage/resBatchOpertation!distributeWorkGroup.action",
				data:ajaxParam,
				success:function(){
					search();
				}
			});
		});
		win.show();
	}}}

	var removeResource = {text:"删除",id:"removeResource",listeners:{click:function() {
		batchOperateMenu.hide();
		if(!validate(toast)) {return;}
		win2.setConfirm_listener(function(){
			win2.hide();
			$.ajax({
				type: "POST",
				dataType:'json',
				url: "${ctx}/resourcemanage/resBatchOpertation!validateDms.action",
				success: function(data, textStatus){
					var flag = data.validateDms;
					if("true" == flag) {
						toast.addMessage("系统正在进行DMS资源迁移，此操作请稍后再执行。");
					}else{
						var ajaxParam = $("#res-list-query").serialize();
						$.ajax({
							type:"POST",
							dataType:'json',
							url:"${ctx}/resourcemanage/resBatchOpertation!removeResource.action",
							data:ajaxParam,
							success:function(){
								search();
							}
						});
					}
				}
			});
		});
		win2.setSubTipText("*删除操作不影响其他使用此资源的子模块，例如业务服务、网络拓扑等。");
		win2.show();
	}}};

	var domainId = $("#domainId").val();
	
	batchOperateMenu = new MenuContext({x : 0,y : 0,width:165});
	
	//注销date 2011-07-14
//	$('#batchOperate').bind('click',function(event){
//		batchOperateMenu.position(event.pageX, event.pageY);
//		if(domainId == "-1"){
//			if(isStandAlone == 'true') {
//				batchOperateMenu.addMenuItems([[moveDomain,removeResource]]);
//			} else {
//				batchOperateMenu.addMenuItems([[moveDomain,moveDMS,removeResource]]);
//			}
//		}else{
//			if(domainId == "unDistribute"){
//				if(isStandAlone) {
//					batchOperateMenu.addMenuItems([[distributeDomain,removeResource]]);
//				} else {
//					batchOperateMenu.addMenuItems([[distributeDomain,moveDMS,removeResource]]);
//				}
//			}else{
//				if(tree.getCurrentNode().isLeaf() == true) {
//					batchOperateMenu.addMenuItems([[moveDomain,removeResource]]);
//				}else{
//					batchOperateMenu.addMenuItems([[moveDomain,distributeWorkGroup,removeResource]]);
//				}
//			}
//		}
//	});
//	$('.selectico').bind('click',function(event){
//		batchOperateMenu.position(event.pageX, event.pageY);
//		if(domainId == "-1"){
//			if(isStandAlone == 'true') {
//				batchOperateMenu.addMenuItems([[moveDomain,removeResource]]);
//			} else {
//				batchOperateMenu.addMenuItems([[moveDomain,moveDMS,removeResource]]);
//			}
//		}else{
//			if(domainId == "unDistribute"){
//				if(isStandAlone) {
//					batchOperateMenu.addMenuItems([[distributeDomain,removeResource]]);
//				} else {
//					batchOperateMenu.addMenuItems([[distributeDomain,moveDMS,removeResource]]);
//				}
//			}else{
//				if(tree.getCurrentNode().isLeaf() == true) {
//					batchOperateMenu.addMenuItems([[moveDomain,removeResource]]);
//				}else{
//					batchOperateMenu.addMenuItems([[moveDomain,distributeWorkGroup,removeResource]]);
//				}
//			}
//		}
//	});
 //新添加代码日期2011-07-14
$('#batchOperateAndselectico').bind('click',function(event){
		batchOperateMenu.position(event.pageX, event.pageY);
		if(domainId == "-1"){
			if(isStandAlone == 'true') {
				batchOperateMenu.addMenuItems([[moveDomain,removeResource]]);
			} else {
				batchOperateMenu.addMenuItems([[moveDomain,moveDMS,removeResource]]);
			}
		}else{
			if(domainId == "unDistribute"){
				if(isStandAlone) {
					batchOperateMenu.addMenuItems([[distributeDomain,removeResource]]);
				} else {
					batchOperateMenu.addMenuItems([[distributeDomain,moveDMS,removeResource]]);
				}
			}else{
				if(tree.getCurrentNode().isLeaf() == true) {
					batchOperateMenu.addMenuItems([[moveDomain,removeResource]]);
				}else{
					batchOperateMenu.addMenuItems([[moveDomain,distributeWorkGroup,removeResource]]);
				}
			}
		}
	});




});

function search() {
	$.blockUI({message:$('#loading')});
	var ajaxParam = $("#query-form").serialize();
	$.ajax({
		type: "POST",
		dataType:'html',
		url: "${ctx}/resourcemanage/resManage!resList.action",
		data: ajaxParam,
		success: function(data, textStatus){
			$resource_list_div = $("#resource-list-div");
			$resource_list_div.find("*").unbind();
			$resource_list_div.html(data);
			$.unblockUI();
		}
	});
}

function exportRes() {
	$("#res-list-query").attr("action", "${ctx}/resourcemanage/resExport!export.action");
	$("#res-list-query").submit();
}

function openDistributeRes() {
	var domainId = $("#domainId").val();
	var workGroupId = $("#workGroupId").val();
	var resType = $("#resType").val();
	var src="${ctx}/resourcemanage/resManage!resDistribute.action?pageQueryVO.domainId=" + domainId + "&pageQueryVO.workGroupId=" + workGroupId + "&pageQueryVO.resType=" + resType + "&pageQueryVO.pageSize=16";
	var width=530;
	var height=590;
	window.open(src,'resDistribute','height='+height+',width='+width+',scrollbars=yes');
}

function openMoveDomain() {
	var src="${ctx}/resourcemanage/resBatchOpertation!openMoveDomain.action";
	var width=410;
	var height=220;
	return window.showModalDialog(src,window,'dialogWidth:'+width+'px;dialogHeight:'+height+'px;help:no;center:yes;resizable:no;status:no;scroll:no');
}

function openMoveDms1() {
	var src="${ctx}/resourcemanage/resBatchOpertation!openMoveDMS1.action";
	var width=410;
	var height=170;
	//return window.open(src,'moveDms1','height='+height+',width='+width+',scrollbars=no');
	return showModalDialog(src,window,'dialogWidth:'+width+'px;dialogHeight:'+height+'px;help:no;center:yes;resizable:no;status:no;scroll:no');
}

function openMoveDms2() {
	var src="${ctx}/resourcemanage/resBatchOpertation!openMoveDMS2.action";
	var width=410;
	var height=455;
	//return window.open(src,'moveDms2','height='+height+',width='+width+',scrollbars=no');
	return showModalDialog(src,window,'dialogWidth:'+width+'px;dialogHeight:'+height+'px;help:no;center:yes;resizable:no;status:no;scroll:no');
}

function openDistributeDomain() {
	var src="${ctx}/resourcemanage/resBatchOpertation!openDistributeDomain.action";
	var width=260;
	var height=95;
	return window.showModalDialog(src,window,'dialogWidth:'+width+'px;dialogHeight:'+height+'px;help:no;center:yes;resizable:no;status:no;scroll:no');
}

function openDistributeWorkGroup() {
	var domainId = $("#domainId").val();
	var src="${ctx}/resourcemanage/resBatchOpertation!openDistributeWorkGroup.action?pageQueryVO.domainId=" + domainId;
	var width=260;
	var height=95;
	return window.showModalDialog(src,window,'dialogWidth:'+width+'px;dialogHeight:'+height+'px;help:no;center:yes;resizable:no;status:no;scroll:no');
}
//发现按钮
//function openDiscovery() {
//	var src="${ctx}/discovery/discovery-main.action";
//	var width=930;
//	var height=700;
//	window.open(src,'resDistribute','height='+height+',width='+width+',scrollbars=yes');
//}

function removeRes(toast) {
	if(!validate(toast)) return;
	win.setConfirm_listener(function(){
		win.hide();
		var ajaxParam = $("#res-list-query").serialize();
		$.ajax({
			type: "POST",
			dataType:'html',
			url: "${ctx}/resourcemanage/resManage!removeInstanceFormWorkGroup.action",
			data: ajaxParam,
			success: function(data, textStatus){
				$resource_list_div = $("#resource-list-div");
				$resource_list_div.find("*").unbind();
				$resource_list_div.html(data);
			}
		});
	});
	win.show();
}

function validate(toast) {
	var $checkarr = $("input[name='instanceIds']:checked");
	if($checkarr.length == 0){
		toast.addMessage("请至少选择一项。");
		return false;
	}
	return true;
}
SimpleBox.renderAll();
--></script>