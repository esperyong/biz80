<%--
	modules/itpm/strategy/strategy_def.jsp
	author: wangtao@mochasoft.com.cn
	Description: 工单触发策略 - 策略定义
--%>
<%@page import="com.mocha.bsm.system.SystemContext"%>
<%@ page language="java" contentType="text/html;charset=UTF-8" errorPage="/modules/common/error.jsp"%>
<jsp:directive.page import="com.mocha.dev.ReqRes"/>
<jsp:directive.page import="com.mocha.bsm.itom.mgr.StrategyMgr"/>
<jsp:directive.page import="com.mocha.bsm.itom.vo.StrategyInfoVO"/>
<jsp:directive.page import="com.mocha.bsm.itom.mgr.XmlCommunication"/>
<jsp:directive.page import="java.util.List"/>
<jsp:directive.page import="java.util.Map"/>
<jsp:directive.page import="com.mocha.bsm.itom.vo.xml.HandlerVO"/>
<jsp:directive.page import="com.mocha.bsm.itom.view.UserDomainManage"/>
<jsp:directive.page import="com.mocha.bsm.itom.mgr.plugin.ResourceQueryMgr"/>
<jsp:directive.page import="com.mocha.bsm.itom.vo.CategoryVO"/>
<jsp:directive.page import="com.mocha.bsm.itom.common.IConsts"/>
<jsp:directive.page import="com.mocha.dev.ListMap"/>
<jsp:directive.page import="com.mocha.bsm.itom.vo.UserVO"/>
<jsp:directive.page import="com.mocha.bsm.itom.type.DIYCategoryType"/>
<jsp:directive.page import="java.util.ArrayList"/>
<jsp:directive.page import="com.mocha.bsm.itom.type.CategoryURLType"/>
<jsp:directive.page import="com.mocha.bsm.itom.type.ConditionURLType"/>
<jsp:directive.page import="com.mocha.bsm.itom.util.PageUtil"/>
<jsp:directive.page import="com.mocha.bsm.itom.vo.SendConditonVO"/>
<jsp:directive.page import="com.mocha.bsm.itom.vo.UserDomainVO"/>
<jsp:directive.page import="com.mocha.bsm.itom.type.WorkFormType"/>
<jsp:directive.page import="com.mocha.bsm.itom.type.StrategyType"/>
<jsp:directive.page import="com.mocha.bsm.itom.ItpmConfig"/>
<%@ taglib uri="/mochatag" prefix="mt"%>
<%@ include file="/modules/common/security.jsp"%>
<%
   ReqRes rr = new ReqRes(request, response);
   rr.encoding("UTF-8").nocache().security();

   String workformId = rr.param("workformId", null);
   String workformName = rr.param("workformName", null);
   String workformType = rr.param("workformType", null);
   String isSelf = rr.param("workformType", null);
   String typeRadio = null;
   String itomDomainId = rr.param("itomDomainId", null);
   String strategyId = rr.param("strategyId", null);
   boolean isEdit = false;
   StrategyInfoVO info = new StrategyInfoVO();
   //发送条件
   SendConditonVO sendCondition = new SendConditonVO();
   if(!rr.empty(strategyId)) {
   	  isEdit = true;
   	  StrategyInfoVO vo = StrategyMgr.getInstance().queryStrategyNormalInfoVO(strategyId);
   	  info = (StrategyInfoVO)XmlCommunication.getInstance().fromXMl(vo.getXmlInfo());
   	  workformId = info.getWorkformId();
   	  workformName = info.getWorkformName();
   	  sendCondition = info.getSendConditon();
   	  workformType = info.getIsSelf();
   	  isSelf = info.getIsSelf();
   	  itomDomainId = info.getUserdomainId();
   	  typeRadio = info.getWorkformType();
   }

   UserDomainVO UserDomainVO = UserDomainManage.getInstance().getUserDomainVOByDomainId(itomDomainId);
   Map map = StrategyMgr.getInstance().get_tree_handler(request, info.getHandlers(), new String[]{itomDomainId});
   List left_list = (List)map.get("left");
   List right_list = (List)map.get("right");
   List category_list = ResourceQueryMgr.getInstance().query_all_category();//资源
   //out.print(org.apache.commons.lang.builder.ToStringBuilder.reflectionToString(category_list));
   List list = new ArrayList();//其他（现在只有服务）
   ListMap diy_category = DIYCategoryType.getAll();
   for (int i = 0; i < diy_category.size(); i++) {
	   String key = (String)diy_category.getKey(i);
	   String value = (String)diy_category.get(key);
	   CategoryVO vo = new CategoryVO();
	   vo.setId(key);
	   vo.setName(value);
	   list.add(vo);
   }
   String right_person_str = "";
   if(!rr.empty(right_list)) {
   		for(int i = 0; i < right_list.size(); i++) {
   			HandlerVO vo = (HandlerVO)right_list.get(i);
   			right_person_str += vo.getHandlerId()+",";
   		}
   		right_person_str = right_person_str.substring(0,right_person_str.length()-1);
   }

   boolean isPortalAdmin = UserDomainManage.getInstance().isPortalAdmin(currentUserId);
