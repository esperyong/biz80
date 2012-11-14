<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.mocha.bsm.detail.util.Constants" %>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<style>
span.ellitd{text-overflow:ellipsis;white-space:nowrap;overflow:hidden; word-spacing:normal; word-break:normal; display:block;}
</style>
<div class="rightcontent">
	
  <s:if test="datas == null || datas.size() <= 0">
	<div class="grid-gray" style="height:450px;">
	  <div class="formcontent" style="height:450px;">
	    <table style="height:450px;width:100%;">
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
  </s:if>
  
  <s:else>
  <div>
    <p style="margin-bottom:5px;"><span id="exportExcel" class="ico ico-excel right" style="margin-right:25px;" title="<s:text name="detail.export.excel" />"></span><span class="txt-white"><s:text name="detail.data.coltime" /><span id="collectTime"><s:property value="collectTime" default="-" /></span><s:text name="detail.data.freq" /></span></p>
    <div style="overflow-x:hidden;overflow-y:auto;height:450px;">
    <div style="width:97%;">
    <div class="business-grid02-mid">
      <table class="business-grid02-grid">
        <tr>
          <th width="20%"><s:text name="detail.job.name" /></th>
          <th width="10%"><s:text name="detail.job.enable" /></th>
          <th width="10%"><s:text name="detail.job.runstatus" /></th>
          <th width="30%"><s:text name="detail.job.createdate" /></th>
          <th width="30%"><s:text name="detail.job.describe" /></th>
        </tr>
        <s:iterator value="datas" var="jobsInfo" status="idx">
          <tr class="<s:if test="#idx.isEven()">business-grid02-tr-02</s:if>">
            <td><span class="ellitd" style="width:125px;" title="<s:property value="#jobsInfo.jobName" default="-" />"><s:property value="#jobsInfo.jobName" default="-" /></span></td>
            <td><s:property value="#jobsInfo.enable" default="-" /></td>
            <td><s:property value="#jobsInfo.runStatus" default="-" /></td>
            <td><s:property value="#jobsInfo.createDate" default="-" /></td>
            <td><span class="ellitd" style="width:190px;" title="<s:property value="#jobsInfo.describe" default="-" />"><s:property value="#jobsInfo.describe" default="-" /></span></td>
          </tr>
        </s:iterator>
      </table>
    </div>
    </div>
    </div>
  </div>
  </s:else>
<iframe name="downloadFrm" id="downloadFrm" width="0" height="0" style="display:none"></iframe>
<script type="text/javascript">
  var path = "${ctx}";
  var instanceId = "${instanceId}";
  var metricId = "${metricId}";
  $(function(){
    $.unblockUI();
    $("#exportExcel").click(function(){
      var params = "instanceId="+instanceId+"&metricId="+metricId;
      var url = path + "/detail/jobsinfo__JobsInfo!export.action?"+params;
      document.getElementById("downloadFrm").src = url;
    });
  });
</script>

