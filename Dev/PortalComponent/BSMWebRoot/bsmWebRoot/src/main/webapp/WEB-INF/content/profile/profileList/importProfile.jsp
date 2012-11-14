<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp"%>
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css" />
<style type="text/css">
.example {/* make the box translucent (80% opaque) */
height:30px;
width:0px;
cursor:pointer;
opacity: 0; /* Firefox， Safari(WebKit)， Opera */

-ms-filter: alpha(opacity=0); /* IE 8 */

filter: alpha(opacity=0); /* IE 4-7 */

zoom: 1;/* set zoom， width or height to trigger hasLayout in IE 7 and lower */
}
</style>
</head>
<body>
<%@ include file="/WEB-INF/common/loading.jsp" %>

<page:applyDecorator name="popwindow" title="策略导入">
	<page:param name="width">480px;</page:param>
	<page:param name="height">340px;</page:param>
	<page:param name="topBtn_index_1">1</page:param>
	<page:param name="topBtn_id_1">win-close</page:param>
	<page:param name="topBtn_css_1">win-ico win-close</page:param>
	<page:param name="topBtn_title_1">关闭</page:param>
	
	<page:param name="bottomBtn_index_1">1</page:param>
	<page:param name="bottomBtn_id_1">import_button</page:param>
	<page:param name="bottomBtn_text_1">导入</page:param>
	<page:param name="bottomBtn_index_2">2</page:param>
	<page:param name="bottomBtn_id_2">cancel_button</page:param>
	<page:param name="bottomBtn_text_2">取消</page:param>
	<page:param name="bottomBtn_index_3">3</page:param>
	<page:param name="bottomBtn_id_3">confirm_button</page:param>
	<page:param name="bottomBtn_text_3">确定</page:param>
	<page:param name="content">
	<form name="uploadform" id="uploadform" enctype="multipart/form-data">
	<div id="uploadDiv">
	<div class="fold-blue">
        <div class="fold-top"><span class="fold-top-title">选择文件</span></div>
  		<div class="margin8">
     		<span class="ico ico-tips"></span><span>导入文件必须为BSM导出的profile文件，导入即可创建新策略。</span>
  		</div>
  		<div class="margin8">
  			<ul class="fieldlist">
  			<li>
  				<span class="field" style="float:left;"><s:property value="@com.mocha.bsm.profile.business.admin.DomainMgr@getDomainTitle()"/></span>
  				<span style="float:left;"><s:text name="i18n.profile.colon"/>&nbsp;</span>
  				<span style="float:left;"><s:select name="domainId"  id="domainId" list="userDomainList" listKey="key"  listValue="value" style="width:130px;"/></span>
     		</li>
     		<li>
  				<span class="field" style="float:left;">选择文件</span>
  				<span style="float:left;"><s:text name="i18n.profile.colon"/></span>
  				<span style="float:left;"><input type="file" name="myFile" id="browseButton" size="40"/></span>
     		</li>
     		</ul>
<!--     		<span class="gray-btn-l"><span class="btn-r"><span class="btn-m"><a>刷新</a></span></span></span>-->
  		</div>
	</div>
	<!-- 刷新报告 START -->
	<div class="fold-blue">
	<div class="fold-top" id="importResult"><span class="fold-top-title">导入结果</span></div>
	<div style="display:none;" id="report_div">
			
		<div id="loading_div">
		<div class="margin8">
			<p class="bold lineheight21"><span><span class="bold lineheight21">耗用时间：</span><span id="compact">00:00:00</span></span></p>
			
			
			<div class=" grayborder padding5">
				<div class="find-center"><img id="imgLoading" src="${ctx}/images/loading.gif" /><br />
	            <span id="spLoading">0%</span></div>
			</div>
		</div>
		</div>
		<div id="uploadResultDiv" style="display:none;"></div>
	</div>
	</div>
<!--		<div class="margin3"><span class="black-btn-l right"><span class="btn-r"><span class="btn-m"><a id="complete">完成</a></span></span></span></div>-->
	<!-- 刷新报告 END -->
<!--	<div id="uploadStepInfoDiv">-->
<!--	-->
<!--	</div>-->
	</form>
	</page:param>
