<%@page import="java.util.Set"%>
<%@ page language="java" contentType="text/html;charset=UTF-8" errorPage="/modules/common/error.jsp"%>
<jsp:directive.page import="com.mocha.dev.ReqRes"/>
<jsp:directive.page import="com.mocha.dev.ListMap"/>
<jsp:directive.page import="com.mocha.bsm.itom.common.IConsts"/>
<jsp:directive.page import="java.util.List"/>
<jsp:directive.page import="com.mocha.bsm.itom.vo.ResourceVO"/>
<jsp:directive.page import="java.util.ArrayList"/>
<jsp:directive.page import="java.util.Arrays"/>
<jsp:directive.page import="com.mocha.bsm.itom.type.ResourceQueryType"/>
<jsp:directive.page import="com.mocha.bsm.itom.mgr.plugin.ResourcePlugin"/>
<jsp:directive.page import="com.mocha.bsm.itom.util.PageUtil"/>
<jsp:directive.page import="com.mocha.bsm.itom.common.CategoryFilterCnofig"/>
<%@ include file="/modules/common/security.jsp"%>
<%
   ReqRes rr = new ReqRes(request, response);
   rr.encoding("UTF-8").nocache().security();

   String queryflag = rr.param("queryflag", "false");
   String userdomain = rr.param("userdomain", null);
   String categoryidstr = rr.param("categoryidstr", null);
   String ipfrom = rr.param("ipfrom", null);
   String ipto = rr.param("ipto", null);
   String name = rr.param("resourcename", null);
   String categorytypename = rr.param("categorytypename", null);
   String resourceId = rr.param("resourceId", null);
   String categoryId = rr.param("categoryId", null);
   String typeRadio = rr.param("typeRadio", null);

   String idStr = rr.param("idStr", null);
   ListMap displays = ResourceQueryType.getAll();
   String display_column = rr.param("display_column", (String)displays.getKey(1));
   String[] idArr = null;
   List idList = new ArrayList();
   if(!rr.empty(idStr)){
	   idArr = idStr.split(",");
   }
   if(!rr.empty(idArr)){
	   idList = Arrays.asList(idArr);
   }
   ListMap query_column_listmap = ResourceQueryType.getAll();

   ResourcePlugin plugin = new ResourcePlugin();
   List list = null;
   if(!rr.empty(userdomain)){
	   list = plugin.query(request, response, rr, currentUserId, userdomain);
   }

   List categoryidList = new ArrayList();
   String[] categoryidArr = null;
   if(!rr.empty(categoryidstr)){
	   categoryidArr = categoryidstr.split(",");
   }
   if(!rr.empty(categoryidArr)){
	   categoryidList = Arrays.asList(categoryidArr);
   }
   if(rr.empty(categoryId)) {
   	categoryId = categoryidstr;
   }
   Set<String> t_allNetWorkCategorys=CategoryFilterCnofig.getAllChildCategory(IConsts.NETWORKDEVICES);
