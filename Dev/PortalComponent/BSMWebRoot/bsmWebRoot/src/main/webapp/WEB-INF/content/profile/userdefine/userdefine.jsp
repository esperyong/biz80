<!-- content/profile/userdefine/userdefine.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/WEB-INF/common/meta.jsp" %>
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/validationEngine.jquery.css" type="text/css" media="screen" title="no title" charset="utf-8" />
<link href="${ctx}/css/jquery-ui/treeview.css" rel="stylesheet" type="text/css" ></link>
<title></title>
<%String title = "-"; %>
<s:if test="basicInfo.enable == true"><%title = "查看监控策略"; %></s:if><s:else><%title = "编辑监控策略"; %></s:else>

<script type="text/javascript">
var path = "${ctx}";
</script>
<%@ include file="/WEB-INF/common/userinfo.jsp" %>
<script src="${ctxJs}/jquery-1.4.2.min.js"></script>
<script src="${ctxJs}/jquery.blockUI.js"></script>
<script src="${ctx}/js/component/cfncc.js"></script>
<script src="${ctx}/js/component/treeView/tree.js"></script>
<script src="${ctx}/js/component/menu/menu.js"></script>
<script src="${ctx}/js/component/accordionPanel/accordionPanel.js"></script>
<script src="${ctx}/js/component/accordionPanel/accordionAddSubPanel.js"></script>
<script src="${ctx}/js/component/panel/panel.js"></script>
<script type="text/javascript" src="${ctx}/js/component/toast/Toast.js"></script>
<script src="${ctx}/js/component/slider/slider.js"></script>
<script src="${ctxJs}/jquery.validationEngine.js" ></script>
<script src="${ctxJs}/jquery.validationEngine-cn.js" ></script>
<script src="${ctxJs}/profile/comm.js" ></script>
<script src="${ctxJs}/component/comm/winopen.js"></script>
<script src="${ctx}/js/component/popwindow/popwin.js"></script>
<style type="text/css">
.focus{
      border:1px solid #f00;
      background:#fcc;
}
#metricSetting table td{
	vertical-align: middle;
	text-align: center;
}
#metricSetting table th{
	vertical-align: middle;
	text-align: center;
}
.span_dot_shot{width:230px;overflow: hidden; text-overflow:ellipsis;display: inline-block;white-space:nowrap;}
</style>
</head>
<body>
<form name="profileForm" id="profileForm" onsubmit="return false;">
<input type="hidden" name="basicInfo.profileId" value="${basicInfo.profileId}" id="basicInfo_profileId"/>
<input type="hidden" name="basicInfo.resourceId" value="${basicInfo.resourceId}" />
<input type="hidden" name="basicInfo.resourceType" value="${basicInfo.resourceType}" />
<input type="hidden" name="basicInfo.parentId" value="${basicInfo.parentId}" />
<input type="hidden" name="basicInfo.enable" value="${basicInfo.enable}" />
<input type="hidden" name="basicInfo.doaminId" value="${basicInfo.doaminId}" id="basicInfo_doaminId"/>
<input type="hidden" name="modifyListen.resSelect" id="modifyListen_resSelect" value="${modifyListen.resSelect}" /><%--是否选择资源实例 --%>
<input type="hidden" name="modifyListen.metricSet" id="modifyListen_metricSet" value="${modifyListen.metricSet}" /><%-- 是否修改指标  --%>
<input type="hidden" name="modifyListen.customEvent" id="modifyListen_customEvent" value="${modifyListen.customEvent}" /><%-- 是否修改自定义事件 --%>
<input type="hidden" name="modifyListen.alarmRule" id="modifyListen_alarmRule" value="${modifyListen.alarmRule}" /><%-- 是否修改告警规则 --%>
<input type="hidden"  name="basicInfo.createUserId" value="${basicInfo.createUserId}"/>
<input type="hidden"  name="basicInfo.modifyUserId" value="<s:property value="%{@com.mocha.bsm.profile.business.admin.UserMgr@getCurrentUserId()}"/>"/>

<page:applyDecorator name="popwindow" title="<%=title %>">
<page:param name="width">950px;</page:param>
<page:param name="topBtn_index_1">1</page:param>
<page:param name="topBtn_id_1">win-close</page:param>
<page:param name="topBtn_css_1">win-ico win-close</page:param>
<page:param name="topBtn_title_1">关闭</page:param>

<page:param name="bottomBtn_index_1">1</page:param>
<page:param name="bottomBtn_id_1">confirm_button</page:param>
<page:param name="bottomBtn_text_1">确定</page:param>

