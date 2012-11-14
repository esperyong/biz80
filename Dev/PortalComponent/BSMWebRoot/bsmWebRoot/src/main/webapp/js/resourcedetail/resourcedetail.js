var mc; //下拉菜单
var closeItemArray = new Array(); // 点击flash需要关闭的菜单，层等
var ResourceDetail = {};
if(!window.RD){
  window.RD = ResourceDetail;
}

var availPanel; // 可用性统计panel

$(function() {
  //SimpleBox.renderAll("popfilterdiv");
  SimpleBox.renderToUseWrap([{selectId:"ipselect",maxHeight:"170",contentId:"popfilterdiv"}]);
  // 给左侧导航菜单绑定单击事件
  $("#navigation li").bind("click",function(){
    clickNav($(this));
  });
  
  $('#relaserviceDiv div').live('click', function() {
    flashClickCallBack();
    $div = $(this);
    var url = $div.attr("relaUrl");
    if(url){
      winOpen({url:url,width:1000,height:600,name:'relaServiceDetail'});
    }
  });
  
  function clickNav($li){
    $.blockUI({message:$('#loading')});
    var instanceId = $("#instanceId").val();
    // 点击左侧导航菜单的处理方法，如果是子资源单独处理
    $("#navigation li").removeClass("selected");
    $li.addClass("selected");
    var id = $li.attr("id");
    var vars = id.split("__");
    if(vars[0]=="child"){
        //子资源单独处理
        var url = ctxpath + "/detail/childdetail.action";
        $.loadPage("content",url,"POST",{parentInstanceId:instanceId,childResourceId:vars[1]}); 
    }else{
      var url = ctxpath + "/detail/" + id + "!" + vars[0] + ".action";
      $.loadPage("content",url,"POST",{instanceId:instanceId}); 
    }
  }
  
  // 弹出菜单
  var mcConfig = {
    x : 20, y : 100, // 弹出菜单位置
    width : 130,
    listeners : {
      click : function(id){
      }
    }
  };
  mc = new MenuContext(mcConfig);
  // 为右侧功能按钮绑定单击事件
  $("span.black-btn-l").bind("click",function(){
    var $span = $(this);
    var params = $span.attr("params");
    if(!params){
      return;
    }
    var instanceId = $("#instanceId").val();
    var paramsObj = eval("(" + params + ")");
    if (paramsObj["url"]) { //-------------------------
      // url为弹出窗口
      winOpen({url:paramsObj["url"],width:paramsObj["width"],height:paramsObj["height"]});
    } else if (paramsObj["handler"]) { //-------------------------
      // handler为要处理的方法名称
      if(RD && RD.handler && RD.handler[paramsObj["handler"]]){
        RD.handler[paramsObj["handler"]].call({instanceId:instanceId});
      }else{
        var msg = "未定义handler[" + paramsObj["handler"] + "]方法";
        var _information = new information({text : msg});
        _information.show();
      }
    } else if (paramsObj["menuitem"]) { //-------------------------
      // menuitem为下拉菜单
      var items = paramsObj["menuitem"].split(",");
      var menuitems = new Array();
      for(var i in items){
        var menuitem = {};
        menuitem.ico = "";
        menuitem.id = items[i];
        menuitem.text = I18N[items[i]];
        menuitem.listeners = {};
        if(RD && RD.menuhandler && RD.menuhandler[items[i]]){
          menuitem.listeners.click = RD.menuhandler[items[i]];
        } else {
          var msg = "未定义menuhandler[" + items[i] + "]方法";
          var _information = new information({text : msg});
          _information.show();
        }
        menuitems.push(menuitem);
      }
      //操作弹出菜单
      mc.addMenuItems([menuitems]);
      var offset = $(this).offset();
      mc.position(offset.left-5,offset.top + 20);
      mc.setWidth(130);
      closeItemArray.push(mc);
    } else if (paramsObj["relaapp"]) { //-------------------------
      // relaapp为关联应用
      var items = paramsObj["relaapp"].split(",");
      var appitems = new Array();
      for(var i in items){
        var idName = items[i].split("__");
        var appitem = {};
        appitem.ico = "";
        appitem.id = idName[0];
        appitem.text = "<span class='nameelli' title='"+idName[1]+"'>"+idName[1]+"</span>";
        appitem.listeners = {};
        appitem.listeners.click = function(){
          // relaapp为关联应用
          var id = $(this).attr("id")
          var url = ctxpath + "/detail/resourcedetail.action?instanceId=" + id;
          winOpen({url:url,width:980,height:600,scrollable:false,name:'resdetail_'+id});
        };
        appitems.push(appitem);
      }
      //操作弹出菜单
      mc.addMenuItems([appitems]);
      var offset = $(this).offset();
      mc.position(offset.left - 80,offset.top + 20);
      mc.setWidth(160);
      closeItemArray.push(mc);
    } else if (paramsObj["relahost"]) { //-------------------------
      // relahost为关联主机
      var id = paramsObj["relahost"];
      var url = ctxpath + "/detail/resourcedetail.action?instanceId=" + id;
      winOpen({url:url,width:980,height:600,scrollable:false,name:'resdetail_'+id});
    } else if (paramsObj["relaservice"]) { //-------------------------
      // relaservice为关联服务
      var items = paramsObj["relaservice"].split(",");
      var serviceitems = new Array();
      for(var i in items){
        var idName = items[i].split("__");
        var serviceitem = {};
        serviceitem.ico = "";
        serviceitem.id = idName[2];//idName[2]为关联服务的url
        serviceitem.text = "<span class='nameelli' title='"+idName[1]+"'>"+idName[1]+"</span>";
        serviceitem.listeners = {};
        serviceitem.listeners.click = function(){
          var url = $(this).attr("id");
          if(url){
            winOpen({url:url,width:1000,height:600,name:'relaServiceDetail'});
          }
        };
        serviceitems.push(serviceitem);
      }
      //操作弹出菜单
      mc.addMenuItems([serviceitems]);
      var offset = $(this).offset();
      mc.position(offset.left-5,offset.top + 20);
      mc.setWidth(160);
      closeItemArray.push(mc);
    } 
  }); // end binding
  
  // 可用性统计
  $("#availPie").click(function(){
    if(!checkInstanceState()){
      return;
    }
    var instanceId = $("#instanceId").val();
    var url = ctxpath + "/detail/availstatistics.action?instanceId=" + instanceId;
    if(availPanel){
      availPanel.close();
    }
    availPanel = new winPanel({
      id : "availstatistics",
      title : I18N.detail_availstatistics, //可用性统计
      isautoclose : false,
      //tools : [],
      isDrag : true,
      isFloat : true,
      cls : "pop-div",
      x : 240,
      y : 30,
      width : 540,
    height : 500,
      listeners : {
        closeAfter : function(){
          availPanel = null;
        },
        loadAfter : function(){
          $.unblockUI();
        }
      },
      url : url
      },{
      winpanel_DomStruFn : "pop_winpanel_DomStruFn"
    });
    //availPanel.setPosition(240,30);
  });
  // 定位当前导航菜单
  if(currentNavigation){
    clickNav($("#" + currentNavigation));
  }
}); // end ready

