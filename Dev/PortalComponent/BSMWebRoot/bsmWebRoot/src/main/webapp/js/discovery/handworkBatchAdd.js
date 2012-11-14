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
  var panel_disc_upload = new AccordionPanel( {
    id : "panel_disc_upload"
  });
  panel_disc_upload.$accBtn.click(function(){
    setTimeout(function(){resizeFrameHeight();},500);
  }); 
  var panel_disc_matchform = new AccordionPanel( {
    id : "panel_disc_matchform"
  });
  panel_disc_matchform.$accBtn.click(function(){
    setTimeout(function(){resizeFrameHeight();},500);
  }); 
  var panel_disc_addmonitor = new AccordionPanel( {
    id : "panel_disc_addmonitor"
  });
  panel_disc_addmonitor.$accBtn.click(function(){
    setTimeout(function(){resizeFrameHeight();},500);
  }); 
  
  // 下载导入模版
  $("#downloadId").click(function(){
    $("#uploadForm").attr("action",ctxpath + "/discovery/batchAddImport!downloadExcel.action");
    $("#uploadForm").attr("target","submitIframe");
    $("#uploadForm").submit();
  });
  
  // 上传导入模版
  $("#uploadBtn").click(function(){
    // 验证导入模版文件格式，只允许xls文件
    var upload = $("#upload").val();
    var checkResult = checkUploadFile(upload);
    if(!checkResult){
      return;
    }
    
    $.blockUI({message:$('#loading')});
    $("#uploadForm").attr("action",ctxpath + "/discovery/batchAddUpload.action");
    $("#uploadForm").attr("target","submitIframe");
    $("#uploadForm").submit();
  });
  
  // 更改开始行，重新匹配表单项
  $("#beginLine").change(function(){
    if(!$.validate($("#form1"),{promptPosition:"centerRight"})){
      return;
    }
    parent.setChange();
    var fileName = window.frames["submitIframe"].$("#uploadFileName").val();
    if(fileName){
      $.blockUI({message:$('#loading')});
      reloadDataMatch(fileName);
    }
  });
  
  // 导入
  $("#import").click(function(){
    if(!$.validate($("#form1"),{promptPosition:"centerRight"})){
      return;
    }
    
    var _confirm = new confirm_box({width:480,height:110});
    _confirm.setContentText("导入资源时，如果资源已存在做如下处理：<div style='margin-top:5px;'><input type='radio' name='updateradio' id='updateradioyes' checked />更新资源实例&nbsp;&nbsp;<input type='radio' name='updateradio' id='updateradiono' />添加资源失败</div>");
    _confirm.setSubTipText("*IP、MAC不更新，其他信息输入为空时对应信息不更新。");
    _confirm.setConfirm_listener(function() {
      _confirm.hide();
      var updateInst = $("#updateradioyes").attr("checked");
      
      parent.setChange();
      startLoading();
      $("#div_disc_result").show();
      panel_disc_domain.collectQuick();
      panel_disc_upload.collectQuick();
      panel_disc_matchform.collectQuick();
      
      $('#compact').countdown( {
        since : 0,
        format : 'HMS',
        compact : true,
        description : ''
      });
      var domainId = $("#domainId").val();
      var fileName = window.frames["submitIframe"].$("#uploadFileName").val();
      $("#form1").get(0).action = ctxpath + "/discovery/batchAddImport.action?domainId=" + domainId + "&uploadFileName=" + fileName + "&updateInst=" + updateInst;
      $("#form1").get(0).target = "iframe_discovery";
      $("#form1").get(0).submit();
    });
    _confirm.show();
  });
  
  // 终止导入
  $("#stopBtn").bind("click",function(){
    var url = ctxpath + "/discovery/batchAdd!stopImport.action";
    ajaxJson(url,null,null);
  });
  
  /**
   * 加入监控
   */
  $("#sp_monitor").bind("click", function() {
    parent.setChange();
    $.blockUI({message:$('#loading')});
    // 弹出加入监控
    window.frames["iframe_discovery"].addMonitor();
  });
  
  /**
   * 继续导入
   */
  $("#sp_continue").bind("click", function() {
    parent.$("#a_navigate_batch_add").click();
    //refreshMonitorPage();
  });
  
  /**
   * 完成并退出
   */
  $("#sp_finish").bind("click", function() {
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
  percentInterval = setInterval(function() {
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

// 
function fileIsMax(){
  $.unblockUI();
  var _information = new information({text:"上传文件大小不能超过5MB。"});
  _information.show();
}

//匹配表单项,重新加载匹配数据
function reloadDataMatch(fileName){
  var url = ctxpath + "/discovery/batchAdd!matchForm.action";
  var beginLine = $("#beginLine").val();
  var param = {"uploadFileName":fileName,"beginLine":beginLine};
  ajaxJson(url,param,function(data){
    $("#div_disc_matchform").show();
    if(data){
      clearMatchForm();
      reFillMatchForm(data,$("#name"),"设备名称");
      reFillMatchForm(data,$("#ip"),"IP地址");
      reFillMatchForm(data,$("#mac"),"MAC地址");
      reFillMatchForm(data,$("#type"),"设备类型");
      reFillMatchForm(data,$("#remark"),"备注");
      // 重新渲染下拉列表
      SimpleBox.reload(['name','ip','mac','type','remark']);
    }
  });
}

function reFillMatchForm(data,$select,matchName){
  if(!data){
    return;
  }
  var matched = false; // 是否有匹配的项目
  for(var i=0;i<data.length ;i++){
    if(data[i].value == matchName){
      matched = true;
      break;
    }
  }
  if(!matched){
    $select.append("<option value='-1' selected>--未匹配,请选择--</option>");
  }
  for(var i=0;i<data.length ;i++){
    var option;
    if(data[i].value == matchName){
      option = "<option value='"+data[i].column+"' selected>"+data[i].value+"</option>";
    }else{
      option = "<option value='"+data[i].column+"'>"+data[i].value+"</option>";
    }
    $select.append(option);
  }
}

// 清除匹配表单项
function clearMatchForm(){
  $("#name").empty();
  $("#ip").empty();
  $("#mac").empty();
  $("#type").empty();
  $("#remark").empty();
}

//ajax请求
var ajaxJson = function(url,param,callback){
  $.ajax({
    url:url,
    dataType:"json",
    cache:false,
    data:param,
    type:"POST",
    success:function(data){
      if(callback){
        callback(data);
      }
    },
    complete:function(){
      $.unblockUI();
      parent.setNotChange();
    }
  });
};

//过滤上传格式
function checkUploadFile(upload) {
  if(upload != "") {
    var subfix = upload.match(/^(.*)(\.)(.{1,8})$/)[3];
    subfix = subfix.toLowerCase();
    if(subfix != "xls") {
      // 清空file框
      var _file = document.getElementById("upload");
      if(_file.files){
          _file.value = "";
      }
      var _information = new information({text:"上传文件格式错误。"});
      _information.show();
      return false;
    }
  } else {
    var _information = new information({text:"请选择上传文件。"});
    _information.show();
    return false;
  }
  return true;
}
