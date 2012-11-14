<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<%%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
    <head>
        <style>
            .pop-top-title{
                overflow: hidden; text-overflow:ellipsis;display: inline-block;white-space:nowrap;width:620px;
            }
        </style>
        
        <title>告警分析</title>
        <link href="${ctx}/css/master.css" rel="stylesheet" type="text/css" />
        <link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css"></link>
        <link href="${ctx}/css/public.css" rel="stylesheet" type="text/css"></link>
        <script src="${ctxJs}/jquery-1.4.2.min.js"></script>
        <script src="${ctx}/js/component/cfncc.js"></script>
        <script src="${ctx}/js/component/tabPanel/tab.js"></script>
        <script src="${ctx}/js/component/comm/winopen.js"></script>
        <script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.core.js"></script>
        <script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.widget.js"></script>
        <script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.mouse.js"></script>
        <script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.draggable.js"></script>
        <script type="text/javascript" src="${ctx}/js/component/plugins/jquery.timeentry.min.js"></script>
        <script src="${ctx}/js/component/gridPanel/grid.js"></script>
        <script src="${ctx}/js/component/gridPanel/indexgrid.js"></script>
        <script src="${ctx}/js/component/gridPanel/page.js"></script>
        <script src="${ctx}/js/jquery.blockUI.js"></script>
        <script src="${ctx}/js/component/toast/Toast.js"></script>
        <script src="${ctx}/js/component/panel/panel.js"></script>
    </head>
    <body>
        <page:applyDecorator name="popwindow" title="告警分析-${instanceName}">
            <page:param name="width">700px</page:param>
            <page:param name="height">328px;</page:param>
            <page:param name="topBtn_index_1">1</page:param>
            <page:param name="topBtn_id_1">win-close</page:param>
            <page:param name="topBtn_css_1">win-ico win-close</page:param>
            <page:param name="topBtn_title_1">关闭</page:param>
            <page:param name="bottomBtn_index_1">1</page:param>
            <page:param name="bottomBtn_id_1">cancel_button</page:param>
            <page:param name="bottomBtn_text_1">关闭</page:param>
            <page:param name="content">
                <page:applyDecorator name="tabPanel">
                    <page:param name="id">mytab</page:param>
                    <page:param name="width">680</page:param>
                    <page:param name="tabBarWidth"></page:param>
                    <page:param name="cls">tab-grounp</page:param>
                    <page:param name="current">${tab}</page:param>
                    <page:param name="background">#fff</page:param>
                    <page:param name="tabHander">[{text:"关联事件",id:"tab1"},{text:"告警记录",id:"tab2"}] </page:param>
                    <page:param name="content_1">
                        <div id="events" class="tab-content-gridmargin" style="background-color: white">
                            <s:if test="eventState=='activity'">
                                <s:action name="eventDetailInfo!activeDetailInfo" namespace="/event" executeResult="true" ignoreContextParams="true" flush="false">
                                    <s:param name="eventDetailInfoVO.eventId" value="eventDataId" />
                                    <s:param name="eventDetailInfoVO.occurTimePage" value="eventOccurTime" />
                                    <s:param name="modelType" value="'notification'" />
                                </s:action>
                            </s:if>
                            <s:else>
                                <s:if test="eventState=='history'">
                                    <s:action name="eventDetailInfo!historyDetailInfo" namespace="/event" executeResult="true" ignoreContextParams="true" flush="false">
                                        <s:param name="eventDetailInfoVO.eventId" value="eventDataId" />
                                        <s:param name="eventDetailInfoVO.occurTimePage" value="eventOccurTime" />
                                        <s:param name="modelType" value="'notification'" />
                                    </s:action>
                                </s:if>
                            </s:else>
                        </div>
                    </page:param>
                    <page:param name="content_2">
                        <form name="nftListForm" id="nftListForm" method="post">
                        <input type="hidden" name="orderBy" id="orderBy" value="${orderBy}" />
                        <input type="hidden" name="orderType" id="orderType" value="${orderType}" />
                        <input type="hidden" name="currentPage" id="currentPage" value="${currentPage}" />
                        <input type="hidden" name="eventDataId" id="eventDataId" value="${eventDataId}" />
                        <input type="hidden" name="operateView" id="operateView" value="${operateView}" />
                            <div id="logs">
                                <s:action name="notificationlist" namespace="/notification" executeResult="true" ignoreContextParams="true" flush="false">
                                    <s:param name="eventDataId" value="eventDataId" />
                                    <s:param name="operateView" value="'view'" />
                                    <s:param name="orderBy"></s:param>
                                    <s:param name="orderType"></s:param>
                                    <s:param name="currentPage"></s:param>
                                    <s:param name="pageHeight">270</s:param>
                                    <s:param name="pageWidth">680</s:param>
                                </s:action>
                            </div>
                        </form>
                    </page:param>
                </page:applyDecorator>
            </page:param>
        </page:applyDecorator>
        <script type="text/javascript">
    	   var tp = new TabPanel({
    	       id: "mytab",
    	       listeners: {
                 change: function(tab) {
                     if (tab.index == 1) {
                     }
                     if (tab.index == 2) {
                     }
                 }
    	       }
    	   });
           
        </script>
        <script type="text/javascript" src="${ctx}/js/notification/comm.js"></script>
    </body>
</html>
