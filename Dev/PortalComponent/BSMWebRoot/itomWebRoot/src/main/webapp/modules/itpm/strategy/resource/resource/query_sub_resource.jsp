<%@ page language="java" contentType="text/html;charset=UTF-8" errorPage="/modules/common/error.jsp"%>
<jsp:directive.page import="com.mocha.dev.ReqRes"/>
<jsp:directive.page import="java.util.List"/>
<jsp:directive.page import="java.util.Arrays"/>
<jsp:directive.page import="java.util.ArrayList"/>
<jsp:directive.page import="com.mocha.bsm.itom.mgr.plugin.ResourcePlugin"/>
<jsp:directive.page import="com.mocha.bsm.itom.vo.SubResourceVO"/>
<jsp:directive.page import="com.mocha.bsm.itom.util.PageUtil"/>
<jsp:directive.page import="com.mocha.bsm.itom.vo.StrategyInfoVO"/>
<jsp:directive.page import="com.mocha.bsm.itom.mgr.XmlCommunication"/>
<jsp:directive.page import="com.mocha.bsm.itom.mgr.StrategyMgr"/>
<jsp:directive.page import="com.mocha.bsm.itom.vo.ResourceVO"/>
<%@ include file="/modules/common/security.jsp"%>
<%
   ReqRes rr = new ReqRes(request, response);
   rr.encoding("UTF-8").nocache().security();

   String instanceId = rr.param("instanceId", null);
   String instanceName = rr.param("instanceName", null);
   String strategyId = rr.param("strategyId", null);
   StrategyInfoVO vo = StrategyMgr.getInstance().queryStrategyNormalInfoVO(strategyId);
   StrategyInfoVO info = (StrategyInfoVO)XmlCommunication.getInstance().fromXMl(vo.getXmlInfo());
   List resources = info.getResources();
   List selectsub = null;
   if(!rr.empty(resources)){
	   for(int i = 0; i < resources.size(); i++){
		   ResourceVO resvo = (ResourceVO)resources.get(i);
		   if(resvo.getInstanceId().equals(instanceId)){
				selectsub = resvo.getSubResource();
				break;
		   }
	   }
   }
   ResourcePlugin networkplugin = new ResourcePlugin();
   List subList = networkplugin.query_child_resource_instrategy(instanceId, selectsub);
%>
<HTML>
<HEAD>
<link href="<%=cssRootPath %>/liye1.css" rel="stylesheet" type="text/css">
<SCRIPT language=JavaScript src="<%=jsRootPath%>/common.js"></SCRIPT>
<script src="<%=jsRootPath %>/checkForm.js"></script>
<script src="<%=jsRootPath %>/tools.js"></script>
<script language="javascript">
</script>
</HEAD>
<BODY>
<form name="formname" method="post" target="">
<div id="layer7">
  <table width="100%" align="center" cellpadding="0" cellspacing="1" bgcolor="#cacaca">
    <tr>
      <td height="320" align="center" valign="top" bgcolor="#FFFFFF">
      <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td height="22" align="center" valign="middle" background="<%=imgRootPath%>/bg002.jpg" class="table-bottom-border"><div align="left"> <strong>&nbsp;&nbsp;&nbsp;设置触发工单的网络接口</strong></div></td>
          <td width="30" align="center" background="<%=imgRootPath%>/bg002.jpg" class="table-bottom-border"><img src="<%=imgRootPath%>/gb.gif" style="cursor:pointer" width="19" height="19" onclick="closeDiv();"></td>
        </tr>
      </table>
          <table width="98%"  border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td height="3"><img src="<%=imgRootPath%>/spacer.gif" width="1" height="1"></td>
            </tr>
          </table>
        <table width="97%"  border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td height="25"><div align="left"><img src="<%=imgRootPath%>/spacer.gif" width="1" height="1">当前网络设备：<%=PageUtil.ellipsisNvl(instanceName, 185) %></div></td>
            </tr>
        </table>
        <div style="height:260px;width:290px;overflow:auto">
        <table width="96%" border="1" align="center" cellpadding="2" cellspacing="0"  bordercolorlight="#D4D4D4" bordercolordark="#FFFFFF" style="word-break :break-all;">
            <tr>
              <td width="39%" bgcolor="#EAEEF1" align="left"><strong>网络接口名称</strong></td>
              <td width="56%" bgcolor="#EAEEF1" align="left"><strong>接口描述</strong></td>
            </tr>
			<%
			if(!rr.empty(subList)){
				for(int i = 0; i < subList.size(); i++){
					SubResourceVO subvo = (SubResourceVO)subList.get(i);
			%>
            <tr>
              <td align="left" valign="top" bgcolor="#FFFFFF"><input type="hidden" name="subresourcename" value="<%=subvo.getInstanceName() %>"><%=PageUtil.ellipsisNvl(subvo.getInstanceName(), 95) %></td>
              <td align="left" valign="top" bgcolor="#FFFFFF"><input type="hidden" name="subresourcedesc" value="<%=subvo.getRemark() %>"><%=PageUtil.ellipsisNvl(subvo.getRemark(), 145) %></td>
            </tr>
            <%
			}}
            %>
        </table>
        </div>
        </td>
    </tr>
  </table>
</div>
</form>
</BODY>
<script type="text/javascript">
function closeDiv() {
	parent.document.getElementById("subquerydiv").style.display="none";
}
</script>
</HTML>
