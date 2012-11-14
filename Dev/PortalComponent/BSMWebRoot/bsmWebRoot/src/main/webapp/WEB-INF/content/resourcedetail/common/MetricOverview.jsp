<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.mocha.bsm.detail.util.Constants" %>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>

<div class="rightcontent">
  <div class="tree left">
    <p class="tree-h1"><s:text name="MetricOverview" /></p>
    <div class="tree-content" style="height:430px;color:#FFF;overflow:auto;">
      <s:property value="tree.createTree(true)" escape="false" />
    </div>
  </div>
  <div class="right rightct" id="metricview" style="width:67.5%;height:472px;overflow:auto;">
    <!-- 初始显示可用性，如果修改默认节点需要同时修改js中,这样处理样式有问题，改为在js中处理第一次选中第一个节点 -->
    <!-- <s:action name="metricinfo!availability" namespace="/detail" executeResult="true" flush="false"></s:action> -->
  </div>
</div>
<script type="text/javascript" src="${ctxJs}/component/treeView/tree.js"></script>
<script type="text/javascript">
  var path = "${ctx}";
  var instanceId = "${instanceId}";
  var metricTreeId = "<%=Constants.METRIC_TREE_ID%>";
  var availMetricNodeId = "<%=Constants.AVAILABILITY_METRIC%>";
</script>
<script type="text/javascript" src="${ctxJs}/resourcedetail/metricoverview.js"></script>

