var isMetricSetChange = false;
var isAlarmRuleChange = false;
var wp = null;
var $form;
var win = null;
var contentType = {
		metricSetting : 'metricSetting',
		notifyRole : 'notifyRole'
};
function showMessage(mes){
	 var _information = new information({text:mes});
	 _information.show();
}
$(function(){
	$.blockUI({message:$('#loading')});
	$(".pop-content").css("overflow-y","hidden");
	$form = $("#customProfileForm");
	var profileId = $("#basicInfo_profileId").val();
	var resourceId = $("#basicInfo_resourceId").val();
	var instanceId = $("#basicInfo_incId").val();
	win = new confirm_box({title:'提示',text:'',cancle_listener:function(){win.hide();}});
	$form.validationEngine({
		promptPosition:"centerRight", 
		inlineValidation: true,
		scroll:false,
		success:false,
	    failure : function() { callFailFunction()}, 
		beforePrompt:function(tag){
	    	var div = $(tag).parentsUntil(".fold-blue").parent();
	    	expendPanelById(panelArray,div.attr("id"));
		}
	});
	
	
    var panelArray = new Array();
    panelArray[0] = new AccordionPanel({id:"generalInfo"},{
   		DomStruFn:"addsub_accordionpanel_DomStruFn",
		DomCtrlFn:"addsub_accordionpanel_DomCtrlFn"
           });
    panelArray[1] = new AccordionPanel({id:"metricSetting"},{
	   DomStruFn:"addsub_accordionpanel_DomStruFn",
	   DomCtrlFn:"addsub_accordionpanel_DomCtrlFn"
           });
    panelArray[2] = new AccordionPanel({id:"notifyRole"},{
	   DomStruFn:"addsub_accordionpanel_DomStruFn",
	   DomCtrlFn:"addsub_accordionpanel_DomCtrlFn"
       });
   
		
	function expendPanel(panelArray,currentObj){
		currentObj.$accBtn.click(function(){
			if(currentObj.state=="expend"){
				for(var i in panelArray){
					if(panelArray[i] != currentObj && panelArray[i].state=="expend"){
						panelArray[i].collect();
					}
				}
			}
		});
	}
	
	function expendPanelById(panelArray,currentId){
		for(var i in panelArray){
			if(panelArray[i].getId() != currentId && panelArray[i].state=="expend"){
				panelArray[i].collect();
			}else if(panelArray[i].getId() == currentId && panelArray[i].state!="expend") {
				panelArray[i].expend();
			}
		}
	}
	expendPanel(panelArray,panelArray[0]);
	expendPanel(panelArray,panelArray[1]);
	expendPanel(panelArray,panelArray[2]);
	
	
	function setAllEventAlarm() {
		$("[id^=isAlert_]").click(function(){
			var self = $(this);
			var mIndex = self.attr('mIndex');
			var array = $("li[index="+mIndex+"]").find('input[type=checkbox][id$="notification"]');
			array.each(function(i,e){
				$(this).attr('checked',self.attr('checked'));
				changeContent($(this),contentType.metricSetting);
			})
			
		});
	}	

	function setAllEventMonitor() {
		$("[id^=monitorAllSelect_]").click(function(){
			var self = $(this);
			var mIndex = self.attr('mIndex');
			var array = $("li[index="+mIndex+"]").find('input[type=checkbox][name=isMonitor]:enabled');
			array.each(function(i,e){
				$(this).attr('checked',self.attr('checked'));
				changeContent($(this),contentType.metricSetting);
			})
			
		});
	}	
  
  function setAllEventCritical() {
		$("[id^=criticalAllSelect_]").click(function(){
			var self = $(this);
			var mIndex = self.attr('mIndex');
			var array = $("li[index="+mIndex+"]").find('input[type=checkbox][name=critical]:enabled');
			array.each(function(i,e){
				$(this).attr('checked',self.attr('checked'));
				changeContent($(this),contentType.metricSetting);
			})
			
		});
	}	
	/**
	 * 指标设置
	 */
	function setMetrics() {
		$('[id=allFreqList]').bind('change',function(){
			allFreqListSelect(this);
		});
		$("#monitorMetricSetting :input:not('[id=allFreqList]')").bind('change',function(){
			changeContent($(this),contentType.metricSetting);
		});
		$(".monitor-ico-open").bind('click', function(){show(this);});
		
		$(".monitor-ico-close").bind('click', function(){hide(this);});
	
		$('span[id=advSetting]').bind('click', function(){
			openAdvPage($(this), profileId);
		});
		$('span[id=batchSetting]').bind('click', function(){
			//TODO 打开批量指标设置页面
			openBatchSettingPage($(this));
		});
		//阈值
		$('.cue-min').click(function(event){
			clickCueMin(this,event.pageX,event.pageY);
		});
		$('span[id=setting]').click(function(){
			settingClick(this,profileId);
		})
	}
	
	/**
	*告警规则
	*/
	function setAlarms() {
		$("#addAlarmToProfile").click(function(){
			var flag = false;
			var $leftAlarm = $(":checkbox:checked","#leftAlarm");
			if($leftAlarm.length == 0) {
				var _information = new information({text:"请选择要添加的告警规则。"});
				_information.show();
			}
			$leftAlarm.each(function(i,e){
				$(this).attr("checked", false);
				$(this).parent().parent().appendTo("#rightAlarm");
				$(this).next().attr('name','alarmRuleSelect.ruleIds');
				if(!flag) {
					flag = true;
				}
			})
			if(flag) {
				changeAlarmRule();
			}
		});
		$("#delAlarmToProfile").click(function(){
			var flag = false;
			var $rightAlarm = $(":checkbox:checked","#rightAlarm");
			if($rightAlarm.length == 0) {
				var _information = new information({text:"请选择要取消的告警规则。"});
				_information.show();
			}
			$rightAlarm.each(function(i,e){
				$(this).attr("checked", false);
				$(this).parent().parent().appendTo("#leftAlarm");
				$(this).next().attr('name','');
				if(!flag) {
					flag = true;
				}
			})
			if(flag) {
				changeAlarmRule();
			}
		});
		
		$('.r-ico-add').click(function() {
			var winOpenObj = {};
			winOpenObj.height = '600';
			winOpenObj.width = '670';
			winOpenObj.name = 'alarmDef';
			winOpenObj.url = path +'/profile/alarm/alarmDef.action?commonRule.basicInfo.moduleId=BSM_PROFILE&ruleDomainId='+$("#basicInfo_doaminId").val();
			winOpenObj.scrollable = true;
			winOpen(winOpenObj);
		});
		
		alarmInfo();
	}
	
	
	function setSubmit() {
		$('#apply_button').click(function(){
			submit(false);
		});
		$('#confirm_button').click(function(){
			submit(true);
		});
	}
	
	function resetMetricDefaultValue() {
		$('#resetDefaultValue').bind('click',function(){
			win.setContentText('此操作将覆盖所做的设置，并立即生效，是否确认执行？');
			win.setConfirm_listener(function(){
				win.hide();
				$.blockUI({message:$('#loading')});
				var data = "profileId=" + profileId;
				data += "&instanceId=" + instanceId;
				$.ajax({
					type:"post",
					cache:false,
					url:path+"/profile/customProfile/recoverMainDefaultMetric.action",
					data:data,
					dataType:"html",
					success:function(data){
					$("#metric_div").html("").append(data);
					setMetrics();
					setAllEventAlarm();
				    setAllEventMonitor();
				    setAllEventCritical();
					$.unblockUI();
				},
				failed:function(){alert('返回错误');$.unblockUI();}
				
				});
			});
			win.show();
		});
	}
	
	function reloadData() {
		setAllEventAlarm();
	    setAllEventMonitor();
	    setAllEventCritical();
		setMetrics();
		setAlarms();
		setSubmit()
		resetMetricDefaultValue();
	}
	reloadData();
	
//	if($("#listen_isNew").val() == 'true') {
//		$("input[name$='.haveChange']").val(true);
//		$("#listen_metricSetHaveChange").val(true);
//		$("#listen_alarmRuleHaveChange").val(true);
//	};
	$.unblockUI();
  if($("#listen_isNew").val() == 'true'){
     var _information = new information({text:"第一次进行个性化监控设置，需保存后才可以进行进一步的高级设置。"});
		 _information.show();
  }

function submit(isClosed){
	$.blockUI({message:$('#loading')});
	if(!$.validate( $form )) {
		  $.unblockUI();
		  return;
	}
	var data = $('#customProfileForm').serialize();
		$.ajax({
		   type: "POST",
		   cache:false,
		   url: 'saveCustomProfile.action',
		   data:data,
		   success: function(msg){
				var rowIndex = $('#rowIndex').val();
			 	if(msg != null && msg.success){
			 		window.opener.modiRow(rowIndex,"CustomizeProfile");
			 	}
			 	//profileObj.getProfileType()+","+profileObj.getProfileId()+","+profileObj.getName()
			 	var profileName = $('#basicInfo_incName').val();
			 	var json = 'CustomizeProfile,' + profileId + ',' + profileName;
			 	if(window.opener && window.opener.Monitor.Resource.right.monitorList.modiColProfile){
				 	window.opener.Monitor.Resource.right.monitorList.modiColProfile(rowIndex,json);
			 	}
			 	if(isClosed){
			 		closeWin();
			 	}else{
			 		window.location.href = window.location.href;
			 		$.unblockUI();
			 	}
		   },
		   failed: function(msg){
			   alert(msg.responseText);
			   $.unblockUI();
		   }
		   
		});
};
function allFreqListSelect(tag){
	if($(tag).attr('id')=='allFreqList'){
		var _fre = $(tag).val();
		var fres = $(tag).parentsUntil('table').parent().next().find('[name$=frequencyId]');
		$.each(fres,function(i,e){
			if(_fre != $(e).val()){
				$(e).val(_fre);
				$(e).change();
			}
		})
	}
}

/**
*	修改内容时调用此方法修改监听变量.
**/
function changeContent(tag,type){ 
	if(contentType.metricSetting == type){
		if($(tag).attr('name')=='checkAllMetric'){
			checkAllMetric(tag);
			return;
		};
		if($(tag).attr('name')=='isMonitor'){
			$(tag).prev().children('[name$=monitor]').val($(tag).attr('checked'));
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
		$('#listen_metricSetHaveChange').val(true);
		//2指标组是否有修改
		var $metricGroupHaveChange = $(tag).parentsUntil('li[id!=""]').parent().children('[name=hiddenDiv]').children('[name$=haveChange]');
		$metricGroupHaveChange.val(true);
		//3本行指标是否有修改
		var $metricHaveChange = $(tag).parentsUntil('tr').parent().find('[name$=haveChange]');
		$metricHaveChange.val(true);
	}
	else if(contentType.notifyRole == type){
		$('#listen_alarmRuleHaveChange').val(true);
	}
	
}

function checkAllMetric(tag){
	var $monitorList = $(tag).parentsUntil('.monitor-items-list').parent().next().find('input[name=isMonitor]');
	var $tag = $(tag); 
	$monitorList.each(function(i,e){
		var obj = $(e);
		if(!obj.attr('disabled')) {
			if(obj.attr('checked')!=$tag.attr('checked')){
				obj.attr('checked',$tag.attr('checked'));
				changeContent(obj,contentType.metricSetting);
			}
		}
	});
}

function changeAlarmRule(){
	if(!isAlarmRuleChange){
		$('#listen_alarmRuleHaveChange').val(true);
		isAlarmRuleChange = true;
	}
};
function clickCueMin(tag,x,y){
	var self = $(tag);
		var $redValue = self.parent().children('[value=red]').next().next();
		var unit = self.parent().children('[value=red]').prev().val();
		var $yellowValue = self.parent().children('[value=yellow]').next().next();
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
};

function revise(redTag,yeTag){
	var rTop = redTag.position().top;
	var yTop = yeTag.position().top;
	if(yTop <= rTop+redTag.height()){
		redTag.css("margin-bottom" , redTag.height() / 2+7);
		yeTag.css("margin-top" , redTag.height()+7);
	}
	
}
function settingClick(tag,profileId){
	var metricId = $(tag).parentsUntil('tbody').find("[name$=metricId]").val();
	var resourceId = $("#basicInfo_resourceId").val();
	var param = 'metricId=' + metricId + '&profileId=' + profileId + '&resourceId=' + resourceId;
	var winOpenObj = {};
	winOpenObj.height = '500';
	winOpenObj.width = '750';
	winOpenObj.name = 'performanceEdit';
	winOpenObj.url = path+'/profile/performanceEdit.action?'+param;
	winOpenObj.scrollable = true;
	winOpen(winOpenObj);
}

$('div[id=monitorFreq]').click(function(){
	var metricId = $(this).parentsUntil('tbody').find("[name$=metricId]").val();
	var profileId = $("#basicInfo_profileId").val();
	var resourceId =  $("#basicInfo_resourceId").val();
	var winOpenObj = {};
	winOpenObj.height = '500';
	winOpenObj.width = '750';
	winOpenObj.name = 'performanceEdit';
	winOpenObj.url = path+'/profile/performanceEdit.action?monitorFreq=true&metricId=' + metricId + '&profileId=' + profileId + '&resourceId=' + resourceId;;
	winOpenObj.scrollable = true;
	winOpen(winOpenObj);
});

function openAdvPage(thisObj, profileId){
	$parents = thisObj.parentsUntil('li').parent().children('[name=hiddenDiv]');
	var resourceId = $parents.children('[name$=metricGroupId]').val();
	var requestPath = new Array();
	requestPath.push(path);
	requestPath.push('/profile/customProfile/queryChildIns.action?instanceId=');
	requestPath.push(instanceId);
	requestPath.push('&resourceId=');
	requestPath.push(resourceId);
	requestPath.push('&profileId=');
	requestPath.push(profileId);
	requestPath.push('&isCustomProfile=true');
	var winOpenObj = {};
	winOpenObj.height = '500';
	winOpenObj.width = '730';
	winOpenObj.name = 'advSet';
	winOpenObj.url = requestPath.join('');
	winOpenObj.scrollable = true;
	winOpen(winOpenObj);
}

function openBatchSettingPage(thisObj) {
	$parents = thisObj.parentsUntil('li').parent().children('[name=hiddenDiv]');
	var resourceId = $parents.children('[name$=metricGroupId]').val();
	var requestPath = new Array();
	requestPath.push(path);
	requestPath.push('/profile/customProfile/openBatchSetPage.action?resourceId=');
	requestPath.push(resourceId);
	requestPath.push("&profileId=");
	requestPath.push(profileId);
	requestPath.push("&instanceId=");
	requestPath.push(instanceId);
	var winOpenObj = {};
	winOpenObj.height = '500';
	winOpenObj.width = '730';
	winOpenObj.name = 'batchSet';
	winOpenObj.url = requestPath.join('');
	winOpenObj.scrollable = true;
	winOpen(winOpenObj);
}

function show(tag){
	var parentLi = $(tag).parentsUntil('li').parent();
	/*var profileId = '';
	var isNew = $('#listen_isNew').val();
	if(isNew=='false'){
		profileId = $("#basicInfo_profileId").val();
	}
	var index = parentLi.attr('index');
	var metricGroupId = parentLi.find("[name$=metricGroupId]").val();*/
	var $monitorTarget = parentLi.children('.monitor-target');
	/*if($monitorTarget.children().length == 0){
		//alert(path+'#'+profileId+'#'+metricGroupId);
		$.loadPage($monitorTarget,
			path + "/profile/customProfile/ChildResInsMetric.action",
			"POST",
			{profileId:profileId,resourceId:metricGroupId,index:index,isNew:isNew},
			function(){
				$monitorTarget.find(":input:not('[id=allFreqList]')").bind('change',function(){
					changeContent(this,contentType.metricSetting);
				});
				$monitorTarget.find(".cue-min").bind('click',function(event){
					clickCueMin(this,event.pageX,event.pageY);
				});
				$monitorTarget.find('[id=setting]').click(function(){
					settingClick(this,profileId);
				});
				$monitorTarget.find("[id^=isAlert_]").click(function(){
					var self = $(this);
					var mIndex = self.attr('mIndex');
					$("li[index="+mIndex+"]").find('input[type=checkbox][id$="notification"]').attr('checked',self.attr('checked'));
					
				});
				$monitorTarget.height("auto");
				$monitorTarget.slideDown("slow");
			}
		);
		
	}else{*/
		$monitorTarget.height("auto");
		$monitorTarget.slideDown("slow");
	/*}*/
	$(tag).attr('class','monitor-ico monitor-ico-close');
	$(tag).unbind();
	$(tag).bind('click',function(){hide(this);});
	hideOther();
}

function hide(tag){
	$(tag).parentsUntil('li').parent().children('.monitor-target').slideUp("slow");
	$(tag).attr('class','monitor-ico monitor-ico-open');
	$(tag).unbind();
	$(tag).bind('click',function(){show(this);});
}

/*有问题*/
function hideOther(tag){
	$(".monitor-ico-open").each(function(i,e){
		hide(e);
	})
}

$(".cue-content").each(function(){
	revise($($(this).find(".cue-min-note-red")[0]),$($(this).find(".cue-min-note-yellow")[0]));
});
});
function calcPopDivPageY(event, divHeight) {
	var pageHeight = $(document).height();
	if(event.pageY + divHeight > pageHeight) {
		return event.pageY - divHeight;
	}
	return event.pageY
}
function calcPopDivPageX(event, divWidth) {
	var pageWidth = $(document).width();
	if(event.pageX + divWidth > pageWidth) {
		return event.pageX-(event.pageX + divWidth - pageWidth + 50);
	}
	return event.pageX;
}
function isNon (v){
	if(v===undefined || v===null || v ==''){
		return true;
	}
	return false;
}
function alarmInfo() {
	$("span[id^='alarm_detail_']").click(function(event){
		var	alarmId = this.id;
		alarmId = alarmId.substring("alarm_detail_".length,alarmId.length);
		var alarm = new function(){};
		$.ajax({
		  type: "get",
		  url: path+"/profile/alarm/detail.action?ruleId="+alarmId,
		  cache: false,
		  success: function(alarm){
			  if(alarm.jsonStr == null) {
					alert("系统异常.");
					return;
				}else if(alarm.jsonStr == "deleted") {
					var _information = new information({text:"规则已被删除."});
					_information.show();
					return;
				}
			var jsonObj = eval("("+alarm.jsonStr+")");
			var NA = '-';
			var html = "<h2>"+(jsonObj.name)+"</h2><hr/>";
			html+="接收方式："+(isNon(jsonObj.sendTypes)? NA : jsonObj.sendTypes)+"<br/>";
			html+="接收人员："+(isNon(jsonObj.receiveUser)?NA:jsonObj.receiveUser)+"<br>";
			html+="发送条件："+(isNon(jsonObj.sendCondtion)?NA:jsonObj.sendCondtion)+"<br>";
			html+="发送时间："+(isNon(jsonObj.sendTime)?NA:jsonObj.sendTime)+"<br>";
			html+="升级人员："+(isNon(jsonObj.ureceiveUser)?NA:jsonObj.ureceiveUser)+"<br>";
			html+="升级条件："+(isNon(jsonObj.usendCondtion)?NA:jsonObj.usendCondtion)+"<br>";
			if(wp == undefined || wp == null){
		 	wp = new winPanel({html:html
			,x:calcPopDivPageX(event, 320)
			,y:calcPopDivPageY(event, 175)
			,width:300
			,isautoclose: true
			,closeAction: "close"
			, listeners:{ closeAfter:function(){
					//alert("afterClose");
		 			wp = null; 
					}
				, loadAfter:function(){ 
//					alert("loadAfter"); 
					} 
				} }
			,{winpanel_DomStruFn:"blackLayer_winpanel_DomStruFn" }); 
			}
		  },failed:function(){alert('返回错误');}
		});
	});
}
function refreshRuleInfo(id,name){
	var $alarm = $(':checkbox[value='+id+']','#leftAlarm');
	if($alarm.val() != undefined){
		$('[value='+id+']','#leftAlarm').parent().next().html(name);
	}else{
		var tr = "<tr><td width='10%'><input type='checkbox'><input type='hidden' id='profileForm_' value='"+id+"' ></td><td width='90%' align='left'>"+name+"<span id='alarm_detail_"+id+"'/></td></tr>";
		$('#leftAlarm').append(tr);
		$('#alarm_detail_'+id).addClass('ico ico-find');
	}
	$("span[id^='alarm_detail_']").unbind();
	alarmInfo();
}