<page:param name="bottomBtn_index_2">2</page:param>
<page:param name="bottomBtn_id_2">cancel_button</page:param>
<page:param name="bottomBtn_text_2">取消</page:param>

<page:param name="bottomBtn_index_3">3</page:param>
<page:param name="bottomBtn_id_3">apply_button</page:param>
<page:param name="bottomBtn_text_3">应用</page:param>

<page:param name="content">
<%@ include file="/WEB-INF/common/loading.jsp" %>
<div class="pop-left">
<page:applyDecorator name="popwindow" title="监控策略列表">
	<page:param name="width">220px;</page:param>
	<page:param name="content">
		<div id='loadProfileTree'>${profileTree}</div>
		<div style="height: 15px;"></div>
	</page:param>
</page:applyDecorator>
</div>
<div class="pop-right">
<page:applyDecorator name="popwindow" title="${basicInfo.profileName}" >
	<page:param name="width">695px;</page:param>
	<page:param name="content">
		<page:applyDecorator name="accordionAddSubPanel"  >
			 <page:param name="id">basicInfo</page:param>
		     <page:param name="title">常规信息</page:param>
		     <page:param name="height"></page:param>
		     <page:param name="width">685px</page:param>
		     <page:param name="cls">fold-blue</page:param>
		    
		     <page:param name="content">
<!--		     <fieldset class="blue-border" style="width:630px;">-->
<!--			 <legend>基本信息</legend>-->
				<div style="padding:5px; width:630px;">
			     <table  class="fitwid">
						<tbody>
							<tr>
								<td width="15%">策略名称</td><td width="2%">：</td>
								<td width="33%">
								<s:if test="basicInfo.profileType!='UserDefineProfile'||basicInfo.enable==true">
									<div title="<s:property value="basicInfo.profileName"/>" style="width: 200px; text-overflow: ellipsis; overflow: hidden;"><nobr><s:property value="basicInfo.profileName"/></nobr></div>
									<input type="hidden" name="basicInfo.profileName" value="${basicInfo.profileName}"/>
								</s:if>
								<s:else> 
								  <s:textfield name="basicInfo.profileName" id="basicInfo_profileName" cssClass="validate[required[策略名称],length[0,50,策略名称],noSpecialStr[策略名称], ajax[duplicateName]]"/>
								</s:else>
								 </td>
								<s:if test="basicInfo.profileType != 'SystemProfile'">
									<td width="15%"><s:property value="@com.mocha.bsm.profile.business.admin.DomainMgr@getDomainTitle()"/></td><td width="2%">：</td><td width="33%"><div title="<s:property value="basicInfo.domainName"/>" style="width: 210px; text-overflow: ellipsis; overflow: hidden;"><nobr><s:property value="basicInfo.domainName"/></nobr></div></td>
								</s:if>
								<s:else>
									<td width="15%"></td><td width="2%"></td><td width="33%"></td>
								</s:else>
							</tr>
							<tr>
								<s:if test="basicInfo.parentId == null">
									<td width="15%">策略类型</td><td width="2%">：</td><td width="33%"><div title="<s:property value="basicInfo.resourceModel"/>" style="width: 210px; text-overflow: ellipsis; overflow: hidden;"><nobr>${basicInfo.resourceModel}</nobr></div></td>
									<td width="15%">监控模型</td><td width="2%">：</td><td width="33%"><div title="<s:property value="basicInfo.resourceType"/>" style="width: 210px; text-overflow: ellipsis; overflow: hidden;"><nobr>${basicInfo.resourceType}</nobr></div></td>
								</s:if>
								<s:else>
									<td width="15%">策略类型</td><td width="2%">：</td><td width="33%">${basicInfo.resourceType}</td>
									<td width="15%"></td><td width="2%"></td><td width="33%"></td>
								</s:else>
							</tr>
							<s:if test="basicInfo.profileType!='SystemProfile'">
							<tr><td>创建人</td><td>：</td><td><div title="<s:property value="basicInfo.createUserName"/>" style="width: 210px; text-overflow: ellipsis; overflow: hidden;"><nobr>${basicInfo.createUserName}</nobr></div></td><td>创建时间</td><td>：</td><td>${basicInfo.createTime}</td></tr>
							</s:if>
							<tr><td>修改人</td><td>：</td><td><div title="<s:property value="basicInfo.modifyUserName"/>" style="width: 210px; text-overflow: ellipsis; overflow: hidden;"><nobr>${basicInfo.modifyUserName}</nobr></div></td><td>修改时间</td><td>：</td><td>${basicInfo.modifyTime}</nobr></div></td></tr>
							<tr><td>备注</td><td>：</td><td colspan="4"><s:textarea name="basicInfo.desc" rows="10" cols="80" id="basic_desc" cssClass="validate[length[0,200,备注]]"></s:textarea></td></tr>
						</tbody>
					</table>
