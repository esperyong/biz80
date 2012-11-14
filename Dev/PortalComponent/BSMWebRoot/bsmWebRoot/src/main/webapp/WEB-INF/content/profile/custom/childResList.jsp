<!-- content/profile/userdefine/childResList.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/WEB-INF/common/meta.jsp" %>
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css"></link>
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" ></link>
<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css" />
<script src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script src="${ctx}/js/component/cfncc.js"></script>
<script src="${ctx}/js/jquery.blockUI.js"></script>
<script src="${ctx}/js/component/comm/winopen.js"></script>
<script src="${ctx}/js/component/panel/panel.js"></script>
<script src="${ctx}/js/component/toast/Toast.js"></script>
<script src="${ctx}/js/component/slider/slider.js"></script>
<script src="${ctx}/js/profile/comm.js"></script>
<script src="${ctx}/js/component/gridPanel/page.js"></script>
<script src="${ctx}/js/component/gridPanel/grid.js"></script>
<script src="${ctx}/js/component/gridPanel/indexgrid.js"></script>
<script src="${ctx}/js/component/popwindow/popwin.js"></script>
<%--个性化高级设置页面. --%>
<style type="text/css">
.monitor-items-list tbody tr td{
	vertical-align: middle;
	text-align: center;
}
.monitor-items-head thead tr th{
	vertical-align: middle;
	text-align: center;
}
.monitor-items th{
text-align: center;
vertical-align: middle;
}
.monitor-items td{
text-align: center;
vertical-align: middle;
}
</style>
<script type="text/javascript">
var path = "${ctx}";
</script>
</head>
<body>
<%@ include file="/WEB-INF/common/loading.jsp" %>
<form id='resInsform'>
<input type="hidden" name="instanceId" value="${instanceId}" />
<input type="hidden" name="resourceId" value="${resourceId}" id="resourceId"/>
<page:applyDecorator name="popwindow"  title="高级设置 - ${resName}监控项">
	
	<page:param name="width">710px;</page:param>
	<page:param name="height">440px;</page:param>
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
  <div style="overflow: auto;height:100%;position:relative;">
	<div class="h2">
    	<span class="black-btn-l right" id="recoverDefaultMetric" ><span class="btn-r"><span class="btn-m"><a>恢复为默认值</a></span></span></span>
    	<span class="black-btn-l right" id="refresh" ><span class="btn-r"><span class="btn-m"><a>刷新</a></span></span></span>
      <span class="black-btn-l right" id="delProgress"  style="display:none;"><span class="btn-r"><span class="btn-m"><a>删除进程</a></span></span></span>
      <span class="black-btn-l right" id="addProgress"  style="display:none;"><span class="btn-r"><span class="btn-m"><a>添加进程</a></span></span></span>
    	<span class="sub-panel-tips"></span>
    	<span class="txt" id="noProgressMess">说明：要刷新设备上的${resName}列表，请点击“刷新”按钮。</span>
      <span class="txt" id="progressMess" style="display:none;">点击“添加${resName}”将进程添加监控</span>
    </div>
    <ul  class="monitor-items" id="monitorMetricSetting">
	     <li>
	     <table class="monitor-items-head" >
  			<thead><tr>
  			<th width="9%"><input type="checkbox" name="checkAllResource"/>全选</th>
  			<th width="16%"><input type="checkbox" name="checkAllMetric"/>是否监控</th>
  			<th width="45%" style="text-align: left;">${resName}</th>
  			<th width="7%">&nbsp;</th>
  			<th width="8%">备注</th>
  			<th width="15%">恢复为默认值</th>
  			</tr></thead></table>
	     </li>
	     <s:iterator value="childResInsList" id="ins" status="st1">
	     <li index="<s:property value="#st1.index"/>">
	     <div style="display: none;" id="childResIns_${st1.index}" name="hiddenDiv">
	     	<input type="hidden" name="childResInsList[${st1.index}].profileId" value="${ins.profileId}"/>
	     	<input type="hidden" name="childResInsList[${st1.index}].instanceId" value="${ins.instanceId}"/>
	     	<input type="hidden" name="childResInsList[${st1.index}].haveChange" value="${ins.haveChange}"/>
	     </div>
	     <table class="monitor-items-list" index="${st1.index}" profileId="${ins.profileId}" instanceId="${ins.instanceId}">
	     <tbody><tr>
	     <%--是否刷新或恢复默认值 --%>
	     <td width="8%"><input type="checkbox" name="childrenIds" value="${ins.profileId}"/></td>
	     <%-- 是否监控 --%>
	     <td width="17%" instanceId="${ins.instanceId}">
	     	<input type="hidden" name="childResInsList[${st1.index}].monitor" value="${ins.monitor}"/>
	     	<input type="checkbox"  <s:if test="!#metric.notEditMonitor">disabled="disabled"</s:if> <s:if test="#ins.monitor">checked="checked"</s:if> name="isMonitor"/>
	     </td>
	     <%-- 设备名称 --%>
	     <td width="43%" style="text-align: left;">
	     <div style="width: 300px; text-overflow: ellipsis; overflow: hidden;" title="<s:property value="#ins.instanceName"/>"><nobr>
       <s:if test="#ins.state == 'ico ico-backplane-nomonitoring'">
           <span class="ico ico-backplane-normal" style="text-align: left;cursor:none;"></span>
       </s:if><s:else>
          <span class="<s:property value="#ins.state"/>" style="text-align: left;cursor:none;"></span>
       </s:else>
       <s:property value="#ins.instanceName"/>
	     </nobr></div>
	     </td>
	     <%-- 指标按钮 --%>
	     <td width="7%"><span class="monitor-ico monitor-ico-open"></span></td>
	     <%-- 备注 --%>
	     <td width="8%"><span class="ico ico-file" paramterId="${ins.instanceId}"></span></td>
	     <%-- 恢复默认值 --%>
	     <td width="15%"><span class="gray-btn-l right" pid="singleRecover" ><span class="btn-r"><span class="btn-m"><a>恢复为默认值</a></span></span></span></td>
	     </tr></tbody>
	     </table>
	     <div class="monitor-target" style="display: none;"></div>
	     </li>
	     </s:iterator>
	</ul>	
  </div>
	</page:param>