%>
<HTML>
<HEAD>
<TITLE></TITLE>
<link href="<%=cssRootPath %>/liye1.css" rel="stylesheet" type="text/css">
<link href="<%=cssRootPath %>/liye.css" rel="stylesheet" type="text/css">
<link href="<%=cssRootPath %>/css.css" rel="stylesheet" type="text/css">
<SCRIPT language=JavaScript src="<%=jsRootPath%>/common.js"></SCRIPT>
<script src="<%=jsRootPath %>/checkForm.js"></script>
<script src="<%=jsRootPath %>/tools.js"></script>
<script type="text/javascript" src="<%=jsRootPath%>/loading.js"></script>
<script type="text/javascript">
var g_loading = new Loading("<span class='word-blue'><%=i18n.key("data.submit.wait")%></span>",180,180,"yes",true,790,520,0,0);
function doStart(){
  g_loading.start();
}
function doStop(){
  g_loading.stop();
}
</script>
</HEAD>
<BODY>
<div align="center">
<form name="formname" id="formname" action="" method="post" target="">
<input type="hidden" name="query_column" value=""/>
<input type="hidden" name="display_column" value=""/>
<input type="hidden" name="idStr" value="<%=idStr %>"/>
<input type="hidden" name="userdomain" value="<%=userdomain %>">
<input type="hidden" name="categoryId" value="<%=categoryId %>">
<input type="hidden" name="resourceId" value="<%=resourceId %>">
<input type="hidden" name="instanceId" value="">
<input type="hidden" name="instanceName" value="">
<input type="hidden" name="categoryidstr" value="<%=categoryidstr %>">
<input type="hidden" name="categorytypename" value="<%=categorytypename %>">
<input type="hidden" name="typeRadio" value="<%=typeRadio %>">
<table width="100%"  border="0" cellspacing="0" cellpadding="0">
  <tr>
  	<td colspan="3">
	  	<table width="100%"  border="0" cellspacing="0" cellpadding="0">
	  		<tr>
		     <td align="center" valign="middle" background="<%=imgRootPath %>/bg002.jpg" class="table-bottom-border"><div align="left"> <strong>&nbsp;&nbsp;&nbsp;搜索</strong></div></td>
		     <td class="table-bottom-border" background="<%=imgRootPath %>/bg002.jpg">&nbsp;</td>
		     <td width="19" align="center" background="<%=imgRootPath %>/bg002.jpg" class="table-bottom-border" onClick=""><img src="<%=imgRootPath %>/gb.gif" style="cursor:pointer" width="19" height="19" onclick="closeDiv();"></td>
		   </tr>
	  	</table>
  	</td>
  </tr>
  <tr>
   	<td width="70" class="table-bottom-border2"><span class="zi">&nbsp;&nbsp;资源类型：</span></td>
  	<td width="220" class="table-bottom-border2">
	<div onclick="DisplaySelectTypeDiv();">
	<select name="categorytype"  class="zi" style="width:220px;" disabled>
	<%if(!rr.empty(categorytypename)){ %>
	<option><%=categorytypename %></option>
	<%}else{%>
	<option>全部</option>
	<%} %>
	</select>
	</div>
	</td>
  	<td id="<%=IConsts.IP_QUERY %>" class="table-bottom-border2">&nbsp;&nbsp;IP地址&nbsp;<img src="<%=imgRootPath %>/xiala.jpg" width="12" height="15" style="cursor:hand;" onClick="MM_showHideLayers('querydiv','','show');">：从&nbsp;<input type="text" name="ipfrom" value="<%if(rr.equals(display_column, (String)displays.getKey(0)) && !rr.empty(ipfrom)){out.print(ipfrom);} %>" class="zi" size="14">&nbsp;到&nbsp;<input type="text" name="ipto" value="<%if(rr.equals(display_column, (String)displays.getKey(0)) && !rr.empty(ipto)){out.print(ipto);} %>" class="zi" size="14">&nbsp;<img src="<%=imgRootPath%>/sousuo.gif" alt="<%=i18n.key("SEARCH") %>" width="18" height="18" style="cursor:hand;" onclick="sousuo('<%=IConsts.IP_QUERY %>','<%=(String)displays.getKey(0) %>');"></td>
  	<td id="<%=IConsts.NAME_QUERY %>" style="display:none;" class="table-bottom-border2">&nbsp;&nbsp;资源名称&nbsp;<img src="<%=imgRootPath %>/xiala.jpg" width="12" height="15" style="cursor:hand;" onClick="MM_showHideLayers('querydiv','','show');"><input type="text" name="resourcename" value="<%if(rr.equals(display_column, (String)displays.getKey(1)) && !rr.empty(name)){out.print(name);} %>" class="zi" size="25">&nbsp;<img src="<%=imgRootPath%>/sousuo.gif" alt="<%=i18n.key("SEARCH") %>" width="18" height="18" style="cursor:hand;" onclick="sousuo('<%=IConsts.NAME_QUERY %>', '<%=(String)displays.getKey(1) %>');"></td>
  </tr>
</table>

