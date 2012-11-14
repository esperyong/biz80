<!-- content/profile/custom/custom.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/WEB-INF/common/meta.jsp" %>
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css"></link>
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" ></link>
<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/validationEngine.jquery.css" type="text/css" media="screen" title="no title" charset="utf-8" />
<style type="text/css">
.monitor-items th{
text-align: center;
vertical-align: middle;
}
.monitor-items td{
text-align: center;
vertical-align: middle;
}
</style>
<script type="text/javascript">
var path = "${ctx}";
</script>
<script src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script src="${ctx}/js/jquery.blockUI.js"></script>
<script src="${ctx}/js/component/cfncc.js"></script>
<script src="${ctx}/js/component/accordionPanel/accordionPanel.js"></script>
<script src="${ctx}/js/component/accordionPanel/accordionAddSubPanel.js"></script>
<script src="${ctx}/js/component/panel/panel.js"></script>
<script src="${ctx}/js/component/toast/Toast.js"></script>
<script src="${ctx}/js/component/slider/slider.js"></script>
<script src="${ctx}/js/component/comm/winopen.js"></script>
<script src="${ctx}/js/jquery.validationEngine-cn.js"></script> 
<script src="${ctx}/js/jquery.validationEngine.js"></script>
<script src="${ctx}/js/profile/comm.js"></script>
<script src="${ctxJs}/component/comm/winopen.js"></script>
<script src="${ctx}/js/component/popwindow/popwin.js"></script>
</head>
<body>
<%@ include file="/WEB-INF/common/loading.jsp" %>
<form name="customProfileForm" id="customProfileForm">
<input type="hidden" name="rowIndex" value="${rowIndex}" id="rowIndex"/>
<input type="hidden" name="basicInfo.profileId" value="${basicInfo.profileId}" id="basicInfo_profileId"/>
<input type="hidden" name="basicInfo.incId" value="${basicInfo.incId}" id="basicInfo_incId"/>
<input type="hidden" name="basicInfo.incName" value="${basicInfo.incName}" id="basicInfo_incName"/>
<input type="hidden" name="basicInfo.resourceId" value="${basicInfo.resourceId}" id="basicInfo_resourceId"/>
<input type="hidden" name="basicInfo.parentId" value="${basicInfo.parentId}" id="basicInfo_parentId"/>
<input type="hidden" name="basicInfo.createUserId" value="${basicInfo.createUserId}" id="basicInfo_createUserId"/>
<s:if test="basicInfo.modifyUserId != null">
<input type="hidden" name="basicInfo.modifyUserId" value="${basicInfo.modifyUserId}" id="basicInfo_modifyUserId"/>
</s:if>
<s:else>
<input type="hidden" name="basicInfo.modifyUserId" value="<s:property value="%{@com.mocha.bsm.profile.business.admin.UserMgr@getCurrentUserId()}"/>" id="basicInfo_modifyUserId"/>
</s:else>
<input type="hidden" name="basicInfo.doaminId" value="${basicInfo.doaminId}" id="basicInfo_doaminId"/>

