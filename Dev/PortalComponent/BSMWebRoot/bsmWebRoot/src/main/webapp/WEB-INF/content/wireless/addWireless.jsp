<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/WEB-INF/common/meta.jsp"%>
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css">
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css" />
<link type="text/css" href="${ctx}/css/validationEngine.jquery.css" rel="stylesheet" media="screen" title="no title" charset="utf-8" />
<title>添加Action</title>
</head>
<body>
<%@ include file="/WEB-INF/common/loading.jsp" %>
<form name="actionForm" id="actionForm" method="post">
 <input type="hidden" name="instanceId" value="${defineVO.basicInfoVo.instanceId}" id="instanceId"/>
 <input type="hidden" name="defineVO.actionId" value="${defineVO.actionId}" id="actionId"/>
 <input type="hidden" name="defineVO.basicInfoVo.instanceId" value="${defineVO.basicInfoVo.instanceId}"/>
 <s:if test="defineVO.basicInfoVo.createuserId != null">
 	 <input type="hidden" name="defineVO.basicInfoVo.createuserId" id="createuserId" value="${defineVO.basicInfoVo.createuserId}"/>
 </s:if>
 <s:else>
	 <input type="hidden" name="defineVO.basicInfoVo.createuserId" id="createuserId" value="<s:property value="%{@com.mocha.bsm.wireless.admin.UserMgr@getCurrentUserId()}"/>"/>
 </s:else>
 <s:if test="defineVO.basicInfoVo.createuserId != null">
	 <input type="hidden" name="defineVO.basicInfoVo.userdomainId" id="userdomainId" value="${defineVO.basicInfoVo.userdomainId}"/>
 </s:if>
 <s:else>
	 <input type="hidden" name="defineVO.basicInfoVo.userdomainId" id="userdomainId" value="<s:property value="%{@com.mocha.bsm.wireless.admin.DomainMgr@getCurrentUserDomainId()}"/>"/>
 </s:else>
 <%String title = "-"; %>