<table id="datadiv"  width="100%" <%if(rr.empty(list)) {%>style="display:none"<%} %>>
<tr><td>
<table id="tablediv" width="100%">
<tr><td>
<div style="width:630px;height:350px;overflow:auto">
<table id="datatable" width="98%" border="1" align="center" cellpadding="2" cellspacing="0"  bordercolorlight="#D4D4D4" bordercolordark="#FFFFFF" style="word-break :break-all;">
  <tr>
    <td width="5%" bgcolor="#EAEEF1" align="left">
        <input name="alldata" type="checkbox" value="" onclick="allSelect(this);">
    </td>
    <td width="40%" bgcolor="#EAEEF1" align="left"><strong>资源名称</strong></td>
    <td width="30%" bgcolor="#EAEEF1" align="left"><strong>资源类型</strong></td>
    <td width="25%" bgcolor="#EAEEF1" align="left"><strong>IP地址</strong></td>
  </tr>
<tbody id="datatbody">
<%
	if(!rr.empty(list)) {
	for(int i=0; i<list.size(); i++) {
		ResourceVO vo = (ResourceVO)list.get(i);
		if(!idList.contains(vo.getInstanceId())){
			String[] ips = null;
			if(!rr.empty(vo.getIp())){
				ips = vo.getIp().split(",");
			}
			boolean isNetWork=(!rr.equals(IConsts.EVENT_TYPE_CHANGE, typeRadio) && !IConsts.EVENT_TYPE_PERFORM.equals(typeRadio)&& t_allNetWorkCategorys.contains(vo.getCategoryId()));
			String t_instanceName=(vo.getInstanceName()==null)?null:vo.getInstanceName().replaceAll("\"","\\\\\"");
			%>
	<tr>
    <td align="left" valign="top" bgcolor="#FFFFFF"><input id="<%=vo.getInstanceId()+"_all" %>" name="ins_check" type="checkbox" <%if(idList.contains(vo.getInstanceId())){ %>checked<%} %> value="<%=vo.getInstanceId() %>" onclick="singleSelect(this);"></td>
    <td align="left" valign="top" bgcolor="#FFFFFF"><%if(isNetWork){ %><img id="<%=vo.getInstanceId()+"_no" %>" src="<%=imgRootPath %>/jiek_gray.gif" alt="<%=i18n.key("itpm.strategy.network.imgno") %>" width="16" height="16" style="cursor:hand;" align="absmiddle" onclick='openSubQuery("<%=vo.getInstanceId() %>","<%=t_instanceName%>");'><img id="<%=vo.getInstanceId()+"_have" %>" src="<%=imgRootPath %>/jiek.gif" alt="<%=i18n.key("itpm.strategy.network.imghave") %>" width="16" height="16" style="cursor:hand;display:none" align="absmiddle" onclick='openSubQuery("<%=vo.getInstanceId()%>","<%=t_instanceName%>");'><img id="<%=vo.getInstanceId()+"_half" %>" src="<%=imgRootPath %>/jiek_b1.gif" alt="<%=i18n.key("itpm.strategy.network.imghalf") %>" width="16" height="16" style="cursor:hand;display:none" align="absmiddle" onclick='openSubQuery("<%=vo.getInstanceId() %>","<%=t_instanceName%>");'>
    <%} %><%=PageUtil.ellipsisNvl(vo.getInstanceName(), 200) %>
    <input type="hidden" name="<%=vo.getInstanceId()+"_type" %>" value="<%=vo.getCategoryId() %>">
    <input type="hidden" name="<%=vo.getInstanceId()+"_id" %>" value="null">
    <input type="hidden" name="ins_name" value="<%=(vo.getInstanceName()==null)?null:vo.getInstanceName().replaceAll("\"","&#34;")%>"></td>
    <td align="left" valign="top" bgcolor="#FFFFFF"><%=PageUtil.ellipsisNvl(vo.getResourceType(), 185) %><input type="hidden" name="ins_type" value="<%=vo.getResourceType() %>"></td>
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
	</div><input type="hidden" name="ins_ip" value="<%=vo.getIp() %>"></td>
  </tr>
<%}}} %>
</tbody>
</table>
</div>
</td></tr></table>
<table width="100%"  border="0" cellspacing="0" cellpadding="0">
   <tr>
     <td height="30">
     <div align="right">
	     <img src="<%=imgRootPath %>/an_tanchu_queding.GIF" style="cursor:pointer" width="35" height="17" hspace="3" onclick="doSubmit();">
	     <img src="<%=imgRootPath %>/an_tanchu_quxiao.GIF" style="cursor:pointer" width="35" height="17" onclick="closeDiv();">&nbsp;
     </div>
     </td>
   </tr>
