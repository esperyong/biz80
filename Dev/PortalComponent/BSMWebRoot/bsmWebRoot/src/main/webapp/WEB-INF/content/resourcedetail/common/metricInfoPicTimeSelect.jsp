<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>

<div id="timeCustomDiv" style="position:absolute;width:100%;margin-top:5px;">
  <ul class="fieldlist-n">
    <li><span class="field-middle txt-white"><s:text name="detail.starttime" /></span><span class="txt-white">：</span><span><input type="text" id="startTime"  /></span></li>
    <li class="line"></li>
    <li><span class="field-middle txt-white"><s:text name="detail.endtime" /></span><span class="txt-white">：</span><span><input type="text" id="endTime"  /></span></li>
    <li class="line"></li>
    <li><span class="field-middle txt-white"><s:text name="detail.time.interval" /></span><span class="txt-white">：</span><span>
      <select id="timeInterval">
        <option value="1h"><s:text name="detail.monitor.freq" /></option>
        <option value="7d"><s:text name="detail.freq.onehour" /></option>
        <option value="14d"><s:text name="detail.freq.oneday" /></option>
      </select></span>
    </li>
    <li class="line"></li>
    <li class="last">
      <span id="alarmMgs1" class="txt-white"><s:text name="detail.metricInfoPicTimeSel.note1" /></span>
      <span id="alarmMgs2" class="txt-white" style="display:none;"><s:text name="detail.metricInfoPicTimeSel.note2" /> </span>
      <span id="alarmMgs3" class="txt-white" style="display:none;"><s:text name="detail.metricInfoPicTimeSel.note3" /></span>
    </li>
    
  </ul>
</div>

<script type="text/javascript">
$(function() {
  //初始化时间控件
  $("#startTime,#endTime").bind('focus',function(){
    WdatePicker({dateFmt:'yyyy/MM/dd HH:mm:ss'});
  });

  //
  $("#timeInterval").change(function(){
    var freq = this.value;
    if('1h' == freq){
      $("#alarmMgs1").show();
      $("#alarmMgs2,#alarmMgs3").hide();
    }else if('7d' == freq){
      $("#alarmMgs2").show();
      $("#alarmMgs1,#alarmMgs3").hide();
    }else if('14d' == freq){
      $("#alarmMgs3").show();
      $("#alarmMgs2,#alarmMgs1").hide();
    }
  });
});
</script>