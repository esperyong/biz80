<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>

<s:set var="vToday" value="%{@com.mocha.bsm.detail.business.AvailStatisticsMgr@AVAIL_TODAY}" />
<s:set var="vYesterday" value="%{@com.mocha.bsm.detail.business.AvailStatisticsMgr@AVAIL_YESTERDAY}" />
<s:set var="v7Days" value="%{@com.mocha.bsm.detail.business.AvailStatisticsMgr@AVAIL_7_DAYS}" />
<s:set var="vMonth" value="%{@com.mocha.bsm.detail.business.AvailStatisticsMgr@AVAIL_MONTH}" />
<s:set var="vYear" value="%{@com.mocha.bsm.detail.business.AvailStatisticsMgr@AVAIL_YEAR}" />
<s:set var="P_SIZE" value="%{@com.mocha.bsm.detail.business.AvailStatisticsMgr@PAGE_SIZE}" />

<input type="hidden" name="availInstId" id="availInstId" value="${instanceId}" />
<input type="hidden" name="availTime" id="availTime" value="${availTime}" />
<input type="hidden" name="currentPage" id="currentPage" value="${currentPage}" />

<div id="availDiv" style="position:absolute;width:100%;margin-top:5px;">
  <div class="left table-b" style="width:34%;">
    <div class="table-b-top-l"><div class="table-b-top-r"><div class="table-b-top-m"></div></div></div>
    <div class="table-b-m"><div class="business-grid02-topbottom-left">
    <div class="business-grid02-topbottom-right"> </div></div>
    <div class="business-grid02-mid">
    <table class="business-grid02-grid" id="timeValueTab">
      <tr>
        <td colspan="3" class="business-grid02-td-left bold" style="text-align:center;"><s:text name="detail.msg.availstatistics" /></td>
      </tr>
      <tr style="cursor:pointer" class="business-grid02-tr-02 <s:if test="availTime==#vToday">business-grid02-tr-on</s:if>" id="<s:property value="#vToday" />">
        <td class="line bold" width="50px"><s:text name="detail.typical.today" /></td>
        <td class="line bold" width="5px"><s:text name="detail.colon" /></td>
        <td class="line"><s:property value="availValueMap[#vToday]" default="-"/><s:if test="availValueMap[#vToday]!=null && availValueMap[#vToday]!='-'">%</s:if></td>
      </tr> 
      <tr style="cursor:pointer" class="business-grid02-tr-02 <s:if test="availTime==#vYesterday">business-grid02-tr-on</s:if>" id="<s:property value="#vYesterday" />">
        <td class="line bold"><s:text name="detail.typical.yesterday" /></td>
        <td class="line bold"><s:text name="detail.colon" /></td>
        <td class="line"><s:property value="availValueMap[#vYesterday]" default="-"/><s:if test="availValueMap[#vYesterday]!=null && availValueMap[#vYesterday]!='-'">%</s:if></td>
      </tr>
      <tr style="cursor:pointer" class="business-grid02-tr-02 <s:if test="availTime==#v7Days">business-grid02-tr-on</s:if>" id="<s:property value="#v7Days" />">
        <td class="line bold"><s:text name="detail.typical.sevendays" /></td>
        <td class="line bold"><s:text name="detail.colon" /></td>
        <td class="line"><s:property value="availValueMap[#v7Days]" default="-"/><s:if test="availValueMap[#v7Days]!=null && availValueMap[#v7Days]!='-'">%</s:if></td>
      </tr>
      <tr style="cursor:pointer" class="business-grid02-tr-02 <s:if test="availTime==#vMonth">business-grid02-tr-on</s:if>" id="<s:property value="#vMonth" />">
        <td class="line bold"><s:text name="detail.typical.month" /></td>
        <td class="line bold"><s:text name="detail.colon" /></td>
        <td class="line"><s:property value="availValueMap[#vMonth]" default="-"/><s:if test="availValueMap[#vMonth]!=null && availValueMap[#vMonth]!='-'">%</s:if></td>
      </tr>
      <tr style="cursor:pointer" class="business-grid02-tr-02 <s:if test="availTime==#vYear">business-grid02-tr-on</s:if>" id="<s:property value="#vYear" />">
        <td class="bold"><s:text name="detail.typical.year" /></td>
        <td class="bold"><s:text name="detail.colon" /></td>
        <td class=""><s:property value="availValueMap[#vYear]" default="-"/><s:if test="availValueMap[#vYear]!=null && availValueMap[#vYear]!='-'">%</s:if></td>
      </tr>
    </table>
    </div>
    <div class="business-grid02-topbottom-left">
      <div class="business-grid02-topbottom-right"></div>
    </div>
    </div>
    <div class="table-b-b-l"><div class="table-b-b-r"><div class="table-b-b-m"></div></div></div>
  </div>
  
	<div class="right" style="width:65%;height:175px;">
    <img src="${ctx}/detail/availchart.action?instanceId=${instanceId}&availTime=${availTime}&width=305&height=175" />
	</div> 
  
  <div class="clear separated10"></div>
	<div class="h2" style="text-align:center;">
	  <span class="bold" style="line-height:16px;"><s:text name="i18n.left.doublequote" /><span class="bold" id="timeSlot"><s:text name="detail.typical.today" /></span><s:text name="i18n.right.doublequote" /><s:text name="detail.disabled.statistics" /></span><br/>
	  <span class="bold" style="line-height:16px;">(<s:property value="startTime" /> - <s:property value="endTime" />)</span>
	</div>
  <div class="clear separated10"></div>
  <s:if test="eventList != null && eventList.size() > 0">
    <table class="black-grid">
      <tr class="black-grid-graybg">
        <th width="8%" style="text-align:center;"><s:text name="detail.serialnumber" /></th>
        <th width="33%"><s:text name="detail.starttime" /></th>
        <th width="33%"><s:text name="detail.endtime" /></th>
        <th width="25%"><s:text name="detail.totaltime" /></th>
      </tr>
      <s:iterator value="eventList" var="map" status="idx">
	      <tr class="black-grid-graybg">
	        <td class="line" style="text-align:center;"><s:property value="#idx.getIndex()+1 + (currentPage-1) * #P_SIZE" /></td>
	        <td class="line"><s:property value="#map['start']" /></td>
	        <td class="line"><s:property value="#map['end']" /></td>
	        <td class="line"><s:property value="#map['total']" /></td>
	      </tr>
      </s:iterator>
      
      <s:if test="eventList.size() < #P_SIZE">
        <s:bean name="org.apache.struts2.util.Counter" id="counter">
          <s:param name="first" value="eventList.size()" />
          <s:param name="last" value="#P_SIZE - 1" />
          <s:iterator>
			      <tr class="black-grid-graybg">
			        <td class="line">&nbsp;</td>
			        <td class="line">&nbsp;</td>
			        <td class="line">&nbsp;</td>
			        <td class="line">&nbsp;</td>
			      </tr>
          </s:iterator>
        </s:bean>
      </s:if>
    </table>
    <div id="pageid"></div><!-- 分页组件 -->
  </s:if>
  <s:else>
	  <div class="grid-gray" style="height:250px;">
	    <div class="formcontent" style="height:250px;">
	      <table style="height:250px;width:100%;">
	        <tbody>
	          <tr>
	           <td class="nodata vertical-middle" style="text-align:center;">
	             <span class="nodata-l">
	                <span class="nodata-r">
	                  <span class="nodata-m"> <span class="icon"><s:text name="i18n.nodata" /></span> </span>
	                </span>
	              </span>
	            </td>
	          </tr>
	        </tbody>
	      </table>
	    </div>
	  </div>
  </s:else>