%>
<HTML>
<HEAD>
<TITLE>Mocha BSM</TITLE>
<link href="<%=cssRootPath %>/liye.css" rel="stylesheet" type="text/css">
<link href="<%=cssRootPath %>/liye1.css" rel="stylesheet" type="text/css">
<link href="<%=cssRootPath %>/css.css" rel="stylesheet" type="text/css">
<SCRIPT language=JavaScript src="<%=jsRootPath%>/common.js"></SCRIPT>
<script src="<%=jsRootPath %>/checkForm.js"></script>
<script src="<%=jsRootPath%>/tools.js"></script>
<script type="text/javascript" src="<%=jsRootPath%>/loading.js"></script>
<script type="text/javascript">
var g_loading = new Loading("<span class='word-blue'><%=i18n.key("data.submit.wait")%></span>",160,260,"yes",true,680,500,0,0);
function doStart(){
  g_loading.start();
}
function doStop(){
  g_loading.stop();
}
doStop();
</script>
</HEAD>
<BODY onload="init();">
<div align="center">
<form name="formname" id="formname" action="" method="post" target="strategy_def_jsp">
<input type="hidden" name="isEdit" value="<%=isEdit %>" >
<input type="hidden" name="workformId" value="<%=workformId %>" >
<input type="hidden" name="workformName" value="<%=workformName %>" >
<input type="hidden" name="isSelf" value="<%=isSelf %>" >
<input type="hidden" name="oldStrategyName" value="<%=info.getStrategyName() %>" >
<input type="hidden" name="strategyId" value="<%if(!rr.empty(strategyId)){out.print(strategyId);} %>" >
<input type="hidden" name="left_sel_person" value="" >
<input type="hidden" name="right_sel_person" value="<%=right_person_str %>" >
<input type="hidden" name="categoryidstr" value="" >
<input type="hidden" name="memory" value="" >
<input type="hidden" name="div_id" value="normaldiv,resourcediv,conditiondiv,finishdiv" >

<!--提交保存数据 -->
<input type="hidden" name="submit_res_id" value="" >
<input type="hidden" name="submit_res_type" value="" >
<input type="hidden" name="submit_res_category" value="" >
<input type="hidden" name="submit_res_subId" value="" >
<input type="hidden" name="submit_res_condition" value="" >
<input type="hidden" name="submit_res_subcondition" value="" >
<input type="hidden" name="sendType" value="<%=sendCondition.getSendType() %>">
<input type="hidden" name="sendFreq" value="<%=sendCondition.getSendFreq() %>">
<input type="hidden" name="sendUnit" value="<%=sendCondition.getSendUnit() %>">
<input type="hidden" name="sendCount" value="<%=sendCondition.getSendCount() %>">

<div style="height:30px">&nbsp;</div>
<table width="650" border="0" cellpadding="3" cellspacing="1" bgcolor="#cacaca">
  <tr>
    <td bgcolor="#F6F8FB"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td height="67" background="<%=imgRootPath%>/xd-bg.gif">

        <table id="<%=IConsts.S_INCCIDENT %>_title" width="100%" height="66"  border="0" cellpadding="0" cellspacing="0" style="display:none;">
          <tr align="center">
            <td height="43"><img src="<%=imgRootPath%>/xd01.gif" width="37" height="39"></td>
            <td><img src="<%=imgRootPath%>/arrow-xd.gif" width="24" height="18"></td>
            <td><img name="resourceimage" src="<%=imgRootPath%>/xd03.gif" width="38" height="43" style="display:none"><img name="resourceimage_gray" src="<%=imgRootPath%>/xd03_gray.gif" width="38" height="43"></td>
            <td><img name="resourceimage" src="<%=imgRootPath%>/arrow-xd.gif" width="24" height="18" style="display:none"><img name="resourceimage_gray" src="<%=imgRootPath%>/arrow-xd_gray.gif" width="24" height="18"></td>
            <td><img name="conditionimage" src="<%=imgRootPath%>/xd04.gif" width="40" height="43" style="display:none"><img name="conditionimage_gray" src="<%=imgRootPath%>/xd04_gray.gif" width="40" height="43"></td>
            <td><img name="conditionimage" src="<%=imgRootPath%>/arrow-xd.gif" width="24" height="18" style="display:none"><img name="conditionimage_gray" src="<%=imgRootPath%>/arrow-xd_gray.gif" width="24" height="18"></td>
            <td><img name="finishimage" src="<%=imgRootPath%>/xd05.gif" width="40" height="43" style="display:none"><img name="finishimage_gray" src="<%=imgRootPath%>/xd05_gray.gif" width="40" height="43"></td>
          </tr>
          <tr align="center">
            <td height="24"><img src="<%=imgRootPath%>/1a.GIF" width="16" height="16" hspace="4" align="absmiddle"><span style="cursor:hand" class="zi1" onclick="NextDiv('normaldiv');">常规信息</span></td>
            <td>&nbsp;</td>
            <td><img name="resourceimage" src="<%=imgRootPath%>/2a.GIF" width="16" height="16" hspace="4" align="absmiddle" style="display:none"><img name="resourceimage_gray" src="<%=imgRootPath%>/2a_gray.gif" width="16" height="16" hspace="4" align="absmiddle"><span id="resourcespan_gray" class="txt-gray">添加资源</span><span id="resourcespan" class="zi1" style="display:none" style="cursor:hand" onclick="NextDiv('resourcediv');">添加资源</span></td>
            <td>&nbsp;</td>
            <td><img name="conditionimage" src="<%=imgRootPath%>/3a.GIF" width="16" height="16" hspace="4" align="absmiddle" style="display:none"><img name="conditionimage_gray" src="<%=imgRootPath%>/3a_gray.gif" width="16" height="16" hspace="4" align="absmiddle"><span id="conditionspan_gray" class="txt-gray">触发条件</span><span id="conditionspan" class="zi1" style="display:none" style="cursor:hand" onclick="NextDiv('conditiondiv');">触发条件</span></td>
            <td>&nbsp;</td>
            <td><img name="finishimage" src="<%=imgRootPath%>/4a.GIF" width="16" height="16" hspace="4" align="absmiddle" style="display:none"><img name="finishimage_gray" src="<%=imgRootPath%>/4a_gray.gif" width="16" height="16" hspace="4" align="absmiddle"><span id="finishspan_gray" class="txt-gray">完成</span><span id="finishspan" class="zi1" style="display:none" style="cursor:hand" onclick="NextDiv('finishdiv');">完成</span></td>
            </tr>
        </table>
        <table id="<%=IConsts.S_CHANGE %>_title" width="100%" height="66"  border="0" cellpadding="0" cellspacing="0" style="display:none;">
          <tr align="center">
            <td height="43"><img src="<%=imgRootPath%>/xd01.gif" width="37" height="39"></td>
            <td><img src="<%=imgRootPath%>/arrow-xd.gif" width="24" height="18"></td>
            <td><img name="resourceimage" src="<%=imgRootPath%>/xd03.gif" width="38" height="43" style="display:none"><img name="resourceimage_gray" src="<%=imgRootPath%>/xd03_gray.gif" width="38" height="43"></td>
            <td><img name="resourceimage" src="<%=imgRootPath%>/arrow-xd.gif" width="24" height="18" style="display:none"><img name="resourceimage_gray" src="<%=imgRootPath%>/arrow-xd_gray.gif" width="24" height="18"></td>
            <td><img name="finishimage" src="<%=imgRootPath%>/xd05.gif" width="40" height="43" style="display:none"><img name="finishimage_gray" src="<%=imgRootPath%>/xd05_gray.gif" width="40" height="43"></td>
          </tr>
          <tr align="center">
            <td height="24"><img src="<%=imgRootPath%>/1a.GIF" width="16" height="16" hspace="4" align="absmiddle"><span style="cursor:hand" class="zi1" onclick="NextDiv('normaldiv');">常规信息</span></td>
            <td>&nbsp;</td>
            <td><img name="resourceimage" src="<%=imgRootPath%>/2a.GIF" width="16" height="16" hspace="4" align="absmiddle" style="display:none"><img name="resourceimage_gray" src="<%=imgRootPath%>/2a_gray.gif" width="16" height="16" hspace="4" align="absmiddle"><span id="resourcespan_gray" class="txt-gray">添加资源</span><span id="resourcespan" class="zi1" style="display:none" style="cursor:hand" onclick="NextDiv('resourcediv');">添加资源</span></td>
            <td>&nbsp;</td>
            <td><img name="finishimage" src="<%=imgRootPath%>/3a.GIF" width="16" height="16" hspace="4" align="absmiddle" style="display:none"><img name="finishimage_gray" src="<%=imgRootPath%>/3a_gray.gif" width="16" height="16" hspace="4" align="absmiddle"><span id="finishspan_gray" class="txt-gray">完成</span><span id="finishspan" class="zi1" style="display:none" style="cursor:hand" onclick="NextDiv('finishdiv');">完成</span></td>
            </tr>
        </table>
        </td>
      </tr>
    </table></td>
  </tr>