<!--			</fieldset>-->
				</div>
				<div style="height: 50px;"></div>
		    </page:param>
		</page:applyDecorator>
		<page:applyDecorator name="accordionAddSubPanel"  >
			 <page:param name="id">resInsSelect</page:param>
		     <page:param name="title">资源选择</page:param>
		     <page:param name="height"></page:param>
		     <page:param name="width">685px</page:param>
		     <page:param name="cls">fold-blue</page:param>
		     <page:param name="display">collect</page:param>
		      <page:param name="content">
		      	<div id="resIns_div">
					<%--<s:if test="basicInfo.parentId != null">
						<s:action name="childInsSelect" executeResult="true" ignoreContextParams="false" flush="false" namespace="/profile">
							<s:param name="parentProfileId" value="basicInfo.parentId"></s:param>
							<s:param name="childProfileId" value="basicInfo.profileId"></s:param>
							<s:param name="filterCondition" value=""></s:param>
							<s:param name="resName" value="basicInfo.resourceType"></s:param>
						</s:action>
					</s:if>
					<s:else>
						<s:action name="queryResIns" executeResult="true" ignoreContextParams="false" flush="false" namespace="/profile/userDefineProfile">
							<s:param name="profileId" value="basicInfo.profileId"></s:param>
						</s:action>
					</s:else>--%>
				</div>
		      </page:param>
		</page:applyDecorator>
		<page:applyDecorator name="accordionAddSubPanel"  >
			 <page:param name="id">metricSetting</page:param>
		     <page:param name="title">指标定义</page:param>
		     <page:param name="height"></page:param>
		     <page:param name="width">685px</page:param>
		     <page:param name="cls">fold-blue</page:param>
		     <page:param name="topBtn_Index_1">1</page:param>
		     <page:param name="topBtn_Id_1">resetDefaultValue</page:param>
		     <page:param name="topBtn_Text_1">恢复为默认值</page:param>
		     <page:param name="display">collect</page:param>
		     
		     <page:param name="content">
		     <div id="metric_div">
		     	<%--<s:action name="queryMetric" executeResult="true" ignoreContextParams="false" flush="false" namespace="/profile/userDefineProfile">
					<s:param name="profileId" value="basicInfo.profileId"></s:param>
					<s:param name="resourceId" value="basicInfo.resourceId"></s:param>
				</s:action>--%>
		     </div>
		     </page:param>
		</page:applyDecorator>
		<page:applyDecorator name="accordionAddSubPanel"  >
			 <page:param name="id">customEvent</page:param>
		     <page:param name="title">自定义事件</page:param>
		     <page:param name="height"></page:param>
		     <page:param name="width">685px</page:param>
		     <page:param name="cls">fold-blue</page:param>
		     <page:param name="topBtn_Index_1">1</page:param>
		     <page:param name="topBtn_Id_1">addUserDefEvent</page:param>
		     <page:param name="topBtn_Text_1">添加自定义事件</page:param>
		     <page:param name="display">collect</page:param>
		     
		     <page:param name="content">
		     	<div id="customEvent_div">
		     		<%--<s:action name="queryCustomEvent" executeResult="true" ignoreContextParams="false" flush="false" namespace="/profile/userDefineProfile">
						<s:param name="profileId" value="basicInfo.profileId"></s:param>
					</s:action>--%>
				</div>
		     </page:param>
		</page:applyDecorator>
		<s:if test="basicInfo.parentId == null">
			<page:applyDecorator name="accordionAddSubPanel"  >
				 <page:param name="id">notifyRole</page:param>
			     <page:param name="title">告警规则选择</page:param>
			     <page:param name="height"></page:param>
			     <page:param name="width">685px</page:param>
			     <page:param name="cls">fold-blue</page:param>
			     <page:param name="display">collect</page:param>
			    
			     <page:param name="content">
				     <div id="alarm_div">
				     	<%--<s:action name="queryAlarm" executeResult="true" ignoreContextParams="false" flush="false" namespace="/profile/userDefineProfile">
							<s:param name="profileId" value="basicInfo.profileId"></s:param>
						</s:action>--%>
				     </div>
			     </page:param>
			</page:applyDecorator>
		</s:if>
	</page:param>
</page:applyDecorator>
</div>
</page:param>
</page:applyDecorator>
<script type="text/javascript" src="${ctx}/js/profile/userdefine/frequencyPanel.js"> </script>
<script src="${ctxJs}/profile/userdefine/userdefine.js"></script>
</form>
</body>
</html>