<%@ page language="java" contentType="text/html; charset=UTF-8"  errorPage="/modules/common/error.jsp"%>
<jsp:directive.page import="com.mocha.dev.ReqRes"/>
<jsp:directive.page import="java.util.List"/>
<jsp:directive.page import="com.mocha.bsm.itom.mgr.StrategyMgr"/>
<jsp:directive.page import="com.mocha.bsm.itom.vo.StrategyInfoVO"/>
<jsp:directive.page import="com.mocha.bsm.itom.mgr.plugin.ResourceQueryMgr"/>
<jsp:directive.page import="com.mocha.bsm.itom.util.PageUtil"/>
<jsp:directive.page import="com.mocha.bsm.itom.type.DIYCategoryType"/>
<jsp:directive.page import="com.mocha.bsm.itom.mgr.XmlCommunication"/>
<jsp:directive.page import="com.mocha.bsm.itom.common.IConsts"/>
<jsp:directive.page import="com.mocha.bsm.itom.vo.xml.WorkFormTypeVO"/>
<jsp:directive.page import="java.util.ArrayList"/>
<jsp:directive.page import="com.mocha.dev.ListMap"/>
<jsp:directive.page import="com.mocha.bsm.itom.vo.CategoryVO"/>
<jsp:directive.page import="com.mocha.bsm.itom.type.QueryResourceURLType"/>
<jsp:directive.page import="com.mocha.bsm.itom.view.UserDomainManage"/>
<%@ include file="/modules/common/security.jsp" %>
<%
	ReqRes rr = new ReqRes(request, response);
	rr.encoding("UTF-8").nocache().security();

	String workformId = rr.param("workformId", null);
	String workformName = rr.param("workformName", null);
	String workformType = rr.param("workformType", null);
	String itomDomainId = rr.param("itomDomainId", null);
	String sou_type = rr.param("sou_type", null);
	String common_condition = rr.param("common_condition", null);
	if(rr.empty(common_condition) || i18n.key("itpm.strategy.define.search.note").equals(common_condition)){
		common_condition = null;
	}
	String up_resname = rr.param("up_resname", null);
	if(rr.empty(up_resname)){
		up_resname = null;
	}
	String up_ip = rr.param("up_ip", null);
	if(rr.empty(up_ip)){
		up_ip = null;
	}
	String up_category = rr.param("up_category", null);
	if(rr.empty(up_category)){
		up_category = null;
	}
	String up_workform = rr.param("up_workform", null);
	if(rr.empty(up_workform)){
		up_workform = null;
	}

	//取工单
	List workform_list = XmlCommunication.getInstance().query_workform_list(currentUserId, itomDomainId);

	//取资源种类组
	List category_list = ResourceQueryMgr.getInstance().query_all_category();//资源
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
    category_list.addAll(list);

	List common_strategy_list = null;
	List up_strategy_list = null;
	if(rr.equals("up_query", sou_type)){
		up_strategy_list = StrategyMgr.getInstance().strategy_list_query(up_resname, up_ip, up_category, up_workform, itomDomainId);
	}else if(rr.equals("common_query", sou_type)){
		common_strategy_list = StrategyMgr.getInstance().strategy_list_query(common_condition, workformId, itomDomainId);
	}else{
		if(!rr.empty(workformId)) {
			common_strategy_list = StrategyMgr.getInstance().queryNormalInfoByWrokformId(workformId, itomDomainId);
		}
	}

	ListMap queryResource = QueryResourceURLType.getAll();

   boolean isPortalAdmin = UserDomainManage.getInstance().isPortalAdmin(currentUserId);
	int maxPage = 0;