</table>


<!-- 常规信息 -->

<div id="normaldiv">
<table width="650" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#cacaca">
  <tr>
    <td height="150" valign="top" bgcolor="#FFFFFF" >
    <center>
    <table width="98%"  border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td height="15"><img src="<%=imgRootPath%>/spacer.gif" width="1" height="1" class="table-bottom-border1"></td>
        </tr>
    </table>
    <mt:inforHead alt="常规信息" title="常规信息" width="620" heigh="100" imgurl="<%=imgRootPath%>"/>
      <table width="98%"  border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td height="10"><img src="<%=imgRootPath%>/spacer.gif" width="1" height="1"></td>
        </tr>
      </table>
      <table width="95%" align="center" border="0" cellspacing="1" cellpadding="0">
		<tr>
		   <td width="20%" align="left" valign="top">工单名称：</td>
		   <td width="70%" align="left" valign="top"><font class="zi"><%if(!rr.empty(workformName)){out.print(workformName);} %></font></td>
		</tr>
		<tr>
		   <td width="20%" align="left" valign="top">工单触发策略名称：</td>
		   <td width="70%" align="left" valign="top"<%if(!isPortalAdmin){%>style="display:none;"<%}%>>
		   	<input type="text" name="strategyName" value="<%if(!rr.empty(info.getStrategyName())){out.print(info.getStrategyName());} %>" size="25" class="zi">&nbsp;<font color="red">*</font>
		   </td>
		   <%if(!isPortalAdmin){%>
		   	<td width="70%" align="left" valign="top"><font class="zi"><%=PageUtil.nvl(info.getStrategyName()) %></font></td>
		   <%}%>
		</tr>
		<tr>
		   <td width="20%" align="left" valign="top">策略类型：</td>
		   <td width="70%" align="left" valign="top">
		   <table border="0" align="left" width="100%" cellspacing="1" cellpadding="0">
			<tr>
				<td width="40%" align="left" valign="top">
			<%
			for(int i = 0; i < StrategyType.getAll().size(); i++){
				String key = (String)StrategyType.getAll().getKey(i);
				String value = (String)StrategyType.getAll().get(key);
				if((rr.equals(IConsts.S_INCCIDENT, workformType) && !IConsts.EVENT_TYPE_CHANGE.equals(key))
						|| (rr.equals(IConsts.S_CHANGE, workformType) && IConsts.EVENT_TYPE_CHANGE.equals(key))
						|| (!rr.equals(IConsts.S_INCCIDENT, workformType) && !rr.equals(IConsts.S_CHANGE, workformType))){
			%>
				<input name="workformType" type="radio"
				<%if(key.equals(typeRadio)){%>
				checked
				<%}else if(rr.empty(typeRadio) && i == 0){%>
				checked
				<%} %>
				<%if(rr.equals(IConsts.S_CHANGE, workformType) && IConsts.EVENT_TYPE_CHANGE.equals(key)){ %>
				checked
				<%} %>
				 <%if(!isPortalAdmin){ %>disabled<%} %>
				onclick="init();" value="<%=key %>"><%=value %>
			<%}} %>
				</td>
				<td align="left" valign="top">
					<font color="red">*</font><span class="zi1">对应不同的事件类型。</span>
				</td>
			</tr>
			</table>
		   </td>
		</tr>
		<tr <%if(SystemContext.isStandAlone()){ %>style="display:none"<%} %>>
		   <td width="20%" align="left" valign="top">所属域：</td>
		   <td width="70%" align="left" valign="top">
			<span class="zi"><%=UserDomainVO.getUserDomainName() %></span>
			<input name="userdomainId" type="hidden" value="<%=itomDomainId %>">
		   </td>
		</tr>
		<tr>
		   <td width="20%" align="left" valign="top">资源类型：</td>
		   <td width="70%" align="left" valign="top">
		   <select id="choose_resource" size=10 class="zi" style='width: 155px;height: 68px' name=choose_resource>
		   <%
		   if(!rr.empty(info.getResourceType())){
		   if(IConsts.RESOURCE_CATEGORY.equals(info.getResourceType())) {
			   if(!rr.empty(info.getCategorys())){
				   for(int i = 0; i < info.getCategorys().size(); i++){
					   String categoryid = (String)info.getCategorys().get(i);
					   String categoryname = ResourceQueryMgr.getInstance().getCategoryName(categoryid);
			   %>
		   		<option><%=categoryname %></option>
		   <%}}}else { %>

		   		<option><%=DIYCategoryType.getName(info.getResourceType()) %></option>
		   <%}} %>
		   </select>
		   <%if(isPortalAdmin) {%>
		   <img src="<%=imgRootPath%>/checksoft.gif" width="15" height="15" style="cursor:hand" onclick="displayDiv()">
		   <font color="red">*</font><span class="zi1">选择触发工单的资源的类型。</span>
		   <%} %>
		   </td>
		</tr>
		<tr>
		   <td width="20%" align="left" valign="top">备注：</td>
		   <td width="70%" align="left" valign="top">
		   <%if(isPortalAdmin) {%>
		   		<input name="remark" type="text" value="<%if(!rr.empty(info.getRemark())){out.print(info.getRemark()); }%>" size="40" class="zi">
		   <%}else {%>
			    <input name="remark" type="hidden" value="<%if(!rr.empty(info.getRemark())){out.print(info.getRemark()); }%>">
		   <%
		   		out.print(PageUtil.nvl(info.getRemark()));
		   } %>
		   </td>
		</tr>
		</table>
	<mt:inforFoot imgurl="<%=imgRootPath%>"/>
	</center>
	  <table width="98%"  border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td height="5"><img src="<%=imgRootPath%>/spacer.gif" width="1" height="1" class="table-bottom-border1"></td>
        </tr>
      </table>
      <table width="96%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td height="32" align="right"><table width="1%" align="right" cellpadding="0" cellspacing="0">
              <tr>
                <td width="1"></td>
              </tr>
            </table>
              <table width="0%" align="right" cellpadding="0" cellspacing="0">
                <tr>
                  <td><img src="<%=imgRootPath%>/left.jpg" width="6" height="22"></td>
                  <td width="45" background="<%=imgRootPath%>/mid.jpg"><div align="center"><span class="zi"  style="cursor:hand;" onclick="NextDiv('resourcediv');">下一步</span></div></td>
                  <td><img src="<%=imgRootPath%>/right.jpg" width="6" height="22"></td>
                </tr>
            </table></td>
        </tr>
      </table>
		</td>
	  </tr>
	</table>
