var isResSelectChange = false;
var isMetricSetChange = false;
var isCustomEventChange = false;
var isAlarmRuleChange = false;
var wp = null;
var win = null;
$(function(){
	var profile_parentId = $("input[name=basicInfo.parentId]").val();
	
	$.blockUI({message:$('#loading')});
	treeTrim();
	/*
	 * panel pucker ctrl
	 */
	var panelArray = new Array();
	panelArray[0] = new AccordionPanel({id : "basicInfo"}, {
		DomStruFn : "addsub_accordionpanel_DomStruFn",
		DomCtrlFn : "addsub_accordionpanel_DomCtrlFn"
	});
	panelArray[1] = new AccordionPanel({id : "resInsSelect"}, {
		DomStruFn : "addsub_accordionpanel_DomStruFn",
		DomCtrlFn : "addsub_accordionpanel_DomCtrlFn"
	});
	
	panelArray[2] = new AccordionPanel({id : "metricSetting"}, {
		DomStruFn : "addsub_accordionpanel_DomStruFn",
		DomCtrlFn : "addsub_accordionpanel_DomCtrlFn"
	});
	panelArray[3] = new AccordionPanel({id : "customEvent"}, {
		DomStruFn : "addsub_accordionpanel_DomStruFn",
		DomCtrlFn : "addsub_accordionpanel_DomCtrlFn"
	});
	
	//child profile no have alarm.
	if(profile_parentId == "" || profile_parentId == null) {
		panelArray[4]  = new AccordionPanel({id : "notifyRole"}, {
			DomStruFn : "addsub_accordionpanel_DomStruFn",
			DomCtrlFn : "addsub_accordionpanel_DomCtrlFn"
		});
	}
	
	function expendPanel(panelArray,currentObj){
		currentObj.$accBtn.click(function(){
			$(".formError").remove();
			if(currentObj.state=="expend"){
				loadTabPageClick(currentObj.getId());
				regulation();
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
	for (var i in panelArray) {
		expendPanel(panelArray,panelArray[i]);
	}
	var tree = new Tree( {
		id : "profileTree",
		listeners : {
			nodeClick : function(node,event) {
				node_NodeClick(node);
			},
			toolClick : function(node,event) {
				var x = event.pageX;
				var y = event.pageY;
			    var nodeId = node.getId();
				if(nodeId.indexOf('_')>0){
					nodeId = nodeId.split('_');
					mc.position(x, y);
					if(nodeId[0] == 'm'){
						mc.addMenuItems([[{
							ico : 'add',
							text : "新建子策略",
							id : "add",
							listeners : {
								click : function() {
									var winOpenObj = {};
									winOpenObj.height = '335';
									winOpenObj.width = '520';
									winOpenObj.name = 'addChildStrategy';
									winOpenObj.url = path+'/profile/addstrategy.action?parentProfileId=' + nodeId[1];
									winOpenObj.scrollable = false;
									winOpen(winOpenObj);
                  mc.hide();
								}
											}
							} ] ]);
					}else if(nodeId[0] == 's'){
						mc.addMenuItems([[{
							ico : 'remove',
							text : "删除子策略",
							id : "remove",
							listeners : {
								click : function() {
									win.setContentText('此操作不可恢复，是否确认执行此操作？');
									win.setConfirm_listener(function(){
										win.hide();
										$.ajax({
											type: "GET",
											cache:false,
											url: 'delChildProfile.action?basicInfo.profileId=' + nodeId[1],
											success: function(msg){
											if(msg != null && msg.success){
												window.location.href = 'queryProfile.action?basicInfo.profileId=' + msg.basicInfo.profileId;
											}
										},
										error: function(msg){
											alert(msg.responseText);
										}
										
										});
									});
									win.show();
							
									
							
								}
											}
										} ] ]);
					}
				}
			} 
		}
	});
	//校验是否是查看编辑页面
	if(setProfileWhetherEdit()) {
		$.unblockUI();
		return;
	}
	win = new confirm_box({title:'提示',text:'',cancle_listener:function(){win.hide();}});
	var $basicInfo_parentId = $("input[name=basicInfo.parentId]");
	if($basicInfo_parentId.val() == null) {
		$.validationEngineLanguage.allRules.duplicateName = {
				"file":path + "/profile/duplicateProfileName.action?profileId="+$("#basicInfo_profileId").val()+"&profileType=&isEdit=true",
				"alertTextLoad":"* 正在验证，请等待",
				"alertText":"* 有重复的策略名称"
		}
	}else {
		$.validationEngineLanguage.allRules.duplicateName = {
				"file":path + "/profile/duplicateChildProfileName.action?profileId="+$("#basicInfo_profileId").val()+"&parentId="+$basicInfo_parentId.val(),
				"alertTextLoad":"* 正在验证，请等待",
				"alertText":"* 有重复的策略名称"
		}
		
	}
	
	$('#profileForm').validationEngine({
		promptPosition:"topRight", 
		validationEventTriggers:"blur change",
		inlineValidation: true,
		scroll:false,
		success:false,
	    failure : function() { callFailFunction()  }, 
	    beforePrompt:function(tag){
	    	var div = $(tag).parentsUntil(".fold-blue").parent();
	    	expendPanelById(panelArray,div.attr("id"));
		}
	});
	/*
	 * Profile Tree
	 */
	var offset = $("#newProfile").offset();
	var width = $("#newProfile").width();
	var mc = new MenuContext( {x : 0,y : 0,width : 120}, {menuContext_DomStruFn : "ico_menuContext_DomStruFn"});
	
	confirmButtonClick();
	applyButtonClick();
	resetDefaultValue();
	addUserDefEventClick();
	
	$.unblockUI();
});

/*
 * 阈值
 */
function paintThreshold(){
	
}
function setProfileWhetherEdit() {
	var pageIsEnable = $('[name=basicInfo.enable]').val();
	var isAdmin = $("#basicInfo_admin").val();
	if(pageIsEnable=='true' || (!isSystemAdmin && !isConfigMgrRole)){
		$(':input').attr('disabled','true');
		$('select').attr('disabled','true');
		$('.cue-min').unbind();
		$('[id^=openCustom_]').css("cursor", "none").unbind();
		//$('.ico-equipment').removeClass("ico-equipment").addClass('ico-equipment-off');
		$("#resetDefaultValue").hide();
		$("#addUserDefEvent").hide();
		$(".ico-delete").hide();
		$(".r-ico-add").hide();
		$('#confirm_button').hide();
		$('#apply_button').hide();
		$('#cancel_button').hide();
		$('.turn-right').css("cursor", "none");
		$('.turn-left').css("cursor", "none");
		$('.ico-t-right').hide();
		$('#refresh').hide();
		return true;
	}
	return false;
}

/*
 * submit
 */
function profileSubmit(isClosed){
	settings = {
			promptPosition:"topRight", 
			inlineValidation: true,
			scroll:false,
			success:false
			/*,
		    failure : function() { callFailFunction()  } */
	}
	$.blockUI({message:$('#loading')});
	if(!$.validate($('#profileForm'),settings)) {$.unblockUI();return;}
	if(checkRepeatSubmit()) {return;}
	 $('#right_resIns').find('[name=resInsSelect.instanceIds]').attr('checked',true);
	 var data =$('#profileForm').serialize();
	 //alert(data);
	$.ajax({
		type:'POST',
		url: path+'/profile/userDefineProfile/saveProfile.action',
		data:data,
		success:function(data){
			$.unblockUI();
			submitFlag = false;
			if(data.errorMessage != undefined){
				var _information = new information({text:data.errorMessage});
				_information.show();
				return;
			}
			try{
				window.location.href = window.location.href; 
				window.opener.changeGrid("/profile/profileListChild.action");
			}catch(e){
			}
			if(isClosed){closeWin();}
		},
	   error:function(msg) {
			alert( msg.responseText);
	   }
	})
}
var c_eventCount = -1;
/*
 * 自定义事件
 */
function deleteCustomEvent(obj){
	var composeId= obj.find("input[name$=composeId]").val();
	if(composeId != null) {
		$.ajax({
			type:'POST',
			url:path + '/profile/customEvent/deleteEvent.action?composeId='+composeId,
			success:function(){
				loadCustomEvent(true);
			},
			error:function(msg) {
				alert(msg.responseText);
			}
		})
	}
}

function openCustomEventPage(composeId) {
	var resourceId = $("input[name=basicInfo.resourceId]").val();
	var profileId = $("input[name=basicInfo.profileId]").val();
	var param = "?resourceId="+resourceId+"&eventDef.profileId="+profileId;
	var enable = $('[name=basicInfo.enable]').val();
	if(composeId != undefined) {
		param +="&eventDef.composeId="+composeId+"&enable="+enable;
	}
	var winOpenObj = {};
	winOpenObj.height = '402';
	winOpenObj.width = '650';
	winOpenObj.name = 'customEvent';
	winOpenObj.url = path + '/profile/customEvent/queryCustomEvent.action'+param;
	winOpenObj.scrollable = false;
	winOpen(winOpenObj);
}

	
function changeResSelect(){
	if(!isResSelectChange){
		$('#modifyListen_resSelect').val(true);
		isResSelectChange = true;
	}
}

function changeAlarmRule(){
	if(!isAlarmRuleChange){
		$('#modifyListen_alarmRule').val(true);
		isAlarmRuleChange = true;
	}
}

function changeCustomEvent(){
	if(!isCustomEventChange){
		$('#modifyListen_customEvent').val(true);
		isCustomEventChange = true;
	}
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

function showMonitorRes(){
	$('#left_resIns').children('[state=true]').show();
	$('#left_resIns').children('[state!=true]').hide();
}

function showUnmonitorRes(){
	$('#left_resIns').children('[state=true]').hide();
	$('#left_resIns').children('[state!=true]').show();
}

function showAllRes(){
	$('#left_resIns').children().show();
}

function revise(redTag,yeTag){
	var rTop = redTag.position().top;
	var yTop = yeTag.position().top;
	if(yTop < rTop+redTag.height()){
		redTag.css("margin-bottom" , redTag.height() / 2 + 2);
		yeTag.css("margin-top" , redTag.height() + 1 );
	}
	
}

function setManyRecordeHtml(obj, title, width) {
	var html="";
	if(isNon(obj)) {
		html+="<span style='font-weight: bolder;'>"+title+"</span><span>-</span>";
	}else {
		for ( var int = 0; int < obj.length; int++) {
			if(int == 0) {
				html+="<span class='field' style='width:"+width+"px;font-weight: bolder;'>"+title+"</span><span class='.ellipsis'>"+obj[int]+"</span>";
			}else {
				html+="<span class='field' style='width:"+width+"px;font-weight: bolder;'>&nbsp;</span><span class='.ellipsis'>"+obj[int]+"</span>";
			}
			
			if(int != obj.length-1) {
				html+="<br>";
			}
		}
	}
	return html;
}
function isNon (v){
	if(v===undefined || v===null || v ==''){
		return true;
	}
	return false;
}

var alarmInfo = function() {
	$("span[id^='alarm_detail_']").click(function(event){
		var	alarmId = this.id;
		alarmId = alarmId.substring("alarm_detail_".length,alarmId.length);
		$.ajax({
		  type: "get",
		  url: path+"/profile/alarm/detail.action?ruleId="+alarmId,
		  success: function(data){
			var _information;
			if(data.jsonStr == null) {
				_information = new information({text:"系统异常"});
				_information.show();
				return;
			}else if(data.jsonStr == "deleted") {
				_information = new information({text:"规则已被删除"});
				_information.show();
				return;
			}
			var jsonObj = eval("("+data.jsonStr+")");
			
			var NA = '-';
			var html = "<span style='font-weight: bolder;'>规则名称：</span><span class='.ellipsis'>"+(jsonObj.name)+"</span><hr/>";
			html+="<span style='font-weight: bolder;'>接收方式：</span><span class='.ellipsis'>"+(isNon(jsonObj.sendTypes)? NA :jsonObj.sendTypes)+"</span><br/>";
			html+="<span style='font-weight: bolder;'>接收人员：</span><span class='.ellipsis'>"+(isNon(jsonObj.receiveUser)?NA:jsonObj.receiveUser)+"</span><br>";
			html+="<span style='font-weight: bolder;'>发送条件：</span><span class='.ellipsis'>"+(isNon(jsonObj.sendCondtion)?NA:jsonObj.sendCondtion)+"</span><br>";
			html += setManyRecordeHtml(jsonObj.sendTime, "发送时间：", 70);
			html+="<br><span style='font-weight: bolder;'>升级人员：</span><span class='.ellipsis'>"+(isNon(jsonObj.ureceiveUser)?NA:jsonObj.ureceiveUser)+"</span><br>";
			html += setManyRecordeHtml(jsonObj.usendCondtion, "升级条件：", 70);
			if(wp != undefined || wp != null){
				wp.close("close");
				wp = null;
			}
		 	wp = new winPanel({html:html
			,x:calcPopDivPageX(event, 350)
			,y:calcPopDivPageY(event, 175)
			,width:350
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
		  },error:function(){alert(msg.responseText);}
		});
	});
}
function calcPopDivPageX(event, divWidth) {
	var pageWidth = $(document).width();
	if(event.pageX + divWidth > pageWidth) {
		return event.pageX-(event.pageX + divWidth - pageWidth + 50);
	}
	return event.pageX;
}
function calcPopDivPageY(event, divHeight) {
	var pageHeight = $(document).height();
	if(event.pageY + divHeight > pageHeight) {
		return event.pageY - divHeight;
	}
	return event.pageY
}
function treeTrim(){
	 $('#loadProfileTree li').css('word-wrap','normal');
	 $("#loadProfileTree span[type='text']").each(
	 function() {
		    var text = $(this).text();
		    var width = 125;
			var patt1 = /^m_/;
			var nodeid = $(this).parent().attr("nodeid");
			if(nodeid && patt1.test(nodeid)){
		    	width = 140;
		    }
		    $(this).empty();
		    $(this).append("<span STYLE='width:"+width+"px;overflow: hidden; text-overflow:ellipsis;display: inline-block;white-space:nowrap;' title='" + text + "'>" + text + "</span>");
		   }
		  );
}


/********Start***********/
var insanceMouseOver = function() {
	$(".insName'").mouseover(function(event){
		var instanceId = $(this).parent().parent().parent().prev().children("[type=checkbox]").val();
		var popObj = new function(){};
		$.ajax({
		  type: "get",
		  url: path+"/profile/popDivResInsInfo.action?instanceId="+instanceId,
		  success: function(popObj){
		  	var _information;
			if(popObj.jsonString == null) {
				_information = new information({text:"系统异常"});
				_information.show();
				return;
			}else if(popObj.jsonString == "deleted") {
				_information = new information({text:"资源已被删除"});
				_information.show();
				return;
			}
			var jsonObj = eval("("+popObj.jsonString+")");
			var NA = '-';
			var html="<span style='font-weight: bolder;'>显示名称：</span><span class='span_dot_shot' title='"+(isNon(jsonObj.displayName)? NA : jsonObj.displayName)+"'>"+(isNon(jsonObj.displayName)? NA : jsonObj.displayName)+"</span><br>";
			html+="<span style='font-weight: bolder;'>资源名称：</span><span class='span_dot_shot' title='"+(isNon(jsonObj.resInsName)?NA:jsonObj.resInsName)+"'>"+(isNon(jsonObj.resInsName)?NA:jsonObj.resInsName)+"</span><br>";
			html+="<span style='font-weight: bolder;'>IP地址：</span><span class='.ellipsis'>"+(isNon(jsonObj.ipAddress)?NA:jsonObj.ipAddress)+"<br>";
			html+="<span style='font-weight: bolder;'>备注：</span><span class='.ellipsis'>"+(isNon(jsonObj.remark)?NA:jsonObj.remark)+"<br>";
			html+="<span style='font-weight: bolder;'>维护人：</span><span class='.ellipsis'>"+(isNon(jsonObj.maintainPerson)?NA:jsonObj.maintainPerson)+"<br>";
			html += setManyRecordeHtml(jsonObj.offLineTimes, "计划不在线时间：", 110);
			html += "<hr/><span style='font-weight: bolder;'>当前策略：</span><span class='.ellipsis'>"+(jsonObj.profileName)+"<br>";
			html += setManyRecordeHtml(jsonObj.ruleNames, "告警规则：",65);
			
			if(wp != undefined || wp != null){
				wp.close("close");
				wp = null;
			}
				wp = new winPanel({html:html
				,x:calcPopDivPageX(event, 350)
				,y:event.pageY+10
				,width:350
				,isautoclose: true
				,closeAction: "close"
				, listeners:{ closeAfter:function(){
						wp = null; 
						}
					, loadAfter:function(){ 
						} 
					} }
				,{winpanel_DomStruFn:"blackLayer_winpanel_DomStruFn" }); 
			
		  },error:function(){alert(msg.responseText);}
		});
	});
}

function node_NodeClick(node) {
	var nodeId = node.getId();
	if(nodeId.indexOf('_')>0){
		nodeId = nodeId.split('_');
		if(nodeId.length > 1){
			window.location.href = 'queryProfile.action?basicInfo.profileId=' + nodeId[1];
		}
	}
};

function resetDefaultValue() {
	$('#resetDefaultValue').bind('click',function(){
		win.setContentText('此操作将覆盖所做的设置，并立即生效，是否确认执行？');
		win.setConfirm_listener(function(){
			win.hide();
			$.blockUI({message:$('#loading')});
			var profileId = "profileId=" + $('input[name=basicInfo.profileId]').val();
			var resourceId = "&resourceId=" + $('input[name=basicInfo.resourceId]').val();
			var data = profileId + resourceId;
			
			$.ajax({
				type:"post",
				cache:false,
				url:path+"/profile/userDefineProfile/resetDefaultValue.action",
				data:data,
				dataType:"html",
				success:function(data){
					$("#metric_div").html("").append(data);
					metricSettingChange();
					cueMinClick();
					advSettingClick();
					allSelectAlarm();
			        allSelectMonitor();
			        allSelectCritical();
					$.unblockUI();
				},
				error:function(msg){alert(msg.responseText);$.unblockUI();}
			
			});
		});
		win.show();
	});
}

var metricSettingChange = function() {
	$(':input','#metricSetting').bind('change',function(){
		if(!isMetricSetChange){
			$('#modifyListen_metricSet').val(true);
			isMetricSetChange = true;
		}
		var name = $(this).attr('name');
		var haveChange = $(this).parentsUntil('table').parent().prev().children("[name$=haveChange]");
		haveChange.val(true);
		if(name == 'monitor'){
			$(this).next().val($(this).is(':checked'));
//			$(this).next().next().val(true);
		}else if(name == 'critical'){
			var tag = $(this).is(':checked');
			$(this).next().val(tag);
			if(tag){
				$(this).parent().parent().find("div[name=cue_min]").attr("disabled","");
				$(this).parent().parent().find("ul[name=eventName_ul]").attr("disabled","");
				$(this).parent().parent().find("ul[name=notification_ul]").attr("disabled","");
				$(this).parent().parent().find("ul[name=event_ul]").attr("disabled","");
				$(this).parent().parent().find("span[name=metric_number]").attr("disabled","");
				$(this).parent().parent().find("span[name=metric_number]").find("input[type=text]").attr("disabled","");
				$(this).parent().parent().find("span[id=setting]").attr("disabled","").attr("class","ico ico-equipment");
			}else{
				$(this).parent().parent().find("div[name=cue_min]").attr("disabled","disabled");
				$(this).parent().parent().find("ul[name=eventName_ul]").attr("disabled","disabled");
				$(this).parent().parent().find("ul[name=notification_ul]").attr("disabled","disabled");
				$(this).parent().parent().find("ul[name=event_ul]").attr("disabled","disabled");
				$(this).parent().parent().find("span[name=metric_number]").attr("disabled","disabled");
				$(this).parent().parent().find("span[name=metric_number]").find("input[type=text]").attr("disabled","disabled");
				$(this).parent().parent().find("span[id=setting]").attr("disabled","disabled").attr("class","ico ico-equipment-off");
			}
//			$(this).next().next().val(true);
		}else if(name.indexOf('frequencyId')>0){
			$(this).next().val(true);
		}else if(name.indexOf('notification')>0){
//			var _index = $(this).attr('name');
//			_index = _index.replace('notification','haveChange');
			var $haveChange = $(this).parent().parent().parent().prev().find("input[name$=haveChange]");
			$haveChange.val(true);
		}else if(name.indexOf('severityId')>0){
			$(this).next().val(true);
		}
		
		//设置指标组监控变量
		var parentAttrid = $(this).parentsUntil('li[id=metricgroup_next]').parent().attr('parentAttrid');
		$("[groupAttrid="+parentAttrid+"]").val(true);
	})
}

var cueMinClick = function() {
	$('.cue-min').click(function(event){
		var self = $(this);
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
		},event.pageX,event.pageY);
	});//阈值
}


var chooseResInsAllClick = function() {
	$('#ChooseResInsAll').click(function(){
		var value = $('[name=stateRaidos]:checked').val();
		if(value == "true"){
			$('#left_resIns').children('[state=true][canMove=true]').find('[name=resInsSelect.leftResIns.instanceId]').attr('checked',$(this).attr('checked'));
		}
		else if(value == "false"){
			$('#left_resIns').children('[state!=true][canMove=true]').find('[name=resInsSelect.leftResIns.instanceId]').attr('checked',$(this).attr('checked'));
		}else{
			$('#left_resIns').children('[canMove=true]').find('[name=resInsSelect.leftResIns.instanceId]').attr('checked',$(this).attr('checked'));
		}
	})
}
var chooseResInsMineClick = function() {
	$('#ChooseResInsMine').click(function(){
		$('#right_resIns').find('[name=resInsSelect.instanceIds]').attr('checked',$(this).attr('checked'));
	})
}
var resInsTurnRightClick = function() {
	$('#resins-turn-right').click(function(){
    var isEdit = $('[name=basicInfo.enable]').val();
    if(isEdit=='true'){
      return;
    }
		var $list = $('#left_resIns').children('[canMove=true]').find('[name=resInsSelect.leftResIns.instanceId]:checked');
		if($list.length == 0) {
			var _information = new information({text:"请选择要移入的资源。"});
			_information.show();
		}
		$list.attr('name','resInsSelect.instanceIds');
		$list.attr('checked',false);
		$list.parent().parent().children(":last-child").find("div").hide();
		$('#right_resIns').append($list.parent().parent().parent().parent());
		changeResSelect();
		$('#ChooseResInsAll').attr("checked", false);
		$('#ChooseResInsMine').attr("checked", false);
	})
}
var resInsTurnLeftClick = function() {
	$('#resins-turn-left').click(function(){
    var isEdit = $('[name=basicInfo.enable]').val();
    if(isEdit=='true'){
      return;
    }
		var $list = $('#right_resIns').find('[name=resInsSelect.instanceIds]:checked');
		if($list.length == 0) {
			var _information = new information({text:"请选择要移出的资源。"});
			_information.show();
		}
		$list.attr('name','resInsSelect.leftResIns.instanceId');
		$list.attr('checked',false);
		$list.parent().parent().children(":last-child").find("div").show();
		$('#left_resIns').append($list.parent().parent().parent().parent());
		changeResSelect();
		$('#ChooseResInsAll').attr("checked", false);
		$('#ChooseResInsMine').attr("checked", false);
	})
}
function confirmButtonClick() {
	$('#confirm_button').click(function(){profileSubmit(true)});
}
function applyButtonClick() {
	$('#apply_button').click(function(){profileSubmit(false)});
}
function addUserDefEventClick() {
	$("#addUserDefEvent").click(function() {openCustomEventPage(); });
}
var radioClick = function() {
	$('input[name=stateRaidos]').click(function() {
		var value = $('[name=stateRaidos]:checked').val();
		if(value == "false") {
			showUnmonitorRes();
		}else if(value == "true") {
			showMonitorRes();
		}else {
			showAllRes();
		}
	});
}
var customEventInputChange = function() {
	$(":input","#customEvent").change(function(){changeCustomEvent(); });//自定义事件
}
var alarmTurnRightClick = function() {
	/**
	*告警规则
	*/
	$("#addAlarmToProfile").click(function(){
    var isEdit = $('[name=basicInfo.enable]').val();
    if(isEdit=='true'){
      return;
    }
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
}
var alarmTurnLeftClick = function() {
	$("#delAlarmToProfile").click(function(){
    var isEdit = $('[name=basicInfo.enable]').val();
    if(isEdit=='true'){
      return;
    }
		var flag = false;
		var $rightAlarm = $(":checkbox:checked","#rightAlarm");
		if($rightAlarm.length == 0) {
      var _information = new information({text:"请选择要取消的告警规则。"});
			_information.show();
		}
		$(":checkbox:checked","#rightAlarm").each(function(i,e){
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
}
var advSettingClick = function() {
	$('span[id=setting]').click(function(){
		var metricId = $(this).parentsUntil('table').parent().prev().children("[name$=metricId]").val();
		var profileId = $("[name=basicInfo.profileId]").val();
		var resourceId = $("[name=basicInfo.resourceId]").val();
		
		var isEdit = $('[name=basicInfo.enable]').val();
		var winOpenObj = {};
		winOpenObj.height = '500';
		winOpenObj.width = '750';
		winOpenObj.name = 'performanceEdit';
		winOpenObj.url = path+'/profile/performanceEdit.action?isEdit='+isEdit+'&metricId=' + metricId + '&profileId=' + profileId + '&resourceId=' + resourceId;
		winOpenObj.scrollable = false;
		winOpenObj.resizeable = false;
		winOpen(winOpenObj);
	});
}
var monitorFreqClick = function() {
	$('div[id=monitorFreq]').click(function(){
		var metricId = $(this).parentsUntil('table').parent().prev().children("[name$=metricId]").val();
		var profileId = $("[name=basicInfo.profileId]").val();
		var resourceId = $("[name=basicInfo.resourceId]").val();
		var winOpenObj = {};
		winOpenObj.height = '500';
		winOpenObj.width = '750';
		winOpenObj.name = 'performanceEdit';
		winOpenObj.url = path+'/profile/performanceEdit.action?monitorFreq=true&metricId=' + metricId + '&profileId=' + profileId + '&resourceId=' + resourceId;;
		winOpenObj.scrollable = true;
		winOpen(winOpenObj);
	});
}
var openCustomEvent = function() {
	$('[id^=openCustom_]').bind('click',function(){
		var composeId = $(this).attr("id").split("_")[1];
		openCustomEventPage(composeId);
	});
}
var deleteCustomEventClick = function() {
	$("#customEvent .ico-delete").bind('click',function(){
		win.setContentText('此操作不可恢复，是否确认执行此操作？');
		win.setConfirm_listener(function(){
			win.hide();
			var $obj = $(this).parentsUntil("li").parent();
			deleteCustomEvent($obj);
		});
		win.show();

	});
}
var openAlarmDef = function() {
	$('.r-ico-add').click(function() {
		var winOpenObj = {};
		winOpenObj.height = '600';
		winOpenObj.width = '670';
		winOpenObj.name = 'alarmDef';
		winOpenObj.url = path +'/profile/alarm/alarmDef.action?commonRule.basicInfo.moduleId=BSM_PROFILE&ruleDomainId='+$("#basicInfo_doaminId").val();
		winOpenObj.scrollable = true;
		winOpen(winOpenObj);
	});
}
var allSelectAlarm = function() {
	$("#alarmAllSelect").click(function(){
		var array = $("input[flag='whetherAlarm']");
		var checkState = $("#alarmAllSelect").attr("checked");
		if(!isMetricSetChange){
			$('#modifyListen_metricSet').val(true);
			isMetricSetChange = true;
		}
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
    if(!isMetricSetChange){
			$('#modifyListen_metricSet').val(true);
			isMetricSetChange = true;
		}
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
    if(!isMetricSetChange){
			$('#modifyListen_metricSet').val(true);
			isMetricSetChange = true;
		}
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

var whetherAlarm = function() {
	$("input[flag='whetherAlarm']").click(function(){
		if($(this).attr("checked") == false) {
			$("#alarmAllSelect").attr("checked",false);
		}
	});
}
function regulation(){
	$(".cue-content").each(function(){
		revise($($(this).find(".cue-min-note-red")[0]),$($(this).find(".cue-min-note-yellow")[0]));
	});
	
};
var submitFlag = false;
function checkRepeatSubmit() {
	if(submitFlag) {
		alert("正在提交，请稍候...");
		return true;
	}else {
		submitFlag = true;
		return false;
	}
}

function generateSelectHtmlByString(str) {
	var html="";
	var arr = str.split(",");
	if(arr != null && arr.length > 0) {
		html = "<select style='width:120px;'>";
		for(var i = 0; i < arr.length; i++){
			html += "<option>" + arr[i] + "</option>";
		}
		html += "</select>";
	}
	return html;
}
function generateSelectHtmlByArray(arr) {
   var html="";
   if(arr != null && arr.length > 0) {
	   html = "<select style='width:120px;'>";
       for(var i = 0; i < arr.length; i++){
       	html += "<option>" + arr[i] + "</option>";
       }
       html += "</select>";
   }
   return html;
}
/**********结束***********/

/**********分页签加载-开始***********/
function loadResIns() {
	$resIns_div = $("#resIns_div");
	if($resIns_div.html() == "") {
		var profile_parentId = $("input[name=basicInfo.parentId]").val();
		if(profile_parentId == "" || profile_parentId == null) {
			//主资源
			var url = path+"/profile/userDefineProfile/queryResIns.action";
			var data = "profileId=" + $('input[name=basicInfo.profileId]').val();
			var array = [];
			array.push(chooseResInsAllClick);
			array.push(chooseResInsMineClick);
			array.push(resInsTurnLeftClick);
			array.push(resInsTurnRightClick);
			array.push(insanceMouseOver);
			array.push(radioClick);
			loadTagPage(url, data, $resIns_div, array);
		}else {
			//子资源
			var url = path+"/profile/childInsSelect.action";
			if($('input[name=basicInfo.resourceId]').val().indexOf("Process")>0){
				var url = path+"/profile/processChildInsSelect.action";
			}
			var data = "parentProfileId=" + profile_parentId;
			data+="&childProfileId="+$('input[name=basicInfo.profileId]').val();
			data+="&filterCondition=";
			data+="&resName="+$('input[name=basicInfo.resourceType]').val();
			data+="&resId="+$('input[name=basicInfo.resourceId]').val();
			var array = [];
			array.push(chooseResInsAllClick);
			array.push(chooseResInsMineClick);
			array.push(resInsTurnLeftClick);
			array.push(resInsTurnRightClick);
			loadTagPage(url, data, $resIns_div, array);
			
		}
	}
}
function loadMetric() {
	$metric_div = $("#metric_div");
	if($metric_div.html() == "") {
		var url = path+"/profile/userDefineProfile/queryMetric.action";
		var profileId = "profileId=" + $('input[name=basicInfo.profileId]').val();
		var resourceId = "&resourceId=" + $('input[name=basicInfo.resourceId]').val();
		var data = profileId + resourceId;
		var array = [];
		array.push(metricSettingChange);
		array.push(cueMinClick);
		array.push(advSettingClick);
		array.push(allSelectAlarm);
		array.push(allSelectMonitor);
		array.push(allSelectCritical);
		array.push(whetherAlarm);
		array.push(monitorFreqClick);
		loadTagPage(url, data, $metric_div, array, array);
	}
}
function loadCustomEvent(operate) {
	$customEvent_div = $("#customEvent_div");
	if(operate || $customEvent_div.html() == "") {
		var url = path+"/profile/userDefineProfile/queryCustomEvent.action";
		var data = "profileId=" + $('input[name=basicInfo.profileId]').val();
		var array = [];
		array.push(openCustomEvent);
		array.push(deleteCustomEventClick);
		array.push(customEventInputChange);
		loadTagPage(url, data, $customEvent_div,array);
	}
}
function loadAlarmInfo() {
	$alarm_div = $("#alarm_div");
	if($alarm_div.html() == "") {
		var url = path+"/profile/userDefineProfile/queryAlarm.action";
		var data = "profileId=" + $('input[name=basicInfo.profileId]').val() + "&userDomainId="+$('').val();
		var array = [];
		array.push(alarmTurnLeftClick);
		array.push(alarmTurnRightClick);
		array.push(openAlarmDef);
		array.push(alarmInfo);
		loadTagPage(url, data, $alarm_div, array);
	}
}

function loadTagPage(url, data, divObj, array) {
	$.blockUI({message:$('#loading')});
	$.ajax({
		type:"post",
		cache:false,
		url:url,
		data:data,
		dataType:"html",
		success:function(data){
			divObj.empty().append(data);
			if(array && array.length && array.length > 0) {
				for ( var int = 0; int < array.length; int++) {
					array[int]();
				}
			}
			setProfileWhetherEdit();
			regulation();
			$.unblockUI();
		},
		error:function(msg){alert(msg.responseText);$.unblockUI();}
	
	});
}

function loadTabPageClick(currentid) {
	if(currentid == "resInsSelect") {
		loadResIns()
	}else if(currentid == "metricSetting") {
		loadMetric();
	}else if(currentid == "customEvent") {
		loadCustomEvent();
	}else if(currentid == "notifyRole") {
		loadAlarmInfo();
	}
	
}
/**********分页签加载-结束***********/
/*******Start*******/
//chooseResInsAllClick();
//chooseResInsMineClick();
//resInsTurnRightClick();
//resInsTurnLeftClick();
//radioClick();
//insanceMouseOver();

//deleteCustomEventClick();
//customEventInputChange();
//openCustomEvent();

//alarmTurnRightClick();
//alarmTurnLeftClick();
//openAlarmDef();
//alarmInfo();

//metricSettingChange();
//cueMinClick();
//monitorFreqClick();
//allSelectAlarm();
//whetherAlarm();
//advSettingClick();
/*******End*******/
