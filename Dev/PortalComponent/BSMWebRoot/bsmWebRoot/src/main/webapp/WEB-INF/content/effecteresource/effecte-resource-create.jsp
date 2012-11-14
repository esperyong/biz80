<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- 
	@page : 事件资源合并设置.jsp 
	@auther : weiyi@rd.mochasoft.com.cn
--%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp"%>
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css" />
<script src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script src="${ctxJs}/jquery.blockUI.js"></script>
<script src="${ctx}/js/component/cfncc.js"></script>
<script src="${ctx}/js/component/gridPanel/grid.js"></script>
<script src="${ctx}/js/component/gridPanel/indexgrid.js"></script>
<script src="${ctx}/js/component/gridPanel/page.js"></script>
<script src="${ctx}/js/notification/comm.js"></script>
<script src="${ctx}/js/component/popwindow/popwin.js"></script>
<script>
		var path = "${ctx}";
		var pageCount = 1;
		var isEdit = ${queryVO.isEdit};
	</script>
<title>事件合并设置</title>
</head>
<body>
<%@ include file="/WEB-INF/common/loading.jsp"%>
<page:applyDecorator name="popwindow" title="事件合并设置">
	<page:param name="width">600px;</page:param>
	<page:param name="topBtn_index_1">1</page:param>
	<page:param name="topBtn_id_1">win-close</page:param>
	<page:param name="topBtn_css_1">win-ico win-close</page:param>
	<page:param name="topBtn_title_1">关闭</page:param>

	<page:param name="bottomBtn_index_1">1</page:param>
	<page:param name="bottomBtn_id_1">confirm_button</page:param>
	<page:param name="bottomBtn_text_1">确定</page:param>

	<page:param name="bottomBtn_index_2">2</page:param>
	<page:param name="bottomBtn_id_2">cancel_button</page:param>
	<page:param name="bottomBtn_text_2">取消</page:param>
	
	<page:param name="bottomBtn_index_3">3</page:param>
	<page:param name="bottomBtn_id_3">app_button</page:param>
	<page:param name="bottomBtn_text_3">应用</page:param>
	<page:param name="content">
		<form id="create_form" >
			<input type="hidden" name="effecteResRela.rootDevice" id="effecteResRela_rootDevice" value="${displayVO.rootDeviceId}"/>
			<input type="hidden" name="parentCategory" value="${displayVO.rootDeviceParentCategory}"/>
			<input type="hidden" name="queryVO.orderBy" value="resIpAddress"/>
			<input type="hidden" name="queryVO.resIp" value=""/>
			<input type="hidden" name="queryVO.resName" value=""/>
		<div class=h2><span class="ico ico-tips"></span><span>选择要进行事件合并的设备，以及被合并的影响设备。</span></div>
		<div class=margin8><span>选择根源设备：</span><span><input class="input-single" value="${displayVO.rootDeviceName}" id="rootDeviceName" size="50" /></span><span class=black-btn-l id="chooseRootDevice"><span class=btn-r><span class=btn-m><a onfocus="undefined">选择</a></span></span></span></div>
		<div class="margin8 fold-blue">
		<h1><span class="r-ico r-ico-delete" id="delRelDevice"></span><span class="r-ico r-ico-add" id="addRelDevice"></span><span>影响资源：</span></h1>
		 	 <page:applyDecorator name="indexcirgrid">
		      <page:param name="id">tableId</page:param>
		      <page:param name="height">300px</page:param>
		      <page:param name="tableCls"></page:param>
		      <page:param name="gridhead">[{colId:"resInstanceId", text:"<input type=\"checkbox\"/>"},{colId:"resIpAddress", text:"设备IP"},{colId:"resInstanceName", text:"设备名称"},{colId:"resInstanceCategory", text:"设备类型"}]</page:param>
		      <page:param name="gridcontent">${displayVO.content}</page:param>
		    </page:applyDecorator>
		</div>
		</form>
	</page:param>
</page:applyDecorator>
<script type="text/javascript">
$(document).ready(function(){
	if(!isEdit){
		$("#rootDeviceName").attr("disabled","true");
		$("#chooseRootDevice").attr("disabled","true");
	}
});
var columnW = {resInstanceId:"5",resIpAddress:"20",resInstanceName:"35",resInstanceCategory:"20",effecteInstance:"20"};
var gp = new GridPanel({id:"tableId",
	columnWidth:columnW,
	unit: "%",
	sortLisntenr:function($sort){
    }},{gridpanel_DomStruFn:"index_gridpanel_DomStruFn",gridpanel_DomCtrlFn:"index_gridpanel_DomCtrlFn",gridpanel_ComponetFn:"index_gridpanel_ComponetFn"});
