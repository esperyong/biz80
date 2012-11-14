<%--
	modules/itpm/strategy/host_action.jsp
	author: wangtao@mochasoft.com.cn
	Description: 工单触发策略 - 主机选择
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" errorPage="/modules/common/error.jsp"%>
<jsp:directive.page import="com.mocha.dev.ReqRes"/>
<jsp:directive.page import="com.mocha.bsm.itom.mgr.XmlCommunication"/>
<jsp:directive.page import="com.mocha.bsm.itom.ItpmConfig"/>
<%@ include file="/modules/common/security.jsp"%>
<%
   ReqRes rr = new ReqRes(request, response);
   rr.encoding("UTF-8").nocache().security();
   
	String url = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+ ItpmConfig.get("itil_servlet_path");
	String action = "workform_state_change";
	String xml = "<map><entry><string>BoInstanceId</string><string>00-44VTZYU6-XUK6-FJNG-DKJ1-8ODJXBOVAXVG</string></entry><entry><string>RelationDataId</string><string>T0C06AG370J00S0060V00TGRF5</string></entry><entry><string>state</string><string>complete</string></entry></map>";
	String flag_xml = XmlCommunication.getInstance().call_itil(url, action, xml);
	out.print(flag_xml);
%>