%>
<html>
<head>
<title></title>
<link href="<%=cssRootPath %>/liye.css" rel="stylesheet" type="text/css">
<link href="<%=cssRootPath %>/css.css" rel="stylesheet" type="text/css">
<link href="<%=cssRootPath %>/liye1.css" rel="stylesheet" type="text/css">
<script src="<%=jsRootPath%>/common.js"></script>
<script src="<%=jsRootPath%>/checkForm.js"></script>
<script src="<%=jsRootPath%>/tools.js"></script>
<script src="<%=jsRootPath%>/utils.js"></script>
<script type="text/javascript">
function init(){
	if(parent&&parent.setHeight){
		try{
			parent.setHeight(getTotalHeight(),'<%=sou_type %>');	
		}catch(e){}
	}
	  
}
</script>
<BODY onload="init()">
<form name="formname" id="formname" action="" method="post" target="strategy_list_jsp">
<input type="hidden" name="del_str" value="" />
<input type="hidden" name="sou_type" value="" />
<input type="hidden" name="workformId" value="<%=workformId %>" />
<input type="hidden" name="workformName" value="<%=workformName %>" />
<input type="hidden" name=workformType value="<%=workformType %>" />
<input type="hidden" name="itomDomainId" value="<%=itomDomainId %>" />
<table width="99%"  border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="24%" align="left" valign="top">
    <img src="<%=imgRootPath %>/spacer.gif" width="1" height="1"></td>
  </tr>
</table>
<!-- 高级搜索 -->
<div id="upsou" <%if(!rr.equals("up_query",sou_type)){ %>style="display:none"<%} %>>
<table width="98%"  border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="39%" height="26" valign="bottom"><div align="left" class="zi1">
      <table cellpadding="0" cellspacing="0">
        <tr>
          <td width="10"><img src="<%=imgRootPath %>/line-left.jpg" width="12" height="26"></td>
          <td width="293" background="<%=imgRootPath %>/kp-line-mid.jpg" style="padding-top:3px">高级搜索条件&nbsp;&nbsp;
          <img src="<%=imgRootPath %>/an-qh.jpg" width="15" height="15" border="0" align="absmiddle" style="cursor:hand" onclick="souDiv('commonsou','upsou');"></td>
          <td width="3"><img src="<%=imgRootPath %>/line-right.jpg" width="38" height="26"></td>
        </tr>
      </table>
    </div></td>
    <td width="39%" valign="bottom" class="table-bottom-border2">&nbsp;</td>
    <td width="22%" class="table-bottom-border2">
    <%if(isPortalAdmin) {%>
    <div align="right">
     <img src="<%=imgRootPath %>/anniu_zblb_add.GIF" alt="<%=i18n.key("CREATE") %>" onclick="addStrategy();" style="cursor:hand" width="11" height="11" hspace="4" border="0" align="absmiddle">
     <img src="<%=imgRootPath %>/an-shanchu.gif" alt="<%=i18n.key("DELETE") %>" onclick="deleteStrategy();" style="cursor:hand" width="11" height="5" hspace="2" align="absmiddle">&nbsp;&nbsp;&nbsp;&nbsp;
     </div>
     <%} %>
     </td>

  </tr>
