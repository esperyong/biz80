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
<jsp:directive.page import="com.mocha.bsm.itom.util.PageUtil"/>
<%@ include file="/modules/common/security.jsp"%>
<%@ taglib uri="/mochatag" prefix="mt"%>
<%
   ReqRes rr = new ReqRes(request, response);
   rr.encoding("UTF-8").nocache().security();
   String sendType = rr.param("sendType", null);
   String sendFreq = rr.param("sendFreq", null);
   String sendUnit = rr.param("sendUnit", null);
   String sendCount = rr.param("sendCount", null);

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
<mt:inforHead alt="发送待办条件" title="发送待办条件" width="622" heigh="130" imgurl="<%=imgRootPath%>"/>
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="8"></td>
  </tr>
</table>
<table width="96%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="28" align="right"><div align="left" class="zi">发送待办条件：</div></td>
    <td align="right"><div align="left" class="zi">
    <input name="radiobutton" type="radio" value="radio1" <%if(rr.empty(sendType) || "radio1".equals(sendType)) {%>checked<%} %> <%if(!isPortalAdmin){ %>disabled<%} %>>产生事件立即发送待办。</div></td>
  </tr>
  <tr>
    <td width="20%" height="28" align="right"></td>
    <td width="80%" align="right">
    <div align="left" class="zi">
      <input name="radiobutton" type="radio" value="radio2" <%if("radio2".equals(sendType)) {%>checked<%} %> <%if(!isPortalAdmin){ %>disabled<%} %>>
      <input name="time2" type="text" value="<%if("radio2".equals(sendType)){out.print(PageUtil.nvl(sendFreq, ""));}%>" size="3" maxlength="3" class="zi" onkeyup="checkNum(this);">
      <select name="select2" class="zi">
      	<%for(int i = 0; i < timeType.size(); i++) {
      		String key = (String)timeType.getKey(i);
      		String value = (String)timeType.get(key);
      	%>
	      <option value="<%=key %>" <%if("radio2".equals(sendType) && rr.equals(key, sendUnit)) {%>selected<%} %>><%=value %> </option>
		<%} %>
      </select>内产生的同一事件只发送一次待办。
    </div>
    </td>
  </tr>
  <tr>
    <td height="28" align="right">&nbsp;</td>
    <td align="right">
    <div align="left" class="zi">
      <input name="radiobutton" type="radio" value="radio3" <%if("radio3".equals(sendType)) {%>checked<%} %> <%if(!isPortalAdmin){ %>disabled<%} %>>产生的同一事件超过
      <INPUT name="time3" value="<%if("radio3".equals(sendType)){out.print(PageUtil.nvl(sendFreq, ""));}%>" size="3" maxlength="3" type="text" class="zi"" onkeyup="checkNum(this);">
        <select name="select3" class="zi">
	        <%for(int i = 0; i < timeType.size(); i++) {
	      		String key = (String)timeType.getKey(i);
	      		String value = (String)timeType.get(key);
	      	%>
		      <option value="<%=key %>" <%if("radio3".equals(sendType) && rr.equals(key, sendUnit)) {%>selected<%} %>><%=value %></option>
		    <%} %>
        </select>以上没有恢复则发送待办。
        </div>
    </td>
  </tr>
  <tr>
    <td height="28" align="right">&nbsp;</td>
    <td align="right">
    <div align="left" class="zi">
      <input name="radiobutton" type="radio" value="radio4" <%if("radio4".equals(sendType)) {%>checked<%} %> <%if(!isPortalAdmin){ %>disabled<%} %>>产生的同一事件在
	  <INPUT name="time4" value="<%if("radio4".equals(sendType)){out.print(PageUtil.nvl(sendFreq, ""));}%>" size="3" maxlength="3" type="text" class="zi" onkeyup="checkNum(this);">
		<select name="select4" class="zi">
			<%for(int i = 0; i < timeType.size(); i++) {
	      		String key = (String)timeType.getKey(i);
	      		String value = (String)timeType.get(key);
	      	%>
		      <option value="<%=key %>" <%if(rr.equals(key, sendUnit)) {%>selected<%} %>><%=value %></option>
		    <%} %>
		</select>内发生
	  <INPUT name="count4" size="3" maxlength="3" type="text" class="zi" onkeyup="checkNum(this);" value="<%if("radio4".equals(sendType)){out.print(PageUtil.nvl(sendCount, ""));}%>">次则发送待办。
	</div>
	</td>
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
function doSubmit() {
	var flag = checkForm();
	if(!flag) {
	   parent.parent.formname.sendType.value = "<%=sendType %>";
	   parent.parent.formname.sendFreq.value = "<%=sendFreq %>";
	   parent.parent.formname.sendUnit.value = "<%=sendUnit %>";
	   parent.parent.formname.sendCount.value = "<%=sendCount %>";
	}
	return flag;
}
function checkForm() {
	var radios = document.formname.radiobutton;
	var radio_value = "";
	for(i = 0; i < radios.length; i++) {
		if(radios[i].checked) {
			radio_value = radios[i].value;
		}
	}
	parent.parent.formname.sendType.value = radio_value;


	if(radio_value == "radio1") {
		return true;
	}else if(radio_value == "radio2") {
		if(checkTime(document.formname.time2, document.formname.select2.value)){
			return true;
		}
	}else if(radio_value == "radio3") {
		if(checkTime(document.formname.time3, document.formname.select3.value)) {
			return true;
		}
	}else if(radio_value == "radio4") {
		if(checkTime(document.formname.time4, document.formname.select4.value) && checkCount(document.formname.count4)) {
			return true;
		}
	}

	return false;
}

function checkTime(time, unit) {
	if(!checkNullField(time,'itpm.strategy.conditon.date.noNull','<%=path%>')){
		return false;
	}

	parent.parent.formname.sendFreq.value = time.value;
	parent.parent.formname.sendUnit.value = unit;
	return true;
}

function checkCount(count) {
	if(!checkNullField(count,'itpm.strategy.conditon.times.noNull','<%=path%>')){
		return false;
	}
	parent.parent.formname.sendCount.value = count.value;
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