<div id="resourcetype" style="position:relative; left:115px; top:-60px; width:210px; z-index:3; background-color: #FFFFFF; layer-background-color: #FFFFFF; border: 1px none #000000;display:none">
  <table width="100%" cellpadding="0" cellspacing="1" bgcolor="#6699CC">
    <tr>
      <td align="center" valign="top" bgcolor="#FFFFFF">
      <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td height="22" align="center" valign="middle" background="<%=imgRootPath%>/bg002.jpg" class="table-bottom-border"><div align="left"> <strong>&nbsp;&nbsp;&nbsp;选择触发工单的资源的类型</strong></div></td>
          <td width="30" align="center" background="<%=imgRootPath%>/bg002.jpg" class="table-bottom-border"><img src="<%=imgRootPath%>/gb.gif" style="cursor:pointer" width="19" height="19" onClick="closeDiv();"></td>
        </tr>
      </table>
          <table width="100%"  border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td colspan="4" align="left">
                  <table width="98%"  border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td><img src="<%=imgRootPath%>/images/spacer.gif" width="1" height="1"></td>
                    </tr>
                </table>
              </td>
            </tr>
            <%if(!rr.empty(category_list)){ %>
            <tr>
              <td colspan="4" align="left" valign="middle" bgcolor="#F1F1F1" class="table-bottom-border2">
              <div align="left"><strong>
                <input name="resourceTypeRadio" type="radio" value="<%=IConsts.RESOURCE_CATEGORY %>" checked>
                <input name="othersname" type="hidden" value="othersname">
              </strong>资源</div></td>
            </tr>
            <tr>
              <td align="left">&nbsp;</td>
              <td colspan="3" align="left"><strong>
                <input type="checkbox" name="allmode" value="checkbox" onclick="allSelect(this);">
              </strong>全部</td>
            </tr>
            <%
            	for(int i = 0; i < category_list.size(); i++){
            		CategoryVO category = (CategoryVO)category_list.get(i);
            		if(i < category_list.size() - 1){
            %>
            <tr>
              <td width="11%" align="left">&nbsp;</td>
              <td width="10%" background="<%=imgRootPath%>/joinbottom.gif">&nbsp;</td>
              <td align="left">
                <input type="checkbox" name="categoryid" value="<%=category.getId() %>" onclick="singleSelect(this);" <%if(info.getCategorys().contains(category.getId())){ %>checked<%} %>>
                <input type="hidden" name="categoryname" value="<%=category.getName() %>">
                <%=category.getName() %>
              </td>
              <td width="3%" align="left">&nbsp;</td>
            </tr>
            <%}else if(i == category_list.size() - 1) {%>
            <tr>
              <td width="11%" valign="top">&nbsp;</td>
              <td width="10%" valign="top"><img src="<%=imgRootPath%>/join.gif" width="19" height="16"></td>
              <td align="left">
                <input type="checkbox" name="categoryid" value="<%=category.getId() %>" onclick="singleSelect(this);" <%if(info.getCategorys().contains(category.getId())){ %>checked<%} %>>
                <input type="hidden" name="categoryname" value="<%=category.getName() %>"><%=category.getName() %></td>
              <td align="left">&nbsp;</td>
            </tr>
            <%}} %>
            <tr>
              <td valign="top">&nbsp;</td>
              <td>&nbsp;</td>
              <td><div align="left"></div></td>
              <td align="left">&nbsp;</td>
            </tr>
            <%} %>
            <%
            if(!rr.empty(list)){
            	for(int i = 0; i < list.size(); i++){
            		CategoryVO category = (CategoryVO)list.get(i);
            %>
            <tr>
              <td colspan="4" align="left" valign="middle" bgcolor="#F1F1F1" class="table-bottom-border2">
                <input name="resourceTypeRadio" type="radio" value="<%=category.getId() %>" <%if(rr.equals(category.getId(),info.getResourceType())){ %>checked<%} %>>
                <input name="othersname" type="hidden" value="<%=category.getName() %>">
                <%=category.getName() %></td>
            </tr>
            <%}} %>
        </table>
        <table width="94%"  border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td height="30"><div align="right">
              <img src="<%=imgRootPath%>/an_tanchu_queding.GIF" style="cursor:pointer" width="35" height="17" hspace="3" onClick="selectResource();">
              <img src="<%=imgRootPath%>/an_tanchu_quxiao.GIF" style="cursor:pointer" width="35" height="17" onClick="closeDiv();"></div></td>
            </tr>
        </table></td>
    </tr>
  </table>
