<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/meta.jsp"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<div class="tongji-content">
  <div class="left-content">
    <div class="panel-gray" style="background-color:#fff;">
      	<page:applyDecorator name="accordionInerPanel"> 
			<page:param name="id">appctionTab</page:param>
			<page:param name="width">100%</page:param>
			<page:param name="height">485px</page:param>				
			<page:param name="currentIndex">0</page:param>
								
			<page:param name="panelIndex_0">0</page:param>
			<page:param name="panelIndex_1">1</page:param>
			<page:param name="panelIndex_2">2</page:param>
			<page:param name="panelIndex_3">3</page:param>
			<page:param name="panelIndex_4">4</page:param>
			<page:param name="panelIndex_5">5</page:param>
			<page:param name="panelIndex_6">6</page:param>
			<page:param name="panelIndex_7">7</page:param>
			<page:param name="panelIndex_8">8</page:param>
			<page:param name="panelTitle_0">Database</page:param>
			<page:param name="panelTitle_1">Directory Server</page:param>
			<page:param name="panelTitle_2">J2EE AppServer</page:param>	
			<page:param name="panelTitle_3">Lotus Domino</page:param>
			<page:param name="panelTitle_4">Mail Server</page:param>
			<page:param name="panelTitle_5">中间件</page:param>
			<page:param name="panelTitle_6">Web Server</page:param>
			<page:param name="panelTitle_7">Avaya</page:param>		
			<page:param name="panelTitle_8">业务系统</page:param>										
			<page:param name="panelContent_0">					
					<div style="height:385px">
			       <div class="h1"><select id="realDatAppSelect"><option value="name">名称</option><option value="ip">IP</option></select><input id="realDatAppInput" name="" type="text" value="" onclick="cleanInput(this)" /><span id="realDatApp" class="ico ico-select" title="搜索" onclick="selectNode(this)"></span>
			       <input type="hidden" id="realDatAppRoot" value="Database"/>
			       </div>
				   <div class="tongji-contnet-tips"><span class="ico ico-note-blue"></span>最多选择<span class="red">6</span>个资源</div>
			        <div class="tree" id="realDatAppTreeDiv" style="height:375px">
			        <s:action name="realTreeAction" namespace="/report/tree"  executeResult="true" flush="false">
			       	 <s:param name="rootNodeId" >Database</s:param>
			       	 <s:param name="treeId" >realDatAppTree</s:param>			       	
			       	 <s:param name="userId" >userId</s:param>			  
			       	</s:action>			       	
			        </div></div>					  						  					  						  
			</page:param>
			<page:param name="panelContent_1">
			       <div style="height:385px">
			       <div class="h1"><select id="realDirAppSelect"><option value="name">名称</option><option value="ip">IP</option></select><input id="realDirAppInput" name="" type="text" value="" onclick="cleanInput(this)" /><span id="realDirApp" class="ico ico-select" title="搜索" onclick="selectNode(this)"></span>
			       <input type="hidden" id="realDirAppRoot" value="DirectoryServer"/>
			       </div>
				   <div class="tongji-contnet-tips"><span class="ico ico-note-blue"></span>最多选择<span class="red">6</span>个资源</div>
			       <div class="tree" id="realDirAppTreeDiv" style="height:375px"></div></div>					  						  					  						  
			</page:param>
			<page:param name="panelContent_2">
					<div style="height:385px">
			       <div class="h1"><select id="realJ2eAppSelect"><option value="name">名称</option><option value="ip">IP</option></select><input id="realJ2eAppInput" name="" type="text" value="" onclick="cleanInput(this)" /><span id="realJ2eApp" class="ico ico-select" title="搜索" onclick="selectNode(this)"></span>
			       <input type="hidden" id="realJ2eAppRoot" value="J2EEAppServer"/>
			       </div>
				   <div class="tongji-contnet-tips"><span class="ico ico-note-blue"></span>最多选择<span class="red">6</span>个资源</div>
			       <div class="tree" id="realJ2eAppTreeDiv" style="height:375px"></div></div>					  						  					  						  
			</page:param>
			<page:param name="panelContent_3">
					<div style="height:385px">
			       <div class="h1"><select id="realLotAppSelect"><option value="name">名称</option><option value="ip">IP</option></select><input id="realLotAppInput" name="" type="text" value="" onclick="cleanInput(this)" /><span id="realLotApp" class="ico ico-select" title="搜索" onclick="selectNode(this)"></span>
			       <input type="hidden" id="realLotAppRoot" value="LotusDomino"/>
			       </div>
				   <div class="tongji-contnet-tips"><span class="ico ico-note-blue"></span>最多选择<span class="red">6</span>个资源</div>
			       <div class="tree" id="realLotAppTreeDiv" style="height:375px"></div></div>					  						  					  						  
			</page:param>
			<page:param name="panelContent_4">
					<div style="height:385px">
			       <div class="h1"><select id="realMaiAppSelect"><option value="name">名称</option><option value="ip">IP</option></select><input id="realMaiAppInput" name="" type="text" value="" onclick="cleanInput(this)" /><span id="realMaiApp" class="ico ico-select" title="搜索" onclick="selectNode(this)"></span>
			       <input type="hidden" id="realMaiAppRoot" value="mailserver"/>
			       </div>
				   <div class="tongji-contnet-tips"><span class="ico ico-note-blue"></span>最多选择<span class="red">6</span>个资源</div>
			       <div class="tree" id="realMaiAppTreeDiv" style="height:375px"></div></div>					  						  					  						  
			</page:param>
			<page:param name="panelContent_5">
					<div style="height:385px">
			       <div class="h1"><select id="realMidAppSelect"><option value="name">名称</option><option value="ip">IP</option></select><input id="realMidAppInput" name="" type="text" value="" onclick="cleanInput(this)" /><span id="realMidApp" class="ico ico-select" title="搜索" onclick="selectNode(this)"></span>
			       <input type="hidden" id="realMidAppRoot" value="mailserver"/>
			       </div>
				   <div class="tongji-contnet-tips"><span class="ico ico-note-blue"></span>最多选择<span class="red">6</span>个资源</div>
			       <div class="tree" id="realMidAppTreeDiv" style="height:375px"></div></div>					  						  					  						  
			</page:param>
			<page:param name="panelContent_6">
					<div style="height:385px">
			       <div class="h1"><select id="realWebAppSelect"><option value="name">名称</option><option value="ip">IP</option></select><input id="realWebAppInput" name="" type="text" value="" onclick="cleanInput(this)" /><span id="realWebApp" class="ico ico-select" title="搜索" onclick="selectNode(this)"></span>
			        <input type="hidden" id="realWebAppRoot" value="WebServer"/>
			       </div>
				   <div class="tongji-contnet-tips"><span class="ico ico-note-blue"></span>最多选择<span class="red">6</span>个资源</div>
			       <div class="tree" id="realWebAppTreeDiv" style="height:375px"></div></div>					  						  					  						  
			</page:param>
			<page:param name="panelContent_7">
					<div style="height:385px">
			       <div class="h1"><select id="realAvaAppSelect"><option value="name">名称</option><option value="ip">IP</option></select><input id="realAvaAppInput" name="" type="text" value="" onclick="cleanInput(this)" /><span id="realAvaApp" class="ico ico-select" title="搜索" onclick="selectNode(this)"></span>
			       <input type="hidden" id="realAvaAppRoot" value="Avaya"/>
			       </div>
				   <div class="tongji-contnet-tips"><span class="ico ico-note-blue"></span>最多选择<span class="red">6</span>个资源</div>
			       <div class="tree" id="realAvaAppTreeDiv" style="height:375px"></div></div>					  						  					  						  
			</page:param>			
			<page:param name="panelContent_8">
					<div style="height:385px">
			       <div class="h1"><select id="realRtmAppSelect"><option value="name">名称</option><option value="ip">IP</option></select><input id="realRtmAppInput" name="" type="text" value="" onclick="cleanInput(this)" /><span  id="realRtmApp" class="ico ico-select" title="搜索" onclick="selectNode(this)"></span>
			       <input type="hidden" id="realRtmAppRoot" value="RTMWebSite"/>
			       </div>
				   <div class="tongji-contnet-tips"><span class="ico ico-note-blue"></span>最多选择<span class="red">6</span>个资源</div>
			       <div class="tree" id="realRtmAppTreeDiv" style="height:375px"></div></div>					  						  					  						  
			</page:param>
		</page:applyDecorator> 	         
    </div>
 </div>
  <div class="right-content" id="realAppDataNull" style="display:block"><span class="nodata-l" style="margin:265PX 0px" ><span class="nodata-r"><span class="nodata-m"><span class="icon">请在左侧选择资源</span></span></span></span></div>
  <div class="right-content" id="realAppRigTop" style="display:none">
    <div class="info" >
    <span class="left">选择指标：   			
		<input  id="realAppAvgCPUUtilApp" type="radio" name="realAppMetricType" value="AppAvgCPUUtil" onclick="saveMetricType('App',this)" checked="checked"/><span id="realAppAvgCPUUtilAppText">应用CPU平均利用率</span><input id="realAppAvgCPUUtilAppUnit" type="hidden" value="0"/> 		
		<input  id="realAppAvgMEMUtilApp" type="radio"  name="realAppMetricType" value="AppAvgMEMUtil" onclick="saveMetricType('App',this)"/><span id="realAppAvgMEMUtilAppText">应用内存利用率</span><input id="realAppAvgMEMUtilAppUnit" type="hidden" value="0"/> 													 	
	</span>															
		<span class="right">刷新间隔：<select id="realAppRefresh" ><option value="5000" selected="selected">5秒</option><option value="10000" >10秒</option><option value="30000" >30秒</option><option value="60000" >60秒</option></select></span>			 	        
	<div class="clear"></div>
	</div>
	<div class="title" id="realAppFlashTitle"></div>	
	<div class="graphics">
	  <div class="graphics-top">
	    <div class="graphics-top-r">
		  <div class="graphics-top-m"></div>
		</div>
	  </div>	 
	  <div class="graphics-mid">
	    <div class="flash" id="realAppFlash" ></div>
		<div class="grid" id="realAppFigure" >
		<div class="clear"></div>
		  <ul id="realAppUl">		
		  	<li id="realAppCutline_0" style="display:none">
			  <div id="realAppCutlineL_0" class="li-l">
			    <a id="realAppCutlineA_0" class=""></a>	
			    <div id="realAppCutlineR_0" class="li-r">
				  <div id="realAppCutlineM_0" class="li-m">	
				  <div id="realAppCutlineC_0" class="">	 			   
				   <span id="realAppCutlineColor_0" class="line blueline"></span>
				   <span id="realAppCutlineText_0" class="txt"></span>
				   </div>
				  </div>
				</div>
			  </div>
			</li>
			<li id="realAppCutline_1" style="display:none">
			  <div id="realAppCutlineL_1" class="li-l">
			   <a id="realAppCutlineA_1" class=""></a>	
			    <div id="realAppCutlineR_1" class="li-r">
				  <div id="realAppCutlineM_1" class="li-m">	
				 	<div id="realAppCutlineC_1" class="">				   
				   <span id="realAppCutlineColor_1" class="line blueline"></span>
				   <span id="realAppCutlineText_1" class="txt"></span>
				   </div>
				  </div>
				</div>
			  </div>
			</li>
			<li id="realAppCutline_2" style="display:none">
			  <div id="realAppCutlineL_2" class="li-l">
			  <a id="realAppCutlineA_2" class=""></a>	
			    <div id="realAppCutlineR_2" class="li-r">
				  <div id="realAppCutlineM_2" class="li-m">	
				   	<div id="realAppCutlineC_2" class="">				   
				   <span id="realAppCutlineColor_2" class="line blueline"></span>
				   <span id="realAppCutlineText_2" class="txt"></span>
				   </div>
				  </div>
				</div>
			  </div>
			</li>
			<li id="realAppCutline_3" style="display:none">
			  <div id="realAppCutlineL_3" class="li-l">
			  <a id="realAppCutlineA_3" class=""></a>	
			    <div id="realAppCutlineR_3" class="li-r">
				  <div id="realAppCutlineM_3" class="li-m">					  
				  <div id="realAppCutlineC_3" class="">					   
				   <span id="realAppCutlineColor_3" class="line blueline"></span>
				   <span id="realAppCutlineText_3" class="txt"></span>
				   </div>
				  </div>
				</div>
			  </div>
			</li>
			<li id="realAppCutline_4" style="display:none">
			  <div id="realAppCutlineL_4" class="li-l">
			  <a id="realAppCutlineA_4" class=""></a>		
			    <div id="realAppCutlineR_4" class="li-r">
				  <div id="realAppCutlineM_4" class="li-m">	
				  	<div id="realAppCutlineC_4" class="">		   
				   <span id="realAppCutlineColor_4" class="line blueline"></span>
				   <span id="realAppCutlineText_4" class="txt"></span>
				   </div>
				  </div>
				</div>
			  </div>
			</li>
			<li id="realAppCutline_5" style="display:none">
			  <div id="realAppCutlineL_5" class="li-l">
			   <a id="realAppCutlineA_5" class=""></a>	
			    <div id="realAppCutlineR_5" class="li-r">
				  <div id="realAppCutlineM_5" class="li-m">	
				 	<div id="realAppCutlineC_5" class="">				  
				   <span id="realAppCutlineColor_5" class="line blueline"></span>
				   <span id="realAppCutlineText_5" class="txt"></span>
				   </div>
				  </div>
				</div>
			  </div>
			</li>		  				    	
		  </ul>
		</div>
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
<s:form id="realAppFrom">
	<input type="hidden" id="realAppSelectNode" name="selectNodes" value=",,,,,"/>
	<input type="hidden" id="realAppMetricType" name="metricType" value="AppAvgCPUUtil"/>
