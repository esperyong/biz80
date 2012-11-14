<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html>
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>发现结果页面</title>
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/validationEngine.jquery.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js" ></script>
<script type="text/javascript" src="${ctx}/js/component/cfncc.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery.validationEngine-cn.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery.validationEngine.js"></script>
<script type="text/javascript" src="${ctx}/js/component/accordionPanel/accordionPanel.js"></script>
<script type="text/javascript" src="${ctx}/js/component/accordionPanel/accordionAddSubPanel.js"></script>
<script type="text/javascript" src="${ctx}/js/component/combobox/simplebox.js"></script>
<script type="text/javascript" src="${ctx}/js/component/popwindow/popwin.js"></script>
<script>
var isReplace = "${isReplace}";
$(document).ready(function() {
	var $sp_disc_result = parent.$("#sp_disc_result");
	var time = parent.$('#compact').html();
	parent.$('#compact').countdown("destroy");
	parent.$('#compact').html(time);

	parent.stopLoading();
	parent.$("#iframe_discovery").show("fast",function(){
		setHeight();
		try{
			parent.frameShow();
		}catch(e){}
		try{
			parent.$.unblockUI();
		}catch(e){}
	});
	
	try{
	parent.parent.setNotChange();
	}catch(e){}
	<s:if test="discResult.errorMessage == null">
		$sp_disc_result.removeClass("ico ico-false");
		$sp_disc_result.addClass("ico ico-right");
		$sp_disc_result.attr("title","成功");
		parent.$("#sp_finish").show();
		parent.$("#sp_continue").show();
		parent.$("#sp_monitor").show();
	</s:if>
	<s:else>
		<s:if test="discResult.errorMessage.errorCode == @com.mocha.bsm.discovery.obj.DiscoveryConstants@ERR_INST_EXIST">
			parent.$("#resultFont").hide();
			parent.$("#sp_disc_result").hide();
			$("#discoveryFail").hide();
			parent.replaceInstance("${discResult.resInstance.id}");
		</s:if>
		$sp_disc_result.removeClass("ico ico-right");
		$sp_disc_result.addClass("ico ico-false");
		$sp_disc_result.attr("title","失败");
		parent.$("#sp_finish").show();
		parent.$("#sp_continue").show();
		parent.$("#sp_monitor").hide();
	</s:else>

	SimpleBox.renderAll();	
	$("#form_result").validationEngine({promptPosition:"bottomRight"});
	
	
	$("#parentGroupId").change(function() {
		$.ajax({
			type : "POST",
			dataType : 'html',
			data : $("#form_result").serialize(),
			url : "${ctx}/discovery/resource-instance-grouplist.action",
			success : function(data) {
				var ops = [];
				var dataJson = $.parseJSON(data);
				var list = dataJson.groupFormList;
				for(var i=0;i<list.length;i++){
					ops.push("<option value='"+list[i].resourceCategoryGroupId+"'>"+list[i].resourceGroupName+"</option>");
				}
				$("#categoryGroup").html(ops.join(""));
				$("#categoryGroup").change();
			}
		});
	});
	$("#categoryGroup").change(function() {
		$.ajax({
			type : "POST",
			dataType : 'html',
			data : $("#form_result").serialize(),
			url : "${ctx}/discovery/validate-isdisplaymonitor.action",
			success : function(data) {
				var dataJson = $.parseJSON(data);
				if(dataJson.value){
					parent.document.getElementById("sp_monitor").style.display = "none";
				}else{
					parent.document.getElementById("sp_monitor").style.display = "block";
				}
			}
		});
	});
	
	document.onkeydown = function(e) {
		// 兼容FF和IE和Opera   
		var theEvent = e || window.event;   
		var code = theEvent.keyCode || theEvent.which || theEvent.charCode;   
		//var activeElementId = document.activeElement.id;//当前处于焦点的元素的id   
		//alert(activeElementId);
		if (code == 13 ) {  
			//doSomething();//要触发的方法   
			return false;   
		}   
		return true;   
	}
	if($("#discoveryFail").length != 0){
		var c = $("span[okCount='yes']").length;
		if(c != 0){
			var $td = $("span[okCount='yes']").parent();
			var $tr = $td.parent();
			var $table = $tr.parent();
			if($table.children().length == c){
				var _information  = new information ({text:"请重新发现，若再次失败请联系系统管理员。"});
				_information.offset({top:'8px',left:'80px'});
				_information.show();
			}
		}
	}
	$("#instanceName").bind("change",function(){
		$(this).attr("class","validate[required[资源名称],noSpecialStr[资源名称],length[0,50,资源名称]");
	});
	parent.isDiscovering = false;
	
	if(isReplace == "true"){
		parent.$("#resultFont").html("替换结果：");
		parent.$("#resultFont").show();
		parent.$("#sp_disc_result").show();
		$("#discoveryFail").show();
	}else{
		parent.$("#resultFont").html("发现结果：");
	}
});
function setHeight(){
	var ifm = parent.document.getElementById("iframe_discovery");
	var thisHeight = document.getElementById("theEnd").offsetTop;
	ifm.height = thisHeight;
}

