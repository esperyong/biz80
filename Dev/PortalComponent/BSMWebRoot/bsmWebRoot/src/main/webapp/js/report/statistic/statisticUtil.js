//显示周期时间
function showPeriodTime(reportP){
	for(var i=0;i<2;i++){
		$("#"+cacheObj.getPeriod()+"Time"+i).css("display","none");
	}		
	for(var i=0;i<2;i++){
		$("#"+reportP+"Time"+i).css("display","block");
	}
	$("#statisticReportPeriod").val(reportP);//报告周期
	cacheObj.setPeriod(reportP);
}
//时间范围
function printTimeRange(){
	var timeRange="";
	var period=cacheObj.getPeriod();	
	if(period=="Daily"){
		$("#"+period+"Time0 select").each(function(i){
			timeRange+=$(this).val()+";";	
		});
	}
	if(objValue.isNotEmpty(timeRange)){
		timeRange=timeRange.substring(0,timeRange.length-1);
		$("#statisticReportTimeRange").val(timeRange);//报告时间范围
	}	
}
//定制时间
function getCustomTime(){
	var period=cacheObj.getPeriod();
	var customTime=$("#"+period+"Time1").find("select").val();	
	if(objValue.isNotEmpty(customTime)){
		$("#statisticReportCustomTime").val(customTime);// 定制时间
	}
}
//报表共享
function reportShare(obj){
	$("#statisticReportShare").val(obj.value);//共享赋值
	if(obj.value=="true"){//选择共享后共享域可编辑 
		$("input[name$='reportbasevo.reportDomainIds']").attr("disabled",false);
	}
	else{
		$("input[name$='reportbasevo.reportDomainIds']").attr("disabled",true);
	}
}
//报表域
function reportField(obj){
	var fliedValue="";
	$("input[name$='reportbasevo.reportDomainIds']:checked").each(function(i){
		fliedValue+=$(obj).val()+",";		
	});
	fliedValue=fliedValue.substring(0,fliedValue.length-1);
	$("#statisticReportDomainIds").val(fliedValue);
}

