<!-- content/profile/custom/batchMetricSeting.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/WEB-INF/common/meta.jsp" %>
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css" />

<script src="${ctxJs}/jquery-1.4.2.min.js"></script>
<script src="${ctxJs}/component/cfncc.js"></script>
<script src="${ctxJs}/component/panel/panel.js"></script>
<script src="${ctxJs}/component/toast/Toast.js"></script>
<script src="${ctxJs}/component/slider/slider.js"></script>
<script src="${ctxJs}/jquery.blockUI.js"></script>
<script type="text/javascript" src="${ctx}/js/profile/comm.js"></script>
<script src="${ctxJs}/component/comm/winopen.js"></script>
<script src="${ctxJs}/profile/userdefine/frequencyPanel.js"> </script>

<script type="text/javascript">
var path = "${ctx}";
</script>
</head>
<body>
<%@ include file="/WEB-INF/common/loading.jsp" %>
<form id='resInsform'>
<input type="hidden" name="instanceId" value="${instanceId}" id="instanceId"/> 
<input type="hidden" name="resourceId" value="${resourceId}" id="resourceId" /> 
<input type="hidden" name="profileId" value="${profileId}" id="profileId" /> 

<page:applyDecorator name="popwindow" title="批量设置 - ${resName}监控项">
	<page:param name="width">710px;</page:param>
	<page:param name="height">410px;</page:param>
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
	<page:param name="content">
		<div id="metric_div" style="height:410px;overflow:auto" class="f-relative">
	     	<s:action name="queryBatchSetMetrics" executeResult="true" ignoreContextParams="false" flush="false" namespace="/profile/customProfile">
				<s:param name="resourceId" value="resourceId"></s:param>
			</s:action>
		</div>
	</page:param>
