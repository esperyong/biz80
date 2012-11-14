<%--
	modules/itpm/strategy/send_condition.jsp
	author: wangtao@mochasoft.com.cn
	Description: 工单触发策略 - 触发条件设置
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" errorPage="/modules/common/error.jsp"%>
<jsp:directive.page import="com.mocha.dev.ReqRes"/>
<jsp:directive.page import="com.mocha.bsm.itom.view.UserDomainManage"/>
<jsp:directive.page import="com.mocha.bsm.itom.common.IConsts"/>
<jsp:directive.page import="com.mocha.bsm.itom.type.TimeType"/>
<jsp:directive.page import="com.mocha.dev.ListMap"/>
<%@ include file="/modules/common/security.jsp"%>
<%@ taglib uri="/mochatag" prefix="mt"%>
<%
   ReqRes rr = new ReqRes(request, response);
   rr.encoding("UTF-8").nocache().security();
   String resourceType = rr.param("resourceTypeRadio", null);
   String categoryId = rr.param("categoryidstr", null);
   String strategyId = rr.param("strategyId", null);
   
   ListMap timeType = TimeType.getAll();

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
<form name="formname" id="formname" action="" method="post" target="send_condition_jsp">
<mt:inforHead alt="触发工单条件" title="触发工单条件" width="650" heigh="130" imgurl="<%=imgRootPath%>"/>
<iframe id="index_right" name="take_condiong" width="100%" height="130" frameborder=0 valign="top" scrolling="no" src=""></iframe>
<mt:inforFoot imgurl="<%=imgRootPath%>"/>
<table width="622" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="8"></td>
  </tr>
</table>
<mt:inforHead alt="发送待办条件" title="发送待办条件" width="650" heigh="130" imgurl="<%=imgRootPath%>"/>
<table width="622" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="8"></td>
  </tr>
</table>
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="28" align="right"><div align="left" class="zi">发送待办条件：</div></td>
    <td align="right"><div align="left" class="zi">
    <input name="radiobutton" type="radio" value="radio1" checked>产生故障立即发送待办。</div></td>
  </tr>
  <tr>
    <td width="20%" height="28" align="right"></td>
    <td width="80%" align="right">
    <div align="left" class="zi">
      <input name="radiobutton" type="radio" value="radio2">
      <input name="time2" type="text" value="1" size="3" class="zi" onkeyup="checkNum(this);">
      <select name="select2" class="zi">
      	<%for(int i = 0; i < timeType.size(); i++) {
      		String key = (String)timeType.getKey(i);
      		String value = (String)timeType.get(key);
      	%>
	      <option value="<%=key %>"><%=value %></option>
	    <%} %>
      </select>内产生的同一故障只发送一次待办。
    </div>
    </td>
  </tr>
  <tr>
    <td height="28" align="right">&nbsp;</td>
    <td align="right">
    <div align="left" class="zi">
      <input name="radiobutton" type="radio" value="radio3">产生的同一故障超过
      <INPUT name="time3" size="3" type="text" class="zi"" onkeyup="checkNum(this);">
        <select name="select3" class="zi">
	        <%for(int i = 0; i < timeType.size(); i++) {
	      		String key = (String)timeType.getKey(i);
	      		String value = (String)timeType.get(key);
	      	%>
		      <option value="<%=key %>"><%=value %></option>
		    <%} %>
        </select>以上没有恢复则发送待办。
        </div>
    </td>
  </tr>
  <tr>
    <td height="28" align="right">&nbsp;</td>
    <td align="right">
    <div align="left" class="zi">
      <input name="radiobutton" type="radio" value="radio4">产生的同一故障在
	  <INPUT size="3" name="time4" type="text" class="zi" onkeyup="checkNum(this);">
		<select name="select4" class="zi">
			<%for(int i = 0; i < timeType.size(); i++) {
	      		String key = (String)timeType.getKey(i);
	      		String value = (String)timeType.get(key);
	      	%>
		      <option value="<%=key %>"><%=value %></option>
		    <%} %>
		</select>内发生
	  <INPUT name="count4" size="3" type="text" class="zi" onkeyup="checkNum(this);">次则发送待办。
	</div>
	</td>
  </tr>
</table> 
<table>
<tr>
<td width="45" background="<%=imgRootPath%>/mid.jpg"><div align="center"><span class="zi" style="cursor:hand;" onclick="checkForm()">完成</span></div></td>
</tr>
</table>
<mt:inforFoot imgurl="<%=imgRootPath%>"/>
</form>
</div>
<!-- 提交到IFRAME-->
<IFRAME width=0 height=0  FRAMEBORDER=0  name="send_condition_jsp"></IFRAME>
<div id="theEnd" style="position:relative"></div>
</BODY>
</HTML>
<script>
function checkForm() {
	var radios = document.formname.radiobutton;
	var radio_value = "";
	for(i = 0; i < radios.length; i++) {
		if(radios[i].checked) {
			radio_value = radios[i].value;
		}
	}

	if(radio_value == "radio1") {
		return true;
	}else if(radio_value == "radio2") {
		checkTime(document.formname.time2, document.formname.select2.value);
	}else if(radio_value == "radio3") {
		checkTime(document.formname.time3, document.formname.select3.value);
	}else if(radio_value == "radio4") {
		if(checkTime(document.formname.time4, document.formname.select4.value) && checkCount(document.formname.count4)) {
			return true;
		}
	}
	
	return false;	
}

function checkTime(time, unit) {
	if(!checkNullField(time,'时间不能为空','<%=path%>')){
		return false;
	}
	if(unit == "<%=IConsts.MINUTE %>" && (parseInt(time.value) >= 60 || parseInt(time.value) == 0)) {
		openModalWindowLong("<%=path%>", "分钟必须在0-60之内");
		return false;
	}
	if(unit == "<%=IConsts.HOUR %>" && (parseInt(time.value) >= 24 || parseInt(time.value) == 0)) {
		openModalWindowLong("<%=path%>", "小时必须在0-24之内");
		return false;
	}
	if(unit == "<%=IConsts.DAY %>" && (parseInt(time.value) >= 60 || parseInt(time.value) == 0)) {
		openModalWindowLong("<%=path%>", "天必须在0-60之内");
		return false;
	}
	
	return true;
}

function checkCount(count) {
	if(!checkNullField(count,'次数不能为空','<%=path%>')){
		return false;
	}
	if(parseInt(count.value) >= 60 || parseInt(count.value) == 0) {
		openModalWindowLong("<%=path%>", "次数必须在0-60之内");
		return false;
	}
	return true;
}

function checkNum(obj){
 var val = obj.value;
 var len = val.length;
 if(val.charAt(0) == '0'){
  obj.value = val.substring(0, 0);
 }
 for(var i = 0; i<len; i++){
  if((val.charAt(i)>'9') || (val.charAt(i) < '0')){
   obj.value = val.substring(0, i);
   break;
  }
 }
}
</script>