function validateForm(){
	if (!$.validate($("#form_result"), {
				promptPosition : "bottomRight"
			})) {
		return false;
	}
	return true;
}
</script>
</head>
<body>
<form id="form_result" name="form_result">
<s:if test="discResult.errorMessage == null">
	<input type="hidden" id="discovery_successed" value="true"/>
</s:if>
<s:else>
	<input type="hidden" id="discovery_successed" value="false"/>
</s:else>
<input type="hidden" id="instanceId" name="instanceId" value="${discResult.resInstance.id}"/>
<input type="hidden" id="resourceId" name="resourceId" value="${discResult.resInstance.resourceId}"/>
<div class="fold-content">
	<s:if test="discResult.errorMessage == null">
		<table class="result" style="table-layout:auto;width:100%;">
			<thead>
				<tr><th colspan="2">资源名称：&nbsp;&nbsp;&nbsp;<s:textfield id="instanceName" name="instanceName" value="%{#request.discResult.resInstance.name}" cssClass="validate[required[资源名称],length[0,50,资源名称]]"/> </th></tr>
			</thead>
			<tbody>
				<tr>
					<td><span class="field" style="padding-top:5px; <s:if test="categoryGroupList != null"> float: left;</s:if> width:70px;">资源类型：</span>
						<s:if test="categoryGroupList != null"> 
							<span><s:select id="parentGroupId" name="parentGroupId" list="parentGroup" listKey="resourceCategoryGroupId" listValue="resourceGroupName" value="%{defaultParentId}" style="width:130px;"></s:select></span>
							<span><s:select id="categoryGroup" name="categoryGroup" list="categoryGroupList" isSynchro="1" listKey="resourceCategoryGroupId" listValue="resourceGroupName" value="%{defaultChildId}" style="width:130px;"></s:select></span><span title="PC不能加入监控" class="ico ico-what"/>
						</s:if>
						<s:else>${discResult.resInstance.categoryGroupName}</s:else>
					</td>
					<td><span class="field" style="padding-top:5px; float: left; width:50px;">IP地址：</span>
						<s:if test="discResult.resInstance.ips != null">${discResult.resInstance.ip}</span></s:if>
					</td>
				</tr>
			</tbody>
		</table>
		<s:if test="!discResult.resDiagResult.resultList.isEmpty">
			<div class="h3">
				<span class="bold">发现成功影响取值项如下：</span>
			</div>
		</s:if>
	</s:if>
	<s:else>
		<div class="h3" id="discoveryFail">
			<span class="bold">失败原因：</span>
			<span><s:property value="discResult.errorMessage.errorMsg"/></span>
		</div>
	</s:else>
	
	<s:if test="!discResult.resDiagResult.resultList.isEmpty">
	 	<table class="result">
			<thead>
				<tr>
					<th width="250">诊断内容</th>
					<th width="50">诊断结果</th>
					<th>处理建议</th>
				</tr>
			</thead>
			<tbody>
				<s:iterator value="discResult.resDiagResult.resultList">
					<s:if test="metricOfCannotGet == null">
						<tr>
							<td><s:property value="collectionMode"/></td>
							<td>
								<s:if test="ok">
									<span okCount="yes" class="ico ico-right"></span>
								</s:if>
								<s:else>
									<span class="ico ico-false"></span>
								</s:else>
							</td>						
							<td><s:property value="helpInfo"/></td>
						</tr>
					</s:if>
				</s:iterator>
			</tbody>
		</table>
		<s:if test="discResult.errorMessage != null">
			<div>
				<ul>
					<li>
						<span class="bold">处理建议：</span>				
					</li>
					<li>
						<TEXTAREA class="textarea-border" ROWS="10" COLS="130" readonly>${discResult.resDiagResult.diagSuggestion}</TEXTAREA>
					</li>
				</ul>
			</div>
		</s:if>
	</s:if>	
	<s:iterator value="discResult.resInstance.childResList" id="childResource">				
		<div class="info-detail">
			<page:applyDecorator name="accordionAddSubPanel">  
				<page:param name="id">panel_childres_<s:property value="#childResource.id"/></page:param>
				<page:param name="title"><s:property value="#childResource.name"/>(<s:property value="#childResource.childInstanceList.size()"/>)</page:param>
				<page:param name="height"></page:param>
				<page:param name="width">690px</page:param>
				<page:param name="display"></page:param>
										  
			  	<page:param name="content">
			  		<div class="info-detail-listfit" style="width:670px;">
						<s:iterator value="#childResource.childInstanceList">
							<ul>
								<li><s:property value="name"/></li>
							</ul>
						</s:iterator>
					</div>
				</page:param>		  
			</page:applyDecorator>
		</div>
	</s:iterator>
			 	
</div>
</form>
<div id="theEnd" style="position:relative"></div>
</body>
</html>
<script>
<s:iterator value="discResult.resInstance.childResList" id="childResource">
	var panel_childres_<s:property value="#childResource.id"/> = new AccordionPanel( {
		id : 'panel_childres_<s:property value="#childResource.id"/>'
		},{
            DomStruFn:"addsub_accordionpanel_DomStruFn",
            DomCtrlFn:"addsub_accordionpanel_DomCtrlFn"
    } );
</s:iterator>
</script>