</table>
<table width="98%" cellspacing="0" cellpadding="0">
  <tr>
    <td height="70" align="center" valign="middle" background="<%=imgRootPath %>/itil-select-bg.jpg" bgcolor="#FFFFFF" class="left-right-border"><table width="97%" cellpadding="0" cellspacing="0"  border="0" style=" background:url(<%=imgRootPath %>/line-bg01.jpg)">
      <tr>
        <td width="100" height="22" align="left" valign="middle" style="padding-top:4px">&nbsp;&nbsp;&nbsp;资源名称：</td>
        <td width="128" align="left" valign="middle" style="padding-top:4px">
        <input name="up_resname" type="text" class="zi" size="15" value="<%if(rr.equals("up_query",sou_type) && !rr.empty(up_resname)){out.print(up_resname);} %>"></td>
        <td width="100" align="left" valign="middle" style="padding-top:4px">&nbsp;&nbsp;&nbsp;IP地址：</td>
        <td width="294" align="left" valign="middle" style="padding-top:4px"><div align="left">
          <input name="up_ip" type="text" class="zi" size="15"value="<%if(rr.equals("up_query",sou_type) && !rr.empty(up_ip)){out.print(up_ip);} %>">
        </div></td>
        <td width="124" colspan="2" align="left" valign="middle" style="padding-top:4px">&nbsp;</td>
      </tr>
      <tr>
        <td height="27" align="left" valign="middle" style="padding-top:4px">&nbsp;&nbsp;&nbsp;资源类型：</td>
        <td align="left" valign="middle" style="padding-top:4px">
          <select name="up_category" class="zi">
	          <option value="">全部</option>
          <%
          if(!rr.empty(category_list)){
	      	  for(int i = 0; i < category_list.size(); i++){
	      		CategoryVO categoryvo = (CategoryVO)category_list.get(i);
	      %>
	      	  <option value="<%=categoryvo.getId() %>" <%if(rr.equals("up_query",sou_type) && rr.equals(up_category,categoryvo.getId())){ %>selected<%} %>><%=categoryvo.getName() %></option>
          <%}} %>
          </select>
        &nbsp;</td>
        <td align="left" valign="middle" style="padding-top:4px"><div align="left">&nbsp;&nbsp;&nbsp;搜索工单：</div></td>
        <td colspan="3" align="left" valign="middle" style="padding-top:4px"><div align="left">
          <select name="up_workform"  class="zi">
          	<option value="">全部</option>
          <%
          if(!rr.empty(workform_list)){
        	  for(int i = 0; i < workform_list.size(); i++){
        		  WorkFormTypeVO workformvo = (WorkFormTypeVO)workform_list.get(i);
        		  List child = workformvo.getChildren();
        		  if(!rr.empty(child)){
        			  for(int j = 0; j < child.size(); j++){
        				  WorkFormTypeVO childvo = (WorkFormTypeVO)child.get(j);
          %>
	          <option value="<%=childvo.getId() %>" <%if(rr.equals("up_query",sou_type) && rr.equals(up_workform, childvo.getId())){ %>selected<%} %>><%=childvo.getName() %></option>
	      <%}}}} %>
          </select>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          <img src="<%=imgRootPath %>/sousuo.gif" alt="<%=i18n.key("SEARCH") %>" width="18" height="18" border="0" align="absmiddle" style="cursor:hand" onclick="sousou('up_query');"></div></td>
        </tr>
    </table></td>
  </tr>
</table>
</div>

<!-- 普通搜索 -->
<div id="commonsou" <%if(rr.equals("up_query",sou_type)){ %>style="display:none"<%} %>>
<table width="98%"  border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="78%" height="26" valign="bottom" class="table-bottom-border2"><div align="left" class="zi1">
      <table cellpadding="0" cellspacing="0">
        <tr>
          <td width="10"><img src="<%=imgRootPath %>/line-left.jpg" width="12" height="26"></td>
          <td width="293" background="<%=imgRootPath %>/kp-line-mid.jpg" style="padding-top:3px"><label>
          <input name="common_condition" type="text" class="input-gray" onfocus="getFocus();" onblur="missFocus();" value="<%if(rr.equals("common_query",sou_type) && !rr.empty(common_condition)){out.print(common_condition);}else{out.print(i18n.key("itpm.strategy.define.search.note"));} %>" size="38">
            <img src="<%=imgRootPath %>/sousuo.gif" alt="<%=i18n.key("SEARCH") %>" width="18" height="18" align="absmiddle" style="cursor:hand" onclick="sousou('common_query');">
            <img id="di" src="<%=imgRootPath %>/kp-an-gaoji-2.GIF" name="Image15" width="40" height="22" border="0" align="absmiddle" style="cursor:hand;display:none" onMouseOut="document.getElementById('di').style.display = 'none';document.getElementById('gao').style.display = '';" onclick="souDiv('upsou','commonsou');"><img id="gao" src="<%=imgRootPath %>/kp-an-gaoji.gif" name="Image15" width="40" height="22" border="0" align="absmiddle" style="cursor:hand" onMouseOver="document.getElementById('di').style.display = '';document.getElementById('gao').style.display = 'none';">
          </label></td>
          <td width="3"><img src="<%=imgRootPath %>/line-right.jpg" width="38" height="26"></td>
        </tr>
      </table>
    </div></td>
    <td width="22%" class="table-bottom-border2">
    <%if(isPortalAdmin) {%>
    <div align="right">
    <img src="<%=imgRootPath %>/anniu_zblb_add.GIF" alt="<%=i18n.key("CREATE") %>" onclick="addStrategy();" style="cursor:hand" width="11" height="11" hspace="4" align="absmiddle">
    <img src="<%=imgRootPath %>/an-shanchu.gif" alt="<%=i18n.key("DELETE") %>" onclick="deleteStrategy();" style="cursor:hand" width="11" height="5" hspace="2" align="absmiddle">&nbsp;&nbsp;&nbsp;&nbsp;
    </div>
    <%} %>
    </td>
  </tr>