<input type="hidden" name="listen.isNew" value="${listen.isNew}" id="listen_isNew"/>
<input type="hidden" name="listen.metricSetHaveChange"  value="${listen.metricSetHaveChange}"  id="listen_metricSetHaveChange"/>
<input type="hidden" name="listen.alarmRuleHaveChange"  value="${listen.alarmRuleHaveChange}" id="listen_alarmRuleHaveChange"/>
<page:applyDecorator name="popwindow"  title="${basicInfo.incName}个性化监控设置">
	<page:param name="width">750px;</page:param>
	<page:param name="height">550px;</page:param>
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
    <!-- 常规信息 start -->
	<page:applyDecorator name="accordionAddSubPanel"  >
		 <page:param name="id">generalInfo</page:param>
	       <page:param name="title">常规信息</page:param>
	       <page:param name="height">455px</page:param>
	       <page:param name="width">735px</page:param>
	       <page:param name="cls">fold-blue</page:param>
	      <%--
	       <page:param name="display">collect</page:param>
	       --%> 
	       <page:param name="content">
	       <li style="padding-left:10px">
		     	<table  class="fitwid">
					<tbody>
						<br>
						<tr><td width="13%"><s:property value="@com.mocha.bsm.profile.business.admin.DomainMgr@getDomainTitle()"/></td><td width="2%">：</td><td width="35%"><div title="<s:property value="basicInfo.domainName"/>" style="width: 200px; text-overflow: ellipsis; overflow: hidden;"><nobr>${basicInfo.domainName}</nobr></div></td>
							<td width="13%">资源类型</td><td width="2%">：</td><td width="35%"><div title="<s:property value="basicInfo.resourceType"/>" style="width: 210px; text-overflow: ellipsis; overflow: hidden;"><nobr>${basicInfo.resourceType}</nobr></div></td></tr>
						<tr><td>创建人</td><td>：</td><td><div title="<s:property value="basicInfo.createUserName"/>" style="width: 210px; text-overflow: ellipsis; overflow: hidden;"><nobr>${basicInfo.createUserName}</nobr></div></td>
							<td>修改人</td><td>：</td><td><div title="<s:property value="basicInfo.modifyUserName"/>" style="width: 210px; text-overflow: ellipsis; overflow: hidden;"><nobr>${basicInfo.modifyUserName}</nobr></div></td></tr>
						<tr><td>创建时间</td><td>：</td><td>${basicInfo.createTime}</td><td>修改时间</td><td>：</td><td>${basicInfo.modifyTime}</td></tr>
						<tr><td>备注</td><td>：</td><td colspan="2"><s:textarea name="basicInfo.desc" rows="3" cols="50" cssClass="validate[length[0,200,备注]]"/></td></tr>
					</tbody>
				</table>
			</li>		
		   </page:param>
	</page:applyDecorator >
    <!-- 常规信息 end -->
    <!-- 指标设置 start -->
    <page:applyDecorator name="accordionAddSubPanel"  >
			 <page:param name="id">metricSetting</page:param>
		     <page:param name="title">指标定义</page:param>
		     <page:param name="height">455px</page:param>
		     <page:param name="width">735px</page:param>
		     <page:param name="cls">fold-blue</page:param>
		     <page:param name="topBtn_Index_1">1</page:param>
		     <page:param name="topBtn_Id_1">resetDefaultValue</page:param>
		     <page:param name="topBtn_Text_1">恢复为默认值</page:param>
		     <page:param name="display">collect</page:param>
		     
		     <page:param name="content">
		     <div id="metric_div" style="height: 450px; overflow-y: auto;" class="f-relative">
		     	<s:action name="queryCustomMetric" executeResult="true" ignoreContextParams="false" flush="false" namespace="/profile/customProfile">
					<s:param name="profileId" value="basicInfo.profileId"></s:param>
					<s:param name="instanceId" value="basicInfo.incId"></s:param>
				</s:action>
		     </div>
		     </page:param>
		</page:applyDecorator>
    <!-- 指标设置 end -->
    <!-- 告警规则选择 start -->
	<page:applyDecorator name="accordionAddSubPanel"  >
	 <page:param name="id">notifyRole</page:param>
	    <page:param name="title">告警规则选择</page:param>
	    <page:param name="height">455px</page:param>
	    <page:param name="width">735px</page:param>
	    <page:param name="cls">fold-blue</page:param>
	    <page:param name="display">collect</page:param>
	   
	    <page:param name="content">
	    <div id="alarm_div" style="height: 450px; overflow-y: auto;" class="f-relative">
	    	<s:action name="queryCustomAlarm" executeResult="true" ignoreContextParams="false" flush="false" namespace="/profile/customProfile">
				<s:param name="profileId" value="basicInfo.profileId"></s:param>
				<s:param name="instanceId" value="basicInfo.incId"></s:param>
			</s:action>
	    </div>
	     
	    </page:param>
	</page:applyDecorator>
    <!-- 告警规则选择 end -->
    </page:param>
</page:applyDecorator>
</form>
<script src="${ctx}/js/profile/custom/custom.js"></script>
</body>
</html>