<s:if test="defineVO.actionId == null"><%title = "添加Action"; %></s:if><s:else><%title = "编辑Action"; %></s:else>
<page:applyDecorator name="popwindow"  title="<%=title %>">
 <page:param name="width">550px;</page:param>
 <page:param name="topBtn_index_1">1</page:param>
 <page:param name="topBtn_id_1">win-close</page:param>
 <page:param name="topBtn_css_1">win-ico win-close</page:param>

  <page:param name="bottomBtn_index_1">1</page:param>
 <page:param name="bottomBtn_id_1">confirm_button</page:param>
 <page:param name="bottomBtn_text_1">确定</page:param>
 
 <page:param name="bottomBtn_index_3">1</page:param>
 <page:param name="bottomBtn_id_3">application_button</page:param>
 <page:param name="bottomBtn_text_3">应用</page:param>
 
 <page:param name="bottomBtn_index_2">2</page:param>
 <page:param name="bottomBtn_id_2">cancel_button</page:param>
 <page:param name="bottomBtn_text_2">取消</page:param>
 <page:param name="content">
 
 <page:applyDecorator name="accordionAddSubPanel">
		<page:param name="id">one</page:param>
		<page:param name="title">Action信息</page:param>
		<page:param name="height">450px</page:param>
		<page:param name="width">550px</page:param>
		<page:param name="cls">fold-blue</page:param>
		<page:param name="content">
		 <div>
		  <fieldset class="blue-border" style="width:500px">
		    <legend>Action信息</legend>
		    <ul class="fieldlist-n">
		    <li>
				<span class="field">Action名称</span> 
				<span><s:text name="i18n.wireless.colon"/></span>
				<span>
					<span><s:textfield cssClass="validate[required[Action名称],length[0,50,Action名称],noSpecialStr[Action名称], ajax[duplicateName]]"  name="defineVO.basicInfoVo.actionName" id="actionName" maxlength="" size="30"/></span><span class="red">*</span>    
				</span>
			</li>
		    <li>
				<span class="field">备注</span> 
				<span><s:text name="i18n.wireless.colon"/></span>
				<span>
					<span><s:textarea cssClass="validate[length[0,200,备注]]" id="description" name="defineVO.basicInfoVo.description" cols="40" rows="5"></s:textarea></span>    
				</span>
			</li>
		    </ul>
		  </fieldset>
		  
		  <fieldset class="blue-border" style="width:500px">
		    <legend>触发条件</legend>
		    <ul class="fieldlist-n">
		    <li>
				<span class="field">选择资源</span>
				<span><s:text name="i18n.wireless.colon"/></span> 
				<span>
					<span>
						<s:select name="defineVO.triggerConditionVO.resourceType" id="resourceType" list="defineVO.triggerConditionVO.resourceTypes" listKey="key"  listValue="value" value="defineVO.triggerConditionVO.resourceType" cssClass="validate[required]"/>
						&nbsp;
						<s:select name="defineVO.triggerConditionVO.resourceValue" id="resourceValue" list="defineVO.triggerConditionVO.resourceValues" listKey="key"  listValue="value" value="defineVO.triggerConditionVO.resourceValue" cssClass="validate[required]"/>
					</span>    
				</span>
			</li>
		    <li>
				<span class="field">选择指标</span> 
				<span><s:text name="i18n.wireless.colon"/></span>
				<span>
					<span>
						<s:select name="defineVO.triggerConditionVO.metricType" id="metricType" list="defineVO.triggerConditionVO.metricTypes" listKey="key"  listValue="value" value="defineVO.triggerConditionVO.metricType" cssClass="validate[required]"/>
						&nbsp;
						<s:select name="defineVO.triggerConditionVO.metricValue" id="metricValue" list="defineVO.triggerConditionVO.metricValues" listKey="key"  listValue="value" value="defineVO.triggerConditionVO.metricValue" cssClass="validate[required]"/>
					</span>    
				</span>
			</li>
		    <li>
				<span class="field">选择事件</span> 
				<span><s:text name="i18n.wireless.colon"/></span>
				<span>
					<span>
						<s:select name="defineVO.triggerConditionVO.eventValue" id="eventValue" list="defineVO.triggerConditionVO.eventValues" listKey="key"  listValue="value" value="defineVO.triggerConditionVO.eventValue" cssClass="validate[required]"/>
					</span>    
				</span>
			</li>
		    </ul>
		  </fieldset>
		 </div>
		 </page:param>
	</page:applyDecorator>
	
	<page:applyDecorator name="accordionAddSubPanel">
		<page:param name="id">two</page:param>
		<page:param name="title">脚本信息</page:param>
		<page:param name="height">450px</page:param>
		<page:param name="width">550px</page:param>
		<page:param name="cls">fold-blue</page:param>
		<page:param name="display">collect</page:param>
		<page:param name="content">
			<div>
				<fieldset class="blue-border" style="width:500px">
				    <legend>选择脚本</legend>
				    <ul class="fieldlist-n">
				    
				    	<li><span class="sub-panel-tips" style="line-height:20px;">选择已添加脚本，可在" 监控管理 -> 扩展监控 -> 脚本库 "中新增脚本。</span></li>
					    <li>
							<span class="field">选择脚本</span> 
							<span><s:text name="i18n.wireless.colon"/></span>
							<span>
								<input type="hidden" name="defineVO.scriptInfoVO.scriptId" id="script_Id" value="${defineVO.scriptInfoVO.scriptId}">
								<span><s:textfield name="defineVO.scriptInfoVO.scriptName" id="script_Name"  disabled="true" cssClass="validate[required]"/></span><span class="red">*</span><span class="ico ico-find" title="点击进行择选择"></span>    
							</span>
						</li>
					    <li>
							<span class="field">脚本文件路径</span> 
							<span><s:text name="i18n.wireless.colon"/></span>
							<span>
								<span><s:textfield name="defineVO.scriptInfoVO.scriptPath" id="script_filePath" disabled="true" /></span>    
							</span>
						</li>
					    <li>
							<span class="field">脚本所在服务器</span>
							<span><s:text name="i18n.wireless.colon"/></span> 
							<span>
								<span><s:textfield name="defineVO.scriptInfoVO.scriptIp" id="script_Ip" disabled="true" /></span> <span class="black-btn-l"> <span class="btn-r"><span class="btn-m" id="testCommond"><a>检测</a></span></span></span>    
							</span>
						</li>
				    </ul>
			    </fieldset>
			    <s:set name="parameters" value="defineVO.parameters"/>
			    <s:set name="flag" value="true"/>
			    <div id="parameter_div">
			    	<%@ include file="parameter.jsp"%>
	    		</div>
				  	
			</div>
		</page:param>
	</page:applyDecorator>
 </page:param>
</page:applyDecorator>
<div id="runResultDiv" style="display:none;"></div>
</form>
</body>
<script>var path = "${ctx}";var panel = "ss";</script>
<script src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script src="${ctx}/js/jquery.validationEngine-cn.js"></script>
<script src="${ctx}/js/jquery.validationEngine.js"></script>
<script src="${ctx}/js/component/plugins/jquery.ui.core.js"></script>
<script src="${ctx}/js/component/plugins/jquery.ui.widget.js"></script>
<script src="${ctx}/js/component/plugins/jquery.ui.mouse.js"></script>
<script src="${ctx}/js/component/plugins/jquery.ui.draggable.js"></script>
<script src="${ctx}/js/component/cfncc.js"></script>
<script src="${ctx}/js/component/accordionPanel/accordionPanel.js"></script>
<script src="${ctx}/js/component/accordionPanel/accordionAddSubPanel.js"></script>
<script src="${ctx}/js/jquery.blockUI.js"></script>
<script src="${ctx}/js/component/popwindow/popwin.js"></script>
<script src="${ctx}/js/component/panel/panel.js"></script>
<script src="${ctx}/js/wireless/addWireless.js"></script>
</html>