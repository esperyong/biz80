
function coder(str) {
    var s = "";
    var len = str.length;
    if (len == 0) return s;
    for (var i = 0; i < len; i++) {
        switch (str.substr(i, 1)) {
        case '"':
            s += "&#34;";
            break; // 双引号 &quot;
        case '$':
            s += "&#36;";
            break;
        case '%':
            s += "&#37;";
            break;
        case '&':
            s += "&#38;";
            break; // &符号 &amp;
        case '\'':
            s += "&#39;";
            break; // 单引号
        case ',':
            s += "&#44;";
            break;
        case ':':
            s += "&#58;";
            break;
        case ';':
            s += "&#59;";
            break;
        case '<':
            s += "&#60;";
            break; // 小于 &lt;
        case '=':
            s += "&#61;";
            break;
        case '>':
            s += "&#62;";
            break; // 大于 &gt;
        case '@':
            s += "&#64;";
            break; // @
        case ' ':
            s += "&#160;";
            break; // 空格 &nbsp;
        case '?':
            s += "&#169;";
            break; // 版权 &copy;
        case '?':
            s += "&#174;";
            break; // 注册商标 &reg;
        default:
            s += str.substr(i, 1);
        }
    }
    return s;
};
function searchResource(val,monitor){
	   if(val != "searchResourceTree"){
	      $("#searchSearch").val(val);
	   }
       $.blockUI({message: $('#monitorListLoading')});
       $("#searchResourceForm input[name='monitor']").val(monitor);
       var ajaxParam = $("#searchResourceForm").serialize();
       $.loadPage("main-right", path + "/monitor/monitorList!getMainRight.action?" + ajaxParam, "POST", "",function() {
       if(!$("#pointIdSel")[0]){
       	    $.unblockUI();
            Monitor.Resource.right.init();
            Monitor.Resource.right.noMonitorList.init("search", "noGroup");
            Monitor.Resource.right.monitorList.init("search", "noGroup");
            return false;
       }
       var pointInfo = $("#pointIdSel").val();
       if(!pointInfo){
       	   $.unblockUI();
           Monitor.Resource.right.init();
           Monitor.Resource.right.noMonitorList.init("search", "noGroup");
           Monitor.Resource.right.monitorList.init("search", "noGroup");
           return false;
       }
       if(pointInfo.indexOf("pc") >= 0){
       	    $.unblockUI();
       	    var monitorCount =  Monitor.Resource.right.pcList.monitorCount;
            var noMonitorCount = Monitor.Resource.right.pcList.noMonitorCount ;
            var resultCount = "";
            if (monitorCount && noMonitorCount) {
               resultCount = parseInt(monitorCount) + parseInt(noMonitorCount)
            }
            $("#searchCount").html(resultCount);
            $("#searchMonitorCount").html(monitorCount);
            $("#searchNoMonitorCount").html(noMonitorCount);
        	Monitor.Resource.right.pcList.init();
       }else{
       	    $.unblockUI();
        	Monitor.Resource.right.init();
            Monitor.Resource.right.noMonitorList.init("search", "noGroup");
            Monitor.Resource.right.monitorList.init("search", "noGroup");
       }
   });
}
//显示隐藏mainRight
function mainRightlsattr(visible){
	if(!visible || !hidX ){
		return false;
	}
	var $mainRight = $("#main-right");
	if( "hidden" == visible){
		hidX = $mainRight.detach();
	}else{
	    $mainRight.prepend(hidX);
	}
}
//物理位置
function physicalLocation(instanceId){
    var url = path + "/detail/detailoperate!locationInfo.action?instanceId=" + instanceId;
    winOpen({url:url,width:343,height:335,name:'toolsPhylocation'});
}
//刷新应用
function applicationRefresh(instanceId) {
    $.blockUI({message: $('#equipmentLoading')});
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: path + "/monitor/monitorAjaxList!applicationRefresh.action?resID=" + instanceId,
        success: function(data, textStatus) {
            var json = data.gridJson;
            $.unblockUI();
            if (json == null) {
                var _information = Monitor.Resource.infomation;
                _information.setContentText("刷新设备成功。"); //提示框 
                _information.show();
                Monitor.refresh();
            } else {
                var _information = Monitor.Resource.infomation;
                _information.setContentText("刷新设备失败。"); //提示框 
                _information.show();
            }
        },
        error: function() {
            $.unblockUI();
        }
    });
}
//刷新设备
function equipmentRefresh(instanceId) {
    $.blockUI({message: $('#equipmentLoading')});
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: path + "/monitor/monitorAjaxList!equipmentRefresh.action?resID=" + instanceId,
        success: function(data, textStatus) {
            var json = data.gridJson;
            $.unblockUI();
            if (json == null) {
                var _information = Monitor.Resource.infomation;
                _information.setContentText("刷新设备成功。"); //提示框 
                _information.show();
                Monitor.refresh();
            } else {
                var _information = Monitor.Resource.infomation;
                _information.setContentText("刷新设备失败。"); //提示框 
                _information.show();
            }
        },
        error: function() {
            $.unblockUI();
        }
    });
}
//业务服务
function businessService(instanceId) {
    var url = path + "/monitor/monitorList!businessService.action?instanceId=" + instanceId;
    if (Monitor.Resource.right.businessPanel == null) {
        var div = document.getElementById("totalDivId");
        var top = (document.documentElement.clientHeight) / 2;
        var left = (document.documentElement.clientWidth) / 2;
        Monitor.Resource.right.businessPanel = new winPanel({
            type: "POST",
            url: url,
            width: 370,
            x: left - 150,
            y: top - 150,
            isautoclose: true,
            closeAction: "close",
            listeners: {
                closeAfter: function() {
                    Monitor.Resource.right.businessPanel = null;
                },loadAfter: function() {}
            }
        },{
            winpanel_DomStruFn: "blackLayer_winpanel_DomStruFn"
        });
    }
}
//个性化策略
function customProfile(instanceId, rowIndex) {
    winOpen({
        url: path + "/profile/customProfile/queryCustomProfile.action?instanceId=" + instanceId + "&rowIndex=" + rowIndex,
        width: 770,
        height: 610,
        scrollable: true,
        name: 'customProfile'
    });
}
//接口定位
function interlocal(instanceId) {
    $.blockUI({message: $('#monitorListLoading')});
    var qurl = path + "/monitor/monitorAjaxList!interlocal.action?instanceId=" + instanceId;
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: qurl,
        success: function(data, textStatus) {
            var nodeId = data.upNodeId;
            var index = data.upIndex;
            var width = 560;
            var height = 490;
            $.unblockUI();
            if (nodeId && index) {
                var url = "/netfocus/modules/3rd/nf_for_trouble.jsp?nodeId=" + nodeId + "&ifIndex=" + index;
                winOpen({
                    url: url,
                    width: 560,
                    height: 490,
                    scrollable: false,
                    name: 'detailInterlocal'
                });
            } else {
                var url = "/netfocus/modules/3rd/nf_for_trouble.jsp?nodeId=" + nodeId + "&ifIndex=" + index;
                winOpen({
                    url: url,
                    width: 560,
                    height: 320,
                    scrollable: false,
                    name: 'detailInterlocal'
                });
            }
        }, error: function() {
            $.unblockUI();
        }
    });
}
//查看下联设备
function bottomAlliedEquipment(nodeId) {
    if (!nodeId || nodeId == null || nodeId == '-' || nodeId == '' || nodeId == 'null') {
        var _information = Monitor.Resource.infomation;
        _information.setContentText("此资源不在拓扑中。"); //提示框 
        _information.show();
        return false;
    }
    var netUrl = "/netfocus/netfocus.do?action=position@isexistdowndevinfo&nodeID="+ nodeId;
    $.ajax({
          type:"POST",
          url:netUrl,
          dataType:'text',
          success:function(data1){
          if(!data1){
              var _information = new information({text:"没有下联设备。"});
              _information.show();
              return false；
          }
          var obj1 = eval("(" + data1 + ")");
          if (obj1) {
           if(obj1.success){
             var equipUrl = "/netfocus/netfocus.do?action=position@getdowndevinfo&nodeID=" + nodeId;
             winOpen({url:equipUrl,width:1014,height:630,scrollable:false,name:'detailEquipment'});
           }else{
              var _information = new information({text:"没有下联设备。"});
              _information.show();
           }
          } else {
            var _information = new information({text:"没有下联设备。"});
            _information.show();
          }
        }
    });
}
//未监控变更设备类型
function noMonitorChangeType(instanceId) {
    winOpen({
        url: path + "/discovery/resource-instance-changetype.action?instanceId=" + instanceId,
        width: 660,
        height: 260,
        scrollable: true,
        name: 'changeType'
    });
}
//已监控变更设备类型
function monitorChangeType(instanceId) {
    winOpen({
        url: path + "/discovery/resource-instance-changetype.action?instanceId=" + instanceId,
        width: 660,
        height: 260,
        scrollable: true,
        name: 'changeType'
    });
}
//变更发现信息
function changeFindInfo(instanceId) {
    winOpen({
        url: path + "/discovery/resource-instance-editinfo.action?instanceId=" + instanceId,
        width: 605,
        height: 295,
        scrollable: false,
        name: 'changeFindInfo'
    });
}
//已监控重新发现
function rediscovery(instanceId) {
    winOpen({
        url: path + "/discovery/resource-instance-rediscovery.action?instanceId=" + instanceId,
        width: 660,
        height: 320,
        scrollable: true,
        name: 'rediscovery'
    });
}
//未监控重新发现
function rediscoveryNoMonitor(instanceId) {
    winOpen({
        url: path + "/discovery/resource-instance-rediscovery.action?instanceId=" + instanceId,
        width: 660,
        height: 320,
        scrollable: true,
        name: 'rediscovery'
    });
}
Monitor.Resource.right.openSpecfiyWindow = function(windowName) {
	this.width = '525';
	this.height = '200';
	this.scrollable = true;
    winOpen({
        url: 'about:blank',
        width: this.width,
        height: this.height,
        scrollable: this.scrollable,
        name: windowName
    });
}
Monitor.Resource.right.openDelResultWindow = function(windowName) {
    var left = $(window).width() / 2 - 300 / 2;
    var top = $(window).height() / 2 - 200 / 2;
    window.open('about:blank', windowName, 'width=350,height=230,menubar=no,scrollbars=no,left=' + left + ',top=' + top);
}
Monitor.Resource.right.openStarMonitorResultWindow = function(windowName) {
    winOpen({
        url: 'about:blank',
        width: 500,
        height: 245,
        scrollable: false,
        name: windowName
    });
}
Monitor.Resource.left.group.clear = function() {
    $("#resourceGroupDiv").find("*").unbind();
    $("#resourceGroupDiv").html("");
};
Monitor.Resource.left.equipment.clear = function() {
    $("#equipmentDiv").find("*").unbind();
    $("#equipmentDiv").html("");
};
Monitor.Resource.left.application.clear = function() {
    $("#applicationDiv").find("*").unbind();
    $("#applicationDiv").html("");
};
Monitor.Resource.left.search.clear = function() {
    $("#searchResourceDiv").find("*").unbind();
    $("#searchResourceDiv").html("");
};
Monitor.Resource.left.clear = function() {
    $("#resourceDiv").find("*").unbind();
    $("#resourceDiv").html("");
};
Monitor.Resource.right.clear = function() {
    $("#main-right").find("*").unbind();
    $("#main-right").html("");
};
Monitor.Resource.right.monitorGrid.clear = function() {
    $("#monitorGrid").find("*").unbind();
    $("#monitorGrid").html("");
};
Monitor.Resource.right.noMonitorGrid.clear = function() {
    $("#nomonitorGrid").find("*").unbind();
    $("#nomonitorGrid").html("");
};
Monitor.Resource.right.refresh = function(ponitId, monitor, whichTree, whichGrid, currentTree, currentResourceTree, action) {
    $("#submitForm #pointId").val("");
    $("#submitForm #monitor").val("");
    $("#submitForm #whichTree").val("");
    $("#submitForm #whichGrid").val("");
    $("#submitForm #currentTree").val("");
    $("#submitForm #currentResourceTree").val("");
    $("#submitForm").attr('action', path + "/monitor/monitorList.action");
    if (ponitId) {
        $("#submitForm #pointId").val(ponitId);
    }
    if (monitor) {
        $("#submitForm #monitor").val(monitor);
    }
    if (whichTree) {
        $("#submitForm #whichTree").val(whichTree);
    }
    if (whichGrid) {
        $("#submitForm #whichGrid").val(whichGrid);
    }
    if (currentTree) {
        $("#submitForm #currentTree").val(currentTree);
    }
    if (currentResourceTree) {
        $("#submitForm #currentResourceTree").val(currentResourceTree);
    }
    if (action) {
        $("#submitForm").attr('action', path + action);
    }
    $("#submitForm").submit();
};
function refreshPage(instanceId,whichPage) {
	if( whichPage && whichPage == "discovery" ){
	   $("#submitForm").attr('action', path + "/monitor/monitorList.action?instanceId=" + instanceId[0]);
	}else{
	   $("#submitForm").attr('action', path + "/monitor/monitorList.action");
	}
    $("#submitForm").submit();
}
function judgeNoMonitorMenu(items,permission,reason) {
    var length = items.length;
    for (var i = 0; i < length; i++) {
        var item = items[i];
        for (var j = 0, jlen = item.length; j < jlen; j++) {
            item[j].disable = permission;
            if (reason && reason == "noPermission") {
                item[j].disablePrompt = "无此权限，请联络系统管理员。";
            }
            if (item[j].childMenu) {
                if (item[j].childMenu.menus) {
                    var itemj = item[j].childMenu.menus;
                    for (var k = 0, klen = itemj.length; k < klen; k++) {
                        var itemk = itemj[k];
                        for (var l = 0, llen = itemk.length; l < llen; l++) {
                            itemk[l].disable = permission;
                            if (reason && reason == "noPermission") {
                                item[l].disablePrompt = "无此权限，请联络系统管理员。";
                            }
                        }
                    }
                }
            }

        }
    }
}
function judgeMonitorMenu(items,jsonstr) {
    var length = items.length;
    var permission = jsonstr[0].permission;
     var reason = "";
    if(permission == "false"){
       permission = false;
       reason = "无此权限，请联络系统管理员。";
    }else{
       permission = true;
    }
    for (var i = 0; i < length; i++) {
        var item = items[i];
        for (var j = 0, jlen = item.length; j < jlen; j++) {
        	if(item[j].id == "associatedBusinessService"){
        		if( permission == true ){
        		   	var service = jsonstr[3].service;
        		    if(service == "false"){
        		       item[j].disable = false;
        		    }else{
        		       item[j].disable = true;
        		    }
                    if(service && service=="false"){
                	   item[j].disablePrompt = "无业务服务License，请联络摩卡软件获取购买相关License的信息。";
                    }
        		} 
        	} else if(item[j].id == "InterfaceLocalization" || item[j].id == "topologyLocation" || item[j].id == "bottomAlliedEquipment"){
        		    if(permission == true){
        		       var nf = jsonstr[1].nf;
        		       if(nf == "false"){
        		          item[j].disable = false;
        		       }else{
        		          item[j].disable = true;
        		       }
                       if(nf && nf=="false"){
                	      item[j].disablePrompt = "无网络拓扑License，请联络摩卡软件获取购买相关License的信息。";
                       }
        		    }
        	      }else if(item[j].id == "physicalLocation"){
        	      	         if( permission == true ){
        		                 var location = jsonstr[2].location;
        		                 if(location == "false"){
        		                    item[j].disable = false;
        		                 }else{
        		                     item[j].disable = true;
        		                 }
                                 if(location && location=="false"){
                	                item[j].disablePrompt = "无物理位置License，请联络摩卡软件获取购买相关License的信息。";
                                 }
        	      	         }
        	            }else{
        	                  item[j].disable = permission;
        	                  item[j].disablePrompt = reason;
        	            }
            if (item[j].childMenu) {
                if (item[j].childMenu.menus) {
                    var itemj = item[j].childMenu.menus;
                    for (var k = 0, klen = itemj.length; k < klen; k++) {
                        var itemk = itemj[k];
                        for (var l = 0, llen = itemk.length; l < llen; l++) {
                            itemk[l].disable = permission;
                            if (reason && reason == "noPermission") {
                                item[l].disablePrompt = "没有授权";
                            }
                        }
                    }
                }
            }

        }
    }
}
Monitor.refresh = function(action) {
    var actionPath = action;
    if (!actionPath) {
        actionPath = "/monitor/monitorList.action";
    }
    $("#submitForm").attr('action', path + actionPath);
    $("#submitForm").submit();
};
Monitor.Resource.change = function(url, divId) {
    $.blockUI({message: $('#monitorListLoading')});
    $.ajax({
        type: "POST",
        dataType: 'html',
        url: path + url,
        success: function(data, textStatus) {
            $(divId).find("*").unbind();
            $(divId).html("");
            $(divId).append(data);
            $.unblockUI();
        },
        error: function() {
            $.unblockUI();
        }
    });
};
Monitor.Resource.right.tab.setMonitor = function(monitorCount) {
    if (monitorCount && monitorCount != "") {
        Monitor.Resource.right.tp.setTabText(1, "已监控(" + monitorCount + ")");
        Monitor.Resource.right.tp.setTabText(2, "未监控");
    }
};
Monitor.Resource.right.tab.setNoMonitor = function(noMonitorCount) {
    if (noMonitorCount && noMonitorCount != "") {
        Monitor.Resource.right.tp.setTabText(1, "已监控");
        Monitor.Resource.right.tp.setTabText(2, "未监控(" + noMonitorCount + ")");
    }
};
Monitor.Resource.left.group.init = function() {
    //$.blockUI({message: $('#monitorListLoading')});
    var param = "";
    if (Monitor.Resource.left.monitor) {
        var tmpArray = [];
        tmpArray.push("&monitor=");
        tmpArray.push(Monitor.Resource.left.monitor);
        tmpArray.push("&whichTree=");
        tmpArray.push(Monitor.Resource.left.whichTree);
        tmpArray.push("&whichGrid=");
        tmpArray.push(Monitor.Resource.left.whichGrid);
        tmpArray.push("&currentTree=");
        tmpArray.push(Monitor.Resource.left.currentTree);
        tmpArray.push("&currentResourceTree=");
        tmpArray.push(Monitor.Resource.left.currentResourceTree);
        var param = tmpArray.join("");
    }
    var exist = false;//资源组不存在了
    $("#groupul span[name='groupInfo']").removeClass("pitchUp");
    $("#groupul span[name='groupInfo']").each(function() {
        if (Monitor.Resource.left.pointId == $(this).attr("groupId")) {
            $(this).addClass("pitchUp");
            exist = true;
            return false;
        }
    });
    if(!exist){
      Monitor.Resource.left.pointId = "";
    }
    if (!Monitor.Resource.left.pointId || Monitor.Resource.left.pointId == null || Monitor.Resource.left.pointId == "") {
        var id = $("#groupul li:first").attr("id");
        $("#groupul span[name='groupInfo']").each(function() {
            if (id) {
                if (id == $(this).attr("groupId")) {
                    Monitor.Resource.left.pointId = id;
                    $(this).addClass("pitchUp");
                    return false;
                }
            }
        });
    }

    $("#groupul span[name='groupInfo']").bind("click",function() {
    	$.blockUI({message: $('#monitorListLoading')});
        var $group = $(this);
        var groupId = $group.attr("groupId");
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: path + "/monitor/resourceGroup!judgeResourceGroupDeleted.action?resourceGroupId=" + groupId,
            success: function(data, textStatus) {
                //$.unblockUI();
                if (data.isDeleted == "true") {
                    $("#groupul span[name='groupInfo']").removeClass("pitchUp");
                    $group.addClass("pitchUp");
                    Monitor.Resource.right.clear();
                    //$.blockUI({message: $('#monitorListLoading')});
                    $.loadPage("main-right", path + "/monitor/monitorList!getMainRight.action?" + param + "&pointId=" + groupId + "&currentUserId=" + userId + "&isAdmin=" + isAdmin, "GET", "",
                    function() {
                        Monitor.Resource.right.init();
                        SimpleBox.renderAll();
                        if ("noMonitor" == Monitor.Resource.left.monitor) {
                            Monitor.Resource.right.noMonitorList.init("noSearch", "group");
                        } else {
                            Monitor.Resource.right.monitorList.init("noSearch", "group");
                        }
                        $.unblockUI();
                    });
                } else {
                    var _information = Monitor.Resource.infomation;
                    _information.setContentText("该资源组已删除。"); //提示框 
                    _information.show();
                    $("#submitForm").attr('action', path + "/monitor/monitorList.action");
                    $("#submitForm").submit();
                    $.unblockUI();
                }
            },error: function() {
                $.unblockUI();
            }
        });
    });
    
    if(!exist){
      $("#groupul span[name='groupInfo']").first().click();
    }
    
    $("#groupul .ico-t-right").bind('click', function(e) {
        var tmp = $(this).parent().attr("id");
        var isPitchUp = $(this).prev().attr("class");
        var isDisable = true;
        if (isPitchUp && isPitchUp == "span_dot") {
            isDisable = false;
        }
        Monitor.Resource.menu.addMenuItems([[{
            text: "删除",
            id: "delResGroup",
            disable: isDisable,
            listeners: {
                click: function() {
                    var _confirm = Monitor.Resource.confirm;
                    _confirm.setContentText("此操作不可恢复，是否确认执行此操作？"); //也可以在使用的时候传入
                    _confirm.setConfirm_listener(function() {
                        _confirm.hide();
                        $.blockUI({message: $('#monitorListLoading')});
                        $.ajax({
                            type: "POST",
                            dataType: 'json',
                            url: path + "/monitor/resourceGroup!deleteResourceGroup.action?resourceGroupId=" + tmp,
                            success: function(data, textStatus) {
                                Monitor.Resource.toast.addMessage("删除成功。");
                                $("#" + tmp).remove();
                                var id = $("#groupul li:first").attr("id");
                                if (!id || id == "" || id == "null" || id == null) {
                                    Monitor.Resource.right.refresh();
                                    return false;
                                }
                                $("#groupul span[name='groupInfo']").removeClass("pitchUp");
                                $("#groupul span[groupId=" + id + "]").addClass("pitchUp");
                                $.loadPage("main-right", path + "/monitor/monitorList!getMainRight.action?" + param + "&pointId=" + id + "&currentUserId=" + userId, "POST", "",
                                function() {
                                    Monitor.Resource.right.init();
                                    if ("noMonitor" == Monitor.Resource.left.monitor) {
                                        Monitor.Resource.right.noMonitorList.init("noSearch", "group");
                                    } else {
                                        Monitor.Resource.right.monitorList.init("noSearch", "group");
                                    }
                                    $.unblockUI();
                                });
                            }, error: function() {
                                $.unblockUI();
                            }
                        });
                    });
                    _confirm.show();
                }
            }
        },
        {
            text: "编辑",
            id: "editResGroup",
            listeners: {
                click: function() {
                    winOpen({
                        url: path + '/monitor/resourceGroup!resourceGroupInfo.action?resourceGroupId=' + tmp + "&currentUserId=" + Monitor.Resource.left.currentUserId,
                        width: 490,
                        height: 208,
                        name: 'editResGroup'
                    });
                }
            }
        }]]);
        Monitor.Resource.menu.position(e.clientX + 8, e.clientY - 15);
    });
};
Monitor.Resource.right.monitorList.modiColProfile = function(rowIndex, value) {
    Monitor.Resource.right.monitorList.gridMonitor.getRowByIndex(rowIndex).value.hidProfile = value;
    Monitor.Resource.right.monitorList.gridMonitor.refreshCell(rowIndex, "profile", "##");
    $("#tableMonitor .ico-default").bind('click',function(e) {        
        var profileId = $(this).attr("profileId");
        var instanceId = $(this).attr("instanceId");
        $.blockUI({message: $('#monitorListLoading')});
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: path + "/monitor/monitorAjaxList!judgeResourceOperate.action?isMenu=true&isMonitor=monitor&instanceId=" + instanceId,
            success: function(data, textStatus) {
                 $.unblockUI();
                 var _information = Monitor.Resource.infomation;
                 var allowable = data.allowable;
                 if (allowable == "delete") {
                     _information.setContentText("该资源已删除。"); //提示框 
                     _information.show();
                     $("#submitForm").attr('action', path + "/monitor/monitorList.action");
                     $("#submitForm").submit();
                     return false;
                 }
                 if (allowable == "unMonitor") {
                    _information.setContentText("该资源未监控。"); //提示框 
                    _information.show();
                    $("#submitForm").attr('action', path + "/monitor/monitorList.action");
                    $("#submitForm").submit();
                    return false;
                 }
                 var jsonstr = (new Function("return "+allowable))();
                 var permission = true;
                 var reason = "";
                 if(jsonstr){
                     permission = jsonstr[0].permission;
                     if(permission == "false"){
                        permission = false;
                     }
                     reason = jsonstr[0].reason;
                 }
                 if(permission == false){
                    _information.setContentText("无此权限，请联络系统管理员。"); //提示框 
                    _information.show();
                    return false;
                 }
                 winOpen({
                        url: path + '/profile/userDefineProfile/queryProfile.action?basicInfo.profileId=' + profileId,
                        width: 970,
                        height: 1300,
                        scrollable: true,
                        name: 'addResource'
                    })
            },error: function() {
                $.unblockUI();
            }
        });});
    $("#tableMonitor .ico-user-defined").bind('click',function(e) {     
        var profileId = $(this).attr("profileId");
        var instanceId = $(this).attr("instanceId");
        $.blockUI({message: $('#monitorListLoading')});
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: path + "/monitor/monitorAjaxList!judgeResourceOperate.action?isMenu=true&isMonitor=monitor&instanceId=" + instanceId,
            success: function(data, textStatus) {
                $.unblockUI();
                var _information = Monitor.Resource.infomation;
                var allowable = data.allowable;
                if (allowable == "delete") {
                     _information.setContentText("该资源已删除。"); //提示框 
                     _information.show();
                     $("#submitForm").attr('action', path + "/monitor/monitorList.action");
                     $("#submitForm").submit();
                     return false;
                }
                if (allowable == "unMonitor") {
                    _information.setContentText("该资源未监控。"); //提示框 
                    _information.show();
                    $("#submitForm").attr('action', path + "/monitor/monitorList.action");
                    $("#submitForm").submit();
                    return false;
                }
                var jsonstr = (new Function("return "+allowable))();
                var permission = true;
                var reason = "";
                if(jsonstr){
                     permission = jsonstr[0].permission;
                     if(permission == "false"){
                        permission = false;
                     }
                     reason = jsonstr[0].reason;
                }
                if(permission == false){
                    _information.setContentText("无此权限，请联络系统管理员。"); //提示框 
                    _information.show();
                    return false;
                }
                winOpen({
                    url: path + '/profile/userDefineProfile/queryProfile.action?basicInfo.profileId=' + profileId,
                    width: 970,
                    height: 1300,
                    scrollable: true,
                    name: 'addResource'
                })
            },error: function() {
                $.unblockUI();
            }
        });});
    $("#tableMonitor .ico-individuation").bind('click',function(e) {      
    	var instanceId = $(this).attr("instanceId");
        var rowIndex = $(this).attr("rowIndex");
        $.blockUI({message: $('#monitorListLoading')});
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: path + "/monitor/monitorAjaxList!judgeResourceOperate.action?isMenu=true&isMonitor=monitor&instanceId=" + instanceId,
            success: function(data, textStatus) {
                $.unblockUI();
                var _information = Monitor.Resource.infomation;
                var allowable = data.allowable;
                if (allowable == "delete") {
                     _information.setContentText("该资源已删除。"); //提示框 
                     _information.show();
                     $("#submitForm").attr('action', path + "/monitor/monitorList.action");
                     $("#submitForm").submit();
                     return false;
                }
                if (allowable == "unMonitor") {
                    _information.setContentText("该资源未监控。"); //提示框 
                    _information.show();
                    $("#submitForm").attr('action', path + "/monitor/monitorList.action");
                    $("#submitForm").submit();
                    return false;
                }
                var jsonstr = (new Function("return "+allowable))();
                var permission = true;
                var reason = "";
                if(jsonstr){
                     permission = jsonstr[0].permission;
                     if(permission == "false"){
                        permission = false;
                     }
                     reason = jsonstr[0].reason;
                }
                if(permission == false){
                    _information.setContentText("无此权限，请联络系统管理员。"); //提示框 
                    _information.show();
                    return false;
                }
                winOpen({
                    url: path + "/profile/customProfile/queryCustomProfile.action?instanceId=" + instanceId + "&rowIndex=" + rowIndex,
                    width: 770,
                    height: 1200,
                    scrollable: true,
                    name: 'customProfile'
                });
            },error: function() {
                $.unblockUI();
            }
        });
    });
};
Monitor.Resource.right.monitorList.modiColName = function(rowIndex, value) {
    Monitor.Resource.right.monitorList.gridMonitor.getRowByIndex(rowIndex).value.name = value;
    Monitor.Resource.right.monitorList.gridMonitor.refreshCell(rowIndex, "name", value);
};
Monitor.Resource.right.pcList.modiColName = function(rowIndex, value) {
    Monitor.Resource.right.pcList.gridPc.getRowByIndex(rowIndex).value.name = value;
    Monitor.Resource.right.pcList.gridPc.refreshCell(rowIndex, "name", value);
};
Monitor.Resource.right.noMonitorList.modiColName = function(rowIndex, value) {
    Monitor.Resource.right.noMonitorList.gridNoMonitor.getRowByIndex(rowIndex).value.name = value;
    Monitor.Resource.right.noMonitorList.gridNoMonitor.refreshCell(rowIndex, "name", value);
};
Monitor.Resource.right.monitorList.render = function(json) {
    Monitor.Resource.right.monitorList.gridMonitor.loadGridData(json);
};
Monitor.Resource.right.noMonitorList.render = function(json) {
    Monitor.Resource.right.noMonitorList.gridNoMonitor.loadGridData(json);
};
Monitor.Resource.left.equipment.init = function() {
    if (!$("#equipmentTree")[0]) {return false;}
    this.tree = new Tree({
        id: "equipmentTree",
        listeners: {
            nodeClick: function(node) {
                $.blockUI({message: $('#monitorListLoading')});
                var tmpArr = [];
                var pointId = node.getValue("pointId");
                var pointLevel = node.getValue("pointLevel");
                var monitor = node.getValue("monitor");
                var whichTree = node.getValue("whichTree");
                var whichGrid = node.getValue("whichGrid");
                var currentTree = Monitor.Resource.left.equipment.currentTree;
                var currentResourceTree = Monitor.Resource.left.equipment.currentResourceTree;
                if (!pointId) {
                    pointId = "";
                }
                if (!pointLevel) {
                    pointLevel = "";
                }
                if (!monitor) {
                    monitor = "";
                }
                if (!whichTree) {
                    whichTree = "";
                }
                if (!whichGrid) {
                    whichGrid = "";
                }
                if (!currentTree) {
                    currentTree = "";
                }
                if (!currentResourceTree) {
                    currentResourceTree = "";
                }
                tmpArr.push("&pointId=");
                tmpArr.push(pointId);
                tmpArr.push("&pointLevel=");
                tmpArr.push(pointLevel);
                tmpArr.push("&monitor=");
                tmpArr.push(monitor);
                tmpArr.push("&whichTree=");
                tmpArr.push(whichTree);
                tmpArr.push("&whichGrid=");
                tmpArr.push(whichGrid);
                tmpArr.push("&currentTree=");
                tmpArr.push(currentTree);
                tmpArr.push("&currentResourceTree=");
                tmpArr.push(currentResourceTree);
                var param = tmpArr.join("");
                $.ajax({
                    type: "POST",
                    dataType: 'json',
                    timeout : 60000,
                    url: path + "/monitor/monitorAjaxList!nodeCount.action?pointId=" + pointId + "&pointLevel=" + pointLevel + "&currentUserId=" + userId + "&isAdmin=" + isAdmin,
                    success: function(data, textStatus) {
                        node.setText(node.getText().split("(")[0] + "(" + data.nodeCount + ")");
                    },error: function() {
                        $.unblockUI();
                         var _information = Monitor.Resource.infomation;
                         _information.setContentText("系统异常，请联系系统管理员。"); //提示框 
                         _information.show();
                    }
                });
                $.ajax({
                    type: "POST",
                    dataType: 'html',
                    timeout : 60000,
                    url: path + "/monitor/monitorList!getMainRight.action?" + param + "&currentUserId=" + userId + "&isAdmin=" + isAdmin,
                    success: function(data, textStatus) {
                        $("#main-right").html("");
                        $("#main-right").append(data);
                        if ("pc" == pointId) {
                            Monitor.Resource.right.pcList.init();
                        } else {
                            Monitor.Resource.right.init();
                            if ("noMonitor" == monitor) {
                                Monitor.Resource.right.noMonitorList.init("noSearch", "noGroup");
                            } else {
                                Monitor.Resource.right.monitorList.init("noSearch", "noGroup");
                            }
                        }
                        $.unblockUI();
                    },error: function() {
                        $.unblockUI();
                        var _information = Monitor.Resource.infomation;
                        _information.setContentText("系统异常,请联系系统管理员。"); //提示框 
                        _information.show();
                    }
                });

            }
        }
    });
    var currNodeObj = this.tree.getNodeById(Monitor.Resource.left.equipment.pointId);
    var currNodePath = currNodeObj.getPathId();
    this.tree.setCurrentNode(Monitor.Resource.left.equipment.pointId);
    this.tree.locationNode(currNodePath);
};
Monitor.Resource.left.application.init = function() {
    if (!$("#applicationTree")[0]) {return false;}
    this.tree = new Tree({
        id: "applicationTree",
        listeners: {
            nodeClick: function(node) {
                $.blockUI({message: $('#monitorListLoading')});
                var tmpArr = [];
                var pointId = node.getValue("pointId");
                var pointLevel = node.getValue("pointLevel");
                var monitor = node.getValue("monitor");
                var whichTree = node.getValue("whichTree");
                var whichGrid = node.getValue("whichGrid");
                var currentTree = Monitor.Resource.left.application.currentTree;
                var currentResourceTree = Monitor.Resource.left.application.currentResourceTree;
                if (!pointId) {
                    pointId = "";
                }
                if (!pointLevel) {
                    pointLevel = "";
                }
                if (!monitor) {
                    monitor = "";
                }
                if (!whichTree) {
                    whichTree = "";
                }
                if (!currentTree) {
                    currentTree = "";
                }
                if (!currentResourceTree) {
                    currentResourceTree = "";
                }
                tmpArr.push("&pointId=");
                tmpArr.push(pointId);
                tmpArr.push("&pointLevel=");
                tmpArr.push(pointLevel);
                tmpArr.push("&monitor=");
                tmpArr.push(monitor);
                tmpArr.push("&whichTree=");
                tmpArr.push(whichTree);
                tmpArr.push("&currentTree=");
                tmpArr.push(currentTree);
                tmpArr.push("&currentResourceTree=");
                tmpArr.push(currentResourceTree);
                tmpArr.push("&whichGrid=");
                tmpArr.push(whichGrid);
                var param = tmpArr.join("");
                param += "&grid=" + "application";
                $.ajax({
                    type: "POST",
                    dataType: 'json',
                    timeout : 60000,
                    url: path + "/monitor/monitorAjaxList!nodeCount.action?pointId=" + pointId + "&pointLevel=" + pointLevel + "&currentUserId=" + userId + "&isAdmin=" + isAdmin,
                    success: function(data, textStatus) {
                        node.setText(node.getText().split("(")[0] + "(" + data.nodeCount + ")");
                    },error: function() {
                        $.unblockUI();
                         var _information = Monitor.Resource.infomation;
                         _information.setContentText("系统异常,请联系系统管理员。"); //提示框 
                         _information.show();
                    }
                });
                $.ajax({
                    type: "POST",
                    dataType: 'html',
                    timeout : 60000,
                    url: path + "/monitor/monitorList!getMainRight.action?" + param + "&currentUserId=" + userId + "&isAdmin=" + isAdmin,
                    success: function(data, textStatus) {
                        $("#main-right").html("");
                        $("#main-right").append(data);
                        Monitor.Resource.right.init();
                        if ("noMonitor" == monitor) {
                            Monitor.Resource.right.noMonitorList.init("noSearch", "noGroup");
                        } else {
                            Monitor.Resource.right.monitorList.init("noSearch", "noGroup");
                        }
                        $.unblockUI();
                    },error: function() {
                        $.unblockUI();
                        var _information = Monitor.Resource.infomation;
                        _information.setContentText("系统异常，请联系系统管理员。"); //提示框 
                        _information.show();
                    }
                });

            }
        }
    });
    var currNodeObj = this.tree.getNodeById(Monitor.Resource.left.application.pointId);
    var currNodePath = currNodeObj.getPathId();
    this.tree.setCurrentNode(Monitor.Resource.left.application.pointId);
    this.tree.locationNode(currNodePath);
};
Monitor.Resource.left.search.init = function() {
    if (!$("#searchResourceBut")[0]) {return;}
    var $searchText = $("#searchSearch");
    $searchText.bind("focus",function(event) {
        $searchText.removeClass();
        if ($searchText.val() == "请输入条件搜索") {
            $searchText.val("");
        }
    });
    $searchText.bind("blur",function(event) {
        var c = $searchText.val();
        if (c == null || c == '') {
            $searchText.val("请输入条件搜索");
            $searchText.addClass('inputoff');
        }
    });
    $searchText.bind("keydown",function(event) {
        var evt = window.event ? window.event: evt;
        if (evt.keyCode == 13) {
            var val = $.trim($("#searchSearch").val());
            if (val == '请输入条件搜索') {
                val = "";
            }
            searchResource(val,'monitor');
        }
    });
    $("#searchResourceBut").bind("click",function(event) {
        var search = $.trim($("#searchSearch").val());
        if (search == '请输入条件搜索') {
            search = "";
        }
        searchResource(search,'monitor');
    });
   // SimpleBox.renderToUseWrap([{selectId:"domainSearch"},{maxHeight:"40"},{contentId:"layoutwestId"}]);
   // SimpleBox.renderToUseWrap([{selectId:"searchWhatSearch"},{maxHeight:"40"},{contentId:"layoutwestId"}]);
    SimpleBox.renderToUseWrap([{selectId:"pointIdSel",maxHeight:"240",contentId:"layoutwestId"}]);
    SimpleBox.renderAll();
};
Monitor.Resource.right.init = function() {
    Monitor.Resource.right.monitorList.ListMenu.apNoMonitorArray = [[{
        text: "刷新设备",
        id: "refresh_ap",
        disable: permissions,
        listeners: {
            click: function() {
                applicationRefresh(Monitor.Resource.right.monitorList.ListMenu.icoId);
            }
        }
    },
    {
        text: "设置维护信息",
        id: "setMaintainInfo",
        disable: permissions,
        listeners: {
            click: function() {
                winOpen({
                    url: path + "/monitor/maintainSetting.action?instanceId=" + Monitor.Resource.right.monitorList.ListMenu.icoId + "&rowIndex=" + Monitor.Resource.right.monitorList.ListMenu.rowIndex + "&pointId=" + Monitor.Resource.right.monitorList.ListMenu.pointId,
                    width: 630,
                    height: 520,
                    scrollable: false,
                    name: 'setMaintainInfo'
                });
            }
        }
    },{
        text: "变更发现信息",
        id: "changeFindInfo",
        disable: permissions,
        listeners: {
            click: function() {
            	changeFindInfo(Monitor.Resource.right.monitorList.ListMenu.icoId);
            }
        }
    },{
        text: "重新发现",
        id: "rediscovery",
        disable: permissions,
        listeners: {
            click: function() {
            	rediscoveryNoMonitor(Monitor.Resource.right.monitorList.ListMenu.icoId);
            }
        }
    }]];
    Monitor.Resource.right.monitorList.ListMenu.eqNoMonitorArray = [[{
        text: "刷新设备",
        id: "refresh_eq",
        disable: permissions,
        listeners: {
            click: function() {
                equipmentRefresh(Monitor.Resource.right.monitorList.ListMenu.icoId);
            }
        }
    },
    {
        text: "设置维护信息",
        id: "setMaintainInfo",
        disable: permissions,
        listeners: {
            click: function() {
                winOpen({
                    url: path + "/monitor/maintainSetting.action?instanceId=" + Monitor.Resource.right.monitorList.ListMenu.icoId + "&rowIndex=" + Monitor.Resource.right.monitorList.ListMenu.rowIndex + "&pointId=" + Monitor.Resource.right.monitorList.ListMenu.pointId,
                    width: 630,
                    height: 510,
                    scrollable: false,
                    name: 'setMaintainInfo'
                });
            }
        }
    },
    {
        text: "变更设备类型",
        id: "change_type",
        disable: permissions,
        listeners: {
            click: function() {
                   noMonitorChangeType(Monitor.Resource.right.monitorList.ListMenu.icoId);
            }
        }
    },
    {
        text: "变更发现信息",
        id: "changeFindInfo",
        disable: permissions,
        listeners: {
            click: function() {
                   changeFindInfo(Monitor.Resource.right.monitorList.ListMenu.icoId);
            }
        }
    },
    {
        text: "重新发现",
        id: "rediscovery",
        disable: permissions,
        listeners: {
            click: function() {
            	rediscoveryNoMonitor(Monitor.Resource.right.monitorList.ListMenu.icoId);
            }
        }
    }], [{
        text: "工具",
        id: "tools",
        disable: permissions,
        childMenu: {
            width: 150,
            menus: [[{
                text: "Ping",
                id: "Ping",
                disable: permissions,
                listeners: {
                    click: function() {
                        var url = "/netfocus/modules/tool/ping_tools.jsp?ip=" + Monitor.Resource.right.monitorList.ListMenu.discoveryIp;
                        winOpen({
                            url: url,
                            width: 800,
                            height: 520,
                            name: 'toolsPing'
                        });
                    }
                }
            },{
                text: "TelNet",
                id: "TelNet",
                disable: permissions,
                listeners: {
                    click: function() {
                        var url = "/netfocus/applet/telnetApplet.jsp?address=" + Monitor.Resource.right.monitorList.ListMenu.discoveryIp;
                        winOpen({
                            url: url,
                            width: 800,
                            height: 600,
                            name: 'toolsTelnet'
                        });
                    }
                }
            },{
                text: "MIB",
                id: "MIB",
                disable: permissions,
                listeners: {
                    click: function() {
                        var url = "/netfocus/applet/MIBApplet.jsp?address=" + Monitor.Resource.right.monitorList.ListMenu.discoveryIp;
                        winOpen({
                            url: url,
                            width: 800,
                            height: 600,
                            name: 'toolsMIB'
                        });
                    }
                }
            },{
                text: "SNMP Test",
                id: "SNMP",
                disable: permissions,
                listeners: {
                    click: function() {
                        var url = "/netfocus/modules/tool/snmptest.jsp?ip=" + Monitor.Resource.right.monitorList.ListMenu.discoveryIp;
                        winOpen({
                            url: url,
                            width: 800,
                            height: 520,
                            name: 'toolsSnmptest'
                        });
                    }
                }
            },
            {
                text: "TraceRoute",
                id: "TraceRoute",
                disable: permissions,
                listeners: {
                    click: function() {
                        var url = "/netfocus/modules/tool/traceroute_tools.jsp?ip=" + Monitor.Resource.right.monitorList.ListMenu.discoveryIp;
                        winOpen({
                            url: url,
                            width: 800,
                            height: 520,
                            name: 'toolsTraceroute'
                        });

                    }
                }
            }]]
        }
    }]];
    Monitor.Resource.right.monitorList.ListMenu.hostArray = [[{
        text: "个性化监控设置",
        id: "customProfile",
        disable: permissions,
        listeners: {
            click: function() {
                customProfile(Monitor.Resource.right.monitorList.ListMenu.icoId, Monitor.Resource.right.monitorList.ListMenu.rowIndex);
            }
        }
    },
    {
        text: "选择策略",
        id: "chooseProfile",
        disable: permissions,
        listeners: {
            click: function() {
                winOpen({
                    url: path + "/monitor/monitorList!chooseProfile.action?instanceId=" + Monitor.Resource.right.monitorList.ListMenu.icoId + "&rowIndex=" + Monitor.Resource.right.monitorList.ListMenu.rowIndex,
                    width: 387,
                    height: 183,
                    name: 'chooseProfile'
                });
            }
        }
    },
    /* {
    text: "设为关键设备",
    id: "copy_bu",
    listeners: {
        click: function() {}
    }
},*/
    {
        text: "刷新设备",
        id: "refresh_eq",
        disable: permissions,
        listeners: {
            click: function() {
                equipmentRefresh(Monitor.Resource.right.monitorList.ListMenu.icoId);
            }
        }
    },{
        text: "设置维护信息",
        id: "setMaintainInfo",
        disable: permissions,
        listeners: {
            click: function() {
                winOpen({
                    url: path + "/monitor/maintainSetting.action?instanceId=" + Monitor.Resource.right.monitorList.ListMenu.icoId + "&rowIndex=" + Monitor.Resource.right.monitorList.ListMenu.rowIndex + "&pointId=" + Monitor.Resource.right.monitorList.ListMenu.pointId,
                    width: 630,
                    height: 510,
                    scrollable: false,
                    name: 'setMaintainInfo'
                });
            }
        }
    },{
        text: "变更设备类型",
        id: "change_type",
        disable: permissions,
        listeners: {
            click: function() {
                monitorChangeType(Monitor.Resource.right.monitorList.ListMenu.icoId);
            }
        }
    }, {
        text: "变更发现信息",
        id: "changeFindInfo",
        disable: permissions,
        listeners: {
            click: function() {
                   changeFindInfo(Monitor.Resource.right.monitorList.ListMenu.icoId);
            }
        }
    },{
        text: "重新发现",
        id: "rediscovery",
        disable: permissions,
        listeners: {
            click: function() {
            	rediscovery(Monitor.Resource.right.monitorList.ListMenu.icoId);
            }
        }
    }], [{
        text: "未确认告警",
        id: "unrecognizedAlarm",
        disable: permissions,
        listeners: {
            click: function() {
                var instanceId = Monitor.Resource.right.monitorList.ListMenu.icoId;
                var url = path + "/detail/insalarmoverview.action?resInstanceId=" + Monitor.Resource.right.monitorList.ListMenu.icoId + "&notionState=false";
                winOpen({
                    url: url,
                    width: 1000,
                    height: 600,
                    scrollable: false,
                    name: 'detailAlarm'
                });
            }
        }
    },
    /*{
    text: "未提交工单",
    id: "failsSubmitWorkOrders",
    listeners: {
        click: function() {}
    }
},*/
    {
        text: "工具",
        id: "tools",
        disable: permissions,
        childMenu: {
            width: 150,
            menus: [[{
                text: "Ping",
                id: "Ping",
                disable: permissions,
                listeners: {
                    click: function() {
                        var url = "/netfocus/modules/tool/ping_tools.jsp?ip=" + Monitor.Resource.right.monitorList.ListMenu.discoveryIp;
                        winOpen({
                            url: url,
                            width: 800,
                            height: 520,
                            name: 'toolsPing'
                        });
                    }
                }
            },{
                text: "TelNet",
                id: "TelNet",
                disable: permissions,
                listeners: {
                    click: function() {
                        var url = "/netfocus/applet/telnetApplet.jsp?address=" + Monitor.Resource.right.monitorList.ListMenu.discoveryIp;
                        winOpen({
                            url: url,
                            width: 800,
                            height: 600,
                            name: 'toolsTelnet'
                        });
                    }
                }
            }, {
                text: "MIB",
                id: "MIB",
                disable: permissions,
                listeners: {
                    click: function() {
                        var url = "/netfocus/applet/MIBApplet.jsp?address=" + Monitor.Resource.right.monitorList.ListMenu.discoveryIp;
                        winOpen({
                            url: url,
                            width: 800,
                            height: 600,
                            name: 'toolsMIB'
                        });
                    }
                }
            }, {
                text: "SNMP Test",
                id: "SNMP",
                disable: permissions,
                listeners: {
                    click: function() {
                        var url = "/netfocus/modules/tool/snmptest.jsp?ip=" + Monitor.Resource.right.monitorList.ListMenu.discoveryIp;
                        winOpen({
                            url: url,
                            width: 800,
                            height: 520,
                            name: 'toolsSnmptest'
                        });
                    }
                }
            }, {
                text: "TraceRoute",
                id: "TraceRoute",
                disable: permissions,
                listeners: {
                    click: function() {
                        var url = "/netfocus/modules/tool/traceroute_tools.jsp?ip=" + Monitor.Resource.right.monitorList.ListMenu.discoveryIp;
                        winOpen({
                            url: url,
                            width: 800,
                            height: 520,
                            name: 'toolsTraceroute'
                        });

                    }
                }
            }]]
        }
    },{
        text: "诊断",
        id: "diagnose",
        disable: permissions,
        listeners: {
            click: function() {
                var instanceId = Monitor.Resource.right.monitorList.ListMenu.icoId;
                var url = path + "/discovery/resource-instance-diagnose!diagnose.action?instanceId=" + Monitor.Resource.right.monitorList.ListMenu.icoId;
                winOpen({
                    url: url,
                    width: 688,
                    height: 475,
                    scrollable: false,
                    name: 'detailDiagnose'
                });
            }
        }
    }], [{
        text: "物理位置",
        id: "physicalLocation",
        disable: permissions,
        listeners: {
            click: function() {physicalLocation(Monitor.Resource.right.monitorList.ListMenu.icoId);}
        }
    },{
        text: "接口定位",
        id: "InterfaceLocalization",
        disable: permissions,
        listeners: {
            click: function() {
                interlocal(Monitor.Resource.right.monitorList.ListMenu.icoId);
            }
        }
    },{
        text: "拓扑定位",
        id: "topologyLocation",
        disable: permissions,
        listeners: {
            click: function() {
                var instanceId = Monitor.Resource.right.monitorList.ListMenu.icoId;
                var url = "/netfocus/flash/focusonnetwork60.jsp?userid=" + userId + "&instanceId=" + instanceId;
                winOpen({
                    url: url,
                    width: 800,
                    height: 600,
                    name: 'detailTopolocation'
                });
            }
        }
    },{
        text: "关联业务服务",
        id: "associatedBusinessService",
        disable: permissions,
        listeners: {
            click: function(e) {
                var instanceId = Monitor.Resource.right.monitorList.ListMenu.icoId;
                businessService(instanceId);
            }
        }
    }
    /*,
{
    text: "CMDB",
    id: "CMDB",
    listeners: {
        click: function() {}
    }
}*/
    ]];
    Monitor.Resource.right.monitorList.ListMenu.equipmentArray = [[{
        text: "个性化监控设置",
        id: "customProfile",
        disable: permissions,
        listeners: {
            click: function() {
                customProfile(Monitor.Resource.right.monitorList.ListMenu.icoId, Monitor.Resource.right.monitorList.ListMenu.rowIndex);
            }
        }
    },{
        text: "选择策略",
        id: "chooseProfile",
        disable: permissions,
        listeners: {
            click: function() {
                winOpen({
                    url: path + "/monitor/monitorList!chooseProfile.action?instanceId=" + Monitor.Resource.right.monitorList.ListMenu.icoId + "&rowIndex=" + Monitor.Resource.right.monitorList.ListMenu.rowIndex,
                    width: 387,
                    height: 183,
                    name: 'chooseProfile'
                });
            }
        }
    },
    /* {
    text: "设为关键设备",
    id: "copy_bu",
    listeners: {
        click: function() {}
    }
},*/
    {
        text: "刷新设备",
        id: "refresh_eq",
        disable: permissions,
        listeners: {
            click: function() {
                equipmentRefresh(Monitor.Resource.right.monitorList.ListMenu.icoId);
            }
        }
    },{
        text: "设置维护信息",
        id: "setMaintainInfo",
        disable: permissions,
        listeners: {
            click: function() {
                winOpen({
                    url: path + "/monitor/maintainSetting.action?instanceId=" + Monitor.Resource.right.monitorList.ListMenu.icoId + "&rowIndex=" + Monitor.Resource.right.monitorList.ListMenu.rowIndex + "&pointId=" + Monitor.Resource.right.monitorList.ListMenu.pointId,
                    width: 630,
                    height: 510,
                    scrollable: false,
                    name: 'setMaintainInfo'
                });
            }
        }
    },{
        text: "变更设备类型",
        id: "change_type",
        disable: permissions,
        listeners: {
            click: function() {
                monitorChangeType(Monitor.Resource.right.monitorList.ListMenu.icoId);
            }
        }
    },{
        text: "变更发现信息",
        id: "changeFindInfo",
        disable: permissions,
        listeners: {
            click: function() {
                   changeFindInfo(Monitor.Resource.right.monitorList.ListMenu.icoId);
            }
        }
    },{
        text: "重新发现",
        id: "rediscovery",
        disable: permissions,
        listeners: {
            click: function() {
            	rediscovery(Monitor.Resource.right.monitorList.ListMenu.icoId);
            }
        }
    }], [{
        text: "未确认告警",
        id: "unrecognizedAlarm",
        disable: permissions,
        listeners: {
            click: function() {
                var instanceId = Monitor.Resource.right.monitorList.ListMenu.icoId;
                var url = path + "/detail/insalarmoverview.action?resInstanceId=" + instanceId + "&notionState=false";
                winOpen({
                    url: url,
                    width: 1000,
                    height: 600,
                    scrollable: false,
                    name: 'detailAlarm'
                });
            }
        }
    },
    /*{
    text: "未提交工单",
    id: "failsSubmitWorkOrders",
    listeners: {
        click: function() {}
    }
},*/
    {
        text: "工具",
        id: "tools",
        disable: permissions,
        childMenu: {
            width: 150,
            menus: [[{
                text: "Ping",
                id: "Ping",
                disable: permissions,
                listeners: {
                    click: function() {
                        var url = "/netfocus/modules/tool/ping_tools.jsp?ip=" + Monitor.Resource.right.monitorList.ListMenu.discoveryIp;
                        winOpen({
                            url: url,
                            width: 800,
                            height: 520,
                            name: 'toolsPing'
                        });
                    }
                }
            },
            {
                text: "TelNet",
                id: "TelNet",
                disable: permissions,
                listeners: {
                    click: function() {
                        var url = "/netfocus/applet/telnetApplet.jsp?address=" + Monitor.Resource.right.monitorList.ListMenu.discoveryIp;
                        winOpen({
                            url: url,
                            width: 800,
                            height: 600,
                            name: 'toolsTelnet'
                        });
                    }
                }
            },{
                text: "MIB",
                id: "MIB",
                disable: permissions,
                listeners: {
                    click: function() {
                        var url = "/netfocus/applet/MIBApplet.jsp?address=" + Monitor.Resource.right.monitorList.ListMenu.discoveryIp;
                        winOpen({
                            url: url,
                            width: 800,
                            height: 600,
                            name: 'toolsMIB'
                        });
                    }
                }
            },{
                text: "SNMP Test",
                id: "SNMP",
                disable: permissions,
                listeners: {
                    click: function() {
                        var url = "/netfocus/modules/tool/snmptest.jsp?ip=" + Monitor.Resource.right.monitorList.ListMenu.discoveryIp;
                        winOpen({
                            url: url,
                            width: 800,
                            height: 520,
                            name: 'toolsSnmptest'
                        });
                    }
                }
            },{
                text: "TraceRoute",
                id: "TraceRoute",
                disable: permissions,
                listeners: {
                    click: function() {
                        var url = "/netfocus/modules/tool/traceroute_tools.jsp?ip=" + Monitor.Resource.right.monitorList.ListMenu.discoveryIp;
                        winOpen({
                            url: url,
                            width: 800,
                            height: 520,
                            name: 'toolsTraceroute'
                        });
                    }
                }
            }]]
        }
    },{
        text: "诊断",
        id: "diagnose",
        disable: permissions,
        listeners: {
            click: function() {
                var instanceId = Monitor.Resource.right.monitorList.ListMenu.icoId;
                var url = path + "/discovery/resource-instance-diagnose!diagnose.action?instanceId=" + Monitor.Resource.right.monitorList.ListMenu.icoId;
                winOpen({
                    url: url,
                    width: 688,
                    height: 475,
                    scrollable: false,
                    name: 'detailDiagnose'
                });
            }
        }
    }], [{
        text: "物理位置",
        id: "physicalLocation",
        disable: permissions,
        listeners: {
            click: function() {physicalLocation(Monitor.Resource.right.monitorList.ListMenu.icoId);}
        }
    }, {
        text: "查看下联设备",
        id: "bottomAlliedEquipment",
        disable: permissions,
        listeners: {
            click: function() {
                bottomAlliedEquipment(Monitor.Resource.right.monitorList.ListMenu.nodeId);
            }
        }
    },{
        text: "拓扑定位",
        id: "topologyLocation",
        disable: permissions,
        listeners: {
            click: function() {
            	if(!Monitor.Resource.right.monitorList.ListMenu.nodeId || Monitor.Resource.right.monitorList.ListMenu.nodeId =="-" ){
            		 var _information = Monitor.Resource.infomation;
                     _information.setContentText("此资源不在拓扑中。"); //提示框 
                     _information.show();
                     return false;
            	}
                var instanceId = Monitor.Resource.right.monitorList.ListMenu.icoId;
                var url = "/netfocus/flash/focusonnetwork60.jsp?userid=" + userId + "&instanceId=" + instanceId;
                winOpen({
                    url: url,
                    width: 800,
                    height: 600,
                    name: 'detailTopolocation'
                });
            }
        }
    },{
        text: "关联业务服务",
        id: "associatedBusinessService",
        disable: permissions,
        listeners: {
            click: function(e) {
                var instanceId = Monitor.Resource.right.monitorList.ListMenu.icoId;
                businessService(instanceId);
            }
        }
    }
    /*,
{
    text: "CMDB",
    id: "CMDB",
    listeners: {
        click: function() {}
    }
}*/
    ]];
    Monitor.Resource.right.monitorList.ListMenu.applicationArray = [[{
        text: "个性化监控设置",
        id: "customProfile",
        disable: permissions,
        listeners: {
            click: function() {
                customProfile(Monitor.Resource.right.monitorList.ListMenu.icoId, Monitor.Resource.right.monitorList.ListMenu.rowIndex);
            }
        }
    },{
        text: "选择策略",
        id: "chooseProfile",
        disable: permissions,
        listeners: {
            click: function() {
                winOpen({
                    url: path + "/monitor/monitorList!chooseProfile.action?instanceId=" + Monitor.Resource.right.monitorList.ListMenu.icoId + "&rowIndex=" + Monitor.Resource.right.monitorList.ListMenu.rowIndex,
                    width: 387,
                    height: 183,
                    name: 'chooseProfile'
                });
            }
        }
    },
    /*  {
    text: "设为关键设备",
    id: "copy_bu",
    listeners: {
        click: function() {}
    }
},*/
    {
        text: "刷新设备",
        id: "refresh_ap",
        disable: permissions,
        listeners: {
            click: function() {
                applicationRefresh(Monitor.Resource.right.monitorList.ListMenu.icoId);
            }
        }
    }, {
        text: "设置维护信息",
        id: "setMaintainInfo",
        disable: permissions,
        listeners: {
            click: function() {
                winOpen({
                    url: path + "/monitor/maintainSetting.action?instanceId=" + Monitor.Resource.right.monitorList.ListMenu.icoId + "&rowIndex=" + Monitor.Resource.right.monitorList.ListMenu.rowIndex + "&pointId=" + Monitor.Resource.right.monitorList.ListMenu.pointId,
                    width: 630,
                    height: 510,
                    scrollable: false,
                    name: 'setMaintainInfo'
                });
            }
        }
    }, {
        text: "变更发现信息",
        id: "changeFindInfo",
        disable: permissions,
        listeners: {
            click: function() {
                   changeFindInfo(Monitor.Resource.right.monitorList.ListMenu.icoId);
            }
        }
    },{
        text: "重新发现",
        id: "rediscovery",
        disable: permissions,
        listeners: {
            click: function() {
                 rediscovery(Monitor.Resource.right.monitorList.ListMenu.icoId);
            }
        }
    },{
        text: "诊断",
        id: "diagnose",
        disable: permissions,
        listeners: {
            click: function() {
                var instanceId = Monitor.Resource.right.monitorList.ListMenu.icoId;
                var url = path + "/discovery/resource-instance-diagnose!diagnose.action?instanceId=" + Monitor.Resource.right.monitorList.ListMenu.icoId;
                winOpen({
                    url: url,
                    width: 688,
                    height: 475,
                    scrollable: false,
                    name: 'detailDiagnose'
                });
            }
        }
    }], [{
        text: "未确认告警",
        id: "unrecognizedAlarm",
        disable: permissions,
        listeners: {
            click: function() {
                var instanceId = Monitor.Resource.right.monitorList.ListMenu.icoId;
                var url = path + "/detail/insalarmoverview.action?resInstanceId=" + Monitor.Resource.right.monitorList.ListMenu.icoId + "&notionState=false";;
                winOpen({
                    url: url,
                    width: 1000,
                    height: 600,
                    scrollable: false,
                    name: 'detailAlarm'
                });
            }
        }
    }
    /*,
{
    text: "查看流转中工单",
    id: "flowWorkOrder",
    listeners: {
        click: function() {}
    }
}*/
    ], [{
        text: "关联业务服务",
        id: "associatedBusinessService",
        disable: permissions,
        listeners: {
            click: function(e) {
                var instanceId = Monitor.Resource.right.monitorList.ListMenu.icoId;
                businessService(instanceId);
            }
        }
    }
    /*,
{
    text: "CMDB",
    id: "CMDB",
    listeners: {
        click: function() {}
    }
}*/
    ]];
    var self = this;
    var tmpArr = [];
    var whatAction = "/monitor/monitorList.action";
    var pointId = Monitor.Resource.right.pointId;
    var pointLevel = Monitor.Resource.right.pointLevel;
    var monitor = Monitor.Resource.right.monitor;
    var whichTree = Monitor.Resource.right.whichTree;
    var grid = Monitor.Resource.right.grid;
    var whichGrid = Monitor.Resource.right.whichGrid;
    var currentTree = Monitor.Resource.right.currentTree;
    var currentResourceTree = Monitor.Resource.right.currentResourceTree;
    if (!pointId) {
        pointId = "";
    }
    if (!pointLevel) {
        pointLevel = "";
    }
    if (!monitor) {
        monitor = "";
    }
    if (!whichTree) {
        whichTree = "";
    }
    if (!whichGrid) {
        whichGrid = "";
    }
    if (!currentTree) {
        currentTree = "";
    }
    if (!currentResourceTree) {
        currentResourceTree = "";
    }
    tmpArr.push("&pointId=");
    tmpArr.push(pointId);
    tmpArr.push("&pointLevel=");
    tmpArr.push(pointLevel);
    tmpArr.push("&monitor=");
    tmpArr.push(monitor);
    tmpArr.push("&whichTree=");
    tmpArr.push(whichTree);
    tmpArr.push("&whichGrid=");
    tmpArr.push(whichGrid);
    tmpArr.push("&grid=");
    tmpArr.push(grid);
    tmpArr.push("&currentTree=");
    tmpArr.push(currentTree);
    tmpArr.push("&currentResourceTree=");
    tmpArr.push(currentResourceTree);
    tmpArr.push("&isAdmin=");
    tmpArr.push(isAdmin);
    var param = tmpArr.join("");
    var resultCount = 0;
    var monitorCount = Monitor.Resource.right.monitorList.monitorCount;
    var noMonitorCount = Monitor.Resource.right.noMonitorList.noMonitorCount;
    if (monitorCount && noMonitorCount) {
        resultCount = parseInt(monitorCount) + parseInt(noMonitorCount)
    }
    if ("searchResource" == whichTree) {
        $("#searchCount").html(resultCount);
        $("#searchMonitorCount").html(monitorCount);
        $("#searchNoMonitorCount").html(noMonitorCount);
    }
    this.tp = new TabPanel({
        id: "mytab",
        listeners: {
            change: function(tab) {
                $("#submitForm").attr('action', path + whatAction);
                if (tab.index == 1) {
                    $("#monitor").val("monitor");
                    $("#isAdmin").val(isAdmin);
                    var param = $("#submitForm").serialize();
                    if ("searchResource" == whichTree) {
                        // $("#nomonitorGrid").hide();
                        // $("#monitorGrid").show();
                        // self.tp.setTabText(1,"已监控("+monitorCount+")");
                        // self.tp.setTabText(2,"未监控("+noMonitorCount+")");
                        if ($("#tableMonitor")[0]) {
                            $("#tableMonitor input[name='checkAll']").attr("checked", false);
                            $("#tableMonitor input[name='checkOneMonitor']").each(function() {
                                $(this).attr("checked", false);
                            });
                        }
                    } else {
                        $.blockUI({message: $('#monitorListLoading')});
                        if ($("#nomonitorGrid")[0]) {
                            Monitor.Resource.right.noMonitorGrid.clear();
                        }
                       // $("#monitorGrid").hide();
                        $.loadPage("monitorGrid", path + "/monitor/monitorList!getMonitorGrid.action?" + param, "POST", "",
                          function() {
                          	  // $("#monitorGrid").show();
                                if (whichTree) {
                                    if (whichTree == "resourceGroupTree") {
                                        Monitor.Resource.right.monitorList.init("noSearch", "group");
                                    } else {
                                        Monitor.Resource.right.monitorList.init("noSearch", "noGroup");
                                    }
                                }
                                $.unblockUI();
                          });
                    }
                }
                if (tab.index == 2) {
                    $("#monitor").val("noMonitor");
                    $("#isAdmin").val(isAdmin);
                    var param = $("#submitForm").serialize();
                    //  $("#whichGrid").val("nomonitor");
                    if ("searchResource" == whichTree) {
                        // self.tp.setTabText(1,"已监控("+monitorCount+")");
                        // self.tp.setTabText(2,"未监控("+noMonitorCount+")");
                        // $("#monitorGrid").hide();
                        // $("#nomonitorGrid").show();
                        if ($("#tableNoMonitor")[0]) {
                            $("#tableNoMonitor input[name='checkAll']").attr("checked", false);
                            $("#tableNoMonitor input[name='checkOneNoMonitor']").each(function() {
                                $(this).attr("checked", false);
                            });
                        }
                    } else {
                        $.blockUI({message: $('#monitorListLoading')});
                        if ($("#monitorGrid")[0]) {
                            Monitor.Resource.right.monitorGrid.clear();
                        }
                      //  $("#nomonitorGrid").hide();
                        $.loadPage("nomonitorGrid", path + "/monitor/monitorList!getNoMonitorGrid.action?" + param, "POST", "",
                        function() {
                        	// $("#nomonitorGrid").show();
                              if (whichTree) {
                                  if (whichTree == "resourceGroupTree") {
                                      Monitor.Resource.right.noMonitorList.init("noSearch", "group");
                                  } else {
                                      Monitor.Resource.right.noMonitorList.init("noSearch", "noGroup");
                                  }
                              }
                              $.unblockUI();
                        });
                      }
                }
            }
        }
    });
    if ("searchResource" == whichTree) {
        this.tp.setTabText(1, "已监控(" + monitorCount + ")");
        this.tp.setTabText(2, "未监控(" + noMonitorCount + ")");
    }
    $("#notOnlineTime").bind('click',function(e) {
        winOpen({
            url: path + '/monitor/offlinetime.action',
            width: 700,
            height: 650,
            name: 'notOnlineTimeSetting'
        });
    });
    $("#refreshSettings").bind('click',function(e) {
        winOpen({
            url: path + '/monitor/pageRenovate.action?pageModule=MonitorModule',
            width: 300,
            height: 190,
            name: 'refreshSettings'
        });
    });
    //   alert(Monitor.Resource.whichTree);
    if ("searchResource" != Monitor.Resource.whichTree) {
        //  if ("monitor" == monitor) {
        //      $("#nomonitorGrid").find("*").unbind();
        //      $("#nomonitorGrid").html("");
        //  } else {
        //      $("#monitorGrid").find("*").unbind();
        //     $("#monitorGrid").html = ("");
        // }
    }
};
Monitor.Resource.right.monitorList.ListMenu.init = function(whichTree, whichGrid, monitor) {
 if (monitor == 'nomonitor') {
    $("#tableNoMonitor .ico-t-right").bind('click',function(e) {
    	//alert(e.type);
        Monitor.Resource.right.monitorList.ListMenu.icoId = $(this).attr("instanceId");
        Monitor.Resource.right.monitorList.ListMenu.nodeId = $(this).attr("nodeId");
        Monitor.Resource.right.monitorList.ListMenu.rowIndex = $(this).attr("rowIndex");
        Monitor.Resource.right.monitorList.ListMenu.discoveryIp = $(this).attr("discoveryIp");
        Monitor.Resource.right.monitorList.ListMenu.pointId = $(this).attr("pointId");
        var level_1 = $(this).attr("level_1");
        $.blockUI({ message: $('#monitorListLoading')});
        $.ajax({
            type: "POST",
            dataType: 'json',
            timeout: 60000,
            url: path + "/monitor/monitorAjaxList!judgeResourceOperate.action?isMenu=true&isMonitor=noMonitor&instanceId=" + Monitor.Resource.right.monitorList.ListMenu.icoId,
            success: function(data, textStatus) {
                $.unblockUI();
                var allowable = data.allowable;
                if (!allowable || allowable == "delete") {
                    var _information = Monitor.Resource.infomation;
                    _information.setContentText("该资源已删除。"); //提示框 
                    _information.show();
                    $("#submitForm").attr('action', path + "/monitor/monitorList.action");
                    $("#submitForm").submit();
                    return false;
                }
                var jsonstr = (new Function("return " + allowable))();
                var permission = true;
                var reason = "";
                if (jsonstr) {
                    permission = jsonstr[0].permission;
                    if (permission == "false") {
                        permission = false;
                    }
                    reason = jsonstr[0].reason;
                }
                //permission = false;
                if (level_1 == 'application') {
                    if (Monitor.Resource.right.monitorList.ListMenu.apNoMonitorArray) {
                        var items = Monitor.Resource.right.monitorList.ListMenu.apNoMonitorArray;
                        judgeNoMonitorMenu(items, permission, reason);
                    }
                    Monitor.Resource.menu.addMenuItems(items);
                } else {
                    var items = Monitor.Resource.right.monitorList.ListMenu.eqNoMonitorArray;
                    judgeNoMonitorMenu(items, permission, reason);
                    Monitor.Resource.menu.addMenuItems(items);
                }
                Monitor.Resource.menu.position(e.clientX - 175, e.clientY - 5);
            }, error: function() {
                $.unblockUI();
                var _information = Monitor.Resource.infomation;
                _information.setContentText("系统异常，请联系系统管理员。"); //提示框 
                _information.show();
            }
        });
    });
} else {
	
    $("#monitorGrid").delegate("span[whichCol]", "click",function(e) {
    	var obj = $(this);
    	var b = obj.attr("enableclick");
    	if(b == "false"){
    	    return;
    	}
    	obj.attr("enableclick","false"); 
    	setTimeout(function(){
    	    obj.attr("enableclick","true"); 
    	},300);
    	var prev = true;
        if ($(this).prev()) {
            if ($(this).prev().html() == "-") {
                prev = false;
            }
        }
        var instanceId = this.instanceId;
        var spanName = this.whichCol;
        var vmPath = this.vmPath;
        var isMenu = this.isMenu;
        var rowIndex = this.rowIndex;
        var profileId = this.profileId;
        var nodeId = this.nodeId;
        Monitor.Resource.right.monitorList.ListMenu.icoId = this.instanceId;
        Monitor.Resource.right.monitorList.ListMenu.nodeId = this.nodeId;
        Monitor.Resource.right.monitorList.ListMenu.locationDomainId = this.locationDomainId;
        Monitor.Resource.right.monitorList.ListMenu.rowIndex = this.rowIndex;
        Monitor.Resource.right.monitorList.ListMenu.discoveryIp = this.discoveryIp;
        Monitor.Resource.right.monitorList.ListMenu.pointId = this.pointId;
        var level_1 = this.level_1;
        var level_2 = this.level_2;
        $.blockUI({message: $('#monitorListLoading')});
        if ("true" == isMenu) {
            $.ajax({
                type: "POST",
                dataType: 'json',
                timeout : 60000,
                url: path + "/monitor/monitorAjaxList!judgeResourceOperate.action?isMenu=true&isMonitor=monitor&instanceId=" + instanceId,
                success: function(data, textStatus) {
                    $.unblockUI();
                    var _information = Monitor.Resource.infomation;
                    var allowable = data.allowable;
                    if (allowable == "delete") {
                        _information.setContentText("该资源已删除。"); //提示框 
                        _information.show();
                        $("#submitForm").attr('action', path + "/monitor/monitorList.action");
                        $("#submitForm").submit();
                        return false;
                    }
                    if (allowable == "unMonitor") {
                        _information.setContentText("该资源未监控。"); //提示框 
                        _information.show();
                        $("#submitForm").attr('action', path + "/monitor/monitorList.action");
                        $("#submitForm").submit();
                        return false;
                    }
                    var jsonstr = (new Function("return " + allowable))();
                    var permission = true;
                    var reason = "";
                    if (jsonstr) {
                        permission = jsonstr[0].permission;
                        if (permission == "false") {
                            permission = false;
                        }
                        reason = jsonstr[0].reason;
                    }
                    if (permission == false) {
                        _information.setContentText("无此权限，请联络系统管理员。"); //提示框 
                        _information.show();
                        return false;
                    }
                    if ("individuation" == spanName) {
                        winOpen({
                            url: path + "/profile/customProfile/queryCustomProfile.action?instanceId=" + instanceId + "&rowIndex=" + rowIndex,
                            width: 770,
                            height: 610,
                            scrollable: true,
                            name: 'customProfile'
                        });
                    }
                    if ("userDefined" == spanName || "default" == spanName) {
                        winOpen({
                            url: path + '/profile/userDefineProfile/queryProfile.action?basicInfo.profileId=' + profileId,
                            width: 970,
                            height: 1300,
                            scrollable: true,
                            name: 'addResource'
                        })
                    }
                    if ("action" == spanName) {
                         winOpen({
                            url: path + "/wireless/actionForPage/actionList.action?instanceId=" + instanceId + "&authority=" + permission,
                            width: 800,
                            height: 590,
                            scrollable: false,
                            name: 'actionList'
                         });
                    }
                    if ("interpose" == spanName) {
                        var jsonstr = (new Function("return " + allowable))();
                        if (whichTree == 'application') {
                            var items = Monitor.Resource.right.monitorList.ListMenu.applicationArray;
                            judgeMonitorMenu(items, jsonstr);
                            Monitor.Resource.menu.addMenuItems(items);
                        }
                        if (whichTree == 'device') {
                            if (whichGrid == 'host') {
                                var items = Monitor.Resource.right.monitorList.ListMenu.hostArray;
                                judgeMonitorMenu(items, jsonstr);
                                Monitor.Resource.menu.addMenuItems(items);
                            } else {
                                var items = Monitor.Resource.right.monitorList.ListMenu.equipmentArray;
                                judgeMonitorMenu(items, jsonstr);
                                Monitor.Resource.menu.addMenuItems(items);
                            }
                        }
                        if (whichTree == 'resourceGroupTree' || whichTree == 'searchResource') {
                            if (level_1) {
                                if (level_1 == 'application') {
                                    var items = Monitor.Resource.right.monitorList.ListMenu.applicationArray;
                                    judgeMonitorMenu(items, jsonstr);
                                    Monitor.Resource.menu.addMenuItems(items);
                                }
                                if (level_1 == 'device') {
                                    if (level_2 == 'host') {
                                        var items = Monitor.Resource.right.monitorList.ListMenu.hostArray;
                                        judgeMonitorMenu(items, jsonstr);
                                        Monitor.Resource.menu.addMenuItems(items);
                                    } else {
                                        var items = Monitor.Resource.right.monitorList.ListMenu.equipmentArray;
                                        judgeMonitorMenu(items, jsonstr);
                                        Monitor.Resource.menu.addMenuItems(items);
                                    }
                                }
                            }
                        }
                        Monitor.Resource.menu.position(e.clientX - 170, e.clientY);
                    }
                },error: function() {
                    $.unblockUI();
                    var _information = Monitor.Resource.infomation;
                    _information.setContentText("系统异常,请联系系统管理员。"); //提示框 
                    _information.show();
                }
            });
        }
        if ("false" == isMenu) {
            $.ajax({
                type: "POST",
                dataType: 'json',
                timeout : 60000,
                url: path + "/monitor/monitorAjaxList!judgeResourceOperate.action?isMenu=false&instanceId=" + instanceId,
                success: function(data, textStatus) {
                        $.unblockUI();
                        var _information = Monitor.Resource.infomation;
                        if (data.allowable == "delete" || data.allowable == "") {
                            _information.setContentText("该资源已删除。"); //提示框 
                            _information.show();
                            $("#submitForm").attr('action', path + "/monitor/monitorList.action");
                            $("#submitForm").submit();
                            return false;
                        }
                        if (data.allowable == "unMonitor") {
                            _information.setContentText("该资源未监控。"); //提示框 
                            _information.show();
                            $("#submitForm").attr('action', path + "/monitor/monitorList.action");
                            $("#submitForm").submit();
                            return false;
                        }
                        if ("instanceName" == spanName) {
                            winOpen({
                                url: '/pureportal/detail/resourcedetail.action?instanceId=' + instanceId,
                                width: 980,
                                height: 600,
                                scrollable: false,
                                name: 'resdetail_' + instanceId
                            });
                        }
                        if ("backPlane" == spanName) {
                            if (nodeId == "-") {
                                var _information = Monitor.Resource.infomation;
                                _information.setContentText("此资源不在拓扑中。"); //提示框 
                                _information.show();
                            } else {
                                winOpen({
                                    url: "/netfocus/netfocus.do?action=optservice@getnode&nodeId=" + nodeId + "&forward=/modules/flash/backboard.jsp",
                                    width: 1000,
                                    height: 610,
                                    name: 'backboard'
                                });
                            }
                        }
                        if ("vm" == spanName) {
                            winOpen({
                                url: vmPath,
                                width: 1000,
                                height: 900,
                                name: 'visual'
                            });
                        }
                        if ("interface" == spanName) {
                            Monitor.Resource.right.monitorList.gridMonitor.Light(rowIndex);
                            var self = this;
                            if (this.viewInterFace == null) {
                                this.viewInterFace = new winPanel({
                                    type: "POST",
                                    url: path + "/monitor/resourceStateDetail!viewInterFace.action?instanceId=" + instanceId,
                                    width: 440,
                                    x: e.pageX - 300,
                                    isautoclose: true,
                                    y: e.pageY,
                                    closeAction: "close",
                                    listeners: {
                                        closeAfter: function() {
                                            self.viewInterFace = null;
                                            Monitor.Resource.right.monitorList.gridMonitor.cancelLight(rowIndex);
                                        },loadAfter: function() {
                                            var documentHeight = document.body.clientHeight;
                                            var panelY = e.pageY + 5;
                                            var panelHeight = self.viewInterFace.getHeight();
                                            if (panelHeight + panelY > documentHeight) {
                                                panelY = e.pageY - 5 - panelHeight;
                                            }
                                            self.viewInterFace.setY(panelY);
                                        }
                                    }
                                },{
                                    winpanel_DomStruFn: "blackLayer_winpanel_DomStruFn"
                                });
                            }
                        }
                        if ("state" == spanName) {
                            winOpen({
                                url: path + "/monitor/resourceStateDetail.action?instanceId=" + instanceId,
                                width: 640,
                                height: 555,
                                name: 'stateDetail'
                            });
                        }
                        if ("cpuAnalysis" == spanName) {
                        	if(prev == false){
                        		return ;
                        	}
                            var whatMetric = "DeviceAvgCPUUtil";
                            if (whichTree == "application") {
                                whatMetric = "AppAvgCPUUtil";
                            }
                            Monitor.Resource.right.monitorList.gridMonitor.Light(rowIndex);
                            var self = this;
                            if (this.avgCpuRTAnalysis == null) {
                                this.avgCpuRTAnalysis = new winPanel({
                                    type: "POST",
                                    url: path + "/report/real/realManage!loadMonitorFlash.action",
                                    width: 420,
                                    x: e.pageX - 300,
                                    isautoclose: true,
                                    y: e.pageY,
                                    closeAction: "close",
                                    listeners: {
                                        closeAfter: function() {
                                            stopInterval();
                                            self.avgCpuRTAnalysis = null;
                                            Monitor.Resource.right.monitorList.gridMonitor.cancelLight(rowIndex);
                                        },
                                        loadAfter: function() {
                                            var documentHeight = document.body.clientHeight;
                                            var panelY = e.pageY + 5;
                                            var panelHeight = self.avgCpuRTAnalysis.getHeight();
                                            if (panelHeight + panelY > documentHeight) {
                                                panelY = e.pageY - 5 - panelHeight;
                                            }
                                            self.avgCpuRTAnalysis.setY(panelY);
                                            popShowFlash(whatMetric, instanceId, "CPU利用率(%)实时分析", "%");
                                        }
                                    }
                                },
                                {
                                    winpanel_DomStruFn: "blackLayer_winpanel_DomStruFn"
                                });
                            }
                        }
                        if ("memAnalysis" == spanName) {
                        	if(prev == false){
                        		return ;
                        	}
                            var whatMetric = "DeviceAvgMEMUtil";
                            if (whichTree == "application") {
                                whatMetric = "AppAvgMEMUtil";
                            }
                            Monitor.Resource.right.monitorList.gridMonitor.Light(rowIndex);
                            var self = this;
                            if (this.avgMemRTAnalysis == null) {
                                this.avgMemRTAnalysis = new winPanel({
                                    type: "POST",
                                    url: path + "/report/real/realManage!loadMonitorFlash.action",
                                    width: 420,
                                    x: e.pageX - 300,
                                    isautoclose: true,
                                    y: e.pageY,
                                    closeAction: "close",
                                    listeners: {
                                        closeAfter: function() {
                                            stopInterval();
                                            self.avgMemRTAnalysis = null;
                                            Monitor.Resource.right.monitorList.gridMonitor.cancelLight(rowIndex);
                                        },
                                        loadAfter: function() {
                                            var documentHeight = document.body.clientHeight;
                                            var panelY = e.pageY + 5;
                                            var panelHeight = self.avgMemRTAnalysis.getHeight();
                                            if (panelHeight + panelY > documentHeight) {
                                                panelY = e.pageY - 5 - panelHeight;
                                            }
                                            self.avgMemRTAnalysis.setY(panelY);
                                            popShowFlash(whatMetric, instanceId, "内存利用率(%)实时分析", "%");
                                        }
                                    }
                                },
                                {
                                    winpanel_DomStruFn: "blackLayer_winpanel_DomStruFn"
                                });
                            }
                        }
                }, error: function() {
                   $.unblockUI();
                   var _information = Monitor.Resource.infomation;
                   _information.setContentText("系统异常,请联系系统管理员。"); //提示框 
                   _information.show();
                }
            });　　　　　　
        }
    });
    var $instanceName = $("#monitorGrid span[whichCol='instanceName']");
    $instanceName.lazybind('mouseover',function(param) {
        if (Monitor.Resource.right.resourceInfoPanel) {
            Monitor.Resource.right.resourceInfoPanel.close("close");
            Monitor.Resource.right.resourceInfoPanel = null;
        }
        //alert($(this).attr("instanceId"));
        Monitor.Resource.right.resourceInfoPanel = new winPanel({
            type: "POST",
            url: path + "/monitor/maintainSetting!resourceInfo.action?instanceId=" + param.self.instanceId,
            width: 300,
            x: param.event.pageX + 20,
            isautoclose: false,
            y: param.event.pageY + 5,
            closeAction: "close",
            listeners: {
                loadAfter: function() {
                    var documentHeight = document.body.clientHeight;
                    var panelY = param.event.pageY + 5;
                    if (Monitor.Resource.right.resourceInfoPanel && Monitor.Resource.right.resourceInfoPanel != null) {
                        var panelHeight = Monitor.Resource.right.resourceInfoPanel.getHeight();
                        if (panelHeight + panelY > documentHeight) {
                            panelY = param.event.pageY - 5 - panelHeight;
                        }
                        Monitor.Resource.right.resourceInfoPanel.setY(panelY);
                    }
                }
            }
        },
        {
            winpanel_DomStruFn: "blackLayer_winpanel_DomStruFn"
        });
    },400, 'mouseout');
    $("#monitorGrid").delegate("span[whichCol]", "mouseout",function(e) {
       if("instanceName" == this.whichCol){
       	    if (Monitor.Resource.right.resourceInfoPanel && Monitor.Resource.right.resourceInfoPanel != null) {
                Monitor.Resource.right.resourceInfoPanel.close("close");
                Monitor.Resource.right.resourceInfoPanel = null;
            }
       }
    });
}};
Monitor.Resource.right.pcList.init = function() {
    var self = this;
    var tmpArr = [];
    var pointId = Monitor.Resource.right.pcList.pointId;
    var pointLevel = Monitor.Resource.right.pcList.pointLevel;
    var whichTree = Monitor.Resource.right.pcList.whichTree;
    var whichGrid = Monitor.Resource.right.pcList.whichGrid;
    var grid = Monitor.Resource.right.pcList.grid;
    var currentTree = Monitor.Resource.right.pcList.currentTree;
    var currentResourceTree = Monitor.Resource.right.pcList.currentResourceTree;
    if (!pointId) {
        pointId = "";
    }
    if (!pointLevel) {
        pointLevel = "";
    }
    if (!whichTree) {
        whichTree = "";
    }
    if (!whichGrid) {
        whichGrid = "";
    }
    if (!grid) {
        grid = "";
    }
    if (!currentTree) {
        currentTree = "";
    }
    if (!currentResourceTree) {
        currentResourceTree = "";
    }
    tmpArr.push("&pointId=");
    tmpArr.push(pointId);
    tmpArr.push("&pointLevel=");
    tmpArr.push(pointLevel);
    tmpArr.push("&whichTree=");
    tmpArr.push(whichTree);
    tmpArr.push("&whichGrid=");
    tmpArr.push(whichGrid);
    tmpArr.push("&grid=");
    tmpArr.push(grid);
    tmpArr.push("&currentTree=");
    tmpArr.push(currentTree);
    tmpArr.push("&currentResourceTree=");
    tmpArr.push(currentResourceTree);
    var param = tmpArr.join("");
    var sortColId = "";
    var sortType = "";
    if (!$("#tablePc")[0]) {
        return;
    }
    var search = $("#searchPc").val();
    if (search == '请输入条件搜索') {
        search = "";
    }
    this.gridPc = new GridPanel({
        id: "tablePc",
        columnWidth: Monitor.Resource.right.pcList.widthJson,
        unit: "%",
        plugins: [SortPluginIndex],
        sortColumns: Monitor.Resource.right.pcList.sortJson,
        sortLisntenr: function($sort) {
            $.blockUI({message: $('#monitorListLoading')});
            sortColId = $sort.colId;
            sortType = $sort.sorttype;
            $.ajax({
                type: "POST",
                dataType: 'json',
                timeout : 60000,
                url: path + "/monitor/monitorAjaxList!monitorGrid.action?" + encodeURI(param + "&currentPage=" + self.page.current + "&searchWhat=" + $("#searchWhat").val() + "&search=" + search + "&sort=" + sortType + "&sortCol=" + sortColId + "&currentUserId=" + userId + "&domain=" + $("#domain").val()),
                success: function(data, textStatus) {
                    self.gridPc.loadGridData(data.gridJson);
                    $("#tablePc .ico-t-right").bind('click',function(e) {
                        Monitor.Resource.right.monitorList.ListMenu.icoId = $(this).attr("id");
                        Monitor.Resource.right.monitorList.ListMenu.nodeId = $(this).attr("nodeId");
                        Monitor.Resource.right.monitorList.ListMenu.rowIndex = $(this).attr("rowIndex");
                        Monitor.Resource.right.monitorList.ListMenu.discoveryIp = $(this).attr("discoveryIp");
                        Monitor.Resource.right.monitorList.ListMenu.pointId = $(this).attr("pointId");
                        var level_1 = $(this).attr("level_1");
                        Monitor.Resource.menu.addMenuItems([[{
                            text: "刷新设备",
                            id: "refresh_eq",
                            listeners: {
                                click: function() { //alert($(this).attr("id"));
                                    $.blockUI({message: $('#equipmentLoading')});
                                    $.ajax({
                                        type: "POST",
                                        dataType: 'json',
                                        url: path + "/monitor/monitorAjaxList!equipmentRefresh.action?resID=" + Monitor.Resource.right.monitorList.ListMenu.icoId,

                                        success: function(data, textStatus) {
                                            var json = data.gridJson;
                                            $.unblockUI();
                                            if (json == null) {
                                                var _information = Monitor.Resource.infomation;
                                                _information.setContentText("刷新设备成功。"); //提示框 
                                                _information.show();
                                            } else {
                                                var _information = Monitor.Resource.infomation;
                                                _information.setContentText("刷新设备失败。"); //提示框 
                                                _information.show();
                                            } //logout();
                                        }
                                    });
                                }
                            }
                        },
                        {
                            text: "设置维护信息",
                            id: "setMaintainInfo",
                            listeners: {
                                click: function() {
                                    winOpen({
                                        url: path + "/monitor/maintainSetting.action?instanceId=" + Monitor.Resource.right.monitorList.ListMenu.icoId + "&rowIndex=" + Monitor.Resource.right.monitorList.ListMenu.rowIndex + "&pointId=" + Monitor.Resource.right.monitorList.ListMenu.pointId,
                                        width: 630,
                                        height: 510,
                                        scrollable: false,
                                        name: 'setMaintainInfo'
                                    });
                                }
                            }
                        },
                        {
                            text: "变更设备类型",
                            id: "change_type",
                            listeners: {
                                click: function() {monitorChangeType(Monitor.Resource.right.monitorList.ListMenu.icoId);}
                            }
                        },
                        {
                            text: "变更发现信息",
                            id: "changeFindInfo",
                            listeners: {
                                click: function() {
                                       changeFindInfo(Monitor.Resource.right.monitorList.ListMenu.icoId);
                                }
                            }
                        },
                        {
                            text: "重新发现",
                            id: "rediscovery",
                            listeners: {
                                click: function() {
                                    rediscovery(Monitor.Resource.right.monitorList.ListMenu.icoId);
                                }
                            }
                        }]]);
                        Monitor.Resource.menu.position(e.clientX - 175, e.clientY - 5);
                    });
                    SimpleBox.renderAll();
                    $.unblockUI();
                },
                error: function() {
                    $.unblockUI();
                    var _information = Monitor.Resource.infomation;
                    _information.setContentText("系统异常，请联系系统管理员。"); //提示框 
                    _information.show();
                }
            });
        }
    },
    {
        gridpanel_DomStruFn: "index_gridpanel_DomStruFn",
        gridpanel_DomCtrlFn: "index_gridpanel_DomCtrlFn",
        gridpanel_ComponetFn: "index_gridpanel_ComponetFn"
    });
    var renderGrid = [{
        index: "id",
        fn: function(td) {
            if (td.html != "") {
                $checkbox = $('<input type="checkbox" style="cursor:pointer" name="checkOneMonitor" value="' + td.value.hidId + '"/>');
                return $checkbox;
            } else {
                return null;
            }
        }
    },
    {
        index: "vender",
        fn: function(td) {
            if (td.html != "") {
                var resourceId = td.value.hidResourceId;
                if (!resourceId && resourceId == "-" || resourceId == "" || resourceId == null) {
                    $font = $('<span title="非网管设备" class="device-ico RID_NetworkNode"/>');
                    return $font;
                }
                var title = td.value.hidResourceName;
                if (!title || title == "-" || title == null || title == "null") {
                    title = "非网管设备";
                }
                $font = $('<span class="device-ico RID_' + td.value.hidResourceId + '" title="' + title + '"/>');
                return $font;
            } else {
                return null;
            }
        }
    },
    {
        index: "name",
        fn: function(td) {
            var name = td.html;
            name = td.html;
            if (!name || name == "") {
                name = td.value.hidDiscoveryIp;
            }
            if (name && name != "") {
                $span = $('<span style="cursor:pointer" title="' + coder(name) + '">' + name + '</span>');
                $span.bind("mouseover",function(e) {
                    if (Monitor.Resource.right.resourceInfoPanel) {
                        Monitor.Resource.right.resourceInfoPanel.close("close");
                        Monitor.Resource.right.resourceInfoPanel = null;
                    }
                    Monitor.Resource.right.resourceInfoPanel = new winPanel({
                        type: "POST",
                        url: path + "/monitor/maintainSetting!resourceInfo.action?instanceId=" + td.value.hidId,
                        width: 300,
                        x: e.pageX + 20,
                        isautoclose: false,
                        y: e.pageY + 5,
                        closeAction: "close",
                        listeners: {
                            loadAfter: function() {
                                var documentHeight = document.body.clientHeight;
                                var panelY = e.pageY + 5;
                                if (Monitor.Resource.right.resourceInfoPanel && Monitor.Resource.right.resourceInfoPanel != null) {
                                    var panelHeight = Monitor.Resource.right.resourceInfoPanel.getHeight();
                                    if (panelHeight + panelY > documentHeight) {
                                        panelY = e.pageY - 5 - panelHeight;
                                    }
                                    Monitor.Resource.right.resourceInfoPanel.setY(panelY);
                                }
                            }
                        }
                    },
                    {
                        winpanel_DomStruFn: "blackLayer_winpanel_DomStruFn"
                    });
                });
                $span.bind("mouseout", function(e) {
                    if (Monitor.Resource.right.resourceInfoPanel && Monitor.Resource.right.resourceInfoPanel != null) {
                        Monitor.Resource.right.resourceInfoPanel.close("close");
                        Monitor.Resource.right.resourceInfoPanel = null;
                    }
                });
                return $span;
            } else {
                return null;
            }
        }
    },
    {
        index: "IPAddress",
        fn: function(td) {
            if (td.html == "") {
                return null;
            }
            if (td.html == "-") {
                return "-";
            }
            var tmp = td.html;
            var arr = tmp.split(",");
            var length = arr.length;
            if (length <= 1) {
                return '<span>' + td.html + '</span>';
            }
            var select = '<select name="ipAddress" iconIndex="0" iconTitle="管理IP" iconClass="combox_ico_select f-absolute" style="width:117px" id="' + td.value.hidId + '">';
            for (var i = 0; i < length; i++) {
                var option = '<option>' + arr[i] + '</option>'
                select += option;
            }
            select += '</select>';
            $select = $(select);
            $select.bind("click",
            function() {});
            return $select;
        }
    },
    {
        index: "interpose",
        fn: function(td) {
            if (td.html != "") {
                if (td.value.hidLevel_1) {
                    $font = $('<span class="ico ico-t-right" id="' + td.value.hidId + '" pointId="' + pointId + '"whichGrid="' + whichGrid + '" pointId="' + pointId + '"nodeId="' + td.value.hidNodeId + '"rowIndex="' + td.rowIndex + '" locationDomainId="' + td.value.hidDomainId + '" discoveryIp="' + td.value.hidDiscoveryIp + '" level_1="' + td.value.hidLevel_1 + '"></span>"');
                } else {
                    $font = $('<span class="ico ico-t-right" id="' + td.value.hidId + '" pointId="' + pointId + '"whichGrid="' + whichGrid + '" pointId="' + pointId + '"nodeId="' + td.value.hidNodeId + '" locationDomainId="' + td.value.hidDomainId + '"rowIndex="' + td.rowIndex + '" discoveryIp="' + td.value.hidDiscoveryIp + '"></span>"');
                }
                return $font;
            }
        }
    }];
    this.gridPc.rend(renderGrid);
    $("#pcOperate").bind('click',function(e) {
        var icoId = $(this).attr("id");
        var offset = $(this).offset();
        var disable = false;
        if(isSystemAdmin == true){
        	disable = true;
        }else{
              if(whichTree != "searchResource"){
                 if($("#domain")[0].options.length == 1){
                 	if(isConfigMgrRole == true){
                       disable = true;
                 	}
                 }else{
                     if($("#domain").val() != "" && Monitor.Resource.right.monitorList.withoutSearch == "true"){
                           disable = true;
                     }
                 }
              }else{
                  if($("#domainSearch")[0].options.length == 1){
                    if(isConfigMgrRole == true){
                       disable = true;
                 	}
                  }else{
                     if($("#domainSearch").val() != "" && Monitor.Resource.right.monitorList.withoutSearch == "true"){
                           disable = true;
                     }
                  }
             }
        }
        var menuArray = [{
            text: "加入资源组",
            id: "joinResourceGroup",
            disable: true,
            listeners: {
                click: function() {
                    if (Monitor.Resource.right.noMonitorList.paramMap) {
                        Monitor.Resource.right.noMonitorList.paramMap = null;
                    }
                    $("input[name='checkOneMonitor']").each(function() {
                        if ($(this).attr("checked") == true) {
                            Monitor.Resource.right.monitorList.paramMap.put($(this).val(), $(this));
                        }
                    });
                    var instanceIdArr = Monitor.Resource.right.monitorList.paramMap.arr;
                    if (instanceIdArr.length <= 0) {
                        //alert("请选择一条数据。");
                        var _information = Monitor.Resource.infomation;
                        _information.setContentText("请选择一条数据。"); //提示框 
                        _information.show();
                        return false;
                    }
                    winOpen({
                        url: path + '/monitor/monitorList!joinResourceGroup.action?currentUserId=' + userId,
                        width: 410,
                        height: 160,
                        name: 'joinResourceGroup'
                    });
                }
            }
        },
        {
            text: "删除",
            id: "deleteResource",
            disable: disable,
            listeners: {
                click: function() {

                    var tmp = "";
                    $("input[name='checkOneMonitor']").each(function() {
                        if ($(this).attr("checked") == true) {
                            tmp += "&resourceInsId=" + $(this).val();
                        }
                    });
                    if (tmp != "") {
                        var _confirm = Monitor.Resource.confirm;
                        _confirm.setContentText("此操作不可恢复，是否确认执行此操作？"); //也可以在使用的时候传入
                        _confirm.setSubTipText("删除操作不影响其他使用此资源的模块，例如业务服务、网络拓扑等。");
                        _confirm.setConfirm_listener(function() {
                            $.blockUI({message: $('#monitorListLoading')});
                            _confirm.hide();
                            $.ajax({
                                type: "POST",
                                dataType: 'json',
                                timeout : 60000,
                                url: path + "/monitor/monitorAjaxList!delResource.action?" + tmp,
                                success: function(data, textStatus) {
                                	 $.unblockUI();
                                    if (data.deleteRes == "true") {
                                        // var _information = Monitor.Resource.infomation;
                                        // _information.setContentText("删除成功。"); //提示框
                                        // _information.show();
                                        Monitor.Resource.toast.addMessage("操作成功。");
                                        $("#monitor").val("monitor");
                                        $("#submitForm").attr('action', path + "/monitor/monitorList.action");
                                        $("#submitForm").submit();
                                    } else {
                                        $("#delResultForm #delResult").val(data.delResult);
                                        $("#delResultForm").attr('action', path + "/monitor/monitorList!delResult.action?whatOperate=delResource");
                                        $("#delResultForm").submit();
                                    }
                                   
                                },
                                error: function() {
                                    $.unblockUI();
                                     var _information = Monitor.Resource.infomation;
                                     _information.setContentText("系统异常，请联系系统管理员。"); //提示框 
                                     _information.show();
                                }
                            });
                        });
                        _confirm.show();
                    } else {
                        var _information = Monitor.Resource.infomation;
                        _information.setContentText("请选择一条数据。"); //提示框 
                        _information.show();
                        return false;
                    }
                }
            }
        },
        {
            text: "变更设备类型",
            id: "change_type",
            disable: disable,
            listeners: {
                click: function() {
                    var tmp = "";
                    $("input[name='checkOneMonitor']").each(function() {
                        if ($(this).attr("checked") == true) {
                            tmp += $(this).val() + ",";
                        }
                    });
                    if (tmp == "") {
                        var _information = Monitor.Resource.infomation;
                        _information.setContentText("请选择一条数据。"); //提示框 
                        _information.show();
                        return false;
                    }
                    $("#operateForm #instanceId").val(tmp);
                    $("#operateForm").attr('action', path + "/discovery/resource-instance-batchchange.action");
                    $("#operateForm").submit();
                }
            }
        }];
        Monitor.Resource.menu.addMenuItems([menuArray]);
        Monitor.Resource.menu.position(offset.left, offset.top + $(this).height());
    });
    this.page = new Pagination({
        applyId: "pagePc",
        listeners: {
            pageClick: function(page) {
                $.blockUI({message: $('#monitorListLoading')});
                $.ajax({
                    type: "POST",
                    dataType: 'json',
                    timeout : 60000,
                    url: path + "/monitor/monitorAjaxList!monitorGrid.action?" + encodeURI(param + "&currentPage=" + page + "&searchWhat=" + $("#searchWhat").val() + "&search=" + search + "&sort=" + sortType + "&sortCol=" + sortColId + "&currentUserId=" + userId + "&domain=" + $("#domain").val()),
                    success: function(data, textStatus) {
                        $("#tablePc input[name='checkAll']").attr("checked", false);
                        $("#tablePc input[name='checkOneMonitor']").each(function() {
                            $(this).attr("checked", false);
                        });
                        self.gridPc.loadGridData(data.gridJson);
                        $("#tablePc .ico-t-right").bind('click',function(e) {
                            Monitor.Resource.right.monitorList.ListMenu.icoId = $(this).attr("id");
                            Monitor.Resource.right.monitorList.ListMenu.nodeId = $(this).attr("nodeId");
                            Monitor.Resource.right.monitorList.ListMenu.rowIndex = $(this).attr("rowIndex");
                            Monitor.Resource.right.monitorList.ListMenu.discoveryIp = $(this).attr("discoveryIp");
                            var level_1 = $(this).attr("level_1");
                            Monitor.Resource.menu.addMenuItems([[{
                                text: "刷新设备",
                                id: "refresh_eq",
                                listeners: {
                                    click: function() {
                                        $.blockUI({message: $('#equipmentLoading')});
                                        $.ajax({
                                            type: "POST",
                                            dataType: 'json',
                                            url: path + "/monitor/monitorAjaxList!equipmentRefresh.action?resID=" + Monitor.Resource.right.monitorList.ListMenu.icoId,
                                            success: function(data, textStatus) {
                                                var json = data.gridJson;
                                                $.unblockUI();
                                                if (json == null) {
                                                    var _information = Monitor.Resource.infomation;
                                                    _information.setContentText("刷新设备成功。"); //提示框 
                                                    _information.show();
                                                } else {
                                                    var _information = Monitor.Resource.infomation;
                                                    _information.setContentText("刷新设备失败。"); //提示框 
                                                    _information.show();
                                                } //logout();
                                            },
                                            error: function() {
                                                $.unblockUI();
                                            }
                                        });
                                    }
                                }
                            },
                            {
                                text: "设置维护信息",
                                id: "setMaintainInfo",
                                listeners: {
                                    click: function() {
                                        winOpen({
                                            url: path + "/monitor/maintainSetting.action?instanceId=" + Monitor.Resource.right.monitorList.ListMenu.icoId + "&rowIndex=" + Monitor.Resource.right.monitorList.ListMenu.rowIndex + "&pointId=" + Monitor.Resource.right.monitorList.ListMenu.pointId,
                                            width: 630,
                                            height: 510,
                                            scrollable: false,
                                            name: 'setMaintainInfo'
                                        });
                                    }
                                }
                            },
                            {
                                text: "变更设备类型",
                                id: "change_type",
                                listeners: {
                                    click: function() {monitorChangeType(Monitor.Resource.right.monitorList.ListMenu.icoId);}
                                }
                            },
                            {
                                text: "变更发现信息",
                                id: "changeFindInfo",
                                listeners: {
                                    click: function() {
                                           changeFindInfo(Monitor.Resource.right.monitorList.ListMenu.icoId);
                                    }
                                }
                            },
                            {
                                text: "重新发现",
                                id: "rediscovery",
                                listeners: {
                                    click: function() {
                                        rediscovery(Monitor.Resource.right.monitorList.ListMenu.icoId);
                                    }
                                }
                            }]]);
                            Monitor.Resource.menu.position(e.clientX - 175, e.clientY - 5);
                        });
                        SimpleBox.renderAll();
                        $.unblockUI();
                    },error: function() {
                        $.unblockUI();
                         var _information = Monitor.Resource.infomation;
                        _information.setContentText("系统异常，请联系系统管理员。"); //提示框 
                        _information.show();
                    }
                });
            }
        }
    });
    self.page.pageing(Monitor.Resource.right.pcList.pageCount, 1);
    var $searchText = $("#searchPc");
    $("#searchPcBut").bind("click",function(event) {
        $("#searchPc").val($.trim($("#searchPc").val()));
        $.blockUI({message: $('#monitorListLoading')});
        var val = $("#searchPc").val();
        if (val == '请输入条件搜索') {
            val = "";
        }
        $.ajax({
            type: "POST",
            dataType: 'json',
            timeout : 60000,
            url: path + "/monitor/monitorAjaxList!monitorGrid.action?" + encodeURI(param + "&searchWhat=" + $("#searchWhat").val() + "&search=" + val + "&currentUserId=" + userId + "&domain=" + $("#domain").val()),
            success: function(data, textStatus) {
                self.gridPc.loadGridData(data.gridJson);
                $("#tablePc .ico-t-right").bind('click',function(e) {
                    Monitor.Resource.right.monitorList.ListMenu.icoId = $(this).attr("id");
                    Monitor.Resource.right.monitorList.ListMenu.nodeId = $(this).attr("nodeId");
                    Monitor.Resource.right.monitorList.ListMenu.rowIndex = $(this).attr("rowIndex");
                    Monitor.Resource.right.monitorList.ListMenu.discoveryIp = $(this).attr("discoveryIp");
                    var level_1 = $(this).attr("level_1");
                    Monitor.Resource.menu.addMenuItems([[{
                        text: "刷新设备",
                        id: "refresh_eq",
                        listeners: {
                            click: function() { //alert($(this).attr("id"));
                                $.blockUI({message: $('#equipmentLoading')});
                                $.ajax({
                                    type: "POST",
                                    dataType: 'json',
                                    url: path + "/monitor/monitorAjaxList!equipmentRefresh.action?resID=" + Monitor.Resource.right.monitorList.ListMenu.icoId,
                                    success: function(data, textStatus) {
                                        var json = data.gridJson;
                                        $.unblockUI();
                                        if (json == null) {
                                            var _information = Monitor.Resource.infomation;
                                            _information.setContentText("刷新设备成功。"); //提示框 
                                            _information.show();
                                        } else {
                                            var _information = Monitor.Resource.infomation;
                                            _information.setContentText("刷新设备失败。"); //提示框 
                                            _information.show();
                                        } //logout();
                                    },
                                    error: function() {
                                        $.unblockUI();
                                    }
                                });
                            }
                        }
                    },
                    {
                        text: "设置维护信息",
                        id: "setMaintainInfo",
                        listeners: {
                            click: function() {
                                winOpen({
                                    url: path + "/monitor/maintainSetting.action?instanceId=" + Monitor.Resource.right.monitorList.ListMenu.icoId + "&rowIndex=" + Monitor.Resource.right.monitorList.ListMenu.rowIndex + "&pointId=" + Monitor.Resource.right.monitorList.ListMenu.pointId,
                                    width: 630,
                                    height: 510,
                                    scrollable: false,
                                    name: 'setMaintainInfo'
                                });
                            }
                        }
                    },
                    {
                        text: "变更设备类型",
                        id: "change_type",
                        listeners: {
                            click: function() {monitorChangeType(Monitor.Resource.right.monitorList.ListMenu.icoId);}
                        }
                    },
                    {
                        text: "变更发现信息",
                        id: "changeFindInfo",
                        listeners: {
                            click: function() {
                                   changeFindInfo(Monitor.Resource.right.monitorList.ListMenu.icoId);
                            }
                        }
                    },
                    {
                        text: "重新发现",
                        id: "rediscovery",
                        listeners: {
                            click: function() {
                            	rediscovery(Monitor.Resource.right.monitorList.ListMenu.icoId);
                            }
                        }
                    }]]);
                    Monitor.Resource.menu.position(e.clientX - 175, e.clientY - 5);
                });
                self.page.pageing(data.pageCount, 1);
                SimpleBox.renderAll();
                $.unblockUI();
            },error: function() {
                $.unblockUI();
                var _information = Monitor.Resource.infomation;
                _information.setContentText("系统异常，请联系系统管理员。"); //提示框 
                _information.show();
            }
        });
    });
    $searchText.bind("focus",function(event) {
        $searchText.removeClass();
        if ($searchText.val() == "请输入条件搜索") {
            $searchText.val("");
        }
    });
    $searchText.bind("blur",function(event) {
        var c = $searchText.val();
        if (c == null || c == '') {
            $searchText.val("请输入条件搜索");
            $searchText.addClass('inputoff');
        }
    });
    $searchText.bind("keydown",function(event) {
        var evt = window.event ? window.event: evt;
        if (evt.keyCode == 13) {
            $("#searchPc").val($.trim($("#searchPc").val()));
            $.blockUI({message: $('#monitorListLoading')});
            var val = $("#searchMonitor").val();
            $.ajax({
                type: "POST",
                dataType: 'json',
                timeout : 60000,
                url: path + "/monitor/monitorAjaxList!monitorGrid.action?" + encodeURI(param + "&searchWhat=" + $("#searchWhat").val() + "&search=" + val + "&currentUserId=" + userId + "&domain=" + $("#domain").val()),
                success: function(data, textStatus) {
                    self.gridPc.loadGridData(data.gridJson);
                    $("#tablePc .ico-t-right").bind('click', function(e) {
                        Monitor.Resource.right.monitorList.ListMenu.icoId = $(this).attr("id");
                        Monitor.Resource.right.monitorList.ListMenu.nodeId = $(this).attr("nodeId");
                        Monitor.Resource.right.monitorList.ListMenu.rowIndex = $(this).attr("rowIndex");
                        Monitor.Resource.right.monitorList.ListMenu.discoveryIp = $(this).attr("discoveryIp");
                        var level_1 = $(this).attr("level_1");
                        Monitor.Resource.menu.addMenuItems([[{
                            text: "刷新设备",
                            id: "refresh_eq",
                            disable: permissions,
                            listeners: {
                                click: function() { //alert($(this).attr("id"));
                                    $.blockUI({message: $('#equipmentLoading')});
                                    $.ajax({
                                        type: "POST",
                                        dataType: 'json',
                                        url: path + "/monitor/monitorAjaxList!equipmentRefresh.action?resID=" + Monitor.Resource.right.monitorList.ListMenu.icoId,
                                        success: function(data, textStatus) {
                                            var json = data.gridJson;
                                            $.unblockUI();
                                            if (json == null) {
                                                var _information = Monitor.Resource.infomation;
                                                _information.setContentText("刷新设备成功。"); //提示框 
                                                _information.show();
                                            } else {
                                                var _information = Monitor.Resource.infomation;
                                                _information.setContentText("刷新设备失败。"); //提示框 
                                                _information.show();
                                            } //logout();
                                        }
                                    });
                                }
                            }
                        },
                        {
                            text: "设置维护信息",
                            id: "setMaintainInfo",
                            disable: permissions,
                            listeners: {
                                click: function() {
                                    winOpen({
                                        url: path + "/monitor/maintainSetting.action?instanceId=" + Monitor.Resource.right.monitorList.ListMenu.icoId + "&rowIndex=" + Monitor.Resource.right.monitorList.ListMenu.rowIndex + "&pointId=" + Monitor.Resource.right.monitorList.ListMenu.pointId,
                                        width: 630,
                                        height: 510,
                                        scrollable: false,
                                        name: 'setMaintainInfo'
                                    });
                                }
                            }
                        },
                        {
                            text: "变更设备类型",
                            id: "change_type",
                            disable: permissions,
                            listeners: {
                                click: function() {monitorChangeType(Monitor.Resource.right.monitorList.ListMenu.icoId);}
                            }
                        },
                        {
                            text: "变更发现信息",
                            id: "changeFindInfo",
                            disable: permissions,
                            listeners: {
                                click: function() {
                                       changeFindInfo(Monitor.Resource.right.monitorList.ListMenu.icoId);
                                }
                            }
                        },
                        {
                            text: "重新发现",
                            id: "rediscovery",
                            disable: permissions,
                            listeners: {
                                click: function() {
                                       rediscovery(Monitor.Resource.right.monitorList.ListMenu.icoId);
                                }
                            }
                        }]]);
                        Monitor.Resource.menu.position(e.clientX - 175, e.clientY - 5);
                    });
                    self.page.pageing(data.pageCount, 1);
                    SimpleBox.renderAll();
                    $.unblockUI();
                },error: function() {
                    $.unblockUI();
                    var _information = Monitor.Resource.infomation;
                    _information.setContentText("系统异常，请联系系统管理员。"); //提示框 
                    _information.show();
                }
            });
        }
    });
    $("#tablePc input[name='checkAll']").bind("click",function(event) {
        if ($(this).attr("checked") == true) { // 全选
            $("#tablePc input[name='checkOneMonitor']").each(function() {
                $(this).attr("checked", true);
            });
        } else { // 取消全选
            $("#tablePc input[name='checkOneMonitor']").each(function() {
                $(this).attr("checked", false);
            });
        }
    });
    $("#tablePc .ico-t-right").bind('click',function(e) {
        Monitor.Resource.right.monitorList.ListMenu.icoId = $(this).attr("id");
        Monitor.Resource.right.monitorList.ListMenu.nodeId = $(this).attr("nodeId");
        Monitor.Resource.right.monitorList.ListMenu.rowIndex = $(this).attr("rowIndex");
        Monitor.Resource.right.monitorList.ListMenu.discoveryIp = $(this).attr("discoveryIp");
        Monitor.Resource.right.monitorList.ListMenu.pointId = $(this).attr("pointId");
        $.blockUI({ message: $('#monitorListLoading')});
        $.ajax({
            type: "POST",
            dataType: 'json',
            timeout : 60000,
            url: path + "/monitor/monitorAjaxList!judgeResourceOperate.action?isMenu=true&instanceId=" + Monitor.Resource.right.monitorList.ListMenu.icoId,
            success: function(data, textStatus) {
                $.unblockUI();
                if (data.allowable != "delete") {
                    var level_1 = $(this).attr("level_1");
                    Monitor.Resource.menu.addMenuItems([[{
                        text: "刷新设备",
                        id: "refresh_eq",
                        disable: permissions,
                        listeners: {
                            click: function() { //alert($(this).attr("id"));
                                $.blockUI({ message: $('#equipmentLoading')});
                                $.ajax({
                                    type: "POST",
                                    dataType: 'json',
                                    url: path + "/monitor/monitorAjaxList!equipmentRefresh.action?resID=" + Monitor.Resource.right.monitorList.ListMenu.icoId,
                                    success: function(data, textStatus) {
                                        var json = data.gridJson;
                                        $.unblockUI();
                                        if (json == null) {
                                            var _information = Monitor.Resource.infomation;
                                            _information.setContentText("刷新设备成功。"); //提示框 
                                            _information.show();
                                        } else {
                                            var _information = Monitor.Resource.infomation;
                                            _information.setContentText("刷新设备失败。"); //提示框 
                                            _information.show();
                                        }
                                    }
                                });
                            }
                        }
                    },
                    {
                        text: "设置维护信息",
                        id: "setMaintainInfo",
                        disable: permissions,
                        listeners: {
                            click: function() {
                                winOpen({
                                    url: path + "/monitor/maintainSetting.action?instanceId=" + Monitor.Resource.right.monitorList.ListMenu.icoId + "&rowIndex=" + Monitor.Resource.right.monitorList.ListMenu.rowIndex + "&pointId=" + Monitor.Resource.right.monitorList.ListMenu.pointId,
                                    width: 630,
                                    height: 510,
                                    scrollable: false,
                                    name: 'setMaintainInfo'
                                });
                            }
                        }
                    },
                    {
                        text: "变更设备类型",
                        id: "change_type",
                        disable: permissions,
                        listeners: {
                            click: function() {monitorChangeType(Monitor.Resource.right.monitorList.ListMenu.icoId);}
                        }
                    },
                    {
                        text: "变更发现信息",
                        id: "changeFindInfo",
                        disable: permissions,
                        listeners: {
                            click: function() {
                                   changeFindInfo(Monitor.Resource.right.monitorList.ListMenu.icoId);
                            }
                        }
                    },
                    {
                        text: "重新发现",
                        id: "rediscovery",
                        disable: permissions,
                        listeners: {
                            click: function() {
                                   rediscovery(Monitor.Resource.right.monitorList.ListMenu.icoId);
                            }
                        }
                    }]]);
                    Monitor.Resource.menu.position(e.clientX - 175, e.clientY - 5);

                } else {
                    var _information = Monitor.Resource.infomation;
                    _information.setContentText("该资源已删除。"); //提示框 
                    _information.show();
                    $("#submitForm").attr('action', path + "/monitor/monitorList.action");
                    $("#submitForm").submit();
                }
            },error: function() {
                $.unblockUI();
                var _information = Monitor.Resource.infomation;
                _information.setContentText("系统异常，请联系系统管理员。"); //提示框 
                _information.show();
            }
        });
    });
    $("#notOnlineTime").bind('click',function(e) {
        winOpen({
            url: path + '/monitor/offlinetime.action',
            width: 700,
            height: 650,
            name: 'notOnlineTimeSetting'
        });
    });
    $("#refreshSettings").bind('click',function(e) {
        winOpen({
            url: path + '/monitor/pageRenovate.action?pageModule=MonitorModule',
            width: 300,
            height: 190,
            name: 'refreshSettings'
        });
    });
    SimpleBox.renderAll();
};
Monitor.Resource.right.monitorList.init = function(isSearch, isGroup) {
    var whichState = "";
    var self = this;
    if ("search" == isSearch) {
        $("#monitorGrid div[name='isSearch']").hide();
    } else {
        $("#monitorGrid div[name='isSearch']").show("fast",function() {
            SimpleBox.renderAll();
        });
    }
    if ("group" == isGroup) {
        $("#monitorGrid div[name='groupOperate']").show("fast",function() {
            SimpleBox.renderAll();
        });
    } else {
        $("#monitorGrid div[name='groupOperate']").hide();
    }
    $("#monitorGrid").hide();
    var tmpArr = [];
    var pointId = Monitor.Resource.right.monitorList.pointId;
    var pointLevel = Monitor.Resource.right.monitorList.pointLevel;
    var monitor = Monitor.Resource.right.monitorList.monitor;
    var whichTree = Monitor.Resource.right.monitorList.whichTree;
    var whichGrid = Monitor.Resource.right.monitorList.whichGrid;
    var grid = Monitor.Resource.right.monitorList.grid;
    var currentTree = Monitor.Resource.right.monitorList.currentTree;
    var currentResourceTree = Monitor.Resource.right.monitorList.currentResourceTree;
    if (!pointId) {
        pointId = "";
    }
    if (!pointLevel) {
        pointLevel = "";
    }
    if (!monitor) {
        monitor = "";
    }
    if (!whichTree) {
        whichTree = "";
    }
    if (!whichGrid) {
        whichGrid = "";
    }
    if (!grid) {
        grid = "";
    }
    if (!currentTree) {
        currentTree = "";
    }
    if (!currentResourceTree) {
        currentResourceTree = "";
    }
    tmpArr.push("&pointId=");
    tmpArr.push(pointId);
    tmpArr.push("&pointLevel=");
    tmpArr.push(pointLevel);
    tmpArr.push("&monitor=");
    tmpArr.push(monitor);
    tmpArr.push("&whichTree=");
    tmpArr.push(whichTree);
    tmpArr.push("&whichGrid=");
    tmpArr.push(whichGrid);
    tmpArr.push("&grid=");
    tmpArr.push(grid);
    tmpArr.push("&currentTree=");
    tmpArr.push(currentTree);
    tmpArr.push("&currentResourceTree=");
    tmpArr.push(currentResourceTree);
    var param =  tmpArr.join("");
    var sortColId = "";
    var sortType = "";
    if (!$("#tableMonitor")[0]) {
        return;
    }
    var search = $.trim($("#searchMonitor").val());
    if ($("#searchMonitor").is(":hidden")) {
        search = $("#search").val();
    }
    if (search == '请输入条件搜索') {
        search = "";
    }
    this.gridMonitor = new GridPanel({
        id: "tableMonitor",
        columnWidth: Monitor.Resource.right.monitorList.widthJson,
        unit: "%",
        plugins: [SortPluginIndex],
        sortColumns: Monitor.Resource.right.monitorList.sortJson,
        sortLisntenr: function($sort) {
            var search = "";
            var domain = "";
            if (whichTree == "searchResource") {
                search = $.trim($("#searchSearch").val());
                if (search == '请输入条件搜索') {
                    search = "";
                }
                domain = $.trim($("#domainSearch").val());
                if (domain == '请选择域') {
                    domain = "";
                }
            } else {
                search = $.trim($("#searchMonitor").val());
                if (search == '请输入条件搜索') {
                    search = "";
                }
                domain = $.trim($("#domain").val());
                if (domain == '请选择域') {
                    domain = "";
                }
            }
            $.blockUI({message: $('#monitorListLoading')});
            sortColId = $sort.colId;
            sortType = $sort.sorttype;
            $.ajax({
                type: "POST",
                dataType: 'json',
                timeout : 60000,
                url: path + "/monitor/monitorAjaxList!monitorGrid.action?" + encodeURI(param + "&currentPage=" + self.page.current + "&searchWhat=" + $("#searchWhat").val() + "&search=" + search + "&sort=" + sortType + "&sortCol=" + sortColId + "&currentUserId=" + userId + "&domain=" + domain),
                success: function(data, textStatus) {
                    self.gridMonitor.loadGridData(data.gridJson);
                    Monitor.Resource.right.monitorList.ListMenu.init(whichTree, whichGrid, "monitor");
                    SimpleBox.renderAll();
                    $.unblockUI();
                }, error: function() {
                    $.unblockUI();
                    var _information = Monitor.Resource.infomation;
                    _information.setContentText("系统异常，请联系系统管理员。"); //提示框 
                    _information.show();
                }
            });
        }
    },{
        gridpanel_DomStruFn: "index_gridpanel_DomStruFn",
        gridpanel_DomCtrlFn: "index_gridpanel_DomCtrlFn",
        gridpanel_ComponetFn: "index_gridpanel_ComponetFn"
    });
    var renderGrid = [{
        index: "id",
        fn: function(td) {
            if (td.html != "") {
                return '<input type="checkbox" style="cursor:pointer" name="checkOneMonitor" value="' + td.value.hidId + '"/>';
            } else {
                return null;
            }
        }
    },{
        index: "vender",
        fn: function(td) {
            if (td.html != "") {
                var resourceId = td.value.hidResourceId;
                var vender = "-";
                if (!resourceId && resourceId == "-" || resourceId == "" || resourceId == null) {
                    vender= '<span title="非网管设备" class="device-ico RID_NetworkNode"/>';
                    return $vender;
                }
                var title = td.value.hidResourceName;
                if (!title || title == "-" || title == null || title == "null") {
                    title = "非网管设备";
                }
                vender = '<span class="device-ico RID_' + td.value.hidResourceId + '" title="' + title + '"></span>';
                return vender;
            } else {
                return null;
            }
        }
    },{
        index: "name",
        fn: function(td) {
            var name = td.html;
            if (!name || name == "") {
                name = td.value.hidDiscoveryIp;
            }
            if (name && name != "") {
                return '<span whichCol="instanceName" isMenu="false" style="cursor:pointer" title="' + coder(name) + '" instanceId="'+td.value.hidId+'">' + coder(name) + '</span>';
            } else {
                return null;
            }
        }
    },{
        index: "DeviceAvgCPUUtil",
        fn: function(td) {
        	var tdHtml = td.html;
            if (tdHtml == "") {
                return null;
            }
            var cpu = "-";
            if (tdHtml == "-") {
                cpu = '<span class="ico ico-novalue-off" style="cursor:default"></span>';
                return cpu;
            }
            if (tdHtml == "noMetric") {
                cpu = '<span class="ico ico-no-indicators-off" style="cursor:default"></span>';
                return cpu;
            }
            if (tdHtml == "noValue") {
                cpu = '<span class="ico ico-novalue-off" style="cursor:default"></span>';
                return cpu;
            }
            if (tdHtml == "noMonitor") {
                cpu = '<span class="ico ico-stop" style="cursor:default"></span>';
                return cpu;
            }
            var cpuColor = td.value.hidCpuColor;
            switch (cpuColor) {
            case "red":
                cpu = '<span style="color:red;width:43px;display:inline-block;text-align:left;font-weight:700">' + td.html + '</span>' + '<span title="点击查看实时分析" class="ico ico-percent" whichCol="cpuAnalysis" isMenu="false" instanceId="' + td.value.hidId + '"rowIndex="' + td.rowIndex + '" whichTree="' + whichTree + '"></span>';
                break;
            case "green":
                cpu = '<span style="color:#1dc817;width:43px;display:inline-block;text-align:left;font-weight:700">' + td.html + '</span>' + '<span title="点击查看实时分析" class="ico ico-percent" whichCol="cpuAnalysis" isMenu="false" instanceId="' + td.value.hidId + '"rowIndex="' + td.rowIndex + '" whichTree="' + whichTree + '"></span>';
                break;
            case "yellow":
                cpu = '<span style="color:#FFD700;width:43px;display:inline-block;text-align:left;font-weight:700">' + td.html + '</span>' + '<span title="点击查看实时分析" class="ico ico-percent" whichCol="cpuAnalysis" isMenu="false" instanceId="' + td.value.hidId + '"rowIndex="' + td.rowIndex + '" whichTree="' + whichTree + '"></span>';
                break;
            case "black":
              cpu = '<span style="width:43px;display:inline-block;text-align:left;font-weight:700">' + td.html + '</span>' + '<span title="点击查看实时分析" class="ico ico-percent" whichCol="cpuAnalysis" isMenu="false" instanceId="' + td.value.hidId + '"rowIndex="' + td.rowIndex + '" whichTree="' + whichTree + '"></span>';
              break;
            default:
                cpu = '<span class="ico ico-novalue-off" style="cursor:default"></span>';
            }
            return cpu;
        }
    },{
        index: "DeviceAvgMEMUtil",
        fn: function(td) {
        	var tdHtml = td.html;
            if (tdHtml == "") {
                return null;
            }
             var mem = "-";
            if (tdHtml == "-") {
                mem = '<span class="ico ico-novalue-off" style="cursor:default"></span>';
                return mem;
            }
            if (tdHtml == "noMetric") {
                mem = '<span class="ico ico-no-indicators-off" style="cursor:default"></span>';
                return mem;
            }
            if (tdHtml == "noValue") {
                mem = '<span class="ico ico-novalue-off" style="cursor:default"></span>';
                return mem;
            }
            if (tdHtml == "noMonitor") {
                mem = '<span class="ico ico-stop" style="cursor:default"></span>';
                return mem;
            }
            var memColor = td.value.hidMemColor;
            switch (memColor) {
            case "red":
                mem = '<span style="color:red;width:43px;display:inline-block;text-align:left;font-weight:700">' + td.html + '</span>' + '<span title="点击查看实时分析" class="ico ico-percent" whichCol="memAnalysis" isMenu="false" instanceId="' + td.value.hidId + '"rowIndex="' + td.rowIndex + '" whichTree="' + whichTree + '"></span>';
                break;
            case "green":
                mem = '<span style="color:#1dc817;width:43px;display:inline-block;text-align:left;font-weight:700">' + td.html + '</span>' + '<span title="点击查看实时分析" class="ico ico-percent" whichCol="memAnalysis" isMenu="false" instanceId="' + td.value.hidId + '"rowIndex="' + td.rowIndex + '" whichTree="' + whichTree + '"></span>';
                break;
            case "yellow":
                mem = '<span style="color:#FFD700;width:43px;display:inline-block;text-align:left;font-weight:700">' + td.html + '</span>' + '<span title="点击查看实时分析" class="ico ico-percent" whichCol="memAnalysis" isMenu="false" instanceId="' + td.value.hidId + '"rowIndex="' + td.rowIndex + '" whichTree="' + whichTree + '"></span>';
                break;
            case "black":
              mem = '<span style="width:43px;display:inline-block;text-align:left;font-weight:700">' + td.html + '</span>' + '<span title="点击查看实时分析" class="ico ico-percent" whichCol="memAnalysis" isMenu="false" instanceId="' + td.value.hidId + '"rowIndex="' + td.rowIndex + '" whichTree="' + whichTree + '"></span>';
                break;
            default:
                mem = '<span class="ico ico-novalue-off"></span>';
            }
            return mem;
        }
    },{
        index: "IPAddress",
        fn: function(td) {
        	var tdHtml = td.html;
            if (tdHtml == "") {
                return null;
            }
            if (tdHtml == "-") {
                return "-";
            }
            var arr = tdHtml.split(",");
            var length = arr.length;
            if (length <= 1) {
                return '<span>' + td.html + '</span>';
            }
            var select = '<select name="ipAddress" iconIndex="0" iconTitle="管理IP" iconClass="combox_ico_select f-absolute" style="width:117px" id="' + td.value.hidId + '">';
            for (var i = 0; i < length; i++) {
                var option = '<option>' + arr[i] + '</option>'
                select += option;
            }
            select += '</select>';
            return select;
        }
    },{
        index: "state",
        fn: function(td) {
            if (td.html != "") {
            	var state;
            	var hidState = td.value.hidState ;
                if (hidState != 'null' && hidState != '-') {
                    state = '<span whichCol="state" isMenu="false" title="点击浏览状态详细信息" class=" ' + td.value.hidState + '"name="' + td.value.hidState + '"rowIndex="' + td.rowIndex +'" instanceId="'+td.value.hidId+'"></span>';
                } else {
                    state = '-';
                }
                return state;
            }
        }
    },{
        index: "interpose",
        fn: function(td) {
            if (td.html != "") {
            	var interpose ;
                if (td.value.hidLevel_1) {
                    interpose = '<span whichCol="interpose" isMenu="true" class="ico ico-t-right" instanceId="' + td.value.hidId + '" pointId="' + pointId + '"whichGrid="' + whichGrid + '" pointId="' + pointId + '"nodeId="' + td.value.hidNodeId + '"rowIndex="' + td.rowIndex + '" locationDomainId="' + td.value.hidDomainId + '" discoveryIp="' + td.value.hidDiscoveryIp + '" level_1="' + td.value.hidLevel_1 + '" level_2="' + td.value.hidLevel_2 +  '"></span>';
                } else {
                    interpose = '<span whichCol="interpose" isMenu="true" class="ico ico-t-right" instanceId="' + td.value.hidId + '" pointId="' + pointId + '"whichGrid="' + whichGrid + '" pointId="' + pointId + '"nodeId="' + td.value.hidNodeId + '" locationDomainId="' + td.value.hidDomainId + '"rowIndex="' + td.rowIndex + '" discoveryIp="' + td.value.hidDiscoveryIp + '"></span>';
                }
                return interpose;
            }
        }
    },{
        index: "profile",
        fn: function(td) {
            if (td.html != "") {
                var arr = td.value.hidProfile.split(",");
                var profile = "-";
                if ("SystemProfile" == arr[0]) {
                    profile = '<span whichCol="default" isMenu="true" class="ico ico-default" id="' + arr[0] + '" profileId="' + arr[1] + '"instanceId="' + td.value.hidId + '"rowIndex="' + td.rowIndex + '"title="' + "系统默认策略："+arr[2] + '"></span>';
                    return profile;
                }
                if ("UserDefineProfile" == arr[0]) {
                    profile = '<span whichCol="userDefined" isMenu="true" class="ico ico-user-defined" id="' + arr[0] + '" profileId="' + arr[1] + '"instanceId="' + td.value.hidId + '"rowIndex="' + td.rowIndex + '"title="' + "用户自定义策略：" +arr[2]+ '"></span>';
                    return profile;
                }
                if ("CustomizeProfile" == arr[0]) {
                    profile = '<span whichCol="individuation" isMenu="true" class="ico ico-individuation" id="' + arr[0] + '" profileId="' + arr[1] + '"instanceId="' + td.value.hidId + '"rowIndex="' + td.rowIndex + '"title="' + "个性化监控设置" + '"></span>';
                    return profile;
                }
                profile = '<span class="" id="" rowIndex="' + td.rowIndex + '">-</span>';
                return profile;
            }
        }
    }];
    if ("networkdevice" == whichGrid) {
        renderGrid.push({
            index: "interface",
            fn: function(td) {
                if (td.html != "") {
                    return  '<span class="ico ico-interface" whichCol="interface" isMenu="false" instanceId="' + td.value.hidId + '"rowIndex="' + td.rowIndex + '"title="' + "点击查看接口信息" + '"></span>';
                }
            }
        });
        renderGrid.push({
            index: "back",
            fn: function(td) {
                if (td.html != "") {
                    return '<span whichCol="backPlane" isMenu="false" title="点击查看背板信息" class="ico ico-backplane" instanceId ="' + td.value.hidId + '" nodeId = "'+td.html+'"></span>';
                }
            }
        });
    }
    if ("resourceGroup" == whichGrid) {
        renderGrid.push({
            index: "visual",
            fn: function(td) {
                if (td.html != "") {
                	var hidVisual = td.value.hidVisual;
                    if ( hidVisual && hidVisual != "-") {
                        var vm = '<span whichCol="vm" isMenu="false" class="ico ico-vm" title="点击查看VM" instanceId="'+td.value.hidId+'" vmPath="'+hidVisual+'"/></span>';
                        return vm;
                    } else {
                        return null;
                    }
                } else {
                    return null;
                }
            }
        });
    }
    if ("application" == whichGrid) {
        renderGrid.push({
            index: "Action",
            fn: function(td) {
                if (td.html != "") { 
                    var action = '<span whichCol="action" isMenu="true" class="ico ico-usedaction" instanceId ="'+td.value.hidId+'"></span>';
                    return action;
                }
            }
        });
    }
    if ("host" == whichGrid) {
        renderGrid.push({
            index: "visual",
            fn: function(td) {
                if (td.html != "") {
                	var hidVisual = td.value.hidVisual;
                    if ( hidVisual && hidVisual != "-") {
                        var vm = '<span whichCol="vm" isMenu="false" class="ico ico-vm"  title="点击查看VM" instanceId="'+td.value.hidId+'" vmPath="'+hidVisual+'"/></span>';
                        return vm;
                    } else {
                        return null;
                    }
                } else {
                    return null;
                }
            }
        });
        renderGrid.push({
            index: "Action",
            fn: function(td) {
                if (td.html != "") {
                    var action = '<span whichCol="action" isMenu="true" class="ico ico-usedaction" instanceId ="'+td.value.hidId+'"></span>';
                    return action;
                }
            }
        });
    }
    this.gridMonitor.rend(renderGrid);
    Monitor.Resource.right.monitorList.ListMenu.init(whichTree, whichGrid, "monitor");
    var p = $("#monitorOperate");
    var position = p.position();
    if ("group" == isGroup) {
        $("#shiftinGroup").bind('click',function(e) {
            if (!pointId || pointId == null || pointId == "") {
                var _information = Monitor.Resource.infomation;
                _information.setContentText("请创建一个资源组。"); //提示框 
                _information.show();
                return;
            }
            winOpen({
                url: path + '/monitor/resourceGroup!standbyResource.action?resourceGroupId=' + Monitor.Resource.right.monitorList.pointId + "&currentUserId=" + userId,
                width: 830,
                height: 670,
                name: 'addResource'
            });
        });
        $("#shiftOutGroup").bind('click',function(e) {
            var tmp = "";
            $("input[name='checkOneMonitor']").each(function() {
                if ($(this).attr("checked") == true) {
                    tmp += "&resourceInsId=" + $(this).val();
                }
            });
            if (tmp != "" && Monitor.Resource.right.monitorList.pointId && Monitor.Resource.right.monitorList.pointId != "" && Monitor.Resource.right.monitorList.pointId != null) {
                $.blockUI({message: $('#monitorListLoading')});
                $.ajax({
                    type: "POST",
                    dataType: 'json',
                    timeout : 60000,
                    url: path + "/monitor/monitorAjaxList!explantResourceGroup.action?" + tmp + param,
                    success: function(data, textStatus) {
                        Monitor.refresh("/monitor/monitorList.action");
                        $.unblockUI();
                    },error: function() {
                        $.unblockUI();
                         var _information = Monitor.Resource.infomation;
                        _information.setContentText("系统异常，请联系系统管理员。"); //提示框 
                        _information.show();
                    }
                });
            } else {
                var _information = Monitor.Resource.infomation;
                _information.setContentText("请选择一条数据。"); //提示框 
                _information.show();
            }
        });
    }
    $("#refresh").bind('click',function(e) {
        $("#submitForm").attr('action', path + "/monitor/monitorList.action");
        $("#submitForm").submit();
    });
    if($("#domain")[0]){
    	 $("#domain").bind('change',function(e) {
              Monitor.Resource.right.monitorList.withoutSearch = "false";
          });
    }
   if($("#domainSearch")[0]){
    	 $("#domainSearch").bind('change',function(e) {
              Monitor.Resource.right.monitorList.withoutSearch = "false";
          });
    }
    p.bind('click',function(e) {
        var icoId = $(this).attr("id");
        var offset = $(this).offset();
        var disable = false;
        if(isSystemAdmin == true){
        	disable = true;
        }else{
              if(whichTree != "searchResource"){
                 if($("#domain")[0].options.length == 1){
                 	if(isConfigMgrRole == true){
                       disable = true;
                 	}
                 }else{
                     if($("#domain").val() != "" && Monitor.Resource.right.monitorList.withoutSearch == "true"){
                            disable = true;
                     }
                 }
              }else{
                  if($("#domainSearch")[0].options.length == 1){
                    if(isConfigMgrRole == true){
                       disable = true;
                 	}
                  }else{
                     if($("#domainSearch").val() != "" && Monitor.Resource.right.monitorList.withoutSearch == "true"){
                     	   disable = true;
                     }
                  }
             }
        }
        var menuArray = [{
            text: "加入资源组",
            id: "joinResourceGroup",
            disable: true,
            listeners: {
                click: function() {
                    if (Monitor.Resource.right.noMonitorList.paramMap) {
                        Monitor.Resource.right.noMonitorList.paramMap = null;
                    }
                    $("input[name='checkOneMonitor']").each(function() {
                        if ($(this).attr("checked") == true) {
                            Monitor.Resource.right.monitorList.paramMap.put($(this).val(), $(this));
                        }
                    });
                    var instanceIdArr = Monitor.Resource.right.monitorList.paramMap.arr;
                    if (instanceIdArr.length <= 0) {
                        var _information = Monitor.Resource.infomation;
                        _information.setContentText("请选择一条数据。"); //提示框 
                        _information.show();
                        return false;
                    }
                    winOpen({
                        url: path + '/monitor/monitorList!joinResourceGroup.action?currentUserId=' + userId,
                        width: 410,
                        height: 160,
                        name: 'joinResourceGroup'
                    });
                }
            }
        },{
            text: "取消监控",
            id: "cancelMonitor",
            disable: disable,
            listeners: {
                click: function() {
                    var tmp = "";
                    $("input[name='checkOneMonitor']").each(function() {
                        if ($(this).attr("checked") == true) {
                            tmp += "&resourceInsId=" + $(this).val();
                        }
                    });
                    if (tmp != "") {
                        var _confirm = Monitor.Resource.confirm;
                        _confirm.setContentText("您确定要取消监控所选资源吗？"); //也可以在使用的时候传入
                        _confirm.setSubTipText("");
                        _confirm.setConfirm_listener(function() {
                            $.blockUI({message: $('#monitorListLoading')});
                            _confirm.hide();
                            $.ajax({
                                type: "POST",
                                dataType: 'json',
                                timeout : 60000,
                                url: path + "/monitor/monitorAjaxList!stopMonitor.action?" + tmp,
                                success: function(data, textStatus) {
                                    if (data.deleteRes == "true") {
                                        var _information = Monitor.Resource.infomation;
                                        _information.setContentText("取消监控成功。"); //提示框
                                        _information.show();
                                        if("searchResource" == whichTree ){
                                        	 searchResource("searchResourceTree",'noMonitor')
                                        }else{
                                             $("#monitor").val("noMonitor");
                                             $("#submitForm").attr('action', path + "/monitor/monitorList.action");
                                             $("#submitForm").submit();
                                        }
                                    } else {
                                        $("#delResultForm #delResult").val(data.delResult);
                                        $("#delResultForm").attr('action', path + "/monitor/monitorList!delResult.action?whatOperate=stopMonitor");
                                        $("#delResultForm").submit();
                                    }
                                    $.unblockUI();
                                },error: function() {
                                    $.unblockUI();
                                    var _information = Monitor.Resource.infomation;
                                    _information.setContentText("系统异常，请联系系统管理员。"); //提示框 
                                    _information.show();
                                }
                            });
                        });
                        _confirm.show();
                    } else {
                        var _information = Monitor.Resource.infomation;
                        _information.setContentText("请选择一条数据。"); //提示框 
                        _information.show();
                        return false;
                    }
                }
            }
        },{
            text: "删除",
            id: "deleteResource",
            disable: disable,
            listeners: {
                click: function() {
                    var tmp = "";
                    $("input[name='checkOneMonitor']").each(function() {
                        if ($(this).attr("checked") == true) {
                            tmp += "&resourceInsId=" + $(this).val();
                        }
                    });
                    if (tmp != "") {
                        var _confirm = Monitor.Resource.confirm;
                        _confirm.setContentText("此操作不可恢复，是否确认执行此操作？"); //也可以在使用的时候传入
                        _confirm.setSubTipText("删除操作不影响其他使用此资源的模块，例如业务服务、网络拓扑等。");
                        _confirm.setConfirm_listener(function() {
                            $.blockUI({message: $('#monitorListLoading')});
                            _confirm.hide();
                            $.ajax({
                                type: "POST",
                                dataType: 'json',
                                timeout : 60000,
                                url: path + "/monitor/monitorAjaxList!delResource.action?" + tmp,
                                success: function(data, textStatus) {
                                    if (data.deleteRes == "true") {
                                        Monitor.Resource.toast.addMessage("操作成功。");
                                        if("searchResource" == whichTree ){
                                        	 searchResource("searchResourceTree",'monitor')
                                        }else{
                                             $("#monitor").val("monitor");
                                             $("#submitForm").attr('action', path + "/monitor/monitorList.action");
                                             $("#submitForm").submit();
                                        }
                                    } else {
                                        $("#delResultForm #delResult").val(data.delResult);
                                        $("#delResultForm").attr('action', path + "/monitor/monitorList!delResult.action?whatOperate=delResource");
                                        $("#delResultForm").submit();
                                    }
                                    $.unblockUI();
                                },error: function() {
                                    $.unblockUI();
                                    var _information = Monitor.Resource.infomation;
                                    _information.setContentText("系统异常，请联系系统管理员。"); //提示框 
                                    _information.show();
                                }
                            });
                        });
                        _confirm.show();
                    } else {
                        var _information = Monitor.Resource.infomation;
                        _information.setContentText("请选择一条数据。"); //提示框 
                        _information.show();
                        return false;
                    }
                }
            }
        }];
        if (whichTree != 'application' && "resourceGroup" != whichGrid && "searchResource" != whichTree) {
            menuArray.push({
                text: "变更设备类型",
                disable: disable,
                id: "change_type",
                listeners: {
                    click: function() {
                        var tmp = "";
                        $("input[name='checkOneMonitor']").each(function() {
                            if ($(this).attr("checked") == true) {
                                tmp += $(this).val() + ",";
                            }
                        });
                        if (tmp == "") {
                            var _information = Monitor.Resource.infomation;
                            _information.setContentText("请选择一条数据。"); //提示框 
                            _information.show();
                            return false;
                        }
                        $("#operateForm #instanceId").val(tmp);
                        $("#operateForm").attr('action', path + "/discovery/resource-instance-batchchange.action");
                        $("#operateForm").submit();
                    }
                }
            });
        }
        Monitor.Resource.menu.addMenuItems([menuArray]);
        Monitor.Resource.menu.position(offset.left, offset.top + $(this).height());
    });
    this.page = new Pagination({
        applyId: "pageMonitor",
        listeners: {
            pageClick: function(page) {
                var search = "";
                var domain = "";
                if (whichTree == "searchResource") {
                    search = $.trim($("#searchSearch").val());
                    if (search == '请输入条件搜索') {
                        search = "";
                    }
                    domain = $.trim($("#domainSearch").val());
                    if (domain == '请选择域') {
                        domain = "";
                    }
                } else {
                    search = $.trim($("#searchMonitor").val());
                    if (search == '请输入条件搜索') {
                        search = "";
                    }
                    domain = $.trim($("#domain").val());
                    if (domain == '请选择域') {
                        domain = "";
                    }
                }
                $.blockUI({message: $('#monitorListLoading')});
                $.ajax({
                    type: "POST",
                    dataType: 'json',
                    timeout : 60000,
                    url: path + "/monitor/monitorAjaxList!monitorGrid.action?" + encodeURI(param + "&currentPage=" + page + "&searchWhat=" + $("#searchWhat").val() + "&search=" + search + "&sort=" + sortType + "&sortCol=" + sortColId + "&currentUserId=" + userId + "&domain=" + domain + "&whichState=" + whichState),
                    success: function(data, textStatus) {
                        $("#tableMonitor input[name='checkAll']").attr("checked", false);
                        $("#tableMonitor input[name='checkOneMonitor']").each(function() {
                            $(this).attr("checked", false);
                        });
                        self.gridMonitor.loadGridData(data.gridJson);
                        Monitor.Resource.right.monitorList.ListMenu.init(whichTree, whichGrid, "monitor");
                        SimpleBox.renderAll();
                        $.unblockUI();
                    },error: function() {
                        $.unblockUI();
                         var _information = Monitor.Resource.infomation;
                         _information.setContentText("系统异常，请联系系统管理员。"); //提示框 
                         _information.show()
                    }
                });
            }
        }
    });
    self.page.pageing(Monitor.Resource.right.monitorList.pageCount, 1);
    if ("search" != isSearch) {
        $("#searchMonitorBut").bind("click",function(event) {
            if ($("#lampDiv .lamp-on")) {
                $("#lampDiv .lamp-on").removeClass("lamp-on");
            }
            $("#searchMonitor").val($.trim($("#searchMonitor").val()));
            $.blockUI({message: $('#monitorListLoading')});
            var val = $("#searchMonitor").val();
            if (val == '请输入条件搜索') {
                val = "";
            }
            $.ajax({
                type: "POST",
                dataType: 'json',
                timeout : 60000,
                url: path + "/monitor/monitorAjaxList!monitorGrid.action?" + encodeURI(param + "&searchWhat=" + $("#searchWhat").val() + "&search=" + val + "&currentUserId=" + userId + "&domain=" + $("#domain").val()),
                success: function(data, textStatus) {
                    self.gridMonitor.loadGridData(data.gridJson);
                    Monitor.Resource.right.monitorList.ListMenu.init(whichTree, whichGrid, "monitor");
                    Monitor.Resource.right.monitorList.withoutSearch = data.withoutSearch;
                    self.page.pageing(data.pageCount, 1);
                    SimpleBox.renderAll();
                    $.unblockUI();
                },error: function() {
                    $.unblockUI();
                     var _information = Monitor.Resource.infomation;
                     _information.setContentText("系统异常，请联系系统管理员。"); //提示框 
                     _information.show();
                }
            });
        });
        var $searchText = $("#searchMonitor");
        $searchText.bind("focus",function(event) {
            $searchText.removeClass();
            if ($searchText.val() == "请输入条件搜索") {
                $searchText.val("");
            }
        });
        $searchText.bind("blur",function(event) {
            var c = $searchText.val();
            if (c == null || c == '') {
                $searchText.val("请输入条件搜索");
                $searchText.addClass('inputoff');
            }
        });
        $searchText.bind("keydown", function(event) {
            var evt = window.event ? window.event: evt;
            if (evt.keyCode == 13) {
                if ($("#lampDiv .lamp-on")) {
                    $("#lampDiv .lamp-on").removeClass("lamp-on");
                }
                $("#searchMonitor").val($.trim($("#searchMonitor").val()));
                var val = $("#searchMonitor").val();
                if (val == '请输入条件搜索') {
                    val = "";
                }
                $.blockUI({message: $('#monitorListLoading')});
                $.ajax({
                    type: "POST",
                    dataType: 'json',
                    timeout : 60000,
                    url: path + "/monitor/monitorAjaxList!monitorGrid.action?" + encodeURI(param + "&searchWhat=" + $("#searchWhat").val() + "&search=" + val + "&currentUserId=" + userId + "&domain=" + $("#domain").val()),
                    success: function(data, textStatus) {
                        self.gridMonitor.loadGridData(data.gridJson);
                        Monitor.Resource.right.monitorList.ListMenu.init(whichTree, whichGrid, "monitor");
                        self.page.pageing(data.pageCount, 1);
                        SimpleBox.renderAll();
                        $.unblockUI();
                    },error: function() {
                        $.unblockUI();
                        var _information = Monitor.Resource.infomation;
                        _information.setContentText("系统异常，请联系系统管理员。"); //提示框 
                        _information.show()
                    }
                });
            }
        });
        $("#lampDiv span[whichState]").bind("mouseover",function(event) {
            var lampPanelStr = "";
            var whichState = $(this).attr("whichState");
            if (whichState && whichState != "" && whichState != null) {
                if ("gray" == whichState) {
                    lampPanelStr = '<span class="lamp lamp-gray" ></span><span>当前资源可用性未知。</span>';
                }
                if ("green" == whichState) {
                    lampPanelStr = '<span class="lamp lamp-green" ></span><span>当前资源可用。</span>';
                }
                if ("greenblack" == whichState) {
                    lampPanelStr = '<span class="lamp lamp-greenblack" ></span><span>1.当前资源可用；2.资源或其组件配置变更。</span>';
                }
                if ("greenred" == whichState) {
                    lampPanelStr = '<span class="lampshine-blackbg-ico lampshine-blackbg-ico-greenred" ></span><span>1.当前资源可用；2.资源或其组件的性能出现问题，一个或多个性能指标违反红色阈值，或某些组件不可用；3.无配置变更。</span>';
                }
                if ("alert-greenred" == whichState) {
                    lampPanelStr = '<span class="lampshine-blackbg-ico lampshine-blackbg-ico-alert-greenred" ></span><span>1.当前资源可用；2.资源或其组件的性能出现问题，一个或多个性能指标违反红色阈值，或某些组件不可用；3.资源或其组件有配置变更。</span>';
                }
                if ("greenyellow" == whichState) {
                    lampPanelStr = '<span class="lampshine-blackbg-ico lampshine-blackbg-ico-greenyellow" ></span><span>1.当前资源可用；2.资源或其组件的性能出现问题，一个或多个性能指标违反黄色阈值；3.无配置变更。</span>';
                }
                if ("alert-greenyellow" == whichState) {
                    lampPanelStr = '<span class="lampshine-blackbg-ico lampshine-blackbg-ico-alert-greenyellow" ></span><span>1.当前资源可用；2.资源或其组件的性能出现问题，一个或多个性能指标违反黄色阈值；3.资源或其组件配置变更。</span>';
                }
                if ("greengray" == whichState) {
                    lampPanelStr = '<span class="lampshine-blackbg-ico lampshine-blackbg-ico-greengray" ></span><span>1.当前资源可用；2.资源或其组件的性能出现问题，一个或多个性能指标未知；3.无配置变更。</span>';
                }
                if ("alert-greengray" == whichState) {
                    lampPanelStr = '<span class="lampshine-blackbg-ico lampshine-blackbg-ico-alert-greengray" ></span><span>1.当前资源可用；2.资源或其组件的性能出现问题，一个或多个性能指标未知；3.资源或其组件配置变更。</span>';
                }
                if ("red" == whichState) {
                    lampPanelStr = '<span class="lamp lamp-red" ></span><span>当前资源不可用。</span>';
                }
            }
            if (Monitor.Resource.right.monitorList.lampPanel == null) {
                Monitor.Resource.right.monitorList.lampPanel = new winPanel({
                    type: "POST",
                    html: lampPanelStr,
                    width: 220,
                    x: event.pageX - 20,
                    isautoclose: false,
                    y: event.pageY,
                    closeAction: "close"
                },
                {
                    winpanel_DomStruFn: "blackLayer_winpanel_DomStruFn"
                });
            }
        });
        $("#lampDiv span[whichState]").bind("mouseout",function(event) {
            if (Monitor.Resource.right.monitorList.lampPanel && Monitor.Resource.right.monitorList.lampPanel != null) {
                Monitor.Resource.right.monitorList.lampPanel.close("close");
                Monitor.Resource.right.monitorList.lampPanel = null;
            }
        });
        $("#lampDiv span[whichState]").bind("click",function(event) {
            if ($("#lampDiv .lamp-on")) {
                $("#lampDiv .lamp-on").removeClass("lamp-on");
            }
            $(this).parent().addClass("lamp-on");
            whichState = $(this).attr("whichState");
            $.blockUI({message: $('#monitorListLoading')});
            if ($("#searchMonitor")[0]) {
                $("#searchMonitor").val("");
            }
            $.ajax({
                type: "POST",
                dataType: 'json',
                timeout : 60000,
                url: path + "/monitor/monitorAjaxList!monitorGrid.action?" + encodeURI(param + "&whichState=" + whichState + "&currentUserId=" + userId),
                success: function(data, textStatus) {
                    self.gridMonitor.loadGridData(data.gridJson);
                    self.page.pageing(data.pageCount, 1);
                    Monitor.Resource.right.monitorList.ListMenu.init(whichTree, whichGrid, "monitor");
                    SimpleBox.renderAll();
                    $.unblockUI();
                },error: function() {
                    $.unblockUI();
                     var _information = Monitor.Resource.infomation;
                    _information.setContentText("系统异常，请联系系统管理员。"); //提示框 
                    _information.show();
                }
            });
        });
    }
    $("#tableMonitor input[name='checkAll']").bind("click",function(event) {
        if ($(this).attr("checked") == true) { // 全选
            $("#tableMonitor input[name='checkOneMonitor']").attr("checked", true);
        } else { // 取消全选
            $("#tableMonitor input[name='checkOneMonitor']").attr("checked", false);
        }
    });
    SimpleBox.renderAll();
    $("#monitorGrid").show();
};
Monitor.Resource.right.noMonitorList.init = function(isSearch, isGroup) {
    var self = this;
    if (isSearch == "search") {
        $("div[name='isSearch']").hide();
    } else {
        $("div[name='isSearch']").show("fast",
        function() {
            SimpleBox.renderAll();
        });
    }
    if (isGroup == "group") {
        $("div[name='groupOperate']").show("fast",
        function() {
            SimpleBox.renderAll();
        });
    } else {
        $(".groupOperate").hide();
    }
    var p2 = $("#noMonitorOperate");
    var position2 = p2.position();
    var tmpArr = [];
    var pointId = Monitor.Resource.right.noMonitorList.pointId;
    var pointLevel = Monitor.Resource.right.noMonitorList.pointLevel;
    var monitor = Monitor.Resource.right.noMonitorList.monitor;
    var whichTree = Monitor.Resource.right.noMonitorList.whichTree;
    var whichGrid = Monitor.Resource.right.noMonitorList.whichGrid;
    var currentTree = Monitor.Resource.right.noMonitorList.currentTree;
    var currentResourceTree = Monitor.Resource.right.noMonitorList.currentResourceTree;
    if (!pointId) {
        pointId = "";
    }
    if (!pointLevel) {
        pointLevel = "";
    }
    if (!monitor) {
        monitor = "";
    }
    if (!whichTree) {
        whichTree = "";
    }
    if (!whichGrid) {
        whichGrid = "";
    }
    if (!currentTree) {
        currentTree = "";
    }
    if (!currentResourceTree) {
        currentResourceTree = "";
    }
    tmpArr.push("&pointId=");
    tmpArr.push(pointId);
    tmpArr.push("&pointLevel=");
    tmpArr.push(pointLevel);
    tmpArr.push("&monitor=");
    tmpArr.push(monitor);
    tmpArr.push("&whichTree=");
    tmpArr.push(whichTree);
    tmpArr.push("&whichGrid=");
    tmpArr.push(whichGrid);
    tmpArr.push("&currentTree=");
    tmpArr.push(currentTree);
    tmpArr.push("&currentResourceTree=");
    tmpArr.push(currentResourceTree);
    var param = tmpArr.join("");
    var sortColId = "";
    var sortType = "";
    if (!$("#tableNoMonitor")[0]) {
        return;
    }
    var search = $("#searchNoMonitor").val();
    if ($("#searchNoMonitor").is(":hidden")) {
        search = $("#search").val();
    }
    if (search == '请输入条件搜索') {
        search = "";
    }
      if($("#domain")[0]){
    	 $("#domain").bind('change',function(e) {
              Monitor.Resource.right.noMonitorList.withoutSearch = "false";
          });
    }
   if($("#domainSearch")[0]){
    	 $("#domainSearch").bind('change',function(e) {
             Monitor.Resource.right.noMonitorList.withoutSearch = "false";
          });
    }
    this.gridNoMonitor = new GridPanel({
        id: "tableNoMonitor",
        columnWidth: Monitor.Resource.right.noMonitorList.widthJson,
        unit: "%",
        plugins: [SortPluginIndex],
        sortColumns: Monitor.Resource.right.noMonitorList.sortJson,
        sortLisntenr: function($sort) {
            var search = "";
            var domain = "";
            if (whichTree == "searchResource") {
                search = $.trim($("#searchNoMonitor").val());
                if (search == '请输入条件搜索') {
                    search = "";
                }
                domain = $.trim($("#domainSearch").val());
                if (domain == '请选择域') {
                    domain = "";
                }
            } else {
                search = $.trim($("#searchNoMonitor").val());
                if (search == '请输入条件搜索') {
                    search = "";
                }
                domain = $.trim($("#domain").val());
                if (domain == '请选择域') {
                    domain = "";
                }
            }
            sortColId = $sort.colId;
            sortType = $sort.sorttype;
            $.blockUI({message: $('#monitorListLoading')});
            $.ajax({
                type: "POST",
                dataType: 'json',
                timeout : 60000,
                url: path + "/monitor/monitorAjaxList!noMonitorGrid.action?" + encodeURI(param + "&currentPage=" + Monitor.Resource.right.noMonitorList.currentPage + "&searchWhat=" + $("#searchWhat").val() + "&search=" + search + "&sort=" + sortType + "&sortCol=" + sortColId + "&currentUserId=" + userId + "&domain=" + domain),
                success: function(data, textStatus) {
                    self.gridNoMonitor.loadGridData(data.gridJson);
                    Monitor.Resource.right.monitorList.ListMenu.init(whichTree, whichGrid, "nomonitor");
                    SimpleBox.renderAll();
                    $.unblockUI();
                },error: function() {
                    $.unblockUI();
                    var _information = Monitor.Resource.infomation;
                    _information.setContentText("系统异常，请联系系统管理员。"); //提示框 
                    _information.show();
                }
            });
        }
    },
    {
        gridpanel_DomStruFn: "index_gridpanel_DomStruFn",
        gridpanel_DomCtrlFn: "index_gridpanel_DomCtrlFn",
        gridpanel_ComponetFn: "index_gridpanel_ComponetFn"
    });
    this.gridNoMonitor.rend([{
        index: "id",
        fn: function(td) {
            if (td.html != "") {
                $checkbox = $('<input type="checkbox" style="cursor:pointer" name="checkOneNoMonitor" value="' + td.value.hidId + '"/>');
                return $checkbox;
            } else {
                return null;
            }
        }
    },
    {
        index: "name",
        fn: function(td) {
            var name = "";
            name = td.html;
            if (!name || name == "") {
                name = td.value.hidDiscoveryIp;
            }
            if (name && name != "") {
                $span = $('<span title="' + coder(name) + '">' + name + '</span>');
                $span.lazybind('mouseover',function(param){   
                    if (Monitor.Resource.right.resourceInfoPanel) {
                        Monitor.Resource.right.resourceInfoPanel.close("close");
                        Monitor.Resource.right.resourceInfoPanel = null;
                    }
                    if (Monitor.Resource.right.resourceInfoPanel == null) {
                        Monitor.Resource.right.resourceInfoPanel = new winPanel({
                            type: "POST",
                            url: path + "/monitor/maintainSetting!resourceInfo.action?instanceId=" + td.value.hidId,
                            width: 300,
                            x: param.event.pageX - 20,
                            isautoclose: false,
                            y: param.event.pageY + 5,
                            closeAction: "close",
                            listeners: {
                                loadAfter: function() {
                                    var documentHeight = document.body.clientHeight;
                                    var panelY = param.event.pageY + 5;
                                    if (Monitor.Resource.right.resourceInfoPanel && Monitor.Resource.right.resourceInfoPanel != null) {
                                        var panelHeight = Monitor.Resource.right.resourceInfoPanel.getHeight();
                                        if (panelHeight + panelY > documentHeight) {
                                            panelY = param.event.pageY - 5 - panelHeight;
                                        }
                                        Monitor.Resource.right.resourceInfoPanel.setY(panelY);
                                    }
                                }
                            }
                        },
                        {
                            winpanel_DomStruFn: "blackLayer_winpanel_DomStruFn"
                        });
                    }
                }, 400,'mouseout');
                $span.bind("mouseout",function(e) {
                    if (Monitor.Resource.right.resourceInfoPanel && Monitor.Resource.right.resourceInfoPanel != null) {
                        Monitor.Resource.right.resourceInfoPanel.close("close");
                        Monitor.Resource.right.resourceInfoPanel = null;
                    }
                });
                return $span;
            } else {
                return null;
            }
        }
    },
    {
        index: "vender",
        fn: function(td) {
            if (td.html != "") {
                var resourceId = td.value.hidResourceId;
                if (!resourceId && resourceId == "-" || resourceId == "" || resourceId == null) {
                    $font = $('<span title="非网管设备" class="device-ico RID_NetworkNode"/>');
                    return $font;
                }
                var title = td.value.hidResourceName;
                if (!title || title == "-" || title == null || title == "null") {
                    title = "非网管设备";
                }
                $font = $('<span class="device-ico RID_' + td.value.hidResourceId + '" title="' + title + '"/>');
                return $font;
            } else {
                return null;
            }
        }
    },
    {
        index: "IPAddress",
        fn: function(td) {
            if (td.html == "") {
                return null;
            }
            if (td.html == "-") {
                return "-";
            }
            var tmp = td.html;
            var arr = tmp.split(",");
            var length = arr.length;
            if (length <= 1) {
                return '<span>' + td.html + '</span>';
            }
            var select = '<select name="ipAddress" iconIndex="0" iconTitle="管理IP" iconClass="combox_ico_select f-absolute" style="width:117px" id="' + td.value.hidId + '">';
            for (var i = 0; i < length; i++) {
                var option = '<option>' + arr[i] + '</option>'
                select += option;
            }
            select += '</select>';
            $select = $(select);
            $select.bind("click",
            function() {});
            return $select;

        }
    },
    {
        index: "interpose",
        fn: function(td) {
            if (td.html != "") {
                if (td.value.hidLevel_1) {
                    $font = $('<span class="ico ico-t-right" instanceId="' + td.value.hidId + '" pointId="' + pointId + '"whichGrid="' + whichGrid + '"nodeId="' + td.value.hidNodeId + '" discoveryIp="' + td.value.hidDiscoveryIp + '"rowIndex="' + td.rowIndex + '" level_1="' + td.value.hidLevel_1 + '"></span>"');
                } else {
                    $font = $('<span class="ico ico-t-right" instanceId="' + td.value.hidId + '" pointId="' + pointId + '"whichGrid="' + whichGrid + '"nodeId="' + td.value.hidNodeId + '" discoveryIp="' + td.value.hidDiscoveryIp + '"rowIndex="' + td.rowIndex + '"></span>"');
                }
                return $font;
            }
        }
    }]);
    Monitor.Resource.right.monitorList.ListMenu.init(whichTree, whichGrid, "nomonitor");
    $("#tableNoMonitor input[name='checkAll']").bind("click",function(event) {
        if ($(this).attr("checked") == true) { // 全选
            $("#tableNoMonitor input[name='checkOneNoMonitor']").each(function() {
                $(this).attr("checked", true);
            });
        } else { // 取消全选
            $("#tableNoMonitor input[name='checkOneNoMonitor']").each(function() {
                $(this).attr("checked", false);
            });
        }
    });
    if ("group" == isGroup) {
        $("#shiftinGroup").bind('click',function(e) {
           if (!pointId || pointId == null || pointId == "") {
                var _information = Monitor.Resource.infomation;
                _information.setContentText("请创建一个资源组。"); //提示框 
                _information.show();
                return;
            }
            winOpen({
                url: path + '/monitor/resourceGroup!standbyResource.action?resourceGroupId=' +  Monitor.Resource.right.noMonitorList.pointId + "&currentUserId=" + userId,
                width: 830,
                height: 670,
                name: 'addResource'
            });
        });
        $("#shiftOutGroup").bind('click',function(e) {
            var tmp = "";
            $("input[name='checkOneNoMonitor']").each(function() {
                if ($(this).attr("checked") == true) {
                    tmp += "&resourceInsId=" + $(this).val();
                }
            });
            if (tmp != "" && Monitor.Resource.right.noMonitorList.pointId && Monitor.Resource.right.noMonitorList.pointId != "" && Monitor.Resource.right.noMonitorList.pointId != null) {
                $.blockUI({message: $('#monitorListLoading')});
            	$.ajax({
                    type: "POST",
                    dataType: 'json',
                    timeout : 60000,
                    url: path + "/monitor/monitorAjaxList!explantResourceGroup.action?" + tmp + param,
                    success: function(data, textStatus) {
                        Monitor.refresh("/monitor/monitorList.action");
                        $.unblockUI();
                    },error: function() {
                        $.unblockUI();
                        var _information = Monitor.Resource.infomation;
                        _information.setContentText("系统异常，请联系系统管理员。"); //提示框 
                        _information.show();
                    }
                });
            } else {
                var _information = Monitor.Resource.infomation;
                _information.setContentText("请选择一条数据。"); //提示框 
                _information.show();
                return false;
            }
        });
    }
    $("#startMonitor").bind("click",function(event) {
        var tmp = "";
        var tmpArr = [];
        $("input[name='checkOneNoMonitor']").each(function() {
            if ($(this).attr("checked") == true) {
                tmpArr.push("&resourceInsId=");
                tmpArr.push($(this).val());
            }
        });
        tmp = tmpArr.join("");
        if (tmp != "") {
            $.blockUI({message: $('#monitorListLoading')});
            $.ajax({
                type: "POST",
                dataType: 'json',
                timeout : 60000,
                url: path + "/monitor/monitorAjaxList!startMonitor.action?" + tmp,
                success: function(data, textStatus) {
                	$.unblockUI();
                    if (data.isHasDms == "false") {
                        var infomationConfig = {
                            width: 480,
                            height: 100
                        };
                        var _information = new information(infomationConfig);
                        _information.setContentText("请先初始化系统，在'系统管理->系统部署'中发现Agent并注册系统服务CMS/DCH/DMS。");
                        _information.show();
                        $("#submitForm").attr('action', path + "/monitor/monitorList.action");
                        $("#submitForm").submit();
                        return false;
                    }
                     if (data.hasLisence) {
                        var infomationConfig = {
                            width: 480,
                            height: 100
                        };
                        var _information = new information(infomationConfig);
                        _information.setContentText("产品监控的资源数量已超过限额，请联络摩卡软件获取购买支持更多数量License的信息。");
                        _information.show();
                        $("#submitForm").attr('action', path + "/monitor/monitorList.action");
                        $("#submitForm").submit();
                        return false;
                    }
                    if("searchResource" == whichTree ){
                        searchResource("searchResourceTree",'monitor')
                    }else{
                        $("#starMonitorForm #starMonitorResult").val(data.starMonitorResult);
                        $("#starMonitorForm").attr('action', path + "/monitor/monitorList!startMonitorResult.action");
                        $("#starMonitorForm").submit();
                    }
                },error: function() {
                    $.unblockUI();
                    var _information = Monitor.Resource.infomation;
                    _information.setContentText("系统异常，请联系系统管理员。"); //提示框 
                    _information.show();
                }
            });
        } else {
            //alert("请选择一条数据。");
            var _information = Monitor.Resource.infomation;
            _information.setContentText("请选择一条数据。"); //提示框 
            _information.show();
            return false;
        }
    });
    this.disable = false;
      if(isSystemAdmin == true){
        	this.disable  = true;
        }else{
              if(whichTree != "searchResource"){
                 if($("#domain")[0].options.length == 1){
                 	if(isConfigMgrRole == true){
                       this.disable  = true;
                 	}
                 }else{
                     if($("#domain").val() != "" && Monitor.Resource.right.monitorList.withoutSearch == "true"){
                        this.disable  = true;
                     }
                 }
              }else{
                  if($("#domainSearch")[0].options.length == 1){
                    if(isConfigMgrRole == true){
                       this.disable  = true;
                 	}
                  }else{
                     if($("#domainSearch").val() != "" && Monitor.Resource.right.monitorList.withoutSearch == "true"){
                           this.disable  = true;
                     }
                  }
             }
        }
    if (this.disable  == true) {
        $("#startMonitor").removeAttr("disabled");
    } else {
        $("#startMonitor").attr("disabled", "disabled");
    }
    this.page = new Pagination({
        applyId: "pageNoMonitor",
        listeners: {
            pageClick: function(currentPage) {
                var search = "";
                var domain = "";
                if (whichTree == "searchResource") {
                    search = $.trim($("#searchNoMonitor").val());
                    if (search == '请输入条件搜索') {
                        search = "";
                    }
                    domain = $.trim($("#domainSearch").val());
                    if (domain == '请选择域') {
                        domain = "";
                    }
                } else {
                    search = $.trim($("#searchMonitor").val());
                    if (search == '请输入条件搜索') {
                        search = "";
                    }
                    domain = $.trim($("#domain").val());
                    if (domain == '请选择域') {
                        domain = "";
                    }
                }
                $.blockUI({message: $('#monitorListLoading')});
                $.ajax({
                    type: "POST",
                    dataType: 'json',
                    timeout : 60000,
                    url: path + "/monitor/monitorAjaxList!noMonitorGrid.action?" + encodeURI(param + "&currentPage=" + currentPage + "&searchWhat=" + $("#searchWhat").val() + "&search=" + search + "&sort=" + sortType + "&sortCol=" + sortColId + "&currentUserId=" + userId + "&domain=" + domain),
                    success: function(data, textStatus) {
                        self.gridNoMonitor.loadGridData(data.gridJson);
                        Monitor.Resource.right.monitorList.ListMenu.init(whichTree, whichGrid, "nomonitor");
                        $("#tableNoMonitor input[name='checkAll']").attr("checked", false);
                        $("#tableNoMonitor input[name='checkOneNoMonitor']").each(function() {
                            $(this).attr("checked", false);
                        });
                        SimpleBox.renderAll();
                        $.unblockUI();
                    },error: function() {
                        $.unblockUI();
                        var _information = Monitor.Resource.infomation;
                        _information.setContentText("系统异常，请联系系统管理员。"); //提示框 
                       _information.show();
                    }
                });
            }
        }
    });
    self.page.pageing(Monitor.Resource.right.noMonitorList.pageCount, 1);
    $("#noMonitorOperate").bind('click',function(e) {
        var offset = $(this).offset();
        var icoId = $(this).attr("id");
        var mcArray = [{
            ico: "",
            text: "加入资源组",
            disable: true,
            id: "join_group",
            listeners: {
                click: function() {
                    if (Monitor.Resource.right.monitorList.paramMap) {
                        Monitor.Resource.right.monitorList.paramMap = null;
                    }
                    $("input[name='checkOneNoMonitor']").each(function() {
                        if ($(this).attr("checked") == true) {
                            Monitor.Resource.right.noMonitorList.paramMap.put($(this).val(), $(this));
                        }
                    });
                    var instanceIdArr = Monitor.Resource.right.noMonitorList.paramMap.arr;
                    if (instanceIdArr.length <= 0) {
                        var _information = Monitor.Resource.infomation;
                        _information.setContentText("请选择一条数据。"); //提示框 
                        _information.show();
                        return false;
                    }
                    winOpen({
                        url: path + '/monitor/monitorList!joinResourceGroup.action?currentUserId=' + userId,
                        width: 410,
                        height: 160,
                        name: 'joinResourceGroup'
                    });
                }
            }
        },
        {
            ico: "",
            text: "删除",
            id: "delete",
            disable: this.disable,
            listeners: {
                click: function() {
                    var tmp = "";
                    var tmpArr = [];
                    $("input[name='checkOneNoMonitor']").each(function() {
                        if ($(this).attr("checked") == true) {
                            tmpArr.push("&resourceInsId=");
                            tmpArr.push($(this).val());
                        }
                        tmp = tmpArr.join("");
                    });
                    if (tmp != "") {
                        var _confirm = Monitor.Resource.confirm;
                        _confirm.setContentText("此操作不可恢复，是否确认执行此操作？"); //也可以在使用的时候传入
                        _confirm.setSubTipText("删除操作不影响其他使用此资源的模块，例如业务服务、网络拓扑等。");
                        _confirm.setConfirm_listener(function() {
                            $.blockUI({message: $('#monitorListLoading')});
                            _confirm.hide();
                            $.ajax({
                                type: "POST",
                                dataType: 'json',
                                timeout : 60000,
                                url: path + "/monitor/monitorAjaxList!delResource.action?" + tmp,
                                success: function(data, textStatus) {
                                    if (data.deleteRes == "true") {
                                        Monitor.Resource.toast.addMessage("操作成功。");
                                        $("#monitor").val("noMonitor");
                                        $("#submitForm").attr('action', path + "/monitor/monitorList.action");
                                        $("#submitForm").submit();
                                    } else {
                                        $("#delResultForm #delResult").val(data.delResult);
                                        $("#delResultForm").attr('action', path + "/monitor/monitorList!delResult.action");
                                        $("#delResultForm").submit();
                                    }
                                    $.unblockUI();
                                },error: function() {
                                    $.unblockUI();
                                    var _information = Monitor.Resource.infomation;
                                    _information.setContentText("系统异常，请联系系统管理员。"); //提示框 
                                    _information.show();
                                }
                            });
                        });
                        _confirm.show();
                    } else {
                        var _information = Monitor.Resource.infomation;
                        _information.setContentText("请选择一条数据。"); //提示框 
                        _information.show();
                        return false;
                    }
                }
            }
        }];
        if (whichTree != 'application' && "resourceGroup" != whichGrid && "searchResource" != whichTree) {
            mcArray.push({
                text: "变更设备类型",
                id: "change_type",
                disable: this.disable,
                listeners: {
                    click: function() {
                        var tmp = "";
                        $("input[name='checkOneNoMonitor']").each(function() {
                            if ($(this).attr("checked") == true) {
                                tmp += $(this).val() + ",";
                            }
                        });
                        if (tmp == "") {
                            var _information = Monitor.Resource.infomation;
                            _information.setContentText("请选择一条数据。"); //提示框 
                            _information.show();
                            return false;
                        }
                        $("#operateForm #instanceId").val(tmp);
                        $("#operateForm").attr('action', path + "/discovery/resource-instance-batchchange.action");
                        $("#operateForm").submit();
                    }
                }
            });
        }
        Monitor.Resource.menu.addMenuItems([mcArray]);
        Monitor.Resource.menu.position(offset.left, offset.top + $(this).height());
    });
    if (isSearch != "search") {
        $("#searchNoMonitorBut").bind("click",function(event) {
            $("#searchNoMonitor").val($.trim($("#searchNoMonitor").val()));
            var val = $("#searchNoMonitor").val();
            if (val == '请输入条件搜索') {
                val = "";
            }
            $.blockUI({message: $('#monitorListLoading')});
            $.ajax({
                type: "POST",
                dataType: 'json',
                timeout : 60000,
                url: path + "/monitor/monitorAjaxList!noMonitorGrid.action?" + encodeURI(param + "&searchWhat=" + $("#searchWhat").val() + "&search=" + val + "&currentUserId=" + userId + "&domain=" + $("#domain").val()),
                success: function(data, textStatus) {
                    self.gridNoMonitor.loadGridData(data.gridJson);
                    Monitor.Resource.right.monitorList.ListMenu.init(whichTree, whichGrid, "nomonitor");
                    self.page.pageing(data.pageCount, 1);
                    Monitor.Resource.right.noMonitorList.withoutSearch = data.withoutSearch;
                    SimpleBox.renderAll();
                    $.unblockUI();
                },error: function() {
                    $.unblockUI();
                    var _information = Monitor.Resource.infomation;
                    _information.setContentText("系统异常，请联系系统管理员。"); //提示框 
                    _information.show();
                }
            });
        });
        var $searchText = $("#searchNoMonitor");
        $searchText.bind("focus",function(event) {
            $searchText.removeClass();
            if ($searchText.val() == "请输入条件搜索") {
                $searchText.val("");
            }
        });
        $searchText.bind("blur",function(event) {
            var c = $searchText.val();
            if (c == null || c == '') {
                $searchText.val("请输入条件搜索");
                $searchText.addClass('inputoff');
            }
        });
        $searchText.bind("keydown",function(event) {
            var evt = window.event ? window.event: evt;
            if (evt.keyCode == 13) {
                $("#searchNoMonitor").val($.trim($("#searchNoMonitor").val()));
                var val = $("#searchNoMonitor").val();
                if (val == '请输入条件搜索') {
                    val = "";
                }
                $.blockUI({message: $('#monitorListLoading')});
                $.ajax({
                    type: "POST",
                    dataType: 'json',
                    timeout : 60000,
                    url: path + "/monitor/monitorAjaxList!noMonitorGrid.action?" + encodeURI(param + "&searchWhat=" + $("#searchWhat").val() + "&search=" + val + "&currentUserId=" + userId + "&domain=" + $("#domain").val()),
                    success: function(data, textStatus) {
                        self.gridNoMonitor.loadGridData(data.gridJson);
                        Monitor.Resource.right.monitorList.ListMenu.init(whichTree, whichGrid, "nomonitor");
                        self.page.pageing(data.pageCount, 1);
                        SimpleBox.renderAll();
                        $.unblockUI();
                    },error: function() {
                        $.unblockUI();
                        var _information = Monitor.Resource.infomation;
                        _information.setContentText("系统异常，请联系系统管理员。"); //提示框 
                        _information.show();
                    }
                });
            }
        });
    }
    SimpleBox.renderAll();
};
Monitor.Resource.left.inner.init = function() {
    this.resourcePanel = new AccordionMenu({
        id: "resourcePanel",
        listeners: {
            expend: function(index) {
                if (index == "0") {
                	var param = "";
                    $.blockUI({message: $('#monitorListLoading')});
                    mainRightlsattr('hidden');
                    Monitor.Resource.left.group.clear();
                    $.loadPage("resourceGroupDiv", path + "/monitor/monitorList!getResourceGroupTree.action?currentUserId=" + userId + "&isAdmin=" + isAdmin, "POST", "",
                    function() {
                        SimpleBox.renderAll();
                        var tmpArr = [];
                        var pointId = Monitor.Resource.left.pointId;
                        var pointLevel = Monitor.Resource.left.pointLevel;
                        var monitor = Monitor.Resource.left.monitor;
                        var whichTree = Monitor.Resource.left.whichTree;
                        var whichGrid = Monitor.Resource.left.whichGrid;
                        var currentTree = Monitor.Resource.left.currentTree;
                        var currentResourceTree = Monitor.Resource.left.currentResourceTree;
                        var currentUserId = Monitor.Resource.left.currentUserId;
                        if (!pointId) {
                             pointId = "";
                        }
                        if (!pointLevel) {
                             pointLevel = "";
                        }
                        if (!monitor) {
                             monitor = "";
                        }
                        if (!whichTree) {
                             whichTree = "";
                        }
                        if (!whichGrid) {
                             whichGrid = "";
                        }
                        if (!currentTree) {
                             currentTree = "";
                        }
                        if (!currentResourceTree) {
                             currentResourceTree = "";
                        }
                        if (!currentUserId) {
                             currentUserId = "";
                        }
                        tmpArr.push("&pointId=");
                        tmpArr.push(pointId);
                        tmpArr.push("&pointLevel=");
                        tmpArr.push(pointLevel);
                        tmpArr.push("&monitor=");
                        tmpArr.push(monitor);
                        tmpArr.push("&whichTree=");
                        tmpArr.push(whichTree);
                        tmpArr.push("&whichGrid=");
                        tmpArr.push(whichGrid);
                        tmpArr.push("&isAdmin=");
                        tmpArr.push(isAdmin);
                        tmpArr.push("&currentUserId=");
                        tmpArr.push(currentUserId);
                        tmpArr.push("&currentResourceTree=");
                        tmpArr.push(currentResourceTree);
                        param = tmpArr.join("");
                        Monitor.Resource.left.group.init();
                        $.newLoadPage("main-right", path + "/monitor/monitorList!getMainRight.action?" + param, "POST", "",function() {
                           Monitor.Resource.right.init();
                           SimpleBox.renderAll();
                           if ("noMonitor" == Monitor.Resource.right.monitor) {
                              Monitor.Resource.right.noMonitorList.init("noSearch", "group");
                           } else {
                              Monitor.Resource.right.monitorList.init("noSearch", "group");
                           }
                           mainRightlsattr('visible');
                           $.unblockUI();
                        },"",60000,function() {$.unblockUI();});
                        //$.unblockUI();
                    });
                    return false;
                }
                if (index == "1") {
                    $.blockUI({message: $('#monitorListLoading')});
                    mainRightlsattr('hidden');
                    var eqParam = "&currentUserId=" + userId + "&isAdmin=" + isAdmin;
                    eqParam += "&pointId=" + "host" + "&pointLevel=" + "1" + "&whichTree=" + "device" + "&whichGrid=" + "host" + "&monitor=" + "monitor" + "&currentResourceTree=" + index + "&currentTree=" + 0;
                    Monitor.Resource.left.equipment.clear();
                    $.loadPage("equipmentDiv", path + "/monitor/monitorList!getEquipmentTree.action?" + eqParam, "POST", "",
                    function() {
                        Monitor.Resource.left.equipment.init();
                        //$.unblockUI();
                    });
                  //  $.blockUI({message: $('#monitorListLoading')});
                    $.loadPage("main-right", path + "/monitor/monitorList!getMainRight.action?" + eqParam, "POST", "",
                    function() {
                        Monitor.Resource.right.init();
                        SimpleBox.renderAll();
                        if ("noMonitor" == Monitor.Resource.right.monitor) {
                            Monitor.Resource.right.noMonitorList.init("noSearch", "noGroup");
                        } else {
                            Monitor.Resource.right.monitorList.init("noSearch", "noGroup");
                        }
                        mainRightlsattr('visible');
                        $.unblockUI();
                    });

                    return false;
                }
                if (index == "2") {
                    $.blockUI({message: $('#monitorListLoading')});
                    mainRightlsattr('hidden');
                    var appParam = "&currentUserId=" + userId + "&isAdmin=" + isAdmin;
                    appParam += "&pointId=" + "Database" + "&pointLevel=" + "1" + "&whichTree=" + "application" + "&whichGrid=" + "application" + "&monitor=" + "monitor" + "&currentResourceTree=" + index + "&currentTree=" + 0;
                    Monitor.Resource.left.application.clear();
                    $.loadPage("applicationDiv", path + "/monitor/monitorList!getApplicationTree.action?" + appParam, "POST", "",function() {
                        Monitor.Resource.left.application.init();
                    });
                    $.loadPage("main-right", path + "/monitor/monitorList!getMainRight.action?" + appParam, "POST", "", function() {
                        Monitor.Resource.right.init();
                        SimpleBox.renderAll();
                        if ("noMonitor" == Monitor.Resource.right.monitor) {
                            Monitor.Resource.right.noMonitorList.init("noSearch", "noGroup");
                        } else {
                            Monitor.Resource.right.monitorList.init("noSearch", "noGroup");
                        }
                        mainRightlsattr('visible');
                        $.unblockUI();
                    });
                    return false;
                }
                if (index == "3") {
                    $.blockUI({message: $('#monitorListLoading')});
                    mainRightlsattr('hidden');
                    var searchParam = "pointId=" + "&whichTree=" + "searchResource" + "&whichGrid=" + "resourceGroup" + "&monitor=" + "" + "&currentResourceTree=" + index + "&currentTree=" + 0 + "&currentUserId=" + userId + "&isAdmin=" + isAdmin;
                    Monitor.Resource.left.search.clear();
                    $.loadPage("searchResourceDiv", path + "/monitor/monitorList!getSearchResourceTree.action?" + searchParam, "POST", "",
                    function() {
                        Monitor.Resource.left.search.init();
                       // $.unblockUI();
                    });
                   // $.blockUI({message: $('#monitorListLoading')});
                    $.loadPage("main-right", path + "/monitor/monitorList!getMainRight.action?" + searchParam, "POST", "",
                    function() {
                        Monitor.Resource.right.init();
                        SimpleBox.renderAll();
                        Monitor.Resource.right.noMonitorList.init("search", "noGroup");
                        Monitor.Resource.right.monitorList.init("search", "noGroup");
                        mainRightlsattr('visible');
                        $.unblockUI();
                    });
                    return false;
                }
            }
        },
        currentIndex: 1
    },
    {
        accordionMenu_DomStruFn: "inner_accordionMenu_DomStruFn",
        accordionMenu_DomCtrlFn: "inner_accordionMenu_DomCtrlFn"
    });
};
Monitor.Resource.left.init = function() {
    var tmpArr = [];
    var pointId = Monitor.Resource.left.pointId;
    var pointLevel = Monitor.Resource.left.pointLevel;
    var monitor = Monitor.Resource.left.monitor;
    var whichTree = Monitor.Resource.left.whichTree;
    var whichGrid = Monitor.Resource.left.whichGrid;
    var currentTree = Monitor.Resource.left.currentTree;
    var currentResourceTree = Monitor.Resource.left.currentResourceTree;
    if (!pointId) {
        pointId = "";
    }
    if (!pointLevel) {
        pointLevel = "";
    }
    if (!monitor) {
        monitor = "";
    }
    if (!whichTree) {
        whichTree = "";
    }
    if (!whichGrid) {
        whichGrid = "";
    }
    if (!currentTree) {
        currentTree = "";
    }
    if (!currentResourceTree) {
        currentResourceTree = "";
    }
    tmpArr.push("&pointId=");
    tmpArr.push(pointId);
    tmpArr.push("&pointLevel=");
    tmpArr.push(pointLevel);
    tmpArr.push("&monitor=");
    tmpArr.push(monitor);
    tmpArr.push("&whichTree=");
    tmpArr.push(whichTree);
    tmpArr.push("&whichGrid=");
    tmpArr.push(whichGrid);
    tmpArr.push("&isAdmin=");
    tmpArr.push(isAdmin);
    tmpArr.push("&currentResourceTree=");
    tmpArr.push(currentResourceTree);
    var param = tmpArr.join("");
    Monitor.Resource.left.resourceOrProfile = new AccordionMenu({
        id: "resourceOrProfile",
        listeners: {
            expend: function(index) {
                if (index == "1") {
                	$.blockUI({message: $('#monitorListLoading')});
                    if (Monitor.Resource.menu) {
                        Monitor.Resource.menu.hide();
                    }
                    $.loadPage("profileDiv", path + "/monitor/monitorList!getProfileTree.action?" + "&currentTree=" + index, "POST", "",
                    function() {
                        Monitor.Resource.right.clear();
                         mainRightlsattr('hidden');
                        $.loadPage("main-right", path + "/profile/profileListQuery.action?profileDefType=SystemProfile", "POST", "",
                        function() {
                        	mainRightlsattr('visible');
                            $.unblockUI();
                        });
                    });
                }
                if (index == "0") {
                    $.blockUI({message: $('#monitorListLoading')});
                    $("#resourceDiv").find("*").unbind();
                    $("#resourceDiv").html("");
                    $.loadPage("resourceDiv", path + "/monitor/monitorList!getResourceTree.action?" + "&currentTree=" + index + "&currentUserId=" + userId, "POST", "",
                    function() {
                        Monitor.Resource.left.inner.init();
                        if (whichTree) {
                            if ("resourceGroupTree" == whichTree) {
                                Monitor.Resource.left.group.init();
                            }
                            if ("device" == whichTree) {
                                Monitor.Resource.left.equipment.init();
                            }
                            if ("application" == whichTree) {
                                Monitor.Resource.left.application.init();
                            }
                            if ("searchResource" == whichTree) {
                                Monitor.Resource.left.search.init();
                            }
                        }
                        Monitor.Resource.right.clear();
                       if (whichTree) {
                       	   var tmpArr1 = [];
                           tmpArr1.push("&pointId=");
                           tmpArr1.push(Monitor.Resource.left.pointId);
                           tmpArr1.push("&pointLevel=");
                           tmpArr1.push(Monitor.Resource.left.pointLevel);
                           tmpArr1.push("&monitor=");
                           tmpArr1.push(Monitor.Resource.left.monitor);
                           tmpArr1.push("&whichTree=");
                           tmpArr1.push(Monitor.Resource.left.whichTree);
                           tmpArr1.push("&whichGrid=");
                           tmpArr1.push(Monitor.Resource.left.whichGrid);
                           tmpArr1.push("&isAdmin=");
                           tmpArr1.push(isAdmin);
                           tmpArr1.push("&currentResourceTree=");
                           tmpArr1.push(Monitor.Resource.left.currentResourceTree);
                           var param1 = tmpArr1.join("");
                    	   mainRightlsattr('hidden');
                           $.loadPage("main-right", path + "/monitor/monitorList!getMainRight.action?" + param1 + "&currentTree=" + index + "&currentUserId=" + userId, "POST", "",
                           function() {
                               Monitor.Resource.right.init();
                               SimpleBox.renderAll();
                               if ("searchResource" == Monitor.Resource.whichTree) {
                                    Monitor.Resource.right.noMonitorList.init("search");
                                    Monitor.Resource.right.monitorList.init("search");
                               } else {
                                    Monitor.Resource.right.monitorList.init("noSearch", "noGroup");
                               }
                               mainRightlsattr('visible');
                               $.unblockUI();
                           });
                       }
                    });
                }
            }
        }
    });
   
    if(!profileCanOperate){
    	Monitor.Resource.left.resourceOrProfile.changeItemName("1","");
        Monitor.Resource.left.resourceOrProfile.unbinding("1");
    }
    
    Monitor.Resource.left.resourceOrProfile.binding({index:1,fn:function(){ 
      //$.blockUI({message: $('#monitorListLoading')});
      $.ajax({
          type: "POST",
          dataType: 'json',
          url: path + "/monitor/monitorAjaxList!judgeProfileCanOperate.action?currentUserId=" +Monitor.Resource.currentUserId,
          success: function(data, textStatus) {
               //$.unblockUI();
               var allowable = data.allowable;
               if (allowable == "false") {
                  Monitor.Resource.left.resourceOrProfile.changeItemName("1","");
                  Monitor.Resource.left.resourceOrProfile.unbinding("1");
                  //Monitor.Resource.left.resourceOrProfile.bindAnimate("0");
               }else{
                  Monitor.Resource.left.resourceOrProfile.changeItemName("1","策略");
                  Monitor.Resource.left.resourceOrProfile.bindAnimate("1");
               }
               
          },error: function() {
              //$.unblockUI();
          }
      });}});
    
    if (currentTree == 0) {
        Monitor.Resource.left.inner.init();
    }
    if (currentResourceTree == "0") {
        Monitor.Resource.left.group.init();
    }
    if (currentResourceTree == "1") {
        Monitor.Resource.left.equipment.init();
    }
    if (currentResourceTree == "2") {
        Monitor.Resource.left.application.init();
    }
    if (currentResourceTree == "3") {
        Monitor.Resource.left.search.init();
    }
};
Monitor.Resource.right.group.init = function(monitor) {
    if ("noMonitor" == monitor) {
        Monitor.Resource.right.noMonitorList.init("noSearch", "group");
    } else {
        Monitor.Resource.right.monitorList.init("noSearch", "group");
    }
};
Monitor.Resource.right.search.init = function() {
    Monitor.Resource.right.noMonitorList.init("search", "noGroup");
    Monitor.Resource.right.monitorList.init("search", "noGroup");
};
Monitor.Resource.init = function() {
	mainRightlsattr('hidden'); 
    var confirmConfig = {
        width: 480,
        height: 130
    };
    Monitor.Resource.confirm = new confirm_box(confirmConfig);
    Monitor.Resource.infomation = new information();
    if (Monitor.Resource.pageRenovate && Monitor.Resource.pageRenovate != 0) {
        setInterval("Monitor.refresh();", Monitor.Resource.pageRenovate);
    }
    Monitor.Resource.toast = new Toast({
        position: "CT"
    });
    Monitor.Resource.menu = new MenuContext({
        x: 20,
        y: 100,
        width: 150,
        plugins: [duojimnue]
    });
    Monitor.Resource.left.init();
    Monitor.Resource.right.init();
    if ("pc" == Monitor.Resource.pointId) {
        Monitor.Resource.right.pcList.init();
        mainRightlsattr('visible'); 
        return false;
    }
    if ("resourceGroupTree" == Monitor.Resource.whichTree) {
        if ("noMonitor" == Monitor.Resource.monitor) {
            Monitor.Resource.right.noMonitorList.init("noSearch", "group");
        } else {
            Monitor.Resource.right.monitorList.init("noSearch", "group");
        }
        mainRightlsattr('visible'); 
        return false;
    }
    if ("searchResource" == Monitor.Resource.whichTree) {
        Monitor.Resource.right.search.init();
        mainRightlsattr('visible'); 
        return false;
    }
    if ("noMonitor" == Monitor.Resource.monitor) {
        Monitor.Resource.right.noMonitorList.init("noSearch", "noGroup");
    } else {
        Monitor.Resource.right.monitorList.init("noSearch", "noGroup");
    }
    mainRightlsattr('visible'); 
};