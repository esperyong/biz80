<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<page:applyDecorator name="popwindow" title="添加报告内容">
	<page:param name="width">758px</page:param>	
	<page:param name="topBtn_index_1">1</page:param>
	<page:param name="topBtn_id_1">${tabID }</page:param>
	<page:param name="topBtn_css_1">win-ico win-close</page:param>
	<page:param name="topBtn_title_1">关闭</page:param>
	 
	<page:param name="bottomBtn_index_1">1</page:param>
	<page:param name="bottomBtn_id_1">${tabSubmit }</page:param>
	<page:param name="bottomBtn_text_1" >确定</page:param>

	<page:param name="bottomBtn_index_2">2</page:param>
	<page:param name="bottomBtn_id_2">${tabCancel }</page:param>
	<page:param name="bottomBtn_text_2" >取消</page:param>

	<page:param name="bottomBtn_index_3">3</page:param>
	<page:param name="bottomBtn_id_3">${tabApply }</page:param>
	<page:param name="bottomBtn_text_3" >应用</page:param>
	
	<page:param name="content">
	   <form id="addReportInfoForm_%{sign}" onSubmit="return false;">
		<ul class="fieldlist-n">
			<li><span>标题：</span> 
				<s:textfield type="text" size="50"  cssClass="validate[required[标题],length[0,50,标题],noSpecialStr[标题]]"  id="%{reportType }_infoName_%{sign }" value="请输入标题"/>								
			<span class="red">*</span></li>			
		</ul>
		</form>	
		<page:applyDecorator name="tabPanel">
			<page:param name="id">${tabOtherID }</page:param>
			<page:param name="width">744</page:param>
			<page:param name="tabBarWidth">744</page:param>
			<page:param name="cls">tab-grounp</page:param>
			<page:param name="current">1</page:param>
			<page:param name="tabHander">[{text:"选择资源",id:"resource"},{text:"选择指标",id:"metric"}]</page:param>
			<page:param name="content_1">	
				<div id="${reportType }_addReportInfo_${sign }">				
				</div>
			</page:param>	
			<page:param name="content_2">
				<div id="${reportType }_addReportMetric_${sign }">				
				</div>		
			</page:param>
		</page:applyDecorator>
	</page:param>
	</page:applyDecorator>
	<input type="hidden" id="isNew_${sign }" value="true">
	<input type="hidden" id="isComponent_${sign }" value="false">
	<input type="hidden" id="isReloadMetric_${sign }" value="true">
	<input type="hidden" id="isReloadRes_${sign }" value="true">
	<input type="hidden" id="isReloadCom_${sign }" value="false">
