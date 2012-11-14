<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/meta.jsp"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<div class="tongji-content">
  <div class="left-content">
    <div class="panel-gray" style="background-color:#fff;"> 
      	<page:applyDecorator name="accordionInerPanel"> 
			<page:param name="id">interfaceTab</page:param>
			<page:param name="width">100%</page:param>
			<page:param name="height">560px</page:param>				
			<page:param name="currentIndex">0</page:param>
								
			<page:param name="panelIndex_0">0</page:param>
			<page:param name="panelIndex_1">1</page:param>
			<page:param name="panelIndex_2">2</page:param>
			<page:param name="panelTitle_0">服务器接口</page:param>
			<page:param name="panelTitle_1">网络设备接口</page:param>
			<page:param name="panelTitle_2">存储设备接口</page:param>	
			<page:param name="panelContent_0">
				   <div style="height:505px">
			       <div class="h1"><select id="realSerIntSelect" style="width:50px"><option value="name">名称</option><option value="netName">接口名称</option><option value="ip">IP</option><input id="realSerIntInput" name="" type="text" value="" onclick="cleanInput(this)"/><span id="realSerInt" class="ico ico-select" title="搜索" onclick="selectNode(this)"></span>
			       <input type="hidden" id="realSerIntRoot" value="server"/>
			       </div>
				   <div class="tongji-contnet-tips"><span class="ico ico-note-blue"></span>最多选择<span class="red">6</span>个接口</div>
			       <div class="tree" id="realSerIntTreeDiv" style="height:470px;">
			       <s:action name="realTreeAction" namespace="/report/tree"  executeResult="true" flush="false">
			       	 <s:param name="rootNodeId" >server</s:param>
			       	 <s:param name="treeId" >realSerIntTree</s:param>
			       	 <s:param name="childResourceType" ><s:property value="@com.mocha.bsm.modeladapter.enums.ResourceType@NetworkInterface" /></s:param>
			       	 <s:param name="userId" >userId</s:param>			  
			       	</s:action>
			       </div></div>				  						  					  						  
			</page:param>
			<page:param name="panelContent_1">
					<div style="height:505px">
			       <div class="h1"><select id="realNetIntSelect" style="width:50px"><option value="name">名称</option><option value="netName">接口名称</option><option value="ip">IP</option><input id="realNetIntInput" name="" type="text" value="" onclick="cleanInput(this)"/><span id="realNetInt" class="ico ico-select" title="搜索" onclick="selectNode(this)"></span>
			       <input type="hidden" id="realNetIntRoot" value="networkdevice"/>
			       </div>
				   <div class="tongji-contnet-tips"><span class="ico ico-note-blue"></span>最多选择<span class="red">6</span>个接口</div>
			       <div class="tree" id="realNetIntTreeDiv" style="height:470px;"></div></div>					  						  					  						  
			</page:param>
			<page:param name="panelContent_2">
					 <div style="height:505px">
			       <div class="h1"><select id="realStoIntSelect" style="width:50px"><option value="name">名称</option><option value="netName">接口名称</option><option value="ip">IP</option><input id="realStoIntInput" name="" type="text" value="" onclick="cleanInput(this)"/><span id="realStoInt" class="ico ico-select" title="搜索" onclick="selectNode(this)"></span>
			       <input type="hidden" id="realStoIntRoot" value="storage"/>
			       </div>
				   <div class="tongji-contnet-tips"><span class="ico ico-note-blue"></span>最多选择<span class="red">6</span>个接口</div>
			       <div class="tree" id="realStoIntTreeDiv" style="height:470px;"></div></div>					  						  					  						  
			</page:param>
		</page:applyDecorator> 	         
    </div>
 </div>
  <div class="right-content"  id="realIntDataNull" style="display:block"><span class="nodata-l" style="margin:265px 0px" ><span class="nodata-r"><span class="nodata-m"><span class="icon">请在左侧选择资源</span></span></span></span></div>
  <div class="right-content" id="realIntRigTop" style="display:none">
    <div class="info">
    <span class="left">选择指标：
    	<select id="realMetricInt" ><option value="0" selected="selected">流量</option><option value="1" >广播包</option><option value="2" >丢包</option><option value="3" >错包</option></select>		
		<input  id="realMetricTypeInt_0" type="radio" name="realIntMetricType" value="NICReceiveRate" onclick="saveMetricType('Int',this),saveMetricIndex(this)" checked="checked"/><span id="realMetricTypeIntText_0">入包量</span><input id="realMetricTypeIntUnit_0" type="hidden" value="3"/>  		
		<input  id="realMetricTypeInt_1" type="radio" name="realIntMetricType" value="NICSendRate" onclick="saveMetricType('Int',this),saveMetricIndex(this)"/><span id="realMetricTypeIntText_1">出包量</span><input id="realMetricTypeIntUnit_1" type="hidden" value="3"/>																
	</span>	
	<span class="left" style="display:none" id="realMetric_2">
		<input  id="realMetricTypeInt_2" type="radio" name="realIntMetricType" value="NICReceiveRate" onclick="saveMetricType('Int',this),saveMetricIndex(this)"/><span id="realMetricTypeIntText_2" >总包量</span><input id="realMetricTypeIntUnit_2" type="hidden" value="3"/>
	</span>														
		<span class="right">刷新间隔：<select id="realIntRefresh" ><option value="5000" selected="selected">5秒</option><option value="10000" >10秒</option><option value="30000" >30秒</option><option value="60000" >60秒</option></select></span>		 	        
	<div class="clear"></div>
	</div>	
	<div class="title" id="realIntFlashTitle"></div>
	<div class="graphics">
	  <div class="graphics-top">
	    <div class="graphics-top-r">
		  <div class="graphics-top-m"></div>
		</div>
	  </div>	 
	  <div class="graphics-mid">
	    <div class="flash" id="realIntFlash" ></div>
		<div class="grid" id="realIntFigure" >
		<div class="clear"></div>
		  <ul id="realIntUl">		
		  	<li id="realIntCutline_0" style="display:none">
			  <div id="realIntCutlineL_0" class="li-l">
			   <a id="realIntCutlineA_0" class=""></a>	
			    <div id="realIntCutlineR_0" class="li-r">
				  <div id="realIntCutlineM_0" class="li-m">	
				  <div id="realIntCutlineC_0" class="">				  			
				   <span id="realIntCutlineColor_0" class="line blueline"></span>
				   <span id="realIntCutlineText_0" class="txt"></span>
				   </div>	
				  </div>
				</div>
			  </div>
			</li>
			<li id="realIntCutline_1" style="display:none">
			  <div id="realIntCutlineL_1" class="li-l">
			  <a id="realIntCutlineA_1" class=""></a>
			    <div id="realIntCutlineR_1" class="li-r">
				  <div id="realIntCutlineM_1" class="li-m">	
				  <div id="realIntCutlineC_1" class="">						   					 
				   <span id="realIntCutlineColor_1" class="line blueline"></span>
				   <span id="realIntCutlineText_1" class="txt"></span>
				   </div>
				  </div>
				</div>
			  </div>
			</li>
			<li id="realIntCutline_2" style="display:none">
			  <div id="realIntCutlineL_2" class="li-l">
			  <a id="realIntCutlineA_2" class=""></a>	
			    <div id="realIntCutlineR_2" class="li-r">
				  <div id="realIntCutlineM_2" class="li-m">	
				  <div id="realIntCutlineC_2" class="">						   				  
				   <span id="realIntCutlineColor_2" class="line blueline"></span>
				   <span id="realIntCutlineText_2" class="txt"></span>
				   </div>
				  </div>
				</div>
			  </div>
			</li>
			<li id="realIntCutline_3" style="display:none">
			  <div id="realIntCutlineL_3" class="li-l">
			  <a id="realIntCutlineA_3" class=""></a>
			    <div id="realIntCutlineR_3" class="li-r">
				  <div id="realIntCutlineM_3" class="li-m">
				  <div id="realIntCutlineC_3" class="">							   				   
				   <span id="realIntCutlineColor_3" class="line blueline"></span>
				   <span id="realIntCutlineText_3" class="txt"></span>
				   </div>
				  </div>
				</div>
			  </div>
			</li>
			<li id="realIntCutline_4" style="display:none">
			  <div id="realIntCutlineL_4" class="li-l">
			  <a id="realIntCutlineA_4" class=""></a>
			    <div id="realIntCutlineR_4" class="li-r">
				  <div id="realIntCutlineM_4" class="li-m">
				  <div id="realIntCutlineC_4" class="">							   				 
				   <span id="realIntCutlineColor_4" class="line blueline"></span>
				   <span id="realIntCutlineText_4" class="txt"></span>
				   </div>
				  </div>
				</div>
			  </div>
			</li>
			<li id="realIntCutline_5" style="display:none">
			  <div id="realIntCutlineL_5" class="li-l">
			  <a id="realIntCutlineA_5" class=""></a>	
			    <div id="realIntCutlineR_5" class="li-r">
				  <div id="realIntCutlineM_5" class="li-m">	
				  <div id="realIntCutlineC_5" class="">						   			  
				   <span id="realIntCutlineColor_5" class="line blueline"></span>
				   <span id="realIntCutlineText_5" class="txt"></span>
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
<s:form id="realIntFrom">
	<input type="hidden" id="realIntSelectNode" name="selectNodes" value=",,,,,"/>
	<input type="hidden" id="realIntMetricType" name="metricType" value="NICReceiveRate"/>