/**
 * 下拉按钮绑定的方法，这里定义的key需要和配置文件(resourcedetail.properties)中配置的key相同 
 */
RD.menuhandler = {
  monitor : function(){
    // 个性化监控
    flashClickCallBack();
    if(!checkInstanceState()){
      return;
    }
    var instanceId = $("#instanceId").val();
    var url =  ctxpath + "/profile/customProfile/queryCustomProfile.action?instanceId=" + instanceId;
    winOpen({url:url,width:770,height:610,scrollable:true,name:'detailMonitorSetting'});
  },
  strategy : function(){
    // 选择策略
    flashClickCallBack();
    if(!checkInstanceState()){
      return;
    }
    var instanceId = $("#instanceId").val();
    var url =  ctxpath + "/monitor/monitorList!chooseProfile.action?instanceId=" + instanceId;
    winOpen({url:url,width:380,height:180,name:'detailStrategy'});
  },
  refresh : function(){
    // 刷新设备
    $.blockUI({message:$('#refreshEquipLoading')});
    flashClickCallBack();
    if(!checkInstanceState()){
      return;
    }
    var instanceId = $("#instanceId").val();
    var url = ctxpath + "/detail/detailoperate!refresh.action?instanceId=" + instanceId;
    ajaxJson(url,null,function(data){
      var refreshResult = data.refreshResult;
      if(refreshResult){
        var _information = new information({text:refreshResult});
        _information.show();
      }else{
        var _information = new information({text : I18N.detail_refreshequip_successmsg, confirm_listener : function(){
            $.blockUI({message:$('#loading')});
            _information.hide();
            window.location.href=window.location.href;
          },close_listener:function(){
            $.blockUI({message:$('#loading')});
            _information.hide();
            window.location.href=window.location.href;
          }
        });
        _information.show();
      }
    });
  },
  changetype : function(){
    // 变更设备类型
    flashClickCallBack();
    if(!checkInstanceState()){
      return;
    }
    var instanceId = $("#instanceId").val();
    var url =  ctxpath + "/discovery/resource-instance-changetype.action?instanceId=" + instanceId;
    winOpen({url:url,width:660,height:260,scrollable:true,name:'detailChangetype'});
  },
  changefindinfo : function(){
    // 变更发现信息
    flashClickCallBack();
    if(!checkInstanceState()){
      return;
    }
    var instanceId = $("#instanceId").val();
    var url =  ctxpath + "/discovery/resource-instance-editinfo.action?instanceId=" + instanceId;
    winOpen({url:url,width:605,height:295,name:'detailChangeFindInfo'});
  },
  rediscovery : function(){
    // 重新发现
    flashClickCallBack();
    if(!checkInstanceState()){
      return;
    }
    var instanceId = $("#instanceId").val();
    var url =  ctxpath + "/discovery/resource-instance-rediscovery.action?instanceId=" + instanceId;
    winOpen({url:url,width:660,height:320,scrollable:true,name:'detailRediscovery'});
  },
  diagnose : function(){
    // 诊断
    flashClickCallBack();
    if(!checkInstanceState()){
      return;
    }
    var instanceId = $("#instanceId").val();
    var url = ctxpath + "/discovery/resource-instance-diagnose!diagnose.action?instanceId=" + instanceId; 
    winOpen({url:url,width:688,height:475,scrollable:false,name:'detailDiagnose_'+instanceId});
  }
};

