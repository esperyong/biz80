var tp = null;
var _confirm = new confirm_box({text:"是否确认执行此操作？"});
function init(){
	/*if(tp.count == 0){
		 $('#notp').show();
		 $('#yestp').hide();
	 }else{
		 $('#notp').hide();
		 $('#yestp').show();
	 }*/
}

function addTab(tabName,tabId){
	tp.addTab({text: tabName ,id:tabId});
}

function editTab(viewName,viewId){
	tp.setTabText(viewId,viewName);
}

function clearSearchBtnVisible(isShow){
	var $clearSearch = $('#clearSearch');
	if(isShow=='true'){
		$clearSearch.show();
	}else{
		$clearSearch.hide();
	}
}

function openViewEdit(tabId){
	var url = path+'/notification/viewEditor.action';
	url = url + "?viewId=" + (tabId?tabId:"");
	url = url + "&userId=" + userId;
	url = url + "&domains=" + domainId;
	url = url + "&isSystemAdmin=" + isSystemAdmin;
	winOpen({
        url: url,
        width: 700,
        height: 582,
        name: 'openViewEdit'
	});
}

var _information = new information({text:"系统默认视图不允许删除。"});
function delTab(viewId){
	if(viewId=='REAL_TIME_NOTIFICATION'){
		_information.show();
		return;
	}
	_confirm.setContentText("是否确认删除‘"+tp.getTabText(viewId)+"’视图？");
	_confirm.setConfirm_listener(function(){
		$.ajax({
			type:"POST",
			url:path+"/notification/viewEditorDel.action?viewId="+viewId,
			success:function(){
				//document.location.reload();
				tp.removeTab(viewId);
				init();
				_confirm.hide();
			}
		});
	});
	_confirm.show();
}

function getViewId(){
	return tp.currentId;
}

function getTimeId(){
	var $sel = $('#timePeriod');
	return $sel.val();
}

function getUserId(){
	return userId;
}

function getViewName(){
	return tp.getTabText(tp.currentIndex);
}

function thisMovie(movieName) {
     if (navigator.appName.indexOf("Microsoft") != -1) {
         return window[movieName];
     } else {
         return document[movieName];
     }
}

function refreshFlash(uid, viewId, timePeriod){
	thisMovie("AlertList").refreshFlash(uid, viewId, timePeriod);
}

function operationBackToFlash(){
	thisMovie("AlertList").operationBackToFlash();
}

function getDate(s){
	var now;
	if(s != 0){
		now = new Date(s);
	}else{
		now = new Date();
	}
	var year = now.getFullYear();
	var month=now.getMonth()+1;
	var day=now.getDate();
    var hour=now.getHours();
    var minute=now.getMinutes();
    var second=now.getSeconds();
    var nowdate=year+"/"+month+"/"+day+" "+hour+":"+minute+":"+second;
    return nowdate;
}

/**
 * n:number 显示的数值 x:number x轴 y:number y轴
 */
function openDateSelectPanel(n,x,y){
	var offset= $('#AlertList').offset();
	x = x + offset.left;
	y = y + offset.top;
	var event = {};

	event.srcEl = $('#ss')[0];
   	WdatePicker({
   		startDate:getDate(n),
   		dateFmt:'yyyy/MM/dd HH:mm:ss',
   		el:'ss',
   		position:{left:x,top:y},
   		onclearing:function(){
   			thisMovie("AlertList").returnSelectDate(0);
   			return 0;
   		},
   		onpicked:function(){
   			var d = new Date(this.value);
   			thisMovie("AlertList").returnSelectDate(d.getTime());
   			return d.getTime();
   		}
   	});
}

// 设置.
function openPlatFormSet() {
    var src = path + "/event/platFormSet!openPlatFormSet.action";
    var width=720;
    var height=450;
    winOpen({
        url: src,
        width: width,
        height: height,
        name: 'platFormSet',
        scrollable: true
	});
}

// 批量操作菜单
var batchOperateMenu;

// 单独操作菜单
var singleOperateMenu;

var panelName = null;

// 点击flash时调用此方法.
function closeMenu(){
	batchOperateMenu.hide();
	singleOperateMenu.hide();
	
	if(panelName != null){
		panelName.close("close");
	}
}

// 打开详细页面
function openDetailPage(eventDataId){
	var url = path+'/notification/opencontentInfo.action';
	if(eventDataId != undefined && eventDataId != null ){
		url = url + '?eventDataId=' + eventDataId;
		/*winOpen({
            url: url,
            width: 808,
            height: 285,
            name: 'openDetailPage'
		});*/
		window.open(url,'openDetailPage','height=285,width=808,scrollbars=no');
	}
}

function openResourceDetail(parentInstanceId){
	if(parentInstanceId != undefined && parentInstanceId != null ){
		var url = path+"/detail/resourcedetail.action?instanceId="+parentInstanceId;
		window.open(url,'resourcedetail','height=650,width=1000,scrollbars=yes');
	}	
}

