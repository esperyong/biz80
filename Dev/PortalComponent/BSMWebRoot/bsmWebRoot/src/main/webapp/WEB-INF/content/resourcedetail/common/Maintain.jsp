<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<style type="text/css">
  h1{text-align:center;color:#FFF;font-size:18px;}
  span.natspan{width:100px;display:inline-block;}
  span.elli-main{width:500px;text-overflow:ellipsis;white-space:nowrap;overflow:hidden; word-spacing:normal; word-break:normal; display:block;}
</style>
<div class="rightcontent" style="height:472px;overflow:auto;">
  <div style="width:97%;">
	<!-- 责任人start -->
	<div class="business-grid02-title"><s:text name="detail.maintain.person" /></div>
	<div class="right rightct" style="width:100%;height:160px;">
	  <div class="table-b" style="width:100%;height:100%;">
	    <div class="table-b-top-l"><div class="table-b-top-r"><div class="table-b-top-m"></div></div></div>
	    <div class="table-b-m">
	      <div class="business-grid02-topbottom-left">
	        <div class="business-grid02-topbottom-right"></div>
	      </div>
	      <div class="business-grid02-mid">
	        <table class="business-grid02-grid">
	          <tr>
	            <td class="business-grid02-td-left bold" width="20%;">&nbsp;&nbsp;<s:text name="detail.maintain.person" /></td>
	            <td class="business-grid02-td-right" width="80%;">
	               <s:if test="user!=null"><s:property value="user.getName()" default="-" /></s:if><s:else>-</s:else>
	             </td>
	          </tr>
	          <tr>
	            <td class="business-grid02-td-left bold">&nbsp;&nbsp;<s:text name="detail.maintain.email" /></td>
	            <td class="business-grid02-td-right">
	              <s:if test="user!=null"><s:property value="user.getEmail()" default="-" /></s:if><s:else>-</s:else>
	            </td>
	          </tr>
	          <tr>
	            <td class="business-grid02-td-left bold">&nbsp;&nbsp;<s:text name="detail.maintain.mobile" /></td>
              <td class="business-grid02-td-right">
                <s:if test="user!=null && user.getMobile()!=''"><s:property value="user.getMobile()" default="-" /></s:if><s:else>-</s:else>
              </td>
	          </tr>
            <tr>
              <td class="business-grid02-td-left bold">&nbsp;&nbsp;<s:text name="detail.maintain.phone" /></td>
              <td class="business-grid02-td-right">
                <s:if test="user!=null && user.getTelphone()!=''"><s:property value="user.getTelphone()" default="-" /></s:if><s:else>-</s:else>
              </td>
            </tr>
	          <tr>
	            <td class="business-grid02-td-left business-grid02-td-last bold">&nbsp;&nbsp;<s:text name="detail.maintain.remark" /></td>
	            <td class="business-grid02-td-right  business-grid02-td-last">
	              <span class="elli-main" title="<s:property value="instance.getDescription()" default="-" />"><s:if test="instance!=null"><s:property value="instance.getDescription()" default="-" /></s:if><s:else>-</s:else></span>
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
	<!-- 责任人end -->
	
	<!-- 资源组start -->
	<div class="business-grid02-title"><s:text name="detail.maintain.resourcegroup" /></div>
	<div class="right rightct" style="width:100%;height:55px;">
	  <div class="table-b" style="width:100%;height:100%;">
	    <div class="table-b-top-l"><div class="table-b-top-r"><div class="table-b-top-m"></div></div></div>
	    <div class="table-b-m">
	      <div class="business-grid02-topbottom-left">
	        <div class="business-grid02-topbottom-right"></div>
	      </div>
	      <div class="business-grid02-mid">
	        <table class="business-grid02-grid">
	          <tr>
	            <td class="business-grid02-td-left business-grid02-td-last bold" style="width:20%;">&nbsp;&nbsp;<s:text name="detail.maintain.resourcegroup" /></td>
	            <td class="business-grid02-td-right  business-grid02-td-last" style="width:80%;">
	              <s:if test="groups==null || groups.length==0">-</s:if>
	              <s:else>
	                <span class="elli-main">
	                <s:iterator value="groups" var="group" status="idx">
	                  <s:if test="#idx.isLast()"><s:property value="#group.getResourceGroupName()" /></s:if>
	                  <s:else><s:property value="#group.getResourceGroupName()" /> , </s:else>
	                </s:iterator>
	                </span>
	              </s:else>
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
	<!-- 资源组end -->
	
	<!-- 计划不在线时间start -->
	<s:if test="offlineTime!=null && offlineTime.size()>0">
	<div class="business-grid02-title"><s:text name="detail.maintain.offlinetime" /></div>
	<div class="right rightct" style="width:100%;">
	  <div class="table-b" style="width:100%;height:100%;">
	    <div class="table-b-top-l"><div class="table-b-top-r"><div class="table-b-top-m"></div></div></div>
	    <div class="table-b-m">
	      <div class="business-grid02-topbottom-left">
	        <div class="business-grid02-topbottom-right"></div>
	      </div>
	      <div class="business-grid02-mid">
	        <table class="business-grid02-grid">
	          <tr>
	            <td class="business-grid02-td-left business-grid02-td-last bold" style="vertical-align:middle;width:20%;" rowspan="<s:property value="offlineTime.size()+1" />">&nbsp;&nbsp;<s:text name="detail.maintain.offlinetime" /></td>
	          </tr>
	          <s:iterator value="offlineTime" var="time" status="idx">
            <tr>
              <td class="business-grid02-td-right <s:if test="#idx.isLast()">business-grid02-td-last</s:if>">
                <s:property value="time" escape="false" />
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
	<s:else>
  <div class="business-grid02-title"><s:text name="detail.maintain.offlinetime" /></div>
  <div class="right rightct" style="width:100%;">
    <div class="table-b" style="width:100%;height:100%;">
      <div class="table-b-top-l"><div class="table-b-top-r"><div class="table-b-top-m"></div></div></div>
      <div class="table-b-m">
        <div class="business-grid02-topbottom-left">
          <div class="business-grid02-topbottom-right"></div>
        </div>
        <div class="business-grid02-mid">
          <table class="business-grid02-grid">
            <tr>
              <td class="business-grid02-td-left business-grid02-td-last bold" style="vertical-align:middle;width:20%;">&nbsp;&nbsp;<s:text name="detail.maintain.offlinetime" /></td>
              <td class="business-grid02-td-right business-grid02-td-last">-</td>
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
	</s:else>
	<!-- 计划不在线时间end -->
  </div>
</div>
<script type="text/javascript">
$.unblockUI();
</script>