//显示汇总数据和详细数据
function choiceShow(obj){
	var flag=$(obj).attr("checked");	
	$("#"+cacheObj.getReportType()+"_"+obj.id.split("_")[1]+"Value_"+obj.id.split("_")[2]).val(flag)
}
//获取当前展示层的ID
function getDivID(obj){
	var id=obj.id;
	id=id.split("_")[2];
	return id;
}
//累计报告内容行数
function addNum(){
	var num=parseInt(cacheObj.getNum());
	num++;
	cacheObj.setNum(num);
}
//选择资源或自定义
function choiceRes(obj){
	if(obj.id=="choiceCustom_"+cacheObj.getRowID()){
		$("#resoure_"+cacheObj.getRowID()).css("display","none");
		$("#custom_"+cacheObj.getRowID()).css("display","block");
	}else{
		$("#resoure_"+cacheObj.getRowID()).css("display","block");
		$("#custom_"+cacheObj.getRowID()).css("display","none");
	}
}
//自定义中table复选框
function choiceCustomRow(obj){
	if(obj.checked){
		$("input[name='customCheck_"+cacheObj.getRowID()+"']").attr("checked",true);
	}else{
		$("input[name='customCheck_"+cacheObj.getRowID()+"']").attr("checked",false);
	}
}
//添加自定义行
function addCustomRow(){	
	var num=$("#customSum_"+cacheObj.getRowID()).val();
	$tr=$("<tr><tr>");
	$td=$("<td></td>");
	$text=$("<input type=\"text\"/>");
	$select=$("<select></select>");
	$span=$("<span></span>");
	var name="customCheck_"+cacheObj.getRowID();
	$tr.append($td.clone().attr("width","25%")
			.append("<input type=\"checkbox\" name=\"customCheck_"+cacheObj.getRowID()+"\" id=\""+num+"\"/>")
			.append($select.clone().attr("id","resourceFilter_"+cacheObj.getRowID()+"_"+num).append($("#"+cacheObj.getReportType()+"_resourceFilter").html())));
	$tr.append($td.clone().attr("width","55%")
			.append($select.clone().attr("id","conditionFilter_"+cacheObj.getRowID()+"_"+num).append($("#"+cacheObj.getReportType()+"_conditionFilter").html()))
			.append($text.clone().attr("id","valueFilter_"+cacheObj.getRowID()+"_"+num).attr("size","45").val("多个关键字之间用”;“分开,关系为”或“"))
			.append($span.clone().attr("class","red").html("*")));
	$tr.append($td.clone().attr("width","20%")
			.append($span.clone().html("并")));	
	$("#customTable_"+cacheObj.getRowID())
	.append("<tr id=\"row_"+cacheObj.getRowID()+"_"+num+"\" class=\"black-grid-graybg\">"+$tr.html()+"</tr>");
	num++;
	$("#customSum_"+cacheObj.getRowID()).val(num);
}
//删除自定义行
function deleteCustomRow(){	
	$("input[name$='customCheck_"+cacheObj.getRowID()+"']:checked").each(function(i){
		$("#row_"+cacheObj.getRowID()+"_"+this.id).remove();
	});
	$("#customCheckbox_"+cacheObj.getRowID()).attr("checked",false);
}
//返回数组值
function getArrayValue(array,sign){
	var result=[];
	for(var i=0;i<array.length;i++){		
		result.push(array[i]);
		if(i!=array.length-1){
			result.push(sign);
		}		
	}
	return result.join("");
}
//保存报告内容行
function saveCustomResoureVo(){	
	var reportInfoName=$("#"+cacheObj.getReportType()+"_infoName_"+cacheObj.getRowID()).val();
	if(objValue.isNotEmpty(reportInfoName)){
		if(reportInfoName!="请输入标题"){
			var flag=true;//标识是否有重复的报告内容名称
			$("#"+cacheObj.getReportType()+"Table input[name$='reportInfoName']").each(function(i){
				var oldName=$("#"+cacheObj.getReportType()+"_nameValue_"+this.id).val();
				if(oldName==reportInfoName&&this.id!=cacheObj.getRowID()){
					flag=false;
				}
			});		
			if(flag){
				$("#"+cacheObj.getReportType()+"_reportInfoName_"+cacheObj.getRowID()).val(reportInfoName);//显示报告内容名称
				$("#"+cacheObj.getReportType()+"_nameValue_"+cacheObj.getRowID()).val(reportInfoName);//报告内容名称
			}else{
				popInfo.setContentText("标题已存在。");
				popInfo.show();
				return false;
			}
		}else{
			popInfo.setContentText("请输入标题。");
			popInfo.show();
			return false;
		}				
	}else{				
		popInfo.setContentText("标题不允许为空。");
		popInfo.show();
		return false;
	}
	$("#"+cacheObj.getReportType()+"_resFilter_"+cacheObj.getRowID()).val("Resource");//选择资源还是自定义	
	if(!saveResoureValue()){
		return false;
	}
	if(!saveMetric()){//保存指标
		return false;
	}			
	$("#"+cacheObj.getReportType()+"_tr_"+cacheObj.getRowID()).css("display","block");
	return true;
}
//保存指标
function saveMetric(){	
	var metricValue="";
	var perMetricValue="";
	if(cacheObj.getReportType()=="MachineRoom"||cacheObj.getReportType()=="BusinessServices"){		
		metricValue=$("#"+cacheObj.getReportType()+"_metric_"+cacheObj.getRowID()).val();
	}else{
		$("#"+cacheObj.getReportType()+"InfoMetric_"+cacheObj.getRowID()+" input[name$="+cacheObj.getReportType()+"_metric_"+cacheObj.getRowID()+"]:checked").each(function(i){
			metricValue+=this.value+";";//信息指标
		});
		if(objValue.isNotEmpty(metricValue)){
			metricValue=metricValue.substring(0,metricValue.length-1);
		}		
		$("#"+cacheObj.getReportType()+"PerMetric_"+cacheObj.getRowID()+" input[name$="+cacheObj.getReportType()+"_metric_"+cacheObj.getRowID()+"]:checked").each(function(i){
			perMetricValue+=this.value+";";//性能指标
		});
		if(objValue.isNotEmpty(perMetricValue)){
			perMetricValue=perMetricValue.substring(0,perMetricValue.length-1);
		}
	}	
	if(objValue.isNotEmpty(metricValue)||objValue.isNotEmpty(perMetricValue)){
		if($("#isReloadMetric_"+cacheObj.getRowID()).val()=="true"){
			popInfo.setContentText("所选资源已改动，请重新选择指标。");
			popInfo.show();
			return false;
		}
		var num=0;
		if(objValue.isNotEmpty(metricValue)){			
			num=metricValue.split(";").length;
		}		
		$("#"+cacheObj.getReportType()+"_infoMetricsValue_"+cacheObj.getRowID()).val(metricValue);//信息指标
		if(cacheObj.getReportType()!="MachineRoom"&&cacheObj.getReportType()!="BusinessServices"){	
			if(objValue.isNotEmpty(perMetricValue)){
				metricValue+=";"+perMetricValue;
				num+=perMetricValue.split(";").length;
			}else{
				popInfo.setContentText("性能指标为空不能生成报告。");
				popInfo.show();
				return false;
			}
		}
				
		$("#"+cacheObj.getReportType()+"_metricValue_"+cacheObj.getRowID()).val(metricValue);//所有指标				
		$("#"+cacheObj.getReportType()+"_perMetricsValue_"+cacheObj.getRowID()).val(perMetricValue);//性能指标
		$("#"+cacheObj.getReportType()+"_metricNum_"+cacheObj.getRowID()).html(num+"个");//指标个数
		if(cacheObj.getReportType()!="MachineRoom"&&cacheObj.getReportType()!="BusinessServices"){
			var orderValue=$("input[name$="+cacheObj.getReportType()+"_metricOrder_"+cacheObj.getRowID()+"]:checked").val();		
			if(objValue.isNotEmpty(orderValue)){
				$("#"+cacheObj.getReportType()+"_orderValue_"+cacheObj.getRowID()).val(orderValue);//指标排序
			}else{	
				if(cacheObj.getReportType()!="MachineRoom"&&cacheObj.getReportType()!="BusinessServices"){	
					popInfo.setContentText("排序指标没选择");
					popInfo.show();
					return false;
				}			
			}
		}					
		return true;
	}else{		
		var falg=$("#isNew_"+cacheObj.getRowID()).val();
		if(objValue.isNotEmpty(falg)){
			if(falg=="false"){
				var metricFlag=$("#isReloadMetric_"+cacheObj.getRowID()).val();				
				if(objValue.isNotEmpty(metricFlag)&&metricFlag=="true"){
					popInfo.setContentText("所选资源已改动，请重新选择指标。");
					popInfo.show();
					return false;
				}								
			}
		}		
		popInfo.setContentText("请选择指标");
		popInfo.show();
		return false;					
	}	
}
//保存资源
function saveResoureValue(){	
	var resNum=0;
	var componentTypeValue=$("#compomentSelect_"+cacheObj.getRowID()).val();	
	if(objValue.isNotEmpty(componentTypeValue)){
		var componentResValues="";
		var componentsValues="";	
		componentResValues=$("#instancesParent_"+cacheObj.getRowID()).val();
		componentsValues=$("#instances_"+cacheObj.getRowID()).val();
		if(objValue.isNotEmpty(componentResValues)&&objValue.isNotEmpty(componentsValues)){	
			resNum=componentResValues.split(";").length;
			$("#"+cacheObj.getReportType()+"_componentTypeValue_"+cacheObj.getRowID()).val(componentTypeValue);//组件类型	
			var componentTypeName=$("#compomentSelect_"+cacheObj.getRowID()+" option:selected" ).html();
			$("#"+cacheObj.getReportType()+"_componentNameValue_"+cacheObj.getRowID()).val(componentTypeName.replace(/(^\s*)|(\s*$)/g, ""));//报告组件名称	
			$("#"+cacheObj.getReportType()+"_compomentType_"+cacheObj.getRowID()).html(componentTypeName.replace(/(^\s*)|(\s*$)/g, ""));//显示报告组件名称	
			$("#"+cacheObj.getReportType()+"_componentResValue_"+cacheObj.getRowID()).val(componentResValues);//组件资源实例ID		
			$("#"+cacheObj.getReportType()+"_componentsValue_"+cacheObj.getRowID()).val(componentsValues);//组件实例ID
			$("#"+cacheObj.getReportType()+"_componentNum_"+cacheObj.getRowID()).html(componentsValues.split(";").length+"个");//显示报告组件
		}else{		
			popInfo.setContentText("请选择资源。");
			popInfo.show();
			return false;		
		}							
	}else{
		if($("#isNew_"+cacheObj.getRowID()).val()=="false"){
			$("#"+cacheObj.getReportType()+"_componentTypeValue_"+cacheObj.getRowID()).val("");//组件类型	
			$("#"+cacheObj.getReportType()+"_componentNameValue_"+cacheObj.getRowID()).val("");//显示报告组件名称
			$("#"+cacheObj.getReportType()+"_compomentType_"+cacheObj.getRowID()).html("-");//显示报告组件名称	
			$("#"+cacheObj.getReportType()+"_componentResValue_"+cacheObj.getRowID()).val("");//组件资源实例ID		
			$("#"+cacheObj.getReportType()+"_componentsValue_"+cacheObj.getRowID()).val("");//组件实例ID
			$("#"+cacheObj.getReportType()+"_componentNum_"+cacheObj.getRowID()).html("-");//显示报告组件
		}
		var resouresValue="";//资源实例
		var resouresValue=$("#instances_"+cacheObj.getRowID()).val();		
		if(objValue.isNotEmpty(resouresValue)){				
			resNum=resouresValue.split(";").length;
			$("#"+cacheObj.getReportType()+"_resouresValue_"+cacheObj.getRowID()).val(resouresValue);//资源实例				
		}else{	 
			popInfo.setContentText("请选择资源。");
			popInfo.show();
			return false;			
		}
	}
	
	var domainIdValue=$("#domainId_"+cacheObj.getRowID()).val();
	$("#"+cacheObj.getReportType()+"_domainIdValue_"+cacheObj.getRowID()).val(domainIdValue);//域	
	var resoureTypeValue=$("#resoureTypeSelect_"+cacheObj.getRowID()).val();
	$("#"+cacheObj.getReportType()+"_resoureTypeValue_"+cacheObj.getRowID()).val(resoureTypeValue);//资源类型	
	$("#"+cacheObj.getReportType()+"_resoureNum_"+cacheObj.getRowID()).html(resNum+"个");
	var resourceModelValue=$("#resourceModelSelect_"+cacheObj.getRowID()).val();
	if(objValue.isNotEmpty(resourceModelValue)){
		if(resoureTypeValue!=resourceModelValue){
			$("#"+cacheObj.getReportType()+"_resourceModelValue_"+cacheObj.getRowID()).val(resourceModelValue);//资源模型
		}else{
			$("#"+cacheObj.getReportType()+"_resourceModelValue_"+cacheObj.getRowID()).val("");//资源模型
		}	
	}else{
		$("#"+cacheObj.getReportType()+"_resourceModelValue_"+cacheObj.getRowID()).val("");//资源模型
	}	
	if(cacheObj.getReportType()!="MachineRoom"&&cacheObj.getReportType()!="BusinessServices"){	
		var resoureTypeName=$("#resoureTypeSelect_"+cacheObj.getRowID()+" option:selected" ).html();
		if(resoureTypeName.indexOf("-")>-1){
			resoureTypeName=resoureTypeName.split("-")[1];
		}	
		$("#"+cacheObj.getReportType()+"_resoureNameValue_"+cacheObj.getRowID()).val(resoureTypeName);//报告资源名称
		$("#"+cacheObj.getReportType()+"_resoureType_"+cacheObj.getRowID()).html(resoureTypeName);//显示报告资源名称
	}
	return true;
}
//全部选中或不选 
function fullChoice(obj){
	if(obj.checked){
		$("#"+$("#statisticReportType").val()+"Table input[name$='reportInfoName']").attr("checked",true); 
	}
	else{
		$("#"+$("#statisticReportType").val()+"Table input[name$='reportInfoName']").attr("checked",false);
	}
}
//报告内容table删除行
function deteleTableRow(){	
	var flag=false;
	$("input[name$='reportInfoName']:checked").each(function(i){
		$("#"+$("#statisticReportType").val()+"_tr_"+this.id).remove();
		flag=true;
	});
	if(flag){
		$("#"+$("#statisticReportType").val()+"_Checkbox").attr("checked",false);
	}else{
		popInfo.setContentText("请选择要删除的内容 ");
		popInfo.show();
	}	
}
//拼写报告内容行
function printReportRow(id){
	$tr=$("<tr><tr>");
	$td=$("<td></td>");
	$span=$("<span></span>");
	$div=$("<div></div>");
	$("#"+cacheObj.getReportType()+"_reportInfo").append($div.clone().attr("id",cacheObj.getReportType()+"_div0_"+id+"").attr("style","position:absolute;left:10%;top:1%;width:90%;height:90%;z-index:1000;visibility:hidden"));
	
	if(cacheObj.getReportType()=="MachineRoom"){
		$tr.append($td.clone().attr("width","25%")
				.append($("<input type=\"checkbox\" name=\"reportInfoName\">").clone().attr("id",id))
				.append($("<input type=\"text\" >").clone().attr("id",cacheObj.getReportType()+"_reportInfoName_"+id).attr("disabled",true)))
				.append($("<input type=\"hidden\"  name=\"reportInfo["+id+"].id\">").clone().attr("id",cacheObj.getReportType()+"_idValue_"+id))
				.append($("<input type=\"hidden\"  name=\"reportInfo["+id+"].name\">").clone().attr("id",cacheObj.getReportType()+"_nameValue_"+id));
		$tr.append($td.clone().attr("width","25%")
				.append($("<input type=\"hidden\"  name=\"reportInfo["+id+"].resources\">").clone().attr("id",cacheObj.getReportType()+"_resouresValue_"+id))
				.append($("<input type=\"hidden\"  name=\"reportInfo["+id+"].metrics\">").clone().attr("id",cacheObj.getReportType()+"_metricValue_"+id))											
				.append($span.clone().attr("id",cacheObj.getReportType()+"_metricNum_"+id).html("-")));
		$tr.append($td.clone().attr("width","25%")		
				.append("<span class=\"black-btn-l\"><span class=\"btn-r\"><span class=\"btn-m\"><a id=\""+cacheObj.getReportType()+"_a3_"+id+"\" onclick=\"reSet(this)\">设置</a>" 
						+"</span></span></span><input type=\"hidden\" id=\""+cacheObj.getReportType()+"_isLoad_"+id+"\" value=\"true\" />"));
		$tr.append($td.clone().attr("width","25%")
				.append($span.clone().attr("class","ico ico-select").attr("id",cacheObj.getReportType()+"_preview_"+id).attr("onclick","preview(this)").attr("title","预览")));	
	}else{
		$tr.append($td.clone().attr("width","170px")
				.append($("<input type=\"checkbox\" name=\"reportInfoName\">").clone().attr("id",id))
				.append($("<input type=\"text\" >").clone().attr("id",cacheObj.getReportType()+"_reportInfoName_"+id).attr("disabled",true)))
				.append($("<input type=\"hidden\"  name=\"reportInfo["+id+"].id\">").clone().attr("id",cacheObj.getReportType()+"_idValue_"+id))
				.append($("<input type=\"hidden\"  name=\"reportInfo["+id+"].name\">").clone().attr("id",cacheObj.getReportType()+"_nameValue_"+id));
		$tr.append($td.clone().attr("width","120px")
				.append($("<input type=\"hidden\"  name=\"reportInfo["+id+"].resoureType\">").clone().attr("id",cacheObj.getReportType()+"_resoureTypeValue_"+id))
				.append($("<input type=\"hidden\"  name=\"reportInfo["+id+"].resoureName\">").clone().attr("id",cacheObj.getReportType()+"_resoureNameValue_"+id))			
				.append($("<input type=\"hidden\"  name=\"reportInfo["+id+"].resourceModel\">").clone().attr("id",cacheObj.getReportType()+"_resourceModelValue_"+id))
				.append($("<input type=\"hidden\"  name=\"reportInfo["+id+"].resourceModelName\">").clone().attr("id",cacheObj.getReportType()+"_resourceModelNameValue_"+id))
				.append($span.clone().attr("id",cacheObj.getReportType()+"_resoureType_"+id+"").html("-")));	
		$tr.append($td.clone()
				.append($("<input type=\"hidden\"  name=\"reportInfo["+id+"].resFilter\">").clone().attr("id",cacheObj.getReportType()+"_resFilter_"+id))
				.append($("<input type=\"hidden\"  name=\"reportInfo["+id+"].resources\">").clone().attr("id",cacheObj.getReportType()+"_resouresValue_"+id))
				.append($("<input type=\"hidden\"  name=\"reportInfo["+id+"].resourcesName\">").clone().attr("id",cacheObj.getReportType()+"_resourcesNameValue_"+id))
				.append($("<input type=\"hidden\"  name=\"reportInfo["+id+"].customsInfoType\">").clone().attr("id",cacheObj.getReportType()+"_customsInfoTypeValue_"+id))
				.append($("<input type=\"hidden\"  name=\"reportInfo["+id+"].customsCondition\">").clone().attr("id",cacheObj.getReportType()+"_customsConditionValue_"+id))
				.append($("<input type=\"hidden\"  name=\"reportInfo["+id+"].customsValue\">").clone().attr("id",cacheObj.getReportType()+"_customsValue_"+id))
				.append($("<input type=\"hidden\"  name=\"reportInfo["+id+"].domainId\">").clone().attr("id",cacheObj.getReportType()+"_domainIdValue_"+id))
				.append($span.clone().attr("id",cacheObj.getReportType()+"_resoureNum_"+id).html("-")));
		$tr.append($td.clone()
				.append($("<input type=\"hidden\"  name=\"reportInfo["+id+"].componentType\">").clone().attr("id",cacheObj.getReportType()+"_componentTypeValue_"+id))
				.append($("<input type=\"hidden\"  name=\"reportInfo["+id+"].componentName\">").clone().attr("id",cacheObj.getReportType()+"_componentNameValue_"+id))
				.append($span.clone().attr("id",cacheObj.getReportType()+"_compomentType_"+id).html("-")));
		$tr.append($td.clone()
				.append($("<input type=\"hidden\"  name=\"reportInfo["+id+"].componentRes\">").clone().attr("id",cacheObj.getReportType()+"_componentResValue_"+id))
				.append($("<input type=\"hidden\"  name=\"reportInfo["+id+"].components\">").clone().attr("id",cacheObj.getReportType()+"_componentsValue_"+id))
				.append($span.clone().attr("id",cacheObj.getReportType()+"_componentNum_"+id).html("-")));
		$tr.append($td.clone()
				.append($("<input type=\"hidden\"  name=\"reportInfo["+id+"].metrics\">").clone().attr("id",cacheObj.getReportType()+"_metricValue_"+id))
				.append($("<input type=\"hidden\"  name=\"reportInfo["+id+"].infoMetrics\">").clone().attr("id",cacheObj.getReportType()+"_infoMetricsValue_"+id))
				.append($("<input type=\"hidden\"  name=\"reportInfo["+id+"].perMetrics\">").clone().attr("id",cacheObj.getReportType()+"_perMetricsValue_"+id))
				.append($("<input type=\"hidden\"  name=\"reportInfo["+id+"].order\">").clone().attr("id",cacheObj.getReportType()+"_orderValue_"+id))
				.append($span.clone().attr("id",cacheObj.getReportType()+"_metricNum_"+id).html("-")));
		$tr.append($td.clone()		
				.append("<span class=\"black-btn-l\"><span class=\"btn-r\"><span class=\"btn-m\"><a id=\""+cacheObj.getReportType()+"_a3_"+id+"\" onclick=\"reSet(this)\">设置</a>" 
						+"</span></span></span><input type=\"hidden\" id=\""+cacheObj.getReportType()+"_isLoad_"+id+"\" value=\"true\" />"));
		if(cacheObj.getReportType()=="Performance"||cacheObj.getReportType()=="Malfunction"){
			$tr.append($td.clone()
					.append($("<input type=\"checkbox\" checked=\"checked\" onclick=\"choiceShow(this)\">").clone().attr("id",cacheObj.getReportType()+"_show1_"+id))
					.append($("<input type=\"hidden\"  name=\"reportInfo["+id+"].show1\" value=\"true\">").clone().attr("id",cacheObj.getReportType()+"_show1Value_"+id))
					.append($span.clone().html("显示")));	
			$tr.append($td.clone()
					.append($("<input type=\"checkbox\" onclick=\"choiceShow(this)\">").clone().attr("id",cacheObj.getReportType()+"_show2_"+id))
					.append($("<input type=\"hidden\"  name=\"reportInfo["+id+"].show2\" value=\"false\">").clone().attr("id",cacheObj.getReportType()+"_show2Value_"+id))
					.append($span.clone().html("显示")));
		}	
		$tr.append($td.clone()
				.append($span.clone().attr("class","ico ico-select").attr("id",cacheObj.getReportType()+"_preview_"+id).attr("onclick","preview(this)").attr("title","预览")));	
	}				
	$("#"+cacheObj.getReportType()+"Table").append("<tr style=\"display:none\" id=\""+cacheObj.getReportType()+"_tr_"+id+"\">"+$tr.html()+"<tr>");	
}
/**
 * 加载资源实例
 */
