<%--
	modules/itpm/strategy/host_action.jsp
	author: wangtao@mochasoft.com.cn
	Description: 工单触发策略 - 主机选择
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" errorPage="/modules/common/error.jsp"%>
<jsp:directive.page import="com.mocha.dev.ReqRes"/>
<jsp:directive.page import="com.mocha.bsm.itom.mgr.StrategyMgr"/>
<jsp:directive.page import="com.mocha.bsm.itom.vo.StrategyInfoVO"/>
<jsp:directive.page import="com.mocha.bsm.itom.mgr.XmlCommunication"/>
<jsp:directive.page import="java.util.List"/>
<jsp:directive.page import="com.mocha.bsm.itom.vo.ResourceVO"/>
<jsp:directive.page import="com.mocha.bsm.itom.mgr.plugin.ResourceQueryMgr"/>
<jsp:directive.page import="com.mocha.bsm.itom.vo.SubResourceVO"/>
<jsp:directive.page import="com.mocha.bsm.itom.common.IConsts"/>
<jsp:directive.page import="com.mocha.bsm.itom.util.PageUtil"/>
<jsp:directive.page import="java.util.ArrayList"/>
<jsp:directive.page import="com.mocha.bsm.itom.view.UserDomainManage"/>
<jsp:directive.page import="java.util.Map"/>
<jsp:directive.page import="java.util.Set"/>
<jsp:directive.page import="com.mocha.bsm.itom.common.CategoryFilterCnofig"/>
<%@ include file="/modules/common/security.jsp"%>
<%
   ReqRes rr = new ReqRes(request, response);
   rr.encoding("UTF-8").nocache().security();
   //String categoryId = rr.param("categoryId", null);
   String strategyId = rr.param("strategyId", null);
   String categoryidstr = rr.param("categoryidstr", null);
   String userdomainId = rr.param("userdomainId", null);
   String resourceTypeRadio = rr.param("resourceTypeRadio", null);
   String typeRadio = rr.param("workformType", null);
   List resource = null;
   if(!rr.empty(strategyId)) {
	   StrategyInfoVO vo = StrategyMgr.getInstance().queryStrategyNormalInfoVO(strategyId);
	   StrategyInfoVO info = (StrategyInfoVO)XmlCommunication.getInstance().fromXMl(vo.getXmlInfo());
	   if(resourceTypeRadio.equals(info.getResourceType())){
	   		resource = info.getResources();
	   }
   }
   boolean isPortalAdmin = UserDomainManage.getInstance().isPortalAdmin(currentUserId);
   Set<String> t_allNetWorkCategorys=CategoryFilterCnofig.getAllChildCategory(IConsts.NETWORKDEVICES);
%>
<HTML>
<HEAD>
<TITLE>Mocha BSM</TITLE>
<link href="<%=cssRootPath %>/liye1.css" rel="stylesheet" type="text/css">
<SCRIPT language=JavaScript src="<%=jsRootPath%>/common.js"></SCRIPT>
<script src="<%=jsRootPath %>/checkForm.js"></script>
</HEAD>
<BODY>
<div align="center">
<form name="formname" id="formname" action="" method="post" target="host_action_jsp">
<input type="hidden" name="idStr" value="">
<input type="hidden" name="categoryId" value="">
<input type="hidden" name="instanceId" value="">
<input type="hidden" name="instanceName" value="">
<input type="hidden" name="domainId" value="">
<input type="hidden" name="categoryidstr" value="<%=categoryidstr %>">
<input type="hidden" name="typeRadio" value="<%=typeRadio %>">
<table width="100%" border="0" align="right">
	<tr>
	  <td width="94%" height="35">
	  <%if(isPortalAdmin){ %>
	  <div align="right"><img src="<%=imgRootPath%>/anniu_zblb_add.GIF" alt="<%=i18n.key("CREATE") %>" width="11" height="11" align="absmiddle" style="cursor:hand" onclick="openResource();">
	  </div>
	  <%} %>
	  </td>
	  <td width="6%">
	  <%if(isPortalAdmin){ %>
	  <div align="center"><img src="<%=imgRootPath%>/an-shanchu.gif" alt="<%=i18n.key("DELETE") %>" width="11" height="5" align="absmiddle" style="cursor:hand" onclick="delLine();">
	  </div>
	  <%} %>
	  </td>
	</tr>
	<tr>
      <td colspan="3">
