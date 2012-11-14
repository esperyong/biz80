
/*
 * 打开窗口方法
 * 	url		:	路径
 * 	winName :	窗口名称
 *  pageId	:	提交后刷新的区域
 **/
function openWinFun(url,winName,pageId){
	var winOpenObj = {};
	winOpenObj.url= url;
	winOpenObj.name=winName;
	winOpenObj.width = '600';
	winOpenObj.height = '350';
	winOpenObj.scrollable = false;
	winOpenObj.resizeable = false;
	var returnVal = modalinOpen(winOpenObj);
	if(returnVal=="success"){
		if(pageId){
			loadTablePanelFun(pageId);
		}else{
			loadTable();
		}
	}
}

//删除模型
function delModelFun(url,data){
	if(!data){
		doInformatAlter();
		return;
	}
	var _confirm = new confirm_box({text:"是否删除模型？"});
	_confirm.setConfirm_listener(function(){
		$.ajax({
			url:url,
			data:data,
			dataType:"json",
			type:"post",
			success:function(data,state){
				if(data.errorMsg){
					toast.addMessage("操作失败。原因："+data.errorMsg);
					setTimeout(function(){},500);
				}else{
					toast.addMessage("操作成功。");
					setTimeout(function(){
						loadTable();
					},500);	
				}
			}
		});
		_confirm.hide();
	});	
	_confirm.show();
}
//删除组件
function delComponentFun(url,data){
	if(!data){
		doInformatAlter();
		return;
	}
	var _confirm = new confirm_box({text:"是否删除组件？"});
	_confirm.setConfirm_listener(function(){
		$.ajax({
			url:url,
			data:data,
			dataType:"json",
			type:"post",
			success:function(datas,state){
				if(datas.errorMsg){
					toast.addMessage("操作失败。原因："+datas.errorMsg);
					setTimeout(function(){},500);
				}else{
					toast.addMessage("操作成功。");
					setTimeout(function(){
						loadTablePanelFun("tab3");
					},500);	
				}				
			}
		});
		_confirm.hide();
	});
	_confirm.show();
}
//删除指标
function delMetricFun(checkBoxId,parentId){
	var data = $("input[id *= '"+checkBoxId+"']:checked").serialize();
	if(!data){
		doInformatAlter();
		return;
	}
	var _confirm = new confirm_box({text:"是否删除指标？"});
	_confirm.setConfirm_listener(function(){
		$.ajax({
			url:ctx+"/scriptmonitor/repository/delModelExtend!delMetric.action",
			data:data+"&resourceId="+parentId,
			dataType:"json",
			type:"post",
			success:function(data,state){
				if(data.errorMsg){
					toast.addMessage("操作失败。原因："+data.errorMsg);
					setTimeout(function(){},500);
				}else{
					toast.addMessage("操作成功。");
					setTimeout(function(){
						loadTablePanelFun("tab2");
					},500);	
				}				
			}
		});
		_confirm.hide();
	});
	_confirm.show();
}