</s:form>
<s:form id="realSerIntFrom">
	<input type="hidden" id="realSerIntSelectNode" name="selectNodes" value=",,,,,"/>
	<input type="hidden" id="realSerIntMetricType" name="metricType" value="NICReceiveRate"/>
	<input type="hidden" id="realSerIntRefreshTime" name="refreshTime" value="5000"/>
	<input type="hidden" id="realSerIntCutlineNull" name="cutlineNull" value=""/>
	<input type="hidden" id="realSerIntCutlineName" name="CutlineName" value=",,,,,"/>
</s:form>
<s:form id="realNetIntFrom">
	<input type="hidden" id="realNetIntSelectNode" name="selectNodes" value=",,,,,"/>
	<input type="hidden" id="realNetIntMetricType" name="metricType" value="NICReceiveRate"/>
	<input type="hidden" id="realNetIntRefreshTime" name="refreshTime" value="5000" />
	<input type="hidden" id="realNetIntCutlineNull" name="cutlineNull" value=""/>
	<input type="hidden" id="realNetIntCutlineName" name="CutlineName" value=",,,,,"/>
</s:form>
<s:form id="realStoIntFrom">
	<input type="hidden" id="realStoIntSelectNode" name="selectNodes" value=",,,,,"/>
	<input type="hidden" id="realStoIntMetricType" name="metricType" value="NICReceiveRate"/>
	<input type="hidden" id="realStoIntRefreshTime" name="refreshTime" value="5000"/>
	<input type="hidden" id="realStoIntCutlineNull" name="cutlineNull" value=""/>
	<input type="hidden" id="realStoIntCutlineName" name="CutlineName" value=",,,,,"/>