/**
 * 配置定义为handler的需要在这里定义它的处理方法
 */
RD.handler = {
  alarm : function(){
    // 告警
    flashClickCallBack();
    if(!checkInstanceState()){
      return;
    }
    var instanceId = $("#instanceId").val();
    var url = ctxpath + "/detail/insalarmoverview.action?resInstanceId=" + instanceId;
    winOpen({url:url,width:1000,height:600,name:'detailAlarm'});
  },
  topolocation : function(){
    // 拓扑定位
    flashClickCallBack();
    if(!checkInstanceState()){
      return;
    }
    $.blockUI({message:$('#loading')});
    var instanceId = $("#instanceId").val();
    var url = ctxpath + "/detail/detailoperate!equipment.action?instanceId=" + instanceId;
    ajaxJson(url,null,function(data){
      var nodeId = data.nodeId;
      if(nodeId){
        var instanceId = $("#instanceId").val();
        var url = "/netfocus/flash/focusonnetwork60.jsp?userid=" + userId + "&instanceId=" + instanceId;
        winOpen({url:url,width:1000,height:610,name:'detailTopolocation'});
      }else{
        var _information = new information({text : I18N.detail_topolocation_msg});
        _information.show(); 
      }
    });
  },
  equipment : function(){
    // 下联设备
    flashClickCallBack();
    if(!checkInstanceState()){
      return;
    }
    $.blockUI({message:$('#loading')});
    var instanceId = $("#instanceId").val();
    var url = ctxpath + "/detail/detailoperate!equipment.action?instanceId=" + instanceId;
    ajaxJson(url,null,function(data){
      var nodeId = data.nodeId;
      if (nodeId) {
        // 判断是否有下联设备
        var netUrl = "/netfocus/netfocus.do?action=position@isexistdowndevinfo&nodeID="+ nodeId;
        $.ajax({
          type:"POST",
          url:netUrl,
          dataType:'text',
          success:function(data1){
          if(data1){
            var obj1 = eval("(" + data1 + ")");
            if (obj1) {
             if(obj1.success){
               var equipUrl = "/netfocus/netfocus.do?action=position@getdowndevinfo&nodeID=" + nodeId;
               winOpen({url:equipUrl,width:1014,height:630,scrollable:false,name:'detailEquipment'});
             }else{
                var _information = new information({text : I18N.detail_nobottomequip_msg});
                _information.show();
             }
            } else {
              var _information = new information({text : I18N.detail_nobottomequip_msg});
              _information.show();
            }
          }else{
            var _information = new information({text : I18N.detail_nobottomequip_msg});
            _information.show();
          }
        }
        });
      } else {
        var _information = new information({text : I18N.detail_topolocation_msg});
        _information.show(); 
      }
    });
  },
  interlocal : function(){
    // 接口定位
    flashClickCallBack();
    if(!checkInstanceState()){
      return;
    }
    $.blockUI({message:$('#loading')});
    var instanceId = $("#instanceId").val();
    var url = ctxpath + "/detail/detailoperate!interlocal.action?instanceId=" + instanceId;
    ajaxJson(url,null,function(data){
      var nodeId = data.upNodeId;
      var index = data.upIndex;
      if(nodeId && index){
        var url = "/netfocus/modules/3rd/nf_for_trouble.jsp?nodeId=" + nodeId + "&ifIndex=" + index;
        winOpen({url:url,width:560,height:490,scrollable:false,name:'detailInterlocal'});
      }else{
        var url = "/netfocus/modules/3rd/nf_for_trouble.jsp?nodeId=" + nodeId + "&ifIndex=" + index;
        winOpen({url:url,width:560,height:320,scrollable:false,name:'detailInterlocal'});
      }
    });
  },
  messageboard : function(){
    // 留言板
    flashClickCallBack();
    if(!checkInstanceState()){
      return;
    }
    var instanceId = $("#instanceId").val();
    var url = ctxpath + "/detail/listinstanceremark.action?userId=" + userId +"&instanceId=" + instanceId;
    winOpen({url:url,width:820,height:560,scrollable:true,name:'detailMessageboard'});
  },
  relaservice : function(){
    // 关联服务
    flashClickCallBack();
    if(!checkInstanceState()){
      return;
    }
    $.blockUI({message:$('#loading')});
    var instanceId = $("#instanceId").val();
    var url = ctxpath + "/detail/detailoperate!relaservice.action?instanceId=" + instanceId;
    ajaxJson(url,null,function(data){
      //data.relaservice = "{relaservice:'id1__哈哈哈哈哈哈哈哈哈哈__url,id1__sdfsdfsdfdsfsdfdfasdf加上中文汉字__url,id1__中文中文加上WWWWWWWWWWWWWWWWWW__url,id1__WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW__url'}";
      if(!data.relaservice){
        var _information = new information({text : I18N.detail_relanonservice_msg});
        _information.show(); 
        return;
      }
      var relaservices = eval("(" + data.relaservice + ")");
      var items = relaservices["relaservice"].split(",");
      var html = "<div class='bold underline-gray lineheight26'>" + I18N.detail_relaservice_info + "</div>";
      if(items.length > 5){
        html += "<div id='relaserviceDiv' style='height:160px;overflow-y:auto;overflow-x:hidden;'>";
      }else{
        html += "<div id='relaserviceDiv'>";
      }
      for(var i in items){
        var idNameUrl = items[i].split("__");
        var relaId = idNameUrl[0];
        var relaName = idNameUrl[1];
        var relaUrl = idNameUrl[2];
        html += "<div class='gray-btn-singleline relanameelli' relaId='"+relaId+"' relaUrl='"+relaUrl+"' title='"+relaName+"'>"+relaName+"</div>";
      }
      html += "</div>";
      var relaservicePanel = new winPanel({
             id:"relaservicePanel",
             isautoclose:true,
             isDrag:false,
             width:240,
             x:440,
             y:200,
             html:html
         },{
        winpanel_DomStruFn:"blackLayer_winpanel_DomStruFn"
      });
      closeItemArray.push(relaservicePanel);
    });
  },
  room : function(){
    // 机房
    flashClickCallBack();
    if(!checkInstanceState()){
      return;
    }
    $.blockUI({message:$('#loading')});
    var instanceId = $("#instanceId").val();
    var url = ctxpath + "/detail/detailoperate!roomInfo.action?instanceId=" + instanceId;
    ajaxJson(url,null,function(data){
      var room = eval("(" + data.roomInfo + ")");
      var html = "<span class='bold'>机房信息</span>";
      html += "<hr width='95%' />";
      html += "<table>";
      html += "<tr><td>所在机房：</td><td>" + room.name + "</td></tr>"
      html += "<tr><td>机柜号：</td><td>" + room.jigui + "</td></tr>"
      html += "<tr><td>机框号：</td><td>" + room.jikuang + "</td></tr>"
      html += "</table>"
      var roomPanel = new winPanel({
             id:"roomPanel",
             isautoclose:true,
             isDrag:false,
             width:240,
             x:440,
             y:200,
             html:html
         },{
        winpanel_DomStruFn:"blackLayer_winpanel_DomStruFn"
      });
      closeItemArray.push(roomPanel);
    });
  },
  phylocation : function(){
    // 物理位置
    flashClickCallBack();
    if(!checkInstanceState()){
      return;
    }
    //$.blockUI({message:$('#loading')});
    var instanceId = $("#instanceId").val();
    var url = ctxpath + "/detail/detailoperate!locationInfo.action?instanceId=" + instanceId;
    winOpen({url:url,width:343,height:335,name:'toolsPhylocation'});
  },
  flowanalysis : function(){
    // 流量分析
    flashClickCallBack();
    if(!checkInstanceState()){
      return;
    }
    $.blockUI({message:$('#loading')});
    var instanceId = $("#instanceId").val();
    var url = ctxpath + "/detail/detailoperate!ntaUrl.action?instanceId=" + instanceId + "&domainId=" + domainId;
    ajaxJson(url,null,function(data){
      var ntaUrl = data.ntaUrl;
      if(ntaUrl){
        winOpen({url:ntaUrl,width:1024,height:600,scrollable:true,name:'toolsFlowanalysis'});
      }
    });
  },
  itam : function(){
    // IT资产管理
    flashClickCallBack();
    if(!checkInstanceState()){
      return;
    }
  },
  VM : function(){
    flashClickCallBack();
    if(!checkInstanceState()){
      return;
    }
    $.blockUI({message:$('#loading')});
    var instanceId = $("#instanceId").val();
    var discoveryIp = $("#discoveryIp").val();
    var url = ctxpath + "/detail/vmUrl.action?instanceId=" + instanceId + "&discoveryIp=" + discoveryIp;
    ajaxJson(url,null,function(data){
      var vmUrl = data.vmUrl;
      if(!vmUrl){
        return;
      }
      winOpen({url:vmUrl,width:1000,height:900,name:'toolsVisual'});
    });
  },
  process : function(){
    // 进程管理
    flashClickCallBack();
    if(!checkInstanceState()){
      return;
    }
    $.blockUI({message:$('#loading')});
    var instanceId = $("#instanceId").val();
    var discoveryIp = $("#discoveryIp").val();
    var url = ctxpath + "/detail/processUrl.action?instanceId=" + instanceId + "&discoveryIp=" + discoveryIp;
    ajaxJson(url,null,function(data){
      var vmUrl = data.vmUrl;
      if(!vmUrl){
        return;
      }
      winOpen({url:vmUrl,width:1000,height:900,name:'toolsProcess'});
    });
  },
  Telnet : function(){
    flashClickCallBack();
    if(!checkInstanceState()){
      return;
    }
    var discoveryIp = $("#discoveryIp").val();
    var url = "/netfocus/applet/telnetApplet.jsp?address=" + discoveryIp;
    winOpen({url:url,width:800,height:600,name:'toolsTelnet'});
  },
  MIB : function(){
    flashClickCallBack();
    if(!checkInstanceState()){
      return;
    }
    var discoveryIp = $("#discoveryIp").val();
    var url = "/netfocus/applet/MIBApplet.jsp?address=" + discoveryIp;
    winOpen({url:url,width:800,height:600,name:'toolsMIB'});
  },
  snmptest : function(){
    flashClickCallBack();
    if(!checkInstanceState()){
      return;
    }
    var discoveryIp = $("#discoveryIp").val();
    var url = "/netfocus/modules/tool/snmptest.jsp?ip=" + discoveryIp;
    winOpen({url:url,width:800,height:520,name:'toolsSnmptest'});
  },
  Ping : function(){
    flashClickCallBack();
    if(!checkInstanceState()){
      return;
    }
    var discoveryIp = $("#discoveryIp").val();
    var url = "/netfocus/modules/tool/ping_tools.jsp?ip=" + discoveryIp;
    winOpen({url:url,width:800,height:520,name:'toolsPing'});
  },
  Traceroute : function(){
    flashClickCallBack();
    if(!checkInstanceState()){
      return;
    }
    var discoveryIp = $("#discoveryIp").val();
    var url = "/netfocus/modules/tool/traceroute_tools.jsp?ip=" + discoveryIp;
    winOpen({url:url,width:800,height:520,name:'toolsTraceroute'});
  },
  remoteping : function(){
    flashClickCallBack();
    if(!checkInstanceState()){
      return;
    }
    var url = "/netfocus/modules/tool/remoteping_tools.jsp";
    winOpen({url:url,width:800,height:660,name:'toolsRemotePing'});
  },
  arptable : function(){
    flashClickCallBack();
    if(!checkInstanceState()){
      return;
    }
    var instanceId = $("#instanceId").val();
    var url = ctxpath + "/detail/arptablelist.action?instanceId=" + instanceId;
    winOpen({url:url,width:800,height:505,name:'toolsArptable'});
  },
  routertable : function(){
    flashClickCallBack();
    if(!checkInstanceState()){
      return;
    }
    var instanceId = $("#instanceId").val();
    var url = ctxpath + "/detail/routetablelist.action?instanceId=" + instanceId;
    winOpen({url:url,width:800,height:505,name:'toolsRoutertable'});
  },
  webmanager : function(){
    // Web管理
    flashClickCallBack();
    if(!checkInstanceState()){
      return;
    }
    var instanceId = $("#instanceId").val();
    var discoveryIp = $("#discoveryIp").val();
    var url = ctxpath + "/detail/detailtools!webmanager.action?instanceId=" + instanceId + "&discoveryIp=" + discoveryIp;
    winOpen({url:url,width:420,height:130,name:'toolsWebmanager'});
  },
  userenv : function(){
    // 用户环境变量
    flashClickCallBack();
    if(!checkInstanceState()){
      return;
    }
    var instanceId = $("#instanceId").val();
    var resourceId = $("#resourceId").val();
    var isAgent = false; // agent:true ,否则false
    if(resourceId.toLowerCase().indexOf("agent")!=-1){
      isAgent = true;
    }
    var url = ctxpath + "/detail/userset.action?instanceId=" + instanceId + "&isAgent=" + isAgent;
    winOpen({url:url,width:640,height:350,name:'toolsUserenv'});
  },
  netstat : function(){
    // netstat
    flashClickCallBack();
    if(!checkInstanceState()){
      return;
    }
    var instanceId = $("#instanceId").val();
    var resourceId = $("#resourceId").val();
    var mramType = "agentless"; // mramType区分两种情况：agent和agentless
    if(resourceId.toLowerCase().indexOf("agent")!=-1){
      mramType = "agent";
    }
    var url = ctxpath + "/detail/netstat.action?instanceId=" + instanceId + "&mramType=" + mramType;
    winOpen({url:url,width:920,height:705,name:'toolsNetstat'});
  }
};