function delMetricFun2(metricId,parentId){
	if(!metricId){
		doInformatAlter();
		return;
	}
	var _confirm = new confirm_box({text:"是否删除指标？"});
	_confirm.setConfirm_listener(function(){
		$.ajax({
			url:ctx+"/scriptmonitor/repository/delModelExtend!delMetric.action",
			data:"metricId="+metricId+"&resourceId="+parentId,
			dataType:"json",
			type:"post",
			
			success:function(data,state){
				if(data.errorMsg){
					toast.addMessage("操作失败。原因："+data.errorMsg);
					setTimeout(function(){},500);
				}else{
					toast.addMessage("操作成功。");
					setTimeout(function(){
						loadTablePanelFun("tab3");
					},500);	
				}
			}
		});
		_confirm.hide();
	});
	_confirm.show();
}
//发布
function publishModelFun(resourceId){

	if(!resourceId){
		doInformatAlter();
		return;
	}
	var _confirm = new confirm_box({text:"是否发布模型？"});
	_confirm.setConfirm_listener(function(){
		$.blockUI({message:$('#loading')});
		$.ajax({
			url:ctx+"/scriptmonitor/repository/modelExtend!publishModel.action",
			data:"resourceId="+resourceId,
			dataType:"json",
			type:"post",
			success:function(data,state){
				$.unblockUI();
				if(data.errorMessage){
					toast.addMessage("操作失败。原因："+data.errorMessage);
					setTimeout(function(){},500);
				}else{
					toast.addMessage("发布成功。<br/>为确保系统能正常取值，请您手动重启Server。");
					setTimeout(function(){
						loadTable();
					},500);	
				}
			}
		});
		_confirm.hide();
	});
	_confirm.show();
}
//发布
function publishModelFun2(data){
	if(!data){
		doInformatAlter();
		return;
	}
	var _confirm = new confirm_box({text:"是否发布模型？"});
	_confirm.setConfirm_listener(function(){
		$.blockUI({message:$('#loading')});
		$.ajax({
			url:ctx+"/scriptmonitor/repository/modelExtend!publishModel.action",
			data:data,
			dataType:"json",
			type:"post",
			success:function(data,state){
				$.unblockUI();
				if(data.errorMessage){
					toast.addMessage("操作失败。原因："+data.errorMessage);
					setTimeout(function(){
						loadTable();
					},500);
				}else{
					toast.addMessage("发布成功。<br/>为确保系统能正常取值，请您手动重启Server。");
					setTimeout(function(){
						loadTable();
					},500);	
				}
			}
		});
		_confirm.hide();
	});
	_confirm.show();
}
//刷新表数据
function loadTable(){
	$.blockUI({message:$('#loading')});
	$.ajax({
		url:ctx+"/scriptmonitor/repository/modelExtend!searchJsonModels.action",
		data:$("#searchCondition").serialize()+"&isExtension="+isExtension,
		dataType:"json",
		type:"POST",
		success:function(data,state){
			page.pageing(data.pageCount,data.currentPageCount);
			myGP.loadGridData(data.datas);
			$.unblockUI();
		}
	});
}

//全选
function setAllSelectFun(allCheckBoxId,checkBoxName){
	var $allCheckBox = $("#"+allCheckBoxId);
	var $checkBox = $("input[checkBoxName="+checkBoxName+"]");
	$allCheckBox.bind("click",function(){
		$checkBox.each(function(i){
			$(this).attr("checked",$allCheckBox.attr("checked"));
		});
	});
}
function alertAllCheckBoxFun(allCheckBoxId,checkBoxName){
	var $allCheckBox = $("#"+allCheckBoxId);
	var $checkBox = $("input[checkBoxName="+checkBoxName+"]");
	$checkBox.each(function(i){
		$(this).bind("click",function(){
			$allCheckBox.attr("checked",true);
			$checkBox.each(function(i){
				if(!$(this).attr("checked")){
					$allCheckBox.attr("checked",false);
				}
			});
		});
	})
}
//显示指标
function showMetricFun(parentId,resourceId,$html){
	$.ajax({
		url:ctx+"/scriptmonitor/repository/editModel!showMetrics.action",
		data:"parentId="+parentId+"&resourceId="+resourceId,
		dataType:"html",
		type:"post",
		success:function(data,state){
			$html.find("*").unbind();
			$html.html("").html(data);
		}
	});
}
//打开按钮
function openBtnFun($btn){
	$btn.removeClass("monitor-ico-open").addClass("monitor-ico-close");
	var resourceId = $btn.attr("id");
	var $html = $("#"+resourceId+"_next");
	$html.show("slow");
}
//关闭按钮
function closeBtnFun($btn){
	$btn.removeClass("monitor-ico-close").addClass("monitor-ico-open");
	var resourceId = $btn.attr("id");
	var $html = $("#"+resourceId+"_next");
	$html.hide("slow");
}

