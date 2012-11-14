<!-- content/profile/userdefine/refreshIns.jsp -->
<%@page import="com.mocha.bsm.profile.type.alarm.SendAlarmFreqEnum"%>
<%@page import="com.mocha.bsm.commonrule.common.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<%@ include file="/WEB-INF/common/meta.jsp"%>
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css" />
</head>
<body>
<page:applyDecorator name="popwindow" title="刷新子资源">
	<page:param name="width">700px;</page:param>
	<page:param name="height">550px;</page:param>
	<page:param name="topBtn_index_1">1</page:param>
	<page:param name="topBtn_id_1">win-close</page:param>
	<page:param name="topBtn_css_1">win-ico win-close</page:param>
	<page:param name="topBtn_title_1">关闭</page:param>
	<page:param name="content">
	<form id="formname">
		<div class="fold-blue" style="overflow: auto; height: 550px;">
		<div class="fold-top"><span class="fold-top-title"> 选择资源 </span></div>
		<div class="padding8">
		<div class="margin3"><span class="ico ico-tips lineheight21"></span><span
			class=" lineheight21">点击‘刷新’按钮，系统将重新获取所选设备的子资源信息，获取成功的子资源将会自动加载到子策略的子资源列表中。</span></div>

		<table class="grayborder table-width100">
			<thead>
				<tr class="picmanage-title">
					<th class="vertical-middle bold" colspan="3" style="padding-left:10px;">
					<span class="ico ico-filter"></span>
					<span>
						<select name="searchType" id="searchType">
							<option value="ip">按IP</option>
							<option value="name">按名称</option>
						</select> 
					<input type="text" name="searchValue" id="searchValue" value="输入IP或名称过滤" onblur="trySet(this,'输入IP或名称过滤')" onfocus="tryClear(this,'输入IP或名称过滤')" /></span>
					<span class="ico ico-find"></span></th>
				</tr>
			</thead>
			<tbody id="selectItems">
				<tr class="fold-greybg">
					<td width="10%" class="fold-top-title"><input type="checkbox" id="allSelect"/></td>
					<td width="45%" class="fold-top-title">资源名称</td>
					<td width="45%" class="fold-top-title">IP地址</td>
				</tr>
				<s:iterator id="obj" value="instanceInfoList" status="st">
					<tr class="fold-greybg">
						<td><input type="checkbox" name="resInsSelect.instanceIds" value="${obj.id}"/></td>
						<td><s:property value="#obj.name"/></td>
						<td>
							<s:if test="#obj.ips.length > 1">
								<s:select list="#obj.ips" style="width:120px;"/>
							</s:if>
							<s:else>
								<s:property value="#obj.ips"/>
							</s:else>
						</td>
					</tr>
				</s:iterator>
			</tbody>
		</table>
		<div class="margin3"><span id="refresh" class="black-btn-l f-right"><span
			class="btn-r"><span class="btn-m"><a>刷新</a></span></span></span></div>
		</div>
		
		<!-- 刷新报告 START -->
		
		<div style="display:none;" id="report_div">
			<div class="fold-top"><span class="fold-top-title">刷新报告</span></div>
			<div id="loading_div">
			<div class="margin8">
				<p class="bold lineheight21"><span><span class="class="bold lineheight21"">耗用时间：</span><span id="compact">00:00:00</span></span></p>
				
				
				<div class=" grayborder padding5">
					<div class="find-center"><img id="imgLoading" src="${ctx}/images/loading.gif" /><br />
		            <span id="spLoading">0%</span></div>
				</div>
			</div>
			</div>
			<div id="refresh_result" class="margin8" style="display:none;"></div>
			<div class="margin3"><span class="black-btn-l right" id="finishButton"><span class="btn-r"><span class="btn-m"><a id="complete">完成</a></span></span></span></div>
		</div>
		<!-- 刷新报告 END -->
		
		
		</div>
	</form>
	</page:param>
