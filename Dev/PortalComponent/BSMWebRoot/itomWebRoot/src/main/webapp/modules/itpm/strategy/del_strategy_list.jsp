<%--
	modules/itpm/strategy/del_strategy_list.jsp
	author: wangtao@mochasoft.com.cn
	Description: 工单触发策略 - 删除策略定义Action
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" errorPage="/modules/common/error.jsp"%>
<jsp:directive.page import="com.mocha.dev.ReqRes"/>
<jsp:directive.page import="com.mocha.bsm.itom.mgr.StrategyMgr"/>
<jsp:directive.page import="java.util.Arrays"/>
<%-- <jsp:directive.page import="com.mocha.bsm.itom.auditlog.DeleteStragegyFactoyrImpl"/> --%>
<%@ include file="/modules/common/security.jsp"%>
<%
   ReqRes rr = new ReqRes(request, response);
   rr.encoding("UTF-8").nocache().security();
   String workformId = rr.param("workformId", null);
   String workformName = rr.param("workformName", null);
   String workformType = rr.param("workformType", null);
   String del_str = rr.param("del_str", null);
   //DeleteStragegyFactoyrImpl.getInstance().insertAuditLog(del_str.split(","), currentUserId, request);
   StrategyMgr.getInstance().deleteInfoByStrategyId(Arrays.asList(del_str.split(",")));
%>

<script language="javascript">
	parent.parent.changeRightPage2('/bsmitom/modules/itpm/strategy/strategy_list.jsp','<%=workformId %>','<%=workformName %>', '<%=workformType %>');
	//parent.location.reload();
</script>
</HTML>