<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<div class="resources-search f-relative vertical-middle">
	<s:form id="query-form">
		<div class="select" style="margin-top: 3px;">
	  <s:if test="pageQueryVO.domainId == '-1'">
		  <span><s:select list="%{@com.mocha.bsm.resourcemanage.common.QueryConditionFactory@userDomains()}" name="pageQueryVO.domainId" id="domainId" listKey="key" listValue="value" headerKey="-1" headerValue="选择%{@com.mocha.bsm.resourcemanage.common.RangeName@rangeName()}" cssStyle="width:300px;"/></span>
	  </s:if>
	  <span><s:hidden name="pageQueryVO.queryName" value="name"/>名称：</span>
	  <span><s:textfield name="pageQueryVO.queryValue" cssStyle="width:80px"/></span>
	  <span class="ico"></span>
	  </div>
	  <s:if test="pageQueryVO.domainId != '-1'">
	  <s:hidden name="pageQueryVO.domainId" id="domainId"/>
	  </s:if>
  	  <s:hidden name="pageQueryVO.workGroupId" id="workGroupId"/>
  	  <s:hidden name="pageQueryVO.resType" id="resType"/>
	</s:form>
	<s:if test="(pageQueryVO.workGroupId == null) || (pageQueryVO.workGroupId == '')">
  		<div class="button"><span class="black-btn02-l black-btn02-l-blank"><span class="btn-r"><span class="btn-m"><a id="res_export">导出</a></span></span></span><span class="black-btn02-l  black-btn02-l-blank"><span class="btn-r"><span class="btn-m"><a id="batchOperate">批量操作</a><a class="selectico"></a></span></span></span></div>
  	</s:if>
  	<s:else>
  		<div class="button"><span class="black-btn02-l  black-btn02-l-blank"><span class="btn-r"><span class="btn-m"><a id="remove">移出</a></span></span></span><span class="black-btn02-l  black-btn02-l-blank"><span class="btn-r"><span class="btn-m"><a id="distribute">添加资源</a></span></span></span></div>
  	</s:else>
</div>
<div id="resource-list-div">
	<s:action name="resManage!resList" namespace="/resourcemanage" executeResult="true" ignoreContextParams="true" flush="false">
		<s:param name="pageQueryVO.domainId" value="pageQueryVO.domainId"/>
		<s:param name="pageQueryVO.workGroupId" value="pageQueryVO.workGroupId"/>
		<s:param name="pageQueryVO.resType" value="pageQueryVO.resType"/>
	</s:action>
</div>
<script type="text/javascript">
var batchOperateMenu;
var win;
var win2;
var rangeName = '<%=com.mocha.bsm.resourcemanage.common.RangeName.rangeName() %>';
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

	$("#res_export").bind("click", function(){
		win2.setConfirm_listener(function(){
			win2.hide();
			exportRes();
		});
		win2.show();
	});

	win = new confirm_box({title:'提示',text:'是否确认执行此操作？',cancle_listener:function(){win.hide();}});
	win2 = new confirm_box({title:'提示',text:'最多能导出最近1000条记录，是否继续？',cancle_listener:function(){win2.hide();}});

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
		win.setConfirm_listener(function(){
			win.hide();
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
		});
		win.show();
	}}};

	var domainId = $("#domainId").val();
	
	batchOperateMenu = new MenuContext({x : 0,y : 0,width:150});
	$('#batchOperate').bind('click',function(event){
		batchOperateMenu.position(event.pageX, event.pageY);
		if(domainId == "-1"){
			batchOperateMenu.addMenuItems([[moveDomain]]);
		}else{
			if(domainId == "unDistribute"){
				batchOperateMenu.addMenuItems([[distributeDomain]]);
			}else{
				if(tree.getCurrentNode().isLeaf() == true) {
					batchOperateMenu.addMenuItems([[moveDomain]]);
				}else{
					batchOperateMenu.addMenuItems([[moveDomain,distributeWorkGroup]]);
				}
			}
		}
	});
	$('.selectico').bind('click',function(event){
		batchOperateMenu.position(event.pageX, event.pageY);
		if(domainId == "-1"){
			batchOperateMenu.addMenuItems([[moveDomain]]);
		}else{
			if(domainId == "unDistribute"){
				batchOperateMenu.addMenuItems([[distributeDomain]]);
			}else{
				if(tree.getCurrentNode().isLeaf() == true) {
					batchOperateMenu.addMenuItems([[moveDomain]]);
				}else{
					batchOperateMenu.addMenuItems([[moveDomain,distributeWorkGroup]]);
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
</script>