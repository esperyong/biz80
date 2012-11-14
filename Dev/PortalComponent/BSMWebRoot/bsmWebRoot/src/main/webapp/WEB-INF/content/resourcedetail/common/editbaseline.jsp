<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html>
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title><s:text name="detail.changebaselinemgr" /></title>
<link rel="stylesheet" type="text/css" href="${ctxCss}/master.css" />
<link rel="stylesheet" type="text/css" href="${ctxCss}/public.css" />
<link rel="stylesheet" type="text/css" href="${ctxCss}/UIComponent.css" />
<link rel="stylesheet" type="text/css" href="${ctxCss}/business-grid.css" />
<link rel="stylesheet" type="text/css" href="${ctxCss}/datepicker.css"></link>
<style type="text/css">
  h1{text-align:center;font-size:18px;}
  span.natspan{width:100px;display:inline-block;}
  span.titleeli{width:100%;text-overflow:ellipsis;white-space:nowrap;overflow:hidden; word-spacing:normal; word-break:normal; display:block;}
</style>
</head>
<body style="background-color:#E2E2E2;">
<s:set var="rHead" value="%{@com.mocha.bsm.detail.business.ChangeManageMgr@ROW_TYPE_HEAD}" />
<s:set var="rCurrent" value="%{@com.mocha.bsm.detail.business.ChangeManageMgr@ROW_TYPE_CURRENT}" />
<s:set var="rEvent" value="%{@com.mocha.bsm.detail.business.ChangeManageMgr@ROW_TYPE_EVENT}" />
<s:set var="rBaseline" value="%{@com.mocha.bsm.detail.business.ChangeManageMgr@ROW_TYPE_BASELINE}" />

<div class="loading" id="loading" style="display:none;">
  <div class="loading-l">
    <div class="loading-r">
      <div class="loading-m"><span class="loading-img"><s:text name="page.loading.msg" /></span></div>
   </div>
  </div>
</div> 

<form id="baselinefrm" name="baselinefrm" method="post">

