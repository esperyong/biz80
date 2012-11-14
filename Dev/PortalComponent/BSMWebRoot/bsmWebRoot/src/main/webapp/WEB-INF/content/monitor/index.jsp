<!-- 监控列表 index.jsp -->
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
    <%@ include file="/WEB-INF/common/taglibs.jsp" %>
        <%@ include file="/WEB-INF/common/meta.jsp" %>
        <%@ include file="/WEB-INF/common/userinfo.jsp" %>
            <title>Mocha BSM</title>
             <script type="text/javascript">
             if (!window.Monitor) {
            	    window.Monitor = {};
            	}
            	if (!window.name) {
            	    window.name = 'monitorList';
            	}
            	Monitor.Resource = {};
            	Monitor.Resource.confirm = null;
            	Monitor.Resource.infomation = null;
            	Monitor.Resource.toast = {};
            	Monitor.Resource.menu = {};
            	Monitor.Resource.left = {};
            	Monitor.Resource.left.inner = {};
            	Monitor.Resource.left.group = {};
            	Monitor.Resource.left.equipment = {};
            	Monitor.Resource.left.application = {};
            	Monitor.Resource.left.link = {};
            	Monitor.Resource.left.search = {};
            	Monitor.Resource.right = {};
            	Monitor.Resource.right.tab = {};
            	Monitor.Resource.right.pcList = {};
            	Monitor.Resource.right.monitorList = {};
            	Monitor.Resource.right.monitorGrid = {};
            	Monitor.Resource.right.noMonitorGrid = {};
            	Monitor.Resource.right.linkMonitorList = {};
            	Monitor.Resource.right.linkNoMonitorList = {};
            	Monitor.Resource.right.monitorList.ListMenu = {};
            	Monitor.Resource.right.monitorList.lampPanel = null;
            	Monitor.Resource.right.resourceInfoPanel = null;
            	Monitor.Resource.right.businessPanel = null;
            	Monitor.Resource.right.noMonitorList = {};
            	Monitor.Resource.right.searchMonitorList = {};
            	Monitor.Resource.right.searchNoMonitorList = {};
            	Monitor.Resource.right.group = {};
            	Monitor.Resource.right.search = {};
            	Monitor.Resource.right.monitorList.ListMenu.icoId = null;
            	Monitor.Resource.right.monitorList.ListMenu.pointId = null;
            	Monitor.Resource.right.monitorList.ListMenu.nodeId = null;
            	Monitor.Resource.right.monitorList.ListMenu.rowIndex = null;
            	Monitor.Resource.right.monitorList.ListMenu.locationDomainId = null;
            	Monitor.Resource.right.monitorList.ListMenu.discoveryIP = null;
             </script>
            <div id="equipmentLoading" class="loading" style="display:none;"
               ><div class="loading-l"
                ><div class="loading-r"
                    ><div class="loading-m"
                         ><span class="loading-img">设备刷新中，请稍候...</span 
                    ></div
                ></div
                ></div
           ></div> 
           <div id="monitorListLoading" class="loading" style="display:none;"
               ><div class="loading-l"
                ><div class="loading-r"
                    ><div class="loading-m"
                         ><span class="loading-img">载入中，请稍候...</span 
                    ></div
                ></div
                ></div
           ></div> 
            <page:applyDecorator name="headfoot">
            <page:param name="head">
                <link href="${ctx}/css/common.css" rel="stylesheet" type="text/css">
                <link rel="stylesheet" href="${ctx}/css/master.css" type="text/css" />
                <link href="${ctx}/css/button-module.css" rel="stylesheet" type="text/css">
                <link rel="stylesheet" href="${ctx}/css/validationEngine.jquery.css" type="text/css" media="screen" title="no title" charset="utf-8" />
                <link rel="stylesheet" href="${ctx}/css/public.css" type="text/css" />
                <link rel="stylesheet" href="${ctx}/css/jquery-ui/treeview.css" type="text/css" />
                <link rel="stylesheet" href="${ctx}/css/UIComponent.css" type="text/css" />
                <link rel="stylesheet" href="${ctx}/css/device-ico.css" type="text/css" />
                <link rel="stylesheet" href="${ctx}/css/custommodel.css?<%=System.currentTimeMillis() %>" type="text/css" />
                <script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.core.js"></script>
                <script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.widget.js"></script>
                <script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.mouse.js"></script>
                <script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.draggable.js"></script>
                <script type="text/javascript" src="${ctx}/js/jquery.layout-1.2.0.js"></script>
                <script type="text/javascript" src="${ctx}/js/component/cfncc.js"></script>
                <script type="text/javascript" src="${ctx}/js/component/accordionPanel/accordionLeft.js"></script>
                <script type="text/javascript" src="${ctx}/js/component/tabPanel/tab.js"></script>
                <script type="text/javascript" src="${ctx}/js/component/panel/panel.js"></script>
                <script type="text/javascript" src="${ctx}/js/component/treeView/tree.js"></script>
                <script type="text/javascript" src="${ctx}/js/component/gridPanel/grid.js"></script>
                <script type="text/javascript" src="${ctx}/js/component/gridPanel/indexgrid.js"></script>
                <script type="text/javascript" src="${ctx}/js/component/gridPanel/page.js"></script>
                <script type="text/javascript" src="${ctx}/js/component/menu/menu.js"></script>
                <script type="text/javascript" src="${ctx}/js/component/comm/winopen.js"></script>
                <script type="text/javascript" src="${ctx}/js/monitor/Util.js"></script>
                <script type="text/javascript" src="${ctx}/js/monitor/ResourceUtil.js"></script>
                <script type="text/javascript" src="${ctx}/js/component/toast/Toast.js"></script>
                <script type="text/javascript" src="${ctx}/js/component/popwindow/popwin.js"></script>
                <script type="text/javascript" src="${ctx}/js/component/combobox/simplebox.js"></script>
                <script src="${ctx}/js/jquery.blockUI.js" type="text/javascript"></script>
                <style type="text/css">.pitchUp{color: #0b4f7a; cursor: pointer; font-weight: bolder;}.inputoff{color:#CCCCCC}
	           </style>
            </page:param>
                <page:param name="body">
                    <div id="totalDivId" style="height:100%;overflow:auto;" class="main-jk">
                        <div class="ui-layout-west main-jk-left" id="layoutwestId" style="margin-top:2px;">
                            <page:applyDecorator name="accordionLeftPanel">
                                <page:param name="id">resourceOrProfile</page:param>
                                <page:param name="width">100%</page:param>
                                <page:param name="height">100%</page:param>
                                <page:param name="currentIndex"><s:property value="currentTree" /></page:param>
                                <page:param name="panelIndex_0">0</page:param>
                                <page:param name="panelIndex_1">1</page:param>
                                <page:param name="panelTitle_0">资源</page:param>
                                <page:param name="panelTitle_1"><s:if test="profileCanOperate=='true' || isAdmin == 'true'">策略</s:if><s:else></s:else></page:param>
                                <page:param name="panelContent_0">
                                    <div id="resourceDiv" style="height:100%">
                                        <s:action name="monitorList!getResourceTree" namespace="/monitor" executeResult="true" ignoreContextParams="false" flush="false">
                                            <s:param name="pointId" value="pointId" />
                                            <s:param name="pointLevel" value="pointLevel" />
                                            <s:param name="monitor" value="monitor" />
                                            <s:param name="whichTree" value="whichTree" />
                                            <s:param name="whichGrid" value="whichGrid" />
                                            <s:param name="currentTree" value="currentTree" />
                                            <s:param name="currentResourceTree" value="currentResourceTree" />
                                            <s:param name="search" value="search" />
                                            <s:param name="currentUserId" value="currentUserId" />
                                            <s:param name="currentDomainId" value="currentDomainId" />
                                            <s:param name="pageName" value="pageName" />
                                            <s:param name="isAdmin" value="isAdmin" />
                                        </s:action>
                                    </div>
                                </page:param>
                                <page:param name="panelContent_1">
                                    <div id="profileDiv" style="height:100%;overflow:hidden;padding-left:10px;" class="celue">
                                    </div>
                                </page:param>
                            </page:applyDecorator>
                        </div>
                        <div class="ui-layout-center main-jk-right" id="main-right" style="height:auto;">
                            <s:action name="monitorList!getMainRight" namespace="/monitor" executeResult="true" ignoreContextParams="false" flush="false">
                                <s:param name="pointId" value="pointId" />
                                <s:param name="pointLevel" value="pointLevel" />
                                <s:param name="monitor" value="monitor" />
                                <s:param name="whichTree" value="whichTree" />
                                <s:param name="whichGrid" value="whichGrid" />
                                <s:param name="currentTree" value="currentTree" />
                                <s:param name="currentResourceTree" value="currentResourceTree" />
                                <s:param name="search" value="search" />
                                <s:param name="currentUserId" value="currentUserId" />
                                <s:param name="currentDomainId" value="currentDomainId" />
                                <s:param name="pageName" value="pageName" />
                                <s:param name="isAdmin" value="isAdmin" />
                            </s:action>
                        </div>
                    </div>
                </page:param>
            </page:applyDecorator>
            <script type="text/javascript">
            var path = "${ctx}";
            var permissions = true;
            var profileCanOperate = false;
            var hidX = null;
            Monitor.Resource.profileCanOperate = '<s:property value="profileCanOperate"/>';
            if(isAdmin == true || isConfigMgrRole == true || isSystemAdmin == true){
            	profileCanOperate = true;
            }
            var currentUserId = userId;
            
            Monitor.Resource.pageRenovate = '<s:property value="pageRenovate"/>';
            Monitor.Resource.pointId = '<s:property value="pointId"/>';
            Monitor.Resource.pointLevel = '<s:property value="pointLevel"/>';
            Monitor.Resource.monitor = '<s:property value="monitor"/>';
            Monitor.Resource.whichTree = '<s:property value="whichTree"/>';
            Monitor.Resource.whichGrid = '<s:property value="whichGrid"/>';
            Monitor.Resource.currentTree = '<s:property value="currentTree"/>';
            Monitor.Resource.currentResourceTree = '<s:property value="currentResourceTree"/>';
            Monitor.Resource.currentUserId = '<s:property value="currentUserId"/>';
            Monitor.Resource.currentDomainId = '<s:property value="currentDomainId"/>';
            Monitor.Resource.pageName = '<s:property value="pageName"/>';
            Monitor.Resource.right.monitorList.paramMap = new Map();
            $(function() {
                $.blockUI({message:$('#monitorListLoading')});
                Monitor.Resource.init();
                $.unblockUI();
            });
            </script>