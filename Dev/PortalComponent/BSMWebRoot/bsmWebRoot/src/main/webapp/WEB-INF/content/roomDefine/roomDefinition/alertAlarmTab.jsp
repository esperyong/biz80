<!-- 机房-机房定义-监控设置-告警定义alertAlarmTab.jsp -->
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>告警定义</title>
<script>
if("<s:property value='saveRuleFalg' />" == "true"){
	try{
		parent.window.ajaxChangeTabPageVisitFun("tab4","<s:property value='roomId' />");
		parent.window.toast.addMessage("告警规则操作成功");
		
	}catch(e){
		//alert(e);
	}
}
</script>
</head>
<body>
<form action="" method="post" name="alertAlarmFormName" id="alertAlarmFormID">
<div style="background-color:#F2F2F2;width:100%；height:100%"><span class="ico ico-note"></span><span>创建告警规则，设置告警的发送方式、接收人、告警时间、告警升级等。</span></div>
     <div class="fitwid" id="activeModId">
		<span class="field-table-tr-ico">
        <span class="r-ico r-ico-close" id="delRuleRow"></span>
        <span class="r-ico r-ico-add" id="addNewRule"></span>
        </span>
		<table id="tb" class="grid-gray-fontwhite">
		<thead>
			<tr>
				<th width="4%"><input type="checkbox" name="allCheck" id="allCheck" /></th>
				<th width="6%">激活</th>
				<th width="20%">规则名称</th>
				<th width="20%">发送方式</th>
				<th width="20%">接收人</th>
				<th width="20%">备注</th>
			</tr>
		</thead>
		<tbody>
		<s:iterator value="commonrule" id="list" status="index">
			<tr>
				
				
				<s:if test="#list.ruleId=='default_rule'">
				<td><input type="checkbox" name="checkName" id="checkName" value="<s:property value='#list.ruleId' />" disabled="true"/></td>
				<td><input type="checkbox" name="acCheck" checked="checked" value="<s:property value='#list.ruleId' />##true" disabled="true"/></td>
				</s:if>
				<s:else>
				<td><input type="checkbox" name="checkName" id="checkName" value="<s:property value='#list.ruleId' />"/></td>
				<s:if test="#list.enable==true">
				<td><input type="checkbox" name="acCheck" checked="checked" value="<s:property value='#list.ruleId' />##true"/></td>
				</s:if>
				<s:else>
				<td><input type="checkbox" name="acCheck" value="<s:property value='#list.ruleId' />##false"/></td>
				</s:else>
				</s:else>
				
				
				<td>
					<span onclick="updateRule('<s:property value="#list.ruleId" />');" style="cursor:pointer"><s:property value='#list.ruleName' /></span>
				</td>
				<td>
				<s:if test="#list.sendType.length>1">
					<select name="selRuleType">
					<s:iterator value="#list.sendType" status="aa" id="name">
						<option value="">
						<s:property value="name" />
						</option>
					</s:iterator>
					</select>
				</s:if>
				<s:else>
					<s:property value='#list.sendType' />
				</s:else>
				</td>
				<s:if test="#list.ruleId=='default_rule'">
					<td></td>
				</s:if>
				<s:else>
					<td><s:property value='#list.createUserId' /></td>
				</s:else>
				
				<td><s:property value='#list.ruleDesc' /></td>
			</tr>
		</s:iterator>
		</tbody>
		</table>
		</span>
	 </div>
	 <ul class="panel-button">
		<li><span></span><a id="useRule" >应用</a></li>
     </ul>
  <input type="hidden" name="roomId" id="roomId" value="<s:property value='roomId'/>" />
</form>
<iframe name="alarmSubmitIframe" id="alarmSubmitIframeId" frameborder="0" scrolling="no" height="0" width="0" src=""></iframe>
</body> 
</html>

<script type="text/javascript">
$("document").ready(function() {
//全选
//$("#allCheck").click(allChoose);
//add
$("#addNewRule").click(function(event) {
	var moduleId ="<s:property value='moduleId'/>";
	var height = "700";
	var width = "668";
	var left = "300";
	var top = "0";
	window.open("${ctx}/profile/alarm/alarmDef.action?commonRule.basicInfo.moduleId="+moduleId, "alarmDefWindowSJ", "height="+height+", width="+width+",left="+left+",top="+top+",toolbar=no,menubar=no,scrollbars=yes,resizable=no,location=no,status=no");
});
//delete
$("#delRuleRow").click(function() {
	var che = $("input[name='checkName']:checkbox:checked");  
	var delId = "";
	 if(che != null && (che.length>0)) {
		var roomId = $("#roomId").val();
		$("#alertAlarmFormID").attr("action","${ctx}/roomDefine/EditRules!deleteRule.action");
		$("#alertAlarmFormID").attr("target","alarmSubmitIframe");
		$("#alertAlarmFormID").submit();
		ajaxChangeTabPageVisitFun("tab4",roomId);
	 }else{
		alert("选择删除的列");
	 }
	 
	
});
//use
$("#useRule").click(function() {
	tab4SubmitFun();	
});
function tab4SubmitFun(){
	//allChooseTrue();
	//var che = $("input[name='acCheck']:checkbox:checked");  
	var roomId = $("#roomId").val();
	$("#alertAlarmFormID").attr("action","${ctx}/roomDefine/EditRules!activeRule.action");
	$("#alertAlarmFormID").attr("target","alarmSubmitIframe");
	$("#alertAlarmFormID").submit();
	//ajaxChangeTabPageVisitFun("tab4",roomId);
}

});
function allChoose() {
    $("#tb tr:gt(0)").each(function() {
        $(this).find("#checkName").get(0).checked = $("#allCheck").get(0).checked;
    });
}
function allChooseTrue() {
    $("#tb tr:gt(0)").each(function() {
        $(this).find("#checkName").get(0).checked = true;
    });
}
//刷新页面
function reloadParentPage(ruleId){
	var roomId = $("#roomId").val();
	$("#alertAlarmFormID").attr("action","${ctx}/roomDefine/EditRules!addRule.action?ruleId="+ruleId);
	$("#alertAlarmFormID").attr("target","alarmSubmitIframe");
	$("#alertAlarmFormID").submit();
	//ajaxChangeTabPageVisitFun("tab4",roomId);
}
function updateRule(ruleId) {
	var moduleId ="<s:property value='moduleId'/>";
	var width = "668";
	var left = "300";
	var top = "100";

	left = (screen.width-668)/2;
	
	if("default_rule" == ruleId){
		top = screen.height/2-150;
		var height1 = "300";
		window.open("${ctx}/profile/alarm/defautAlarmDef.action?ruleId="+ruleId+"&commonRule.basicInfo.moduleId="+moduleId, "alarmDefWindowSJ", "height="+height1+", width="+width+",left="+left+",top="+top+",toolbar=no,menubar=no,scrollbars=yes,resizable=no,location=no,status=no");
	}else{
		top = screen.height/2-300;
		var height2 = "600";
		window.open("${ctx}/profile/alarm/alarmDef.action?ruleId="+ruleId+"&commonRule.basicInfo.moduleId="+moduleId, "alarmDefWindowSJ", "height="+height2+", width="+width+",left="+left+",top="+top+",toolbar=no,menubar=no,scrollbars=yes,resizable=no,location=no,status=no");
	}
	
}
</script>