</page:applyDecorator>
</form>
<script type="text/javascript">
var win = null;
var wp = null;
$(function(){
  $('#addProgress').click(function(){
		var profileId = "${profileId}";
		var resourceId = "${resourceId}";
		var winOpenObj = {};
		winOpenObj.height = '600';
		winOpenObj.width = '700';
		winOpenObj.name = 'refreshProcessIns';
		winOpenObj.url = path + '/profile/userDefineProfile/forwardProessPage.action?profileId='+profileId+'&resId='+resourceId+'&customTag=custom';
		winOpenObj.scrollable = false;
		winOpen(winOpenObj);
		
	});
  function checkForm() {
	$checkboxes = $("input[name='childrenIds']:checked");
	var _information;
	if($checkboxes.length == 0) {
		_information = new information({text:"至少选择一个进程。"});
		_information.show();
		return false;
	}
	return true;
}
  $('#delProgress').click(function(){

		if(!checkForm()) {
			return;
		}
		var confirm_process = new confirm_box({text:"是否确认删除所选进程？"});
		confirm_process.show();
		confirm_process.setConfirm_listener(function(){
		confirm_process.hide();
			$checkboxes = $("input[name='childrenIds']:checked");
			var instanceIds = "";
			for(var i=0 ; i < $checkboxes.length ; i++){
        checkb=$($checkboxes[i]);
					if(instanceIds == ""){
						instanceIds = checkb.parents("table").attr("instanceId");
					}else{
						instanceIds += ";"+checkb.parents("table").attr("instanceId");
						}
				}
        
			$.blockUI({message:$('#loading')});
			$.ajax({
				method:'POST',
				url : '${ctx}/profile/userDefineProfile/removeProcess.action?instanceId='+instanceIds,
				dataType:"json",
				success:function(data){
					$.unblockUI();
          window.location.href=window.location.href;
				},
				error:function(msg) {
					alert( msg.responseText);
			   }
			});
    	});
		confirm_process.setCancle_listener(function(){
			confirm_process.hide();
			});
	
	});
  showProcess();
	win = new confirm_box({title:'提示',text:'',cancle_listener:function(){win.hide();}});
	$(".monitor-ico-open").bind('click', function(){show(this);});
	$(".monitor-ico-close").bind('click', function(){hide(this);});
	//阈值
	$('.cue-min').click(function(event){
		thresholdEvent(this,event.pageX,event.pageY);
	});
	$("#confirm_button").click(function(){
		var data = $('#resInsform').serialize();
		$.ajax({
			type:"post",
			cache:false,
			url:path + "/profile/customProfile/saveChildIns.action",
			data:data,
			success:function(){
				//parent.opener.location.href = parent.opener.location.href;
				window.close();
			},failed:function(){
				//window.location.href = window.location.href;
			}
		})
	});
	$(':input').blur();
	$(':input').bind('change',function(){
		changeContent(this);
	});
	$('#recoverDefaultMetric').click(function(){
		if($("input[name=childrenIds]:checked").length == 0) {
			var _information = new information({text:"请至少选择一项。"});
			_information.show();
			return;
		}
		win.setContentText('此操作将覆盖所做的设置，并立即生效，是否确认执行？');
		win.setConfirm_listener(function(){
			win.hide();
			$.blockUI({message:$('#loading')});
			var data = $('#resInsform').serialize();
			$.ajax({
				type:"post",
				cache:false,
				url:path+"/profile/customProfile/recoverDefaultMetric.action",
				data:data,
				success:function(){
					$.unblockUI();
					window.location.href = window.location.href;
				}
			});
		});
		win.show();
		
	});
	$('#refresh').click(function(){
		$.blockUI({message:$('#loading')});
		var data = $('#resInsform').serialize();
		$.ajax({
			type:"POST",
			cache:false,
			url:path+"/profile/customProfile/customChildInsRefresh.action",
			data:data,
			success:function(){
				$.unblockUI();
				window.location.href = window.location.href;
			}
		});
	});

	$('input[name=checkAllResource]').change(function() {
		$('input[name=childrenIds]').attr("checked",$(this).attr("checked"));
	});
	$('input[name=childrernIds]').change(function(){
		var value = $(this).attr("checked");
		if(value == false) {
			$('input[name=checkAllResource]').attr("checked", value);
		}
	});

	$('.ico-file').mouseover(function() {
		$obj = $(this);
		var instanceId = $obj.attr("paramterId");
		$.ajax({
			type:"POST",
			cache:false,
			url:path+"/profile/customProfile/queryRemark.action?instanceId="+instanceId,
			success:function(data){
				var message = "-";
				if(data.description != undefined && data.description != null) {
					message = data.description;
				}
				$obj.attr("title", message);
			}
		});
	});

	$('.ico-file').click(function(event) {
		var instanceId = $(this).attr("paramterId");
		wp = new winPanel( {
			url : path+"/profile/customProfile/gotoEditRemark.action?instanceId="+instanceId,
			width : 260,
			height: 160,
			x:event.pageX-130,
			y:event.pageY,
			isautoclose: true,
			closeAction: "close",
			listeners : {
				closeAfter : function() {
					panel = null;
				},
				loadAfter : function() {
				}
			}
		}, {
			winpanel_DomStruFn : "blackLayer_winpanel_DomStruFn"
		});
	});

	singleRecover();
})
  
