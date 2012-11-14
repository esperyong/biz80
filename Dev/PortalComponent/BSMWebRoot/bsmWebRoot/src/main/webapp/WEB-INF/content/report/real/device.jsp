<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/meta.jsp"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<div class="tongji-content" >
  <div class="left-content">
    <div class="panel-gray" style="background-color:#fff;">
      	<page:applyDecorator name="accordionInerPanel"> 
			<page:param name="id">deviceTab</page:param>
			<page:param name="width">100%</page:param>
			<page:param name="height">590px</page:param>				
			<page:param name="currentIndex">0</page:param>								
			<page:param name="panelIndex_0">0</page:param>
			<page:param name="panelIndex_1">1</page:param>
			<page:param name="panelIndex_2">2</page:param>
			<page:param name="panelTitle_0">服务器</page:param>
			<page:param name="panelTitle_1">网络设备</page:param>
			<page:param name="panelTitle_2">存储设备</page:param>	
			<page:param name="panelContent_0">
			       <div style="height:515px">
			       <div class="h1"><select id="realSerDevSelect" style="width:75px"><option value="name">资源名称</option><option value="ip">IP地址</option></select><input style="width:100px" id="realSerDevInput" name="" type="text" value="" onclick="cleanInput(this)" /><span id="realSerDev" class="ico ico-select" title="搜索" onclick="selectNode(this)"></span>
			       <input type="hidden" id="realSerDevRoot" value="server"/>
			       </div>
				   <div class="tongji-contnet-tips"><span class="ico ico-note-blue"></span>最多选择<span class="red">6</span>个资源</div>
			       <div class="tree" id="realSerDevTreeDiv" style="height:490px;">
			       	<s:action name="realTreeAction" namespace="/report/tree"  executeResult="true" flush="false">
			       	 <s:param name="rootNodeId" >server</s:param>
			       	 <s:param name="treeId" >realSerDevTree</s:param>
			       	 <s:param name="userId" >userId</s:param>
			       	</s:action>			       	
			       </div></div>					       		  						  					  						  
			</page:param>
			<page:param name="panelContent_1">
			       <div style="height:515px">
			       <div class="h1"><select id="realNetDevSelect" style="width:75px"><option value="name">资源名称</option><option value="ip">IP地址</option></select><input style="width:100px" id="realNetDevInput" name="" type="text" value="" onclick="cleanInput(this)"/><span  id="realNetDev" class="ico ico-select" title="搜索" onclick="selectNode(this)"></span>
			       <input type="hidden" id="realNetDevRoot" value="networkdevice"/>
			       </div>
				   <div class="tongji-contnet-tips"><span class="ico ico-note-blue"></span>最多选择<span class="red">6</span>个资源</div>
			       <div class="tree" id="realNetDevTreeDiv" style="height:490px;"></div></div>					       			  						  					  						  
			</page:param>
			<page:param name="panelContent_2">
			  	   <div style="height:515px">
			       <div class="h1"><select id="realStoDevSelect" style="width:75px"><option value="name">资源名称</option><option value="ip">IP地址</option></select><input style="width:100px" id="realStoDevInput" name="" type="text" value="" onclick="cleanInput(this)"/><span id="realStoDev"  class="ico ico-select" title="搜索" onclick="selectNode(this)"></span>
			       <input type="hidden" id="realStoDevRoot" value="storage"/>
			       </div>
				   <div class="tongji-contnet-tips"><span class="ico ico-note-blue"></span>最多选择<span class="red">6</span>个资源</div>
			       <div class="tree" id="realStoDevTreeDiv" style="height:490px;"></div></div>				  						  					  						  
			</page:param>
		</page:applyDecorator> 	         
    </div>
 </div>
  <div class="right-content" id="realDevDataNull" style="display:block;"><span class="nodata-l" style="margin:268px 0px" ><span class="nodata-r"><span class="nodata-m"><span class="icon">请在左侧选择资源</span></span></span></span></div>
  <div class="right-content" id="realDevRigTop" style="display:none;">
    <div class="info">
    <span class="left">选择指标：		
		<input  id="realDeviceAvgCPUUtilDev" type="radio" name="realDevMetricType" value="DeviceAvgCPUUtil" onclick="saveMetricType('Dev',this)" checked="checked"/><span id="realDeviceAvgCPUUtilDevText">CPU平均利用率</span><input id="realDeviceAvgCPUUtilDevUnit" type="hidden" value="0"/> 		
		<input  id="realDeviceAvgMEMUtilDev" type="radio"  name="realDevMetricType" value="DeviceAvgMEMUtil" onclick="saveMetricType('Dev',this)"/><span id="realDeviceAvgMEMUtilDevText">内存利用率</span><input id="realDeviceAvgMEMUtilDevUnit" type="hidden" value="0"/> 													
		<input  id="realDelayedPingDev" type="radio" name="realDevMetricType" value="DelayedPing" onclick="saveMetricType('Dev',this)"/><span id="realDelayedPingDevText">Ping时延 </span><input id="realDelayedPingDevUnit" type="hidden" value="1"/> 	
	</span>	
	<span class="left" style="display:block" id="realNetDevMetric">
		<input  id="realDeviceDropRateDev" type="radio"  name="realDevMetricType" value="DeviceDropRate"  onclick="saveMetricType('Dev',this)"/><span  id="realDeviceDropRateDevText">丢包率</span><input id="realDeviceDropRateDevUnit" type="hidden" value="2"/>
		<input  id="realDeviceBroadcastRateDev" type="radio" name="realDevMetricType" value="DeviceBroadcastRate"   onclick="saveMetricType('Dev',this)"/><span  id="realDeviceBroadcastRateDevText">广播包率</span><input id="realDeviceBroadcastRateDevUnit" type="hidden" value="2"/>
	</span>															
		<span class="right">刷新间隔：<select id="realDevRefresh" ><option value="5000" selected="selected">5秒</option><option value="10000" >10秒</option><option value="30000" >30秒</option><option value="60000" >60秒</option></select></span>		 	        
	<div class="clear"></div>
	</div>	
	<div class="title" id="realDevFlashTitle"></div>
	<div class="graphics">
	  <div class="graphics-top">
	    <div class="graphics-top-r">
		  <div class="graphics-top-m"></div>
		</div>
	  </div>	 
	  <div class="graphics-mid">
	    <div class="flash" id="realDevFlash" ></div>
		<div class="grid" id="realDevFigure" >
		<div class="clear"></div>
		  <ul id="realDevUl">		
		  	 <li id="realDevCutline_0" style="display:none">
			  <div id="realDevCutlineL_0" class="li-l">
			  <a id="realDevCutlineA_0" class=""></a>
			    <div id="realDevCutlineR_0" class="li-r">
				  <div id="realDevCutlineM_0" class="li-m"> 	
				   <div id="realDevCutlineC_0" class=""> 
				   <span id="realDevCutlineColor_0" class="line blueline"></span>
				   <span id="realDevCutlineText_0" class="txt"></span>
				   </div>
				  </div>
				</div>
			  </div>
			</li>
			<li id="realDevCutline_1" style="display:none">
			  <div id="realDevCutlineL_1" class="li-l">
			   <a id="realDevCutlineA_1" class=""></a>
			    <div id="realDevCutlineR_1" class="li-r">
				  <div id="realDevCutlineM_1" class="li-m">	
				  <div id="realDevCutlineC_1" class=""> 			  
				   <span id="realDevCutlineColor_1" class="line blueline"></span>
				   <span id="realDevCutlineText_1" class="txt"></span>
				   </div>
				  </div>
				</div>
			  </div>
			</li>
			<li id="realDevCutline_2" style="display:none">
			  <div id="realDevCutlineL_2" class="li-l">
			  <a id="realDevCutlineA_2" class=""></a>	
			    <div id="realDevCutlineR_2" class="li-r">
				  <div id="realDevCutlineM_2" class="li-m">	
				  	<div id="realDevCutlineC_2" class=""> 	
				   <span id="realDevCutlineColor_2" class="line blueline"></span>
				   <span id="realDevCutlineText_2" class="txt"></span>
				   </div>
				  </div>
				</div>
			  </div>
			</li>
			<li id="realDevCutline_3" style="display:none">
			  <div id="realDevCutlineL_3" class="li-l">
			  <a id="realDevCutlineA_3" class=""></a>	
			    <div id="realDevCutlineR_3" class="li-r">
				  <div id="realDevCutlineM_3" class="li-m">	
				  	<div id="realDevCutlineC_3" class=""> 	  
				   <span id="realDevCutlineColor_3" class="line blueline"></span>
				   <span id="realDevCutlineText_3" class="txt"></span>
				   </div>
				  </div>
				</div>
			  </div>
			</li>
			<li id="realDevCutline_4" style="display:none">
			  <div id="realDevCutlineL_4" class="li-l">
			  <a id="realDevCutlineA_4" class=""></a>
			    <div id="realDevCutlineR_4" class="li-r">
				  <div id="realDevCutlineM_4" class="li-m">	
				   <div id="realDevCutlineC_4" class=""> 						 
				   <span id="realDevCutlineColor_4" class="line blueline"></span>
				   <span id="realDevCutlineText_4" class="txt"></span>
				   </div>
				  </div>
				</div>
			  </div>
			</li>
			<li id="realDevCutline_5" style="display:none">
			  <div id="realDevCutlineL_5" class="li-l">
			  <a id="realDevCutlineA_5" class=""></a>	
			    <div id="realDevCutlineR_5" class="li-r">
				  <div id="realDevCutlineM_5" class="li-m">	
				  <div id="realDevCutlineC_5" class=""> 				   				 
				   <span id="realDevCutlineColor_5" class="line blueline"></span>
				   <span id="realDevCutlineText_5" class="txt"></span>
				   </div>
				  </div>
				</div>
			  </div>
			</li>				  				    	
		  </ul>
		</div>
        <div class="clear"></div>
	  </div> 
	  <div class="graphics-bottom">
	    <div class="graphics-bottom-r">
		  <div class="graphics-bottom-m">
		  </div>
		</div>
	  </div>
	</div>
  </div>
