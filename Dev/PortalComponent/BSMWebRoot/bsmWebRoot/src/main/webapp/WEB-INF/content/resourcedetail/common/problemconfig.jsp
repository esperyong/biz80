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
	       
  </div>
</div>
