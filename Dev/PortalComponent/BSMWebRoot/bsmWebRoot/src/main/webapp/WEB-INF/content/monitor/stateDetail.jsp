<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <%@ include file="/WEB-INF/common/meta.jsp" %>
	<title>状态详细信息</title>
	<link rel="stylesheet" type="text/css" href="${ctxCss}/validationEngine.jquery.css" />
	<link rel="stylesheet" type="text/css" href="${ctxCss}/public.css" />
	<link rel="stylesheet" type="text/css" href="${ctxCss}/UIComponent.css" />
	<style type="text/css">.span_dot{width:120px;overflow: hidden; text-overflow:ellipsis;display: inline-block;white-space:nowrap;}
	.span_dot_long{width:150px;overflow: hidden; text-overflow:ellipsis;display: inline-block;white-space:nowrap;}
</style>
    <script type="text/javascript">var path = "${ctx}";</script> 
    <script type="text/javascript" src="${ctxJs}/jquery-1.4.2.min.js"></script>
	<script type="text/javascript" src="${ctxJs}/component/plugins/jquery.ui.core.js"></script>
	<script type="text/javascript" src="${ctxJs}/component/plugins/jquery.ui.widget.js"></script>
	<script type="text/javascript" src="${ctxJs}/component/plugins/jquery.ui.mouse.js"></script>
	<script type="text/javascript" src="${ctxJs}/component/plugins/jquery.ui.draggable.js"></script>
	<script type="text/javascript" src="${ctxJs}/component/cfncc.js"></script>
	<script type="text/javascript" src="${ctxJs}/component/accordionPanel/accordionLeft.js"></script>
    <script type="text/javascript" src="${ctxJs}/component/accordionPanel/accordionPanel.js"></script>
    <script type="text/javascript" src="${ctxJs}/component/accordionPanel/accordionAddSubPanel.js"></script>
	<script type="text/javascript" src="${ctxJs}/component/tabPanel/tab.js"></script>
	<script type="text/javascript" src="${ctxJs}/component/panel/panel.js"></script>
	<script type="text/javascript" src="${ctxJs}/component/gridPanel/grid.js"></script>
	<script type="text/javascript" src="${ctxJs}/component/gridPanel/indexgrid.js"></script>
	<script type="text/javascript" src="${ctxJs}/component/gridPanel/page.js"></script>
	<script type="text/javascript" src="${ctxJs}/component/menu/menu.js"></script> 
	<script type="text/javascript" src="${ctxJs}/monitor/maintainsetting.js"></script>
	<script type="text/javascript" src="${ctxJs}/monitor/componentlist.js"></script>
	<script type="text/javascript" src="${ctx}/js/component/comm/winopen.js"></script>
	<script type="text/javascript" src="${ctx}/js/component/combobox/simplebox.js"></script>
</head>
<body>
<page:applyDecorator name="popwindow"  title="状态详细信息">
  <page:param name="width">640px</page:param>
  <page:param name="topBtn_index_1">1</page:param>
  <page:param name="topBtn_id_1">close_button</page:param>
  <page:param name="topBtn_title_1">关闭</page:param>
  <page:param name="topBtn_css_1">win-ico win-close</page:param>
  <page:param name="content">
  <!-- content start -->
  <div style="padding:30px 10px 10px 10px;">
              <div class="margin3">
                   <ul>
                      <li style="width:30%" class="left ellipsis lineheight21">
                          <span class="suojin bold">显示名称：</span><span class="span_dot" title="<s:property value="instanceName "/>"><s:property value="instanceName "/></span>
                      </li>
                      <li style="width:35%" class="left ellipsis lineheight21">
                          <span class="suojin1em bold">IP地址：</span> 
                          <s:if test="ipMap != null && ipMap.size() == 1">
                              <s:iterator value="ipMap" var="map" status="stat">
                                    <span><s:property value="#map.value" /></span>
                                </s:iterator>
                          </s:if>
                          <s:else>
                          <select iconIndex="0" iconTitle="管理IP" iconClass="ico ico-right for-inline f-absolute" id="ipAddress" name="ipAddress" class="">
                                 <s:iterator value="ipMap" var="map" status="stat">
                                     <option value="<s:property value=" #map.key " />">
                                         <s:property value="#map.value" />
                                     </option>
                                </s:iterator>
                          </select>
                          </s:else>
                      </li>
                      <li style="width:35%" class="left box ellipsis">
                          <span class="suojin1em bold lineheight21">资源类型：</span><span class="span_dot" title="<s:property value="instanceType "/>"><s:property value="instanceType "/></span>
                      </li>
                  </ul>
            </div>
            <div class="margin3">
                 <span class="suojin bold">当前状态：</span><span class="<s:property value='currentState'/>" style="cursor:default"></span><span>说明：（<s:property value='stateExplain'/>）</span>
            </div>
	        <page:applyDecorator name="tabPanel">  
		          <page:param name="id">metricOrComp</page:param>
		          <page:param name="height">400</page:param>
		          <page:param name="cls">tab-grounp</page:param>
		          <page:param name="background">#FFF</page:param>
		          <page:param name="current">1</page:param> 
		          <page:param name="tabHander">[{text:"问题指标",id:"metric"},{text:"问题组件",id:"comp"}]</page:param>
		           <page:param name="content_1">
		              <div style="width:590px">
			            <s:action name="resourceStateDetail!problemMetric"  namespace="/monitor"  executeResult="true" ignoreContextParams="false" flush="false"> 
			                        <s:param name="instanceId" value="instanceId" />
			            </s:action>
	                  </div> 
		          </page:param>
		          <page:param name="content_2">
		               <div class="f-relative" style="width:590px;height:370px;overflow-y:auto;overflow-x:hidden">
                            <s:action name="resourceStateDetail!problemComp"  namespace="/monitor"  executeResult="true" ignoreContextParams="false" flush="false"> 
			                        <s:param name="instanceId" value="instanceId" />
			                </s:action> 
		               </div>
		          </page:param>
	      </page:applyDecorator>
  </div>
  <!-- content end -->
  </page:param>
</page:applyDecorator>
<script type="text/javascript">
var tabConfig = new TabPanel({
    id:"metricOrComp",
    listeners:{
      change:function(tab){
      // alert(tab.index);
      }
   }
});
</script>
</body>
</html>