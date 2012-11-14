<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<style type="text/css">
  span.elli-name{width:<s:if test="isChildInstance()">120</s:if><s:else>90</s:else>px;text-overflow:ellipsis;white-space:nowrap;overflow:hidden; word-spacing:normal; word-break:normal; display:block;}
  span.elli-throld{width:<s:if test="isChildInstance()">80</s:if><s:else>40</s:else>px;text-overflow:ellipsis;white-space:nowrap;overflow:hidden; word-spacing:normal; word-break:normal; display:block;}
</style>
<s:if test="isChildInstance()"><div style="height:472px;overflow-x:hidden;overflow-y:auto;"></s:if>
	<s:iterator value="metricMap" status="idx">
  <s:if test="key !=null"><s:set name="groupId" value="key.getMetricGroupId()" /></s:if>
  <s:else><s:set name="groupId" value="'customGroup'" /></s:else>
	<s:if test="key !=null"><s:set name="groupName" value="key.getMetricGroupName()" /></s:if>
	<s:else><s:set name="groupName" value="'其它'" /></s:else>
	<s:set name="metricList" value="value" />
	<div style="<s:if test="isChildInstance()">width:97%;overflow-x:hidden;</s:if><s:else>width:96%;</s:else>">
	  <s:if test="#groupId!=null && #groupId!=''"><p class="rightct-h1"><span class="ico <s:if test="#idx.getIndex()>1">ico-plus</s:if><s:else>ico-minus</s:else>" divID="<s:property value="groupId" />"></span><span class="txt-white"><s:property value="groupName" /></span></p></s:if>
	  
	  <div id="<s:property value="groupId" />" style="display:<s:if test="#idx.getIndex()>1">none;</s:if>;">
	  
    <div class="business-grid02-topbottom"></div>
    <div class="business-grid02-mid">
	    <table class="business-grid02-grid" id="performTab_${groupId}" groupId="${groupId}">
	      <tr first="true">
	        <th width="15%"><s:text name="detail.metricname" /></th>
	        <th width="13%"><s:text name="detail.confirmstatus" /></th>
	        <th width="13%"><span class="lamp lamp-lingyellow" style="cursor:default;"></span><s:text name="detail.threshold" /></th>
	        <th width="13%"><span class="lamp lamp-lingred" style="cursor:default;"></span><s:text name="detail.threshold" /></th>
	        <th width="13%"><s:text name="detail.currentvalue1" /></th>
	        <th width="28%"><s:text name="detail.typical.coltime" /></th>
	      </tr>
	      <s:iterator value="#metricList" var="metricBean" status="idx">
	        <tr class="<s:if test="#idx.isEven()">business-grid02-tr-02</s:if>" <s:if test="isChildInstance()">style="cursor:pointer;"</s:if> metricId="<s:property value="#metricBean.metricId" />" metricUnit="<s:property value="#metricBean.unit" default="" />" metricName="<s:property value="#metricBean.metricName" />">
	          <td>
	           <span class="elli-name" title="<s:property value="#metricBean.metricName" default="-" /><s:if test="#metricBean.unit!=null && #metricBean.unit!=''">(<s:property value="#metricBean.unit" default="" />)</s:if>">
	             <s:property value="#metricBean.metricName" default="-" /><s:if test="#metricBean.unit!=null && #metricBean.unit!=''">(<s:property value="#metricBean.unit" default="" />)</s:if>
	           </span>
	          </td>
	          <td>&nbsp;&nbsp;&nbsp;&nbsp;<span class="<s:property value="#metricBean.state" default="lamp lamp-linggrey" />" style="cursor:default;"></span></td>
	          <td>
	            <span class="elli-throld" title="<s:property value="#metricBean.yellowValue" default="-" /><s:if test="#metricBean.yellowValue!=null && #metricBean.yellowValue!=''"><s:property value="#metricBean.unit" default="" /></s:if>">
	             <s:property value="#metricBean.yellowValue" default="-" /><s:if test="#metricBean.yellowValue!=null && #metricBean.yellowValue!=''"><s:property value="#metricBean.unit" default="" /></s:if>
	            </span>
	          </td>
	          <td>
	            <span class="elli-throld" title="<s:property value="#metricBean.redValue" default="-" /><s:if test="#metricBean.redValue!=null && #metricBean.redValue!=''"><s:property value="#metricBean.unit" default="" /></s:if>">
	              <s:property value="#metricBean.redValue" default="-" /><s:if test="#metricBean.redValue!=null && #metricBean.redValue!=''"><s:property value="#metricBean.unit" default="" /></s:if>
	            </span>
	          </td>
	          <td>
	            <span class="elli-throld" title="<s:property value="#metricBean.currentValue" default="-" /><s:if test="#metricBean.currentValue!=null && #metricBean.currentValue!=''"><s:property value="#metricBean.unit" default="" /></s:if>">
	              <s:property value="#metricBean.currentValue" default="-" /><s:if test="#metricBean.currentValue!=null && #metricBean.currentValue!=''"><s:property value="#metricBean.unit" default="" /></s:if>
	            </span>
	          </td>
	          <td><s:property value="#metricBean.collectTime" default="-" /></td>
	        </tr>
	      </s:iterator>
	    </table>
    </div>
    <div class="business-grid02-topbottom"></div>
	  
	  
	  <!-- 下部为汇总数据图表 -->
	  <s:if test="isChildInstance()">
	  <div class="separated10"></div>
	  <div style="height:384px;overflow:hidden;">
	    <div class="business-grid02-topbottom"></div>
	    <div class="business-grid02-mid">
	      <div class="business-grid02-title underline-gray margin5"><span class="right vertical-middle" id="unit_${groupId}"><s:text name="detail.unit" /><s:text name="i18n.colon" />%</span><span id="metricDesc_${groupId}"></span></div>
	      <div class="margin5" id="toolsdiv_${groupId}">
	        <!-- <span class="ico ico-eyes right" id="eyes_${groupId}"></span> -->
	        <span class="ico ico-pdf right" groupId="${groupId}" name="pdf"></span>
	        <span class="ico ico-excel02 right" groupId="${groupId}" name="xls"></span>
	        <span class="ico ico-clock right" id="clock_${groupId}" groupId="${groupId}"></span>
	        <span name="freqDiv" freq="365d" id="365d_${groupId}" groupId="${groupId}" class="data-l right"><span class="data-r"><span class="data-m">365d</span></span></span>
	        <span name="freqDiv" freq="30d" id="30d_${groupId}" groupId="${groupId}" class="data-l right"><span class="data-r"><span class="data-m">30d</span></span></span>
	        <span name="freqDiv" freq="14d" id="14d_${groupId}" groupId="${groupId}" class="data-l right"><span class="data-r"><span class="data-m">14d</span></span></span>
	        <span name="freqDiv" freq="7d" id="7d_${groupId}" groupId="${groupId}" class="data-l right"><span class="data-r"><span class="data-m">7d</span></span></span>
	        <span name="freqDiv" freq="1h" id="1h_${groupId}" groupId="${groupId}" class="data-on-l right"><span class="data-r"><span class="data-m">1h</span></span></span>
	        <div class="clear"></div>
	      </div>
	      <div class="margin5" style="height:320px;overflow:hidden;margin:0;padding:0;">
	        <img id="summarizemd_${groupId}" src="${ctxImages}/s.gif" width="673" height="320"/>
	      </div>
	      <div></div>
	    </div>
	    <div class="business-grid02-topbottom"></div>
	  </div>
	  <input type="hidden" id="currentMetricId_${groupId}" />
	  <input type="hidden" id="currentFreq_${groupId}" />
		<input type="hidden" id="currentFilename_${groupId}" />
		<input type="hidden" id="currentLstartTime_${groupId}" />
		<input type="hidden" id="currentLendTime_${groupId}" />
	  </s:if>
	  <!-- 下部为汇总数据图表 -->
	  
	  </div>
	</div>
	
	</s:iterator>
	<iframe name="downloadFrm" id="downloadFrm" width="0" height="0" style="display:none"></iframe>