// 关闭下拉菜单
function closeMenu(){
  if(mc){
    mc.hide();
  }
}

// 点击flash关闭html页面的弹出层，菜单等
function flashClickCallBack(){
  if(closeItemArray && closeItemArray.length > 0){
    var item = closeItemArray.pop();
    while(item){
      if( item.hide){
        item.hide();
      }else if(item.hidden){
        item.hidden();
      }
      item = closeItemArray.pop();
    }
  }
}

// 个性化监控设置和选择策略保存后调用
var Monitor = {};
Monitor.Resource = {};
Monitor.Resource.right = {};
Monitor.Resource.right.monitorList = {};
Monitor.Resource.right.monitorList.modiColProfile = function(){
  $.blockUI({message:$('#loading')});
  window.location.href = window.location.href;
}

// 刷新资源状态
function refreshResState(){
  var instanceId = $("#instanceId").val();
  var url = ctxpath + "/detail/resourcedetail!refreshResState.action?instanceId=" + instanceId;
  ajaxJson(url,null,function(data){
    if(data && data.state){
      //根据最新状态更改资源状态的图标
      var $stateSpan = $("#resState");
      if($stateSpan){
        $stateSpan.attr("class",data.state);
        //$stateSpan.attr("class","lampshine-blackbg-ico lampshine-blackbg-ico-greenyellow");
      }
    }
  });
}