</table>
</div>


<table width="98%" align="center" cellpadding="0" cellspacing="0">
  <tr>
	<%
	if(rr.empty(common_strategy_list) && rr.empty(up_strategy_list)){
	%>
	<td>
	<IFRAME name="nodataiframe" width="100%" valign="top" height="300"  marginwidth=0 marginheight=0 FRAMEBORDER=0 scrolling="no" src="<%=path %>/modules/common/blank.jsp" ></IFRAME>
	</td>
	<%
	}else if(!rr.empty(common_strategy_list)){
		if(common_strategy_list.size()%20>0){
			maxPage = common_strategy_list.size()/20+1;
		}else{
			maxPage = common_strategy_list.size()/20;
		}
	%>
	<td class="boder-all-gray">
		<!-- 普通列表 -->
		<table id="ordertable" width="100%" cellpadding="0" cellspacing="0" border="0">
		<thead>
	      <tr>
	        <td width="5%" height="23" align="left" background="<%=imgRootPath %>/grid3-hrow.gif"><input type="checkbox" name="all_record" value="checkbox" onclick="allSelect(this);" <%if(!isPortalAdmin) {%>disabled<%} %>></td>
	       	<td width="25%" align="left" valign="middle" background="<%=imgRootPath%>/grid3-hrow.gif"><strong>工单触发策略名称</strong></td>
	        <td width="15%" align="left" background="<%=imgRootPath %>/grid3-hrow.gif"><strong>策略类型</strong></td>
	        <td width="35%" align="left" background="<%=imgRootPath %>/grid3-hrow.gif"><strong>关联资源类型</strong></td>
	        <td width="20%" align="left" background="<%=imgRootPath %>/grid3-hrow.gif"><strong>触发工单的资源</strong></td>
	      </tr>
	    </thead>
	    <tbody>
	      <%
	     for(int i=0; i<common_strategy_list.size(); i++) {
	    	  StrategyInfoVO info = (StrategyInfoVO) common_strategy_list.get(i);
	    	  StrategyInfoVO vo = (StrategyInfoVO)XmlCommunication.getInstance().fromXMl(info.getXmlInfo());
	    	  String type = "";
	    	  if(IConsts.RESOURCE_CATEGORY.equals(info.getResourceType())) {
    	  		for(int j=0; j < vo.getCategorys().size(); j++) {
    	  			String cname = ResourceQueryMgr.getInstance().getCategoryName((String)vo.getCategorys().get(j));
    	  			if(cname != null){
	    	  			type += cname +",";
    	  			}
    	  		}
    	  		if(type.length() > 0){
    	  			type = type.substring(0, type.length()-1);
    	  		}
	    	  }else {
		    	  	type = DIYCategoryType.getName(info.getResourceType());
	    	  }
	      %>
	      <tr>
	        <td height="23" align="left"><input type="checkbox" name="strategy_record" value="<%=info.getStrategyId() %>" onclick="singleSelect(this);"  <%if(!isPortalAdmin) {%>disabled<%} %>></td>
	        <td align="left" bgcolor="#FFFFFF"><span style="cursor:hand" onclick="editStrategy('<%=info.getStrategyId() %>');"><%=PageUtil.ellipsisNvl(info.getStrategyName(), 180)%></span></td>
	        <td align="left" bgcolor="#FFFFFF"><span><%=PageUtil.ellipsisNvl(i18n.key("itpm.strategy.eventtype."+info.getWorkformType()), 100) %></span></td>
	        <td align="left" bgcolor="#FFFFFF"><span><%=PageUtil.ellipsisNvl(type,180) %></span></td>
	        <td align="left" bgcolor="#FFFFFF"><img src="<%=imgRootPath %>/isTop.gif" onclick="openQueryResource('<%=info.getStrategyId() %>','<%=info.getResourceType() %>','<%=info.getWorkformType() %>');" style="cursor:hand" title="触发工单的资源" width="18" height="16" align="absmiddle"></td>
	      </tr>
	      <%} %>
	      </tbody>
	    </table>
	</td>
    <%}else{ %>
    <td class="boder-all-gray">
    	<!-- 高级搜索列表 -->
    	<table id="ordertable" width="100%" cellpadding="0" cellspacing="0" border="0">
    	<thead>
	      <tr>
	        <td width="5%" height="23" align="left" background="<%=imgRootPath %>/grid3-hrow.gif"><input type="checkbox" name="all_record" value="checkbox" onclick="allSelect(this);"  <%if(!isPortalAdmin) {%>disabled<%} %>></td>
	       	<td width="21%" align="left" valign="middle" background="<%=imgRootPath%>/grid3-hrow.gif"><strong>工单名称</strong></td>
	       	<td width="21%" align="left" valign="middle" background="<%=imgRootPath%>/grid3-hrow.gif"><strong>工单触发策略名称</strong></td>
	        <td width="10%" align="left" background="<%=imgRootPath %>/grid3-hrow.gif"><strong>策略类型</strong></td>
	        <td width="26%" align="left" background="<%=imgRootPath %>/grid3-hrow.gif"><strong>关联资源类型</strong></td>
	        <td width="17%" align="left" background="<%=imgRootPath %>/grid3-hrow.gif"><strong>触发工单的资源</strong></td>
	      </tr>
	    </thead>
	    <tbody>
	      <%
	      if(up_strategy_list.size()%20>0){
			  maxPage = up_strategy_list.size()/20+1;
		  }else{
			  maxPage = up_strategy_list.size()/20;
		  }
	     for(int i=0; i<up_strategy_list.size(); i++) {
	    	  StrategyInfoVO info = (StrategyInfoVO) up_strategy_list.get(i);
	    	  StrategyInfoVO vo = (StrategyInfoVO)XmlCommunication.getInstance().fromXMl(info.getXmlInfo());
	    	  String type = "";
	    	  if(IConsts.RESOURCE_CATEGORY.equals(info.getResourceType())) {
    	  		for(int j=0; j < vo.getCategorys().size(); j++) {
    	  			String cname = ResourceQueryMgr.getInstance().getCategoryName((String)vo.getCategorys().get(j));
    	  			if(cname != null){
	    	  			type += cname +",";
    	  			}
    	  		}
    	  		if(type.length() > 0){
    	  			type = type.substring(0, type.length()-1);
    	  		}
	    	  }else {
		    	  	type = DIYCategoryType.getName(info.getResourceType());
	    	  }
	      %>
	      <tr>
	        <td height="23" align="left"><input type="checkbox" name="strategy_record" value="<%=info.getStrategyId() %>" onclick="singleSelect(this);"  <%if(!isPortalAdmin) {%>disabled<%} %>></td>
	        <td align="left" bgcolor="#FFFFFF"><span style="cursor:hand" onclick="editStrategy('<%=info.getStrategyId() %>');"><%=PageUtil.ellipsisNvl(info.getWorkformName(),120) %></span></td>
	        <td align="left" bgcolor="#FFFFFF"><span><%=PageUtil.ellipsisNvl(info.getStrategyName(), 120)%></span></td>
	        <td align="left" bgcolor="#FFFFFF"><span><%=PageUtil.ellipsisNvl(i18n.key("itpm.strategy.eventtype."+info.getWorkformType()), 80)%></span></td>
	        <td align="left" bgcolor="#FFFFFF"><span><%=PageUtil.ellipsisNvl(type,140) %></span></td>
	        <td align="left" bgcolor="#FFFFFF"><img src="<%=imgRootPath %>/isTop.gif" onclick="openQueryResource('<%=info.getStrategyId() %>','<%=info.getResourceType() %>','<%=info.getWorkformType() %>');" title="触发工单的资源" style="cursor:hand" width="18" height="16" align="absmiddle"></td>
	      </tr>
	      <%} %>
	      </tbody>
	    </table>
	 </td>
    <%} %>
  </tr>