function loadInstance(){	
	$.blockUI({message:$('#loading')});	
	var url=path+"/report/statistic/statisticOper!loadChoiceResource.action";
	var param=$("#resourceForm_"+cacheObj.getRowID()).serialize();	
	param+="&userId="+userId;
	$("#choiceResource_"+cacheObj.getRowID()).load(url,param,function(){$.unblockUI();});
}
//初始化资源类型，模型，组件 
function initRes(obj){
	loadSelect($("#resoureTypeSelect_"+cacheObj.getRowID()).val(),$("#resourceModelSelect_"+cacheObj.getRowID()));//初始化资源模型
	if(cacheObj.getReportType()!="Malfunction"){
		loadchildResSelect($("#resoureTypeSelect_"+cacheObj.getRowID()).val(),$("#compomentSelect_"+cacheObj.getRowID()));//初始化组件
	}		
}
//重新初始化组件     
function loadResModel(Obj){
	var resourceModel=$(Obj).val();
	var resourceType=$("#resoureTypeSelect_"+cacheObj.getRowID()).val();
	if(objValue.isNotEmpty(resourceType)){
		if(objValue.isNotEmpty(resourceModel)){
			if(resourceType!=resourceModel){
				loadComSelect($(Obj).val(),$("#compomentSelect_"+cacheObj.getRowID()));			
			}else{
				loadchildResSelect(resourceType,$("#compomentSelect_"+cacheObj.getRowID()));
			}
		}else{
			loadchildResSelect(resourceType,$("#compomentSelect_"+cacheObj.getRowID()));
		}		
	}	
}
//加载指标
function loadChoiceMetirc(){
	$.blockUI({message:$('#loading')});	 
	var url = path+"/report/statistic/statisticOper!loadChoiceMetirc.action";
	var param="reportType="+cacheObj.getReportType()+"&sign="+cacheObj.getRowID();        	        		
	var resoureType=$("#resoureTypeSelect_"+cacheObj.getRowID()).val();//资源类型	
	var resourceModel=$("#resourceModelSelect_"+cacheObj.getRowID()).val();//资源模型	
	var childResourceType=$("#compomentSelect_"+cacheObj.getRowID()).val();//组件
	var resouresValue=$("#instances_"+cacheObj.getRowID()).val();
	var componentResValue=$("#instancesParent_"+cacheObj.getRowID()).val();	
	param+="&resourceCategory="+resoureType;
	if(objValue.isNotEmpty(resoureType)){
		if(objValue.isNotEmpty(resourceModel)&&resoureType!=resourceModel){
			param+="&resourceModel="+resourceModel;
			if(objValue.isNotEmpty(childResourceType)){
				param+="&childResourceType="+childResourceType;
			}			
		}else{			 
			var metricSign=metricObj.get(resoureType);
			if(objValue.isNotEmpty(metricSign)){
				param+="&metricSign="+metricSign
			}		
			var childResourceType=$("#compomentSelect_"+cacheObj.getRowID()).val();
    		if(objValue.isNotEmpty(childResourceType)){
    			param+="&childResourceType="+childResourceType;
    		}
		}
	}
	if(objValue.isNotEmpty(componentResValue)&&objValue.isNotEmpty(resouresValue)){
		param+="&instance="+resouresValue+"&instanceParent="+componentResValue;
	}else if(objValue.isNotEmpty(resouresValue)){
		param+="&instance="+resouresValue
	}
	if($("#isNew_"+cacheObj.getRowID()).val()=="false"){
		var metricValue=$("#"+cacheObj.getReportType()+"_metricValue_"+cacheObj.getRowID()).val();
		param+="&metircs="+metricValue;
	}
	$("#"+cacheObj.getReportType()+"_addReportMetric_"+cacheObj.getRowID()).load(url,param,function(){$.unblockUI();})
	//cacheObj.setIsReloadMetric(false);//标识指标已经更改
	$("#isReloadMetric_"+cacheObj.getRowID()).val("false");
}
//添加报告内容确定和应用 
function submitReportInfo(){				
	return saveCustomResoureVo();
}
//初始化资源分页表单
function initForm(obj){
	var id=obj.id;
	var sign=id.split("_")[0];	
	if(sign=="resoureTypeSelect"||sign=="resourceModelSelect"){
		if($("#isReloadRes_"+cacheObj.getRowID()).val()=="true"){
			//$("#returnType_"+cacheObj.getRowID()).val("jsonType");
		}else{
			$("#isReloadRes_"+cacheObj.getRowID()).val("true");
			$("#returnType_"+cacheObj.getRowID()).val("choice_resource");			
		}	
		$("#returnType_"+cacheObj.getRowID()).val("choice_resource");		
		$("#isReloadCom_"+cacheObj.getRowID()).val("false");
		$("#searchValue_"+cacheObj.getRowID()).val("");
	}else if(sign=="compomentSelect"){
		if(objValue.isNotEmpty($(obj).val())){	
			if($("#isReloadCom_"+cacheObj.getRowID()).val()=="true"){
				//$("#returnType_"+cacheObj.getRowID()).val("jsonType");
			}else{
				$("#isReloadCom_"+cacheObj.getRowID()).val("true");
				$("#returnType_"+cacheObj.getRowID()).val("choice_resourceChild");
			}
			$("#returnType_"+cacheObj.getRowID()).val("choice_resourceChild");
			$("#isReloadRes_"+cacheObj.getRowID()).val("false");
		}else{
			$("#isReloadRes_"+cacheObj.getRowID()).val("true");
			$("#returnType_"+cacheObj.getRowID()).val("choice_resource");		
			$("#isReloadCom_"+cacheObj.getRowID()).val("false");
		}
		$("#searchType_"+cacheObj.getRowID()).val("SEARCHTYPE_NAME");
		$("#searchValue_"+cacheObj.getRowID()).val("");
	}else if(sign=="pageQueryVO"){
		var searchValue=$("#searchValue_"+cacheObj.getRowID()).val();
		if(objValue.isNotEmpty(searchValue)&&searchValue=="请输入条件进行搜索"){	
			$("#searchValue_"+cacheObj.getRowID()).val("");
		}		
		$("#searchType_"+cacheObj.getRowID()).val($("#pageQuerySearch_"+cacheObj.getRowID()).val());
		if($("#isReloadRes_"+cacheObj.getRowID()).val()=="true"){
			$("#returnType_"+cacheObj.getRowID()).val("choice_resource");	
		}else{
			$("#returnType_"+cacheObj.getRowID()).val("choice_resourceChild");
		}
	}else{
		if($("#isReloadRes_"+cacheObj.getRowID()).val()=="true"){
			$("#returnType_"+cacheObj.getRowID()).val("choice_resource");	
		}else{
			$("#returnType_"+cacheObj.getRowID()).val("choice_resourceChild");
		}
	}	
	$("#instances_"+cacheObj.getRowID()).val("");	
	$("#instancesParent_"+cacheObj.getRowID()).val("");	
	$("#compositor_"+cacheObj.getRowID()).val("COMPOSITOR_DISPLAYNAME");
	$("#order_"+cacheObj.getRowID()).val("ASC");
	$("#pageSize_"+cacheObj.getRowID()).val("12");
	$("#pageNumber_"+cacheObj.getRowID()).val("1");
	$("#isReloadMetric_"+cacheObj.getRowID()).val("true");//模型组件的更改标识指标的更改	
}
function choiceSearchType(obj){
	$("#searchType_"+cacheObj.getRowID()).val($(obj).val());
}
//全选或不选资源实例
function choiceResInstances(obj){
	var instances="";
	var instancesParent="";
	if($(obj).attr("checked")){
		$("input[name$='check_"+cacheObj.getRowID()+"']").each(function(i){
			$(this).attr("checked",true);
			instances+=$(this).val()+";";
			if($("#isReloadCom_"+cacheObj.getRowID()).val()=="true"){
				instancesParent+=$(this).val()+","+$("#"+$(this).val()+"_"+cacheObj.getRowID()).val()+";";
			}
		});
		if(objValue.isNotEmpty(instances)){
			instances=instances.substring(0,instances.length-1);
			var olderInstances=$("#instances_"+cacheObj.getRowID()).val();		
			if(objValue.isNotEmpty(olderInstances)){
				var instanceArray=new Array();
				instanceArray=getArrayBySign(olderInstances,";");
				var newInstanceArray=getArrayBySign(instances,";");
				for(var i=0;i<newInstanceArray.length;i++){
					if(instanceArray.indexOf(newInstanceArray[i])==-1){
						olderInstances+=";"+newInstanceArray[i];
					}
				}				
				$("#instances_"+cacheObj.getRowID()).val(olderInstances);
			}else{
				$("#instances_"+cacheObj.getRowID()).val(instances);
			}
		}					
		if(objValue.isNotEmpty(instancesParent)){
			instancesParent=instancesParent.substring(0,instancesParent.length-1);
			var olderInstances=$("#instancesParent_"+cacheObj.getRowID()).val();		
			if(objValue.isNotEmpty(olderInstances)){
				var instanceArray=new Array();
				instanceArray=getArrayBySign(olderInstances,";");
				var newInstanceArray=getArrayBySign(instancesParent,";");
				for(var i=0;i<newInstanceArray.length;i++){
					if(instanceArray.indexOf(newInstanceArray[i])==-1){
						olderInstances+=";"+newInstanceArray[i];
					}
				}
				$("#instancesParent_"+cacheObj.getRowID()).val(olderInstances);
			}else{
				$("#instancesParent_"+cacheObj.getRowID()).val(instancesParent);
			}
		}
	}else{
		var arrayInstances=new Array();		
		var olderInstances=$("#instances_"+cacheObj.getRowID()).val();
		if(objValue.isNotEmpty(olderInstances)){
			arrayInstances=getArrayBySign(olderInstances,";");
		}
		var arrayInsParent=new Array();
		var olderInsParent=$("#instancesParent_"+cacheObj.getRowID()).val();
		if(objValue.isNotEmpty(olderInsParent)){
			arrayInsParent=getArrayBySign(olderInsParent,";");
		}
		$("input[name$='check_"+cacheObj.getRowID()+"']").each(function(i){
			$(this).attr("checked",false);
			if(objValue.isNotEmpty(arrayInstances)){
				arrayInstances.remove($(this).val());
			}	
			if($("#isReloadCom_"+cacheObj.getRowID()).val()=="true"){
				if(objValue.isNotEmpty(arrayInsParent)){					
					arrayInsParent.remove($(this).val()+","+$("#"+$(this).val()+"_"+cacheObj.getRowID()).val());
				}	
			}
		});
		if(objValue.isNotEmpty(arrayInstances)){
			var instances=getArrayValue(arrayInstances,";");
			$("#instances_"+cacheObj.getRowID()).val(instances);
		}else{
			$("#instances_"+cacheObj.getRowID()).val("");
		}
		if($("#isReloadCom_"+cacheObj.getRowID()).val()=="true"){
			if(objValue.isNotEmpty(arrayInsParent)){
				var instances=getArrayValue(arrayInsParent,";");
				$("#instancesParent_"+cacheObj.getRowID()).val(instances);
			}	
		}else{
			$("#instancesParent_"+cacheObj.getRowID()).val("");
		}
	}
	$("#isReloadMetric_"+cacheObj.getRowID()).val("true");//更改标识指标	
}
//选择单个资源实例
function choiceInstance(obj){
	if($(obj).attr("checked")){		
		var olderInstances=$("#instances_"+cacheObj.getRowID()).val();		
		if(objValue.isNotEmpty(olderInstances)){
			olderInstances+=";"+$(obj).val();
			$("#instances_"+cacheObj.getRowID()).val(olderInstances);
		}else{
			$("#instances_"+cacheObj.getRowID()).val($(obj).val());
		}
		var olderInsParent=$("#instancesParent_"+cacheObj.getRowID()).val();
		if($("#isReloadCom_"+cacheObj.getRowID()).val()=="true"){
			if(objValue.isNotEmpty(olderInsParent)){
				olderInsParent+=";"+$(obj).val()+","+$("#"+$(obj).val()+"_"+cacheObj.getRowID()).val();
				$("#instancesParent_"+cacheObj.getRowID()).val(olderInsParent);
			}else{
				$("#instancesParent_"+cacheObj.getRowID()).val($(obj).val()+","+$("#"+$(obj).val()+"_"+cacheObj.getRowID()).val());
			}
		}
	}else{
		var array=new Array();
		var olderInstances=$("#instances_"+cacheObj.getRowID()).val();
		if(objValue.isNotEmpty(olderInstances)){
			array=getArrayBySign(olderInstances,";");
		}
		if(objValue.isNotEmpty(array)){
			array.remove($(obj).val());
			var instances=getArrayValue(array,";");
			$("#instances_"+cacheObj.getRowID()).val(instances);
		}
		var arrayInsParent=new Array();
		var olderInsParent=$("#instancesParent_"+cacheObj.getRowID()).val();
		if(objValue.isNotEmpty(olderInsParent)){
			arrayInsParent=getArrayBySign(olderInsParent,";");
		}
		if($("#isReloadCom_"+cacheObj.getRowID()).val()=="true"){
			if(objValue.isNotEmpty(arrayInsParent)){			
				if(objValue.isNotEmpty(arrayInsParent)){
					arrayInsParent.remove($(obj).val()+","+$("#"+$(obj).val()+"_"+cacheObj.getRowID()).val());
					var instances=getArrayValue(arrayInsParent,";");
					$("#instancesParent_"+cacheObj.getRowID()).val(instances);
				}
			}			
		}		
	}
	$("#isReloadMetric_"+cacheObj.getRowID()).val("true");//更改标识指标
	isChecked();
}
/**
 * 分页全选按钮是否选中
 */
