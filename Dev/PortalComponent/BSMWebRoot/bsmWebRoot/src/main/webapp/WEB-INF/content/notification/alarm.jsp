<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<html>
<head>
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css"></link>
<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css"></link>
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css"></link>
<%@ include file="/WEB-INF/common/userinfo.jsp"%>
<script type="text/javascript">
    var path = '${ctx}';
    var levelname = "${levelName}";
    var levelnames = levelname.split(";");
    var levelId = "${levelId}";
    var levelIds = levelId.split(";");
</script>
<script src="${ctx}/js/jquery-1.4.2.min.js"></script>
</head>
<body>
<div id="loading" class="loading for-inline" style="display: none;">
    <span class="vertical-middle loading-img for-inline"></span><span class="suojin1em">载入中，请稍候...</span>
</div>
<div id="yestp" style="display: block;">
    <s:hidden name="ok1" value="%{@com.mocha.bsm.notification.businessmodel.platform.PlatForm@STATUS_CONFIRM_UNATTENTION}" />
    <s:hidden name="ok2" value="%{@com.mocha.bsm.notification.businessmodel.platform.PlatForm@STATUS_CONFIRM_ATTENTION}" />
    <s:hidden name="active" value="%{@com.mocha.bsm.notification.businessmodel.platform.PlatForm@STATUS_ACTIVE_ATTENTION}" />
    <s:hidden name="unactive" value="%{@com.mocha.bsm.notification.businessmodel.platform.PlatForm@STATUS_ACTIVE_UNATTENTION}" />
    <page:applyDecorator name="tabPanel">
        <page:param name="id">mytab</page:param>
        <page:param name="width">100%</page:param>
        <page:param name="height">100%</page:param>
        <page:param name="tabBarWidth">200</page:param>
        <page:param name="cls">tab-grounp</page:param>
        <page:param name="otherButton">
            <div class="tab-r-menu right">
                <div class="tab-r-menu-r" id="rightMenu" style="background-color: gray; width: 195px;">
                    <SPAN class="ico ico-arrow-zd" id="min" style="display: none;"></SPAN>
                    <div id="big">
                        <span class="ico ico-history" id="ntfQuery1"></span><span class="title" id="ntfQuery2" style="cursor: pointer;">告警查询</span>
                        <span class="ico ico-set"></span><span class="title txt-black" id='openPlatFormSet' style="cursor: pointer;">第三方集成</span>
                        <span class="ico ico-arrow-zk" id="in"></span>
                    </div>
                </div>
            </div>
        </page:param>
        <page:param name="current">1</page:param>
        <page:param name="tabHander">
            <s:property value="viewsJson" escape="false" />
        </page:param>
        <page:param name="content">
            <s:action name="listflash" namespace="/notification" executeResult="true" ignoreContextParams="true" flush="false"></s:action>
        </page:param>
    </page:applyDecorator>
</div>
<script type="text/javascript" src="${ctx}/js/component/date/WdatePicker.js"></script>
<script src="${ctx}/js/component/cfncc.js"></script>
<script src="${ctx}/js/component/tabPanel/tab.js"></script>
<script type="text/javascript" src="${ctx}/js/component/menu/menu.js"></script>
<script type="text/javascript" src="${ctx}/js/component/popwindow/popwin.js"></script>
<script type="text/javascript" src="${ctx}/js/component/comm/winopen.js"></script>
<script type="text/javascript" src="${ctx}/js/notification/management.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery.blockUI.js"></script>
<script type="text/javascript" src="${ctx}/js/component/toast/Toast.js"></script>
<script src="${ctx}/js/component/panel/panel.js"></script>
<input id="ss" type="text" style="width: 0px; height: 0px; font-size: 0px; border:0px" />
</body>
</html>