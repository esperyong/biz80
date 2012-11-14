<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<style type="text/css">
  span.elli{width:100%;overflow:hidden;white-space:nowrap;text-overflow:ellipsis;}
</style>
<s:set var="INIT_METRIC_COUNT" value="%{@com.mocha.bsm.detail.business.ChildDetailMgr@INIT_METRIC_COUNT}" />
<h1 style="margin-bottom:10px;"><s:text name="detail.columncustom.note1" /><s:text name="i18n.left.bracket" /><span id="maxcol"><s:text name="detail.columncustom.note2" />${INIT_METRIC_COUNT}<s:text name="detail.columncustom.note3" /></span><s:text name="i18n.right.bracket" /><s:text name="i18n.colon" /></h1>
<div style="width:200px;height:140px;overflow:auto;border:1px solid #666;">
<ul id="metricList">
<s:iterator value="metricList" var="metric">
<li><input name="column" type="checkbox" value="<s:property value="#metric.getMetricId()"/>" <s:if test="columns.indexOf(#metric.getMetricId())!=-1">checked</s:if> /><s:property value="#metric.getMetricName()" /></li>
</s:iterator>
<li><input name="column" type="checkbox" value="profile" <s:if test="columns.indexOf('profile')!=-1">checked</s:if> /><s:text name="detail.info.strategy" /></li>
<li><input name="column" type="checkbox" value="desc" <s:if test="columns.indexOf('desc')!=-1">checked</s:if> /><s:text name="detail.info.remark" /></li>
</ul>
</div>
<div style="text-align:right;margin-top:10px;"><input type="button" id="btnOk" value="<s:text name="i18n.confirm" />" /><input type="button" id="btnCnl" value="<s:text name="i18n.cancel" />" /></div>
<script type="text/javascript">
$(function(){
  // checkbox事件
  $("#metricList input[name=column]").bind("click",function(){
    $input = $("#metricList input:checked");
    var count = $input.length;
    if(count > ${INIT_METRIC_COUNT}){
      $("#maxcol").attr("class","red");
      this.checked = false;
    }else{
      $("#maxcol").attr("class","");
    }
  });
  // 确定按钮
  $("#btnOk").bind("click",function(){
    $input = $("#metricList input:checked");
    var count = $input.length;
    if(count == 0){
      var _information = new information({text:"<s:text name="detail.msg.leastselectone" />"});
      _information.show(); 
      return;
    }
    if(count > ${INIT_METRIC_COUNT}){
      var _information = new information({text:"<s:text name="detail.msg.mostselectfive" />"});
      _information.show(); 
      return;
    }
    var checkArr = new Array();
    $input.each(function(){
      checkArr.push(this.value);
    });
    var columns = checkArr.join(",");
    //alert(columns);
    $.ajax({
      type : "post",
      url : "childdetail!saveColumnCustom.action",
      data : {parentInstanceId:"${parentInstanceId}",childResourceId:"${childResourceId}",columns:columns},
      success : function(data, textStatus) {
        if(window.selectPanel){
          selectPanel.close("close");
        }
        $("#child__${childResourceId}").click();
      },      
      error : function() {
        if(window.selectPanel){
          selectPanel.close("close");
        }
      }
    });
  });
  $("#btnCnl").bind("click",function(){
    if(selectPanel){
      selectPanel.close("close");
    }
  });
});
</script>