</s:form>
<s:form id="realDatAppFrom">
	<input type="hidden" id="realDatAppSelectNode" name="selectNodes" value=",,,,,"/>
	<input type="hidden" id="realDatAppMetricType" name="metricType" value="AppAvgCPUUtil"/>
	<input type="hidden" id="realDatAppRefreshTime" name="refreshTime" value="5000"/>	
	<input type="hidden" id="realDatAppCutlineNull" name="cutlineNull" value=""/>
	<input type="hidden" id="realDatAppCutlineName" name="CutlineName" value=",,,,,"/>
</s:form>
<s:form id="realDirAppFrom">
	<input type="hidden" id="realDirAppSelectNode" name="selectNodes" value=",,,,,"/>
	<input type="hidden" id="realDirAppMetricType" name="metricType" value="AppAvgCPUUtil"/>
	<input type="hidden" id="realDirAppRefreshTime" name="refreshTime" value="5000" />
	<input type="hidden" id="realDirAppCutlineNull" name="cutlineNull" value=""/>
	<input type="hidden" id="realDirAppCutlineName" name="CutlineName" value=",,,,,"/>
</s:form>
<s:form id="realJ2eAppFrom">
	<input type="hidden" id="realJ2eAppSelectNode" name="selectNodes" value=",,,,,"/>
	<input type="hidden" id="realJ2eAppMetricType" name="metricType" value="AppAvgCPUUtil"/>
	<input type="hidden" id="realJ2eAppRefreshTime" name="refreshTime" value="5000"/>
	<input type="hidden" id="realJ2eAppCutlineNull" name="cutlineNull" value=""/>
	<input type="hidden" id="realJ2eAppCutlineName" name="CutlineName" value=",,,,,"/>
