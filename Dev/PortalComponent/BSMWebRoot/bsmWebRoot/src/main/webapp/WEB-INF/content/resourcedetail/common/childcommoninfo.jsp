<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<style type="text/css">
  span.elli{width:100%;overflow:hidden;white-space:nowrap;text-overflow:ellipsis;}
  span.elli-main{width:450px;text-overflow:ellipsis;white-space:nowrap;overflow:hidden; word-spacing:normal; word-break:normal; display:block;}
</style>
<div class="rightcontent" style="height:470px;overflow-x:hidden;overflow-y:auto;">
  <div style="width:100%;">
  <!-- 基本信息start -->
  <div class="business-grid02-title"><s:text name="detail.baseinfo" /></div>
  <div class="right rightct" style="width:100%;">
    <div class="table-b" style="width:97%;height:100%;">
      <div class="table-b-top-l"><div class="table-b-top-r"><div class="table-b-top-m"></div></div></div>
      <div class="table-b-m">
        <div class="business-grid02-topbottom-left">
          <div class="business-grid02-topbottom-right"></div>
        </div>
        <div class="business-grid02-mid">
          <table class="business-grid02-grid">
            <tr>
              <td class="business-grid02-td-left bold" width="30%">&nbsp;&nbsp;<s:text name="detail.instancename" /></td>
              <td class="business-grid02-td-right" width="70%">
                 <span class="elli-main" title="<s:property value="childInstance.getName()" default="-" />"><s:property value="childInstance.getName()" default="-" /></span>
               </td>
            </tr>
            <tr>
              <td class="business-grid02-td-left bold">&nbsp;&nbsp;<s:text name="detail.resourcetype" /></td>
              <td class="business-grid02-td-right">
                <s:if test="childResource!=null"><s:property value="childResource.getResourceName()" default="-" /></s:if><s:else>-</s:else>
              </td>
            </tr>
            <tr>
              <td class="business-grid02-td-left bold">&nbsp;&nbsp;<s:text name="detail.typical.stratgy" /></td>
              <td class="business-grid02-td-right"><s:property value="childProfile" default="-" /></td>
            </tr>
            <tr>
              <td class="business-grid02-td-left business-grid02-td-last bold">&nbsp;&nbsp;<s:text name="detail.info.remark" /></td>
              <td class="business-grid02-td-right  business-grid02-td-last">
                <span class="elli-main" title="<s:property value="childInstance.getDescription()" default="-" />"><s:if test="childInstance!=null"><s:property value="childInstance.getDescription()" default="-" /></s:if><s:else>-</s:else></span>
              </td>
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
  <!-- 基本信息end -->
  
  <!-- 子资源信息指标start -->
  <s:if test="infoMetrics!=null && infoMetrics.size()>0">
  <div class="business-grid02-title"><s:property value="childResource.getResourceName()" /><s:text name="detail.information" /></div>
  <div class="right rightct" style="width:100%;">
    <div class="table-b" style="width:97%;height:100%;">
      <div class="table-b-top-l"><div class="table-b-top-r"><div class="table-b-top-m"></div></div></div>
      <div class="table-b-m">
        <div class="business-grid02-topbottom-left">
          <div class="business-grid02-topbottom-right"></div>
        </div>
        <div class="business-grid02-mid">
          <table class="business-grid02-grid">
          <s:iterator value="infoMetrics" var="metricMap" status="idx">
            <tr>
              <td class="business-grid02-td-left <s:if test="#idx.isLast()">business-grid02-td-last</s:if> bold" width="30%">&nbsp;&nbsp;<s:property value="#metricMap['metricName']" /></td>
              <td class="business-grid02-td-right" width="70%">
                 <span class="elli-main" title="<s:property value="#metricMap['metricValue']" default="-" />"><s:property value="#metricMap['metricValue']" default="-" /><s:property value="#metricMap['metricUnit']" /></span>
               </td>
            </tr>
          </s:iterator>
          </table>
        </div>
        <div class="business-grid02-topbottom-left">
          <div class="business-grid02-topbottom-right"></div>
        </div>
      </div>
      <div class="table-b-b-l"><div class="table-b-b-r"><div class="table-b-b-m"></div></div></div>
    </div>
  </div>
  </s:if>
  <!-- 子资源信息指标end -->
  
  <!-- 资源状态start -->
  <div class="business-grid02-title"><s:text name="detail.resourcestatus" /></div>
  <div class="right rightct" style="width:100%;">
    <div class="table-b" style="width:97%;">
      <div class="table-b-top-l"><div class="table-b-top-r"><div class="table-b-top-m"></div></div></div>
      <div class="table-b-m">
        <div class="business-grid02-topbottom-left">
          <div class="business-grid02-topbottom-right"></div>
        </div>
        <div class="business-grid02-mid">
          <table class="business-grid02-grid">
            <tr>
              <td class="business-grid02-td-left bold" width="30%">&nbsp;&nbsp;<s:text name="detail.globalstatus" /></td>
              <td class="business-grid02-td-right" width="70%">
                 <span class="<s:property value="childState" />" style="cursor:default;"></span>
               </td>
            </tr>
            <tr>
              <td class="business-grid02-td-left business-grid02-td-last bold">&nbsp;&nbsp;<s:text name="detail.info.explain" /></td>
              <td class="business-grid02-td-right  business-grid02-td-last">
                <span id="stateexplain"></span>
              </td>
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
  <!-- 资源状态end -->
  
  </div>
</div>
<script type="text/javascript">
  var state = "${childState}";
  $("#stateexplain").html(I18N[state]);
</script>