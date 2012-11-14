<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %> 
<!--资源树  -->
              <page:applyDecorator name="accordionInerPanel">  
                         <page:param name="id">resourcePanel</page:param>
                         <page:param name="width">100%</page:param>
                         <page:param name="height">200px</page:param>
                         <page:param name="currentIndex"><s:property value="currentResourceTree"/></page:param>
                         <page:param name="panelIndex_0">0</page:param>
                         <page:param name="panelOverFlow_0"></page:param>
                         <page:param name="padding_0">0px</page:param>
                         <page:param name="panelIndex_1">1</page:param>
                         <page:param name="panelOverFlow_1">auto</page:param>
                         <page:param name="padding_1">0px</page:param>
                         <page:param name="panelIndex_2">2</page:param>
                         <page:param name="panelOverFlow_2">auto</page:param>
                         <page:param name="padding_2">0px</page:param>
                         <page:param name="panelIndex_3">3</page:param>
                         <page:param name="panelOverFlow_3">auto</page:param>
                         <page:param name="padding_3">0px</page:param>
                         <page:param name="panelTitle_0">资源组</page:param>
                         <page:param name="panelIco_0">tree-panel-ico tree-panel-ico-group</page:param>
                         <page:param name="panelTitle_1">设备列表</page:param>
                         <page:param name="panelIco_1">tree-panel-ico tree-panel-ico-device</page:param>
                         <page:param name="panelTitle_2">应用列表</page:param>
                         <page:param name="panelIco_2">tree-panel-ico tree-panel-ico-app</page:param>
                         <page:param name="panelTitle_3">搜索</page:param>
                         <page:param name="panelIco_3">tree-panel-ico tree-panel-ico-search</page:param> 
                         <page:param name="panelContent_0">  
                               <ul class="fieldlist">   
	                               <li style="width:100%">
	                                   <img class="right" style="cursor:pointer;margin:2px" title="新增资源组" src="${ctx}/images/add-button1.gif" onclick="winOpen({url:'${ctx}/monitor/resourceGroup.action?currentUserId='+Monitor.Resource.left.currentUserId,width:490,height:208,name:'addResGroup'})"/>
                                   </li>
	                           </ul>
	                           <div style="width: 100%; overflow: auto;height:90%;">
                                    <div id="resourceGroupDiv" style="height:100%;width:185px;zoom:1;">
                                         <s:if test="whichTree=='resourceGroupTree'">
                                            <s:action name="monitorList!getResourceGroupTree"  namespace="/monitor"  executeResult="true" ignoreContextParams="false" flush="false">
                                                     <s:param name="pointId" value="pointId"/>
                                                     <s:param name="pointLevel" value="pointLevel"/>
                                                     <s:param name="monitor" value="monitor"/>
                                                     <s:param name="whichTree" value="whichTree"/>
                                                     <s:param name="whichGrid" value="whichGrid"/>
                                                     <s:param name="currentTree" value="currentTree"/>
                                                     <s:param name="currentResourceTree" value="currentResourceTree"/>
                                                     <s:param name="currentUserId" value="currentUserId" />
                                                     <s:param name="currentDomainId" value="currentDomainId" />
                                           </s:action>
                                        </s:if>
                                   </div>
                               </div>
                         </page:param>                    
                         <page:param name="panelContent_1">
                               <div id="equipmentDiv" style="height:100%;width:185px;">
                                    <s:if test="whichTree=='device'">
                                           <s:action name="monitorList!getEquipmentTree"  namespace="/monitor"  executeResult="true" ignoreContextParams="false" flush="false">
                                                     <s:param name="pointId" value="pointId"/>
                                                     <s:param name="pointLevel" value="pointLevel"/>
                                                     <s:param name="monitor" value="monitor"/>
                                                     <s:param name="whichTree" value="whichTree"/>
                                                     <s:param name="whichGrid" value="whichGrid"/>
                                                     <s:param name="currentTree" value="currentTree"/>
                                                     <s:param name="currentResourceTree" value="currentResourceTree"/>
                                                     <s:param name="currentUserId" value="currentUserId" />
                                                     <s:param name="currentDomainId" value="currentDomainId" />
                                           </s:action>
                                    </s:if>
                               </div>
                         </page:param>
                         <page:param name="panelContent_2">
                               <div id="applicationDiv" style="height:100%;width:185px;">
                                    <s:if test="whichTree=='application'">
                                            <s:action name="monitorList!getApplicationTree"  namespace="/monitor"  executeResult="true" ignoreContextParams="false" flush="false">
                                                     <s:param name="pointId" value="pointId"/>
                                                     <s:param name="pointLevel" value="pointLevel"/>
                                                     <s:param name="monitor" value="monitor"/>
                                                     <s:param name="whichTree" value="whichTree"/>
                                                     <s:param name="whichGrid" value="whichGrid"/>
                                                     <s:param name="currentTree" value="currentTree"/>
                                                     <s:param name="currentResourceTree" value="currentResourceTree"/>
                                                     <s:param name="currentUserId" value="currentUserId" />
                                                     <s:param name="currentDomainId" value="currentDomainId" />
                                            </s:action>
                                   </s:if>
                                </div>
                         </page:param>
                         <page:param name="panelContent_3">  
                         <div id="searchResourceDiv" style="height:100%;width:185px;overflow:hidden;">
                              <s:if test="whichTree=='searchResource'">
                                            <s:action name="monitorList!getSearchResourceTree"  namespace="/monitor"  executeResult="true" ignoreContextParams="false" flush="false">
                                                     <s:param name="pointId" value="pointId"/>
                                                     <s:param name="pointLevel" value="pointLevel"/>
                                                     <s:param name="monitor" value="monitor"/>
                                                     <s:param name="whichTree" value="whichTree"/>
                                                     <s:param name="whichGrid" value="whichGrid"/>
                                                     <s:param name="currentTree" value="currentTree"/>
                                                     <s:param name="currentResourceTree" value="currentResourceTree"/>
                                                     <s:param name="currentUserId" value="currentUserId" />
                                                     <s:param name="currentDomainId" value="currentDomainId" />
                                                     <s:param name="search" value="search" />
                                                     <s:param name="searchWhat" value="searchWhat" />
                                            </s:action>
                               </s:if>
                         </div>
                         </page:param> 
                  </page:applyDecorator>
<script type="text/javascript">
Monitor.Resource.left.pointId = '<s:property value="pointId"/>';
Monitor.Resource.left.pointLevel = '<s:property value="pointLevel"/>';
Monitor.Resource.left.monitor = '<s:property value="monitor"/>';
Monitor.Resource.left.whichTree = '<s:property value="whichTree"/>';
Monitor.Resource.left.whichGrid = '<s:property value="whichGrid"/>';
Monitor.Resource.left.currentTree = '<s:property value="currentTree"/>';
Monitor.Resource.left.currentResourceTree = '<s:property value="currentResourceTree"/>';
Monitor.Resource.left.currentUserId = '<s:property value="currentUserId"/>';
Monitor.Resource.left.currentDomainId = '<s:property value="currentDomainId"/>';
</script>