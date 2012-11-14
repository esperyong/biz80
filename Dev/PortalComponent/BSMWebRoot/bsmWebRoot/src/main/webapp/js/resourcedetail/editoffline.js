$(function(){
  var $offlineType = $("input[name='offlineType']");
  var $startTime = $('#startTime');
  var $endTime = $('#endTime');
  
  $.timeEntry.setDefaults({show24Hours: true,showSeconds:true,spinnerImage: path+'/images/spinnerUpDown.png',spinnerSize: [15, 16, 0],spinnerIncDecOnly: true,useMouseWheel: false,defaultTime: '09:00:00',timeSteps: [1, 10, 0]});
  $startTime.timeEntry();
  $endTime.timeEntry();

   /*>>>>>>>>>>>>>>>>>展开收缩组件<<<<<<<<<<<<<<<<<<<<<*/
   var one = new AccordionPanel({
      id:"one"
       },{
         DomStruFn:"addsub_accordionpanel_DomStruFn",
         DomCtrlFn:"addsub_accordionpanel_DomCtrlFn"
           });
   new AccordionPanel({
      id:"two"
       },{
         DomStruFn:"addsub_accordionpanel_DomStruFn",
         DomCtrlFn:"addsub_accordionpanel_DomCtrlFn"
           });
  var index = parseInt($("input[name='array_index']").val());
  if(isNaN(index)) {index = 0;}
  
  $("#c").click(function(){
    one.expend();
  });

  /*>>>>>>>>>>>>>>>>>报警按钮<<<<<<<<<<<<<<<<<<<<<*/
  $("#confirm_button").click(function(){
    alert("confirm");
  });
  
  $("#cancel_button").click(function(){
    window.close();
  });
  
  

  /*>>>>>>>>>>>>>>>>>发送告警时间<<<<<<<<<<<<<<<<<<<<<*/
  $("#datepicker").datepicker({
    dateFormat:"yy/mm/dd",
    showOn: "button",
    buttonImage: path+"/images/ico/date.gif",
    buttonImageOnly: true,
    buttonText: "日期选择"
    //closeText:"关闭",
    //showButtonPanel:"true",
    //showWeek:"true"
  });
  
  $offlineType.click(function() {
      var offlineType = $("input[name='offlineType']:checked").attr("id");
      if(offlineType == "daliy") {
        $("#week").hide();
        $("#date").hide();
      }else if(offlineType == "weekly") {
        $("#date").hide();
        $("#week").show();
      }else if(offlineType == "fixed") {
        $("#week").hide();
        $("#date").show();
      }
  });
  
  $("#pre_left").click(function() {
    $(".addBackground").remove();
  });
  
  $("#pre_right").click(function() {
      var offlineType = $("input[name='offlineType']:checked").attr("id");
      var datepicker = $("#datepicker").val();
      if((datepicker == "") && (offlineType == "fixed")) {
      $.validationEngine.defaultSetting("#datepicker");
      $.validationEngine.loadValidation("#datepicker");
      return false;
    }
      var timeStart = $startTime.val();
      var timeEnd = $endTime.val();
      if(timeStart>=timeEnd){
        alert('timeStart > timeEnd');
        return false;
      }
      
      var offLineTime;
      var displayText;
      if(offlineType == "fixed") {
        offLineTime ="<input type=\"hidden\" name=\"commonalarmvo.offLineTime["+(index)+"].date\" value=\""+datepicker+"\"/>";
        displayText = datepicker+" "+timeStart+"-"+timeEnd;
      }else if(offlineType == "weekly") {
        offLineTime ="<input type=\"hidden\" name=\"commonalarmvo.offLineTime["+(index)+"].date\" value=\""+$("select[name=\"weekly\"]").val()+"\"/>";
        displayText = $("select[name=\"weekly\"]").find("option:selected").text()+" "+timeStart+"-"+timeEnd;;
      }else if(offlineType == "daliy") {
        var offLineTime ="<input type=\"hidden\" name=\"commonalarmvo.offLineTime["+(index)+"].date\" value=\"\"/>";
        displayText = "每天 "+timeStart+"-"+timeEnd;
      }
      
      offLineTime += "<input type=\"hidden\" name=\"commonalarmvo.offLineTime["+(index)+"].type\" value=\""+offlineType+"\"/>";
      offLineTime +="<input type=\"hidden\" name=\"commonalarmvo.offLineTime["+(index)+"].startTime\" value=\""+timeStart+"\"/>";
      offLineTime +="<input type=\"hidden\" name=\"commonalarmvo.offLineTime["+(index)+"].endTime\" value=\""+timeEnd+"\"/>";
      var offTime_Id = "addDiv"+index;
      $(".right").append("<div id='"+offTime_Id+"' class='h1' style='cursor:pointer;'>"+offLineTime+displayText+"</div>");
      $("#"+offTime_Id).click(function() {
      if($(this).hasClass("addBackground")) {
        $(this).removeClass("addBackground");
      }else {
        $(this).addClass("addBackground");
      }
      });
      index = index+1;
  });
  $("#topBtn1").click(function() {
    window.close();
  });
  
});

