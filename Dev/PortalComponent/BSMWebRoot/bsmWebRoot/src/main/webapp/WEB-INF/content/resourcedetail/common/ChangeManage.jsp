<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<style type="text/css">
  h1{text-align:center;color:#FFF;font-size:18px;}
  span.natspan{width:100px;display:inline-block;}
  span.elli{width:200px;text-overflow:ellipsis;white-space:nowrap;overflow:hidden; word-spacing:normal; word-break:normal; display:block;}
</style>
<s:set var="rHead" value="%{@com.mocha.bsm.detail.business.ChangeManageMgr@ROW_TYPE_HEAD}" />
<s:set var="rCurrent" value="%{@com.mocha.bsm.detail.business.ChangeManageMgr@ROW_TYPE_CURRENT}" />
<s:set var="rEvent" value="%{@com.mocha.bsm.detail.business.ChangeManageMgr@ROW_TYPE_EVENT}" />
<s:set var="rBaseline" value="%{@com.mocha.bsm.detail.business.ChangeManageMgr@ROW_TYPE_BASELINE}" />

<div class="rightcontent" style="height:472px;overflow:auto;">
  <div>
  <!-- 变更总结start -->
  <div class="business-grid02">
    <div class="business-grid02-title"><s:text name="ChangeManage" /></div>
    <s:if test="sumList!=null && sumList.size()>0">
    <div class="business-grid02-mid">
		  <table class="business-grid02-grid">
		    <thead>
				<tr><th width="30%" style="text-align:left;"><s:text name="detail.changemanage.list" /></th><th width="5%">&nbsp;</th><th><s:text name="detail.nearest.changetime" /></th></tr>
				</thead>
				<tbody id="sumtab">
				<s:iterator value="sumList" var="rowMap" status="idx">
				  <tr class="<s:if test="#idx.isEven()">business-grid02-tr-02</s:if>">
				    <td style="text-align:left;"><span class="elli" title="<s:property value="#rowMap['instName']" default="-" />"><s:property value="#rowMap['instName']" default="-" /></span></td>
				    <td>&nbsp;</td>
				    <td><s:property value="#rowMap['changeTime']" default="-" /></td>
				  </tr>
				</s:iterator>
        </tbody>
		</table>
    </div>
    </s:if>
    <div class="separated10"></div>
    <div class="txt-white">&nbsp;&nbsp;<s:text name="detail.time" /><s:text name="i18n.colon" /><s:text name="i18n.from" /><input type="text" id="fromDate" value="${startDate}" />&nbsp;&nbsp;<s:text name="i18n.to" /><input type="text" id="toDate" value="${endDate}" /><span class="ico" id="changeSearch" title="<s:text name="i18n.query" />"></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="black-btn-l" id="changeConfirm"><span class="btn-r"><span class="btn-m"><a><s:text name="detail.changeconfirm" /></a></span></span></span><span class="black-btn-l" id="baselinemgr"><span class="btn-r"><span class="btn-m"><a><s:text name="detail.changebaselinemgr" /></a></span></span></span></div>
    <div class="separated10"></div>
    <div class="vertical-middle"><ul><li class="left"><span class="ico ico-legend-green" style="cursor:default;"></span><span class="txt-white"><s:text name="detail.current.status" /></span><span class="ico ico-legend-red" style="cursor:default;"></span><span class="txt-white"><s:text name="detail.change.status" /></span><span class="ico ico-legend-gray" style="cursor:default;"></span><span class="txt-white"><s:text name="detail.baseline.status" /></span></li></ul></div>
    <div class="separated20"></div>
  </div>
	<!-- 变更总结end -->
	<!-- 变更一览start -->
	<s:if test="changeDataMap!=null && changeDataMap.size()>0">
  <div class="business-grid02" id="changeviewdiv">
		<s:iterator value="changeDataMap" var="datas" status="idx">

	  <s:if test="key !=null"><s:set name="groupId" value="key.getMetricGroupId()" /></s:if>
	  <s:else><s:set name="groupId" value="'customGroup'" /></s:else>
	  <s:if test="key !=null"><s:set name="groupName" value="key.getMetricGroupName()" /></s:if>
	  <s:else><s:set name="groupName" value="'其它'" /></s:else>

	  <s:set name="rowsList" value="value" />
	  
    <p class="rightct-h1"><span class="ico <s:if test="#idx.getIndex()>1">ico-plus</s:if><s:else>ico-minus</s:else>" divID="<s:property value="groupId" />"></span><span class="txt-white"><s:property value="groupName" /></span></p>
    
    <div id="<s:property value="groupId" />" style="display:<s:if test="#idx.getIndex()>1">none;</s:if>;">
    
    <div class="business-grid02-mid">
      <table class="business-grid02-grid">
        <s:iterator value="#rowsList" var="rowMap" status="rowIdx">
          <s:if test="#rowMap.rowtype==#rHead">
						<thead>
						  <tr>
						    <th><nobr><s:text name="detail.change.discoverytime" /></nobr></th>
						    <s:iterator value="#rowMap.metrics" var="metric">
						      <th><nobr><s:property value="#metric.getMetricName()" default="-" />&nbsp;&nbsp;&nbsp;&nbsp;</nobr></th>
						    </s:iterator>
						  </tr>
						</thead>
          </s:if>
          <s:elseif test="#rowMap.rowtype==#rCurrent">
	          <tr class="business-grid02-tr-green" rowtype="<s:property value="#rCurrent" />">
	            <td><nobr><s:property value="#rowMap.collectTime" default="-" /></nobr></td>
	            <s:iterator value="#rowMap['values']" var="metricValue" status="valIdx">
	              <td><nobr><s:property value="#metricValue" default="-" /><s:if test="!#metricValue.endsWith(#rowMap['metrics'].get(#valIdx.getIndex()).getMetricUnit())"><s:property value="#rowMap['metrics'].get(#valIdx.getIndex()).getMetricUnit()" /></s:if></nobr></td>
	            </s:iterator>
	          </tr>
          </s:elseif>
          <s:elseif test="#rowMap.rowtype==#rEvent">
	          <tr class="business-grid02-tr-red" style="display:none;" rowtype="<s:property value="rEvent" />">
	            <td><nobr><s:property value="#rowMap.collectTime" default="-" /></nobr></td>
	            <s:iterator value="#rowMap['values']" var="metricValue" status="valIdx">
		            <td>
			            <s:iterator value="#rowMap.metrics" var="metric" status="metIdx">
			            <nobr>
			            <s:if test="#rowMap['changemetricid'] == #metric.getMetricId() && #valIdx.getIndex() == #metIdx.getIndex()">
                    <span class="ico ico-alert02" title="<s:property value="#rowMap.eventmsg" default="-" />" style="cursor:default;"></span>
                  </s:if>
			            </s:iterator>
		              <s:property value="#metricValue" default="-" /><s:if test="!#metricValue.endsWith(#rowMap['metrics'].get(#valIdx.getIndex()).getMetricUnit())"><s:property value="#rowMap['metrics'].get(#valIdx.getIndex()).getMetricUnit()" /></s:if>
		              <nobr>
		            </td>
	            </s:iterator>
	          </tr>
          </s:elseif>
          <s:elseif test="#rowMap.rowtype==#rBaseline">
	          <tr class="business-grid02-tr-02" rowtype="<s:property value="rBaseline" />">
              <td><nobr><span class="ico ico-arrowup"></span><s:property value="#rowMap.collectTime" default="-" /></nobr></td>
              <s:iterator value="#rowMap['values']" var="metricValue" status="valIdx">
                <td><nobr><s:property value="#metricValue" default="-" /><s:if test="!#metricValue.endsWith(#rowMap['metrics'].get(#valIdx.getIndex()).getMetricUnit())"><s:property value="#rowMap['metrics'].get(#valIdx.getIndex()).getMetricUnit()" /></s:if></nobr></td>
              </s:iterator>
	          </tr>
          </s:elseif>
        </s:iterator>
    </table>
    </div>
    </div>
    <div class="separated10"></div>
		</s:iterator>
  </div>
  </s:if>
	<!-- 变更一览end -->
</div>
</div>
<script type="text/javascript">
$(function(){
  var isChildInstance = ${childInstance};//是否子资源请求
  // 基线之上一条事件没有的隐藏图标
  var $baseTrs = $("tr[rowtype=baseline]");
  $baseTrs.each(function(){
    var $trs = $(this).prevUntil("tr[rowtype!=event]");
     if($trs.length<=0){
       $(this).find("span.ico").hide();
     }
  });

  // 基线点击展开闭合事件
  $("tr[rowtype=baseline] span.ico").bind("click",function(){
    var $span = $(this);
    var $currTr = $span.parents("tr")
    var $trs = $currTr.prevUntil("tr[rowtype!=event]")
    var classVal = $span.attr("class");
    if(classVal.indexOf("ico-arrowup") != -1){
      $span.attr("class","ico ico-arrowright");
      $trs.show();
    }else if(classVal.indexOf("ico-arrowright") != -1){
      $span.attr("class","ico ico-arrowup");
      $trs.hide();
    }
  });
  // 配置变更分组展开与闭合
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

  // 变更确认
	$("#changeConfirm").bind("click",function(){
	  $.ajax( {
	    type : "post",
	    url : "${ctx}/detail/changeConfirm.action",
	    data : "instanceId=${instanceId}",
	    success : function(data, textStatus) {
	      var msg = "<s:text name="detail.msg.changeconfirmfailure" />";
		    if(data && data.result){
		      msg = "<s:text name="detail.msg.changeconfirmsuccess" />";
			  }
		    // 变更成功弹出提示.
		    var toast = new Toast({position:"CT"});
		    toast.addMessage(msg);
		    if(isChildInstance){
		      //window.location.href = window.location.href;
		      if(window.opener && window.opener.refreshResState){
		        window.opener.refreshResState();
			    }
			    if(window.tp){
		        $.blockUI({message:$('#loading')});
		        var childInstanceId = $("#childInstanceId").val();
		        var url = ctxpath + "/detail/common__ChangeManage!common.action?childInstance=true&instanceId="+childInstanceId;
		        tp.loadContent(3,{url:url,type:"post",param:{},callback:function(){$.unblockUI();}});
				  }
			  }else{
	        $("#common__ChangeManage").click();
	        if(refreshResState){
	          refreshResState();
		      }
		    }
		    
	    }
	  });
	});
	
  //初始化时间控件
  $("#fromDate,#toDate").bind('focus',function(){
    WdatePicker({dateFmt:'yyyy/MM/dd HH:mm:ss'});
  });

  $("#changeSearch").click(function(){
    var fromDate = $("#fromDate").val();
    var toDate = $("#toDate").val();
    if(fromDate!='' && toDate!='' && fromDate > toDate){
      var msg = "<s:text name="detail.msg.endtimegtstarttime" />";
      var _information = new information({text : msg});
      _information.show();
      return;
    }else if(fromDate!='' && toDate==''
      || fromDate=='' && toDate!=''){
      var msg = "<s:text name="detail.msg.selecttimeslot" />";
      var _information = new information({text : msg});
      _information.show();
      return;
    }
    var instanceId = $("#instanceId").val();
    var url = ctxpath + "/detail/common__ChangeManage!common.action";
    if(isChildInstance){
      // 子资源
      if(window.tp){
        $.blockUI({message:$('#loading')});
        var childInstanceId = $("#childInstanceId").val();
        var url = ctxpath + "/detail/common__ChangeManage!common.action?childInstance=true&instanceId="+childInstanceId+"&startDate="+fromDate+"&endDate="+toDate;
        tp.loadContent(3,{url:url,type:"post",param:{},callback:function(){$.unblockUI();}});
      }
    }else{
      // 主资源
      $.blockUI({message:$('#loading')});
      $.loadPage("content",url,"POST",{instanceId:instanceId,startDate:fromDate,endDate:toDate},function(){
        $.unblockUI();
      }); 
    }
  });
  
  // 基线管理
  $("#baselinemgr").bind("click",function(){
    var url = "${ctx}/detail/editbaseline.action?instanceId=<s:property value="instanceId"/>&childInstance="+isChildInstance;
    winOpen({url:url,width:810,height:525,name:'bselinemgr'});
  });
  
  $.unblockUI();
});
</script>