</page:applyDecorator>
<script src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script src="${ctx}/js/jquery.form.js"></script>
<script src="${ctx}/js/component/plugins/jquery.ui.core.js"></script>
<script src="${ctx}/js/component/plugins/jquery.ui.widget.js"></script>
<script src="${ctx}/js/component/plugins/jquery.ui.mouse.js"></script>
<script src="${ctx}/js/component/plugins/jquery.ui.draggable.js"></script>
<script src="${ctx}/js/component/cfncc.js"></script>
<script src="${ctx}/js/jquery.blockUI.js" type="text/javascript"></script>
<script src="${ctx}/js/jquery.countdown.js" ></script>
<script src="${ctx}/js/profile/comm.js" ></script>
<script src="${ctx}/js/component/combobox/simplebox.js"></script>
<script src="${ctx}/js/component/popwindow/popwin.js"></script>
<script>
var isImporting = true;
var path = "${ctx}";
var num = 0;
var time = 0;
var submitFlag = false;
$(function(){
	var $import_button = $("#import_button");
	var $cancel_button = $("#cancel_button");
	var $confirm_button = $("#confirm_button");
	var $fileInput = $("input[name=myFile]");
	var $uploadform = $('#uploadform');
	var $uploadDiv = $('#uploadDiv');
	var $uploadResultDiv = $('#uploadResultDiv');
	var $uploadStepInfoDiv = $('#uploadStepInfoDiv');
	var $report_div = $('#report_div');
	var $spLoading = $("#spLoading");
	var $compact = $('#compact');
	var $importResult = $("#importResult");
	
	$("#win-close").unbind().bind('click',function(){
		if(isImporting){
			closeWin();
		}else{
			var _information = new information({text:"正在进行导入，请完成后再执行关闭操作。"});
			_information.show();
		}
	});
	
	$confirm_button.hide();
	$importResult.hide();
	$import_button.click(function() {
		var value = $fileInput.val();
		if(value == "") {
			var _information = new information({text:"请选择一个文件"});
			_information.show();
		}else if(!RegExp("\.(" + ["obj"].join("|") + ")$", "i").test(value)){
			var _information = new information({text:"文件类型错误"});
			_information.show();
		}else {
			$.blockUI({message:$('#loading')});
			isImporting = false;
			$importResult.show();
			$cancel_button.hide();
			if(submitFlag) {
				var _information = new information({text:"正在导入，请稍候..."});
				_information.show();
				return;
			}else {
				submitFlag = true;
			}
			preProcess();
			$uploadform.ajaxSubmit({
				url: path+"/profile/profileImport.action",//表单的action
				method: 'POST',
				dataType:"html",
				success:function(data){
					finishProcess(data);
					$import_button.hide();
					$cancel_button.hide();
					$confirm_button.show().click(function(){
						try{
							opener.userDefineProfileRefresh();
						 }catch(e) {
						  
						 }
						window.opener = null;
						window.open("", "_self");
						window.close();
					});
					isImporting = true;
					$.unblockUI();
				},
			    error:function(msg) {
					isImporting = true;
					alert(msg.responseText);
			    }
			});
			//num = setInterval(function(){logDisplay();},200);
		}
	});

	function logDisplay() {
		$.ajax({
			type:"POST",
			dataType:'json',
			url:path+"/profile/queryImportStepInfo.action",
			success:function(data, textStatus){
				var logInfo = data.stepInfo;
				if("finish" == logInfo){
					//clearInterval(num);
					$uploadStepInfoDiv.append("操作结束");
				}else if("" != logInfo){
					$uploadStepInfoDiv.append(logInfo).append("<br>");
				}
			}
		});
	}
	function setDisplayStyle(oTarget,display) {
		oTarget.css("display",display);
	}

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
	 $spLoading.text("导入完成.");
	}

	function preProcess() {
		$report_div.show();
		startLoading();
		calcTime();
		$uploadResultDiv.hide();
	}
	function finishProcess(data) {
		stopLoading();
		$compact.countdown("pause");
		$uploadResultDiv.html("").append(data);
		$uploadResultDiv.show();
		submitFlag = false;
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
	var selectIdArray = new Array("domainId");
	SimpleBox.renderTo(selectIdArray);
});


</script>
</body>
</html>