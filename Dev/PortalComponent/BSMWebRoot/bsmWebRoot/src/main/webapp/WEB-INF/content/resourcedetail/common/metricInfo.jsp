<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<style type="text/css">
  span.elli-desc{width:310px;text-overflow:ellipsis;white-space:nowrap;overflow:hidden; word-spacing:normal; word-break:normal; display:block;}
</style>
<div class="right rightct" style="width:100%;height:100%;">
  <div class="table-b" style="width:100%;height:100%;">
	  <div class="table-b-top-l"><div class="table-b-top-r"><div class="table-b-top-m"></div></div></div>
	  <div class="table-b-m">
	    <div class="business-grid02-topbottom-left">
	      <div class="business-grid02-topbottom-right"></div>
	    </div>
	    <div class="business-grid02-mid">
	      <table class="business-grid02-grid">
	        <tr>
	          <td class="business-grid02-td-left bold" width="30%;">&nbsp;&nbsp;<s:text name="detail.metricdescribe" /></td>
			      <td class="business-grid02-td-right" width="70%;"><span class="elli-desc" title="<s:property value="metricBean.metricDesc" default="-" />"><s:property value="metricBean.metricDesc" default="-" /></span></td>
			    </tr>
			    <tr>
			      <td class="business-grid02-td-left bold">&nbsp;&nbsp;<s:text name="detail.confirmstatus" /></td>
			      <td class="business-grid02-td-right"><span id="stateSpan" class="<s:property value="metricBean.state" default="lamp lamp-linggrey" />" style="cursor:default;"></span></td>
			    </tr>
	        <tr>
	          <td class="business-grid02-td-left bold">&nbsp;&nbsp;<span class="lamp lamp-lingred" style="cursor:default;"></span><s:text name="detail.threshold" /></td>
	          <td class="business-grid02-td-right"><s:property value="metricBean.redValue" default="-" /><s:if test="metricBean.redValue!=null && metricBean.redValue!=''">&nbsp;<s:property value="metricBean.unit" default="" /></s:if></td>
	        </tr>
	        <tr>
	          <td class="business-grid02-td-left bold">&nbsp;&nbsp;<span class="lamp lamp-lingyellow" style="cursor:default;"></span><s:text name="detail.threshold" /></td>
	          <td class="business-grid02-td-right"><s:property value="metricBean.yellowValue" default="-" /><s:if test="metricBean.yellowValue!=null && metricBean.yellowValue!=''">&nbsp;<s:property value="metricBean.unit" default="" /></s:if></td>
	        </tr>
	        <tr>
	          <td class="business-grid02-td-left bold">&nbsp;&nbsp;<s:text name="detail.currentvalue1" /></td>
	          <td class="business-grid02-td-right"><s:property value="metricBean.currentValue" default="-" /><s:if test="metricBean.currentValue!=null && metricBean.currentValue!=''">&nbsp;<s:property value="metricBean.unit" default="" /></s:if></td>
	        </tr>
			    <tr>
			      <td class="business-grid02-td-left business-grid02-td-last bold">&nbsp;&nbsp;<s:text name="detail.typical.coltime" /></td>
			      <td class="business-grid02-td-right  business-grid02-td-last"><s:property value="metricBean.collectTime" default="-" /></td>
			    </tr>
			  </table>
	    </div>
	    <div class="business-grid02-topbottom-left">
	      <div class="business-grid02-topbottom-right"></div>
	    </div>
	  </div>
	     
	  <div class="table-b-b-l"><div class="table-b-b-r"><div class="table-b-b-m"></div></div></div>
	       
	  <div class="separated10"></div>
	  <div style="height:284px;overflow:hidden;">
	    <div class="business-grid02-topbottom"></div>
	    <div class="business-grid02-mid">
			  <div class="business-grid02-title underline-gray margin5"><span class="right vertical-middle"><s:text name="detail.unit" /><s:text name="i18n.colon" />${metricBean.unit}</span>${metricBean.metricName}</div>
			  <div class="margin5" id="toolsdiv">
			    <!-- <span class="ico ico-eyes right" id="eyes"></span> -->
					<span class="ico ico-pdf right" id="pdf"></span>
					<span class="ico ico-excel02 right" id="xls"></span>
					<span class="ico ico-clock right" id="clock" title="<s:text name="detail.userdefined.timeslot" />"></span>
					<span name="freqDiv" id="365d" class="data-l right"><span class="data-r"><span class="data-m">365d</span></span></span>
					<span name="freqDiv" id="30d" class="data-l right"><span class="data-r"><span class="data-m">30d</span></span></span>
					<span name="freqDiv" id="14d" class="data-l right"><span class="data-r"><span class="data-m">14d</span></span></span>
					<span name="freqDiv" id="7d" class="data-l right"><span class="data-r"><span class="data-m">7d</span></span></span>
					<span name="freqDiv" id="1h" class="data-on-l right"><span class="data-r"><span class="data-m">1h</span></span></span>
			    <div class="clear"></div>
        </div>
        <div class="margin5" style="height:220px;overflow:hidden;margin:0;padding:0;">
          <!-- <iframe src="${ctx}/detail/summarized.action?instanceId=${instanceId}&metricId=${metricId}" width="100%" height="100%" scrolling='no' frameborder="0"></iframe> -->
          <img id="summarizemd" src="${ctxImages}/s.gif" width="465" height="220"/>
        </div>
        <div></div>
	    </div>
	    <div class="business-grid02-topbottom"></div>
	  </div>
  </div>