function isChecked(){
	var num=0;
	$("input[name$='check_"+cacheObj.getRowID()+"']:checked").each(function(i){
		num++;
	});
	if(num==10){
		$("#checkall_"+cacheObj.getRowID()).attr("checked",true);
	}else{
		$("#checkall_"+cacheObj.getRowID()).attr("checked",false);
	}
}
//添加报告内容行
function addReportInfo(){
	if(!$.validate($("#reportInfo"))){
		return false;
	}
	var flag=$("#isShowTr").val();//标识是否重新调用新页面	
	if(flag=="true"){
		addNum();	
		printReportRow(cacheObj.getNum());	
		cacheObj.setRowID(cacheObj.getNum());
		cacheObj.setDivID(cacheObj.getReportType()+"_div0_"+cacheObj.getNum());
		showDiv(cacheObj.getReportType()+"_div0_"+cacheObj.getRowID());	
		if(cacheObj.getReportType()=="MachineRoom"){
			loadPage(path+"/roomDefine/reportDingzhi.action?sign="+cacheObj.getRowID()+"&reportType="+cacheObj.getReportType(),cacheObj.getReportType()+"_div0_"+cacheObj.getRowID());
		}else{
			loadPage(path+"/report/statistic/statisticOper!loadAddReportInfo.action?sign="+cacheObj.getRowID()+"&reportType="+cacheObj.getReportType(),cacheObj.getReportType()+"_div0_"+cacheObj.getRowID());
		}				
	}else{
		$("#"+cacheObj.getReportType()+"_tr_"+cacheObj.getNum()).css("display","block");
		showDiv(cacheObj.getReportType()+"_div0_"+cacheObj.getNum());
		cacheObj.setDivID(cacheObj.getReportType()+"_div0_"+cacheObj.getNum());
		cacheObj.setRowID(cacheObj.getNum());
	}
	$("#isShowTr").val("false");
	$("#"+cacheObj.getReportType()+"_showAddButton").css("display","none");
}