<%--
	modules/itpm/strategy/strategy_def_action.jsp
	author: wangtao@mochasoft.com.cn
	Description: 工单触发策略 - 策略定义Action
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" errorPage="/modules/common/error.jsp"%>
<jsp:directive.page import="com.mocha.dev.ReqRes"/>
<jsp:directive.page import="com.mocha.bsm.itom.type.ClassCategoryType"/>
<jsp:directive.page import="com.mocha.bsm.itom.mgr.plugin.ItpmPlugin"/>
<jsp:directive.page import="com.mocha.bsm.itom.common.IConsts"/>
<jsp:directive.page import="com.mocha.bsm.itom.mgr.StrategyMgr"/>
<jsp:directive.page import="com.mocha.bsm.itom.vo.StrategyInfoVO"/>
<jsp:directive.page import="java.util.List"/>
<%--<jsp:directive.page import="com.mocha.bsm.itom.auditlog.NewOrEditStrategyFactoryImpl"/> --%>
<%@ include file="/modules/common/security.jsp"%>
<%
   ReqRes rr = new ReqRes(request, response);
   rr.encoding("UTF-8").nocache().security();

   String check = rr.param("check", null);
   String strategyName = rr.param("strategyName", null);
   String oldStrategyName = rr.param("oldStrategyName", null);
   String workformId = rr.param("workformId", null);
   String workformName = rr.param("workformName", null);
   String workformType = rr.param("isSelf", null);
   String userdomainId = rr.param("userdomainId", null);
   String isEdit = rr.param("isEdit", null);
   StrategyInfoVO vo = new StrategyInfoVO();
   vo.setStrategyName(strategyName);
   List list = StrategyMgr.getInstance().queryInfo(vo);

   if(rr.equals(oldStrategyName, strategyName) || (!rr.equals(oldStrategyName, strategyName) && rr.empty(list))) {
	   if(rr.empty(check)){
	   String resourceType = rr.param("resourceTypeRadio", null);
	   String className = ClassCategoryType.getName(resourceType);
	   if(rr.empty(className)) {
	   		className = IConsts.DEFAULT_CALSS;
	   }
	   Class c = Class.forName(className);
	   ItpmPlugin plugin = (ItpmPlugin)c.newInstance();
	   plugin.save(rr, new String[] {userdomainId});
	   //NewOrEditStrategyFactoryImpl.getInstance().insertAuditLog(strategyName, currentUserId, new String[] {userdomainId}, request, Boolean.valueOf(isEdit).booleanValue());
%>
		<script language="javascript">
		//parent.NextDiv('finishdiv');
		//parent.opener.location.href = "strategy_list.jsp?workformId=<%=workformId%>";
		try{
			parent.opener.parent.changeRightPage2('/bsmitom/modules/itpm/strategy/strategy_list.jsp','<%=workformId %>','<%=workformName %>', '<%=workformType %>');
		}catch(e){
		}
		parent.close();
		</script>

<%   }else{
		out.print(false);
		out.flush();
	}} else {
		out.print(true);
		out.flush();
	}
%>