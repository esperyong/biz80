<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
	<div id="metricOverviewDiv" <s:if test="isChildInstance()">style="width:100%;height:470px;"</s:if>>
	  <p class="rightct-h1"><span class="ico ico-minus"></span><span class="txt-white"><s:text name="detail.availmetric" /></span></p>
	  <div id="availMetic">
    <div class="business-grid02-mid">
	    <table class="business-grid02-grid">
	      <tr>
	        <th width="40%"><s:text name="detail.metricname" /></th>
	        <th width="30%"><s:text name="detail.confirmstatus" /></th>
	        <th width="30%"><s:text name="detail.typical.coltime" /></th>
	      </tr>
			  <s:iterator value="metricList" var="metricBean" status="idx">
			    <tr class="<s:if test="#idx.isEven()">business-grid02-tr-02</s:if>">
			      <td><s:property value="#metricBean.metricName" default="-" /></td>
			      <td>&nbsp;&nbsp;&nbsp;&nbsp;<span class="<s:property value="#metricBean.state" default="lamp lamp-linggrey" />" style="cursor:default;"></span></td>
			      <td><s:property value="#metricBean.collectTime" default="-" /></td>
			    </tr>
			  </s:iterator>
	    </table>
    </div>
	  </div>
	</div>
  <script type="text/javascript">
    $(function(){
      $("#metricOverviewDiv .ico").bind("click",function(){
        var $span = $(this);
        var classVal = $span.attr("class");
        if(classVal.indexOf("ico-minus") != -1){
          $span.attr("class","ico ico-plus");
          $("#availMetic").hide();
        }else{
          $span.attr("class","ico ico-minus");
          $("#availMetic").show();
        }
      });
    });
    //$.unblockUI();
  </script>
