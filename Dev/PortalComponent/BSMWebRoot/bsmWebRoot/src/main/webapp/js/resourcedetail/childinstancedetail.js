var tp;
$(function(){
  var tabConfig = {
      id:"instancedetailTab",
      isclear:true,
      listeners:{
        change:function(tab){
          var childInstanceId = $("#childInstanceId").val();
          if(tab.index == 1){
            //常规信息
            //conf.url,conf.type,conf.param,conf.callback
            $.blockUI({message:$('#loading')});
            var url = ctxpath + "/detail/childinstancedetail!commoninfo.action?childInstanceId="+childInstanceId;
            //tp.loadContent(tab.index,{url:url});
            tp.loadContent(tab.index,{url:url,type:"post",param:{},callback:function(){$.unblockUI();}});
          }
          if(tab.index == 2){
            //组件列表
            $.blockUI({message:$('#loading')});
            var url = ctxpath + "/detail/common__ProblemMetric!common.action?childInstance=true&instanceId="+childInstanceId;
            //tp.loadContent(tab.index,{url:url});
            tp.loadContent(tab.index,{url:url,type:"post",param:{},callback:function(){$.unblockUI();}});
          }
          if(tab.index == 3){
            //变更管理
            //conf.url,conf.type,conf.param,conf.callback
            $.blockUI({message:$('#loading')});
            var url = ctxpath + "/detail/common__ChangeManage!common.action?childInstance=true&instanceId="+childInstanceId;
            //tp.loadContent(tab.index,{url:url});
            tp.loadContent(tab.index,{url:url,type:"post",param:{},callback:function(){$.unblockUI();}});
          }
          if(tab.index == 4){
            //可用性指标
            $.blockUI({message:$('#loading')});
            var url = ctxpath + "/detail/metricinfo!availability.action?childInstance=true&instanceId="+childInstanceId;
            //tp.loadContent(tab.index,{url:url});
            tp.loadContent(tab.index,{url:url,type:"post",param:{},callback:function(){$.unblockUI();}});
          }
          if(tab.index == 5){
            //性能指标
            $.blockUI({message:$('#loading')});
            var url = ctxpath + "/detail/metricinfo!performance.action?childInstance=true&instanceId="+childInstanceId;
            //tp.loadContent(tab.index,{url:url});
            tp.loadContent(tab.index,{url:url,type:"post",param:{},callback:function(){$.unblockUI();}});
          }
          if(tab.index == 6){
            //配置指标
            $.blockUI({message:$('#loading')});
            var url = ctxpath + "/detail/metricinfo!configuration.action?childInstance=true&instanceId="+childInstanceId;
            //tp.loadContent(tab.index,{url:url});
            tp.loadContent(tab.index,{url:url,type:"post",param:{},callback:function(){$.unblockUI();}});
          }
        }
     }
  };
  //tab组件
  tp = new TabPanel(tabConfig); 

  //关闭窗口
  $("#close_button").click(function() {
    window.close();
  });
});
