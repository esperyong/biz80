<%--
	modules/itpm/strategy/query_resource.jsp
	author: wangtao@mochasoft.com.cn
	Description: 工单触发策略 - 策略列表 - 触发工单的资源
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" errorPage="/modules/common/error.jsp"%>
<jsp:directive.page import="com.mocha.dev.ReqRes"/>
<jsp:directive.page import="com.mocha.bsm.itom.mgr.StrategyMgr"/>
<jsp:directive.page import="java.util.List"/>
<jsp:directive.page import="com.mocha.bsm.itom.vo.ResourceVO"/>
<jsp:directive.page import="com.mocha.bsm.itom.util.PageUtil"/>
<jsp:directive.page import="com.mocha.bsm.itom.mgr.plugin.ResourceQueryMgr"/>
<jsp:directive.page import="com.mocha.bsm.itom.common.IConsts"/>
<jsp:directive.page import="java.util.Map"/>
<jsp:directive.page import="java.util.Set"/>
<jsp:directive.page import="com.mocha.bsm.itom.common.CategoryFilterCnofig"/>
<%@ include file="/modules/common/security.jsp"%>
<%
   ReqRes rr = new ReqRes(request, response);
   rr.encoding("UTF-8").nocache().security();

  String strategyId = rr.param("strategyId", null);
  String condtion = rr.param("condition", null);
  String typeRadio = rr.param("typeRadio", null);
  if(rr.empty(condtion) || i18n.key("itpm.strategy.define.search.note1").equals(condtion)){
	  condtion = null;
  }
  List resources = StrategyMgr.getInstance().query_instance_by_strategyId(strategyId, condtion);
%>
<HTML>
<HEAD>
<TITLE>Mocha BSM</TITLE>
<link href="<%=cssRootPath %>/liye1.css" rel="stylesheet" type="text/css">
<link href="<%=cssRootPath %>/liye.css" rel="stylesheet" type="text/css">
<link href="<%=cssRootPath %>/css.css" rel="stylesheet" type="text/css">
<SCRIPT language=JavaScript src="<%=jsRootPath%>/common.js"></SCRIPT>
<script src="<%=jsRootPath %>/checkForm.js"></script>
<script type="text/javascript" src="<%=jsRootPath%>/loading.js"></script>
<script type="text/javascript">
var g_loading = new Loading("<span class='word-blue'><%=i18n.key("data.submit.wait")%></span>",35,150,"yes",true,790,520,0,0);
function doStart(){
  g_loading.start();
}
function doStop(){
  g_loading.stop();
}
</script>
</HEAD>
<BODY>
<div id="subquerydiv" style="position:absolute; left:70px; top:30px; width:294px; height:340px;z-index:3; background-color: #FFFFFF; layer-background-color: #FFFFFF; border: 1px none #000000; display:none">
<iframe id="subqueryiframe" name="subqueryiframe" width=100% height=330 frameborder=0 valign="top" scrolling="no"></iframe>
</div>
<div align="center">
<form name="formname" id="formname" action="" method="post">
<input type="hidden" name="strategyId" value="<%=strategyId %>"/>
<input type="hidden" name="instanceId" value=""/>
<input type="hidden" name="instanceName" value=""/>
<input type="hidden" name="typeRadio" value="<%=typeRadio %>"/>
<table width="98%"  border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td height="3"><img src="<%=imgRootPath%>/spacer.gif" width="1" height="1"></td>
    </tr>
  </table>
<table width="97%"  border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td width="83%" height="30"><div align="left">&nbsp;
        <input name="condition" type="text" onfocus="getFocus();" onblur="missFocus();" class="zi" value="<%if(!rr.empty(condtion)) {out.print(condtion);}else{out.print(i18n.key("itpm.strategy.define.search.note1"));} %>" size="30">
        <img src="<%=imgRootPath%>/sousuo.gif" alt="<%=i18n.key("SEARCH") %>" style="cursor:hand;" width="18" height="18" align="absmiddle" onclick="sousuo();"></div></td>
    </tr>
