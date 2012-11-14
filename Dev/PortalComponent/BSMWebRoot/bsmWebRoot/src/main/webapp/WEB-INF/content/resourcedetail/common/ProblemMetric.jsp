<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.mocha.bsm.detail.util.Constants" %>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<s:if test="isChildInstance()">
<style type="text/css">
.rightcontent .tree{border:1px solid #4d5152;width:215px;}
.rightcontent .tree-h1{margin:1px;border:1px solid #363636; background:url(../images/window/pop-window.gif) left -59px repeat-x; text-align:center;color:#fff;padding:5px 0;}
.rightcontent .tree-content{ background:url(../images/window/opacity-bg.png) left top repeat;padding:5px;}
.rightcontent .rightct{width:75%;}
.rightcontent .rightct-h1{padding:5px 0 3px;}
</style>
</s:if>
<div class="rightcontent" <s:if test="isChildInstance()">style="height:470px;"</s:if>>
	<s:if test="metricTree!=null && compTree!=null">
	  <s:set var="leftHeight" value="'405px'" />
	  <s:set var="display" value="'none'" />
	</s:if>
	<s:elseif test="metricTree==null && compTree!=null">
	  <s:set var="leftHeight" value="'430px'" />
	  <s:set var="display" value="''" />
	</s:elseif>
	<s:else>
    <s:set var="leftHeight" value="'430px'" />
    <s:set var="display" value="'none'" />
	</s:else>
	
  <s:if test="metricTree==null && compTree==null">
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
	<script type="text/javascript">$.unblockUI();</script>
  </s:if>
  <s:else>
  <div class="tree left">
    <s:if test="metricTree!=null">
    <p class="tree-h1" id="problemMericP" style="cursor:pointer;"><s:text name="detail.problem.metric" /></p>
    <div class="tree-content" id="metricTreeContentDiv" style="height:<s:property value="#leftHeight" />;color:#FFF;overflow:auto;">
      <s:property value="metricTree.createTree(true)" escape="false" />
    </div>
    </s:if>
    <s:if test="compTree!=null">
    <p class="tree-h1" id="problemComponentP" style="cursor:pointer;"><s:text name="detail.problem.component" /></p>
    <div class="tree-content" id="compTreeContentDiv" style="height:<s:property value="#leftHeight" />;color:#FFF;overflow:auto;display:<s:property value="#display" />;">
      <s:property value="compTree.createTree(true)" escape="false" />
    </div>
    </s:if>
  </div>
  <div class="right rightct" id="metricview" style="width:67.5%;height:472px;overflow:auto;">
    <!-- 初始显示可用性，如果修改默认节点需要同时修改js中,这样处理样式有问题，改为在js中处理第一次选中第一个节点 -->
    <!-- <s:action name="metricinfo!availability" namespace="/detail" executeResult="true" flush="false"></s:action> -->
  </div>
  </s:else>

<script type="text/javascript" src="${ctxJs}/component/treeView/tree.js"></script>
<script type="text/javascript">
  var path = "${ctx}";
  var instanceId = "${instanceId}";
  var metricTreeId = "<%=Constants.METRIC_TREE_ID%>";
  var comonentTreeId = "<%=Constants.PROBLEM_COMPONENT_ID%>";
  var hasMetricTree = <s:property value="metricTree!=null" />;
  var hasCompTree = <s:property value="compTree!=null" />;
</script>
<script type="text/javascript" src="${ctxJs}/resourcedetail/problemMetric.js"></script>