</s:form>
<script type="text/javascript">
var IntChartObj = new AnyChart('${ctxFlash}/AnyChart.swf'); 
IntChartObj.width = 640; 
IntChartObj.height = 300; 
IntChartObj.waitingForDataText="正在加载数据...";
IntChartObj.wMode='transparent';
IntChartObj.write("realIntFlash");
/**
 * metricTypeText0,1,2,3保存每个下拉框选择的指标显示的文字
 * metricTypeTextValue 保存具体选中那个指标文字数组的下标
 * metricTypeText保存下拉框所有指标文字的数组
 */
var metricTypeText0=new Array("入流量","出流量","");
var metricTypeText1=new Array("接收的广播包数","发送的广播包数","广播包率");
var metricTypeText2=new Array("接收的丢包数","发送的丢包数","丢包率");
var metricTypeText3=new Array("接收的错包数","发送的错包数","错包率");
var metricTypeText=new Array(metricTypeText0,metricTypeText1,metricTypeText2,metricTypeText3);
var metricTypeTextValue=new Array("0","0","0","0");
/**
 * metricType0,1,2,3保存每个下拉框选择的指标
 * metricTypeValue 保存具体选中的那个指标数组的下标
 * metricType 保存下拉框所有指标数组
 */
var metricType0=new Array("NICReceiveRate","NICSendRate","");
var metricType1=new Array("NICReceiveBroadcastRate","NICSendBroadcastRate","NICBroadcastRate");
var metricType2=new Array("NICReceiveDropRate","NICSendDropRate","NICDropRate");
var metricType3=new Array("NICReceiveErrorRate","NICSendErrorRate","NICErrorRate");
var metricType=new Array(metricType0,metricType1,metricType2,metricType3);
var metricTypeValue=new Array("0","0","0","0");
/**
 * 保存下拉框对应的每个指标所对应的单位数组下标
 */