</table>
</td></tr></table>
<div id="nodatadiv" style="width:537px;height:350px;" <%if(!rr.empty(list)) {%>style="display:none"<%} %>>
<table width="96%" border="0" height="340">
	<tr>
		<td align="center" height="100" align="center" valign="middle">&nbsp;</td>
	</tr>
	<tr>
		<td align="center" height="70" align="center" valign="middle"><img src="<%=imgRootPath%>/111.png" width="48" height="48" align="absmiddle"></td>
	</tr>
	<tr>
		<td  align="center" valign="top" class="lanzi"><%if("true".equals(queryflag)){ %>查询无数据<%}else{ %>请根据条件搜索资源<%} %></td>
	</tr>
</table>
</div>
<div id="querydiv" style="position:absolute; left:290px; top:40px; width:128px; z-index:1; background-color: #FFFFFF; layer-background-color: #FFFFFF; border: 1px none #000000; height: 50px; display: none;" onMouseOver="MM_showHideLayers('querydiv','','show');" onMouseOut="MM_showHideLayers('querydiv','','hide');">
  <table width="100%"  border="0" cellpadding="0" cellspacing="1" bgcolor="#FFFFFF">
    <tr>
      <td bgcolor="#FFFFFF"><table width="100%" cellpadding="0" cellspacing="0" class="table-allline-blue02">
          <tr>
            <td width="100%" align="center" valign="top" bgcolor="#FFFFFF" >
            <table width="100%" height="50"  border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#E1E1E1">
                <%for(int i=0; i<query_column_listmap.size(); i++) {
                	String key = (String)query_column_listmap.getKey(i);
                	String value = (String)query_column_listmap.get(key);
                %>
                <tr bgcolor="#FFFFFF">
                  <td bgcolor="#EBF1FC" width="25">&nbsp;</td>
                  <td id='<%=key %>_column'><div align="left" onMouseOver="changeBgcolor('<%=key %>');" onClick="selectConditon('<%=key %>');" style="cursor:hand;"><%=value %></div></td>
                </tr>
                <%} %>
            </table>
            </td>
          </tr>
      </table></td>
    </tr>
  </table>
</div>
<div id="selecttypediv" style="position:absolute; left:70px; top:45px; width:220px; height:300px;z-index:3; background-color: #FFFFFF; layer-background-color: #FFFFFF; border: 1px none #000000; display:none">
<table width="100%"  border="0" cellspacing="0" cellpadding="0" class="boder-all-blue">
  <tr>
    <td align="center" valign="middle" background="<%=imgRootPath %>/bg002.jpg" class="table-bottom-border">&nbsp;</td>
    <td class="table-bottom-border" background="<%=imgRootPath %>/bg002.jpg">&nbsp;</td>
    <td width="19" align="center" background="<%=imgRootPath %>/bg002.jpg" class="table-bottom-border"><img src="<%=imgRootPath %>/gb.gif" style="cursor:pointer" width="19" height="19" onclick="document.getElementById('selecttypediv').style.display='none';"></td>
  </tr>
</table>
<iframe id="selecttypeiframe" name="selecttypeiframe" src="select_resourcetype.jsp?categoryidstr=<%=categoryidstr %>" width=100% height=300 frameborder=0 valign="top" scrolling="auto" class="boder-all-blue"></iframe>
</div>
<div id="subquerydiv" style="position:absolute; left:200px; top:10px; width:294px; height:396px;z-index:3; background-color: #FFFFFF; layer-background-color: #FFFFFF; border: 1px none #000000; display:none">
<iframe id="subqueryiframe" name="subqueryiframe" width=100% height=396 frameborder=0 valign="top" scrolling="no"></iframe>
</div>
</form>
</div>
<!-- 提交到IFRAME-->
<IFRAME width=0 height=0  FRAMEBORDER=0  name="host_query_jsp"></IFRAME>
<div id="theEnd" style="position:relative"></div>
</BODY>
<script language="javascript">
function changeType(id, type, text){
	if(id == "all"){
		document.formname.categoryId.value = '<%=categoryidstr%>';
		document.formname.resourceId.value = "";
	}else{
		if(type == "category"){
			document.formname.categoryId.value = id;
			document.formname.resourceId.value = "";
		}else if(type == "resource"){
			document.formname.categoryId.value = "";
			document.formname.resourceId.value = id;
		}
	}
	document.formname.categorytypename.value = text;
}

