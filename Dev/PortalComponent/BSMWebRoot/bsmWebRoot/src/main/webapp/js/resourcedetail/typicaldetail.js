$(function() {
  // 渲染所有下拉列表框
  SimpleBox.renderAll();
  //关闭窗口
  $("#close_button,#okBtn").click(function() {
    window.close();
  });
  // 点击搜索
  $("#searchBtn").click(function(){
    submitFrm();
  });
  // 搜索输入框回车进行查询
  $("#searchVal").keydown(function(event){
    if(event.keyCode==13) {
      submitFrm();
    }
  });
  // 提交表单
  function submitFrm(){
    $.blockUI({message:$('#loading')});
    var searchFrm = $("#searchFrm").get(0);
    searchFrm.method = "POST";
    searchFrm.action = actionUrl;
    searchFrm.submit();
  }
  
  //创建分页对象
  var page = new Pagination({
    applyId : "pageid",
    listeners : {
      pageClick : function(page) {
        // page为跳转到的页数 
        $.blockUI({message:$('#loading')});
        actionUrl = actionUrl + "?currentPage=" + page;
        submitFrm();
      }
    }
  });
  page.pageing(pageCount, currentPage);
  
  // 即时状态检测
  $("span[name=statBtn]").click(function(){
    var $input = $(this);
    var instId = $input.attr("id");
    refreshResState(instId);
  });
  
  // 主资源状态灯绑定点击事件
  $("#detailTab span[name=instanceState]").click(function(){
    var $span = $(this);
    var instanceId = $span.attr("instanceId");
  });
  
  // 子节点状态灯绑定点击事件
  $("#detailTab span[name=childState]").click(function(){
    var $span = $(this);
    var instanceId = $span.attr("childId");
    
  });
  
  // 最近24小时未确认告警绑定点击事件
  $("#detailTab span[name=alarm24]").click(function(){
    var $span = $(this);
    var instanceId = $span.attr("instanceId");
  });
  
  // 可用性统计绑定点击事件
  $("#detailTab td[name=avail]").click(function(){
    var $span = $(this);
    var instanceId = $span.attr("instanceId");
    var url = ctxpath + "/detail/availstatistics!typicalAvail.action?instanceId=" + instanceId;
    winOpen({url:url,width:300,height:240,name:'availwindow'});
  });

  $.unblockUI();
}); // end ready

//刷新资源状态
function refreshResState(instanceId){
  $.blockUI({message:$('#loading')});
  var url = ctxpath + "/detail/resourcedetail!currentRealState.action?deepColor=false&instanceId=" + instanceId;
  ajaxJson(url,null,function(data){
    if(data && data.state){
      //根据最新状态更改资源状态的图标
      var $stateSpan = $("#currentState_" + instanceId);
      if($stateSpan){
        $stateSpan.attr("class",data.state);
        //$stateSpan.attr("class","lampshine-blackbg-ico lampshine-blackbg-ico-greenyellow");
      }
    }
  });
}

// ajax请求
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
      $.unblockUI();
    }
  });
}