</div>
</div>

<!-- 处理人 -->
<div id="handlerdiv" style="display:none;">
<table width="650" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#cacaca">
  <tr>
    <td height="150" valign="top" bgcolor="#FFFFFF" >
    <table width="98%"  border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td height="15"><img src="<%=imgRootPath%>/spacer.gif" width="1" height="1" class="table-bottom-border1"></td>
        </tr>
    </table>
    <center>
    <mt:inforHead alt="首环节处理人" title="首环节处理人" width="620" heigh="100" imgurl="<%=imgRootPath%>"/>
      <table width="95%" border="0" align="center" cellpadding="1" cellspacing="0">
		    <tr>
		      <td height="26" colspan="3" align="left" valign="bottom" class="table-bottom-border2"><div align="left"><img src="<%=imgRootPath%>/kp-help.JPG" width="76" height="16" vspace="2" align="absmiddle"></div></td>
		    </tr>
		    <tr>
		      <td width="45%" height="26" align="left" valign="bottom"><div align="left">候选人员：</div></td>
		      <td width="9%" align="left" valign="bottom"><div align="left"></div></td>
		      <td width="46%" align="left" valign="bottom"><div align="left">已选人员：</div></td>
		    </tr>
		    <tr>
		      <td align="left" valign="top">
		      	<table width="100%" align="center" cellpadding="0" cellspacing="0" border="0">
		          <tr>
		            <td height="200" valign="top" class="boder-all-gray">
					<table width="100%" cellpadding="0" cellspacing="0" border="0">
		                <tr>
		                  <td width="10%" align="left" background="<%=imgRootPath%>/grid3-hrow.gif"><input type="checkbox" name="left_all" value=""  onclick="ClickALL(this, 'left');" <%if(!isPortalAdmin) {%>disabled<%} %>></td>
		                  <td width="45%" align="left" background="<%=imgRootPath%>/grid3-hrow.gif"><strong>姓名</strong></td>
		                  <td width="45%" align="left" background="<%=imgRootPath%>/grid3-hrow.gif"><strong>用户名</strong></td>
		                </tr>
		            	<tr><td colspan="3">
		                <div id="left_person" style="overflow:auto;height:195px">
		                <table width="215" cellpadding="0" cellspacing="0">
		                <%if(!rr.empty(left_list)) {%>
		                <%	for(int i=0; i<left_list.size(); i++) {
		                		UserVO hvo = (UserVO)left_list.get(i);
		                %>
		                <tr>
		                  <td width="11%" align="left"><input type="checkbox" name="left_handler" value="<%=hvo.getUserId() %>" <%if(!isPortalAdmin) {%>disabled<%} %>></td>
		                  <td width="52%" align="left"><%=hvo.getUserName()%></td>
		                  <td width="41%" align="left"><%=hvo.getUserId()%></td>
		                </tr>
		                <%}%>
		                <%} else{ %>
		                <tr>
		                  <td height="23" align="left">&nbsp;</td>
		                  <td align="left" bgcolor="#FFFFFF">&nbsp;</td>
		                  <td align="left">&nbsp;</td>
		                </tr>
		                <%} %>
		                </table>
		                </div>
		                </td></tr>
		            </table></td>
		          </tr>
		      </table>
		      </td>
		      <td align="left">
		      		  <div align="center"><img src="<%=imgRootPath%>/jiantou.gif" width="23" height="20" vspace="4" <%if(isPortalAdmin) {%>style="cursor:hand" onclick="rightMove();"<%} %>><br>
		              <img src="<%=imgRootPath%>/jiantou-2.gif" width="23" height="20" vspace="4" <%if(isPortalAdmin) {%>style="cursor:hand" onclick="leftMove();"<%} %>></div>
		      </td>
		      <td align="left" valign="top">
		      <table width="100%" align="center" cellpadding="0" cellspacing="0">
		          <tr>
		            <td height="200" valign="top" class="boder-all-gray">
		            <table width="100%" cellpadding="0" cellspacing="0">
		                <tr>
		                  <td width="10%" align="left" background="<%=imgRootPath%>/grid3-hrow.gif"><input type="checkbox" name="right_all" value="" onclick="ClickALL(this,'right');" <%if(!isPortalAdmin) {%>disabled<%} %>></td>
		                  <td width="45%" align="left" background="<%=imgRootPath%>/grid3-hrow.gif"><strong>姓名</strong></td>
		                  <td width="45%" align="left" background="<%=imgRootPath%>/grid3-hrow.gif"><strong>用户名</strong></td>
		                </tr>
		            	<tr><td colspan="3">
		                <div id="right_person" style="overflow:auto;height:195px">
		                <table width="215" cellpadding="0" cellspacing="0">
		                <%if(!rr.empty(right_list)) {%>
		                <%	for(int i=0; i<right_list.size(); i++) {
		                		HandlerVO hvo = (HandlerVO)right_list.get(i);
		                %>
		                <tr>
		                  <td width="12%" align="left"><input type="checkbox" name="right_handler" value="<%=hvo.getHandlerId() %>" <%if(!isPortalAdmin) {%>disabled<%} %>></td>
		                  <td width="53%" align="left"><%=hvo.getHandlerName() %></td>
		                  <td width="35%" align="left"><%=hvo.getHandlerId() %></td>
		                </tr>
		                <%}%>
		                <%} else{ %>
		                <tr>
		                  <td height="23" align="left">&nbsp;</td>
		                  <td align="left" bgcolor="#FFFFFF">&nbsp;</td>
		                  <td align="left">&nbsp;</td>
		                </tr>
		                <%} %>
		                </table>
		                </div>
		                </td></tr>
		            </table></td>
		          </tr>
		      </table></td>
		    </tr>
		</table>
		<mt:inforFoot imgurl="<%=imgRootPath%>"/>
		</center>
		<table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
		  <tr>
		    <td width="89%" height="32" align="right">
		    <table width="0%" align="right" cellpadding="0" cellspacing="0">
		        <tr>
		          <td><img src="<%=imgRootPath%>/left.jpg" width="6" height="22"></td>
		          <td width="45" background="<%=imgRootPath%>/mid.jpg"><div align="center"><span class="zi" style="cursor:hand;" onclick="PreDiv('normaldiv');">上一步</span></div></td>
		          <td><img src="<%=imgRootPath%>/right.jpg" width="6" height="22"></td>
		        </tr>
		    </table>
		    </td>
		    <td width="11%" align="right"><table width="0%" align="right" cellpadding="0" cellspacing="0">
		      <tr>
		        <td><img src="<%=imgRootPath%>/left.jpg" width="6" height="22"></td>
		        <td width="45" background="<%=imgRootPath%>/mid.jpg"><div align="center"><span class="zi" style="cursor:hand;" onclick="NextDiv('resourcediv');">下一步</span></div></td>
		        <td><img src="<%=imgRootPath%>/right.jpg" width="6" height="22"></td>
		      </tr>
		    </table></td>
		  </tr>
		</table>
   </td>
  </tr>