</div>
<script type="text/javascript" src="${ctxJs}/<s:text name="js.i18n.file" />"></script>
<script type="text/javascript" src="${ctxJs}/component/gridPanel/page.js"></script>
<script type="text/javascript">
var path = "${ctx}";
$(function() {
  //
  $("#timeValueTab tr").click(function(){
    var $tr = $(this);
    var availTime = $tr.attr("id");
    if(!availTime){
      return;
    }
    $("#timeValueTab tr").removeClass("business-grid02-tr-on");
    $tr.addClass("business-grid02-tr-on");
    $("#availTime").val(availTime);
    reloadContent();
  });
  
  //创建分页对象
  var page = new Pagination({
    applyId : "pageid",
    listeners : {
      pageClick : function(page) {
        // page为跳转到的页数 
        if(!page){
          return;
        }
        $("#currentPage").val(page);
        reloadContent();
      }
    }
  });
  page.pageing(${pageCount}, ${currentPage});

  function reloadContent(){
    $.blockUI({message:$('#loading')});
    var instanceId = $("#availInstId").val();
    var availTime = $("#availTime").val();
    var currentPage = $("#currentPage").val();
    var url = path + "/detail/availstatistics.action";
    var params = {instanceId:instanceId,availTime:availTime,currentPage:currentPage};
    if (window.availPanel) {
      window.availPanel.ajaxLoad(url,params);
    } else {
      $.loadPage("availDiv",url,"POST",params,function(){$.unblockUI();}); 
    }
    
    //$.loadPage("availDiv",url,"POST",params,function(){
    //  $("#availDiv").unblock();
    //}); 
  }
  $("#timeValueTab tr").each(function(){
    var $tr = $(this);
    if($tr.hasClass("business-grid02-tr-on")){
      var timeStr = $tr.find("td[class]").first().html();
      $("#timeSlot").html(timeStr);
    }
  });

});
</script>