function openSubQuery(instanceid, instancename){
	document.formname.instanceId.value = instanceid;
	document.formname.instanceName.value = instancename;
	document.formname.target = "subqueryiframe";
	document.formname.action = "subquery.jsp";
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
function checkForm(){
	alltotrim();
	var selectObj = document.getElementById("categorytype").options;
	if(selectObj == undefined || selectObj.length == 0) {
		openModalWindowLong('<%=path%>','pleaseSelectType');
		return false;
	}
	var query_column = document.formname.query_column.value;
	if(query_column == "<%=IConsts.NAME_QUERY %>") {
		if(!checkLawlessChar(document.formname.resourcename,'itpm.strategy.resource.query.resourceName.illegalchar','<%=path%>')){
		   return false;
		}
	}else if(query_column == "<%=IConsts.IP_QUERY %>") {
		if(document.formname.ipfrom.value.trim()=="" && document.formname.ipto.value.trim()=="") {
			document.formname.ipfrom.value = "0.0.0.0";
			document.formname.ipto.value = "255.255.255.255";
		} else if(document.formname.ipfrom.value.trim()!="" && document.formname.ipto.value.trim()==""){
			if(!document.formname.ipfrom.value.isIP()){
		      openModalWindowLong('<%=path%>','illegalip');
		      return false;
  			}
			document.formname.ipto.value = document.formname.ipfrom.value;
		} else if(document.formname.ipfrom.value.trim()=="" && document.formname.ipto.value.trim()!=""){
			if(!document.formname.ipto.value.isIP()){
		      openModalWindowLong('<%=path%>','illegalip');
		      return false;
  			}
			document.formname.ipfrom.value = document.formname.ipto.value;
		} else if(document.formname.ipfrom.value.trim()!="" && document.formname.ipto.value.trim()!="") {
			if(!document.formname.ipfrom.value.isIP()){
		      openModalWindowLong('<%=path%>','illegalip');
		      return false;
  			}
  			if(!document.formname.ipto.value.isIP()){
		      openModalWindowLong('<%=path%>','illegalip');
		      return false;
  			}

  			if(!compareIP(document.formname.ipfrom.value, document.formname.ipto.value)) {
  				openModalWindowLong('<%=path%>','compare.ip');
		      	return false;
  			}

		}
	}
	return true;
}
//比较IP大小
function compareIP(fromIp, toIp) {
  var fromArr = fromIp.split(".");
  var toArr = toIp.split(".");
  for(i=0; i<fromArr.length; i++) {
	  if(Number(fromArr[i]) > Number(toArr[i])){
	      return false;
	  } else if(Number(fromArr[i]) < Number(toArr[i])){
	      return true;
	  }
  }
  return true;
}
function sousuo(value,display){
	if(checkForm()){
		doStart();
		document.formname.idStr.value = parent.document.formname.idStr.value;
		document.formname.query_column.value = value;
		document.formname.display_column.value = display;
		document.formname.action = "query.jsp?queryflag=true";
		document.formname.target = "";
		document.formname.submit();
	}
}
function MM_showHideLayers(a,b,c) {
  if(c == 'show') {
  	document.getElementById(a).style.display = 'block';
  } else if(c == 'hide') {
    document.getElementById(a).style.display = 'none';
  }
}

function changeBgcolor(param) {
   <%for(int i=0; i<query_column_listmap.size(); i++) {
       	String key = (String)query_column_listmap.getKey(i);
   %>
	   document.getElementById('<%=key %>_column').parentNode.bgColor='#FFFFFF';
	   document.getElementById('<%=key %>_column').parentNode.childNodes[0].bgColor='#EBF1FC';
   <%}%>
   document.getElementById(param+'_column').parentNode.bgColor='#C9DAF1';
   document.getElementById(param+'_column').parentNode.childNodes[0].bgColor='#C9DAF1';
}

function selectConditon(param) {
   <%for(int i=0; i<query_column_listmap.size(); i++) {
       	String key = (String)query_column_listmap.getKey(i);
   %>
	   document.getElementById('<%=key %>_column').parentNode.childNodes[0].innerHTML='';
   <%}%>
   document.getElementById(param+'_column').parentNode.childNodes[0].innerHTML='<div align=\"center\"><img src=\"<%=imgRootPath%>/dui.gif\" width=\"7\" height=\"7\"></div>';
   document.getElementById('querydiv').style.display = 'none';

   <%for(int i=0; i<query_column_listmap.size(); i++) {
       	String key = (String)query_column_listmap.getKey(i);
   %>
	   document.getElementById('<%=key %>_query').style.display = 'none';
   <%}%>
   document.getElementById(param+'_query').style.display = '';
   document.formname.query_column.value=param+"_query";
}

function allSelect(e){
 var single = document.getElementsByName("ins_check");
 if(single != undefined && single.length > 0){
  for(var i = 0; i < single.length; i++){
   single[i].checked = e.checked;
   if(!e.checked){
   	document.getElementsByName(single[i].value+"_id")[0].value = "null";
   	if(document.getElementById(single[i].value+"_no") != null){
	    document.getElementById(single[i].value+"_no").style.display = "";
	    document.getElementById(single[i].value+"_have").style.display = "none";
	    document.getElementById(single[i].value+"_half").style.display = "none";
   	}
   }
  }
 }
}

function singleSelect(e){
 var all = document.formname.alldata;
 if(!e.checked){
  all.checked = e.checked;
  document.getElementsByName(e.value+"_id")[0].value = "null";
  if(document.getElementById(e.value+"_no") != null){
	  document.getElementById(e.value+"_no").style.display = "";
	  document.getElementById(e.value+"_have").style.display = "none";
	  document.getElementById(e.value+"_half").style.display = "none";
  }
 }
}

function doSubmit111(){
	var str = document.getElementById("tablediv").innerHTML;
	parent.document.getElementById("datadiv").innerHTML = str;
	parent.document.getElementById("datadiv").style.display = "";
	parent.document.getElementById("nodatadiv").style.display = "none";
	closeDiv();
}

function doSubmit() {
	var ins_check = document.getElementsByName("ins_check");
	var ins_name = document.getElementsByName("ins_name");
	var ins_type = document.getElementsByName("ins_type");
	var ins_ip = document.getElementsByName("ins_ip");
	var html_str = "";
	var networkCategorys="<%=t_allNetWorkCategorys.toString()%>";
	var flag = false;
	if(ins_check != undefined && ins_check.length > 0) {
		var parent_table=parent.document.getElementById("datatable").tBodies[0];
		var tbLen  = parent_table.rows.length;
		for(i=0; i<ins_check.length; i++) {
			if(ins_check[i].checked) {
				flag = true;
				var newRow = parent_table.insertRow(1);

		    	var newTd1 = newRow.insertCell(0);
		    	newTd1.align = "left";
				newTd1.innerHTML = "<input name=\"datacheckbox\" type=\"checkbox\" value=\""+ins_check[i].value+"\" onclick=\"singleSelect(this);\">";

		    	var newTd2 = newRow.insertCell(1);
		    	newTd2.align = "left";

				var id = ins_check[i].value+"_id";
				var type = ins_check[i].value+"_type";

				newTd2.innerHTML = "<input type='hidden' name='"+ type + "' value='" + document.getElementsByName(type)[0].value + "'>" +
								   "<input type='hidden' name='"+ id + "' value='" + document.getElementsByName(id)[0].value + "'>";
				var cattype = document.getElementsByName(type)[0].value;
				if( <%=!rr.equals(IConsts.EVENT_TYPE_CHANGE, typeRadio) %> && <%=!rr.equals(IConsts.EVENT_TYPE_PERFORM, typeRadio) %> && networkCategorys.indexOf(cattype)>-1){
					var no_img = document.getElementById(ins_check[i].value+"_no").style.display;
					var have_img = document.getElementById(ins_check[i].value+"_have").style.display;
					var half_img = document.getElementById(ins_check[i].value+"_half").style.display;
					if(no_img != ""){
						no_img = "display:none";
					}
					if(have_img != ""){
						have_img = "display:none";
					}
					if(half_img != ""){
						half_img = "display:none";
					}
					newTd2.innerHTML += "<img id='" + ins_check[i].value+"_no" + "' src='<%=imgRootPath %>/jiek_gray.gif' alt='<%=i18n.key("itpm.strategy.network.imgno") %>' width='16' height='16' style='cursor:hand;"+no_img+"' align='absmiddle' onclick=openSubQuery('"+ins_check[i].value+"','"+ins_name[i].value+"');>" +
									    "<img id='" + ins_check[i].value+"_have" + "' src='<%=imgRootPath %>/jiek.gif' alt='<%=i18n.key("itpm.strategy.network.imghave") %>' width='16' height='16' style='cursor:hand;"+have_img+"' align='absmiddle' onclick=openSubQuery('"+ins_check[i].value+"','"+ins_name[i].value+"');>" +
									    "<img id='" + ins_check[i].value+"_half" + "' src='<%=imgRootPath %>/jiek_b1.gif' alt='<%=i18n.key("itpm.strategy.network.imghalf") %>' width='16' height='16' style='cursor:hand;"+half_img+"' align='absmiddle' onclick=openSubQuery('"+ins_check[i].value+"','"+ins_name[i].value+"');>";
				}
				newTd2.innerHTML += "<span title='" + ins_name[i].value + "' style='width:200px; overflow: hidden; text-overflow: ellipsis;'><nobr>" + ins_name[i].value + "</nobr></span>";


		    	var newTd3 = newRow.insertCell(2);
		    	newTd3.align = "left";
				newTd3.innerHTML = "<span title='" + ins_type[i].value + "' style='width:185px; overflow: hidden; text-overflow: ellipsis;'><nobr>" + ins_type[i].value + "</nobr></span>" +
									"<input type=\"hidden\" name=\"dataType\" value=\""+ins_type[i].value+"\" >";

		    	var newTd4 = newRow.insertCell(3);
		    	newTd4.align = "left";

		    	var selectstr = "";
		    	var arr = new Array();
		    	if(ins_ip[i].value != ""){
		    		arr = ins_ip[i].value.split(",");
		    	}
	    		if(arr.length == 1){
	    			selectstr = selectstr + arr[0];
	    		}else{
	    			selectstr = selectstr + "<select class='zi'>";
		    		for(var j = 0; j < arr.length; j++){
		    			selectstr = selectstr + "<option>" + arr[j] + "</option>";
		    		}
		    		selectstr = selectstr + "</select>";
	    		}
				newTd4.innerHTML = selectstr;
			}

		}

		if(flag) {
			parent.document.getElementById("nodatadiv").style.display = "none";
			parent.document.getElementById("datadiv").style.display = "block";
			parent.document.getElementById("query_page").style.display="none";
			//parent.document.getElementById("query_page").src = "bank.jsp";
			//window.location.href = "bank.jsp";
			document.getElementById("datadiv").style.display="none";
			document.getElementById("nodatadiv").style.display="block";
		}else {
			openModalWindowLong('<%=path%>', 'pleaseSelect');
			return false;
		}
	}
}

function closeDiv() {
	parent.document.getElementById("query_page").style.display="none";
	document.getElementById("datadiv").style.display="none";
	document.getElementById("nodatadiv").style.display="block";
}

try{
document.formname.userdomain.value = parent.parent.document.formname.userdomainId.value;
}catch(e){
document.formname.userdomain.value = parent.parent.parent.document.formname.userdomainId.value;
}

function init(){
	selectConditon('<%=display_column%>');//默认按名称查询
	var obj = document.getElementsByName("ins_check");
	if(obj != undefined && obj.length > 0){
		document.getElementById("datadiv").style.display="";
		document.getElementById("nodatadiv").style.display="none";
	}else{
		document.getElementById("datadiv").style.display="none";
		document.getElementById("nodatadiv").style.display="";
	}
}
function DisplaySelectTypeDiv() {
	document.getElementById("selecttypediv").style.display="";
}
init();

doStop();
</script>
</HTML>