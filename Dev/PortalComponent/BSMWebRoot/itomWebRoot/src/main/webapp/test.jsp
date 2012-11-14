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
<html><body>
<form name="loginForm" id="loginForm" action="" method="post">

</form>
</body>
</html>
<script type="text/javascript">
<!--
	//var param = "?bsm_style_id=Resource&bsm_resource_id=80FB67B4750F72C0BB34C87B23D2E39A2F1CA2EF";
	//var param = "?bsm_style_id=Service&bsm_resource_id=C77D14DF-9FEA-D936-F512-FB9A1F61C5A8";
	//var param = "?bsm_style_id=Room&bsm_resource_id=room_00001";	
	//var param = "?bsm_style_id=Room&bsm_resource_id=room_00001";
	
	//var param = "?bsm_style_id=Resource&bsm_event_id=0D318ACC-16CC-EF02-657B-621CE170D6F8";
	  var param = "?bsm_style_id=Service&bsm_event_id=7BAA0F48-54D3-E788-7EE4-659093C8A892&userid=admin";
	//var param = "?bsm_style_id=Room&bsm_event_id=0D318ACC-16CC-EF02-657B-621CE170D6F8";
	
	document.loginForm.action="bsmforward.jsp" + param;
	//alert(document.loginForm.action);
	document.loginForm.submit();
//-->
</script>

