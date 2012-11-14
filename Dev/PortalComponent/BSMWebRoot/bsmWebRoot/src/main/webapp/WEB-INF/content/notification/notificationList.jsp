<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <%@ include file="/WEB-INF/common/meta.jsp"%>
        <link href="${ctx}/css/master.css" rel="stylesheet" type="text/css" />
        <link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css" />
        <link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
        <script src="${ctx}/js/jquery-1.4.2.min.js"></script>
        <script src="${ctx}/js/component/cfncc.js"></script>
        <script type="text/javascript" src="${ctx}/js/component/popwindow/popwin.js"></script>
        <script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.core.js"></script>
        <script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.widget.js"></script>
        <script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.mouse.js"></script>
        <script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.draggable.js"></script>
        <script type="text/javascript" src="${ctx}/js/component/plugins/jquery.timeentry.min.js"></script>
        <script src="${ctx}/js/component/cfncc.js"></script>
        <script src="${ctx}/js/component/gridPanel/grid.js"></script>
        <script src="${ctx}/js/component/gridPanel/indexgrid.js"></script>
        <script src="${ctx}/js/component/gridPanel/page.js"></script>
        <script src="${ctx}/js/jquery.blockUI.js"></script>
        <script src="${ctx}/js/component/toast/Toast.js"></script>
        <script src="${ctx}/js/component/panel/panel.js"></script>
        <script language="javascript" type="text/javascript" src="${ctx}/js/component/date/WdatePicker.js"></script>
        <script type="text/javascript" src="${ctx}/js/component/combobox/simplebox.js"></script>
        <script>
		var path = "${ctx}";
		var panel = null;
		var defaultType = "${defaultType}";
	</script>
    </head>
    <body>
        <page:applyDecorator name="headfoot">
            <page:param name="body">
                <form name="nftListForm" id="nftListForm" method="post">
                    <input type="hidden" name="orderBy" id="orderBy" value="${orderBy}" />
                    <input type="hidden" name="orderType" id="orderType" value="${orderType}" />
                    <input type="hidden" name="currentPage" id="currentPage" value="${currentPage}" />
                    <div class="main">
                        <!-- div class="alarm-content txt-white"> -->
                        <div class="gray-bg txt-black" style="padding-bottom: 1px;">
                            <div class="search">
                                <ul>
                                    <li>
                                        <span style="float: left; height: 21px; line-height: 21px; display: block;" class="title">告警对象：</span>
                                        <s:select id="notificationObjId" name="notificationObjId" list="resCategorys" listKey="key" listValue="value" headerKey="" headerValue="全部"  cssStyle="width:180px"/>
                                        <s:select id="nameorip" name="nameorip" list="nameoriplist" listKey="optionValue" listValue="optionDisplay" value="nameorip" headerKey="" cssStyle="width:56px"/>
                                        <s:textfield style="float:left;height:21px;line-height:21px; display: block;" name="nameoripvalue" id="nameoripvalue" maxlength="" size="" cssClass="input-single" cssStyle="width:90px"/>
                                        <span style="float: left; height: 21px; line-height: 21px; display: block;" class="title">${domainPageName}：</span>
                                        <s:select id="domainId" name="domainId" list="domainlist" listKey="optionValue" listValue="optionDisplay" headerKey="" headerValue="全部" cssStyle="width:80px"/>
                                        <span style="float: left; height: 21px; line-height: 21px; display: block;">接收人：</span>
                                        <s:select id="reception" name="reception" list="userlist" listKey="optionValue" listValue="optionDisplay" headerKey="" headerValue="全部" cssStyle="width:100px"/>
                                    </li>
                                    <li>
                                        <span style="float: left; height: 21px; line-height: 21px; display: block;" class="title">发送方式：</span>
                                        <s:select id="sendmode" name="sendmode" list="sendtype" listKey="optionValue" listValue="optionDisplay" headerKey="" headerValue="全部" />
                                        <span style="float: left; height: 21px; line-height: 21px; display: block;" class="title">发送时间：</span>
                                        <input style="float: left; height: 21px; line-height: 21px; display: block;" type="radio" value="1" name="radio" <s:if test="radio!=2">checked</s:if> />
                                        <s:select id="sendTime" name="sendTime" list="sendTimelist" listKey="optionValue" listValue="optionDisplay" />
                                        <input style="float: left; height: 21px; line-height: 21px; display: block;" type="radio" value="2" name="radio" <s:if test="radio==2">checked</s:if> />
                                        <span style="float: left; height: 21px; line-height: 21px; display: block;">从</span>
                                        <input style="float: left; height: 21px; line-height: 21px; display: block;" class="input-single" type="text" name="startTime" id="startTime" maxlength="19" size="19" readonly="readonly" value="${startTime}" />
                                        <span style="float: left; height: 21px; line-height: 21px; display: block;">到</span>
                                        <input style="float: left; height: 21px; line-height: 21px; display: block;" class="input-single" type="text" name="endTime" id="endTime" value="${endTime}" maxlength="19" size="19" readonly="readonly" />
                                        <span class="ico ico-select" id="search"></span>
                                    </li>
                                </ul>
                                <ul class="right">
                                    <!-- li>
                                      <div class="history right">
                                        <p> <span class="title txt-black">历史记录查询</span> <span class="ico ico-arrow-zk"></span> </p>
                                      </div>
                                    </li> -->
                                    <li>
                                        <span class="black-btn-l right" id="export"><span class="btn-r"><span class="btn-m"><a>导出</a>
                                            </span>
                                        </span>
                                        </span>
                                    </li>
                                </ul>
                            </div>
                            <div id="child_cirgrid">
                                <s:action name="notificationlist" namespace="/notification" executeResult="true" ignoreContextParams="true" flush="false">
                                    <s:param name="pageHeight">545</s:param>
                                </s:action>
                            </div>
                        </div>
                    </div>
                    <script src="${ctx}/js/notification/notificationlist/notificationList.js"></script>
                    <script type="text/javascript">SimpleBox.renderAll();</script>
                </form>
            </page:param>
        </page:applyDecorator>
    </body>
</html>