<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/WEB-INF/common/meta.jsp"%>
<%@ include file="/WEB-INF/common/userinfo.jsp"%>
<link href="${ctx}/css/jquery-ui/treeview.css" rel="stylesheet" type="text/css" ></link>
<link type="text/css" href="${ctx}/css/validationEngine.jquery.css" rel="stylesheet" media="screen" title="no title" charset="utf-8" />
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" ></link>
<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css" ></link>
<script type="text/javascript">
path = '${ctx}';
</script>
<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script src="${ctx}/js/jquery.validationEngine.js"></script>
<script src="${ctx}/js/jquery.validationEngine-cn.js"></script>
<script src="${ctx}/js/component/cfncc.js"></script>
<script src="${ctx}/js/component/treeView/tree.js"></script>
<script type="text/javascript" src="${ctx}/js/notification/comm.js"></script>
<script type="text/javascript" src="${ctx}/js/notification/viewEdit.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery.blockUI.js"></script>
<script type="text/javascript" src="${ctx}/js/component/popwindow/popwin.js"></script>
</head>
<body>
<%@ include file="/WEB-INF/common/loading.jsp" %>
<page:applyDecorator name="popwindow"  title="实时告警视图">
	<page:param name="width">700px;</page:param>
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
	<page:param name="content">
	<s:select list="resCategorys" listKey="key" listValue="value" id="_resCategorys" name="" cssStyle="display:none;"></s:select>
<form action="viewEditorSave.action" method="post" id="platform_form">
<s:hidden name="viewId"/>
<fieldset class="blue-border" style="width:630px;" id='view_baseInfo'>
<legend>基本信息</legend>
<div><span>视图名称：</span><s:textfield name="viewName" cssClass="validate[required,noAdminName,length[0,30]]"></s:textfield><font color='red'>*</font>
</div>
</fieldset>
<fieldset class="blue-border" style="width:630px;" id='view_baseInfo'>
<legend>告警过滤</legend>


<div id="platform" class="clear">
<span class="field-min left for-inline" style="margin-top: 4px;">平台：</span><span class="left for-inline"><input type="checkbox" id="all_p">全选</span>
<span class="for-inline left" style="width: 82%;">
<%--<s:checkboxlist list="supportPlatforms" listKey="optionValue" listValue="optionDisplay" name="platformId"/>--%>

<s:iterator value="supportPlatforms" status="s" id="form">   

    <%--<s:iterator value="platformId" status="p" id="plat">
    <s:if test="#plat==#form.optionValue">
    <s:set id="checked"  value = "checked"/>
    </s:if>
    <s:else>
    <s:set id="checked"  value = ""/>
    </s:else>
    </s:iterator>--%>
    
    <div class="left suojin1em"><input type="checkbox" id="platformId_${s.index}" name="platformId" value="${form.optionValue}" ${form.check}>${form.optionDisplay}</div>
</s:iterator>
 
</span>
</div>


<div id="severity" class="clear"><span class="field-min left for-inline" style="margin-top: 4px;">级别：</span><span class="left for-inline"><input type="checkbox" id="all_s">全选</span>
<span class="for-inline left" style="width: 82%;">
<%--<s:checkboxlist list="supportSeverities" listKey="optionValue" listValue="optionDisplay" name="severities"/>--%>

<s:iterator value="supportSeverities" status="s1" id="sever">   

    <%--<s:iterator value="severities" status="se" id="seve">
    <s:if test="#seve==#sever.optionValue">
    <s:set id="checked1"  value = "checked"/>
    </s:if>
    <s:else>
    <s:set id="checked1"  value = ""/>
    </s:else>
    </s:iterator>--%>

    <div class="left suojin1em"><input type="checkbox" id="severities_${s1.index}" name="severities" value="${sever.optionValue}" ${sever.check}>${sever.optionDisplay}</div>
</s:iterator>

</span>
</div>
</fieldset>
<fieldset class="blue-border" style="width:630px;" id='view_baseInfo_notiobj'>
<legend>告警对象</legend>
<div id="objtype"><s:radio list="@com.mocha.bsm.notification.util.enums.NotificationObjTypeEnum@values()" listKey="key" listValue="value" name="viewType"></s:radio></div>
<div id="objcontent" style="height:320px;">
<div id="OBJECT_TYPE" style="display: none;width: 100%;background-color: #f7f7f7;"></div>
<div id="INSTANCEID" style="display: none;"></div>
<div id="RESGROUP" style="display: none;"></div>
<div id="CUSTOM" style="display: none;" ></div>
</div>
</fieldset>
</form>
<form id="operateForm" name="operateForm" method="post" action="" target="changeType" onsubmit="openSpecfiyWindow('changeType')">
		<input name="userId" id="userId" value="<%=userId %>" type="hidden"/>
		<input name="domains" id="domains" value="<%=domainId %>" type="hidden"/>
</form>
	</page:param>
</page:applyDecorator>
<script type="text/javascript">
    function setBodyHeight(pHeight){
        //pHeight = pHeight+295;
        //window.resizeTo(710, pHeight);
        //window.moveTo((screen.width - 800)/2, (screen.height - pHeight)/2); 
    }
    if('${viewId}'=='REAL_TIME_NOTIFICATION'){//实时告警台
        window.resizeTo(710, 233);
        window.moveTo((screen.width - 800)/2, (screen.height - 245)/2); 
    }
    
</script>
</body>
</html>