</table>
</div>

<!-- 资源选择 -->
<div id="resourcediv" style="display:none">
<table width="650" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#cacaca">
  <tr>
    <td height="150" valign="top" bgcolor="#FFFFFF" >
<iframe id="res_iframe" name="res_iframe" width="100%" height="450" frameborder=0 valign="top" scrolling="no" src=""></iframe>
</td></tr></table>
</div>
<!-- 条件设置 -->
<div id="conditiondiv" style="display:none">
<iframe id="condition_iframe" name="condition_iframe" width="100%" height="450" frameborder=0 valign="top" scrolling="no" src=""></iframe>
</div>
<!-- 完成描述 -->
<div id="finishdiv" style="display:none">
</div>
</form>
</div>
<!-- 提交到IFRAME-->
<IFRAME width=0 height=0  FRAMEBORDER=0  name="strategy_def_jsp"></IFRAME>
<div id="theEnd" style="position:relative"></div>
</BODY>
</HTML>
<script language="javascript">
function dyniframesize(iframename) {
var FFextraHeight=16;
   var pTar = null;
   if (document.getElementById){
     pTar = document.getElementById(iframename);
   }
   else{
     eval('pTar = ' + iframename + ';');
   }
   if (pTar && !window.opera){
     //begin resizing iframe
     pTar.style.display='block';
     if (pTar.contentDocument && pTar.contentDocument.body.offsetHeight){
        //ns6 syntax
        pTar.height = pTar.contentDocument.body.offsetHeight+FFextraHeight;
     }
     else if (pTar.Document && pTar.Document.body.scrollHeight){
        //ie5+ syntax
        pTar.height = pTar.Document.body.scrollHeight;
     }
   }
}
function alltotrim(){
	for (var i = 0; i < document.formname.elements.length; i++){
           if(document.formname.elements[i].type == "text"){
			document.formname.elements[i].value=document.formname.elements[i].value.trim();
		   }
	}
}
function checkForm(){
	alltotrim();

	<%if(!rr.empty(strategyId)) { %>
		var flag = getResonseFromUrl("strategy_check_action.jsp?strategyId=<%=strategyId%>");
		if("false" == flag.trim()){
			openModalWindowLong("<%=path%>", "itpm.strategy.already.delete");
			return false;
		}
	<%} %>

	if(!checkNullField(document.formname.strategyName,'itpm.strategy.define.strategyName.noNull','<%=path%>')){
		   return false;
	}
	if(!checkLawlessChar(document.formname.strategyName,'itpm.strategy.define.strategyName.illegalchar','<%=path%>')){
		   return false;
	}
	if (!checkMaxLength(document.formname.strategyName,'itpm.strategy.define.strategyName.maxlength', '30',"<%=path%>")){
		   return false;
	}
	if(!checkLawlessChar(document.formname.remark,'itpm.strategy.define.remak.illegalchar','<%=path%>')){
		   return false;
	}
	if (!checkMaxLength(document.formname.remark,'itpm.strategy.define.remak.maxlength', '200',"<%=path%>")){
		   return false;
	}

	return true;
}
function ClickALL(e, type) {
	var value = "";
	if(e.checked){
		value = true;
	}else {
		value = false;
	}
	var arrays = document.getElementsByName(type+"_handler");
	if(arrays != undefined) {
		for(i=0; i<arrays.length; i++) {
			arrays[i].checked=value;
		}
	}
}

function doSubmit() {
 	if(checkForm()){
	  window.frames["res_iframe"].doSubmit();
	  var workformType = document.formname.memory.value;
	  if(workformType == "<%=IConsts.EVENT_TYPE_CHANGE %>"){
		  doStart();
		  document.formname.submit_res_condition.value = "<%=ItpmConfig.get("default_condtion") %>";
		  document.formname.submit_res_subcondition.value = "<%=ItpmConfig.get("default_condtion") %>";
		  document.formname.sendType.value = null;
		  document.formname.sendFreq.value = null;
		  document.formname.sendUnit.value = null;
		  document.formname.sendCount.value = null;
		  document.formname.action="strategy_def_action.jsp";
		  document.formname.target="strategy_def_jsp";
		  document.formname.submit();
	  }else{
		  if(window.frames["condition_iframe"].doSubmit()){
		  	  doStart();
			  document.formname.action="strategy_def_action.jsp";
			  document.formname.target="strategy_def_jsp";
			  document.formname.submit();
		  }
	  }
 	}
}

