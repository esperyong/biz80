<%@page import="com.mocha.bsm.profile.type.alarm.SendAlarmFreqEnum"%>
<%@page import="com.mocha.bsm.commonrule.common.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
  <%@ include file="/WEB-INF/common/loading.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<%@ include file="/WEB-INF/common/meta.jsp"%>
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css" />
</head>
<body>
<page:applyDecorator name="popwindow" title="添加进程">
	<page:param name="width">700px;</page:param>
	<page:param name="height">550px;</page:param>
	<page:param name="topBtn_index_1">1</page:param>
	<page:param name="topBtn_id_1">win-close</page:param>
	<page:param name="topBtn_css_1">win-ico win-close</page:param>
	<page:param name="topBtn_title_1">关闭</page:param>
	<page:param name="content">
	
		<div class="fold-blue" style="overflow: auto; height: 550px;">
		<div class="fold-top"><span class="fold-top-title"> 选择主机 </span></div>
		<div class="padding8">
		<div class="margin3"><span class="ico ico-tips lineheight21"></span><span
			class=" lineheight21">选择主机，刷新出所选主机的进程，选择进程加入策略监控。</span></div>
		<div class="margin3"><span>请选择主机：</span>
		<select id="instanceSel" name="instanceId"
      <s:if test="customTag=='custom'">disabled</s:if>
      >
		<s:iterator id="obj" value="instanceInfoList" status="st">
		<option value="${obj.id}"><s:property value="#obj.name"/></option>
		</s:iterator>
		</select>
    <s:if test="customTag!='custom'">
		<span class="red">*请选择设备获取进程列表</span></div>
		</s:if>
		<div class="margin3"><span id="refresh" class="black-btn-l f-right"><span
			class="btn-r"><span class="btn-m"><a>获取进程</a></span></span></span></div>
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
			<form id="addControl">
			<div id="refresh_result" class="margin8" style="display:none;"></div>
			<input type="hidden" value="${resId}" name="resId" id="resId"/>
			<div class="margin3">
				
				<span class="black-btn-l right" id="finishButton">
					<span class="btn-r">
						<span class="btn-m">
						<a id="complete">关闭</a>
						</span>
					</span>
				</span>
				<span class="black-btn-l right" id="addButton">
					<span class="btn-r">
						<span class="btn-m">
						<a id="addProcess">加入策略</a>
						</span>
					</span>
				</span>
			</div>
			</form>
		</div>
		<!-- 刷新报告 END -->
		
		
		</div>
	
	</page:param>
</page:applyDecorator>
<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery.countdown.js" ></script>
<script type="text/javascript" src="${ctxJs}/jquery.blockUI.js"></script>
<script type="text/javascript" src="${ctx}/js/profile/comm.js" ></script>
<script type="text/javascript" src="${ctx}/js/component/cfncc.js"></script> 
<script type="text/javascript" src="${ctx}/js/component/popwindow/popwin.js"></script>
<script>
$(function(){
  
	var percentInterval;
	var searchTip = "输入IP或名称过滤";
	var $spLoading = $("#spLoading");
	var $allSelect = $("#proessId");
	var $instanceIds = $("input[name=processPath]");
    var $report_div = $("#report_div");
    var $refresh_result = $("#refresh_result");
    var $loading_div = $("#loading_div");
    var $complete = $("#complete");
    var $compact = $('#compact');
    var $addProcess = $('#addProcess');
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
			/*
			if(!checkForm()) {
				return;
			}
			*/
			preProcess();
      var instanceId = $("#instanceSel").val();
			$("#finishButton").hide();
			$("#addButton").hide();
			$.ajax({
				method:'POST',
				url : '${ctx}/profile/userDefineProfile/childInsProcessRefresh.action?instanceId='+instanceId+'&resId=${resId}',
				dataType:"html",
				success:function(data){
					$refresh_result.empty().append(data);
					finishProcess();
					$("#finishButton").show();
					$("#addButton").show();
				},
				error:function(msg) {
					alert( msg.responseText);
			   }
			});
			
		});
	}

	function addProcess() {
		$addProcess.click(function() {
      if(!checkForm()) {
				return;
			}
      $.blockUI({message:$('#loading')});
			var instanceId = $("#instanceSel").val();
			var data =$('#addControl').serialize();
			$.ajax({
				method:'POST',
				url : '${ctx}/profile/userDefineProfile/processAddControl.action?instanceId='+instanceId,
				data:data,
				dataType:"html",
				success:function(data){
          $.unblockUI();
					window.opener.location.href=window.opener.location.href;
          window.opener = null;
	        window.open("", "_self");
	        window.close();
				},
				error:function(msg) {
					alert( msg.responseText);
			   }
			});
			
		});
	}

	function checkForm() {
		$checkboxes = $("input[name='processPath']:checked");
    var data =$('#addControl').serialize();
		var _information;
		if($checkboxes.length == 0 || data.indexOf("processPath") == -1) {
			_information = new information({text:"至少选择一个资源实例。"});
			_information.show();
			return false;
		}
		/*
		else if($checkboxes.length > 10) {
			_information = new information({text:"最多选择10个资源实例。"});
			_information.show();
			return false;
		}
		*/
		return true;
	}

	function preProcess() {
    $("#imgLoading").attr("src","${ctx}/images/loading.gif");
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
		//setAllSelect();
		//setRecordCheckBox();
    addProcess();
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