</table>
<%if(maxPage > 1){ %>
<table width="98%"  border="0" cellspacing="0" cellpadding="0">
<tr>
	<td width="35%" height="51" align="left"><span id="current">1</span>/<%=maxPage %></td>
	<td width="35%" align="left">
	<img src="<%=imgRootPath %>/list_home.gif" width="15" height="15" alt="<%=i18n.key("itpm.strategy.firstPage") %>" style="cursor:hand;" onclick="gofirst();">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <img src="<%=imgRootPath %>/list_pre.gif" width="15" height="15" alt="<%=i18n.key("itpm.strategy.frontPage") %>" style="cursor:hand;" onclick="prepage();">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <img src="<%=imgRootPath %>/list_next.gif" width="15" height="15" alt="<%=i18n.key("itpm.strategy.nextPage") %>" style="cursor:hand;" onclick="nextpage();">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <img src="<%=imgRootPath %>/list_end.gif" width="15" height="15" alt="<%=i18n.key("itpm.strategy.lastPage") %>" style="cursor:hand;" onclick="goend();">
    </td>
    <td width="10%" align="left"><%=i18n.key("jumpTo") %></td>
    <td width="4%" align="center"><input name="pageNum" type="text" class="ly" size="3" onkeyup="checkNum(this);" id="pageNumId"></td>
    <td width="4%" align="center"><%=i18n.key("page") %></td>
    <td width="12%" align="center"><img src="<%=imgRootPath %>/goto.gif" width="67" height="21" style="cursor:hand;" onclick="goPage();return false;"></td>
    </tr>
</table>
<%} %>
</form>
<IFRAME width=0 height=0  FRAMEBORDER=0  name="strategy_list_jsp"></IFRAME>
<div id="theEnd" style="position:relative"></div>
</body>
<script type="text/javascript">
var maxPage = <%=maxPage%>;
if(maxPage > 0){
	var pageFor = new Pagination("ordertable",20,false);
	pageFor.firstPage();
}
function gofirst(){
	var current = pageFor.firstPage();
	document.getElementById('current').innerText = parseInt(current);
}
function prepage(){
	var current = pageFor.prePage();
	document.getElementById('current').innerText = parseInt(current);
}
function nextpage(){
	var current = pageFor.nextPage();
	document.getElementById('current').innerText = parseInt(current);
}
function goend(){
	var current = pageFor.lastPage();
	document.getElementById('current').innerText = parseInt(current);
}