</div>
<s:form id="realDevFrom">    
	<input type="hidden" id="realDevSelectNode" name="selectNodes" value=""/>
	<input type="hidden" id="realDevMetricType" name="metricType" value="DeviceAvgCPUUtil"/>
</s:form>
<s:form id="realSerDevFrom">
	<input type="hidden" id="realSerDevSelectNode" name="selectNodes" value=""/>
	<input type="hidden" id="realSerDevMetricType" name="metricType" value="DeviceAvgCPUUtil"/>
	<input type="hidden" id="realSerDevRefreshTime" name="refreshTime" value="5000"/>
	<input type="hidden" id="realSerDevCutlineNull" name="cutlineNull" value=""/>
	<input type="hidden" id="realSerDevCutlineName" name="CutlineName" value=",,,,,"/>
</s:form>
<s:form id="realNetDevFrom">
	<input type="hidden" id="realNetDevSelectNode" name="selectNodes" value=""/>
	<input type="hidden" id="realNetDevMetricType" name="metricType" value="DeviceAvgCPUUtil"/>
	<input type="hidden" id="realNetDevRefreshTime" name="refreshTime" value="5000" />
	<input type="hidden" id="realNetDevCutlineNull" name="cutlineNull" value=""/>
	<input type="hidden" id="realNetDevCutlineName" name="CutlineName" value=",,,,,"/>