</s:form>
<s:form id="realLotAppFrom">
	<input type="hidden" id="realLotAppSelectNode" name="selectNodes" value=",,,,,"/>
	<input type="hidden" id="realLotAppMetricType" name="metricType" value="AppAvgCPUUtil"/>
	<input type="hidden" id="realLotAppRefreshTime" name="refreshTime" value="5000"/>
	<input type="hidden" id="realLotAppCutlineNull" name="cutlineNull" value=""/>
	<input type="hidden" id="realLotAppCutlineName" name="CutlineName" value=",,,,,"/>
</s:form>
<s:form id="realMaiAppFrom">
	<input type="hidden" id="realMaiAppSelectNode" name="selectNodes" value=",,,,,"/>
	<input type="hidden" id="realMaiAppMetricType" name="metricType" value="AppAvgCPUUtil"/>
	<input type="hidden" id="realMaiAppRefreshTime" name="refreshTime" value="5000"/>
	<input type="hidden" id="realMaiAppCutlineNull" name="cutlineNull" value=""/>
	<input type="hidden" id="realMaiAppCutlineName" name="CutlineName" value=",,,,,"/>
</s:form>
<s:form id="realMidAppFrom">
	<input type="hidden" id="realMidAppSelectNode" name="selectNodes" value=",,,,,"/>
	<input type="hidden" id="realMidAppMetricType" name="metricType" value="AppAvgCPUUtil"/>
	<input type="hidden" id="realMidAppRefreshTime" name="refreshTime" value="5000"/>
	<input type="hidden" id="realMidAppCutlineNull" name="cutlineNull" value=""/>
	<input type="hidden" id="realMidAppCutlineName" name="CutlineName" value=",,,,,"/>