function checkNum(obj){
	var val = obj.value;
	var len = val.length;
	for(var i = 0; i<len; i++){
		if((val.charAt(i)>'9') || (val.charAt(i) < '0')){
			obj.value = val.substring(0, i);
			break;
		}
	}

	if (event.keyCode == 13){
		goPage();
	}
}

function goPage(){
	var obj = document.getElementById("pageNumId");
	if (event.keyCode != 13){

	checkNum(obj);

	 }
	var page = document.getElementById("pageNumId").value;
	if(page == ""){
		openModalWindowLong("<%=path%>", "itpm.strategy.pleaseInputPage");
		document.getElementById("pageNumId").focus();
	}else if(Number(page) > maxPage || Number(page) == 0){
		//openModalWindowLong("../..", "EVENT_WRONG_PAGENUM");
		openModalWindowLong("<%=path%>", "itpm.strategy.pleaseInputPage");
		document.getElementById("pageNumId").value = "";
		document.getElementById("pageNumId").focus();
	}else{
		pageFor.gotoPageByNum(page);
		document.getElementById('current').innerText = page;
	}
}

function getFocus(){
	var value = document.formname.common_condition.value;
	if(value.trim() == "<%=i18n.key("itpm.strategy.define.search.note")%>"){
		document.formname.common_condition.value = "";
	}
}