</page:applyDecorator>
<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery.countdown.js" ></script>
<script type="text/javascript" src="${ctx}/js/profile/comm.js" ></script>
<script type="text/javascript" src="${ctx}/js/component/cfncc.js"></script> 
<script type="text/javascript" src="${ctx}/js/component/popwindow/popwin.js"></script>
<script>
$(function(){
	var percentInterval;
	var searchTip = "输入IP或名称过滤";
	var $spLoading = $("#spLoading");
	var $allSelect = $("#allSelect");
	var $instanceIds = $("input[name='resInsSelect.instanceIds']");
    var $report_div = $("#report_div");
    var $refresh_result = $("#refresh_result");
    var $loading_div = $("#loading_div");
    var $complete = $("#complete");
    var $compact = $('#compact');
	var $searchType = $('#searchType');
	var $searchValue = $('#searchValue');
	var $selectItems = $("#selectItems");
	var $refresh = $("#refresh");

	
	function startLoading() {
	 $spLoading.text("0%");
	 var percent = 1;
	 percentInterval = self.setInterval(function() {
	  if (percent <= 99) {
	   increasePercent(percent++);
	  }
	 },1000)
	}
	 
	function increasePercent(percent) {
	 $spLoading.text(percent + "%");
	}
	 
	function stopLoading() {
	 if (percentInterval != null) {
	  window.clearInterval(percentInterval);
	 }
	 $spLoading.text("100%");
	}

	function setAllSelect() {
		$allSelect.click(function() {
	    	$instanceIds.attr("checked",$allSelect.attr("checked"));
	    });
	}
	
	function setRecordCheckBox() {
		$instanceIds.click(function() {
		 	   var param = $(this).attr("checked");
		 	   if(param == false) {
		 		   $allSelect.attr("checked", false);
		 	   }
		});
	}

	function refresh() {
		$refresh.click(function() {
			if(!checkForm()) {
				return;
			}
			preProcess();
			var data =$('#formname').serialize();
			$("#finishButton").hide();
			$.ajax({
				method:'POST',
				url : '${ctx}/profile/userDefineProfile/childInsRefresh.action',
				data:data,
				dataType:"html",
				success:function(data){
					$refresh_result.empty().append(data);
					finishProcess();
					$("#finishButton").show();
				},
				error:function(msg) {
					alert( msg.responseText);
			   }
			});
			
		});
	}

	function checkForm() {
		$checkboxes = $("input[name=resInsSelect.instanceIds]:checked");
		var _information;
		if($checkboxes.length == 0) {
			_information = new information({text:"至少选择一个资源实例。"});
			_information.show();
			return false;
		}else if($checkboxes.length > 10) {
			_information = new information({text:"最多选择10个资源实例。"});
			_information.show();
			return false;
		}
		return true;
	}

	function preProcess() {
		setNoClick();
		$refresh_result.hide();
		$loading_div.show();
		$report_div.show();
		startLoading();
		calcTime();
	}
	function finishProcess() {
		$("#imgLoading").attr("src","${ctx}/images/loading-end.gif");
		stopLoading();
		$compact.countdown("pause");
		$refresh_result.show();
		recoverClick();
		//$loading_div.hide();
	}

	function complete() {
		$complete.click(function() {
	      window.opener = null;
	      window.open("", "_self");
	      window.close();
		});
	}

	function calcTime() {
		$compact.countdown("destroy");
		$compact.countdown( {
		   since : 0,
		   format : 'HMS',
		   compact : true,
		   description : ''
		});
	}

	function setNoClick() {
		$refresh.unbind();
		$refresh.removeClass("black-btn-l f-right");
		$refresh.addClass("black-btn-l-off f-right");
	}
	function recoverClick() {
		refresh();
		$refresh.removeClass("black-btn-l-off f-right");
		$refresh.addClass("black-btn-l f-right");
	};
	
	function search() {
		$(".ico-find").click(function(){
			if($searchValue.val() == searchTip || $searchValue.val() == "") {
				//alert("请输入查询条件。");
				$items = $selectItems.find("tr[class!=line]");
				$items.show();
				return;
			}
			
			$items = $selectItems.find("tr[class!=line]");
			$items.hide();
			if($searchType.val() =="name") {
				$items.each(function(i,entiry){
					var name = $($(entiry).find("td").get(1)).text();
					if(name.indexOf($searchValue.val()) > -1) {
						$(entiry).show();
					}
				});
			}else {
				$items.each(function(i,entiry){
					var name = $($(entiry).find("td").get(2)).html();
					if(name.indexOf($searchValue.val()) > -1) {
						$(entiry).show();
					}
				});
			}
		});
			
	}
	  
	function init() {
		setAllSelect();
		setRecordCheckBox();
		refresh();
		complete();
		search();
	}

	init();	
});

function trySet(obj,txt){
	if(obj.value==""){
		obj.value = txt;
	}
}
function tryClear(obj,txt){
	if(obj.value==txt){
		obj.value = '';
	}
}
</script>
</body>
</html>