function showProcess(){
      if("${resourceId}".indexOf("Process")>0){
            $("#refresh").hide();
            $("#addProgress").show();
            $("#delProgress").show();
            $("#noProgressMess").hide();
            $("#progressMess").show();
      }else{
            $("#refresh").show();
            $("#addProgress").hide();
            $("#delProgress").hide();
            $("#noProgressMess").show();
            $("#progressMess").hide();
      }
}  

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
function show(tag){
  
	var parentTable = $(tag).parentsUntil('table').parent();
	var index = parentTable.attr('index');
	var profileId = parentTable.attr('profileId');
	var instanceId = parentTable.attr('instanceId');
	var $monitorTarget = parentTable.next();
	if($monitorTarget.children().length == 0){
    $.blockUI({message:$('#loading')});
		$.loadPage($monitorTarget,
			path + "/profile/customProfile/ChildResInsMetric.action",
			"POST",
			{instanceId:instanceId,index:index,profileId:profileId},
			function(){
				$monitorTarget.find(":input:not('[id=allFreqList]')").bind('change',function(){
					changeContent(this);
				});
				$monitorTarget.find(".cue-min").bind('click',function(event){
					thresholdEvent(this,event.pageX,event.pageY);
				});
				$monitorTarget.find('[id=setting]').click(function(){
						settingClick(this,profileId);
					})
				$monitorTarget.slideDown("slow");
				$monitorTarget.find("[id^=isAlert]").click(function(){
					var self = $(this);
					var mIndex = $(this).attr("mIndex");

					var array = $("li[index="+mIndex+"]").find('input[type=checkbox][id$="notification"]');
					array.each(function(i,e){
						$(this).attr('checked',self.attr('checked'));
						changeContent($(this));
					})
				});
				$monitorTarget.find("[id^=criticalAllSelect]").click(function(){
					var self = $(this);
					var mIndex = $(this).attr("mIndex");

					var array = $("li[index="+mIndex+"]").find('input[type=checkbox][name=critical]:enabled');
					array.each(function(i,e){
						$(this).attr('checked',self.attr('checked'));
						changeContent($(this));
					})
				});
        $.unblockUI();
			}
		);
		
	}else{
		$monitorTarget.slideDown("slow");
	}
	$(tag).attr('class','monitor-ico monitor-ico-close');
	$(tag).unbind();
	$(tag).bind('click',function(){hide(this);});
	hideOther(tag);
}
	
function hide(tag){
	$(tag).parentsUntil('li').parent().children('.monitor-target').slideUp("slow");
	$(tag).attr('class','monitor-ico monitor-ico-open');
	$(tag).unbind();
	$(tag).bind('click',function(){show(this);});
}

