<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<style type="text/css">
  span.elli-name{width:<s:if test="isChildInstance()">240</s:if><s:else>170</s:else>px;text-overflow:ellipsis;white-space:nowrap;overflow:hidden; word-spacing:normal; word-break:normal; display:block;}
  span.elli-throld{width:<s:if test="isChildInstance()">125</s:if><s:else>95</s:else>px;text-overflow:ellipsis;white-space:nowrap;overflow:hidden; word-spacing:normal; word-break:normal; display:block;}
</style>
	<s:iterator value="metricMap" status="idx">
	<s:if test="key !=null"><s:set name="groupId" value="key.getMetricGroupId()" /></s:if>
	<s:else><s:set name="groupId" value="'customGroup'" /></s:else>
	<s:if test="key !=null"><s:set name="groupName" value="key.getMetricGroupName()" /></s:if>
	<s:else><s:set name="groupName" value="'其它'" /></s:else>
	<s:set name="metricList" value="value" />
	<div  <s:if test="isChildInstance()">style="width:100%;height:470px;"</s:if>>
	  <p class="rightct-h1"><span class="ico <s:if test="#idx.getIndex()>1">ico-plus</s:if><s:else>ico-minus</s:else>" divID="<s:property value="groupId" />"></span><span class="txt-white"><s:property value="groupName" /></span></p>
	  
	  <div id="<s:property value="groupId" />" style="display:<s:if test="#idx.getIndex()>1">none;</s:if>;">
	  
    <div class="business-grid02-topbottom"></div>
    <div class="business-grid02-mid">
	    <table class="business-grid02-grid">
	      <tr>
	        <th width="28%"><s:text name="detail.metricname" /></th>
	        <th width="17%"><s:text name="detail.confirmstatus" /></th>
	        <th width="20%"><s:text name="detail.currentvalue1" /></th>
	        <th width="30%"><s:text name="detail.typical.coltime" /></th>
	      </tr>
	      <s:iterator value="#metricList" var="metricBean" status="idx">
	        <tr class="<s:if test="#idx.isEven()">business-grid02-tr-02</s:if>">
	          <td>
	            <span class="elli-name" title="<s:property value="#metricBean.metricName" default="-" /><s:if test="#metricBean.unit!=null && #metricBean.unit!=''">(<s:property value="#metricBean.unit" default="" />)</s:if>">
	              <s:property value="#metricBean.metricName" default="-" /><s:if test="#metricBean.unit!=null && #metricBean.unit!=''">(<s:property value="#metricBean.unit" default="" />)</s:if>
	            </span>
	          </td>
	          <td>&nbsp;&nbsp;&nbsp;&nbsp;<span class="<s:property value="#metricBean.state" default="lamp lamp-linggrey" />" style="cursor:default;"></span></td>
	          <td>
	            <span class="elli-throld" title="<s:property value="#metricBean.currentValue" default="-" />">
	              <s:property value="#metricBean.currentValue" default="-" />
	            </span>
	          </td>
	          <td><s:property value="#metricBean.collectTime" default="-" /></td>
	        </tr>
	      </s:iterator>
	    </table>
    </div>
    <div class="business-grid02-topbottom"></div>
	  
	  </div>
	</div>
	</s:iterator>
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
  </script>
