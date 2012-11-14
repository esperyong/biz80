<%@ page language="java" contentType="text/html;charset=UTF-8" errorPage="/modules/common/error.jsp"%>
<jsp:directive.page import="com.mocha.dev.ReqRes"/>
<jsp:directive.page import="java.util.List"/>
<jsp:directive.page import="com.mocha.bsm.itom.vo.ResourceVO"/>
<jsp:directive.page import="java.util.Arrays"/>
<jsp:directive.page import="java.util.ArrayList"/>
<jsp:directive.page import="com.mocha.bsm.itom.mgr.plugin.ResourcePlugin"/>
<jsp:directive.page import="com.mocha.bsm.itom.vo.SubResourceVO"/>
<jsp:directive.page import="com.mocha.bsm.itom.util.PageUtil"/>
<%@ include file="/modules/common/security.jsp"%>
<%
   ReqRes rr = new ReqRes(request, response);
   rr.encoding("UTF-8").nocache().security();

   String instanceId = rr.param("instanceId", null);
   String domainId = rr.param("userdomain", null);
   String instanceName = rr.param("instanceName", null);
   String idStr = rr.param(instanceId+"_id", null);
   String[] idArr = null;
   List list = new ArrayList();
   if(!rr.empty(idStr)){
	   idArr = idStr.split(",");
   }
   if(!rr.empty(idArr)){
	   list = Arrays.asList(idArr);
   }
   ResourcePlugin networkplugin = new ResourcePlugin();
   List subList = networkplugin.query_child_resource(instanceId, currentUserId, domainId, list);
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
  <table width="100%" align="center" cellpadding="0" cellspacing="1" bgcolor="#6699CC">
    <tr>
      <td height="390" align="center" valign="top" bgcolor="#FFFFFF">
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
        <div style="height:310px;width:290px;overflow:auto">
        <table width="96%" border="1" align="center" cellpadding="2" cellspacing="0"  bordercolorlight="#D4D4D4" bordercolordark="#FFFFFF" style="word-break :break-all;">
            <tr>
              <td width="5%" bgcolor="#EAEEF1" align="center">
                  <input name="allsub" type="checkbox" value="checkbox" onclick="allSelect(this);">
              </td>
              <td width="39%" bgcolor="#EAEEF1" align="left"><strong>网络接口名称</strong></td>
              <td width="56%" bgcolor="#EAEEF1" align="left"><strong>接口描述</strong></td>
            </tr>
			<%
			if(!rr.empty(subList)){
				for(int i = 0; i < subList.size(); i++){
					SubResourceVO vo = (SubResourceVO)subList.get(i);
			%>
            <tr>
              <td><div align="center">
                <input name="subresourceid" type="checkbox" value="<%=vo.getInstanceId() %>" <%if(list.contains(vo.getInstanceId())){ %>checked<%} %> onclick="singleSelect(this);">
              </div></td>
              <td align="left" valign="top" bgcolor="#FFFFFF"><%=PageUtil.ellipsisNvl(vo.getInstanceName(), 85) %></td>
              <td align="left" valign="top" bgcolor="#FFFFFF"><%=PageUtil.ellipsisNvl(vo.getRemark(), 120) %></td>
            </tr>
            <%
			}}
            %>
        </table>
        </div>
        <table width="100%"  border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td height="30"><div align="right"><img src="<%=imgRootPath%>/an_tanchu_queding.GIF" style="cursor:pointer" width="35" height="17" hspace="3" onclick="doSubmit();"><img src="<%=imgRootPath%>/an_tanchu_quxiao.GIF" style="cursor:pointer" width="35" height="17" onclick="closeDiv();">&nbsp;</div></td>
            </tr>
        </table>
        </td>
    </tr>
  </table>
</div>
</form>
</BODY>
<script type="text/javascript">
function allSelect(e){
	var single = document.getElementsByName("subresourceid");
	if(single != undefined && single.length > 0){
		for(var i = 0; i < single.length; i++){
			single[i].checked = e.checked;
		}
	}
}

function singleSelect(e){
	var all = document.formname.allsub;
	if(!e.checked){
		all.checked = e.checked;
	}
}

function closeDiv() {
	parent.document.getElementById("subquerydiv").style.display="none";
}

function doSubmit(){
	var arrid = document.getElementsByName("subresourceid");
	var strid = "";
	if(arrid != undefined && arrid.length > 0){
		for(var i = 0; i < arrid.length; i++){
			if(arrid[i].checked){
				strid = strid + arrid[i].value + ",";
			}
		}
		strid = strid.substring(0,strid.length-1);
	}
	if(strid == ""){
		strid = "null";
		parent.document.getElementById('<%=instanceId+"_no"%>').style.display = "";
		parent.document.getElementById('<%=instanceId+"_have"%>').style.display = "none";
		parent.document.getElementById('<%=instanceId+"_half"%>').style.display = "none";
	}else{
		var arr = strid.split(",");
		if(arr.length == arrid.length){
			parent.document.getElementById('<%=instanceId+"_no"%>').style.display = "none";
			parent.document.getElementById('<%=instanceId+"_have"%>').style.display = "";
			parent.document.getElementById('<%=instanceId+"_half"%>').style.display = "none";
		}else{
			parent.document.getElementById('<%=instanceId+"_no"%>').style.display = "none";
			parent.document.getElementById('<%=instanceId+"_have"%>').style.display = "none";
			parent.document.getElementById('<%=instanceId+"_half"%>').style.display = "";
		}
		try{
		parent.document.getElementById('<%=instanceId+"_all"%>').checked = true;
		}catch(e){
		}
	}
	parent.document.getElementsByName('<%=instanceId+"_id"%>')[0].value = strid;
	closeDiv();
}
</script>
</HTML>