</div>
<input type="hidden" id="instanceId" value="${instanceId}" />
<input type="hidden" id="metricId" value="${metricId}" />
<input type="hidden" id="freq" value="${freq}" />
<input type="hidden" id="filename" value="${fileName}" />
<input type="hidden" id="lstartTime" value="${startTime}" />
<input type="hidden" id="lendTime" value="${endTime}" />
<iframe name="downloadFrm" id="downloadFrm" width="0" height="0" style="display:none"></iframe>
<script type="text/javascript">
var clockPanel;
var autoclick = true;
function loadSumImage(url,freq){
  // 后台读取数据，生成汇总图片，返回图片路径，还有数据点
  $.ajax({
    url : url,
    dataType : "json",
    cache : false,
    type : "POST",
    success : function(data){
      var filename = data.filename;
      var startTime = data.startTime;
      var endTime = data.endTime;
      $("#summarizemd").get(0).src = "${ctx}/detail/summarized!displayImage.action?width=673&height=260&instanceId=${instanceId}&metricId=${metricId}&freq="+freq+"&fileName="+filename;
      $("#freq").val(freq);
      $("#filename").val(filename);
      $("#lstartTime").val(startTime);
      $("#lendTime").val(endTime);
      //alert("filename="+filename+",startTime="+startTime+",endTime="+endTime+",freq="+freq);
    },
    complete : function(){
      $.unblockUI();
    }
  });
}
$(function(){
  // 点击汇总频度按钮
  $("#toolsdiv span[name=freqDiv]").bind("click",function(){
    if(!autoclick){
      $.blockUI({message:$('#loading')});
    }
    autoclick = false;
    $("#toolsdiv span[name=freqDiv]").attr("class","data-l right");
    $(this).attr("class","data-on-l right");
    var freq = this.id;
    var url = "${ctx}/detail/summarized!summarized.action?width=465&height=150&instanceId=${instanceId}&metricId=${metricId}&freq=" + freq;
    loadSumImage(url,freq);
  });

  // 自定义时间段
  $("#clock").click(function(){
    var instanceId = "${instanceId}";
    var url = ctxpath + "/detail/metricinfo!timeCustom.action?instanceId=" + instanceId;
    if(clockPanel){
      clockPanel.close("close");
    }
    clockPanel = new winPanel({
      id : "timeCustom",
      title : "<s:text name="detail.custom.timeslot" />",
      isautoclose : false,
      tools : [{
        text : "<s:text name="i18n.confirm" />",
        click : function(){
           var startTime = $("#startTime").val();
           var endTime = $("#endTime").val();
           var freq = $("#timeInterval").val();
           //alert(startTime+"-"+endTime+"-"+freq);
           if(startTime!='' && endTime!='' && startTime > endTime){
             var msg = "<s:text name="detail.msg.endtimegtstarttime" />";
             var _information = new information({text : msg});
             _information.show();
             return;
           }else if(startTime == ''){
             var msg = "<s:text name="detail.msg.starttime.notempty" />";
             var _information = new information({text : msg});
             _information.show();
             return;
           }else if(endTime == ''){
             var msg = "<s:text name="detail.msg.endtime.notempty" />";
             var _information = new information({text : msg});
             _information.show();
             return;
           }
           $.blockUI({message:$('#loading')});
           var url = "${ctx}/detail/summarized!summarized.action?width=465&height=150&instanceId=${instanceId}&metricId=${metricId}&freq=" + freq + "&startTime=" + startTime + "&endTime=" + endTime;
           loadSumImage(url,freq);
           clockPanel.close("close");
          }
        },{
          text : "<s:text name="i18n.cancel" />",
          click : function(){
            clockPanel.close("close");
          }
        }
      ],
      isDrag : true,
      isFloat : true,
      cls : "pop-div",
      x : 240,
      y : 150,
      width : 440,
      height : 180,
      listeners : {
        closeAfter : function(){
          clockPanel = null;
        },
        loadAfter : function(){
          $.unblockUI();
        }
      },
      url : url
      },{
      winpanel_DomStruFn : "pop_winpanel_DomStruFn"
    });
  });

  // 导出excel,pdf文件
  $("#xls,#pdf").click(function(){
    var fileType = this.id;
    var instanceId = $("#instanceId").val();
    var metricId = $("#metricId").val();
    var freq = $("#freq").val();
    var filename = $("#filename").val();
    var startTime = $("#lstartTime").val();
    var endTime = $("#lendTime").val();
    var params = "instanceId="+instanceId+"&metricId="+metricId+"&freq="+freq+"&startTime="+startTime+"&endTime="+endTime+"&fileName="+filename+"&fileType="+fileType;
    //alert(params);
    var url = path + "/detail/summarized!exportfile.action?"+params;
    document.getElementById("downloadFrm").src = url;
  });
  
  $("#1h").click();
});
</script>
