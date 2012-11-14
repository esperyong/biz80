<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <%@ include file="/WEB-INF/common/meta.jsp"%>
        <%@ include file="/WEB-INF/common/userinfo.jsp"%>
        <link href="${ctx}/css/master.css" rel="stylesheet" type="text/css" />
        <link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css" />
        <link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
        <script src="${ctx}/js/jquery-1.4.2.min.js"></script>
        <script src="${ctx}/js/jquery.blockUI.js"></script>
        <script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.core.js"></script>
        <script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.widget.js"></script>
        <script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.mouse.js"></script>
        <script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.draggable.js"></script>
        <script type="text/javascript" src="${ctx}/js/component/plugins/jquery.timeentry.min.js"></script>
        <script src="${ctx}/js/component/cfncc.js"></script>
        <script type="text/javascript" src="${ctx}/js/component/popwindow/popwin.js"></script>
        <script type="text/javascript" src="${ctx}/js/component/comm/winopen.js"></script>
        <script src="${ctx}/js/component/gridPanel/grid.js"></script>
        <script src="${ctx}/js/component/gridPanel/indexgrid.js"></script>
        <script src="${ctx}/js/component/gridPanel/page.js"></script>
        <script src="${ctx}/js/component/toast/Toast.js"></script>
        <script src="${ctx}/js/component/panel/panel.js"></script>
        <script type="text/javascript" src="${ctx}/js/component/menu/menu.js"></script>
        <script language="javascript" type="text/javascript" src="${ctx}/js/component/date/WdatePicker.js"></script>
        <script src="${ctx}/js/jquery.validationEngine.js"></script>
        <script src="${ctx}/js/jquery.validationEngine-cn.js"></script>
        <script type="text/javascript" src="${ctx}/js/notification/comm.js"></script>
        <script type="text/javascript" src="${ctx}/js/component/combobox/simplebox.js"></script>
        <script type="text/javascript">
		var path = "${ctx}";
		var panel = null;
		var defaultType = "${defaultType}";
		
        var levelname = "${levelName}";
		var levelnames = levelname.split(";");
        
		var levelId = "${levelId}";
		var levelIds = levelId.split(";");
		
        var isShowCheckBox = true;
        var isNotiPlat = true;//是否从告警台打开
	</script>
    </head>
    <script type="text/javascript">