<page:applyDecorator name="popwindow">
  <page:param name="title"><s:text name="detail.changebaselinemgr" /></page:param>
  <page:param name="width">812px</page:param>
  <page:param name="background">#E2E2E2</page:param>
  <page:param name="topBtn_index_1">1</page:param>
  <page:param name="topBtn_id_1">closeBtn</page:param>
  <page:param name="topBtn_css_1">win-ico win-close</page:param>
  <page:param name="topBtn_title_1"><s:text name="i18n.close" /></page:param>
  
	<page:param name="bottomBtn_index_1">1</page:param>
	<page:param name="bottomBtn_id_1">confirmBtn</page:param>
	<page:param name="bottomBtn_text_1"><s:text name="i18n.confirm" /></page:param>
	
	<page:param name="bottomBtn_index_2">2</page:param>
	<page:param name="bottomBtn_id_2">cancelBtn</page:param>
	<page:param name="bottomBtn_text_2"><s:text name="i18n.cancel" /></page:param>
  
  <page:param name="content">

	<div class="rightcontent" style="height:472px;width:800px;overflow:auto;">
	  <div>
	  <div class="business-grid02">
	    <div class="separated10"></div>
	    <div>&nbsp;&nbsp;<s:text name="detail.time" /><s:text name="i18n.colon" /><s:text name="i18n.from" /><input type="text" id="fromDate" value="${startDate}" />&nbsp;&nbsp;<s:text name="i18n.to" /><input type="text" id="toDate" value="${endDate}" /><s:text name="detail.typical.status" /><s:text name="i18n.colon" /><select id="stateSel"><option value="1"><s:text name="i18n.all" /></option><option value="2"><s:text name="detail.change.status" /></option><option value="3"><s:text name="detail.baseline.status" /></option></select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="black-btn-l" id="refresh"><span class="btn-r"><span class="btn-m"><a><s:text name="btn.refresh" /></a></span></span></span></div>
	    <div class="separated10"></div>
	    <div class="vertical-middle"><ul><li class="left"><span class="ico ico-legend-green" style="cursor:default;"></span><span class=""><s:text name="detail.current.status" /></span><span class="ico ico-legend-red" style="cursor:default;"></span><span class=""><s:text name="detail.change.status" /></span><span class="ico ico-legend-gray" style="cursor:default;"></span><span class=""><s:text name="detail.baseline.status" /></span></li></ul></div>
	    <div class="separated20"></div>
	  </div>
	
		<!-- 变更一览start -->
		<s:if test="changeDataMap!=null && changeDataMap.size()>0">
	  <div class="business-grid02">
			<s:iterator value="changeDataMap" var="datas" status="idx">
		  <s:set name="groupId" value="key.getMetricGroupId()" />
		  <s:set name="groupName" value="key.getMetricGroupName()" />
		  <s:set name="rowsList" value="value" />
		  
	    <p class="rightct-h1"><span class="ico <s:if test="#idx.getIndex()>1">ico-plus</s:if><s:else>ico-minus</s:else>" divID="<s:property value="groupId" />"></span><span class=""><s:property value="groupName" /></span></p>
	    
	    <div id="<s:property value="groupId" />" style="display:<s:if test="#idx.getIndex()>1">none;</s:if>;">
	    
	    <div class="business-grid02-topbottom"></div>
	    <div class="business-grid02-mid">
	      <table class="business-grid02-grid">
	        <s:iterator value="#rowsList" var="rowMap" status="rowIdx">
	          <s:if test="#rowMap.rowtype==#rHead">
							<thead>
							  <tr>
							    <th width="30px;">&nbsp;</th>
							    <th><nobr><s:text name="detail.change.discoverytime" /></nobr></th>
							    <s:iterator value="#rowMap.metrics" var="metric">
							      <th><span class="titleeli"><s:property value="#metric.getMetricName()" default="-" />&nbsp;&nbsp;</span></th>
							    </s:iterator>
							  </tr>
							</thead>
	          </s:if>
	          <s:elseif test="#rowMap.rowtype==#rCurrent">
		          <tr class="business-grid02-tr-green" rowtype="<s:property value="#rCurrent" />">
		            <td>&nbsp;</td>
		            <td><nobr><s:property value="#rowMap.collectTime" default="-" /></nobr></td>
		            <s:iterator value="#rowMap['values']" var="metricValue">
		              <td><s:property value="#metricValue" default="-" /></td>
		            </s:iterator>
		          </tr>
	          </s:elseif>
	          <s:elseif test="#rowMap.rowtype==#rEvent">
		          <tr class="business-grid02-tr-red" rowtype="<s:property value="rEvent" />">
		            <td><input type="checkbox" name="basechk" value="<s:property value="#rowMap['eventId']" />" /></td>
		            <td><nobr><s:property value="#rowMap.collectTime" default="-" /></nobr></td>
		            <s:iterator value="#rowMap['values']" var="metricValue" status="valIdx">
			            <td>
				            <s:iterator value="#rowMap.metrics" var="metric" status="metIdx">
				            <s:if test="#rowMap['changemetricid'] == #metric.getMetricId() && #valIdx.getIndex() == #metIdx.getIndex()">
	                    <span class="ico ico-alert02"  style="cursor:default;" title="<s:property value="#rowMap.eventmsg" default="-" />"></span>
	                  </s:if>
				            </s:iterator>
			              <s:property value="#metricValue" default="-" />
			            </td>
		            </s:iterator>
		          </tr>
	          </s:elseif>
	          <s:elseif test="#rowMap.rowtype==#rBaseline">
		          <tr class="business-grid02-tr-02" rowtype="<s:property value="rBaseline" />">
		            <td><s:if test="#rowIdx.isLast()">&nbsp;</s:if><s:else><input type="checkbox" name="basechk" value="<s:property value="#rowMap['eventId']" />" checked /></s:else></td>
	              <td><nobr><s:property value="#rowMap.collectTime" default="-" /></nobr></td>
	              <s:iterator value="#rowMap['values']" var="metricValue">
	                <td><s:property value="#metricValue" default="-" /></td>
	              </s:iterator>
		          </tr>
	          </s:elseif>
	        </s:iterator>
	    </table>
	    </div>
	    <div class="business-grid02-topbottom"></div>
	    </div>
	    <div class="separated10"></div>
			</s:iterator>
	  </div>
	  </s:if>
		<!-- 变更一览end -->
	 </div>
	</div>
	<script type="text/javascript" src="${ctxJs}/jquery-1.4.2.min.js" ></script>
	<script type="text/javascript" src="${ctxJs}/component/cfncc.js" ></script>
	<script type="text/javascript" src="${ctxJs}/component/panel/panel.js"></script>
	<script type="text/javascript" src="${ctxJs}/component/comm/winopen.js"></script>
	<script type="text/javascript" src="${ctxJs}/jquery.blockUI.js"></script>
	<script type="text/javascript" src="${ctxJs}/component/date/WdatePicker.js"></script>
	<script type="text/javascript" src="${ctxJs}/component/popwindow/popwin.js"></script>
	<script type="text/javascript">
	$(function(){
	  var isChildInstance = ${childInstance};//是否子资源请求
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

	  //初始化时间控件
	  $("#fromDate,#toDate").bind('focus',function(){
	    WdatePicker({dateFmt:'yyyy/MM/dd HH:mm:ss'});
	  });
	
	  // 刷新
	  $("#refresh").bind("click",function(){
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
	    $.blockUI({message:$('#loading')});
	    var url = window.location.href;
	    var baseUrl = url.split("?")[0];
	    var params = "instanceId=${instanceId}&isChildInstance=${childInstance}&startDate="+fromDate+"&endDate="+toDate;
	    window.location.href = baseUrl + "?" + params;
	  });
	
	  // 确定
	  $("#confirmBtn").bind("click",function(){
	    var chks = $("input:checked");
	    var eventIds = "";
	    if(chks && chks.length>0){
	      chks.each(function(){
	        eventIds += this.value + ",";
	      });
	    }
	    $.ajax( {
	      type : "post",
	      url : "${ctx}/detail/savebaseline.action",
	      data : "userId=${userId}&instanceId=${instanceId}&eventIds=" + eventIds,
	      success : function(data, textStatus) {
	        if(window.opener && !isChildInstance){
	          window.opener.$("#common__ChangeManage").click();
	        }else if(window.opener && isChildInstance){
	          window.opener.location.href = window.opener.location.href;
			    }
	        window.close();
	      }
	    });
	  });

	  $("#stateSel").change(function(){
	    var val = this.value;
	    if(val == 1){//全部
	      $("tr[rowtype=current],tr[rowtype=baseline],tr[rowtype=event]").show();
		  }else if(val == 2){//变更事件
		    $("tr[rowtype=event]").show();
		    $("tr[rowtype=current],tr[rowtype=baseline]").hide();
			}else if(val == 3){//基线事件
        $("tr[rowtype=current],tr[rowtype=event]").hide();
        $("tr[rowtype=baseline]").show();
			}
		});
	
	  // 取消,关闭窗口
	  $("#cancelBtn").bind("click",function(){
	    window.close();
	  });
	  $("#closeBtn").bind("click",function(){
	    window.close();
	  });
	  
	  $.unblockUI();
	});
	</script>
  </page:param>
</page:applyDecorator>

</form>
</body>
</html>