gp.rend([{index:"resInstanceId",fn:function(td){
		if(td.html){
			var $r = $("<div></div>");
			$r.append($("<input type=\"checkbox\" value=\""+td.html+"\" >"));
			$r.append($("<input type=\"hidden\" name=\"effecteResRela.relaDevices\" value=\""+td.html+"\" >"));
		return $r;
		}
}},{index:"resInstanceName",fn:function(td){
	if(td.html){
		var text = td.html.split(",");
		var $r = $("<span title="+text[0]+">"+text[0]+"</span>");
	return $r;
	}
}},{index:"resIpAddress",fn:function(td){
	if(td.html){
		var ips = td.html.split(",");
		var $r ;
		if(ips.length > 1 ){
			$r = $("<select id='select_"+td.rowIndex+"'></select>");
			for(var index=0; index < ips.length ; index++){
				$r.append("<option value=\"" + ips[index] + "\" >" + ips[index] + "</option>");
			}
		}else{
			$r = $("<span title=\""+ips[0]+"\">"+ips[0]+"</span>");
		}
		return $r;}	
}},{index:"effecteInstance",fn:function(td){
	if(td.html){
		var $r = $("<span class=\"ico\" title="+td.html+" />");
		$r.click(function(){
				alert(td.html);
		})
		return $r;}	
}}]);
$("#confirm_button").click(function(){
	save(true);
});
$("#app_button").click(function(){
	//因为缺陷BSM8000013145修改
	//$("#rootDeviceName").attr("disabled","true");
	//$("#chooseRootDevice").attr("disabled","true");
	save(false);
});
function save(isclose){
	var data = $("#create_form").serialize();
	var url = path + "/effecteresource/effecteRes!editEffecteRela.action";
	$.ajax({
		type : 'POST',
		url  : url,
		data : data,
		success:function(){
				opener.reloadGrid();
				if(isclose){
					closeWin();
				}
				
		},
	   error:function(msg) {
			alert( msg.responseText);
	   }
	});
}
function createChooseDeviceWindow(isRoot,exceptIdArray){
	var isSingleSelection = isRoot;
	var idcode = "main";
	var reserveCategorys = "";
	if(!isRoot){
		idcode="relDevice";
		reserveCategorys = $("input[name='parentCategory']").val();
	}
	var $popForm = $("<form action= \"" + path + "/businesscomponent/resChoice.action\" method=\"post\" target=\"changeType\"></form>");
	$popForm.append($("<input type=\"hidden\" name=\"queryVO.isSingleSelection\" value=\"" + isSingleSelection + "\" />"));
	$popForm.append($("<input type=\"hidden\" name=\"queryVO.category\" value=\"device\" />"));
	$popForm.append($("<input type=\"hidden\" name=\"queryVO.isSystemAdmin\" value=\"true\" />"));
	$popForm.append($("<input type=\"hidden\" name=\"queryVO.userId\" value=\"user-000000000000001\" />"));
	$popForm.append($("<input type=\"hidden\" name=\"queryVO.domains\" value=\"no_choice\" />"));
	$popForm.append($("<input type=\"hidden\" name=\"queryVO.categoryLevel\" value=\"1\" />"));
	$popForm.append($("<input type=\"hidden\" name=\"queryVO.idcode\" value=\""+idcode+"\" />"));
	switch(reserveCategorys){
		case "networkdevice":$popForm.append($("<input type=\"hidden\" name=\"queryVO.reserveCategorys\" value=\"server\" />"))
							.append($("<input type=\"hidden\" name=\"queryVO.reserveCategorys\" value=\"networkdevice\" />"))
							.append($("<input type=\"hidden\" name=\"queryVO.reserveCategorys\" value=\"storage\" />"))
							.append($("<input type=\"hidden\" name=\"queryVO.reserveCategorys\" value=\"other\" />"))
							.append($("<input type=\"hidden\" name=\"queryVO.reserveCategorys\" value=\"application\" />"));
			break;
		case "server":$popForm.append($("<input type=\"hidden\" name=\"queryVO.reserveCategorys\" value=\"application\" />"));
			break;
		default:$popForm.append($("<input type=\"hidden\" name=\"queryVO.reserveCategorys\" value=\"server\" />"))
				.append($("<input type=\"hidden\" name=\"queryVO.reserveCategorys\" value=\"networkdevice\" />"));
	}
	if(exceptIdArray && exceptIdArray.length > 0){
		var length = exceptIdArray.length;
		for(var i = 0 ;i < length; i++){
			$popForm.append($("<input type=\"hidden\" name=\"queryVO.exceptInstanceIds\" value=\""+exceptIdArray[i]+"\" />"));
		}
	}
	$popForm.submit(function(){
		 var top = window.screen.height/2 - 450/2;
		 var left =  window.screen.width/2 - 700/2;
		 window.open('about:blank',"changeType", 'width=700,height=500,menubar=no,scrollbars=no,left='+left+',top='+top);
	});
	$popForm.appendTo("body");
	$popForm.submit();
	$popForm.remove();
}
function choiceResourceCallback(obj){
		var isRoot=false;
		if(obj.idcode && obj.idcode==="main"){
			isRoot = true;
		}else if(obj.idcode && obj.idcode==="relDevice"){
			
		}
		var url = path + "/effecteresource/effecteRes!" + (isRoot ? "rootDeviceName" : "refreshEffecteRelaJson" )+".action";
		var param;
		if(isRoot){
			param = "queryVO.queryValue=" + obj.resourceInstances[0];
		} else{
			param = $("#create_form").serialize();
			if(obj.resourceInstances && obj.resourceInstances.length && obj.resourceInstances.length > 0){
				for(var i =0;i<obj.resourceInstances.length;i++){
					param += "&effecteResRela.relaDevices="+obj.resourceInstances[i]
				}
			}
		}
		$.ajax({
			url : url,
			dataType:'json',
			data: param + "&queryVO.isReloadRelaDevice=" + isRoot,
			success: function(data, textStatus){
				if(isRoot){
					if(data.displayVO){
						$("#rootDeviceName").val(data.displayVO.rootDeviceName);
						$("#effecteResRela_rootDevice").val(data.displayVO.rootDeviceId);
						$("input[name='parentCategory']").val(data.displayVO.rootDeviceParentCategory);
					}else{
						alert("获取设备信息失败!");
					}
				}else{
					if(data.displayVO && data.displayVO.content){
						gp.loadGridData(data.displayVO.content);
					}else{
						alert("获取设备信息失败!");
					}
				}
			},error:function(e){
				alert("error");
				$("body").html(e.responseText);
			}
		});
}
$(function(){
	$("#rootDeviceName").focus(function(){
		$(this).blur();
	})
	$("#chooseRootDevice").click(function(){
			var ext = [];
			ext.push($("#effecteResRela_rootDevice").val());
		 createChooseDeviceWindow(true,ext);
	});
	$("#addRelDevice").click(function(){
		var ext = [];
		ext.push($("#effecteResRela_rootDevice").val());
		$(".roundedform-content").find("input","[colId=resInstanceId]").each(function(){
			ext.push($(this).val());
		})
		 createChooseDeviceWindow(false,ext);
	});
	$("#delRelDevice").click(function(){
		var confirm_process = new confirm_box({text:"此操作不可恢复，是否确认执行此操作？"});
		confirm_process.show();
		confirm_process.setConfirm_listener(function(){
			confirm_process.hide();
			$.blockUI({message:$('#loading')});
			var ins = $(".roundedform-content").find(":checkbox","[colId=resInstanceId]");
			param = "effecteResRela.rootDevice=" + $("#effecteResRela_rootDevice").val();
			for(var i =0;i < ins.length;i++){
				if(!$(ins[i]).attr("checked")){
					param += "&effecteResRela.relaDevices=" + $(ins[i]).val();
				}
			}
			param += "&queryVO.isReloadRelaDevice=false";
			//var data = $("#create_form").serialize();
			var url = path + "/effecteresource/effecteRes!refreshEffecteRelaJson.action";
			$.ajax({
				type : 'POST',
				url  : url,
				data : param,
				dataType:'json',
				success:function(data){
					if(data && data.displayVO && data.displayVO.content){
						gp.loadGridData(data.displayVO.content);
					}else{
						gp.loadGridData("[]");
					}
					$.unblockUI();
				},
			   error:function(msg) {
					   $("body").html(msg.responseText);
			   }
			});
				
		});
		confirm_process.setCancle_listener(function(){
			confirm_process.hide();
			});
	});
	$(".roundedform-top").find("input","[colId=resInstanceId]").click(function(){
		$(".roundedform-content").find("input","[colId=resInstanceId]").attr("checked",$(this).attr("checked"));
	});
	$(".roundedform-content").find("input","[colId=resInstanceId]").click(function(){
		if(!$(this).attr("checked")){
			$(".roundedform-top").find("input","[colId=resInstanceId]").attr("checked",$(this).attr("checked"));
		}
	});
});
</script>
</body>
</html>