</s:form>
<s:form id="realWebAppFrom">
	<input type="hidden" id="realWebAppSelectNode" name="selectNodes" value=",,,,,"/>
	<input type="hidden" id="realWebAppMetricType" name="metricType" value="AppAvgCPUUtil"/>
	<input type="hidden" id="realWebAppRefreshTime" name="refreshTime" value="5000"/>
	<input type="hidden" id="realWebAppCutlineNull" name="cutlineNull" value=""/>
	<input type="hidden" id="realWebAppCutlineName" name="CutlineName" value=",,,,,"/>
</s:form>
<s:form id="realAvaAppFrom">
	<input type="hidden" id="realAvaAppSelectNode" name="selectNodes" value=",,,,,"/>
	<input type="hidden" id="realAvaAppMetricType" name="metricType" value="AppAvgCPUUtil"/>
	<input type="hidden" id="realAvaAppRefreshTime" name="refreshTime" value="5000"/>
	<input type="hidden" id="realAvaAppCutlineNull" name="cutlineNull" value=""/>
	<input type="hidden" id="realAvaAppCutlineName" name="CutlineName" value=",,,,,"/>
</s:form>
<s:form id="realRtmAppFrom">
	<input type="hidden" id="realRtmAppSelectNode" name="selectNodes" value=",,,,,"/>
	<input type="hidden" id="realRtmAppMetricType" name="metricType" value="AppAvgCPUUtil"/>
	<input type="hidden" id="realRtmAppRefreshTime" name="refreshTime" value="5000"/>
	<input type="hidden" id="realRtmAppCutlineNull" name="cutlineNull" value=""/>
	<input type="hidden" id="realRtmAppCutlineName" name="CutlineName" value=",,,,,"/>