// 检查资源状态，如果已删除或未监控，提示用户，并退出刷新监控页面
function checkInstanceState(){
  var isOk = true;
  var instanceId = $("#instanceId").val();
  var url = ctxpath + "/detail/resourcedetail!checkInstanceState.action?instanceId=" + instanceId;
  ajaxJson(url,null,function(data){
    if(data && data.result && data.result != 'null'){
      var result = data.result;
      if(result == ACTION_RESULT_NONEXIST){
        var _information = new information({text : I18N.detail_msg_resnonexistordelete, confirm_listener:closeWin, close_listener:closeWin});
        _information.show();
      }else if(result == ACTION_RESULT_NONMONITOR){
        var _information = new information({text : I18N.detail_msg_resnonmonitor, confirm_listener:closeWin, close_listener:closeWin});
        _information.show();
      }else if(result == ACTION_RESULT_NONPERMISSION){
        var _information = new information({text : I18N.detail_msg_resnonpermission, confirm_listener:closeWin, close_listener:closeWin});
        _information.show();
      }
      isOk = false;
    }
  },false,true);
  return isOk
}
function closeWin(){
  try{
    window.close();
    top.window.close();
    // 刷新父页面
    if(opener && opener.Monitor && opener.Monitor.refresh){
      opener.Monitor.refresh();
    }
  }catch(e){}
}
// ajax请求
var ajaxJson = function(url,param,callback,isAsync,notUnblock){
  if(isAsync != false){
    isAsync = true;
  }
  $.ajax({
    url:url,
    async:isAsync,
    dataType:"json",
    cache:false,
    data:param,
    type:"POST",
    success:function(data){
      callback(data);     
    },
    complete:function(){
      if(notUnblock){
      }else{
        $.unblockUI();
      }
    }
  });
}

// flash提示仪表盘可点击提示cookie
function setCookie(c_name,c_value,expiredays){
  var exdate = new Date();
  exdate.setDate(exdate.getDate() + expiredays);
  document.cookie = c_name + "=" + escape(c_value) +
  ((expiredays == null) ? "" : ";expires=" + exdate.toGMTString());
}
// 获得指定名称的cookie值
function getCookie(c_name){
  if (document.cookie.length > 0){
    var c_start = document.cookie.indexOf(c_name + "=");
    if (c_start!=-1){
      c_start = c_start + c_name.length+1 ;
      var c_end = document.cookie.indexOf(";",c_start);
      if (c_end == -1){
        c_end = document.cookie.length;
      }
      return unescape(document.cookie.substring(c_start,c_end));
    }
  }
  return "";
}

//重新发现，变更设备类型，回调方法
function refreshPage(instanceId){
  // 提示成功，刷新页面
  var toast = new Toast({position:"CT"});
  toast.addMessage(I18N.detail_operator_successmsg);
  $.blockUI({message:$('#loading')});
  window.location.href = window.location.href;
}