<table id="datadiv" border="0" width="640" height="350" <%if(rr.empty(resource)) {%>style="display:none;"<%} %>>
<tr><td>
<div style= "position:absolute;overflow-x:hidden;overflow:auto;width:640px;height:350px;left:5px;top:40px">
<table id="datatable" width="96%" border="1" align="center" cellpadding="2" cellspacing="0"  bordercolorlight="#D4D4D4" bordercolordark="#FFFFFF" style="word-break :break-all;">
        <tr bgcolor="#EFF4F8">
          <td width="5%" align="left" bgcolor="#f9f9f9"><input name="alldata" type="checkbox" onclick="allSelect(this);" <%if(!isPortalAdmin){ %>disabled<%} %>></td>
          <td width="40%" align="left" bgcolor="#f9f9f9"><strong>&nbsp;资源名称</strong></td>
          <td width="30%" align="left" bgcolor="#f9f9f9"><strong>资源类型</strong></td>
          <td width="25%" align="left" bgcolor="#f9f9f9"><strong>IP地址</strong></td>
        </tr>
        <tbody id="datatbody">
<%
int count = 0;
if(!rr.empty(resource)) {
	Map tempMap = ResourceQueryMgr.getInstance().getMonitoredMap();
	resource = ResourceQueryMgr.getInstance().getResourceInstanceInfo(resource,categoryidstr,tempMap);
%>
<%	for (int i = 0; i < resource.size(); i++) {
		ResourceVO rvo = (ResourceVO)resource.get(i);
		
		if(rvo != null){
			count++;
			String[] ips = null;
			if(!rr.empty(rvo.getIp())){
				ips = rvo.getIp().split(",");
			}
			String id = "";
			List subList = rvo.getSubResource();
			if(!rr.empty(subList)){
				for(int j = 0; j < subList.size(); j++){
					SubResourceVO sub = (SubResourceVO)subList.get(j);
					id += sub.getInstanceId() + ",";
				}
			}
			if(!rr.empty(id)){id = id.substring(0, id.length()-1);}else{id = "null";}
			List allSubList = new ArrayList();
			allSubList = ResourceQueryMgr.getInstance().getChildResourceInstance(rvo.getInstanceId(),currentUserId,userdomainId,new ArrayList());
			String no_img = "display:none";
			String have_img = "display:none";
			String half_img = "display:none";
			if(!IConsts.EVENT_TYPE_CHANGE.equals(typeRadio) && !IConsts.EVENT_TYPE_PERFORM.equals(typeRadio)){
				if(rr.empty(id)||"null".equals(id)||(allSubList != null && allSubList.isEmpty())){
					no_img = "";
				}else{
					List temp = ResourceQueryMgr.getInstance().filterChildResource(allSubList, id);
					if(temp.size() == allSubList.size()){
						no_img = "";
					}else if(temp.size() == 0){
						have_img = "";
					}else if(temp.size() < allSubList.size()){
						half_img = "";
					}
				}
			}
			String t_instanceName=(rvo.getInstanceName()==null)?null:rvo.getInstanceName().replaceAll("\"","\\\\\"");
%>
        <tr>
          <td align="left"><input name="datacheckbox" type="checkbox" value="<%=rvo.getInstanceId() %>" onclick="singleSelect(this);" <%if(!isPortalAdmin){ %>disabled<%} %>></td>
          <td align="left"><%if(t_allNetWorkCategorys.contains(rvo.getCategoryId())){ %><img id="<%=rvo.getInstanceId()+"_no" %>" src="<%=imgRootPath %>/jiek_gray.gif" alt="<%=i18n.key("itpm.strategy.network.imgno") %>" width="16" height="16" style="cursor:hand;<%=no_img %>" align="absmiddle" onclick='openSubQuery("<%=rvo.getInstanceId()%>","<%=t_instanceName%>");'><img id="<%=rvo.getInstanceId()+"_have" %>" src="<%=imgRootPath %>/jiek.gif" alt="<%=i18n.key("itpm.strategy.network.imghave") %>" width="16" height="16" style="cursor:hand;<%=have_img %>" align="absmiddle" onclick='openSubQuery("<%=rvo.getInstanceId() %>","<%=t_instanceName%>");'><img id="<%=rvo.getInstanceId()+"_half" %>" src="<%=imgRootPath %>/jiek_b1.gif" alt="<%=i18n.key("itpm.strategy.network.imghalf") %>" width="16" height="16" style="cursor:hand;<%=half_img %>" align="absmiddle" onclick='openSubQuery("<%=rvo.getInstanceId() %>","<%=t_instanceName%>");'>
	      <%} %><%=PageUtil.ellipsisNvl(rvo.getInstanceName(), 200) %>
          <input type="hidden" name="<%=rvo.getInstanceId()+"_type" %>" value="<%=rvo.getCategoryId() %>">
    	  <input type="hidden" name="<%=rvo.getInstanceId()+"_id" %>" value="<%=id %>">
          <td align="left"><%=PageUtil.ellipsisNvl(rvo.getResourceType(), 185) %><input type="hidden" name="dataType" value="<%=rvo.getResourceType() %>" ></td>
          <td align="left">
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
			</td>
        </tr>
<%}}}%>
</tbody>
</table>
</div>
</td></tr>
</table>
<div id="nodatadiv" style="width:640px;height:350px;<%if(!rr.empty(resource)) {%>display:none<%} %>" >
<table width="96%" border="0" height="340">
	<tr>
		<td align="center" height="100" align="center" valign="middle">&nbsp;</td>
	</tr>
	<tr>
		<td align="center" height="70" align="center" valign="middle"><img src="<%=imgRootPath%>/111.png" width="48" height="48" align="absmiddle"></td>
	</tr>
	<tr>
		<td  align="center" valign="top" class="lanzi">请添加触发工单的资源</td>
	</tr>
