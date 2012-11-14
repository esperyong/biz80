<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/WEB-INF/common/loading.jsp" %>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html>
<head> 
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>重新发现</title>
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/validationEngine.jquery.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js" ></script>
<script type="text/javascript" src="${ctx}/js/component/cfncc.js" ></script>
<script type="text/javascript" src="${ctx}/js/jquery.validationEngine-cn.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery.validationEngine.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery.countdown.js" ></script>
<script type="text/javascript" src="${ctx}/js/component/accordionPanel/accordionPanel.js"></script>
<script type="text/javascript" src="${ctx}/js/component/panel/panel.js"></script>
<script type="text/javascript" src="${ctx}/js/component/gridPanel/grid.js"></script>
<script type="text/javascript" src="${ctx}/js/component/gridPanel/indexgrid.js"></script>
<script type="text/javascript" src="${ctx}/js/component/combobox/simplebox.js"></script>
<script type="text/javascript" src="${ctx}/js/component/comm/winopen.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery.blockUI.js"></script>
<script type="text/javascript" src="${ctx}/js/component/toast/Toast.js"></script>
<script type="text/javascript" src="${ctx}/js/component/popwindow/popwin.js"></script>
<script>
var contextPath = "${ctx}";
var isDiscovering = false;
var licenseJson = $.parseJSON('${licenseJson}');
var isUnmonitor = ${unmonitor};

