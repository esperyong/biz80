<%--
	modules/itpm/strategy/condition.jsp
	author: wangtao@mochasoft.com.cn
	Description: 工单触发策略 - 触发条件设置
--%>
<%@page import="com.mocha.bsm.itom.common.CategoryFilterCnofig"%>
<%@ page language="java" contentType="text/html;charset=UTF-8" errorPage="/modules/common/error.jsp"%>
<jsp:directive.page import="com.mocha.dev.ReqRes"/>
<jsp:directive.page import="com.mocha.bsm.itom.mgr.plugin.ItpmPlugin"/>
<jsp:directive.page import="com.mocha.bsm.itom.type.ClassCategoryType"/>
<jsp:directive.page import="com.mocha.dev.ListMap"/>
<jsp:directive.page import="com.mocha.bsm.itom.vo.StrategyInfoVO"/>
<jsp:directive.page import="com.mocha.bsm.itom.mgr.StrategyMgr"/>
<jsp:directive.page import="com.mocha.bsm.itom.mgr.XmlCommunication"/>
<jsp:directive.page import="java.util.ArrayList"/>
<jsp:directive.page import="java.util.List"/>
<jsp:directive.page import="com.mocha.bsm.itom.common.IConsts"/>
<jsp:directive.page import="com.mocha.bsm.itom.ItpmConfig"/>
<jsp:directive.page import="com.mocha.bsm.itom.view.UserDomainManage"/>
<jsp:directive.page import="com.mocha.bsm.itom.vo.SendConditonVO"/>
<%@ include file="/modules/common/security.jsp"%>
<%@ taglib uri="/mochatag" prefix="mt"%>
<%
   ReqRes rr = new ReqRes(request, response);
   rr.encoding("UTF-8").nocache().security();
   String resourceType = rr.param("resourceTypeRadio", null);
   String categoryidstr = rr.param("categoryidstr", null);
   String strategyId = rr.param("strategyId", null);
   String typeRadio = rr.param("workformType", null);
   String[] categoryIDs = null;
   
   boolean isDisplay = false;
   if(IConsts.RESOURCE_CATEGORY.equals(resourceType)) {
	   if(!rr.empty(categoryidstr)){
		   categoryIDs = categoryidstr.split(",");
		   if(categoryIDs!=null&&categoryIDs.length>0){
			   for(int i=0;i<categoryIDs.length;i++){
				   String t_IIModelID=CategoryFilterCnofig.getIIModelID(categoryIDs[i]);
				   if(t_IIModelID!=null&&IConsts.NETWORKDEVICES.equals(t_IIModelID)){
					   isDisplay = true;
					   break;
				   }
			   }
		   }
		   
	   }
   }
   List condition_list = new ArrayList();
   List subcondition_list = new ArrayList();
   //发送条件
   SendConditonVO sendCondition = new SendConditonVO();

   if(!rr.empty(strategyId)){
	   StrategyInfoVO vo = StrategyMgr.getInstance().queryStrategyNormalInfoVO(strategyId);
	   StrategyInfoVO info = (StrategyInfoVO)XmlCommunication.getInstance().fromXMl(vo.getXmlInfo());
	   condition_list = info.getConditions();
	   subcondition_list = info.getSubConditions();
	   sendCondition = info.getSendConditon();
   }
   String className = ClassCategoryType.getName(resourceType);
   if(rr.empty(className)) {
   		className = IConsts.DEFAULT_CALSS;
   }
   Class c = Class.forName(className);
   ItpmPlugin plugin = (ItpmPlugin)c.newInstance();

   ListMap condition = plugin.getConditions(resourceType);

   String default_condtion = ItpmConfig.get("default_condtion");

   boolean isPortalAdmin = UserDomainManage.getInstance().isPortalAdmin(currentUserId);
%>
<HTML>
<HEAD>
<TITLE>Mocha BSM</TITLE>
<link href="<%=cssRootPath %>/liye1.css" rel="stylesheet" type="text/css">
<SCRIPT language=JavaScript src="<%=jsRootPath%>/common.js"></SCRIPT>
<script src="<%=jsRootPath %>/checkForm.js"></script>
<script language="javascript">
</script>
</HEAD>
<BODY>
<div align="center">
<form name="formname" id="formname" action="" method="post" target="host_condition_jsp">