<script type="text/javascript">
$(document).ready(function(){
	$("#addReportInfoForm").validationEngine();	
	$.blockUI({message:$('#loading')});	    
	var url="${ctx}/report/statistic/statisticOper!loadResource.action";
	var param="userId="+userId+"&sign="+cacheObj.getRowID()+"&reportType="+cacheObj.getReportType();
	var id=$("#"+cacheObj.getReportType()+"_idValue_"+cacheObj.getRowID()).val();
	if(objValue.isNotEmpty(id)){
		$("#isNew_"+cacheObj.getRowID()).val("false");
		$("#${reportType }_infoName_"+cacheObj.getRowID()).val($("#"+cacheObj.getReportType()+"_reportInfoName_"+cacheObj.getRowID()).val());
		var resoureTypeValue=$("#"+cacheObj.getReportType()+"_resoureTypeValue_"+cacheObj.getRowID()).val();
		var resourceModel=$("#"+cacheObj.getReportType()+"_resourceModelValue_"+cacheObj.getRowID()).val();
		var componentTypeValue=$("#"+cacheObj.getReportType()+"_componentTypeValue_"+cacheObj.getRowID()).val();
		var domainIdValue=$("#"+cacheObj.getReportType()+"_domainIdValue_"+cacheObj.getRowID()).val();
		var resouresValue=$("#"+cacheObj.getReportType()+"_resouresValue_"+cacheObj.getRowID()).val();
		var componentResValue=$("#"+cacheObj.getReportType()+"_componentResValue_"+cacheObj.getRowID()).val();
		var componentsValue=$("#"+cacheObj.getReportType()+"_componentsValue_"+cacheObj.getRowID()).val();				
		param+="&resourceCategory="+resoureTypeValue;	
		if(objValue.isNotEmpty(resourceModel)){
			param+="&resourceModel="+resourceModel;
		}
		if(objValue.isNotEmpty(componentTypeValue)){
			param+="&childResourceType="+componentTypeValue;
			param+="&returnType=choice_resourceChild";//返回分页类型为组件			
			$("#isReloadCom_"+cacheObj.getRowID()).val("true");
		}else{
			param+="&returnType=choice_resource";//返回分页类型为资源
			$("#isReloadRes_"+cacheObj.getRowID()).val("true");
		}
		if(objValue.isNotEmpty(domainIdValue)){
			param+="&domainId="+domainIdValue;
		}
		if(objValue.isNotEmpty(componentResValue)&&objValue.isNotEmpty(componentsValue)){
			param+="&instance="+componentsValue+"&instanceParent="+componentResValue;
		}else if(objValue.isNotEmpty(resouresValue)){
			param+="&instance="+resouresValue
		}
		$("#isReloadMetric_"+cacheObj.getRowID()).val("false");
	}else{
		param+="&returnType=choice_resource"
	}		
	$("#"+cacheObj.getReportType()+"_addReportInfo_"+cacheObj.getRowID()).load(url,param,function(){$.unblockUI();});		
	var statisticFlag=new Array(false,true);//标志是否再次加载页面,true表示加载,flase标识不再加载   
	var tp = new TabPanel({id:"${tabOtherID }",
		listeners:{
	        change:function(tab){
	        	if(statisticFlag[tab.index-1]){
	        		loadChoiceMetirc();  	        		        
	        	}	        		        	
	        }
    	}}
	);	
});
$("#${reportType}_infoName_${sign }").bind("click",function(){
	if($(this).val()=="请输入标题"){
		$(this).val("");
	}	
});
//应用
$("#${tabApply}").click(function(){	
	if($(this).val()=="请输入标题"){
		$(this).val("");
	}
	if(!$.validate($("#addReportInfoForm_"+cacheObj.getRowID()))){
		return false;
	}else{
		if(submitReportInfo()){
			$("#"+cacheObj.getReportType()+"_tr_"+cacheObj.getRowID()).css("display","block");		
			$("#isShowTr").val("true");	
			$("#isNew_"+cacheObj.getRowID()).val("false");
			toast.addMessage("保存成功");
		}		
	}	
});
//确定
$("#${tabSubmit}").click(function(){
	var reportInfoName=$("#"+cacheObj.getReportType()+"_infoName_"+cacheObj.getRowID()).val();
	if(reportInfoName=="请输入标题"){
		$("#"+cacheObj.getReportType()+"_infoName_"+cacheObj.getRowID()).val()
	}
	if(!$.validate("#addReportInfoForm_"+cacheObj.getRowID())){
		return false;
	}else{
		if(submitReportInfo()){
			$("#"+cacheObj.getReportType()+"_tr_"+cacheObj.getRowID()) .css("display","block");	
			$("#isShowTr").val("true");	
			$("#isNew_"+cacheObj.getRowID()).val("false");
			closeDiv();
		}		
	}
});
//取消 
$("#${tabCancel}").click(function(){
	var reportInfoName=$("#"+cacheObj.getReportType()+"_infoName_"+cacheObj.getRowID()).val();
	if(!objValue.isNotEmpty(reportInfoName)){
		$("#"+cacheObj.getReportType()+"_infoName_"+cacheObj.getRowID()).val("请输入标题");
	}
	var flag=$("#isShowTr").val();
	if(flag=="false"&&$("#isNew_"+cacheObj.getRowID()).val()=="true"){	
		$("#"+cacheObj.getReportType()+"_tr_"+cacheObj.getRowID()).css("display","none");
	}		
	closeDiv();
	$("#"+cacheObj.getReportType()+"_showAddButton").css("display","block");
});
//关闭
$("#${tabID }").click(function(){	
	var reportInfoName=$("#"+cacheObj.getReportType()+"_infoName_"+cacheObj.getRowID()).val();
	if(!objValue.isNotEmpty(reportInfoName)){
		$("#"+cacheObj.getReportType()+"_infoName_"+cacheObj.getRowID()).val("请输入标题");
	}
	var flag=$("#isShowTr").val();
	if(flag=="false"&&$("#isNew_"+cacheObj.getRowID()).val()=="true"){	
		$("#"+cacheObj.getReportType()+"_tr_"+cacheObj.getRowID()).css("display","none");
	}		
	closeDiv();
});
</script>