function missFocus(){
	var value = document.formname.common_condition.value;
	if(value.trim() == ""){
		document.formname.common_condition.value = "<%=i18n.key("itpm.strategy.define.search.note")%>";
	}
}

function openQueryResource(strategyId,strategyType,typeRadio) {
	try{
		parent.frames['queryResoruceiframe'].doStart();
	}catch(e){
	}
	<%
	if(!rr.empty(queryResource)){
		for(int i = 0; i < queryResource.size(); i++){
	%>
		if(strategyType == '<%=queryResource.getKey(i) %>'){
			parent.document.getElementById("queryResoruceiframe").src = "<%=queryResource.getValue(i) %>?strategyId="+strategyId+"&typeRadio="+typeRadio;
		}
	<%
	}}
	%>
	parent.document.getElementById("queryresourcediv").style.display = "";
}
function addStrategy(){
	openPreWindow("strategy_def.jsp?workformId=<%=workformId%>&workformName="+encodeURIComponent('<%=workformName%>')+"&workformType=<%=workformType%>&itomDomainId=<%=itomDomainId%>",700,580,"strategydef");
}

function editStrategy(strategyId) {
	var flag = getResonseFromUrl("strategy_check_action.jsp?strategyId="+strategyId);
	if("false" == flag.trim()){
		openModalWindowLong("<%=path%>", "itpm.strategy.already.delete");
		parent.changeRightPage2('/bsmitom/itpm/strategy/strategy_list.jsp','<%=workformId %>','<%=workformName %>', '<%=workformType %>');
	}else{
		openPreWindow("strategy_def.jsp?strategyId="+strategyId,700,580,"strategydef");
	}
}

function deleteStrategy(){
	var flag = false;
	var arr = document.getElementsByName("strategy_record");
	if(arr != undefined && arr.length > 0){
		var del_str = "";
		for(var i = 0; i<arr.length ; i++){
	   		if(arr[i].checked){
	   			flag = true;
	   			del_str += arr[i].value+",";
			}
		}
		if(!flag){
			openModalWindowLong('<%=path%>', 'pleaseSelect');
			return false;
		}
		var return_value = openModalWindowYesOrNo('<%=path%>', 'ifDel');
   		if(!return_value){
    		return false;
     	}
     	//parent.doStart();
     	del_str = del_str.substring(0, del_str.length-1);
     	document.formname.del_str.value = del_str;
     	document.formname.target = "strategy_list_jsp";
     	document.formname.action = "del_strategy_list.jsp";
     	document.formname.submit();
	}else{
	    //alert('没有要删除的纪录');
		openModalWindowLong('<%=path%>', 'noDelData');
		return false;
	}
}

function allSelect(e){
 var single = document.getElementsByName("strategy_record");
 if(single != undefined && single.length > 0){
  for(var i = 0; i < single.length; i++){
   single[i].checked = e.checked;
  }
 }
}

function singleSelect(e){
 var all = document.formname.all_record;
 if(!e.checked){
  all.checked = e.checked;
 }
}

function souDiv(first,end){
	document.getElementById(first).style.display = "";
	document.getElementById(end).style.display = "none";
}

function sousou(sou_type){
	//parent.doStart();
	if('up_query' == sou_type) {
		parent.focusNodeFont();
	}
	document.formname.sou_type.value = sou_type;
	document.formname.target = "";
    document.formname.action = "strategy_list.jsp";
    document.formname.submit();
}
//parent.doStop();

function getTotalHeight(){
	var ele = document.getElementById("theEnd");
	// check it first.
	if (ele != null) { 	return ele.offsetTop; 	}
	return 0;
}
</script>
</html>
<%@ include file="/modules/common/footer.jsp" %>