function openLinkDetail(parentInstanceId){
	if(parentInstanceId != undefined && parentInstanceId != null ){
		var url = "/netfocus/modules/link/linkdetail2.jsp?instanceid=" + parentInstanceId;
		window.open(url,'resourcedetail','height=650,width=1000,scrollbars=yes');
	}
}
function openNTADetail(parentInstanceId,eventOccurTime,instanceName,platForm,content,level){
	if(parentInstanceId != undefined && parentInstanceId != null ){
		
		var levelName;
		if(level=="event.serverity.5"){
	    	levelName="致命";
	    }else if(level=="event.serverity.4"){
	    	levelName="严重";
	    }else if(level=="event.serverity.3"){
	    	levelName="次要";
	    }else if(level=="event.serverity.2"){
	    	levelName="警告";
	    }else if(level=="event.serverity.1"){
	    	levelName="信息";
	    }else if(level=="event.serverity.0"){
	    	levelName="未知";
	    }
		
		//var url = "/nta/modules/alert/alert_mg/flash.jsp?probeId=" + parentInstanceId + "&time=" + eventOccurTime;
		var url = "/nta/modules/alert/alert_mg/alarm_detail.jsp?probeId="+parentInstanceId+"&occurTime="+eventOccurTime+"&content="+encodeURIComponent(content)+"&platform="+encodeURIComponent(platForm)+"&objectName="+encodeURIComponent(instanceName)+"&level="+encodeURIComponent(levelName);
		window.open(url,'resourcedetail','height=650,width=1000,scrollbars=yes');
	}
}

function openSingleOpMenu(x,y,ids){
	var idss = ids.split(",");
	var objectId = idss[0].split(";")
	var data = function(){};
	var isShowObj;
	data.resourceTypeId = objectId[8];
	data.userId = getUserId();
	data.parentInstanceId =  objectId[6];
	$.ajax({
		type:"POST",
		url:path + "/notification/isShowMenu.action",
		data:data,
		success:function(data){
			openSingleOpMenuShow(x,y,ids,data.isShowMap);
		}
	});
}