</s:form>
<script type="text/javascript">

var AppChartObj = new AnyChart('${ctxFlash}/AnyChart.swf'); 
AppChartObj.width = 640; 
AppChartObj.height = 300; 
AppChartObj.waitingForDataText="正在加载数据...";
AppChartObj.wMode='transparent';
AppChartObj.write("realAppFlash");
var appCategory="App";
var appPanel = null;
$(document).ready(function(){
	//标志是否再次加载页面,true表示加载,flase标识不再加载
	var appFlag=new Array(false,true,true,true,true,true,true,true,true);
	//子叶签的资源ID
	var appNodeID=new Array("Database","DirectoryServer","J2EEAppServer","LotusDomino","mailserver","Middleware","WebServer","Avaya","RTMWebSite");
	//子叶签的标识
	var appSubCategory=new Array("DatApp","DirApp","J2eApp","LotApp","MaiApp","MidApp","WebApp","AvaApp","RtmApp");
	new AccordionMenu({id:"appctionTab",listeners:{
		expend:function(index){			    
			    categorySignObj.getCategoryObj().setSubCategory(appSubCategory[index]);
			    treeInfo.setRootNodeId(appNodeID[index]);//记录子叶签的资源分类
				treeInfo.setTreeId("real"+appSubCategory[index]+"Tree");//记录子叶签树的ID
			    if(appFlag[index]){
			    	//loadTree("rootNodeId="+appNodeID[index]+"&treeId=real"+appSubCategory[index]+"Tree","#real"+appSubCategory[index]+"TreeDiv");
			    	$.blockUI({message:$('#loading')});			
					var url="${ctx}/report/tree/realTreeAction.action";	
					var param="userId="+userId+"&rootNodeId="+appNodeID[index]+"&treeId=real"+appSubCategory[index]+"Tree"
			    	$("#real"+appSubCategory[index]+"TreeDiv").load(url,param,function(){$.unblockUI();});	
					appFlag[index]=false;
			    }			    
				flow(appCategory,appSubCategory[index],false);	
		  }
		  },currentIndex:1},{accordionMenu_DomStruFn:"inner_accordionMenu_DomStruFn",accordionMenu_DomCtrlFn:"inner_accordionMenu_DomCtrlFn"});
});
//保存刷新时间
$("#realAppRefresh").change(function()
{	
	openRefresh(appCategory);
});
//图例高亮显示
$("#realAppUl li").mouseover(function()
{        
        var index=this.id.split("_")[1];
        setCutlineLight(appCategory,index);
        var showHtml=showMouseoverInfo(appCategory,index);
        if(appPanel != null){
			appPanel.close("close");			
			appPanel = null;		
		}
		appPanel = new winPanel({
			html:showHtml, 
			width:300,
			x:$(this).offset().left,
			y:$(this).offset().top,
			isautoclose:true, 
			listeners:{
				closeAfter:function(){	
					appPanel=null;
				}
			},
			isDrag:false
			},{
			winpanel_DomStruFn:"blackLayer_winpanel_DomStruFn" 
			});
		appPanel.setX($(this).offset().left);
		appPanel.setY($(this).offset().top-appPanel.getHeight());
});	
//图例鼠标离开
$("#realAppUl li").mouseout(function(){	
	var index=this.id.split("_")[1];
	var flag=$("#realAppCutlineR_"+index).val();	
	if(flag!="false")
	{
		setCutlineYuan(appCategory,index);
	}
	else
	{
		setCutlineNull(appCategory,index);
	}
	if(appPanel != null){
		appPanel.close("close");			
		appPanel = null;		
	}
});
//图例关闭 
$("#realAppUl li a").click(function()
{
	var closeFlag=false;
	var index=this.id.split("_")[1];
	var nodeText=$("#realAppCutlineText_"+index).html();
	var selectID=$("#realAppCutlineL_"+index).val();
	var subCategory=categorySignObj.getCategoryObj().subCategory;
	var treeID="real"+subCategory+"Tree";
	var treeObj=(new Function("return "+treeID ))();
	var nodeObj=treeObj.getNodeById(selectID);
	nodeObj.clearChecked();
	cleanNodeAndCutline(appCategory,subCategory,selectID);
	deleteCutlineInfo(appCategory,index);
	if(appPanel != null){
		appPanel.close("close");			
		appPanel = null;		
	}
	openRefresh(appCategory);
});
</script>