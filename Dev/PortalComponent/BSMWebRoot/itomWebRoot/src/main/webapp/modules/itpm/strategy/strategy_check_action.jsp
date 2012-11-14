<%@ page language="java" contentType="text/html;charset=UTF-8" errorPage="/modules/common/error.jsp"%>
<jsp:directive.page import="com.mocha.dev.ReqRes"/>
<jsp:directive.page import="com.mocha.bsm.itom.mgr.StrategyMgr"/>
<%@ include file="/modules/common/security.jsp"%>
<%
	ReqRes rr = new ReqRes(request, response);
	rr.encoding("UTF-8").nocache().security();

	String strategyId = rr.param("strategyId", null);
	if(!rr.empty(strategyId)){
		if(rr.empty(StrategyMgr.getInstance().queryStrategyNormalInfoVO(strategyId))){
			out.print(false);
		}else{
			out.print(true);
		}
	}else{
		out.print(false);
	}
	out.flush();
%>