function PreDiv(div_url) {

	<%if(!rr.empty(strategyId)) { %>
		var flag = getResonseFromUrl("strategy_check_action.jsp?strategyId=<%=strategyId%>");
		if("false" == flag.trim()){
			openModalWindowLong("<%=path%>", "itpm.strategy.already.delete");
			return false;
		}
	<%} %>

	var array = document.formname.div_id.value.split(",");
	var flag = "false";
	for( i=0; i<array.length; i++) {
		document.getElementById(array[i]).style.display="none";
		var str = array[i].substring(0,array[i].length-3);
		var imagearr = document.getElementsByName(str+"image");
		var image_grayarr = document.getElementsByName(str+"image_gray");
		if(i != 0){
			var spanlight = document.getElementById(str+"span");
			var spangray = document.getElementById(str+"span_gray");
		}
		if((div_url != array[i] && flag == "false") || array[i] == div_url){
			for(var m = 0; m < imagearr.length; m++){
				imagearr[m].style.display = "";
				image_grayarr[m].style.display = "none";
			}
			if(i != 0){
				spanlight.style.display = "";
				spangray.style.display = "none";
			}
		}else{
			for(var n = 0; n < imagearr.length; n++){
				imagearr[n].style.display = "none";
				image_grayarr[n].style.display = "";
			}
			if(i != 0){
				spanlight.style.display = "none";
				spangray.style.display = "";
			}
		}
		if(array[i] == div_url){
			flag = "true";
		}
	}
	document.getElementById(div_url).style.display="";
}

function NextDiv(div_url) {
	alltotrim();

	<%if(!rr.empty(strategyId)) { %>
		var flag = getResonseFromUrl("strategy_check_action.jsp?strategyId=<%=strategyId%>");
		if("false" == flag.trim()){
			openModalWindowLong("<%=path%>", "itpm.strategy.already.delete");
			return false;
		}
	<%} %>

	if(!checkNullField(document.formname.strategyName,'itpm.strategy.define.strategyName.noNull','<%=path%>')){
		   return false;
	}
	if(!checkLawlessChar(document.formname.strategyName,'itpm.strategy.define.strategyName.illegalchar','<%=path%>')){
		   return false;
	}
	if (!checkMaxLength(document.formname.strategyName,'itpm.strategy.define.strategyName.maxlength', '30',"<%=path%>")){
		   return false;
	}
	if(checkNameExist().trim() == 'true'){
		openModalWindowLong('<%=path%>', 'itpm.strategy.define.strategyName.exist');
		return false;
	}

	if(document.getElementById("choose_resource").length == 0){
		openModalWindowLong('<%=path%>', 'pleaseSelectType');
		return false;
	}
	if(!checkLawlessChar(document.formname.remark,'itpm.strategy.define.remak.illegalchar','<%=path%>')){
		   return false;
	}
	if (!checkMaxLength(document.formname.remark,'itpm.strategy.define.remak.maxlength', '200',"<%=path%>")){
		   return false;
	}
	var array = document.formname.div_id.value.split(",");
	var flag = "false";
	for( i=0; i<array.length; i++) {
		document.getElementById(array[i]).style.display="none";
		var str = array[i].substring(0,array[i].length-3);
		var imagearr = document.getElementsByName(str+"image");
		var image_grayarr = document.getElementsByName(str+"image_gray");
		if(i != 0){
			var spanlight = document.getElementById(str+"span");
			var spangray = document.getElementById(str+"span_gray");
		}
		if((div_url != array[i] && flag == "false") || array[i] == div_url){
			for(var m = 0; m < imagearr.length; m++){
				imagearr[m].style.display = "";
				image_grayarr[m].style.display = "none";
			}
			if(i != 0){
				spanlight.style.display = "";
				spangray.style.display = "none";
			}
		}else{
			for(var n = 0; n < imagearr.length; n++){
				imagearr[n].style.display = "none";
				image_grayarr[n].style.display = "";
			}
			if(i != 0){
				spanlight.style.display = "none";
				spangray.style.display = "";
			}
		}
		if(array[i] == div_url){
			flag = "true";
		}
	}
	document.getElementById(div_url).style.display="";
}

function checkNameExist(){
	var strategyName = document.formname.strategyName.value;
	var oldStrategyName = document.formname.oldStrategyName.value;
    var flag = getResonseFromUrl("strategy_def_action.jsp?check=check&strategyName="+encodeURIComponent(strategyName)+"&oldStrategyName="+encodeURIComponent(oldStrategyName));
    return flag;
}

function rightMove() {
	var left_array = document.getElementsByName("left_handler");
	var right_array = document.getElementsByName("right_handler");
	var left_str = "";
	var right_str = "";
	var flag = false;
	if(right_array != undefined && right_array.length > 0) {
		for(i=0; i<right_array.length; i++) {
			right_str += right_array[i].value+",";
		}
	}

	if(left_array != undefined && left_array.length > 0){
		for(i=0; i<left_array.length; i++) {
			if(left_array[i].checked) {
				flag = true;
				right_str += left_array[i].value+",";
			}else {
				left_str += left_array[i].value+",";
			}
		}
	}else{
		openModalWindowLong('<%=path%>', 'noHaveUser');
		return false;
	}

	if(!flag) {
		openModalWindowLong('<%=path%>', 'pleaseSelectUser');
		return false;
	}
	if(right_str != "") {
		right_str = right_str.substring(0,right_str.length-1);
	}
	if(left_str != "") {
		left_str = left_str.substring(0,left_str.length-1);
	}
	document.formname.right_sel_person.value = right_str;
	document.formname.left_sel_person.value = left_str;
	//alert(right_str);
	//alert(left_str);
	document.formname.target = "strategy_def_jsp";
	document.formname.action = "move_handler.jsp";
	document.formname.submit();
}