</table>
<%if(rr.empty(resources)) {%>
<table width="100%" align="center">
   	<tr>
   	 <td valign="middle" class="lanzi_x" align="center" style="padding-top: 5px;">
   	 <br><br><br><br><br><br><br>
   	 	<IMG src="<%=imgRootPath%>/ico-infor.jpg"><br>
		<%=i18n.key("nodata") %>

   	 </td>
   	</tr>
</table>
<%}else {%>
<div style="height:375px;OVERFLOW:auto;">
<table width="100%" align="center" cellpadding="0" cellspacing="0">
    <tr>
      <td align="center" valign="top" bgcolor="#FFFFFF">
        <table width="96%" border="1" align="center" cellpadding="0" cellspacing="0"  bordercolorlight="#D4D4D4" bordercolordark="#FFFFFF">
          <tr>
            <td width="42%" bgcolor="#EAEEF1"><div align="left"><strong>资源名称</strong></div></td>
            <td width="30%" bgcolor="#EAEEF1"><div align="left"><strong>资源类型</strong></div></td>
            <td width="28%" bgcolor="#EAEEF1"><div align="left"><strong>IP地址</strong></div></td>
          </tr>
          <%
          Set<String> t_allNetWorkCategorys=CategoryFilterCnofig.getAllChildCategory(IConsts.NETWORKDEVICES);
          for(int i=0; i < resources.size(); i++) {
          		ResourceVO rvo = (ResourceVO)resources.get(i);
          		String[] ips = null;
				if(!rr.empty(rvo.getIp())){
					ips = rvo.getIp().split(",");
				}
				String img = "jiek_gray.gif";
				String alt = i18n.key("itpm.strategy.network.imgno");
				List sublist = rvo.getSubResource();
				String flag = ResourceQueryMgr.getInstance().getSubResourceImg(rvo.getInstanceId(), sublist);
				if(rr.equals("true", flag)){
					img = "jiek.gif";
					alt = i18n.key("itpm.strategy.network.imghave");
				}else if(rr.equals("false", flag)){
					img = "jiek_b1.gif";
					alt = i18n.key("itpm.strategy.network.imghalf");
				}
          %>
          <tr>
            <td align="left" valign="top" bgcolor="#FFFFFF">
            <div align="left">
            <%if(t_allNetWorkCategorys.contains(rvo.getCategoryId()) && !rr.equals(IConsts.EVENT_TYPE_CHANGE,typeRadio) && !IConsts.EVENT_TYPE_PERFORM.equals(typeRadio)){ %><img src="<%=imgRootPath %>/<%=img %>" alt="<%=alt %>" width="16" height="16"  align="absmiddle" <%if(!rr.equals("jiek_gray.gif",img)){ %>style="cursor:hand" onclick='openSubQuery("<%=rvo.getInstanceId() %>","<%=((rvo.getInstanceName()==null)?null:rvo.getInstanceName().replaceAll("\"","\\\\\""))%>");'<%} %>>
            <%} %><%=PageUtil.ellipsisNvl(rvo.getInstanceName(), 100) %>
            </div></td>
            <td align="left" valign="top" bgcolor="#FFFFFF"><div align="left"><%=PageUtil.ellipsisNvl(rvo.getResourceType(), 125) %></div></td>
            <td><div align="left">
				<%
				if(!rr.empty(ips)){
					if(ips.length == 1){
						out.print(ips[0]);
					}else{
				%>
				<select class="zi">
				<%
						for(int j = 0; j < ips.length; j++){
				%>
					<option><%=ips[j] %></option>
				<%
						}
				%>
				</select>
				<%
					}
				}
				%>
				</div></td>
          </tr>
          <%} %>
        </table>
        </td>
    </tr>
</table>
<div>
<%} %>
</form>
</div>
<div id="theEnd" style="position:relative"></div>
</BODY>
<script language="javascript">
function getFocus(){
	var value = document.formname.condition.value;
	if(value.trim() == "<%=i18n.key("itpm.strategy.define.search.note1")%>"){
		document.formname.condition.value = "";
	}
}

function missFocus(){
	var value = document.formname.condition.value;
	if(value.trim() == ""){
		document.formname.condition.value = "<%=i18n.key("itpm.strategy.define.search.note1")%>";
	}
}

function openSubQuery(instanceid, instancename){
	document.formname.instanceId.value = instanceid;
	document.formname.instanceName.value = instancename;
	document.formname.target = "subqueryiframe";
	document.formname.action = "query_sub_resource.jsp";
	document.formname.submit();
	document.getElementById("subquerydiv").style.display = "";
}

function alltotrim(){
	for (var i = 0; i < document.formname.elements.length; i++){
           if(document.formname.elements[i].type == "text"){
			document.formname.elements[i].value=document.formname.elements[i].value.trim();
		   }
	}
}
function checkForm() {
	if(!checkLawlessChar(document.formname.condition,'itpm.strategy.resource.query.resourceName.illegalchar','<%=path%>')){
		   return false;
	}
	return true;
}
function sousuo(){
	if(checkForm()){
		doStart();
		document.formname.target = "";
		document.formname.action = "query_resource.jsp";
		document.formname.submit();
	}
}
doStop();
</script>
</HTML>