// 弹出单独操作菜单
// ids : falsh传回id串
function openSingleOpMenuShow(x,y,ids,isShowObj){
	singleOperateMenu.position(x, y, 9);
	var ok1 = $("[name=ok1]").val();
	var ok2 = $("[name=ok2]").val();
	var active = $("[name=active]").val();
	var unactive = $("[name=unactive]").val();
	var operate = [];
	var idss = ids.split(",");
	var objectId = idss[0].split(";")
	if(objectId[3] == active || objectId[3] == unactive){
		operate.push({text:"确认",id:"confirm",listeners:{click:function() {
			var data = function(){};
			data.isConfirm = 'true';
			data.userId = getUserId();
			data.ids = ids;
			data.viewId = getViewId();
			$.ajax({
				type:"POST",
				url:path + "/notification/menu/confirm.action",
				data:data,
				success:function(){
					singleOperateMenu.hide();
					operationBackToFlash();
				}
			});
		}}});
	}else{
		operate.push({text:"取消确认",id:"reset",listeners:{click:function(){
			var data = function(){};
			data.isConfirm = "false";
			data.userId = getUserId();
			data.ids = ids;
			data.viewId = getViewId();
			$.ajax({type:"POST",
				url:path+"/notification/menu/confirm.action",
				data:data,
				success:function(){
					singleOperateMenu.hide();
					operationBackToFlash();
				}
			});
		}}});
	}
	if(objectId[3] == unactive){
		operate.push({text:"设为关注",id:"untop",listeners:{click:function(){
			var data = function(){};
			data.isAttention = "true";
			data.userId = getUserId();
			data.ids = ids;
			data.viewId = getViewId();
			$.ajax({
				type:"POST",
				url:path+"/notification/menu/attention.action",
				data:data,
			    success:function(data){
				    if(data.result=='true'){
				    	var _information = new information({text:"最多只能设置16个关注告警。"});
						_information.show();
				    	//alert("最多只能设置16个关注告警");
				    }
					singleOperateMenu.hide();
					operationBackToFlash();
				}
			});
		}}});
	}else if(objectId[3] == active){
		operate.push({text:"取消关注告警",id:"untop",listeners:{click:function(){
			var data = function(){};
			data.userId = getUserId();
			data.ids = ids;
			data.viewId = getViewId();
			data.isAttention = "false";
			$.ajax({
				type:"POST",
				url:path+"/notification/menu/attention.action",
				data:data,
				success:function(){
					singleOperateMenu.hide();
					operationBackToFlash();
				}
			});
		}}});
	}
	
	if(isShowObj.upSeverity){	
		operate.push({text:"修改级别",id:"levelnames",childMenu:{width:120,menus:[[
			{text:levelnames[0],id:"severe",listeners:{click:function(){
		 		var data = function(){};
		 		data.ids = ids;
		 		data.levelId = levelIds[0];
		 		$.ajax({
		 			type:"POST",
		 			url:path+"/notification/alterNotificationLevel.action",
		 			data:data,
		 			success:function(){
		 				singleOperateMenu.hide();
						operationBackToFlash();
		 			}
		 		});
			}}},
		 	{text:levelnames[1],id:"critical",listeners:{click:function(){
				var data = function(){};
		 		data.ids = ids;
		 		data.levelId = levelIds[1];
		 		$.ajax({
		 			type:"POST",
		 			url:path+"/notification/alterNotificationLevel.action",
		 			data:data,
		 			success:function(){
		 				singleOperateMenu.hide();
						operationBackToFlash();
		 			}
		 		});
		 	}}},
		 	{text:levelnames[2],id:"error",listeners:{click:function(){
				var data = function(){};
		 		data.ids = ids;
		 		data.levelId = levelIds[2];
		 		$.ajax({
		 			type:"POST",
		 			url:path+"/notification/alterNotificationLevel.action",
		 			data:data,
		 			success:function(){
		 				singleOperateMenu.hide();
						operationBackToFlash();
		 			}
		 		});
			}}},
			{text:levelnames[3],id:"warning",listeners:{click:function(){
				var data = function(){};
		 		data.ids = ids;
		 		data.levelId = levelIds[3];
		 		$.ajax({
		 			type:"POST",
		 			url:path+"/notification/alterNotificationLevel.action",
		 			data:data,
		 			success:function(){
		 				singleOperateMenu.hide();
						operationBackToFlash();
		 			}
		 		});
			}}},
			{text:levelnames[4],id:"informational",listeners:{click:function(){
				var data = function(){};
				data.ids = ids;
				data.levelId = levelIds[4];
				$.ajax({
					type:"POST",
					url:path+"/notification/alterNotificationLevel.action",
					data:data,
					success:function(){
						singleOperateMenu.hide();
						operationBackToFlash();
					}
				});
			}}},
			{text:levelnames[5],id:"unknown",listeners:{click:function(){
				var data = function(){};
				data.ids = ids;
				data.levelId = levelIds[5];
				$.ajax({
		 			type:"POST",
		 			url:path+"/notification/alterNotificationLevel.action",
		 			data:data,
		 			success:function(){
		 				singleOperateMenu.hide();
						operationBackToFlash();
		 			}
		 		});
			}}}                                                                   
		]]}});
	}else{
		operate.push(
    	 	{text:"修改级别",id:"editseverity",disable:false,disablePrompt:"无此权限，请联络系统管理员。",listeners:{click:function(){}}}
    	 );
	}
		
	if(isShowObj.deleteNoti){
		operate.push({text:"删除",id:"delete",listeners:{click:function(){
			singleOperateMenu.hide();
			_confirm.setContentText("是否确认执行此操作？");
			_confirm.setConfirm_listener(function(){
				var data = function(){};
				data.ids = ids;
				$.ajax({
					type:"POST",
					url:path + "/notification/deleteNotification.action",
					data:data,
					success:function(){
						singleOperateMenu.hide();
						operationBackToFlash();
					}
				});
				_confirm.hide();
			});
			_confirm.show();
		}}});
	}else{
		operate.push(
    	 	{text:"删除",id:"delete",disable:false,disablePrompt:"无此权限，请联络系统管理员。",listeners:{click:function(){}}}
    	 );
	}
				 	
	operate.push({text:"评注",id:"comment",listeners:{click:function(){
		var url = path+"/notification/seeNotificationComment.action?ids="+ids+"&userId="+getUserId();
		winOpen({
            url: url,
            width: 625,
            height: 235,
            name: 'NotificationComment',
            scrollable: true
         });
		singleOperateMenu.hide();
 	}}});
	operate.push({text:"转发",id:"zhuanfa",listeners:{click:function(){
		var url = path+"/notification/openFwEmailAndSMS.action?eventDataId="+ids;
		winOpen({
            url: url,
            width: 550,
            height: 478,
            name: 'openFwEmailAndSMS'
         });
		singleOperateMenu.hide();
	 }}});
		
	function getToolsArray(){
		var toolsArray = new Array();
		var i=0;
		if(isShowObj.ping){
			toolsArray[i]={text:"Ping",id:"ping",listeners:{click:function(){
				var url = "/netfocus/modules/tool/ping_tools.jsp?ip="+objectId[7];
				winOpen({
		            url: url,
		            width: 800,
		            height: 515,
		            name: 'ping_tools'
		         });
				singleOperateMenu.hide();
		 	}}};
			i++;
		}
		if(isShowObj.telnet){
			toolsArray[i]={text:"Telnet",id:"telnet",listeners:{click:function(){
				var url = "/netfocus/applet/telnetApplet.jsp?address="+objectId[7];
				winOpen({
		            url: url,
		            width: 800,
		            height: 515,
		            name: 'telnetApplet'
		         });
				singleOperateMenu.hide();
		 	}}};
			i++;
		}
		if(isShowObj.mib){
			toolsArray[i]={text:"MIB",id:"mib",listeners:{click:function(){
				var url = "/netfocus/applet/MIBApplet.jsp?address="+objectId[7];
				winOpen({
		            url: url,
		            width: 800,
		            height: 515,
		            name: 'MIBApplet'
		         });
				singleOperateMenu.hide();
		 	}}};
			i++;
		}
		if(isShowObj.snmp){
			toolsArray[i]={text:"SNMP Test",id:"snmptest",listeners:{click:function(){
				var url = "/netfocus/modules/tool/snmptest.jsp?ip="+objectId[7];
				winOpen({
		            url: url,
		            width: 800,
		            height: 515,
		            name: 'snmptest'
		         });
				singleOperateMenu.hide();
		 	}}};
			i++;
		}
		if(isShowObj.tranceroute){
			toolsArray[i]={text:"TraceRoute",id:"traceroute",listeners:{click:function(){
				var url = "/netfocus/modules/tool/traceroute_tools.jsp?ip="+objectId[7];
				winOpen({
		            url: url,
		            width: 800,
		            height: 515,
		            name: 'traceroute_tools'
		         });
				singleOperateMenu.hide();
		 	}}};
		}
			return toolsArray;
	}
		
	var toolarr = getToolsArray();
	if(toolarr.length > 0){
		operate.push({text:"常用工具",id:"tools",childMenu:{width:120,menus:[ toolarr ]}});
	}
	operate.push({text:"告警分析",id:"gjfx",childMenu:{width:120,menus:[[
	{text:"查看告警记录",id:"viewNotification",listeners:{click:function(){
		var idss = ids.split(",");
		var objectId = idss[0].split(";")
		var data = function(){};
		var url = path+"/notification/viewNotification.action?eventDataId="+objectId[4]+"&eventOccurTime="+objectId[9]+"&parentInstanceId="+objectId[6]+"&tab=2";
		winOpen({
            url: url,
            width: 700,
            height: 383,
            name: 'viewNotification',
            scrollable: false
         });
		singleOperateMenu.hide();
	}}},
	{text:"查看关联事件",id:"viewNotification",listeners:{click:function(){
		var idss = ids.split(",");
		var objectId = idss[0].split(";")
		var data = function(){};
		var url = path+"/notification/viewNotification.action?eventDataId="+objectId[4]+"&eventOccurTime="+objectId[9]+"&parentInstanceId="+objectId[6]+"&tab=1";
		winOpen({
            url: url,
            width: 700,
            height: 383,
            name: 'viewNotification',
            scrollable: false
         });
		singleOperateMenu.hide();
	}}},
		/*{text:"查看告警记录",id:"seelog",listeners:{click:function(){
			var url = path+"/notification/seeNotificationLog.action?eventDataId="+ids;
			winOpen({
	            url: url,
	            width: 1020,
	            height: 688,
	            name: 'seeNotificationLog',
	            scrollable: true
	         });
			singleOperateMenu.hide();
		}}},
		{text:"查看关联事件",id:"seelog",listeners:{click:function(){
			var idss = ids.split(",");
			var objectId = idss[0].split(";")
			var data = function(){};
			data.eventDataId = objectId[4];
			$.ajax({
				type:"POST",
				url:path + "/notification/seeEventState.action",
				data:data,
				success:function(data){
					if(data.eventState=="history"){
						var src = path + "/event/eventDetailInfo!historyDetailInfo.action?eventDetailInfoVO.eventId="+objectId[4];
            			var width=700;
            			var height=330;
            			winOpen({
				            url: src,
				            width: width,
				            height: height,
				            name: 'eventDetailInfo',
				            scrollable: true
				         });
					}else{
						var src=path + "/event/eventDetailInfo!activeDetailInfo.action?eventDetailInfoVO.eventId="+objectId[4];
            			var width=700;
            			var height=330;
            			winOpen({
				            url: src,
				            width: width,
				            height: height,
				            name: 'eventDetailInfo',
				            scrollable: true
				         });
					}
					singleOperateMenu.hide();
				}
			});
	 	}}},*/
 	{text:"历史告警分析",id:"historyAlert",listeners:{click:function(){
		var userId = getUserId();
		var viewId=  getViewId();
		var url = path+"/notification/historyAlert.action?userId="+userId+"&viewId="+viewId+"&parentInstanceId="+objectId[6];
		winOpen({
            url: url,
            width: 1035,
            height: 620,
            name: 'historyAlert'
         });
		singleOperateMenu.hide();
 	}}}
	]]}});
	
	function getAlertObjArray(){
		var objarr = new Array();
		var i=0;
		if(isShowObj.resDetail){
			if(objectId[8].indexOf('-link-')!=-1){
				objarr[i]={text:"资源详细信息",id:"linkdetail2_"+objectId[6],listeners:{click:function(){
					var url = "/netfocus/modules/link/linkdetail2.jsp?instanceid=" + objectId[6];
					winOpen({
			            url: url,
			            width: 1000,
			            height: 650,
			            name: 'linkdetail2_' + objectId[6],
			            scrollable: true
			         });
					singleOperateMenu.hide();
			 	}}};
			}else{
				objarr[i]={text:"资源详细信息",id:"resdetail_"+objectId[6],listeners:{click:function(){
					var url = path + "/detail/resourcedetail.action?instanceId=" + objectId[6];
					winOpen({
			            url: url,
			            width: 980,
			            height: 600,
			            name: 'resdetail_' + objectId[6]
			         });
					singleOperateMenu.hide();
			 	}}};
			}
		 	
			i++;
		}
		
		if(isShowObj.backInfo){
			objarr[i]={text:"背板信息",id:"backboard",disable:isShowObj.backInfoLicense,disablePrompt:"无背板信息License，请联络摩卡软件获取购买相关License的信息。",listeners:{click:function(){
				var url = path+"/notification/backInfo.action?parentInstanceId="+objectId[6];
				winOpen({
		            url: url,
		            width: 1000,
		            height: 610,
		            name: 'backboard'
		         });
				singleOperateMenu.hide();
		 	}}};
			i++;
		}
		
		if(isShowObj.nta){
			objarr[i]={text:"流量分析",id:"trifficAnaly",disable:isShowObj.ntaLicense,disablePrompt:"无流量分析License，请联络摩卡软件获取购买相关License的信息。",listeners:{click:function(){
				var url = path + "/notification/trifficAnaly.action?parentInstanceId="+objectId[6];
				var data = function(){};
				$.ajax({
						type:"POST",
						url:url,
						data:data,
						success:function(data){
							if(data.trafficAnalyUrl!="fail"){
								winOpen({
						            url: data.trafficAnalyUrl,
						            width: 1000,
						            height: 700,
						            name: 'trifficAnaly',
						            scrollable: true
						         });
						         //window.open(data.trafficAnalyUrl,'trifficAnaly','height=600,width=800, toolbar=no, menubar=no, scrollbars=yes,location=no, status=no');
							}
							singleOperateMenu.hide();
						}
					});
		 	}}};
			i++;
		}
		
		if(isShowObj.physicPosition){
			objarr[i]={text:"物理位置",id:"physicPosition",disable:isShowObj.physicPositionLicense,disablePrompt:"无物理位置License，请联络摩卡软件获取购买相关License的信息。",listeners:{click:function(){
				
				if(objectId[6].indexOf("room")!=-1){
					//TODO 机房物理位置
					var url = path+"/notification/physicPosition.action?parentInstanceId="+objectId[6];
    				winOpen({url:url,width:343,height:335,name:'physicPosition'});
				}else{
			        var url = path + "/detail/detailoperate!locationInfo.action?instanceId=" + objectId[6];
					winOpen({
			            url: url,
			            width: 343,
			            height: 335,
			            name: 'physicPosition'
			         });
				}
				
		         
				singleOperateMenu.hide();
		 	}}};
			i++;
		}
		
		if(isShowObj.focusNic){
			objarr[i]={text:"接口定位",id:"nf_for_trouble",disable:isShowObj.focusNicLicense,disablePrompt:"无接口定位License，请联络摩卡软件获取购买相关License的信息。",listeners:{click:function(){
				var url = path + "/notification/focusNic.action?parentInstanceId="+objectId[6] + "&instanceId=" + objectId[1];
				winOpen({
		            url: url,
		            width: 800,
		            height: 600,
		            name: 'nf_for_trouble'
		         });
				singleOperateMenu.hide();
		 	}}};
			i++;
		}
		if(isShowObj.aboutDevice){
			objarr[i]={text:"下联设备",id:"aboutdevice",disable:isShowObj.aboutDeviceLicense,disablePrompt:"无下联设备License，请联络摩卡软件获取购买相关License的信息。",listeners:{click:function(){
		         //获取nodeId
				var url = path+"/notification/aboutDevice.action?parentInstanceId="+objectId[6];	
				var data = function(){};
				$.ajax({
					type:"POST",
					url:url,
					data:data,
					dataType:'json',
					success:function(data){
						var url1 = "/netfocus/netfocus.do?action=position@isexistdowndevinfo&nodeID="+ data.nodeId;
						$.ajax({
							type:"POST",
							url:url1,
							dataType:'text',
							success:function(data2){
								var obj1 = new Function( 'return '+data2);
								if(obj1){
									if((obj1.call(null,null)).success){
								         winOpen({
								            url: "/netfocus/netfocus.do?action=position@getdowndevinfo&nodeID=" + data.nodeId,
								            width: 1014,
								            height: 630,
								            name: 'aboutDevice'
								         });
									}else{
										 var _information = new information();
						                _information.setContentText("没有下联设备。"); //提示框 
						                _information.show();
									}
								}
								singleOperateMenu.hide();
							},error:function(msg){
								//alert(msg.responseText);
							}
						});
					}
				});	
		         
				singleOperateMenu.hide();
		 	}}};
			i++;
		}
		if(isShowObj.topo){
			objarr[i]={text:"拓扑定位",id:"focusonnetwork",disable:isShowObj.topoLicense,disablePrompt:"无拓扑定位License，请联络摩卡软件获取购买相关License的信息。",listeners:{click:function(){
				var url = "/netfocus/flash/focusonnetwork60.jsp?userid="+getUserId()+"&instanceId="+objectId[6];
				winOpen({
		            url: url,
		            width: 800,
		            height: 600,
		            name: 'focusonnetwork60'
		         });
				singleOperateMenu.hide();
		 	}}};
			i++;
		}
		
		if(isShowObj.businessService){
			objarr[i]={text:"关联业务服务",id:"businessService",disable:isShowObj.businessServiceLicense,disablePrompt:"无业务服务License，请联络摩卡软件获取购买相关License的信息。",listeners:{click:function(){
				/*var url = path+"/notification/businessService.action?parentInstanceId="+objectId[6];
				winOpen({
		            url: url,
		            width: 1080,
		            height: 626,
		            name: 'businessService'
		         });*/
		         
         			
         			/*var url = path+"/notification/businessService.action?parentInstanceId="+objectId[6];
					var data = function(){};
					$.ajax({
						type:"POST",
						url:url,
						data:data,
						success:function(data){
							if(data.businessServiceUrl=="false"){
								alert("当前资源未关联任何业务服务");
							}else{
			         			
							}
						}
					});*/
         			
         			
					var url = path+"/monitor/monitorList!businessService.action?instanceId=" + objectId[6];
					
               		if (panelName == null) {
                        var top  = (document.documentElement.clientHeight) / 2 ; 
                        var left = (document.documentElement.clientWidth) / 2 ;
                        panelName = new winPanel({
							type: "POST",
							url: url,
						    width: 370,
						    x: left-150,
						    y: top-150,
						    isautoclose: false,
						    closeAction: "close",
						    listeners: {
                               closeAfter: function() {
                                      panelName = null;
                               },
                               loadAfter: function() {
            
                              }
                           }
                        },
                       {
                             winpanel_DomStruFn: "blackLayer_winpanel_DomStruFn"
                       });
         			}
         			singleOperateMenu.hide();
         			
		 	}}};
			i++;
		}
		
		
		return objarr;
	}
	var alertobjarr = getAlertObjArray();
	if(alertobjarr.length > 0){
		operate.push({text:"告警对象分析",id:"gjdxfx",childMenu:{width:120,menus:[alertobjarr]}});
	}
		             
	singleOperateMenu.addMenuItems([operate]);
}