</s:form>
<s:form id="realStoDevFrom">
	<input type="hidden" id="realStoDevSelectNode" name="selectNodes" value=",,,,,"/>
	<input type="hidden" id="realStoDevMetricType" name="metricType" value="DeviceAvgCPUUtil"/>
	<input type="hidden" id="realStoDevRefreshTime" name="refreshTime" value="5000"/>
	<input type="hidden" id="realStoDevCutlineNull" name="cutlineNull" value=""/>
	<input type="hidden" id="realStoDevCutlineName" name="CutlineName" value=",,,,,"/>
</s:form>
<script type="text/javascript">
var DevChartObj = new AnyChart('${ctxFlash}/AnyChart.swf'); //Flash对象
DevChartObj.width = 640;DevChartObj.height = 300;DevChartObj.waitingForDataText="正在加载数据...";DevChartObj.wMode='transparent';DevChartObj.write("realDevFlash");
var devPanel = null,devCategory="Dev";//设备标识Dev	
$(document).ready(function(){//子叶签的资源ID:服务器设备"server";网络设备"networkdevice";存储设备"storage"		
	var DevFlag=[false,true,true],DevNodeID=["server","networkdevice","storage"],DevSubCategory=["SerDev","NetDev","StoDev"];//子叶签的标识服务器设备--"SerDev";网络设备--"NetDev";存储设备--"StoDev"
	new AccordionMenu({id:"deviceTab",listeners:{
		expend:function(index){
			categorySignObj.getCategoryObj().setSubCategory(DevSubCategory[index]);treeInfo.setRootNodeId(DevNodeID[index]);treeInfo.setTreeId("real"+DevSubCategory[index]+"Tree");//记录子叶签树的ID						
			if(DevFlag[index]){
				$.blockUI({message:$('#loading')});$("#real"+DevSubCategory[index]+"TreeDiv").load("${ctx}/report/tree/realTreeAction.action","userId="+userId+"&rootNodeId="+DevNodeID[index]+"&treeId=real"+DevSubCategory[index]+"Tree",function(){$.unblockUI();});	DevFlag[index]=false;}
			flow(devCategory,DevSubCategory[index],false);}},currentIndex:1},{accordionMenu_DomStruFn:"inner_accordionMenu_DomStruFn",accordionMenu_DomCtrlFn:"inner_accordionMenu_DomCtrlFn"});});
$("#realDevUl").find("li").mouseover(function(){devMouseover(this);});$("#realDevUl li").mouseout(function(){devMouserout(this)});$("#realDevUl li a").click(function(){devClose(this);});//图例关闭
$("#realDevRefresh").change(function(){openRefresh(devCategory);});	
</script>