$(function(){
	var $formObj = $("#queryForm");
	var $orderBy = $("input[name='orderBy']");
	var $orderType = $("input[name='orderType']");
	var $currentPage = $("input[name='currentPage']");
	var profileId = $("[name=basicInfo.profileId]").val();
	var ok1 = $("[name=ok1]").val();
	var ok2 = $("[name=ok2]").val();
	var active = $("[name=active]").val();
	var unactive = $("[name=unactive]").val();
	var columnW = {checkBox:"3",state:"3",severity:"7",time:"15",type:"16",obj:"12",sendcontent:"37",operation:"7"}; 
	var gp = new GridPanel({id:"tableId",
		unit:"%",
		columnWidth:columnW,
		plugins:[SortPluginIndex],
		sortColumns:[{index:"time",defSorttype:"down"}],
		sortLisntenr:function($sort){
        var orderType = "desc";
        if($sort.sorttype == "up"){
			orderType = "asc";
	    }
        //var param = "&orderBy="+$sort.colId+"&orderType="+orderType;	              
        $orderBy.val($sort.colId);
        $orderType.val(orderType);
        var ajaxParam = $formObj.serialize();
        $.ajax({
              type: "POST",
              dataType:'json',
              url: path+"/notification/hisjsonSort.action?"+ajaxParam,
              success: function(data){
        			gp.loadGridData(data.dataList);
        			allSelect();
	    			selectIds();
              },
              error:function(e){
              	//alert(e.responseText);
              }
        });
		}},
		{gridpanel_DomStruFn:"index_gridpanel_DomStruFn",gridpanel_DomCtrlFn:"index_gridpanel_DomCtrlFn",gridpanel_ComponetFn:"index_gridpanel_ComponetFn"});

		gp.rend([
		{index:"checkBox",fn:function(td){
			if(td.html == "") return;
			if( typeof(isShowCheckBox)!="undefined" ){
				$font = $('<input type="checkbox" name="Ids" id="'+td.html+'_checkbox" value="'+td.html+'"/>');
				return $font;
			}else{
				$("#allSelect").hide();
				$font = $('<input type="checkbox" name="Ids" style="display:none;" id="'+td.html+'_checkbox" value="'+td.html+'"/>');
				return $font;
			}
		}},
		{index:"state",fn:function(td){
			if(td.html == "") return;
			
//			ico ico-alarm-ok 确认
//			ico ico-warning 未确认
//			ico ico-page-no 取消发送
//			ico ico-blueflag 关注
//			ico ico-alarm-ok-ncursor 确认(不带手型)
//			ico ico-warning-ncursor未确认(不带手型)
			
			var cssis = "";
			var title = "";
			if(td.html==ok1 || td.html==ok2){//确认图标
				cssis = "ico ico-alarm-ok-ncursor";
				title = "已确认";
			}else if(td.html==unactive){//活动并且未关注(告警查询里默认都是未关注的)
				cssis = "ico ico-warning-ncursor";
				title = "未确认";
			}
			$font = $('<span id="'+td.html+'_state" class="'+cssis+'" title="'+title+'"></span>');
			return $font;
		}},
		{index:"severity",fn:function(td){
			if(td.html == "") return;
			
			var array = td.html.split(',');
			var $font = $('<span class="event-level"><div class="event-level-topbottom"></div><div class="event-level-mid event-level'+array[0]+'">'+array[1]+'</div><div class="event-level-topbottom"></div></span>');
	    	return $font;
			
			//$font = $('<font title="'+td.html+'">'+td.html+'</font>');
			//return $font;
		}},
		{index:"time",fn:function(td){
			if(td.html == "") return;
			$font = $('<font title="'+td.html+'">'+td.html+'</font>');
			return $font;
		}},
		{index:"type",fn:function(td){
			if(td.html == "") return;
			$font = $('<font title="'+td.html+'">'+td.html+'</font>');
			return $font;
		}},
		{index:"obj",fn:function(td){
			if(td.html == "") return;
			var array = td.html.split('##');
			if(array[0]==null || array[0]=="null"){
				array[0] = "-";
			}
			//if(array[6] == '-Resource-linkgroup-link-'){
			if(array[6].indexOf('-link-')!=-1){
				$font = $('<span title="'+array[0]+'" class="ellipsis" style="width:106px;cursor:pointer;"><nobr>'+array[0]+'</nobr></span>');
				$font.bind("click",function(){
					var url = "/netfocus/modules/link/linkdetail2.jsp?instanceid=" + array[4];
		        	window.open(url,'linkdetail2','height=650,width=1000,scrollbars=yes');
				});
			}else if(array[5] == 'model'){
				if(array[6].indexOf('-RTMWebSite-')!=-1){
					$font = $('<span title="'+array[0]+'" class="ellipsis" style="width:106px;"><nobr>'+array[0]+'</nobr></span>');
				}else{
					$font = $('<span title="'+array[0]+'" class="ellipsis" style="width:106px;cursor:pointer;"><nobr>'+array[0]+'</nobr></span>');
					$font.bind("click",function(){
						var url = path+"/detail/resourcedetail.action?instanceId="+array[4];
			        	window.open(url,'resourcedetail','height=650,width=1000,scrollbars=yes');
					});
				}
			}else if(array[5] == "nta") {
            	$font = $('<span title="'+array[0]+'" class="ellipsis" style="width:106px;cursor:pointer;"><nobr>'+array[0]+'</nobr></span>');
				$font.bind("click",function(){
					//var url = "/nta/modules/alert/alert_mg/flash.jsp?probeId=" + array[4] + "&time=" + array[7];
					var url = "/nta/modules/alert/alert_mg/alarm_detail.jsp?probeId="+array[4]+"&occurTime="+array[7]+"&content="+encodeURIComponent(array[9])+"&platform="+encodeURIComponent(array[8])+"&objectName="+encodeURIComponent(array[0])+"&level="+encodeURIComponent(array[10]);
		        	window.open(url,'resourcedetail','height=650,width=1000,scrollbars=yes');
				});
            } else{
				$font = $('<span title="'+array[0]+'" class="ellipsis" style="width:106px;"><nobr>'+array[0]+'</nobr></span>');
			}
			return $font;
		}},
		{index:"sendcontent",fn:function(td){
			if(td.html == "") return;
			var array = td.html.split('##');//ip变更内容有逗号
			$font = $('<font style="cursor:pointer" title="'+array[0]+'">'+array[0]+'</font>');
			$font.bind("click",function(){
				var url = path+"/notification/opencontentInfo.action?eventDataId="+array[1];
				/*winOpen({
		            url: url,
		            width: 800,
		            height: 333,
		            name: 'openDetailPage'
		         });*/
		         window.open(url,'openDetailPage','height=285,width=808,scrollbars=no');
			});
			return $font;
		}},
		{index:"operation",fn:function(td){
			if(td.html == "") return;
			var array = td.html.split(',');
			
			$font = $('<span class="ico ico-t-right" id="'+array[0]+'" value="'+array[0]+'"></span>');
			$font.bind("click",function(event){
				var data = function(){};
				data.resourceTypeId = array[5];
				data.userId = getUserId();
				data.parentInstanceId =  array[3];
				$.ajax({
					type:"POST",
					url:path + "/notification/isShowMenu.action",
					data:data,
					success:function(data){
						clickMenu(event,array,data.isShowMap);
					}
				});
			});
			return $font;
		}
		}]);
		
		function clickMenu(event,array,isShowObj){
			var aa = [];
			if(array[1] == active || array[1] == unactive){
				aa.push({text:"确认",id:"affirm",listeners:{click:function(){
					var data = function(){};
					data.userId = getUserId();
					data.ids = array[0];
					data.isConfirm = 'true';
					$.ajax({
						type:"POST",
						url:path + "/notification/menu/confirm.action",
						data:data,
						success:function(){
							mc.hide();
							//var url = "/notification/historyNotificationlist.action";
							//changeGrid(url);
							document.location.href = document.location.href;
						}
					});
				 }}});
			}else{
				aa.push({text:"取消确认",id:"againinstall",listeners:{click:function(){
					$(this).attr('id')
					var data = function(){};
					data.userId = getUserId();
					data.ids = array[0];
					data.isConfirm = 'false';
					$.ajax({
						type:"POST",
						url:path + "/notification/menu/confirm.action",
						data:data,
						success:function(){
							mc.hide();
							//var url = "/notification/historyNotificationlist.action";
							//changeGrid(url);
							document.location.href = document.location.href;
						}
					});
				 }}});
			}
			
			var editlevel = {text : "修改级别" , id : "editlevel" , childMenu:{width:120,menus:[]}};
			var editLevels = [];
			if( levelnames && levelnames.length == 6 ){
				editLevels.push({text:levelnames[0],id:"severe",listeners:{click:function(){
				 	var data = function(){};
				 	data.ids = array[0];
				 	data.levelId = levelIds[0];
				 	$.ajax({
				 		type:"POST",
				 		url:path+"/notification/alterNotificationLevel.action",
				 		data:data,
				 		success:function(){
				 			mc.hide();
				 			//var url = "/notification/historyNotificationlist.action";
							//changeGrid(url,gp);
				 			document.location.href = document.location.href;
				 		}
				 	});
				 }}});
				editLevels.push({text:levelnames[1],id:"critical",listeners:{click:function(){
					var data = function(){};
				 	data.ids = array[0];
				 	data.levelId = levelIds[1];
				 	$.ajax({
				 		type:"POST",
				 		url:path+"/notification/alterNotificationLevel.action",
				 		data:data,
				 		success:function(){
				 			mc.hide();
				 			//var url = "/notification/historyNotificationlist.action";
				 			//changeGrid(url,gp);
				 			document.location.href = document.location.href;
				 		}
				 	});
				 }}});
				editLevels.push({text:levelnames[2],id:"error",listeners:{click:function(){
					var data = function(){};
				 	data.ids = array[0];
				 	data.levelId = levelIds[2];
				 	$.ajax({
				 		type:"POST",
				 		url:path+"/notification/alterNotificationLevel.action",
				 		data:data,
				 		success:function(){
				 			mc.hide();
				 			//var url = "/notification/historyNotificationlist.action";
				 			//changeGrid(url,gp);
				 			document.location.href = document.location.href;
				 		}
				 	});
				 }}});
				editLevels.push({text:levelnames[3],id:"warning",listeners:{click:function(){
					var data = function(){};
				 	data.ids = array[0];
				 	data.levelId = levelIds[3];
				 	$.ajax({
				 		type:"POST",
				 		url:path+"/notification/alterNotificationLevel.action",
				 		data:data,
				 		success:function(){
				 			mc.hide();
				 			//var url = "/notification/historyNotificationlist.action";
							//changeGrid(url);
				 			document.location.href = document.location.href;
				 		}
				 	});
				 }}});
				editLevels.push({text:levelnames[4],id:"informational",listeners:{click:function(){
					var data = function(){};
				 	data.ids = array[0];
				 	data.levelId = levelIds[4];
				 	$.ajax({
				 		type:"POST",
				 		url:path+"/notification/alterNotificationLevel.action",
				 		data:data,
				 		success:function(){
				 			mc.hide();
				 			//var url = "/notification/historyNotificationlist.action";
							//changeGrid(url);
				 			document.location.href = document.location.href;
				 		}
				 	});
				 }}});
				editLevels.push({text:levelnames[5],id:"unknown",listeners:{click:function(){
					var data = function(){};
				 	data.ids = array[0];
				 	data.levelId = levelIds[5];
				 	$.ajax({
				 		type:"POST",
				 		url:path+"/notification/alterNotificationLevel.action",
				 		data:data,
				 		success:function(){
				 			mc.hide();
				 			//var url = "/notification/historyNotificationlist.action";
							//changeGrid(url);
				 			document.location.href = document.location.href;
				 		}
				 	});
				}}});
			}
			editlevel.childMenu.menus.push(editLevels);
			
			if(isShowObj.upSeverity){
				aa.push(editlevel);
			}else{
				aa.push(
		    	 	{text:"修改级别",id:"editseverity",disable:false,disablePrompt:"无此权限，请联络系统管理员。",listeners:{click:function(){}}}
		    	 );
			}	
			if(isShowObj.deleteNoti){
				aa.push({text:"删除",id:"delete",listeners:{click:function(){
					var _confirm = new confirm_box({text:"确定要删除吗？"});
					_confirm.setConfirm_listener(function(){
			        	var data = function(){};
						data.ids = array[0];
						$.ajax({
							type:"POST",
							url:path + "/notification/deleteNotification.action",
							data:data,
							success:function(){
								mc.hide();

								if( typeof(isNotiPlat)!="undefined" ){//从告警查询
									doSubmit($formObj, path+"/notification/historyNotificationSearch.action");
								}else{
									document.location.reload();
								}
								
							}
						});
						return false;
					});
					_confirm.show();
				 }}});
			}else{
				aa.push(
		    	 	{text:"删除",id:"delete",disable:false,disablePrompt:"无此权限，请联络系统管理员。",listeners:{click:function(){}}}
		    	 );
			}
			 
			aa.push({text:"评注",id:"comment",listeners:{click:function(){
				var url = path+"/notification/seeNotificationComment.action?ids="+array[0]+"&isActivity="+array[1]+"&userId="+getUserId();
				winOpen({
		            url: url,
		            width: 625,
		            height: 235,
		            name: 'NotificationComment',
		            scrollable: true
		         });
				mc.hide();
			 }}});
			aa.push({text:"转发",id:"transpond",listeners:{click:function(){
				var url = path+"/notification/openFwEmailAndSMS.action?eventDataId="+array[2];
				winOpen({
		            url: url,
		            width: 550,
		            height: 478,
		            name: 'openFwEmailAndSMS'
		         });
				mc.hide();
			}}});
			var tool = { text : "常用工具" , id : "tool" , childMenu:{width:120,menus:[]}};
			var tools = [];
			if(isShowObj.ping){
				tools.push({text:"Ping",id:"ping",listeners:{click:function(){
					var url = "/netfocus/modules/tool/ping_tools.jsp?ip="+array[4];
					winOpen({
			            url: url,
			            width: 800,
			            height: 515,
			            name: 'ping_tools'
			         });
					mc.hide();
			 	}}});
			}
			if(isShowObj.telnet){
				tools.push({text:"Telnet",id:"telnet",listeners:{click:function(){
					var url = "/netfocus/applet/telnetApplet.jsp?address="+array[4];
					winOpen({
			            url: url,
			            width: 800,
			            height: 515,
			            name: 'telnetApplet'
			         });
					mc.hide();
			 	}}});
			}
			if(isShowObj.mib){
				tools.push({text:"MIB",id:"mib",listeners:{click:function(){
					var url = "/netfocus/applet/MIBApplet.jsp?address="+array[4];
					winOpen({
			            url: url,
			            width: 800,
			            height: 515,
			            name: 'MIBApplet'
			         });
					mc.hide();
			 	}}});
			}
			if(isShowObj.snmp){
				tools.push({text:"SNMP Test",id:"snmptest",listeners:{click:function(){
					var url = "/netfocus/modules/tool/snmptest.jsp?ip="+array[4];
					winOpen({
			            url: url,
			            width: 800,
			            height: 515,
			            name: 'snmptest'
			         });
					mc.hide();
			 	}}});
			}
			if(isShowObj.tranceroute){
				tools.push({text:"TraceRoute",id:"traceroute",listeners:{click:function(){
					var url = "/netfocus/modules/tool/traceroute_tools.jsp?ip="+array[4];
					winOpen({
			            url: url,
			            width: 800,
			            height: 515,
			            name: 'traceroute_tools'
			         });
					mc.hide();
			 	}}});
			}
			if(tools.length > 0){
				tool.childMenu.menus.push(tools);
				aa.push(tool);
			}
			
			var analysis = { text : "告警分析" , id : "analysis" , childMenu:{width:120,menus:[]}};
			var analysiss = [];
			analysiss.push({text:"查看告警记录",id:"viewNotification",listeners:{click:function(){
				var url = path+"/notification/viewNotification.action?eventDataId="+array[2]+"&eventOccurTime="+array[7]+"&parentInstanceId="+array[3]+"&tab=2";
				winOpen({
		            url: url,
		            width: 700,
		            height: 383,
		            name: 'viewNotification',
		            scrollable: false
		         });
				mc.hide();
			 }}});
			analysiss.push({text:"查看关联事件",id:"viewNotification",listeners:{click:function(){
				var url = path+"/notification/viewNotification.action?eventDataId="+array[2]+"&eventOccurTime="+array[7]+"&parentInstanceId="+array[3]+"&tab=1";
				winOpen({
		            url: url,
		            width: 700,
		            height: 383,
		            name: 'viewNotification',
		            scrollable: false
		         });
				mc.hide();
			 }}});
			/*analysiss.push({text:"查看告警记录",id:"seelog",listeners:{click:function(){
					var url = path+"/notification/seeNotificationLog.action?eventDataId="+array[2];
					winOpen({
			            url: url,
			            width: 1020,
			            height: 688,
			            name: 'seeNotificationLog',
			            scrollable: true
			         });
					mc.hide();
				 }}});
			analysiss.push({text:"查看关联事件",id:"seelog",listeners:{click:function(){
					var data = function(){};
					data.eventDataId = array[2];
					$.ajax({
						type:"POST",
						url:path + "/notification/seeEventState.action",
						data:data,
						success:function(data){
							if(data.eventState=="history"){
								var src = src=path + "/event/eventDetailInfo!historyDetailInfo.action?eventDetailInfoVO.eventId="+array[2];
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
								var src=path + "/event/eventDetailInfo!activeDetailInfo.action?eventDetailInfoVO.eventId="+array[2];
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
							mc.hide();
						}
					});
				 }}});*/
			analysiss.push({text:"历史告警分析",id:"historyAlert",listeners:{click:function(){
				var userId = getUserId();
				//var viewId=  getViewId();
				var url = path+"/notification/historyAlert.action?userId="+userId+"&viewId=&parentInstanceId="+array[3];
				winOpen({
		            url: url,
		            width: 1035,
		            height: 620,
		            name: 'historyAlert'
		         });
				mc.hide();
		 	}}});
		 	
		 	var objanalysis = { text : "告警对象分析" , id : "objanalysis" , childMenu:{width:120,menus:[]}};
			var objanalysiss = [];
		 	
			if(isShowObj.resDetail){
				if(array[5].indexOf('-link-')!=-1){//链路详细信息
					objanalysiss.push({text:"资源详细信息",id:"linkdetail2_"+array[3],listeners:{click:function(){
						var url = "/netfocus/modules/link/linkdetail2.jsp?instanceid=" + array[3];
				         winOpen({
				            url: url,
				            width: 1000,
				            height: 650,
				            name: 'linkdetail2_' + array[3],
				            scrollable: true
				         });
						mc.hide();
				 	}}});
				}else{//资源详细信息
					objanalysiss.push({text:"资源详细信息",id:"resdetail_"+array[3],listeners:{click:function(){
						var url = path + "/detail/resourcedetail.action?instanceId=" + array[3];
				         winOpen({
				            url: url,
				            width: 980,
				            height: 600,
				            name: 'resdetail_' + array[3]
				         });
						mc.hide();
				 	}}});
				}
			}
			
			if(isShowObj.backInfo){
				objanalysiss.push({text:"背板信息",id:"backboard",disable:isShowObj.backInfoLicense,disablePrompt:"无背板信息License，请联络摩卡软件获取购买相关License的信息。",listeners:{click:function(){
					var url = path+"/notification/backInfo.action?parentInstanceId="+array[3];
					winOpen({
			            url: url,
			            width: 1000,
			            height: 610,
			            name: 'backboard'
			         });
					mc.hide();
			 	}}});
			}
			
			if(isShowObj.nta){
				objanalysiss.push({text:"流量分析",id:"trifficAnaly",disable:isShowObj.ntaLicense,disablePrompt:"无流量分析License，请联络摩卡软件获取购买相关License的信息。",listeners:{click:function(){
					var url = path + "/notification/trifficAnaly.action?parentInstanceId="+array[3];
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
							}
							mc.hide();
						}
					});
			 	}}});
			}
			
			//TODO 物理位置
			if(isShowObj.physicPosition){
				objanalysiss.push({text:"物理位置",id:"physicPosition",disable:isShowObj.physicPositionLicense,disablePrompt:"无物理位置License，请联络摩卡软件获取购买相关License的信息。",listeners:{click:function(){
					
					if(array[3].indexOf("room")!=-1){
						//TODO 机房物理位置
						var url = path+"/notification/physicPosition.action?parentInstanceId="+array[3];
	    				winOpen({url:url,width:343,height:335,name:'physicPosition'});
					}else{
						var url = path + "/detail/detailoperate!locationInfo.action?instanceId=" + array[3];
						winOpen({
				            url: url,
				            width: 343,
				            height: 335,
				            name: 'physicPosition'
				         });
					}
					
					mc.hide();
			 	}}});
			}
			
			
			if(isShowObj.focusNic){
				objanalysiss.push({text:"接口定位",id:"nf_for_trouble",disable:isShowObj.focusNicLicense,disablePrompt:"无接口定位License，请联络摩卡软件获取购买相关License的信息。",listeners:{click:function(){
					var url = path + "/notification/focusNic.action?parentInstanceId="+array[3] + "&instanceId=" + array[6];
					winOpen({
			            url: url,
			            width: 800,
			            height: 600,
			            name: 'nf_for_trouble'
			         });
					mc.hide();
			 	}}});
			}
			if(isShowObj.aboutDevice){
				objanalysiss.push({text:"下联设备",id:"aboutdevice",disable:isShowObj.aboutDeviceLicense,disablePrompt:"无下联设备License，请联络摩卡软件获取购买相关License的信息。",listeners:{click:function(){
					
				//获取nodeId
				var url = path+"/notification/aboutDevice.action?parentInstanceId="+array[3];	
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
								mc.hide();
							},error:function(msg){
								//alert(msg.responseText);
							}
						});
					}
				});	
					
				mc.hide();
			 	}}});
			}
			if(isShowObj.topo){
				objanalysiss.push({text:"拓扑定位",id:"focusonnetwork",disable:isShowObj.topoLicense,disablePrompt:"无拓扑定位License，请联络摩卡软件获取购买相关License的信息。",listeners:{click:function(){
					var url = "/netfocus/flash/focusonnetwork60.jsp?userid="+getUserId()+"&instanceId="+array[3];
					winOpen({
			            url: url,
			            width: 800,
			            height: 600,
			            name: 'focusonnetwork60'
			         });
					mc.hide();
			 	}}});
			}
			
			// 关联业务服务
			if(isShowObj.businessService){
				objanalysiss.push({text:"关联业务服务",id:"businessService",disable:isShowObj.businessServiceLicense,disablePrompt:"无业务服务License，请联络摩卡软件获取购买相关License的信息。",listeners:{click:function(e){
					//var url = path+"/notification/businessService.action?parentInstanceId="+array[3];
					//winOpen({
			        //    url: url,
			        //    width: 1080,
			        //    height: 626,
			         //   name: 'businessService'
			         //});
					//mc.hide();
					
			        /*var url = path+"/notification/businessService.action?parentInstanceId="+array[3];
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
							mc.hide();
						}
					});*/
					
					var panelName = null;
					var url = path+"/monitor/monitorList!businessService.action?instanceId=" + array[3];
               		if (panelName == null) {
                        var top  = (document.documentElement.clientHeight) / 2 ; 
                        var left = (document.documentElement.clientWidth) / 2 ;
                        panelName = new winPanel({
							type: "POST",
							url: url,
						    width: 370,
						    x: left-150,
						    y: top-150,
						    isautoclose: true,
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
         			mc.hide();
			         			
			         			
			         			
			 	}}});
			}
			
			if(analysiss.length > 0){
				analysis.childMenu.menus.push(analysiss);
				aa.push(analysis);
			}
			if(objanalysiss.length > 0){
				objanalysis.childMenu.menus.push(objanalysiss);
				aa.push(objanalysis);
			}
			mc.position(event.pageX,event.pageY,aa.length);
			mc.addMenuItems([aa]);
		}
		
		var mc = new MenuContext({x:850,y:55,width:150,plugins:[duojimnue],listeners:{click:function(id){}}});
		var page = new Pagination({applyId:"page",listeners:{
	  		pageClick:function(page){
	  		$currentPage.val(page);
	  		var ajaxParam = $formObj.serialize();
		  		$.ajax({
		   			type: "POST",
		   			dataType:'json',
		   			url: path+"/notification/hisjsonSort.action",
		   			data: ajaxParam,
		   			success:function(data){
		   			if(data.dataList){
		    			gp.loadGridData(data.dataList);
		    			allSelect();
		    			selectIds();
		   			}
		  			},
		  			error:function(e){
		  				//alert(e.responseText);
		  			}
		  		});
	 		}
 		}});
	allSelect();
	selectIds();
 	page.pageing(pageCount,1);
});

function allSelect(){
	var $Ids = $("input[name='Ids']");
	$("#allSelect").click(function() {
		$Ids.attr("checked",$("#allSelect").attr("checked"));
 	});
}
function selectIds(){
	$("input[name='Ids']").click(function() {
   		var param = $(this).attr("checked");
   		if(param == false) {
	   		$("#allSelect").attr("checked", false);
   		}
	})
}

function doSubmit(formObj, actionUrl) {
	formObj.attr("action", actionUrl);
	formObj.submit();
}

function changeGrid(url,gp){
	 //document.location.reload();
	var $formObj = $("#queryForm");
	var grid =$("#child_cirgrid");
	var ajaxParam = $formObj.serialize();
	 $.ajax({
		   type: "POST",
		   dataType:'html',
		   url:path+url,
		   data: ajaxParam,
		   success: function(data, textStatus){
		 	gp.loadGridData(data);
		    //$(grid).html("");
		    //$(grid).append(data);
	   }
	 });
}

function getUserId(){
	return userId;
}