<table width="650" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td align="left" valign="top">
    <table width="100%"  border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td>
        	<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#cacaca">
                <tr>
                  <td height="177" align="center" valign="top" bgcolor="#FFFFFF">
                  	  <table width="100%"  border="0" cellspacing="0" cellpadding="0">
                        <tr>
                          <td height=2></td>
                        </tr>
                      </table>
                      <table width="98%" cellspacing="0" cellpadding="4" border="0">
                        <tr>
                          <td valign="top">
                          <mt:inforHead alt="触发工单条件" title="触发工单条件" width="622" heigh="100" imgurl="<%=imgRootPath%>"/>
                          <table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
                              <tr>
                                <td height="24" align="right" class="table-bottom-border2"><div align="left">发生以下事件类型时，将触发工单：</div></td>
                              </tr>
                              <tr>
                              	<td>
                              		<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
		                              		<%int m = 0;
		                              		for(int i=0; i<condition.size(); i++) {
			                                  	String id = (String)condition.getKey(i);
			                                  	String name = (String)condition.get(id);
			                                  	if((IConsts.EVENT_TYPE_AVAIL.equals(typeRadio)&&id.indexOf("Unavailable") != -1)||
			                                  			IConsts.EVENT_TYPE_PERFORM.equals(typeRadio)&&id.indexOf("Unavailable") == -1){
													m++;
			                                  %>
				                              	<tr>
			                                  	  <td width="150" height="28" align="right"><%if(m == 1) {%><div align="left">资源事件类型：</div><%} %></td>
				                                  <td align="left"><input name="condtion" type="checkbox" value="<%=id %>" <%if(condition_list.contains(id)  || (rr.empty(strategyId) && default_condtion.indexOf(id) != -1)){ %>checked<%} %> <%if(!isPortalAdmin) {%>disabled<%} %>><%=name %>
				                                  <%if("ResourcePerfMinorStateId".equals(id)){ %>&nbsp;&nbsp;&nbsp;&nbsp;<span class="zi1">选中此项可能会产生大量的待办</span><%} %>
				                                  </td>
				                              	</tr>
			                                  <%}} %>
		                              	  <%if(isDisplay){ %>
				                              <%ListMap subCondition = plugin.getSubConditions();
				                                if(!rr.empty(subCondition)) {
				                                	int n = 0;
					                              	for(int i=0; i<subCondition.size(); i++) {
					                                  	String id = (String)subCondition.getKey(i);
					                                  	String name = (String)subCondition.get(id);
					                                  	if((IConsts.EVENT_TYPE_AVAIL.equals(typeRadio)&&id.indexOf("Unavailable") != -1)||
					                                  			IConsts.EVENT_TYPE_PERFORM.equals(typeRadio)&&id.indexOf("Unavailable") == -1){
					                                  		n++;
				                              %>
				                              		<tr>
				                                  	  <td width="150" height="28" align="right"><%if(n == 1) {%><div align="left">网络接口事件类型：</div><%} %></td>
				                              		  <td align="left"><input name="subCondtion" type="checkbox" value="<%=id %>" <%if(subcondition_list.contains(id) || (rr.empty(strategyId) && default_condtion.indexOf(id) != -1)){ %>checked<%} %> <%if(!isPortalAdmin) {%>disabled<%} %>><%=name %></td>
				                              		</tr>
				                              <%}}}%>
			                              <%} %>
	                              	</table>
	                          </td>
	                        </tr>
	                      </table>
	                      <mt:inforFoot imgurl="<%=imgRootPath%>"/>
	                      <table width="622" border="0" align="center" cellpadding="0" cellspacing="0">
						  <tr>
						    <td height="8"></td>
						  </tr>
						  </table>
						  <iframe id="send_condtion" name="send_condtion" width="100%" height="200" frameborder=0 valign="top" scrolling="no" src="<%=path %>/modules/itpm/strategy/send_condition.jsp?sendType=<%=sendCondition.getSendType() %>&sendFreq=<%=sendCondition.getSendFreq() %>&sendUnit=<%=sendCondition.getSendUnit() %>&sendCount=<%=sendCondition.getSendCount() %>"></iframe>

                      <table width="96%" border="0" align="center" cellpadding="0" cellspacing="0">
                        <tr>
                          <td width="89%" height="32" align="right"><table width="0%" align="right" cellpadding="0" cellspacing="0">
                              <tr>
                                <td><img src="<%=imgRootPath%>/left.jpg" width="6" height="22"></td>
                                <td width="45" background="<%=imgRootPath%>/mid.jpg"><div align="center"><span class="zi" style="cursor:hand;" onclick="parent.PreDiv('resourcediv');">上一步</span></div></td>
                                <td><img src="<%=imgRootPath%>/right.jpg" width="6" height="22"></td>
                              </tr>
                          </table>
                          </td>
                          <td width="11%" align="right"><table width="0%" align="right" cellpadding="0" cellspacing="0">
                            <tr>
                              <td><img src="<%=imgRootPath%>/left.jpg" width="6" height="22"></td>
                              <td width="45" background="<%=imgRootPath%>/mid.jpg"><div align="center"><%if(isPortalAdmin){ %><span class="zi" style="cursor:hand;" onclick="parent.doSubmit();">完成</span><%}else{ %><span class="zi" style="cursor:hand;" onclick="parent.close();">关闭</span><%} %></div></td>
                              <td><img src="<%=imgRootPath%>/right.jpg" width="6" height="22"></td>
                            </tr>
                          </table></td>
                        </tr>
                      </table>
                      </td>
                </tr>
            </table>
            </td>
      </tr>
    </table></td>
  </tr>
</table>
</form>
</div>
<!-- 提交到IFRAME-->
<IFRAME width=0 height=0  FRAMEBORDER=0  name="host_condition_jsp"></IFRAME>
</BODY>
<script language="javascript">
//向父页面传值
function doSubmit() {
	var condtion = document.getElementsByName("condtion");

	if(condtion != undefined && condtion.length > 0) {
		var condtion_str = "";
		for(i = 0; i < condtion.length; i++) {
			if(condtion[i].checked){
				condtion_str += condtion[i].value + ",";
			}
		}
		condtion_str = condtion_str.substring(0,condtion_str.length-1);
		parent.document.formname.submit_res_condition.value = condtion_str;
	}

	var subCondtion = document.getElementsByName("subCondtion");
	if(subCondtion != undefined && subCondtion.length > 0) {
		var subCondtion_str = "";
		for(i = 0; i < subCondtion.length; i++) {
			if(subCondtion[i].checked){
				subCondtion_str += subCondtion[i].value + ",";
			}
		}
		subCondtion_str = subCondtion_str.substring(0,subCondtion_str.length-1);
		parent.document.formname.submit_res_subcondition.value = subCondtion_str;
	}
	return window.frames["send_condtion"].doSubmit();
}
</script>
</HTML>