function leftMove() {

	var left_array = document.getElementsByName("left_handler");
	var right_array = document.getElementsByName("right_handler");
	var left_str = "";
	var right_str = "";
	var flag = false;
	if(left_array != undefined && left_array.length > 0) {
		for(i=0; i<left_array.length; i++) {
			left_str += left_array[i].value+",";
		}
	}
	if(right_array != undefined && right_array.length > 0){
		for(i=0; i<right_array.length; i++) {
			if(right_array[i].checked) {
				flag = true;
				left_str += right_array[i].value+",";
			}else {
				right_str += right_array[i].value+",";
			}
		}
	}else{
		openModalWindowLong('<%=path%>', 'noHaveUser');
		return false;
	}

	if(!flag) {
		openModalWindowLong('<%=path%>', 'pleaseSelectUser');
		return false;
	}
	if(right_str != "") {
		right_str = right_str.substring(0,right_str.length-1);
	}
	if(left_str != "") {
		left_str = left_str.substring(0,left_str.length-1);
	}
	document.formname.right_sel_person.value = right_str;
	document.formname.left_sel_person.value = left_str;
	//alert(right_str);
	//alert(left_str);
	document.formname.target = "strategy_def_jsp";
	document.formname.action = "move_handler.jsp";
	document.formname.submit();
}
//切换选择资源页面
function changeResourcePage() {
}
function closeDiv(){
	document.getElementById("resourcetype").style.display = "none";
}
function displayDiv(){
	document.getElementById("resourcetype").style.display = "";
}

function allSelect(e){
 var single = document.getElementsByName("categoryid");
 if(single != undefined && single.length > 0){
  for(var i = 0; i < single.length; i++){
   single[i].checked = e.checked;
  }
 }
}

function singleSelect(e){
 var all = document.formname.allmode;
 if(!e.checked){
  all.checked = e.checked;
 }
}

function selectResource(){
	<%if(!rr.empty(strategyId)) { %>
		var flag = getResonseFromUrl("strategy_check_action.jsp?strategyId=<%=strategyId%>");
		if("false" == flag.trim()){
			openModalWindowLong("<%=path%>", "itpm.strategy.already.delete");
			return false;
		}
	<%} %>
	var radiotype = document.getElementsByName("resourceTypeRadio");
	var radioname = document.getElementsByName("othersname");
	var categoryidstr = "";
	for(var i = 0; i < radiotype.length; i++){
		if(radiotype[i].checked){
			if(radiotype[i].value == '<%=IConsts.RESOURCE_CATEGORY %>'){
				var categoryid = document.getElementsByName("categoryid");
				var categoryname = document.getElementsByName("categoryname");
				if(categoryid != undefined && categoryid.length > 0){
					document.getElementById("choose_resource").length = 0;
					for(var j = 0; j < categoryid.length; j++){
						if(categoryid[j].checked){
							var newObj = new Option(categoryname[j].value);
							document.getElementById("choose_resource").add(newObj);
							categoryidstr = categoryidstr + categoryid[j].value + ",";
						}
					}
					categoryidstr = categoryidstr.substring(0,categoryidstr.length-1);
					document.formname.categoryidstr.value = categoryidstr;
				}
				document.formname.target = "res_iframe";
				document.formname.action = "<%=CategoryURLType.getName(IConsts.RESOURCE_CATEGORY) %>";
				document.formname.submit();
				document.formname.target = "condition_iframe";
				document.formname.action = "<%=ConditionURLType.getName(IConsts.RESOURCE_CATEGORY) %>";
				document.formname.submit();
			}else{
				document.getElementById("choose_resource").length = 0;
				var newObj = new Option(radioname[i].value);
				document.getElementById("choose_resource").add(newObj);
				categoryidstr = radiotype[i].value;
				document.formname.categoryidstr.value = categoryidstr;
				document.formname.target = "res_iframe";
				<%for(int i = 0; i < CategoryURLType.getAll().size(); i++){ %>
					if(radiotype[i].value == '<%=CategoryURLType.getAll().getKey(i) %>'){
						document.formname.action = "<%=CategoryURLType.getAll().getValue(i) %>";
					}
				<%} %>
				document.formname.submit();
				document.formname.target = "condition_iframe";
				<%for(int i = 0; i < ConditionURLType.getAll().size(); i++){ %>
					if(radiotype[i].value == '<%=ConditionURLType.getAll().getKey(i) %>'){
						document.formname.action = "<%=ConditionURLType.getAll().getValue(i) %>";
					}
				<%} %>
				document.formname.submit();
			}
		}
	}
	closeDiv();
}
//根据不同的工单类型显示不同页面
function changePageDisplay() {
	var workformType = document.formname.memory.value;
	if(workformType == "<%=IConsts.EVENT_TYPE_CHANGE %>") {
		window.frames["res_iframe"].document.getElementById("next_button").style.display = "none";
		window.frames["res_iframe"].document.getElementById("finish_button").style.display = "";
	}else{
		window.frames["res_iframe"].document.getElementById("next_button").style.display = "";
		window.frames["res_iframe"].document.getElementById("finish_button").style.display = "none";
	}
}

function changeTitleDisplay() {
	var workformType = document.formname.memory.value;
	if(workformType == "<%=IConsts.EVENT_TYPE_CHANGE %>") {
		document.formname.div_id.value = "normaldiv,resourcediv,finishdiv";
		document.getElementById("<%=IConsts.S_INCCIDENT %>_title").style.display = "none";
		document.getElementById("<%=IConsts.S_CHANGE %>_title").style.display = "";
	}else { //==_incident or other
		document.formname.div_id.value = "normaldiv,resourcediv,conditiondiv,finishdiv";
		document.getElementById("<%=IConsts.S_INCCIDENT %>_title").style.display = "";
		document.getElementById("<%=IConsts.S_CHANGE %>_title").style.display = "none";
	}
}

function setMemory(){
	var workformType = document.getElementsByName("workformType");
	for(var i = 0; i < workformType.length; i++){
		if(workformType[i].checked){
			document.formname.memory.value = workformType[i].value;
		}
	}
}

function init() {
	setMemory();
	changeTitleDisplay();
	selectResource();
}
</script>