</table>
</div>
<table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="89%" height="50" align="right">
    <table width="0%" align="right" cellpadding="0" cellspacing="0">
        <tr>
          <td><img src="<%=imgRootPath%>/left.jpg" width="6" height="22"></td>
          <td width="45" background="<%=imgRootPath%>/mid.jpg"><div align="center"><span class="zi" style="cursor:hand;" onclick="PreDiv('normaldiv');">上一步</span></div></td>
          <td><img src="<%=imgRootPath%>/right.jpg" width="6" height="22"></td>
        </tr>
    </table>
    </td>
    <td width="11%" align="right">
    <table id="next_button" width="0%" align="right" cellpadding="0" cellspacing="0">
      <tr>
        <td><img src="<%=imgRootPath%>/left.jpg" width="6" height="22"></td>
        <td width="45" background="<%=imgRootPath%>/mid.jpg"><div align="center"><span class="zi" style="cursor:hand;" onclick="NextDiv('conditiondiv');">下一步</span></div></td>
        <td><img src="<%=imgRootPath%>/right.jpg" width="6" height="22"></td>
      </tr>
    </table>
    <table id="finish_button" width="0%" align="right" cellpadding="0" cellspacing="0">
     <tr>
       <td><img src="<%=imgRootPath%>/left.jpg" width="6" height="22"></td>
       <td width="45" background="<%=imgRootPath%>/mid.jpg"><div align="center"><%if(isPortalAdmin){ %><span class="zi" style="cursor:hand;" onclick="parent.doSubmit();">完成</span><%}else{ %><span class="zi" style="cursor:hand;" onclick="parent.close();">关闭</span><%} %></div></td>
       <td><img src="<%=imgRootPath%>/right.jpg" width="6" height="22"></td>
     </tr>
   </table>
    </td>
  </tr>
</table>
</div>
</td>
</tr>
</table>
</form>
</div>
<div id="query_page" style="position:absolute; display:none;width:640px;height:440px;left:5px; top:5px">
<iframe src="" id="queryiframe" name="queryiframe" width=100% height=100% frameborder=0 valign="top" scrolling="no" class="boder-all-blue"></iframe>
</div>

<div id="subquerydiv" style="position:absolute; left:200px; top:10px; width:294px; height:396px;z-index:3; background-color: #FFFFFF; layer-background-color: #FFFFFF; border: 1px none #000000; display:none">
<iframe id="subiframe" name="subiframe" width=100% height=396 frameborder=0 valign="top" scrolling="no"></iframe>
</div>
<!-- 提交到IFRAME-->
<IFRAME width=0 height=0  FRAMEBORDER=0  name="host_action_jsp"></IFRAME>
<div id="theEnd" style="position:relative"></div>
</BODY>
<script type="text/javascript">
document.formname.target = "queryiframe";
document.formname.action = "query.jsp";
document.formname.submit();

function openSubQuery(instanceid, instancename){
	document.formname.instanceId.value = instanceid;
	document.formname.instanceName.value = instancename;
	document.formname.domainId.value = parent.document.formname.userdomainId.value;
	document.formname.target = "subiframe";
	document.formname.action = "subquery.jsp";
	document.formname.submit();
	document.getElementById("subquerydiv").style.display = "";
}

function openResource(){
	writeid();
	document.getElementById("query_page").style.display = "";
}

