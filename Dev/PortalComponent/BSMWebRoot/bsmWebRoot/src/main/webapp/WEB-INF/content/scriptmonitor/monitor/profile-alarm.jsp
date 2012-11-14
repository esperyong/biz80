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
		parent.window.toast.addMessage("告警规则操作成功");	
	}catch(e){
		alert(e);
	}
}
</script>
</head>
<body>
<form action="" method="post" name="alertAlarmFormName" id="alertAlarmFormID">
<div class="blackbg01"><span class="ico ico-help"></span>创建告警规则，设置告警的发送方式、接收人、告警时间、告警升级等。</div>
     <div class="fitwid" id="activeModId">
		<span class="field-table-tr-ico">
        <span class="r-ico r-ico-close" id="delRuleRow" title="删除"></span>
        <span class="r-ico r-ico-add" id="addNewRule" title="添加"></span>
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
		<s:iterator value="scriptAlarmRuleList" id="list" status="index">
			<tr>
				<s:if test="#list.rule.ruleId=='default_rule'">
				<td><input type="checkbox" name="checkName" id="checkName" value="<s:property value='#list.rule.ruleId' />" disabled="true"/></td>
				<td><input type="checkbox" name="acCheck" checked="checked" value="<s:property value='#list.rule.ruleId' />##true" disabled="true"/></td>
				</s:if>
				<s:else>
				<td><input type="checkbox" name="checkName" id="checkName" value="<s:property value='#list.rule.ruleId' />"/></td>
				<td><input type="checkbox" name="acCheck" <s:if test="#list.rule.enable==true">checked</s:if> value="<s:property value='#list.rule.ruleId'/>" /></td>
				</s:else>
				<td>
					<span onclick="updateRule('<s:property value="#list.rule.ruleId" />');" style="cursor:pointer"><s:property value='#list.rule.ruleName' /></span>
				</td>
				<td>
				<s:if test="#list.rule.sendType.length>1">
					<select name="selRuleType">
					<s:iterator value="#list.rule.sendType" status="status" id="name">
						<option value="">
						<s:property value="name" />
						</option>
					</s:iterator>
					</select>
				</s:if>
				<s:else>
					<div style="width:150px;text-overflow:ellipsis;white-space:nowrap; overflow:hidden;" title="<s:property value='#list.rule.sendType' />"><s:property value='#list.rule.sendType' /></div>
				</s:else>
				</td>
				<td>
					<div style="width:150px;text-overflow:ellipsis;white-space:nowrap; overflow:hidden;" title="<s:property value='#list.rule.createUserId' />"><s:property value='#list.rule.createUserId' /></div>
				</td>
				<td>
					<div style="width:170px;text-overflow:ellipsis;white-space:nowrap; overflow:hidden;" title="<s:property value='#list.rule.ruleDesc' />"><s:property value='#list.rule.ruleDesc' /></div>
				</td>
			</tr>
		</s:iterator>
		</tbody>
		</table>
		</span>
	 </div>
	 <span class="field-middle"></span>
</form>
<iframe name="alarmSubmitIframe" id="alarmSubmitIframeId" frameborder="0" scrolling="no" height="0" width="0" src=""></iframe>
</body> 
</html>

<script type="text/javascript">
$("document").ready(function() {
$addNewRule=$("#addNewRule");
$delRuleRow=$("#delRuleRow");
isVisible($addNewRule,$delRuleRow);
$addNewRule.click(function(event) {
	var moduleId ="<s:property value='moduleId'/>";
	var height = "700";
	var width = "668";
	var left = "300";
	var top = "0";
	window.open("${ctx}/profile/alarm/alarmDef.action?commonRule.basicInfo.moduleId="+moduleId, "alarmDefWindowSJ", "height="+height+", width="+width+",left="+left+",top="+top+",toolbar=no,menubar=no,scrollbars=yes,resizable=no,location=no,status=no");
});
$delRuleRow.click(function() {
	var che = $("input[name='checkName']:checkbox:checked");  
	 if(che != null && che.length>0) {
		$.ajax({
			type: "POST",
			cache: false,
			data: che.serialize(),
			dataType: "html",
			url: "${ctx}/scriptmonitor/repository/scriptMonitor!deleteAlarmRule.action?profileId="+profileId+"&targetType=alarminfo",
			success: function(data,textStatus){
				var $scriptRepostiory = $("#scriptFrame");
				$scriptRepostiory.find("*").unbind();
				$scriptRepostiory.html(data);
				dialogResize();
			}
		});
	 }else{
		 var _information = new information({text:"请选择一条数据。"});
		 _information.show();
	 }
});
$("#allCheck").click(function(){
	if($(this).attr("checked")) {
		$("input[name='checkName']:checkbox").attr("checked",'true');
	}else {
		$("input[name='checkName']:checkbox").removeAttr("checked");
	}
});
});

//刷新页面
function reloadParentPage(ruleId,isNew){
	isNew = isNew == true ? "create" : "";
	$.ajax({
			type: "POST",
			cache: false,
			data: "ruleId="+ruleId+"&profileId="+profileId+"&targetType=alarminfo&isNew="+isNew,
			dataType: "html",
			url: "${ctx}/scriptmonitor/repository/scriptMonitor!addAlarmRule.action",
			success: function(data,textStatus){
				var $scriptRepostiory = $("#scriptFrame");
				$scriptRepostiory.find("*").unbind();
				$scriptRepostiory.html(data);
				dialogResize();
			}
		});
}
function updateRule(ruleId) {
	var moduleId ="<s:property value='moduleId'/>";
	var width = "668";
	var left = "300";
	var top = "100";
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