var metricUnit=new Array("3","2","2","2");
//保存下拉表和指标值,默认第一个
var metricSerInt=new Array("0","0");
var metricNetInt=new Array("0","0");
var metricStoInt=new Array("0","0");
var intCategory="Int";
var intPanel = null;
$(document).ready(function(){
	//标志是否再次加载页面,true表示加载,flase标识不再加载
	var intFlag=new Array(false,true,true);
	//子叶签的资源ID:服务器设备"server";网络设备"networkdevice";存储设备"storage"
	var intNodeID=new Array("server","networkdevice","storage");
	//子叶签的标识服务器网络接口--"SerInt";网络接口--"NetInt";存储网络接口--"StoInt"
	var intSubCategory=new Array("SerInt","NetInt","StoInt");
	new AccordionMenu({id:"interfaceTab",listeners:{
		expend:function(index){		
			categorySignObj.getCategoryObj().setSubCategory(intSubCategory[index]);
			treeInfo.setRootNodeId(intNodeID[index]);//记录子叶签的资源分类
			treeInfo.setTreeId("real"+intSubCategory[index]+"Tree");//记录子叶签树的ID
			if(intFlag[index]){
		    	//loadTree("rootNodeId="+intNodeID[index]+"&treeId=real"+intSubCategory[index]+"Tree&childResourceType=<s:property value="@com.mocha.bsm.modeladapter.enums.ResourceType@NetworkInterface" /> ","#real"+intSubCategory[index]+"TreeDiv");
		    	$.blockUI({message:$('#loading')});			
				var url="${ctx}/report/tree/realTreeAction.action";	
				var param="userId="+userId+"&rootNodeId="+intNodeID[index]+"&treeId=real"+intSubCategory[index]+"Tree&childResourceType=<s:property value="@com.mocha.bsm.modeladapter.enums.ResourceType@NetworkInterface" /> ";
				$("#real"+intSubCategory[index]+"TreeDiv").load(url,param,function(){$.unblockUI();});	
		    	intFlag[index]=false;
		    }			
			flow(intCategory,intSubCategory[index],false);	
		}
		},currentIndex:1},{accordionMenu_DomStruFn:"inner_accordionMenu_DomStruFn",accordionMenu_DomCtrlFn:"inner_accordionMenu_DomCtrlFn"});
});
//保存刷新时间
$("#realIntRefresh").change(function()
{
	openRefresh(intCategory);
});
//指标下拉框事件
$("#realMetricInt").change(function (){
	var index=parseInt(this.value);
	var arrayText=metricTypeText[index];
	var arrayMetric=metricType[index];
	for(var i=0;i<arrayText.length;i++){
		$("#realMetricTypeIntText_"+i).html("");
		if(arrayText[i]!=""){
			$("#realMetricTypeIntText_"+i).html(arrayText[i]);//指标名称
			$("#realMetricTypeIntUnit_"+i).val(metricUnit[index]);//单位赋值
			$("#realMetricTypeInt_"+i).val(arrayMetric[i]);//指标
			if(i==2){
				$("#realMetric_2").css("display","block");//显示第三个指标				
			}			
		}else{
			$("#realMetric_2").css("display","none");//隐藏第三个指标	
		}				
	}
	$("#realMetricTypeInt_"+metricTypeTextValue[index]).attr("checked",true);
	var metricTypeIndex=metricTypeValue[index];
	var subCategory=categorySignObj.getCategoryObj().subCategory;	
	$("#real"+subCategory+"MetricType").val(arrayMetric[metricTypeIndex]);	
	$("#realIntMetricType").val(arrayMetric[metricTypeIndex]);
	metricObj.cleanData();
	var selectNodes=getSelectNode(subCategory);
	$("#realIntSelectNode").val(selectNodes);
	$("#real"+subCategory+"CutlineNull").val("");
	isExitMetricValue(intCategory,getArrayValue(selectNodes,","));//判断是否存在指标	
	setTitleAndUnit(intCategory,subCategory);
	saveSelectIndex(subCategory,index);
	openRefresh(intCategory);
});
//图例高亮显示
$("#realIntUl li").mouseover(function()
{        
        var index=this.id.split("_")[1];
        setCutlineLight(intCategory,index);
        var showHtml=showMouseoverInfo(intCategory,index);
		if(intPanel != null){
			intPanel.close("close");			
			intPanel = null;		
		}
		intPanel = new winPanel({
			html:showHtml,
			width:300,
			x:$(this).offset().left,
			y:$(this).offset().top,
			isautoclose:false, 
			listeners:{
				closeAfter:function(){	
					intPanel=null;
				}
			},
			isDrag:false
			},{
			winpanel_DomStruFn:"blackLayer_winpanel_DomStruFn" 
			});
		intPanel.setX($(this).offset().left);
		intPanel.setY($(this).offset().top-intPanel.getHeight());
});	
//图例鼠标离开
$("#realIntUl li").mouseout(function(){
	var index=this.id.split("_")[1];
	var flag=$("#realIntCutlineR_"+index).val();	
	if(flag!="false")
	{
		setCutlineYuan(intCategory,index);
	}
	else
	{
		setCutlineNull(intCategory,index);
	}
	if(intPanel != null){
		intPanel.close("close");			
		intPanel = null;		
	}
});
//图例关闭
$("#realIntUl li a").click(function()
{
	var closeFlag=false;
	var index=this.id.split("_")[1];
	var nodeText=$("#realIntCutlineText_"+index).html();
	var selectID=$("#realIntCutlineL_"+index).val();
	var subCategory=categorySignObj.getCategoryObj().subCategory;
	var treeID="real"+subCategory+"Tree";
	var treeObj=(new Function("return "+treeID ))();
	var nodeObj=treeObj.getNodeById(selectID);
	nodeObj.clearChecked();
	cleanNodeAndCutline(intCategory,subCategory,selectID);
	deleteCutlineInfo(intCategory,index);
	if(intPanel != null){
		intPanel.close("close");			
		intPanel = null;		
	}
	openRefresh(intCategory);
});
//记录每一个子叶签的下拉表
function saveSelectIndex(subCategory,selectIndex)
{
	var metricArray=(new Function("return "+"metric"+subCategory ))();
	metricArray[0]=selectIndex;	
}
//记录每一个子叶签的指标下标
function  saveMetricIndex(obj)
{
	var MetricIntID=obj.id;
	var metircIndex=MetricIntID.substring(MetricIntID.length-1);
	var subCategory=categorySignObj.getCategoryObj().subCategory;	
	var metricArray=(new Function("return "+"metric"+subCategory ))();
	metricArray[1]=metircIndex;
}
//设置下拉表值和指标值
function setSelectAndMetric(subCategory)
{
	var metricArray=(new Function("return "+"metric"+subCategory ))();
	var selectIndex=metricArray[0];	
	$("#realMetricInt").val(selectIndex);
	var metircIndex=metricArray[1];		
	$("#realMetricTypeInt_"+metircIndex).attr("checked",true);
}
</script>