function doInformatAlter(){
	var _information = new information({text:"请选择一条数据。"});
	_information.show();
}
//绑定参数设置
var disInfos;
var parameters;
var parameterMap;
var resName;
function getScriptTemplateFun(scritpId,dataParam,obj,isExist,resourceName,resourceId,sourceId){
	resName = resourceName;
	$.ajax({
		url:		ctx+"/scriptmonitor/repository/scriptTemplate!selectScriptById.action",
		data:		"scriptTemplate.id="+scritpId,
		dataType:	"json",
		cache:		false,
		success: function(data, textStatus){
			if(data.scriptTemplate){
				$("input[name=scriptTemplateIdForModule]").val(data.scriptTemplate.name);
				if(obj === "metric"){
					$("input[name=metric.scriptTemplateId]").val(data.scriptTemplate.id);
				}else{//component
					$("input[name=component.scriptTemplateId]").val(data.scriptTemplate.id);
				}
				// 设置脚本参数
				if(data.scriptTemplate.scriptParameters){
					var scriptParams = data.scriptTemplate.scriptParameters;
					//得到模型发现信息列表
					$.ajax({
						url	:	ctx+"/scriptmonitor/repository/modelExtend!discoveryInfo.action",
						data:	dataParam,
						dataType:	"json",
						cache:		false,
						success: function(data, textStatus){
							disInfos = data.moduleDiscoveryInfo;
							parameters = data.parameters;
							parameterMap = data.parameterMap;
							var paramSetDiv="";
								paramSetDiv+="<fieldset class=\"blue-border-nblock\">";
								if(isExist == "false") {//如果是扩展模型则没有设置参数列表
									paramSetDiv+="<legend>参数设置</legend>";
								} else {
									paramSetDiv+="<legend>参数预览</legend>";
								}
								paramSetDiv+="<ul class=\"fieldlist-n\">";
								if(isExist == "false") {//如果是扩展模型则没有设置参数列表
									paramSetDiv+="<li><span class=\"sub-panel-tips\" style=\"line-height:20px;\"></span>定义当前指标所需参数与模型发现信息的关系，如果是发现信息中不存在的参数，需要增加到发现页面。</li>";
								}
								paramSetDiv+="<li><span  class=\"black-btn-l f-right\"><span class=\"btn-r\"><span onclick=\"showParameterDivFun('"+resourceId+"','"+sourceId+"');\" class=\"btn-m\"><a>预览发现信息</a></span></span></span></li>";
								if(isExist == "false"){//如果是扩展模型则没有设置参数列表
									paramSetDiv+="<li><div class=\" border-gray\"><table id=\"discoveryTable\" class=\"grid-gray-fontwhite-g\"><thead><tr><th width=\"5%\">&nbsp;</th><th width=\"45%\">脚本参数</th><th width=\"50%\">对应的发现信息</th></tr></thead><tbody>";
								}else{
									paramSetDiv+="<li style=\"display:none;\"><div><table id=\"discoveryTable\"><tbody>";
								}
								for(var i=0; i<scriptParams.length; i++){
										var paramshtml = createSelectHtml(disInfos,parameters,scriptParams[i].key);
										if(i%2==0){
											paramSetDiv+="<tr class=\"w-bg\">";
										}else{
											paramSetDiv+="<tr class=\"g-bg\">";
										}
										paramSetDiv+="<td height=\"20\">&nbsp;</td><td><span id=\"selectName"+i+"\" value=\""+scriptParams[i].key+"\" class=\"field\" style=\"padding:1pt; margin:2pt;\">";
										paramSetDiv+=scriptParams[i].name;
										if(obj === "metric"){
											paramSetDiv+="</span></td><td><select selectName=\"selectName"+i+"\" name=\"metric.parameterDefs["+i+"].value\" >";
										}else{//component
											paramSetDiv+="</span></td><td><select selectName=\"selectName"+i+"\" name=\"component.parameterDefs["+i+"].value\" >";
										}
										paramSetDiv+=paramshtml;
										paramSetDiv+="</select></td></tr>";
										
										if(obj === "metric"){
											paramSetDiv+="<input name=\"metric.parameterDefs["+i+"].parameterKey\" value=\""+scriptParams[i].key+"\" type=\"hidden\"/>";
										}else{//component
											paramSetDiv+="<input name=\"component.parameterDefs["+i+"].parameterKey\" value=\""+scriptParams[i].key+"\" type=\"hidden\"/>";
										}
								}
								paramSetDiv+="</tbody></table></div></li>";
								paramSetDiv+="</ul></fieldset>";
								$("#paramValues").html("").append(paramSetDiv);
								dialogResize();
						}
					});
				}
			}
		}
	});
}
//生成参数列表
function createSelectHtml(disInfos,parameters,paramKey){
	var optionValues="<option value=''>请选择</option>";
	if(disInfos && parameters.length>0){
		var optionVal;
		for(var i=0;i<parameters.length;i++){
			for(var j=0;j<disInfos.length;j++){
				if(disInfos[j].key == parameters[i] && paramKey == parameterMap[parameters[i]]){
					optionVal = disInfos[j].key;
				}
			}
		}
		for(var j=0;j<disInfos.length;j++){
			if(disInfos[j].key == optionVal){
				optionValues+="<option value='"+disInfos[j].key+"' selected>"+disInfos[j].name+"</option>";
			}else{
				optionValues+="<option value='"+disInfos[j].key+"'>"+disInfos[j].name+"</option>";
			}
		}
	}else if(disInfos){
		for(var j=0;j<disInfos.length;j++){
			optionValues+="<option value='"+disInfos[j].key+"'>"+disInfos[j].name+"</option>";
		}
	}
	return optionValues;
}
//显示弹出层
var expandAttributes;
function showParameterDivFun(resourceId,sourceId){
		expandAttributes =null;
		$.ajax({
			url	:	ctx+"/scriptmonitor/repository/modelExtend!preViewDiscoveryInfo.action",
			data:	"resourceId="+resourceId+"&sourceId="+sourceId,
			dataType:	"json",
			cache:		false,
			success: function(data, textStatus){
						var tempDisInfos = data.moduleDiscoveryInfo;
						expandAttributes =  data.expandAttributes;
						if(tempDisInfos || parameters){
							var selectObjs = new Array();
							var html="<ul id=\"allParameterUi\" class=\"fieldlist-n\" style=\"color:#fff;\">";
							html+="<li><span class=\"field-middle\" style=\"width:125px;\">当前模型</span><span>：</span><span class=\"field-middle\" style=\"width:125px;\">"+resName+"</span></li>";
							//得到所有模型发现输入项
							if(tempDisInfos){
								for(var i=0;i<tempDisInfos.length;i++){
									if(tempDisInfos[i].supportSelect){
										if(selectObjs.length <=0 && tempDisInfos[i].supportValues && tempDisInfos[i].supportValues[0]){
											selectObjs.push(tempDisInfos[i].supportValues[0]);
										}
										html+="<li id=\""+tempDisInfos[i].key+"\"><span class=\"field-middle\" style=\"width:125px;\">"+tempDisInfos[i].name+"</span><span>：</span>";
										html+="<select onchange=\"changeHiddenLi(this.value);\">";
										for(var j=0;j<tempDisInfos[i].supportValues.length;j++){
											html+="<option value=\""+tempDisInfos[i].supportValues[j]+"\">"+tempDisInfos[i].supportValues[j]+"</option>";
										}
										html+="</select>";
										html+="<span class=\"red\">*</span></li>";
									}else if(tempDisInfos[i].label){
										html+="<li><span class=\"field-middle\" style=\"width:125px;\">"+tempDisInfos[i].name+"</span></li>";
									}else{
										html+="<li id=\""+tempDisInfos[i].key+"\" ><span class=\"field-middle\" style=\"width:125px;\">"+tempDisInfos[i].name+"</span><span>：</span><input type=\"text\" value=\"\" /><span class=\"red\">*</span></li>";
									}
									//alert("name : "+tempDisInfos[i].name+",key : "+tempDisInfos[i].key);
								}
							}
							
							//得到没有关联发现项的脚本参数
							if($("#discoveryTable")){
								var $selectObj = $("#discoveryTable").find("select");
								if($selectObj){
									$selectObj.each(function(){
										if(this.selectedIndex != 0){
											return;
										}
										var unselectName = $("#"+$(this).attr("selectName")).html();
										var unselectKey = $("#"+$(this).attr("selectName")).val();
										var exeist = false;
										if(tempDisInfos){
											for(var i=0;i<tempDisInfos.length;i++){
												if(tempDisInfos[i].key == unselectKey){
													exeist=true;
													break;
												}
											}
										}
										if(!exeist){
											html+="<li><span class=\"field-middle\" style=\"width:125px;\">"+unselectName+"</span><span>：</span><input type=\"text\" value=\"\" /><span class=\"red\">*</span></li>";
										}
									});
								}
							}
							html+="</ul>";
							var panel = new winPanel(
									{title:"预览发现信息",
									html:html,
									width:500,
									cls:"pop-div",
									listeners:{closeAfter:function(){panel = null;}}},{winpanel_DomStruFn:"pop_winpanel_DomStruFn"}); 
							if(selectObjs && selectObjs.length>0){
								for(var z=0;z<selectObjs.length;z++){
									changeHiddenLi(selectObjs[z]);
								}
							}
						}
					}
		});
}

function changeHiddenLi(key){
	if(expandAttributes){
		if(expandAttributes[key]){
			$.each(expandAttributes[key],function(key1,value1){
				if(value1 == 'true'){
					$("#"+key1).show();
				}else{
					$("#"+key1).hide();
				}
			});
		}
	}
}

function showAllLi(){
	$("#allParameterUi").find("li").each(function(){
		$(this).show();
	});
}