function clearSearch(){
	thisMovie("AlertList").clearSearch();
}

var panal, min, big;

function turnON(){
	panal.width(panal.width()).animate({width:'195px'},null,null,function(){
	big.show();
	min.hide();
	panal.find('#in').click(function(){
		turnOFF();
	});
	min.unbind();
	});
}

function turnOFF(){
	panal.width(panal.width());
	big.hide();
	panal.animate({width:'15px'}).append(min.show());
	min.click(function(){
		turnON();
	});
	$('#in').unbind();
}

$(function() {
	$(".ui-layout-center").css({overflow:'hidden'});
	panal = $('#rightMenu');
	min = $('#min');
	big = panal.find('#big');
	$('#in').click(function(){
		turnOFF();
	});
	batchOperateMenu = new MenuContext({x : 0,y : 0,width:150,plugins:[duojimnue]});
	singleOperateMenu = new MenuContext({x : 0,y : 0,width:150,plugins:[duojimnue]});
	var screenWidth = window.screen.width-4;
	$('#AlertList').attr('width',screenWidth);
	tp = new TabPanel( {
		id : "mytab",
		width : screenWidth,
		tabBarWidth : screenWidth/2,
		plugins : [ defaultToolsPlugin ],
		listeners : {
			change : function(tab) {
				refreshFlash(getUserId(), tab.id, getTimeId());
			}
		},
		tools : [  {
			id : "close",
			cls : "tab-ico tab-ico-close",
			title : "删除",
			listeners : {
				click : function() {
					delTab(tp.currentId);
					init();
				}
			}
		} ,{
			id : "edit",
			cls : "tab-ico tab-ico-edit",
			title:"编辑视图",
			listeners : {
				click : function(tab) {
//					alert("openViewEdit(tp.currentId):"+tp.currentId);
					openViewEdit(tp.currentId);
				}
			}
		},{
			id : "add",
			cls : "tab-ico tab-ico-add",
			title : "定制视图",
			listeners : {
				click : function() {
					openViewEdit();
				}
			}
		}]

	});
	init();
	$('#addPanle').click(function() {
		openViewEdit();
	});
	// tp.addTab({text:"add1"});
	$('#clearSearch').hide();
	$('#timePeriod').change(function() {
		refreshFlash(getUserId(), getViewId(), $(this).val());
	})
	function haveSelectNotification(ids,toast) {
		if(ids == "") {
			toast.addMessage("请至少选择一项。");
			return false;
		}
		return true;
	}
	var toast = new Toast({position:"CT"});
	
	$('#batchOperate').bind('click',function(event){
		var allcheckboxs = $("input[name='Ids']:checked");
		var offset = $(this).offset();
		batchOperateMenu.position(offset.left, offset.top+$(this).height());
		var operate = [];
		operate.push(
			{text:"确认",id:"confirm",listeners:{click:function() {
				var data = function(){};
				data.isConfirm = 'true';
				var ids = thisMovie("AlertList").selectedRowIds();
				if(!haveSelectNotification(ids,toast)) {
		    		return;
		    	}
				data.userId = getUserId();
				data.ids = ids;
				data.viewId = getViewId();
				$.ajax({
					type:"POST",
					url:path + "/notification/menu/confirm.action",
					data:data,
					success:function(){
					batchOperateMenu.hide();
					operationBackToFlash();
					}
				});
		}}});
		operate.push(
			{text:"取消确认",id:"reset",listeners:{click:function(){
				var data = function(){};
				data.isConfirm = "false";
				var ids = thisMovie("AlertList").selectedRowIds();
				data.userId = getUserId();
				data.ids = ids;
				if(!haveSelectNotification(ids,toast)) {
		    		return;
		    	}
				data.viewId = getViewId();
				$.ajax({type:"POST",
					url:path+"/notification/menu/confirm.action",
					data:data,
					success:function(){
					batchOperateMenu.hide();
					operationBackToFlash();
					}
				});
		}}});	
		operate.push(
			{text:"置为关注告警",id:"untop",listeners:{click:function(){
				var data = function(){};
				data.isAttention = "true";
				var ids = thisMovie("AlertList").selectedRowIds();
				data.userId = getUserId();
				data.ids = ids;
				if(!haveSelectNotification(ids,toast)) {
		    		return;
		    	}
				data.viewId = getViewId();
				$.ajax({
					type:"POST",
					url:path+"/notification/menu/attention.action",
					data:data,
					success:function(data){
					if(data.result=='true'){
						var _information = new information({text:"最多只能设置16个关注告警。"});
						_information.show();
    					//alert("最多只能设置16个关注告警");
    				}
					batchOperateMenu.hide();
					operationBackToFlash();
					}
				});
		}}});	
		operate.push(
			{text:"取消关注告警",id:"untop",listeners:{click:function(){
				var data = function(){};
				var ids = thisMovie("AlertList").selectedRowIds();
				if(!haveSelectNotification(ids,toast)) {
		    		return;
		    	}
				data.userId = getUserId();
				data.ids = ids;
				data.viewId = getViewId();
				data.isAttention = "false";
				$.ajax({
					type:"POST",
					url:path+"/notification/menu/attention.action",
					data:data,
					success:function(){
					batchOperateMenu.hide();
					operationBackToFlash();
					}
				});
		}}});
			
		var data = function(){};
		data.userId = getUserId();
		$.ajax({
			type:"POST",
			url:path + "/notification/isShowMenu.action",
			data:data,
			success:function(data){
				if(data.isShowMap.upSeverity){
					operate.push(
						{text:"修改级别",
							id:"editlevel",
							childMenu:{
							width:120,
							menus:
							[[
								{
									text:levelnames[0],
									id:"severe",
									listeners:{
										click:function(){
											var data = function(){};
											var ids = thisMovie("AlertList").selectedRowIds();
											if(!haveSelectNotification(ids,toast)) {
									    		return;
									    	}
											data.ids = ids;
											data.levelId = levelIds[0];
											$.ajax({
												type:"POST",
												url:path+"/notification/alterNotificationLevel.action",
												data:data,
												success:function(){
													batchOperateMenu.hide();
												operationBackToFlash();
												}
											});
										}
									}
								},
						{text:levelnames[1],
							id:"critical",
							listeners:{
								click:function(){
									var data = function(){};
									var ids = thisMovie("AlertList").selectedRowIds();
									data.ids = ids;
									if(!haveSelectNotification(ids,toast)) {
							    		return;
							    	}
									data.levelId = levelIds[1];
									$.ajax({
										type:"POST",
										url:path+"/notification/alterNotificationLevel.action",
										data:data,
										success:function(){
											batchOperateMenu.hide();
										operationBackToFlash();
										}
									});
								}
							}
						},
						{
							text:levelnames[2],
							id:"error",
							listeners:{click:function(){
								var data = function(){};
								var ids = thisMovie("AlertList").selectedRowIds();
								if(!haveSelectNotification(ids,toast)) {
						    		return;
						    	}
								data.ids = ids;
								data.levelId = levelIds[2];
								$.ajax({
									type:"POST",
									url:path+"/notification/alterNotificationLevel.action",
									data:data,
									success:function(){
										batchOperateMenu.hide();
									operationBackToFlash();
									}
								});
						}}},
						{
							text:levelnames[3],
							id:"warning",listeners:{click:function(){
							var data = function(){};
							var ids = thisMovie("AlertList").selectedRowIds();
							data.ids = ids;
							if(!haveSelectNotification(ids,toast)) {
					    		return;
					    	}
							data.levelId = levelIds[3];
							$.ajax({
								type:"POST",
								url:path+"/notification/alterNotificationLevel.action",
								data:data,
								success:function(){
									batchOperateMenu.hide();
								operationBackToFlash();
								}
							});
						}}},
						{text:levelnames[4],id:"informational",listeners:{click:function(){
						var data = function(){};
							var ids = thisMovie("AlertList").selectedRowIds();
							data.ids = ids;
							if(!haveSelectNotification(ids,toast)) {
					    		return;
					    	}
							data.levelId = levelIds[4];
							$.ajax({
								type:"POST",
								url:path+"/notification/alterNotificationLevel.action",
								data:data,
								success:function(){
									batchOperateMenu.hide();
								operationBackToFlash();
								}
							});
						}}},
						{
							text:levelnames[5],
							id:"unknown",
							listeners:{click:function(){
								var data = function(){};
								var ids = thisMovie("AlertList").selectedRowIds();
								if(!haveSelectNotification(ids,toast)) {
						    		return;
						    	}
								data.ids = ids;
								data.levelId = levelIds[5];
								$.ajax({
									type:"POST",
									url:path+"/notification/alterNotificationLevel.action",
									data:data,
									success:function(){
										batchOperateMenu.hide();
									operationBackToFlash();
									}
								});
						
							}
							}
						}
					]]}});
				}else{
					operate.push(
			    	 	{text:"修改级别",id:"editseverity",disable:false,disablePrompt:"无此权限，请联络系统管理员。",listeners:{click:function(){}}}
			    	 );
				}
				if(data.isShowMap.deleteNoti){
					operate.push({text:"删除",id:"delete",listeners:{click:function(){
					var ids = thisMovie("AlertList").selectedRowIds();
					if(!haveSelectNotification(ids,toast)) {
			    		return;
			    	}
					batchOperateMenu.hide();
					_confirm.setContentText("是否确认执行此操作？");
					_confirm.setConfirm_listener(function(){
						var data = function(){};
						data.ids = ids;
						$.ajax({
							type:"POST",
							url:path + "/notification/deleteNotification.action",
							data:data,
							success:function(){
								batchOperateMenu.hide();
								operationBackToFlash();
							}
						});
						_confirm.hide();
					});
					_confirm.show();
					}}});
				}else{
					operate.push(
			    	 	{text:"删除",id:"delete",disable:false,disablePrompt:"无此权限，请联络系统管理员。",listeners:{click:function(){}}}
			    	 );
				}
				
				operate.push({text:"转发",id:"zhuanfa"
					,listeners:{click:function(){
						var ids = thisMovie("AlertList").selectedRowIds();
						var url = path+"/notification/openFwEmailAndSMS.action?eventDataId="+ids;
						winOpen({
				            url: url,
				            width: 550,
				            height: 478,
				            name: 'openFwEmailAndSMS'
				         });
						batchOperateMenu.hide();
				}}});
					
				batchOperateMenu.addMenuItems([operate]);
			}
		});
	});
	
	$('#browseMode').bind('click',function(){
		window.open(path+'/notification/browseMode.action?userId='+getUserId()+'&timeId='+getTimeId()+'&viewId='+getViewId()+'&viewName='+getViewName()
		        	,"_blank"
		        	,"fullscreen=yes");
	});
	$('[id^=ntfQuery]').click(function(){
		//window.open(path+'/notification/historyNotificationSearch.action',"_blank","fullscreen=yes");
		window.open(path+'/notification/historyNotificationQuery.action',"_blank","fullscreen=yes");
	});
	$('#set').bind('click',function(event){

		var x = event.pageX;
		var y = event.pageY;
	   	openDateSelectPanel(0,451,174);
   	});
	$('#openPlatFormSet').click(function(){
		openPlatFormSet();
	});
	$('#clearSearch').click(function(){
		clearSearch();
	});
	$('#export').click(function(){
		_confirm.setContentText("最多能导出最近1000条数据，是否继续？");
		_confirm.setConfirm_listener(function(){
			var firstTime = thisMovie("AlertList").getFirstTime();
			window.location.href = path+'/notification/NotificationExport.action?userId='+getUserId()+'&timePeriod='+firstTime+'&viewId='+getViewId()+'&viewName='+getViewName();
			_confirm.hide();
		});
		_confirm.show();
    	//window.open(path+'/notification/NotificationExport.action?userId='+getUserId()+'&timePeriod='+firstTime+'&viewId='+getViewId());
	});
});
