<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<%@ include file="/WEB-INF/common/meta.jsp" %>
	<script>
		var path = "${ctx}";
		var panel = null;
		var defaultType = "${defaultType}";
		var origalValue = new Array();
		var menu = null;
		var win = null;
	</script>
	<title>策略列表</title>
</head>
<body>
<%@ include file="/WEB-INF/common/loading.jsp" %>
<div class="main-right">
<form name="profileListForm" id="profileListForm" method="post">
<input type="hidden" name="profileDefType" value="${profileDefType}"/>
<input type="hidden" name="orderBy" value="${orderBy}" id="orderBy"/>
<input type="hidden" name="orderType" value="${orderType}" id="orderType"/>
<input type="hidden" name="currentPage" value="${currentPage}" id="currentPage"/>
	<div class="h1">
		<s:if test="defaultType == false">
		<span class="sub-panel-tips"></span><span>说明：自定义策略列表，展现用户自定义的策略内容及相关设置。</span>
		</s:if>
		<s:if test="profileDefType == 'SystemProfile'">
		<span class="sub-panel-tips"></span><span>默认策略列表，默认策略不可删除。</span>
		</s:if>
	</div>
	<div class="h1-1">
		<span style="float:left;">
		<s:if test="defaultType == false">
			<span style="float:left;height:21px;line-height:21px;"><s:property value="@com.mocha.bsm.profile.business.admin.DomainMgr@getDomainTitle()"/>：</span>
			<s:select id="domainId" name="domainId" list="doMainList" listKey="key" listValue="value" value="domainId" headerKey="" headerValue="全部" style="width:70px;"/>
		</s:if>
		<span style="float:left;height:21px;line-height:21px;">策略类型：</span>
		<s:select id="profileType" name="profileType" list="profileTypeList" listKey="key" listValue="value" value="profileType" headerKey="" headerValue="全部" style="width:185px;"/>
		<span style="float:left;height:21px;line-height:21px;">状态：</span>
		<s:select id="profileState" name="profileState" list="profileStateList" listKey="key" listValue="value" value="profileState"  headerKey="" headerValue="全部"  style="width:50px;"/>
		</span>
		<span class="black-btn-l f-right"><span class="btn-r"><span class="btn-m" id="batchOperate"><a>批量操作</a><a class="down"></a></span></span></span>
		<span class="black-btn-l f-right"><span class="btn-r"><span class="btn-m" id="import"><a>导入</a></span></span></span>		
		<s:if test="profileDefType != null">
			<s:if test="defaultType == false">
				<span class="black-btn-l f-right"><span class="btn-r"><span class="btn-m" id="add"><a>新建</a></span></span></span>
			</s:if>
		</s:if>
		<span id="copybtn" class="black-btn-l f-right"><span class="btn-r"><span class="btn-m" id="copy"><a>复制</a></span></span></span>
	</div>
	<div id="child_cirgrid">
		<s:action name="profileListChild"  namespace="/profile"  executeResult="true" ignoreContextParams="true" flush="false"> 
        	<s:param name="profileId" value="profileId"/>
        </s:action> 
	</div>
</form>
</div>
<script src="${ctx}/js/profile/profilelist/profileList.js"></script>
<script src="${ctx}/js/profile/profilelist/profileListChild.js"></script>
</body>
</html>