function delLine(){
	var flag = false;
    var datatable = document.getElementById("datatable");
	var arr = document.getElementsByName("datacheckbox");
	if(arr != undefined && arr.length > 0){
		for(var i = arr.length - 1; i >= 0 ; i--){
	   		if(arr[i].checked){
	   			flag = true;
	   			break;
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
     	for(var i = arr.length - 1; i >= 0 ; i--){
	   		if(arr[i].checked){
	   			var rowid = arr[i].parentNode.parentNode.rowIndex;
				datatable.deleteRow(rowid);
			}
		}
		document.formname.alldata.checked = false;
	}else{
	    //alert('没有要删除的纪录');
		openModalWindowLong('<%=path%>', 'noDelData');
		return false;
	}
}

function allSelect(e){
	var single = document.getElementsByName("datacheckbox");
	if(single != undefined && single.length > 0){
		for(var i = 0; i < single.length; i++){
			single[i].checked = e.checked;
		}
	}
}

function singleSelect(e){
	var all = document.formname.alldata;
	if(!e.checked){
		all.checked = e.checked;
	}
}

//function NextDiv(div_url) {
	//var array = parent.document.formname.div_id.value.split(",");
	//for( i=0; i<array.length; i++) {
		//parent.document.getElementById(array[i]).style.display="none";
	//}
	//parent.document.getElementById(div_url).style.display="";

//}
//function PreDiv(div_url) {
	//var array = parent.document.formname.div_id.value.split(",");
	//for( i=0; i<array.length; i++) {
		//parent.document.getElementById(array[i]).style.display="none";
	//}
	//parent.document.getElementById(div_url).style.display="";

//}
function NextDiv(div_url) {
	var array = parent.document.formname.div_id.value.split(",");
	var flag = "false";
	for( i=0; i<array.length; i++) {
		parent.document.getElementById(array[i]).style.display="none";
		var str = array[i].substring(0,array[i].length-3);
		var imagearr = parent.document.getElementsByName(str+"image");
		var image_grayarr = parent.document.getElementsByName(str+"image_gray");
		if(i != 0){
			var spanlight = parent.document.getElementById(str+"span");
			var spangray = parent.document.getElementById(str+"span_gray");
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
	parent.document.getElementById(div_url).style.display="";
	parent.dyniframesize('condition_iframe');
}
function PreDiv(div_url) {
		var array = parent.document.formname.div_id.value.split(",");
	var flag = "false";
	for( i=0; i<array.length; i++) {
		parent.document.getElementById(array[i]).style.display="none";
		var str = array[i].substring(0,array[i].length-3);
		var imagearr = parent.document.getElementsByName(str+"image");
		var image_grayarr = parent.document.getElementsByName(str+"image_gray");
		if(i != 0){
			var spanlight = parent.document.getElementById(str+"span");
			var spangray = parent.document.getElementById(str+"span_gray");
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
	parent.document.getElementById(div_url).style.display="";
}
//向父页面传值
function doSubmit() {
	var datacheckbox = document.getElementsByName("datacheckbox");
	var dataType = document.getElementsByName("dataType");

	if(datacheckbox != undefined && datacheckbox.length > 0) {
		var checkbox_str = "";
		var type_str = "";
		var category_str = "";
		var sub_id = "";
		for(i = 0; i < datacheckbox.length; i++) {
			checkbox_str += datacheckbox[i].value + ",";
			type_str += dataType[i].value + ",";
			category_str += document.getElementsByName(datacheckbox[i].value+"_type")[0].value + ",";
			sub_id += document.getElementsByName(datacheckbox[i].value+"_id")[0].value + "@";
		}

		checkbox_str = checkbox_str.substring(0,checkbox_str.length-1);
		type_str = type_str.substring(0,type_str.length-1);
		category_str = category_str.substring(0,category_str.length-1);
		sub_id = sub_id.substring(0,sub_id.length-1);

		parent.document.formname.submit_res_id.value = checkbox_str;
		parent.document.formname.submit_res_type.value = type_str;
		parent.document.formname.submit_res_category.value = category_str;
		parent.document.formname.submit_res_subId.value = sub_id;
		<%if(IConsts.EVENT_TYPE_CHANGE.equals(typeRadio) || IConsts.EVENT_TYPE_PERFORM.equals(typeRadio)){%>
			parent.document.formname.submit_res_subId.value = null;
		<%}%>
	}
}

function writeid(){
	var arr = document.getElementsByName("datacheckbox");
	var str = "";
	if(arr != undefined && arr.length > 0){
		for(var i = 0; i < arr.length; i++){
			str = str + arr[i].value + ",";
		}
		str = str.substring(0,str.length-1);
		document.formname.idStr.value = str;
	}else{
		document.formname.idStr.value = "";
	}
}
parent.changePageDisplay();

function setDiv(){
	<%if(count == 0){%>
		document.getElementById('nodatadiv').style.display = "";
		document.getElementById('datadiv').style.display = "none";
	<%}else{%>
		document.getElementById('nodatadiv').style.display = "none";
		document.getElementById('datadiv').style.display = "";
	<%}%>
}

setDiv();
</script>
</HTML>