<s:if test="isChildInstance()"></div></s:if>
  <script type="text/javascript">
    $(function(){
      $("p.rightct-h1 span.ico").bind("click",function(){
        var $span = $(this);
        var classVal = $span.attr("class");
        var divID = $span.attr("divID");
        if(classVal.indexOf("ico-minus") != -1){
          $span.attr("class","ico ico-plus");
          $("#"+divID).hide();
        }else{
          $span.attr("class","ico ico-minus");
          $("#"+divID).show();
        }
      });
    });

    <s:if test="isChildInstance()">

    var clockPanel;
    var autoclick = true;
    function loadSumImage(url,freq,metricId,groupId){
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
          $("#summarizemd_"+groupId).get(0).src = "${ctx}/detail/summarized!displayImage.action?width=673&height=260&instanceId=${instanceId}&metricId="+metricId+"&freq="+freq+"&fileName="+filename;
          $("#currentFreq_"+groupId).val(freq);
          $("#currentFilename_"+groupId).val(filename);
          $("#currentLstartTime_"+groupId).val(startTime);
          $("#currentLendTime_"+groupId).val(endTime);
          //alert("filename="+filename+",startTime="+startTime+",endTime="+endTime+",freq="+freq);
        },
        complete : function(){
          $.unblockUI();
        }
      });
    }
    
    //性能指标单击事件
    $("table tr").slice(1).bind("click",function(){
      //$("#performTab tr").attr("class","business-grid02-tr-02");
      var $tr = $(this);
      if($tr.attr("first")=='true'){
        return;
      }
      if(!autoclick){
        $.blockUI({message:$('#loading')});
      }
      autoclick = false;
      var table = $tr.parent().parent()[0];
      var $table = $(table);
      //alert($table.attr("id")+"=="+$table.attr("groupId"));
      var groupId = $table.attr("groupId");
      //$tr.attr("class","business-grid02-tr-02 business-grid02-tr-on");
      $("#toolsdiv_"+groupId+" span[name=freqDiv]").attr("class","data-l right");
      $("#toolsdiv_"+groupId+" span[freq=1h]").attr("class","data-on-l right");
      var metricId = $tr.attr("metricId");
      $("#currentMetricId_"+groupId).val(metricId);
      $("#currentFreq_"+groupId).val("1h");
      var metricUnit = $tr.attr("metricUnit");
      if(!metricUnit){
        metricUnit = "-";
      }
      $("#unit_"+groupId).html("<s:text name="detail.unit" /><s:text name="i18n.colon" />" + metricUnit);
      var metricName = $tr.attr("metricName");
      $("#metricDesc_"+groupId).html(metricName);

      var url = "${ctx}/detail/summarized!summarized.action?width=673&height=260&instanceId=${instanceId}&metricId="+metricId+"&freq=1h";
      loadSumImage(url,"1h",metricId,groupId);
      
      //$("#summarizemd_"+groupId).get(0).src="${ctx}/detail/summarized!summarized1.action?width=673&height=260&instanceId=${instanceId}&metricId="+metricId+"&freq=1h";
    });
    // 点击汇总频度按钮
    $("div[id^=toolsdiv] span[name=freqDiv]").bind("click",function(){
      $.blockUI({message:$('#loading')});
      var $span = $(this);
      var groupId = $span.attr("groupId");
      $("#toolsdiv_"+groupId+" span[name=freqDiv]").attr("class","data-l right");
      $span.attr("class","data-on-l right");
      var currentMetricId = $("#currentMetricId_"+groupId).val();
      var currentFreq = $span.attr("freq");
      $("#currentFreq_"+groupId).val(currentFreq);

      var url = "${ctx}/detail/summarized!summarized.action?width=673&height=260&instanceId=${instanceId}&metricId="+currentMetricId+"&freq="+currentFreq;
      loadSumImage(url,currentFreq,currentMetricId,groupId);
      //$("#summarizemd_"+groupId).get(0).src="${ctx}/detail/summarized!summarized1.action?width=673&height=260&instanceId=${instanceId}&metricId="+currentMetricId+"&freq=" + currentFreq;
    });
    //默认选中每一个分组第一行
    $("table").each(function(){
      $(this).find("tr").eq(1).click();
    });

    // 自定义时间段
    $("span[id^=clock_]").click(function(){
      var $span = $(this);
      var groupId = $span.attr("groupId");
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
             var freq = $("#currentFreq_"+groupId).val();
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
             var currentMetricId = $("#currentMetricId_"+groupId).val();
             var url = "${ctx}/detail/summarized!summarized.action?width=673&height=260&instanceId=${instanceId}&metricId="+currentMetricId+"&freq="+freq+"&startTime="+startTime+"&endTime="+endTime;
             loadSumImage(url,freq,currentMetricId,groupId);
             //$("#summarizemd_"+groupId).get(0).src="${ctx}/detail/summarized!summarized1.action?width=673&height=260&instanceId=${instanceId}&metricId="+currentMetricId+"&freq=" + freq + "&startTime=" + startTime + "&endTime=" + endTime;
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
        x : 170,
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
    $("span[name=xls],span[name=pdf]").click(function(){
      var groupId = $(this).attr("groupId");
      var fileType = $(this).attr("name");
      var metricId = $("#currentMetricId_"+groupId).val();
      var freq = $("#currentFreq_"+groupId).val();
      var filename = $("#currentFilename_"+groupId).val();
      var startTime = $("#currentLstartTime_"+groupId).val();
      var endTime = $("#currentLendTime_"+groupId).val();
      
      var params = "instanceId=${instanceId}&metricId="+metricId+"&freq="+freq+"&startTime="+startTime+"&endTime="+endTime+"&fileName="+filename+"&fileType="+fileType;
      //alert(params);
      var url = "${ctx}/detail/summarized!exportfile.action?"+params;
      document.getElementById("downloadFrm").src = url;
    });
    </s:if>
  </script>