function hideOther(tag){
	$(".monitor-ico-open").each(function(i,e){
		if(e==tag){
			return;
		}
		hide(e);
	})
}
/**
*	修改内容时调用此方法修改监听变量.
**/
function changeContent(tag){
		var _self = $(tag);
		if(_self.attr('name')=='checkAllMetric'){
			checkAllMetric(tag);
			return;
		}
		if(_self.attr('name')=='isMonitor'){
			if(_self.parent().attr('instanceId')!=undefined){
				//alert(_self.parent().attr('instanceId'));
				_self.prev().val($(tag).attr('checked'));
				var $monitor_target = _self.parentsUntil('table').parent().next();
				if($monitor_target.children() != null){
					$monitor_target.find('[name=isMonitor]:enabled').attr('checked',_self.attr('checked'));
					$monitor_target.find('[name=isMonitor]:enabled').change();
				}
			}else{
				_self.prev().children('[name$=monitor]').val($(tag).attr('checked'));
			}
			
		}
    if($(tag).attr('name')=='critical'){
      $(tag).next().val($(tag).attr('checked'));
      if($(tag).attr('checked')){
				$(tag).parent().parent().find("div[name=cue_min]").attr("disabled","");
				$(tag).parent().parent().find("ul[name=eventName_ul]").attr("disabled","");
				$(tag).parent().parent().find("ul[name=notification_ul]").attr("disabled","");
        $(tag).parent().parent().find("ul[name=event_ul]").attr("disabled","");
				$(tag).parent().parent().find("span[id=setting]").attr("disabled","").attr("class","ico ico-equipment");
			}else{
				$(tag).parent().parent().find("div[name=cue_min]").attr("disabled","disabled");
				$(tag).parent().parent().find("ul[name=eventName_ul]").attr("disabled","disabled");
				$(tag).parent().parent().find("ul[name=notification_ul]").attr("disabled","disabled");
        $(tag).parent().parent().find("ul[name=event_ul]").attr("disabled","disabled");
				$(tag).parent().parent().find("span[id=setting]").attr("disabled","disabled").attr("class","ico ico-equipment-off");
			}
      
		}
		//1全部指标是否有修改
		//$('[name=listen.metricSetHaveChange]').val(true);
		//2指标组是否有修改
		var $metricGroupHaveChange = $(tag).parentsUntil('li[id!=""]').parent().children('[name=hiddenDiv]').children('[name$=haveChange]');
		$metricGroupHaveChange.val(true);
		//3本行指标是否有修改
    var $metricGruop = $(tag).parentsUntil('table').parent().find('td[name=metricGruop]').find('[name$=haveChange]');
		$metricGruop.val(true);
		var $metricHaveChange = $(tag).parentsUntil('tr').parent().find('[name$=haveChange]');
		$metricHaveChange.val(true);
		return;
}
function checkAllMetric(tag){
		var _self = $(tag);
		var _isMonitors = $('#monitorMetricSetting').find('[name=isMonitor]');
		_isMonitors.attr('checked', _self.attr('checked'));
		$.each(_isMonitors,function(i,e){
			$(e).change();
		})
		return;
};
function settingClick(tag,profileId){
		var m_profileId = $(tag).parentsUntil('tbody').find("[name$=profileId]").val();
		if(m_profileId==null || m_profileId==''){
			m_profileId=profileId;
		}
		var metricId = $(tag).parentsUntil('tbody').find("[name$=metricId]").val();
		var resourceId = $("#resourceId").val();
		
		var winOpenObj = {};
		winOpenObj.height = '500';
		winOpenObj.width = '750';
		winOpenObj.name = 'performanceEdit';
		winOpenObj.url = path+'/profile/performanceEdit.action?metricId=' + metricId + '&profileId=' + m_profileId + '&resourceId=' + resourceId;
		winOpenObj.scrollable = true;
		winOpen(winOpenObj);
}

function singleRecover() {
	$("[pid=singleRecover]").click(function() {
    var clickThis=this;
		win.setContentText('此操作将覆盖所做的设置，并立即生效，是否确认执行？');
		win.setConfirm_listener(function(){
			win.hide();
			$('input[name=childrenIds]').attr("checked", false);
			$(clickThis).parent().parent().find("[name=childrenIds]").attr("checked", true);
			$.blockUI({message:$('#loading')});
			var data = $('#resInsform').serialize();
			$.ajax({
				type:"post",
				cache:false,
				url:path+"/profile/customProfile/recoverDefaultMetric.action",
				data:data,
				success:function(){
					$.unblockUI();
					window.location.href = window.location.href;
				}
			});
		});
		win.show();
	});
}
function panelClose() {
	wp.close("close");
	wp = null;
}
</script>
</body>
</html>