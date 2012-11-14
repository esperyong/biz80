<!-- 监控列表   mainRight.jsp   -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <%@ include file="/WEB-INF/common/meta.jsp" %>
        <%@ include file="/WEB-INF/common/taglibs.jsp" %>
        <%@ include file="/WEB-INF/common/userinfo.jsp" %>
            <form id="operateForm" name="operateForm" method="post" action="" target="changeType" onsubmit="Monitor.Resource.right.openSpecfiyWindow('changeType')" 
                    ><input type="hidden" id="instanceId" name="instanceId" value=""  
            /></form>
            <form id="delResultForm" name="delResultForm" method="post" action="" target="delResult" onsubmit="Monitor.Resource.right.openDelResultWindow('delResult') "  
                    ><input type="hidden" id="delResult" name="delResult" value="" 
            /></form>
            <form id="starMonitorForm" name="starMonitorForm" method="post" action="" target="starMonitorResult" onsubmit="Monitor.Resource.right.openStarMonitorResultWindow('starMonitorResult') "  
                    ><input type="hidden" id="starMonitorResult" name="starMonitorResult" value=""   
                    /><input type="hidden" name="pointId" value="<s:property value="pointId"/>"
                    /><input type="hidden" name="pointLevel" value="<s:property value="pointLevel"/>"
                    /><input type="hidden" name="monitor" value="monitor"
                    /><input type="hidden" name="whichTree" value="<s:property value="whichTree"/>"
                    /><input type="hidden" name="whichGrid" value="<s:property value="whichGrid"/>"
                    /><input type="hidden" name="grid" value="<s:property value="grid"/>"
                    /><input type="hidden" name="currentTree" value="<s:property value="currentTree"/>"
                    /><input type="hidden" name="currentResourceTree" value="<s:property value="currentResourceTree"/>"
                    /><input type="hidden" name="search" value="<s:property value="search"/>"
                    /><input type="hidden" name="currentDomainId" value="<s:property value="currentDomainId"/>"
                    /><input type="hidden" name="currentUserId" value="<s:property value="currentUserId "/>"
                    /><input type="hidden" name="isAdmin" value="<%=isAdmin %>"
            /></form>    
            <form id="submitForm" action="" method="Post"
                ><input type="hidden" name="pointId" id="pointId" value="<s:property value="pointId"/>"
                /><input type="hidden" name="pointLevel" id="pointLevel" value="<s:property value="pointLevel"/>"
                /><input type="hidden" name="monitor" id="monitor" value="<s:property value="monitor"/>"
                /><input type="hidden" name="whichTree" id="whichTree" value="<s:property value="whichTree"/>"
                /><input type="hidden" name="whichGrid" id="whichGrid" value="<s:property value="whichGrid"/>"
                /><input type="hidden" name="grid" id="grid" value="<s:property value="grid"/>"
                /><input type="hidden" name="currentTree" id="currentTree" value="<s:property value="currentTree"/>"
                /><input type="hidden" name="currentResourceTree" id="currentResourceTree" value="<s:property value="currentResourceTree"/>"
                /><input type="hidden" name="search" id="search" value="<s:property value="search"/>"
                /><input type="hidden" name="currentDomainId" id="currentDomainId" value="<s:property value="currentDomainId"/>"
                /><input type="hidden" name="currentUserId" id="currentUserId" value="<s:property value="currentUserId "/>"
                /><input type="hidden" name="isAdmin" id="isAdmin" value="<%=isAdmin %>"/>
            </form>
            <s:if test="pointId == 'pc'">
                <div class="tab" id="mytab" style="">
                    <DIV class="tab-grounp">
                       <DIV class="f-right tab-btn"><A style="COLOR: #fff; MARGIN-LEFT: 5px; VERTICAL-ALIGN: middle; CURSOR: pointer" id="refreshSettings" title="刷新设置" onFocus="undefined"><SPAN class="tab-btn-update"></SPAN></A></DIV>
                       <DIV class="f-right tab-btn"><A style="COLOR: #fff; MARGIN-LEFT: 5px; VERTICAL-ALIGN: middle; CURSOR: pointer" id="notOnlineTime" title="计划不在线时间" onFocus="undefined"><SPAN class="tab-btn-time"></SPAN></A></DIV>
                    </DIV>
                    <DIV style="DISPLAY: block; BACKGROUND: #000" class=tab-content>
                         <DIV id=pcGrid class=tab-content-gridmargin>
                                <s:action name="monitorList!getPcGrid" namespace="/monitor" executeResult="true" ignoreContextParams="false" flush="false">
                                     <s:param name="pointId" value="pointId" />
                                     <s:param name="pointLevel" value="pointLevel" />
                                     <s:param name="monitor" value="monitor" />
                                     <s:param name="whichTree" value="whichTree" />
                                     <s:param name="whichGrid" value="whichGrid" />
                                     <s:param name="grid" value="grid" />
                                     <s:param name="currentTree" value="currentTree" />
                                     <s:param name="currentResourceTree" value="currentResourceTree" />
                                     <s:param name="search" value="search" />
                                     <s:param name="currentUserId" value="currentUserId" />
                                     <s:param name="currentDomainId" value="currentDomainId" />
                                     <s:param name="pageName" value="pageName" />
                               </s:action>
                         </DIV>
                    </DIV>
                </div>
            </s:if>
            <s:else>
                <page:applyDecorator name="tabPanel">
                <page:param name="id">mytab</page:param>
                <page:param name="width"></page:param>
                <page:param name="tabBarWidth"></page:param>
                <page:param name="cls">tab-grounp</page:param>
                <page:param name="current"><s:if test="monitor=='noMonitor'">2</s:if><s:else>1</s:else></page:param>
                <page:param name="tabHander">[{text:"<s:property value="monitorTitle"/>",id:"tab1"},{text:"<s:property value="noMonitorTitle"/>",id:"tab2"}] </page:param>
                <page:param name="rightButton">[{ico:"tab-btn-update",text:"",title="刷新设置",id:"refreshSettings"},{ico:"tab-btn-time",text:"",title="计划不在线时间",id:"notOnlineTime"}]</page:param>
                <page:param name="content_1">
                    <div id="monitorGrid" class="tab-content-gridmargin">
                      <s:if test="monitor=='monitor' && whichTree=='link'">
                          <s:action name="monitorList!getMonitorLinkGrid" namespace="/monitor" executeResult="true" ignoreContextParams="false" flush="false">
                                <s:param name="pointId" value="pointId" />
                                <s:param name="pointLevel" value="pointLevel" />
                                <s:param name="monitor" value="monitor" />
                                <s:param name="whichTree" value="whichTree" />
                                <s:param name="whichGrid" value="whichGrid" />
                                <s:param name="grid" value="grid" />
                                <s:param name="currentTree" value="currentTree" />
                                <s:param name="currentResourceTree" value="currentResourceTree" />
                                <s:param name="search" value="search" />
                                <s:param name="currentUserId" value="currentUserId" />
                                <s:param name="currentDomainId" value="currentDomainId" />
                                <s:param name="pageName" value="pageName" />
                            </s:action>
                       </s:if>
                       <s:else>
                        <s:if test="monitor=='monitor' || whichTree=='searchResource'">
                            <s:action name="monitorList!getMonitorGrid" namespace="/monitor" executeResult="true" ignoreContextParams="false" flush="false">
                                <s:param name="pointId" value="pointId" />
                                <s:param name="pointLevel" value="pointLevel" />
                                <s:param name="monitor" value="monitor" />
                                <s:param name="whichTree" value="whichTree" />
                                <s:param name="whichGrid" value="whichGrid" />
                                <s:param name="grid" value="grid" />
                                <s:param name="currentTree" value="currentTree" />
                                <s:param name="currentResourceTree" value="currentResourceTree" />
                                <s:param name="search" value="search" />
                                <s:param name="currentUserId" value="currentUserId" />
                                <s:param name="currentDomainId" value="currentDomainId" />
                                <s:param name="isAdmin" value="isAdmin" />
                            </s:action>
                        </s:if>
                        </s:else>
                    </div>
                </page:param>
                <page:param name="content_2">
                    <div id="nomonitorGrid">
                        <s:if test="monitor=='noMonitor' || whichTree=='searchResource'">
                            <s:action name="monitorList!getNoMonitorGrid" namespace="/monitor" executeResult="true" ignoreContextParams="false" flush="false">
                                <s:param name="pointId" value="pointId" />
                                <s:param name="pointLevel" value="pointLevel" />
                                <s:param name="monitor" value="monitor" />
                                <s:param name="whichTree" value="whichTree" />
                                <s:param name="whichGrid" value="whichGrid" />
                                <s:param name="grid" value="grid" />
                                <s:param name="currentTree" value="currentTree" />
                                <s:param name="currentResourceTree" value="currentResourceTree" />
                                <s:param name="search" value="search" />
                                <s:param name="currentUserId" value="currentUserId" />
                                <s:param name="currentDomainId" value="currentDomainId" />
                                <s:param name="isAdmin" value="isAdmin" />
                            </s:action>
                        </s:if>
                    </div>
                </page:param>
            </page:applyDecorator>
         </s:else>
            <script type="text/javascript">
                //mytab.setTabText(1,"");
                Monitor.Resource.right.pointId = '<s:property value="pointId"/>';
                Monitor.Resource.right.pointLevel = '<s:property value="pointLevel"/>';
                Monitor.Resource.right.monitor = '<s:property value="monitor"/>';
                Monitor.Resource.right.whichTree = '<s:property value="whichTree"/>';
                Monitor.Resource.right.whichGrid = '<s:property value="whichGrid"/>';
                Monitor.Resource.right.currentTree = '<s:property value="currentTree"/>';
                Monitor.Resource.right.currentResourceTree = '<s:property value="currentResourceTree"/>';
                Monitor.Resource.right.resultCount = '<s:property value="resultCount"/>';
                Monitor.Resource.right.monitorCount = '<s:property value="monitorCount"/>';
                Monitor.Resource.right.noMonitorCount = '<s:property value="noMonitorCount"/>';
                Monitor.Resource.right.currentUserId = '<s:property value="currentUserId"/>';
                Monitor.Resource.right.currentDomainId = '<s:property value="currentDomainId"/>';
                Monitor.Resource.right.grid = '<s:property value="grid"/>';
                Monitor.Resource.right.pageName = '<s:property value="pageName"/>';
            </script>