$(document).ready(function() {
	
	/*
	 * license校验
	 */
	$("#resourceSelect option").each(function(){
		var value = licenseJson[this.value.toUpperCase()];
		if(value == "false"){
			//$("#resourceSelect option[index='"+this.index+"']").remove();
			document.getElementById("resourceSelect").options[this.index] = null;
		}
	});
	var toast = new Toast({position : "CT"});
	
	<s:if test="resourceId != null">
	$("#resGroupId").attr("disabled",true);
	$("#resourceSelect").attr("disabled",true);
	</s:if>
	SimpleBox.renderToUseWrap([{wrapId:null, selectId:'resGroupId', maxHeight:60}]);
	SimpleBox.renderToUseWrap([{wrapId:null, selectId:'resourceSelect', maxHeight:60}]);
	
	$("#sp_discovery").bind("click", function() {
	    if(isDiscovering){
	    	var toast = new Toast({
		        position: "CT"
		    });
            toast.addMessage("发现中，请稍后。");
            return;
	    }
		if(!$.validate($("#form1"),{promptPosition:"centerRight"})){
	    	return;
	    }
	    isDiscovering = true;
		
		$("#iframe_discovery").hide();
		$("#sp_disc_result").attr("class","");
		$("#sp_disc_result").attr("title","");
		$("#div_monitor_report").hide();
		$("#btn_ok").hide();
		
		stopLoading();
		startLoading();
		
		$("#div_disc_result").show();
		$('#compact').countdown({
					since : 0,
					format : 'HMS',
					compact : true,
					description : ''
				});
				
		var url = "resource-instance-rediscoverysubmit.action?instanceId=${instanceId}"+"&isChangePwd="+changeArr.join(",");
		url += "&resourceId="+$("#resourceSelect").val();
		var formObj = document.getElementById("form1");
		formObj.target = "iframe_discovery";
		formObj.action = url;
		formObj.submit();
	});
	$("#btn_cancel").bind("click", function() {
		window.close();
	});
	
	$("#closeId").bind("click", function() {
		window.close();
	});
	if($("#changeModuleONOFF").length != 0){
		var resGroupIdSelectObj = SimpleBox.instanceContent["resGroupId"];
		if(resGroupIdSelectObj){
			$("#resGroupId").attr("disabled",true);
			resGroupIdSelectObj.disable();
		}
		
		var resourceSelectObj = SimpleBox.instanceContent["resourceSelect"];
		if(resourceSelectObj){
			$("#resourceSelect").attr("disabled",true);
			resourceSelectObj.disable();
		}
		$("#changeModuleONOFF").bind("click", function(){
			if(this.checked){
				if(resGroupIdSelectObj){
					$("#resGroupId").attr("disabled",false);
					resGroupIdSelectObj.enable();
				}
				if(resourceSelectObj){
					$("#resourceSelect").attr("disabled",false);
					resourceSelectObj.enable();
				}
			}else{
				var url = "resource-instance-rediscovery.action?instanceId=${instanceId}";
				var formObj = document.getElementById("form1");
				formObj.target="";
				formObj.action = url;
				formObj.submit();
			}
		});
	}
	
	$("#resourceSelect").bind("change",function() {
		var resourceSelect = $("#resourceSelect").val();
		var url = "resource-instance-discoveryinfo.action";
		$.loadPage("discovery-info-div", url, "POST", "instanceId=${instanceId}&resourceId=" + resourceSelect, function(){
			init();
			$("#div_disc_result").hide();
			$("#div_monitor_report").hide();
		});
	});
	
	$("#resGroupId").bind("change",function() {
		var cateGroupId = $("#resGroupId").val();
		$.ajax( {
			type : "post",
			url : "resource-instance-resourcemodule.action",
			data : "oneLevelGroupId=" + cateGroupId,
			success : function(data, textStatus) {
				var resources = data.alterResourceList;
				//alert(resources.length);
				if (resources != null && resources.length > 0) {
					$("#resourceSelect option").remove();
					for (var i = 0; i < resources.length; i++) {
						var resourceId = resources[i].id;
						var resourceName = resources[i].name;
						$("#resourceSelect").append("<option value='" + resourceId + "'>" + resourceName + "</option>");
					}
					$("#resourceSelect").change();
				}
			}
		});
	});
	
	$("#btn_ok").hide();
	$("#btn_cancel").hide();
	$("#loading_text").html('<s:text name="page.loading.msg" />');
});
function frameShow(){
	//如果是监控状态才重置策略
	if(!isUnmonitor){
		var len = window.frames["iframe_discovery"].$("#instanceName").length;
		var resourceSelect = $("#resourceSelect").val();
		//如果有资源名称字段，则发现成功
		if(len != 0){
			
			$.ajax( {
				type : "post",
				url : "validate-ischangeprofile.action",
				data : "instanceId=${instanceId}&resourceId=" + resourceSelect,
				success : function(data, textStatus) {
					//如果已经在策略里，并且策略的资源Id和当前选中的资源Id是否相同则不变更策略，否则则加入选中资源Id的默认策略。
					if(data.value){
						$.blockUI({message:$('#loading')});
						$.ajax( {
							type : "post",
							url : "resource-instance-joindefaultmonitor.action",
							data : "instanceId=${instanceId}&resourceId=" + resourceSelect,
							success : function(data, textStatus) {
								if(data.discResult != null){
									$("#monitor_result").attr("class","ico ico-false");
									$("#monitor_result").attr("title","失败");
								}else{
									$("#monitor_result").attr("class","ico ico-right");
									$("#monitor_result").attr("title","成功");
									$("#profile_name").html(data.profileName);
								}
								$("#div_monitor_report").show();
								$.unblockUI();
							}
						});
					}
				}
			});
		}
	}
	$("#btn_ok").show();
}
</script>
<script type="text/javascript" src="${ctx}/js/discovery/resource-discovery.js"></script>
<script type="text/javascript">
$(function(){
	$("#btn_ok").click(function(){
		try{
			saveInstProp();
		}catch(e){}
		refreshPage(opener,'${instanceId}',"rediscovery");
		window.close();
	});
	$("span[class='fold-ico fold-ico-up']").each(function(){
		$(this).css("display","none");
	});
});
</script>
</head>
<body class="pop-window">
<page:applyDecorator name="popwindow"  title="重新发现">
  
  <page:param name="width">640px</page:param>
  <page:param name="topBtn_index_1">1</page:param>
  <page:param name="topBtn_id_1">closeId</page:param>
  <page:param name="topBtn_css_1">win-ico win-close</page:param>
  <page:param name="topBtn_title_1">关闭</page:param>
  
   	<page:param name="bottomBtn_index_1">1</page:param>
	<page:param name="bottomBtn_id_1">btn_ok</page:param>
	<page:param name="bottomBtn_text_1">确定</page:param>
	
	<page:param name="bottomBtn_index_2">2</page:param>
	<page:param name="bottomBtn_id_2">btn_cancel</page:param>
	<page:param name="bottomBtn_text_2">取消</page:param>
	
  <page:param name="content">
  
    <page:applyDecorator name="accordionPanel">  
		<page:param name="id">panel_disc_info</page:param>
		<page:param name="title">修改发现信息</page:param>
		<page:param name="height"></page:param>
		<page:param name="width">95%</page:param>
		<page:param name="cls">fold</page:param>
		<page:param name="display"></page:param>
	  	<page:param name="content">

			<input type="hidden" name="domainId" id="domainId" value="${domainId}"  />
			<input type="hidden" name="resourceId" id="resourceId" value="${resourceId}"  />
			<ul class="textalign">
				<!-- 没有模型的是一种显示方式，有模型的按是否监控来区分显示内容 -->
				<s:if test="resourceId == null">
					<li style="width:80%;" class="margin5 padding2">&nbsp;<span>当前资源无对应模型，需选择监控模型进行重新发现</span></li>
					<li style="width:80%;" class="margin5 padding2"><span style="float: left; padding-top:5px;">变更监控模型：</span><span>${groupSelect }<s:select list="alterResourceList" id="resourceSelect" name="resourceSelect" isSynchro="1" listKey="id" listValue="name" value="%{resourceId}" offsetWidth="150"></s:select></span></li>
				</s:if>
				<s:else>
					<li style="width:80%;" class="margin5 padding2">&nbsp;当前监控模型：<s:property value="resourceName"/></li>
					<li style="width:80%;" class="margin5 padding2"><span style="float: left;"><input type="checkbox" id="changeModuleONOFF">变更监控模型：</span><span>${groupSelect }</span><span><s:select list="alterResourceList" id="resourceSelect" name="resourceSelect" isSynchro="1" listKey="id" listValue="name" value="%{resourceId}" offsetWidth="150"></s:select></span></li>
				</s:else>
				<li style="width:80%;">
				  	<ul>
						<li class="margin3 padding2">
								<div class="greywhite-border padding5">
									<div class="h2"></span>发现信息</div>
									<div id="discovery-info-div" style="position:relative;">
										<s:action name="resource-instance-discoveryinfo" executeResult="true" namespace="/discovery" flush="false">
											<s:param name="resourceId" value="defaultResourceId" />
											<s:param name="instanceId" value="instanceId" />
										</s:action>
									</div>
								</div>
							</br>
							<span class="black-btn-l right" id="sp_discovery"><span class="btn-r"><span class="btn-m"><a >发现</a></span></span></span>
				       </li>
				    </ul>
				</li>
			</ul>
		</page:param>		  
	</page:applyDecorator>

	<div id="div_disc_result" style="display:none">
	    <page:applyDecorator name="accordionPanel">  
			<page:param name="id">panel_disc_result</page:param>
			<page:param name="title">发现结果</page:param>
			<page:param name="height"></page:param>
			<page:param name="width">95%</page:param>
			<page:param name="cls">fold</page:param>
			<page:param name="display"></page:param>
		  	<page:param name="content">
		  		<div id="disc_result">
					<page:applyDecorator name="resource-discovering">
						<page:param name="timeField">耗用时间</page:param>
						<page:param name="resultField">变更监控模型结果</page:param>
					</page:applyDecorator>
		  		</div>
			</page:param>		  
		</page:applyDecorator>
	</div>
	
	<div id="div_monitor_report" style="display:none">
	    <page:applyDecorator name="accordionPanel">  
			<page:param name="id">panel_monitor_report</page:param>
			<page:param name="title">监控报告</page:param>
			<page:param name="height"></page:param>
			<page:param name="width">95%</page:param>
			<page:param name="cls">fold</page:param>
			<page:param name="display"></page:param>
		  	<page:param name="content">
		  		<div class="h3">
					<span class="bold">加入监控：<span id="monitor_result"></span></span>
		  		</div>
		  		<div class="h3">
					<span class="bold">所属策略：<span id="profile_name">&nbsp;</span></span>
		  		</div>
			</page:param>		  
		</page:applyDecorator>
	</div>
  </page:param>
</page:applyDecorator>
</body>
</html>