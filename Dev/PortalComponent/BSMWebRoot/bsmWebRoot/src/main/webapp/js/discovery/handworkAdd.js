$(function(){
  // 渲染所有下拉列表框
  SimpleBox.renderAll();
  
  $("#form1").validationEngine();
  
  // 定义可折叠panel组件
  var panel_disc_domain = new AccordionPanel( {
    id : "panel_disc_domain"
  });
  // 调整iframe高度，避免出现双层滚动条
  panel_disc_domain.$accBtn.click(function(){
    setTimeout(function(){resizeFrameHeight();},500);
  }); 
  var panel_disc_info = new AccordionPanel( {
    id : "panel_disc_info"
  });
  // 调整iframe高度，避免出现双层滚动条
  panel_disc_info.$accBtn.click(function(){
    setTimeout(function(){resizeFrameHeight();},500);
  }); 
  var panel_disc_addmonitor = new AccordionPanel( {
    id : "panel_disc_addmonitor"
  });
  // 调整iframe高度，避免出现双层滚动条
  panel_disc_addmonitor.$accBtn.click(function(){
    setTimeout(function(){resizeFrameHeight();},500);
  });
  
  
  $("#parentGroupId").change(function(){
    var groupId = this.value;
    var url = ctxpath + "/discovery/singletonAdd!changeCategory.action?parentGroupId=" + groupId;
    ajaxJson(url,null,function(data){
      if(data){
        // 联动子类型
        $("#groupId").empty();
        for(var i=0;i<data.length ;i++){
          var option = "<option value='"+data[i].groupId+"'>"+data[i].groupName+"</option>";
          $("#groupId").append(option);
        }
        $("#groupId").change(); // 重新渲染select组件
      }
    });
  });
  
  // 添加
  $("#addSave").click(function(){
    if(!$.validate($("#form1"),{promptPosition:"centerRight"})){
      return;
    }
    parent.setChange();
    $("#sp_disc_result").removeClass();
    $("#iframe_discovery").hide();
    startLoading();
    panel_disc_domain.collectQuick();
    panel_disc_info.collectQuick();
    panel_disc_addmonitor.expendQuick();
    //panel_disc_addmonitor.$accContent.css("height","auto");
    panel_disc_addmonitor.clearHeight();
    $("#div_disc_result").show();
    $('#compact').countdown( {
      since : 0,
      format : 'HMS',
      compact : true,
      description : ''
    });
    var formObj = document.getElementById("form1");
    formObj.action = ctxpath + "/discovery/singletonAddResult.action";
    formObj.submit();
  });
  
  /**
   * 加入监控
   */
  $("#sp_monitor").bind("click", function() {
    //$.blockUI({message:$('#loading')});
    var frm = window.frames["iframe_discovery"];
    if(!frm.checkForm()){
      return;
    }
    parent.setChange();
    // 保存属性,加入监控会刷新设备，这里保存的属性可能会冲掉
    // 所以改为加入监控之后，在保存属性,都在addMonitor方法处理
    // var result = saveInstProp(false);
    // 弹出加入监控
    var instanceId = frm.$("#instanceId").val();
    var resourceName = frm.$("#instanceName").val();
    var remark = $("#remark").val();
    var categoryGroup  = frm.$("#groupId").val();
    var data = "instanceId=" + instanceId + "&resourceName=" + resourceName + "&remark=" + remark;
    if (categoryGroup != null) {
      data = data + "&groupId=" + categoryGroup; 
    }
    var url = ctxpath + "/discovery/singletonAdd!addMonitor.action?" + data;
    winOpen({url:url,width:500,height:150,name:'singleton_monitor_result'});
  });
  
  /**
   * 继续发现
   */
  $("#sp_continue").bind("click", function() {
    var frm = window.frames["iframe_discovery"];
    if(!frm.checkForm()){
      return;
    }
    saveInstProp();
    //location.href = location.href;
    parent.$("#a_navigate_single_add").click();
    var instanceId = window.frames["iframe_discovery"].$("#instanceId").val();
    refreshMonitorPage(instanceId);
  });
  
  /**
   * 完成并退出
   */
  $("#sp_finish").bind("click", function() {
    var frm = window.frames["iframe_discovery"];
    if(!frm.checkForm()){
      return;
    }
    saveInstProp();
    var instanceId = window.frames["iframe_discovery"].$("#instanceId").val();
    refreshMonitorPage(instanceId);
    parent.window.close();
  });
  
});

var percentInterval;
function startLoading() {
  // loading image
  $("#imgLoading").attr("src", ctxpath + "/images/loading.gif");
  // discovery percent
  $("#spLoading").text("0%");
  var percent = 3;
  percentInterval = window.setInterval(function() {
    if (percent <= 99) {
      increasePercent(percent);
      percent += 3;
    }
  },1000)
}

function increasePercent(percent) {
  $("#spLoading").text(percent + "%");
}

function stopLoading() {
  $("#imgLoading").attr("src", ctxpath + "/images/loading-end.gif");
  if (percentInterval != null) {
    window.clearInterval(percentInterval);
  }
  $("#spLoading").text("100%");
}

// 保存资源属性
function saveInstProp(isSync) {
  var discFrame = window.frames["iframe_discovery"];
  var discovery_successed = discFrame.$("#discovery_successed").val();
  if (discovery_successed == "false") {
    return true;
  }
  var instanceId = discFrame.$("#instanceId").val();
  var instanceName = discFrame.$("#instanceName").val();
  var remark = $("#remark").val();
  var categoryGroup  = discFrame.$("#groupId").val();
  var result = false;
  var data = "instanceId=" + instanceId + "&instanceName=" + instanceName + "&remark=" + remark;
  if (categoryGroup != null) {
    data = data + "&categoryGroup=" + categoryGroup; 
  }
  // AJAX方式保存资源实例属性 
  $.ajax({
    async : (isSync === false) ? false : true,
    type : "post",
    url : "saveResourceProp.action",
    data : data,
    success : function(data, textStatus) {
      if (data == "success") {
        result = true; 
      } else {
        result = false;
      }
    },      
    error : function() {
      result = false;
    }
  });
  return result;
};

//ajax请求
var ajaxJson = function(url,param,callback){
  $.ajax({
    url:url,
    dataType:"json",
    cache:false,
    data:param,
    type:"POST",
    success:function(data){
      callback(data);     
    },
    complete:function(){
      //$.unblockUI();
    }
  });
};

// 继续发现，完成退出刷新监控页面
function refreshMonitorPage(instanceId) {
  if(instanceId && parent.opener.name == 'monitorList'){
    parent.opener.location.href = "/pureportal/monitor/monitorList.action?instanceId=" + instanceId;
  }
}