</page:applyDecorator>
</form>
<script type="text/javascript">
$(function(){
	$.blockUI({message:$('#loading')});
	//阈值
	$('.cue-min').click(function(event){
		thresholdEvent(this,event.pageX,event.pageY);
	});
	$("#confirm_button").click(function(){
		$.blockUI({message:$('#loading')});
		var data = $('#resInsform').serialize();
		$.ajax({
			type:"post",
			cache:false,
			url:path + "/profile/customProfile/saveBatchSetMetrics.action",
			data:data,
			success:function(){
				window.close();
			},failed:function(){
				alert(msg.responseText);
			}
		})
	});

	function thresholdEvent(tag,x,y){
		var self = $(tag);
		var $redValue = self.parent().children('[value=red]').next();
		var unit = self.parent().children('[value=red]').prev().prev().val();
		var $yellowValue = self.parent().children('[value=yellow]').next();
		SliberPanel.create($redValue.val(),$yellowValue.val(),unit,function(obj){
			var rheight = 30;
			var yheight = 60;
			if('%'===unit){
				rheight = 100-obj.red;
				yheight = 100-obj.yellow;
			}
	
			self.children("div.cue-content").find("span.cue-min-red").css("height",rheight+'%')
			.children("span").text(obj.red+unit);
			self.children("div.cue-content").find("span.cue-min-yellow").css("height",yheight+'%')
			.children("span").text(obj.yellow+unit);
			var rTag = $(self.children("div.cue-content").find(".cue-min-note-red")[0]);
			var yTag = $(self.children("div.cue-content").find(".cue-min-note-yellow")[0]);
			
			revise(rTag,yTag);
			$redValue.val(obj.red);
			$redValue.next().val(true);
			$redValue.change();
			$yellowValue.val(obj.yellow);
			$yellowValue.next().val(true);
			$yellowValue.change();
		},x,y);
	}
	
	function revise(redTag,yeTag){
		var rTop = redTag.position().top;
		var yTop = yeTag.position().top;
		if(yTop < rTop+redTag.height()){
			redTag.css("margin-bottom" , redTag.height() / 2);
			yeTag.css("margin-top" , redTag.height());
		}
		
	}
	/**
	*	修改内容时调用此方法修改监听变量.
	**/
	function setChangeContent(){
		$(':input').bind('change',function(){
			var name = $(this).attr('name');
			var haveChange = $(this).parentsUntil('table').parent().prev().children("[name$=haveChange]");
			haveChange.val(true);
			if(name == 'monitor'){
				$(this).next().val($(this).is(':checked'));
			}else if(name == 'critical'){
  			var tag = $(this).is(':checked');
  			$(this).next().val(tag);
  			if(tag){
  				$(this).parent().parent().find("div[name=cue_min]").attr("disabled","");
  				$(this).parent().parent().find("ul[name=eventName_ul]").attr("disabled","");
  				$(this).parent().parent().find("ul[name=notification_ul]").attr("disabled","");
          $(this).parent().parent().find("ul[name=event_ul]").attr("disabled","");
          $(this).parent().parent().find("span[name=metric_number]").attr("disabled","");
  				//$(this).parent().parent().find("span[id=setting]").attr("disabled","").attr("class","ico ico-equipment");
  			}else{
  				$(this).parent().parent().find("div[name=cue_min]").attr("disabled","disabled");
  				$(this).parent().parent().find("ul[name=eventName_ul]").attr("disabled","disabled");
  				$(this).parent().parent().find("ul[name=notification_ul]").attr("disabled","disabled");
          $(this).parent().parent().find("ul[name=event_ul]").attr("disabled","disabled");
          $(this).parent().parent().find("span[name=metric_number]").attr("disabled","disabled");
  				//$(this).parent().parent().find("span[id=setting]").attr("disabled","disabled").attr("class","ico ico-equipment-off");
  			}
      //			$(this).next().next().val(true);
		  }else if(name.indexOf('frequencyId')>0){
				$(this).next().val(true);
			}else if(name.indexOf('notification')>0){
				var $haveChange = $(this).parent().parent().parent().prev().find("input[name$=haveChange]");
				$haveChange.val(true);
			}else if(name.indexOf('severityId')>0){
				$(this).next().val(true);
			}
			//设置指标组监扣变量
			//$(this).parentsUntil('li[id=metricgroup_next]').parent().prev().children("[name$=haveChange]").val(true);
			$(this).parentsUntil('li[id=metricgroup_next]').parent().parent().find("li[name=metric_group]").children("[name$=haveChange]").val(true);
		});
	}

	function whetherAlarm() {
		$("input[flag='whetherAlarm']").click(function(){
			if($(this).attr("checked") == false) {
				$("#alarmAllSelect").attr("checked",false);
			}
		});
	}

	function allSelectAlarm() {
		$("#alarmAllSelect").click(function(){
			var array = $("input[flag='whetherAlarm']");
			var checkState = $("#alarmAllSelect").attr("checked");
			var flag = false;
			array.each(function(i,e) {
				$(e).attr("checked", checkState);
				var $haveChange = $(e).parent().parent().parent().prev().find("input[name$=haveChange]");
				$haveChange.val(true);
				if(!flag) {
					$(e).parentsUntil('li[id=metricgroup_next]').parent().prev().children("[name$=haveChange]").val(true);
				}	
			});
		});
	}
	var allSelectMonitor = function() {
		$("#monitorAllSelect").click(function(){
	    var array = $("input[name=monitor]:enabled");
	    var checkState = $(this).attr("checked");
	    var flag = false;
			array.each(function(i,e) {
				$(e).attr("checked", checkState);
	      $(e).next().val(checkState);
				var $haveChange = $(e).parent().parent().parent().prev().find("input[name$=haveChange]");
				$haveChange.val(true);
				if(!flag) {
					$(e).parentsUntil('li[id=metricgroup_next]').parent().prev().children("[name$=haveChange]").val(true);
				}	
			});
	   // $("input[name=monitor]:enabled").attr("checked",$(this).attr("checked")).change();
		});
	}
	var allSelectCritical = function() {
		$("#criticalAllSelect").click(function(){
	    var array = $("input[name=critical]:enabled");
	    var checkState = $(this).attr("checked");
	    var flag = false;
			array.each(function(i,e) {
				$(e).attr("checked", checkState);
	      $(e).next().val(checkState);
				var $haveChange = $(e).parent().parent().parent().prev().find("input[name$=haveChange]");
				$haveChange.val(true);
				if(!flag) {
					$(e).parentsUntil('li[id=metricgroup_next]').parent().prev().children("[name$=haveChange]").val(true);
				}	
			});
	   // $("input[name=monitor]:enabled").attr("checked",$(this).attr("checked")).change();
		});
	}
	function advSettingClick() {
		var $advSetting = $('td[id=advSetting]');
		var $settingTitle = $('#setting_title');
		$advSetting.each(function(){
			$($(this).parent().children().get(0)).attr("width","10%");
			$($(this).parent().children().get(4)).attr("width","15%");
			$($(this).parent().children().get(5)).attr("width","17%");
		});
		$($settingTitle.parent().children().get(0)).attr("width","10%");
		$($settingTitle.parent().children().get(4)).attr("width","15%");
		$($settingTitle.parent().children().get(5)).attr("width","15%");
		$advSetting.remove();
		$settingTitle.remove();
	}
	advSettingClick();
	setChangeContent();
	whetherAlarm();
	allSelectAlarm();
	allSelectMonitor();
	allSelectCritical();
	$.unblockUI();
});
</script>
</body>
</html>