<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/meta.jsp"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<%@ include file="/WEB-INF/common/userinfo.jsp"%>
<%@ include file="/WEB-INF/common/loading.jsp" %> 
<meta name="decorator" content="headfoot" /> 
<page:applyDecorator name="headfoot">
<page:param name="body">
<link href="${ctxCss}/public.css" rel="stylesheet" type="text/css" />
<link href="${ctxCss}/tongjifenxi.css" rel="stylesheet" type="text/css" />
<link href="${ctxCss}/master.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/button-module.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/jquery-ui/treeview.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/UIComponent.css" rel="stylesheet" type="text/css"> 
<link href="${ctxCss}/validationEngine.jquery.css" type="text/css"  rel="stylesheet" media="screen" title="no title" charset="utf-8" />
<script src="${ctxJs}/component/cfncc.js"></script>
<script src="${ctxJs}/component/tabPanel/tab.js"></script>
<script src="${ctxJs}/report/realFlash.js"></script>
<script src="${ctxJs}/report/realUtil.js"></script>
<script src="${ctxJs}/component/treeView/tree.js"></script>
<script src="${ctxJs}/component/menu/menu.js"></script> 
<script src="${ctxJs}/component/panel/panel.js"></script>
<script src="${ctxJs}/AnyChart.js"></script>
<script src="${ctxJs}/component/accordionPanel/accordionLeft.js"></script>
<script src="${ctxJs}/jquery.blockUI.js" type="text/javascript"></script>
<script src="${ctxJs}/component/popwindow/popwin.js"></script>
<script type="text/javascript">
$(document).ready(function(){	
	var realFlag=[false,true,true],realCategory=["Dev","Int","App"],realSubCategory=["SerDev","SerInt","DatApp"],realFunction=["loadNetworkDevice","loadNetworkInterface","loadApplication"],realLoadPage=["deviceDiv","interfaceDiv","applicationDiv"];	 
	var tp = new TabPanel({id:"realTable",
		listeners:{
	        change:function(tab){
	        	categorySignObj.setCategoryObj(realCategory[tab.index-1]);treeInfo.setTreeId("real"+realSubCategory[tab.index-1]+"Tree");//记录子叶签树的ID				
	        	if(realFlag[tab.index-1]){
	        		$.blockUI({message:$('#loading')});	$("#"+realLoadPage[tab.index-1]).load("${ctx}/report/real/realManage!"+realFunction[tab.index-1]+".action","",function(){$.unblockUI();});		              		
	        		realFlag[tab.index-1]=false;flow(realCategory[tab.index-1],realSubCategory[tab.index-1],true);
	        	}else{
	        		var subCategory=categorySignObj.getCategoryObj().subCategory;flow(realCategory[tab.index-1],subCategory,true);
	        	}}}});});
</script>
<div class="tab margin5">
<page:applyDecorator name="tabPanel">
	<page:param name="id">realTable</page:param>
	<page:param name="width"></page:param>
	<page:param name="tabBarWidth"></page:param>
	<page:param name="cls">tab-grounp</page:param>
	<page:param name="current">1</page:param> 
	<page:param name="tabHander">[{text:"设备",id:"device"},{text:"网络接口",id:"Interface"},{text:"应用",id:"application"}]</page:param>
	<page:param name="content_1"> 
			<div id="deviceDiv"  style="width:100%">
			  <s:action name="realManage!loadNetworkDevice" namespace="/report/real" executeResult="true" flush="false" ></s:action>
			</div>	
	</page:param>	
	<page:param name="content_2">
	    <div id="interfaceDiv"  style="width:100%"></div>			
	</page:param>
	<page:param name="content_3">	
		<div id="applicationDiv" style="width:100%"></div>			
	</page:param>
</page:applyDecorator></div></page:param></page:applyDecorator><input type="hidden" id="networdInterValue" value="<s:property value="@com.mocha.bsm.modeladapter.enums.ResourceType@NetworkInterface" />"/>
<script type="text/javascript">
var path='${ctx}',REALINTERVAL=5,popInfo = new information();
</script>