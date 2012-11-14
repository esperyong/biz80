var editPanel;
var selectUserPanel;
function logout() {
    window.opener = null;
    window.open("", "_self");
    window.close();
}
$(function(){
  var tabConfig = {
      id:"maintaintab",
      listeners:{
        change:function(tab){
          $(".formError").click();
          if(selectUserPanel){
            try{
              selectUserPanel.close("close");
              selectUserPanel = null;
            }catch(e){}
          }
          if(editPanel){
            try{
              editPanel.close("close");
              editPanel = null;
            }catch(e){}
          }
          var instanceId = $("#instanceId").val();
          if(tab.index == 1){
            //常规信息
            //conf.url,conf.type,conf.param,conf.callback
            //var url = path + "/monitor/maintainSetting!commoninfo.action?instanceId="+instanceId;
            //alert(url);
            //tp.loadContent(tab.index,{url:url,type:"post"});
          }
          if(tab.index == 2){
            //组件列表
            //var url = path + "/monitor/maintainSetting!componentlist.action?instanceId="+instanceId;
            //alert(url);
            //tp.loadContent(tab.index,{url:url,type:"post"});
          }
        }
     }
  };
  //tab组件
  var tp = new TabPanel(tabConfig); 

  //确定
  /*$("#confirm_button").click(function(){
    var url = path + "/monitor/maintainSetting!save.action?"+$("#form1").serialize();
			  $.ajax({
	   	            type: "POST",
	   	            dataType: 'json',
	   	            url: url,
	   	            success: function(data, textStatus) {
	   	            ///	window.opener.Monitor.Resource.right.monitorList.modiColName($("#rowIndex").val(),$("#instanceName").val());
				     //   logout();
	   	            }
	   	        });
  });*/
  //取消
  $("#cancel_button").click(function(){
    logout();
  });
  //应用
  /*$("#apply_button").click(function(){
     var url = path + "/monitor/maintainSetting!save.action?"+$("#form1").serialize();
			  $.ajax({
	   	            type: "POST",
	   	            dataType: 'json',
	   	            url: url,
	   	            success: function(data, textStatus) {
				        
	   	            }
	   	        });
  });*/
  
  //关闭窗口
  $("#close_button").click(function() {
    logout();
  });
});