$(function() {
    $.blockUI({message:$('#loading')});
	$('#close_button').click(function(){
		window.close();
	})
    $.unblockUI();
})
</script>
    <body>
    <%@ include file="/WEB-INF/common/loading.jsp"%>
        <page:applyDecorator name="popwindow" title="告警查询">
            <page:param name="topBtn_index_1">1</page:param>
            <page:param name="topBtn_id_1">win-close</page:param>
            <page:param name="topBtn_css_1">win-ico win-close</page:param>
            <page:param name="topBtn_title_1">关闭</page:param>
            <page:param name="bottomBtn_index_1">1</page:param>
            <page:param name="bottomBtn_id_1">close_button</page:param>
            <page:param name="bottomBtn_text_1">关闭</page:param>
            <page:param name="content">
                <form name="queryForm" id="queryForm" method="post">
                    <input type="hidden" name="searchDis" id="searchDis" value="${searchDis}" />
                    <input type="hidden" name="level" id="level" value="${level}" />
                    <div>
                        <div class="alarm-search" id="simpleSearch" <s:if test="searchDis=='advancedSearchstr'">style="display: none;"</s:if>>
                            <li class="margin3">
                                <span style="float: left; height: 21px; line-height: 21px; display: block;" class="title">告警对象：</span>
                                <s:select id="notificationObjId1" name="notificationObjId1" list="resCategorys" listKey="key" listValue="value" headerKey="" headerValue="全部" cssStyle="width: 208px" />
                                <s:select id="nameorip1" name="nameorip1" list="nameoriplist" listKey="optionValue" listValue="optionDisplay" cssStyle="width: 56px" />
                                <s:textfield style="float: left; height: 21px; line-height: 21px; display: block;" name="nameoripvalue1" id="nameoripvalue1" maxlength="" size="15" cssClass="input-single" />
                                <span style="float: left; height: 21px; line-height: 21px; display: block;" class="title">告警时间： </span>
                                <input style="float: left; height: 21px; line-height: 21px; display: block;" type="radio" value="1" name="radio1" <s:if test="radio1!=2">checked</s:if> />
                                <s:select id="sendTime1" name="sendTime1" list="sendTimelist" listKey="optionValue" listValue="optionDisplay" />
                                <input style="float: left; height: 21px; line-height: 21px; display: block;" type="radio" value="2" name="radio1" <s:if test="radio1==2">checked</s:if> />
                                <span style="float: left; height: 21px; line-height: 21px; display: block;" class="title">从</span>
                                <input style="float: left; height: 21px; line-height: 21px; display: block;" type="text" name="notStartTime1" id="notStartTime1" class="input-single" maxlength="19" size="19" readonly="readonly" value="${notStartTime1}" />
                                <span style="float: left; height: 21px; line-height: 21px; display: block;" class="title">到</span>
                                <input style="float: left; height: 21px; line-height: 21px; display: block;" type="text" name="notEndTime1" id="notEndTime1" class="input-single" value="${notEndTime1}" maxlength="19" size="19" readonly="readonly" />
                                <span class="ico ico-select" id="search" title="搜索"></span>
                            </li>
                            <li class="right">
                                <span class="black-btn-l"><span class="btn-r"><span class="btn-m" id="openAdvancedSearch"><a>高级搜索</a> </span> </span> </span>
                            </li>
                        </div>
                        <div class="alarm-advancedsearch" id="openSimpleSearch" <s:if test="searchDis!='advancedSearchstr'">style="display: none;"</s:if>>
                            高级搜索
                            <span class="ico ico-advancesearch"></span>
                        </div>
                        <div class="alarm-search" id="advancedSearch" <s:if test="searchDis!='advancedSearchstr'">style="display: none;"</s:if>>
                            <li class="margin3">
                                <span style="float: left; height: 21px; line-height: 21px; display: block;" class="title">告警对象：</span>
                                <s:select id="notificationObjId" name="notificationObjId" list="resCategorys" listKey="key" listValue="value" headerKey="" headerValue="全部" cssStyle="width: 208px" />
                                <s:select id="nameorip" name="nameorip" list="nameoriplist" listKey="optionValue" listValue="optionDisplay" cssStyle="width: 56px" />
                                <s:textfield style="float: left; height: 21px; line-height: 21px; display: block;" name="nameoripvalue" id="nameoripvalue" maxlength="" size="25" cssClass="input-single" />
                                <span style="float: left; height: 21px; line-height: 21px; display: block;" class="title">${domainPageName}：</span>
                                <s:select id="domainId" name="domainId" list="domainlist" listKey="optionValue" listValue="optionDisplay" headerKey="" headerValue="全部" />
                                <span style="float: left; height: 21px; line-height: 21px; display: block;" class="title">平台：</span>
                                <s:select id="platform" name="platform" list="platformObj" listKey="optionValue" listValue="optionDisplay" headerKey="" headerValue="全部" />
                            </li>
                            <li class="margin3">
                                <span style="float: left; height: 21px; line-height: 21px; display: block;" class="title">告警状态：</span>
                                <s:select id="notionState" name="notionState" list="notificationState" listKey="optionValue" listValue="optionDisplay" headerKey="" headerValue="全部" />
                                <span style="float: left; height: 21px; line-height: 21px; display: block;" class="title">告警时间：</span>
                                <input style="float: left; height: 21px; line-height: 21px; display: block;" type="radio" value="1" name="radio" <s:if test="radio!=2">checked</s:if> />
                                <s:select id="sendTime" name="sendTime" list="sendTimelist" listKey="optionValue" listValue="optionDisplay" />
                                <input style="float: left; height: 21px; line-height: 21px; display: block;" type="radio" value="2" name="radio" <s:if test="radio==2">checked</s:if> />
                                <span style="float: left; height: 21px; line-height: 21px; display: block;" class="title">从</span>
                                <input style="float: left; height: 21px; line-height: 21px; display: block;" type="text" name="notStartTime" id="notStartTime" class="input-single" maxlength="19" size="19" readonly="readonly" value="${notStartTime}" />
                                <span style="float: left; height: 21px; line-height: 21px; display: block;" class="title">到</span>
                                <input style="float: left; height: 21px; line-height: 21px; display: block;" type="text" name="notEndTime" id="notEndTime" class="input-single" value="${notEndTime}" maxlength="19" size="19" readonly="readonly" />
                            </li>
                            <li class="margin3" style="padding-top: 5px;">
                                <span style="float: left; height: 21px; line-height: 21px; display: block;" class="title">告警内容：</span>
                                <s:textfield style="float: left; height: 21px; line-height: 21px; display: block;" name="notContent" id="notContent" maxlength="" size="" cssClass="input-single" />
                                <span style="float: left; height: 21px; line-height: 21px; display: block;" class="title">确认人：</span>
                                <s:textfield style="float: left; height: 21px; line-height: 21px; display: block;" name="querenBody" id="querenBody" maxlength="" size="" cssClass="input-single" />
                                <span style="float: left; height: 21px; line-height: 21px; display: block;" class="title">确认时间：</span>
                                <span style="float: left; height: 21px; line-height: 21px; display: block;" class="title">从</span>
                                <input style="float: left; height: 21px; line-height: 21px; display: block;" type="text" name="querenStartTime" id="querenStartTime" class="input-single" maxlength="19" size="19" readonly="readonly" value="${querenStartTime}" />
                                <span style="float: left; height: 21px; line-height: 21px; display: block;" class="title">到</span>
                                <input style="float: left; height: 21px; line-height: 21px; display: block;" type="text" name="querenEndTime" id="querenEndTime" class="input-single" maxlength="19" size="19" readonly="readonly" value="${querenEndTime}" />
                                <span class="ico ico-select" id="searchAdvanced" title="搜索"></span>
                            </li>
                        </div>
                        <div class="alarm-header">
                            <div class="right">
                                <span class="black-btn-l" id="batchOperate"><span class="btn-r"><span class="btn-m"><a>批量操作</a> </span> </span> </span>
                                <span class="black-btn-l" id="export"><span class="btn-r"><span class="btn-m"><a>导出</a> </span> </span> </span>
                            </div>
                            <div class="tushi right">
                                <s:iterator value="severities" status="stuts" id="ss">
                                    <s:if test="#ss.optionValue==@com.mocha.bsm.event.type.Serverity@SEVERE">
                                        <span onclick="searchCount('<%=com.mocha.bsm.event.type.Serverity.SEVERE%>');" title="致命"><li class="red">
                                                <s:property value="#ss.optionDisplay" />
                                            </li> </span>
                                    </s:if>
                                    <s:elseif test="#ss.optionValue==@com.mocha.bsm.event.type.Serverity@CRITICAL">
                                        <span onclick="searchCount('<%=com.mocha.bsm.event.type.Serverity.CRITICAL%>');" title="严重"><li class="orange">
                                                <s:property value="#ss.optionDisplay" />
                                            </li> </span>
                                    </s:elseif>
                                    <s:elseif test="#ss.optionValue==@com.mocha.bsm.event.type.Serverity@ERROR">
                                        <span onclick="searchCount('<%=com.mocha.bsm.event.type.Serverity.ERROR%>');" title="次要"><li class="yellow">
                                                <s:property value="#ss.optionDisplay" />
                                            </li> </span>
                                    </s:elseif>
                                    <s:elseif test="#ss.optionValue==@com.mocha.bsm.event.type.Serverity@WARNING">
                                        <span onclick="searchCount('<%=com.mocha.bsm.event.type.Serverity.WARNING%>');" title="警告"><li class="blue">
                                                <s:property value="#ss.optionDisplay" />
                                            </li> </span>
                                    </s:elseif>
                                    <s:elseif test="#ss.optionValue==@com.mocha.bsm.event.type.Serverity@INFORMATIONAL">
                                        <span onclick="searchCount('<%=com.mocha.bsm.event.type.Serverity.INFORMATIONAL%>');" title="信息"><li class="green">
                                                <s:property value="#ss.optionDisplay" />
                                            </li> </span>
                                    </s:elseif>
                                    <s:elseif test="#ss.optionValue==@com.mocha.bsm.event.type.Serverity@UNKNOWN">
                                        <span onclick="searchCount('<%=com.mocha.bsm.event.type.Serverity.UNKNOWN%>');" title="未知"><li class="gray">
                                                <s:property value="#ss.optionDisplay" />
                                            </li> </span>
                                    </s:elseif>
                                </s:iterator>
                            </div>
                        </div>
                        <div id="child_cirgrid">
                            <s:action name="historyNotificationlist" namespace="/notification" executeResult="true" ignoreContextParams="true" flush="false">
                                <s:param name="pageHeight">545</s:param>
                                <s:param name="pageSize">20</s:param>
                            </s:action>
                        </div>
                    </div>
                    <script src="${ctx}/js/notification/historynotificationlist/historyNotificationList.js"></script>
                    <script type="text/javascript">SimpleBox.renderAll();</script>
                </form>
            </page:param>
        </page:applyDecorator>
    </body>
</html>
