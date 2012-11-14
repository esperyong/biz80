<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<style type="text/css">
  span.elli-name{width:150px;text-overflow:ellipsis;white-space:nowrap;overflow:hidden; word-spacing:normal; word-break:normal; display:block;}
  span.elli-throld{width:150px;text-overflow:ellipsis;white-space:nowrap;overflow:hidden; word-spacing:normal; word-break:normal; display:block;}
</style>
  <div id="metricOverviewDiv" <s:if test="isChildInstance()">style="width:100%;height:470px;overflow-x:hidden;overflow-y:auto;"</s:if><s:else>style="width:100%;height:470px;overflow-x:hidden;overflow-y:auto;"</s:else>>
    <p class="rightct-h1"><span class="ico ico-minus"></span><span class="txt-white"><s:text name="detail.infometric" /></span></p>
    <div id="availMetic" style="<s:if test="isChildInstance()">width:97%;overflow-x:hidden;</s:if><s:else>width:96%;overflow-x:hidden;</s:else>">
    <div class="business-grid02-mid">
      <table class="business-grid02-grid">
        <tr>
          <th width="33%"><s:text name="detail.metricname" /></th>
          <th width="33%"><s:text name="detail.currentvalue1" /></th>
          <th width="30%"><s:text name="detail.typical.coltime" /></th>
        </tr>
        <s:iterator value="metricList" var="metricBean" status="idx">
          <tr class="<s:if test="#idx.isEven()">business-grid02-tr-02</s:if>">
            <td><span class="elli-name"><s:property value="#metricBean.metricName" default="-" /></span></td>
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
