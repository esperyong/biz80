<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!-- 
	author:liuhw
	description:自定义规则
	uri:{domainContextPath}/bizsm/bizservice/ui/bizservicemanager
 -->
<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Untitled Document</title>
<link href="<%=request.getContextPath()%>/css/master.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/css/portal.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/css/portal02.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.4.2.min.js"></script>
<script src="<%=request.getContextPath()%>/js/component/cfncc.js" type="text/javascript"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/bizservice/ajaxcommon.js"></script>

<script>
$(function(){
	var url = "${ctx}/bizservice/<s:property value="serviceId"/>/bizservice-confstatecal/SERIOUS.xml";
	displayPage(url, "error");
	var url = "${ctx}/bizservice/<s:property value="serviceId"/>/bizservice-confstatecal/WARNING.xml";
	displayPage(url, "alarm");
});
$(function(){
	$("#init").click(
			function(){
				var result = window.confirm('按系统默认生成相应规则，并覆盖之前的设置，请确认是否继续？');
				if(result){
					clear();
					var url = "${ctx}/bizservice/<s:property value="serviceId"/>/bizservice-confstatecal/SERIOUS.xml?defaultRule=true";
					displayPage(url, "error");
					var url = "${ctx}/bizservice/<s:property value="serviceId"/>/bizservice-confstatecal/WARNING.xml?defaultRule=true";
					displayPage(url, "alarm");
				}
			}
	);
});
$(
		function(){
			$("#error_add").click(
				function(){
					addErrorRow();
				}
			);
		}
		
);
$(
		function(){
			$("#error_del").click(
				function(){
					deleteErrorRow();
				}
			);
		}
);

$(
		function(){
			$("#alarm_add").click(
				function(){
					addAlarmRow();
				}
			);
		}
		
);
$(
		function(){
			$("#alarm_del").click(
				function(){
					deleteAlarmRow();
				}
			);
		}
);
$(
		function(){
			$("#apply").click(
				function(){
					OK();
				}
			);
		}
);

$(
		function(){
			$("#cancel").click(
				function(){
					window.close();
				}
			);
		}
);

function displayPage(url, type){	
	$.get(url,function(data){
		var andValue = $(data).find('and').text();
		if(type == "error"){
			if(andValue == "true"){
				$('#errorTable').find('*[name="errorGroup"]').get(0).checked = true;
			}else{
				$('#errorTable').find('*[name="errorGroup"]').get(1).checked = true;
			}
		}else{
			if(andValue == "true"){
				$('#alarmTable').find('*[name="alarmGroup"]').get(0).checked = true;
			}else{
				$('#alarmTable').find('*[name="alarmGroup"]').get(1).checked = true;
			}
		}
		
		
		$(data).find('Assertion').each(function(){
			var srcCode = $(this).find('srcCode').text();
			var jsonObj = eval('(' + srcCode + ')');

			addRow(type, jsonObj.displayValue);
			
		});
		
	});
}

function createXML(tableId, groupId){
	var nullObj = $('#'+tableId).find('tr select');
	if(nullObj.size() == 0){
		return '';
	}
	//如果页面上有请选择下拉框，则需要让用户选择真正的值，否则不允许通过（-1为不允许通过）
	var back1 = false;
	var asserts = '';
	var datas = $('#'+tableId).find('tr');
	datas.each(function(i){
		if(back1 == true){
			return;
		}
		var srcCodeMap = {};
		var selArray = new Array();
		var srcVal = '';//用来生成<srcCode/>的值
		var nCount = 0;//每一行select框的计数
		var flag = 'resource';//判断第一列下拉框选择的是资源还是子服务（默认选择资源）
		var srvId = '';//用来生成srcCode的bizserviceid值
		var resId = '';//用来生成srcCode的resinsid值
		var metricId = '';//用来生成srcCode的metricid值
		var childResId = '';//用来生成srcCode的childresinsid值
		var compositestate = '';//用来生成srcCode的compositestate值
		var res_2_select = '';//当第一列下拉框选择的是资源时，用来承载第二列下拉框的值
		var res_5_select = '';//当第一列下拉框选择的是资源时，用来承载第五列下拉框的值
		$(this).find("select").each(function(){
			if(back1 == true){
				return;
			}
			if(this.value == '-1'){
				alert("请选择。");
				$(this).focus();
				back1 = true;
				return;
			}
			
			if(++nCount == 1){
				//当选择的是第一列下拉框时，做如下处理
				var ids = this.value.split("_");
				if(ids[0] == '0'){
					flag = 'service';
					
				}
				srvId = ids[1];
				resId = ids[1];
			}else{
				if(flag == 'service'){
					//处理点击服务		
					//{'bizserviceid':'123','bizservicestate':'SERIOUS'}		
					srcVal = "\'bizserviceid\':\'"+srvId+"\',\'bizservicestate\':\'"+this.value+"\'";
					//构建json对象
					srcCodeMap["bizserviceid"] = srvId;
					srcCodeMap["bizservicestate"] = this.value;
				}else{
					//处理点击资源
					//{'resinsid':'123','compositestate':{'availState':'AVAILABLE','perfState':'PERFMINOR'}}
					//{'resinsid':'123','metricid':'CPU_RATE','compositestate':{'availState':'AVAILABLE','perfState':'PERFMINOR'}}
					//{'resinsid':'123','childresinsid':'123','metricid':'CPU_RATE','compositestate':{'availState':'AVAILABLE','perfState':'PERFMINOR'}}
					//{'resinsid':'123','childresinsid':'123','compositestate':{'availState':'AVAILABLE','perfState':'PERFMINOR'}}
					if(nCount == 2){
						//选择第二列下拉框
						res_2_select = this.value;
					}
					if(res_2_select == 'state'){//当第二列下拉框选择的是状态
						if(nCount == 3){
							var statVals = this.value.split('_');
							if(statVals.length == 1){
								srcVal = "\'resinsid\':\'"+resId+"\',\'compositestate\':{\'availState\':\'"+statVals[0]+"\',\'perfState\':\'PERFUNKNOWN\'}";
								//构建json对象
								srcCodeMap["resinsid"] = resId;
								var stateMap = {};
								stateMap["availState"] = statVals[0];
								stateMap["perfState"] = "PERFUNKNOWN";
								srcCodeMap["compositestate"] = stateMap;
							}else{
								srcVal = "\'resinsid\':\'"+resId+"\',\'compositestate\':{\'availState\':\'"+statVals[0]+"\',\'perfState\':\'"+statVals[1]+"\'}";
								//构建json对象
								srcCodeMap["resinsid"] = resId;
								var stateMap = {};
								stateMap["availState"] = statVals[0];
								stateMap["perfState"] = statVals[1];
								srcCodeMap["compositestate"] = stateMap;
							}
						}
					}else if(res_2_select == 'com'){//当第二列下拉框选择的是组件
						if(nCount == 4){//第四列下拉框
							childResId = this.value;
						}						
						if(nCount == 5){//第五列下拉框
							res_5_select = this.value;
						}
						if(res_5_select == 'state'){//当第五列下拉框选择的是状态
							if(nCount == 6){
								var statVals = this.value.split('_');
								if(statVals.length == 1){
									srcVal = "\'resinsid\':\'"+resId+"\',\'childresinsid\':\'"+childResId+"\',\'compositestate\':{\'availState\':\'"+statVals[0]+"\',\'perfState\':\'PERFUNKNOWN\'}";
									//构建json对象
									srcCodeMap["resinsid"] = resId;
									srcCodeMap["childresinsid"] = childResId;
									var stateMap = {};
									stateMap["availState"] = statVals[0];
									stateMap["perfState"] = "PERFUNKNOWN";
									srcCodeMap["compositestate"] = stateMap;
								}else{
									srcVal = "\'resinsid\':\'"+resId+"\',\'childresinsid\':\'"+childResId+"\',\'compositestate\':{\'availState\':\'"+statVals[0]+"\',\'perfState\':\'"+statVals[1]+"\'}";
									//构建json对象
									srcCodeMap["resinsid"] = resId;
									srcCodeMap["childresinsid"] = childResId;
									var stateMap = {};
									stateMap["availState"] = statVals[0];
									stateMap["perfState"] = statVals[1];
									srcCodeMap["compositestate"] = stateMap;
								}
							}
						}else{//当第五列下拉框选择的是指标
							if(nCount == 6){
								metricId = this.value;
							}
							if(nCount == 7){
								//判断statVal是可用性指标还是性能指标
								var statVals = this.value.split("_");
								var aState = "";
								var pState = "";
								if(statVals[1] == "true"){
									aState = statVals[0];
									pState = "PERFUNKNOWN";
								}else{
									aState = "AVAILABLE";
									pState = statVals[0];
								}
								srcVal = "\'resinsid\':\'"+resId+"\',\'childresinsid\':\'"+childResId+"\',\'metricid\':\'"+metricId+"\',\'compositestate\':{\'availState\':\'"+aState+"\',\'perfState\':\'"+pState+"\'}";
								//构建json对象
								srcCodeMap["resinsid"] = resId;
								srcCodeMap["childresinsid"] = childResId;
								srcCodeMap["metricid"] = metricId;
								var stateMap = {};
								stateMap["availState"] = aState;
								stateMap["perfState"] = pState;
								srcCodeMap["compositestate"] = stateMap;
							}
						}
					}else{//当第二列下拉框选择的是指标
						if(nCount == 3){
							metricId = this.value;
						}
						if(nCount == 4){
							//判断statVal是可用性指标还是性能指标
							var statVals = this.value.split("_");
							var aState = "";
							var pState = "";
							if(statVals[1] == "true"){
								aState = statVals[0];
								pState = "PERFUNKNOWN";
							}else{
								aState = "AVAILABLE";
								pState = statVals[0];
							}
							srcVal = "\'resinsid\':\'"+resId+"\',\'metricid\':\'"+metricId+"\',\'compositestate\':{\'availState\':\'"+aState+"\',\'perfState\':\'"+pState+"\'}";
							//构建json对象
							srcCodeMap["resinsid"] = resId;
							srcCodeMap["metricid"] = metricId;
							var stateMap = {};
							stateMap["availState"] = aState;
							stateMap["perfState"] = pState;
							srcCodeMap["compositestate"] = stateMap;
						}
					}
				}
			}
			selArray.push(this.value);
		});
		if(back1 == true){
			return;
		}
		if(srcVal != ''){
			srcCodeMap["displayValue"] = selArray;
			var srcVal = '';
			var displayValue = '';
			var compositestate = '';
			for(var key in srcCodeMap){
				var arryTmp = srcCodeMap[key];
				if(key == 'displayValue'){
					for(var i = 0; i < arryTmp.length; i++){
						displayValue += "\'"+arryTmp[i]+"\',";
					}
				}else if(key == 'compositestate'){
					//'compositestate':{'availState':'AVAILABLE','perfState':'PERFMINOR'},
					for(var aKey in arryTmp){
						//[{'key':'value'},{'key':'value'}]
						compositestate += "\'"+aKey+"\':\'"+arryTmp[aKey]+"\',";
					}
				}else{
					srcVal += "\'"+key+"\':\'"+ srcCodeMap[key]+"\',";
				}
			}
			if(compositestate != ''){
				srcVal += "\'compositestate\':{"+compositestate.substring(0,compositestate.length-1)+"},"+"\'displayValue\':["+displayValue.substring(0,displayValue.length-1)+"]";
			}else{
				srcVal += "\'displayValue\':["+displayValue.substring(0,displayValue.length-1)+"]";
			}
			asserts+='<Assertion>'+'<srcCode>{'+srcVal+'}</srcCode>'+'</Assertion>';
			
		}
		
 	});

 	if(back1 == true){
		return '';
 	}
 	var xml = '';
 	if(asserts != ''){
 		var andStr = '';
 		var flag = $('input[id='+groupId+']:checked').val();
 	 	if(flag == '0'){
 	 		andStr = '<and>true</and>';
 	 	}else{
 	 		andStr = '<and>false</and>';
 	 	}
 		xml = '<ConfStateCal>'+'<assertions>'+asserts+'</assertions>'+andStr+'</ConfStateCal>';
 	}
	
 	return xml;
} 

function doRequest(method, url, content){
	$.ajax({
		  type: method,
		  url: url,
		  contentType: "application/xml",
		  data: content,
		  processData: false,
		  cache:false,
		  error: function (request) {
			    var errorMessage = request.responseXML;
				var $errorObj = $(errorMessage).find('FieldErrors>FieldError');
				$errorObj.each(function(i){
					var fieldId = $(this).find('FieldId').text();
					var field = document.getElementById(fieldId);
					var errorInfo = $(this).find('ErrorInfo').text();
					alert(errorInfo);
					field.focus();
				});
		  },
		  success: function(msg){
			  
		  }			  		  
	});
}
//判断严重和警告规则中是否有重复记录
function isSame(){
	var flag = false;
	var errorDatas = $('#errorTable').find('tr');
	errorDatas.each(function(i){
		if(i == 0){
			return true;
		}
		if(flag == true){
			return false;
		}
		
		var errorDate = '';
		$(this).find("select").each(function(){
			errorDate += $(this).val();
		});

		var alarmDatas = $('#alarmTable').find('tr');
		alarmDatas.each(function(j){
			if(j == 0){
				return true;
			}
			var alarmDate = '';
			$(this).find("select").each(function(){
				alarmDate += $(this).val();
			});

			if(errorDate == alarmDate){
				flag = true;
				return false;
			}
		});
	});

	return flag;
}

function OK(){
	var errorTableXML = createXML('errorTable', 'errorGroup');
	var alarmTableXML = createXML('alarmTable', 'alarmGroup');
	if(errorTableXML == '' && alarmTableXML == ''){
		alert('请创建自定义规则。');
		return;
	}
	if(errorTableXML == ''){
		alert('请创建严重规则。');
		return;
	}
	if(alarmTableXML == ''){
		alert('请创建警告规则。');
		return;
	}

	var flag = isSame();
	if(flag){
		alert('规则相同');
		return;
	}

	var url = "${ctx}/bizservice/<s:property value="serviceId"/>/bizservice-confstatecal/SERIOUS.xml";
	doRequest('PUT', url, errorTableXML);
	
	var url = "${ctx}/bizservice/<s:property value="serviceId"/>/bizservice-confstatecal/WARNING.xml";
	doRequest('PUT', url, alarmTableXML);

	alert('保存成功。');
}

function addRow(type, selArrayObj) {
	var srvID = $('#serviceId').val();
	var url = "${ctx}/bizsm/rpc/bizstatusdefineservice!queryServiceTopologyByID?serviceId="+srvID;
	$.getJSON(url,{},function(data){ 
		var errorTable = $('#'+type+'Table');
		var rowSize = errorTable.find('tr').size();
		var selectObj = $('<select id='+rowSize+type+'Select1 name='+rowSize+type+'Select1/>');
		var option = $('<option value="-1">请选择</option>');
		selectObj.append(option);
		$.each(data.menu.items,function(i,value){
	          option = $('<option value='+value.value+'>'+value.displayName+'</option>');
	          selectObj.append(option);
       	});
		
		var newRow = $('<tr></tr>');
		var chkTd = $('<td></td>');
		chkTd.attr("width","5%");
		var chkObj = $('<input type=checkbox id='+type+'PropId name='+type+'PropId/>');
		chkTd.append(chkObj);
		newRow.append(chkTd);
		
		var dataTd = $('<td/>');
		dataTd.attr("align","left");
		dataTd.append(selectObj);
		newRow.append(dataTd);
		
		errorTable.append(newRow);
		
		selectObj.change(function(){
			firstSelectChange(this, dataTd, rowSize, type, selArrayObj);
		});	

		if('' != selArrayObj){
			selectObj.find('option').each(function(){
	        	var value = $(this).val();
				if(value == selArrayObj[0])	{
					selectObj.get(0).value = selArrayObj[0];
					selectObj.change();
				}
	        });
		}
	});
}  
function addErrorRow() {
	addRow('error', '');
}
function deleteErrorRow(){
 	$('input[id="errorPropId"]:checked').each(function(){
 	    $(this).parent().parent().remove();
 	});	
}
function addAlarmRow() {
	addRow('alarm', '');
}

function deleteAlarmRow(){
    $('input[id="alarmPropId"]:checked').each(function(){
 	    $(this).parent().parent().remove();
 	});	
}

function clear(){
	$('input[id="errorPropId"]').each(function(){
 	    $(this).parent().parent().remove();
 	});	
	$('input[id="alarmPropId"]').each(function(){
 	    $(this).parent().parent().remove();
 	});	
}

//第一列下来框要触发的Change事件
function firstSelectChange(selectObj, dataTd, rowSize, ruleType, selArrayObj){
	$(selectObj).nextAll().remove();
	var value = selectObj.value;
	var ids = value.split("_");
	var key=ids[0];
		
	if(key == "0"){
		//创建服务对应的下来菜单
		createA1(dataTd, rowSize, ruleType, selArrayObj);
	}else{
		//创建资源对应的下拉菜单
		createA2(ids[1], dataTd, rowSize, ruleType, selArrayObj);
	}
}
//第二列下来框要触发的Change事件
function secondSelectChange(selectObj, resId, dataTd, rowSize, ruleType, selArrayObj){
	$(selectObj).nextAll().remove();
	var value = selectObj.value;
	if(value == "state"){
		//创建状态的下来菜单
		createB1(resId, dataTd, rowSize, ruleType, selArrayObj);
	}else if(value == "com"){
		//创建组件的下来菜单
		createB2(resId, dataTd, rowSize, ruleType, selArrayObj);
	}else {
		//创建指标的下拉菜单
		createB3(resId, dataTd, rowSize, ruleType, selArrayObj);
	}
}
//第三列下来框要触发的Change事件 type 1：组件 2：指标
function thirdSelectChange(selectObj, type, resId, dataTd, rowSize, ruleType, selArrayObj){
	$(selectObj).nextAll().remove();
	//组件类型id或者指标id
	var id = selectObj.value;
	if(type == "0"){
		//创建组件类型对应的下来菜单
		createC1(resId, id, dataTd, rowSize, ruleType, selArrayObj);
	}else{
		//创建点击指标列表对应的下来菜单
		createC2(resId, id, dataTd, rowSize, ruleType, selArrayObj);
	}
}
//第四列下来框要触发的Change事件
function fourthSelectChange(selectObj, resId, comId, dataTd, rowSize, ruleType, selArrayObj){
	$(selectObj).nextAll().remove();
	//创建组件实例对应的下来菜单
	createD(resId, comId, dataTd, rowSize, ruleType, selArrayObj);
}
//第五列下来框要触发的Change事件
function fiveSelectChange(selectObj, resId, comId, dataTd, rowSize, ruleType, selArrayObj){
	$(selectObj).nextAll().remove();
	var key = selectObj.value;
	if(key == "state"){
		//创建组件实例状态对应的下来菜单
		createE1(resId, comId, dataTd, rowSize, ruleType, selArrayObj);
	}else{
		//创建点组件实例指标对应的下来菜单
		createE2(resId, comId, dataTd, rowSize, ruleType, selArrayObj);
	}
}
//第六列下来框要触发的Change事件
function sixSelectChange(selectObj, resId, comId, dataTd, rowSize, ruleType, selArrayObj){
	$(selectObj).nextAll().remove();
	var comMetricId = selectObj.value;
	createF(comMetricId, resId, comId, dataTd, rowSize, ruleType, selArrayObj);
}

//创建服务对应的下来菜单
function createA1(dataTd, rowSize, ruleType, selArrayObj) {
	var option1 = $('<option value="-1">请选择</option>');
	var option2 = $('<option value="SERIOUS">严重</option>');
	var option3 = $('<option value="WARNING">警告</option>');
	var selectObj = $('<select id='+rowSize+ruleType+'Select2 name='+rowSize+ruleType+'Select2/>');
	selectObj.append(option1);
	selectObj.append(option2);
	selectObj.append(option3);

	dataTd.append(selectObj);
	
	selectObj.change(function(){
    });
    if('' != selArrayObj){
    	selectObj.find('option').each(function(){
        	var value = $(this).val();
			if(value == selArrayObj[1])	{
				selectObj.get(0).value = selArrayObj[1];
			}
        });
    }
}
//创建资源对应的下拉菜单
function createA2(resId, dataTd, rowSize, ruleType, selArrayObj) {
	var option1 = $('<option value="-1">请选择</option>');
	var option2 = $('<option value="state">状态</option>');
	var option3 = $('<option value="com">组件</option>');
	var option4 = $('<option value="metric">指标</option>');
	var selectObj = $('<select id='+rowSize+ruleType+'Select name='+rowSize+ruleType+'Select2/>');
	selectObj.append(option1);
	selectObj.append(option2);
	selectObj.append(option3);
	selectObj.append(option4);

	dataTd.append(selectObj);
	
	selectObj.change(function(){
		secondSelectChange(this, resId, dataTd, rowSize, ruleType, selArrayObj);
    });

	if('' != selArrayObj){
		selectObj.find('option').each(function(){
        	var value = $(this).val();
			if(value == selArrayObj[1])	{
				selectObj.get(0).value = selArrayObj[1];
				selectObj.change();
			}
        });
		//selectObj.get(0).value = selArrayObj[1];
		//selectObj.change();
    }
}
//创建资源对应状态的下拉菜单
function createB1(resId, dataTd, rowSize, ruleType, selArrayObj) {
	var option1 = $('<option value="-1">请选择</option>');
	var option2 = $('<option value="UNAVAILABLE">不可用</option>');
	var option3 = $('<option value="AVAILUNKNOWN">可用性未知</option>');
	var option4 = $('<option value="AVAILABLE_PERFSERIOUS">资源可用，资源或其组件性能严重超标或某些组件不可用</option>');
	var option5 = $('<option value="AVAILABLE_PERFMINOR">资源可用，资源或其组件性能轻微超标</option>');
	var option6 = $('<option value="AVAILABLE_PERFUNKNOWN">资源可用，资源或其组件性能未知</option>');
	var selectObj = $('<select id='+rowSize+ruleType+'Select3 name='+rowSize+ruleType+'Select3/>');
	selectObj.append(option1);
	selectObj.append(option2);
	selectObj.append(option3);
	selectObj.append(option4);
	selectObj.append(option5);
	selectObj.append(option6);

	dataTd.append(selectObj);
	
	selectObj.change(function(){
    });

	if('' != selArrayObj){
		selectObj.find('option').each(function(){
        	var value = $(this).val();
			if(value == selArrayObj[2])	{
				selectObj.get(0).value = selArrayObj[2];
				selectObj.change();
			}
        });
    }
}
//创建资源对应组件的下拉菜单
function createB2(resId, dataTd, rowSize, ruleType, selArrayObj) {
	var url = "${ctx}/bizsm/rpc/bizstatusdefineservice!queryResourceComTypeByResourceId?resourceId="+resId;
	$.getJSON(url,{},function(data){

		var selectObj = $('<select id='+rowSize+ruleType+'Select3 name='+rowSize+ruleType+'Select3/>');
		var option = $('<option value="-1">请选择</option>');
		selectObj.append(option);
		$.each(data.menu.items,function(i,value){
	          option = $('<option value='+value.value+'>'+value.displayName+'</option>');
	          selectObj.append(option);
       	});
       	
		dataTd.append(selectObj);
		
		selectObj.change(function(){
			thirdSelectChange(this, 0, resId, dataTd, rowSize, ruleType, selArrayObj);
		});	

		if('' != selArrayObj){
			selectObj.find('option').each(function(){
	        	var value = $(this).val();
				if(value == selArrayObj[2])	{
					selectObj.get(0).value = selArrayObj[2];
					selectObj.change();
				}
	        });
	    }
	});
	
}
//创建资源对应指标的下拉菜单
function createB3(resId, dataTd, rowSize, ruleType, selArrayObj) {
	var url = "${ctx}/bizsm/rpc/bizstatusdefineservice!queryResourceMetricListByResourceId?resourceId="+resId;
	$.getJSON(url,{},function(data){

		var selectObj = $('<select id='+rowSize+ruleType+'Select3 name='+rowSize+ruleType+'Select3/>');
		var option = $('<option value="-1">请选择</option>');
		selectObj.append(option);
		$.each(data.menu.items,function(i,value){
	          option = $('<option value='+value.value+'>'+value.displayName+'</option>');
	          selectObj.append(option);
       	});

		dataTd.append(selectObj);
		
		selectObj.change(function(){
			thirdSelectChange(this, 1, resId, dataTd, rowSize, ruleType, selArrayObj);
	    });

		if('' != selArrayObj){
			selectObj.find('option').each(function(){
	        	var value = $(this).val();
				if(value == selArrayObj[2])	{
					selectObj.get(0).value = selArrayObj[2];
					selectObj.change();
				}
	        });
	    }
	});
}
//创建组件类型对应的下来菜单
function createC1(resId, comId, dataTd, rowSize, ruleType, selArrayObj){
	var url = "${ctx}/bizsm/rpc/bizstatusdefineservice!queryComResInstanceByResIdAndComId?resourceId="+resId+"&comId="+comId;
	$.getJSON(url,{},function(data){

		var selectObj = $('<select id='+rowSize+ruleType+'Select4 name='+rowSize+ruleType+'Select4/>');
		var option = $('<option value="-1">请选择</option>');
		selectObj.append(option);
		$.each(data.menu.items,function(i,value){
	          option = $('<option value='+value.value+'>'+value.displayName+'</option>');
	          selectObj.append(option);
       	});
		
		dataTd.append(selectObj);
	
		selectObj.change(function(){
			fourthSelectChange(this, resId, comId, dataTd, rowSize, ruleType, selArrayObj);
		});	

		if('' != selArrayObj){
			selectObj.find('option').each(function(){
	        	var value = $(this).val();
				if(value == selArrayObj[3])	{
					selectObj.get(0).value = selArrayObj[3];
					selectObj.change();
				}
	        });
	    }	
	});
}

//创建点击指标列表对应的下来菜单
function createC2(resId, metricId, dataTd, rowSize, ruleType, selArrayObj){
	var option1 = $('<option value="-1">请选择</option>');
	var option2 = $('<option value="UNAVAILABLE">不可用</option>');
	var option3 = $('<option value="PERFSERIOUS">严重超标</option>');
	var option4 = $('<option value="PERFMINOR">轻微超标</option>');
	var selectObj = $('<select id='+rowSize+ruleType+'Select4 name='+rowSize+ruleType+'Select4/>');

	selectObj.append(option1);

	var states = metricId.split("_");
	
	if(states[1] == "true"){
		selectObj.append(option2);
	}else{
		selectObj.append(option3);
		selectObj.append(option4);
	}

	dataTd.append(selectObj);
	
	selectObj.change(function(){
    });

	if('' != selArrayObj){
		selectObj.find('option').each(function(){
        	var value = $(this).val();
			if(value == selArrayObj[3])	{
				selectObj.get(0).value = selArrayObj[3];
				selectObj.change();
			}
        });
    }	
}
//创建组件实例对应的下来菜单
function createD(resId, comId, dataTd, rowSize, ruleType, selArrayObj){
	var option1 = $('<option value="-1">请选择</option>');
	var option2 = $('<option value="state">状态</option>');
	var option3 = $('<option value="metric">指标</option>');
	var selectObj = $('<select id='+rowSize+ruleType+'Select5 name='+rowSize+ruleType+'Select5/>');

	selectObj.append(option1);
	selectObj.append(option2);
	selectObj.append(option3);

	dataTd.append(selectObj);
	
	selectObj.change(function(){
		fiveSelectChange(this, resId, comId, dataTd, rowSize, ruleType, selArrayObj);
    });

	if('' != selArrayObj){
		selectObj.find('option').each(function(){
        	var value = $(this).val();
			if(value == selArrayObj[4])	{
				selectObj.get(0).value = selArrayObj[4];
				selectObj.change();
			}
        });
    }
}
//创建组件实例状态对应的下来菜单
function createE1(resId, comId, dataTd, rowSize, ruleType, selArrayObj){
	var option1 = $('<option value="-1">请选择</option>');
	var option2 = $('<option value="UNAVAILABLE">不可用</option>');
	var option3 = $('<option value="AVAILUNKNOWN">可用性未知</option>');
	var option4 = $('<option value="AVAILABLE_PERFSERIOUS">可用，性能严重超标</option>');
	var option5 = $('<option value="AVAILABLE_PERFMINOR">可用，性能轻微超标</option>');
	var option6 = $('<option value="AVAILABLE_PERFUNKNOWN">可用，性能未知</option>');
	var selectObj = $('<select id='+rowSize+ruleType+'Select6 name='+rowSize+ruleType+'Select6/>');

	selectObj.append(option1);
	selectObj.append(option2);
	selectObj.append(option3);
	selectObj.append(option4);
	selectObj.append(option5);
	selectObj.append(option6);

	dataTd.append(selectObj);
	
	selectObj.change(function(){
    });

	if('' != selArrayObj){
		selectObj.find('option').each(function(){
        	var value = $(this).val();
			if(value == selArrayObj[5])	{
				selectObj.get(0).value = selArrayObj[5];
				selectObj.change();
			}
        });
    }
}
//创建点组件实例指标对应的下来菜单
function createE2(resId, comId, dataTd, rowSize, ruleType, selArrayObj){
	var url = "${ctx}/bizsm/rpc/bizstatusdefineservice!queryResourceMetricListByResourceId?resourceId="+comId;
	$.getJSON(url,{},function(data){

		var selectObj = $('<select id='+rowSize+ruleType+'Select6 name='+rowSize+ruleType+'Select6/>');
		var option = $('<option value="-1">请选择</option>');
		selectObj.append(option);
		$.each(data.menu.items,function(i,value){
	          option = $('<option value='+value.value+'>'+value.displayName+'</option>');
	          selectObj.append(option);
       	});

		dataTd.append(selectObj);
	
		selectObj.change(function(){
			sixSelectChange(this, resId, comId, dataTd, rowSize, ruleType, selArrayObj);
		});	

		if('' != selArrayObj){
			selectObj.find('option').each(function(){
	        	var value = $(this).val();
				if(value == selArrayObj[5])	{
					selectObj.get(0).value = selArrayObj[5];
					selectObj.change();
				}
	        });
	    }	
	});
}

function createF(comMetricId, resId, comId, dataTd, rowSize, ruleType, selArrayObj){
	var option1 = $('<option value="-1">请选择</option>');
	var option2 = $('<option value="UNAVAILABLE">不可用</option>');
	var option3 = $('<option value="PERFSERIOUS">严重超标</option>');
	var option4 = $('<option value="PERFMINOR">轻微超标</option>');
	var selectObj = $('<select id='+rowSize+ruleType+'Select7 name='+rowSize+ruleType+'Select7/>');

	selectObj.append(option1);
	var states = comMetricId.split("_");
	
	if(states[1] == "true"){
		selectObj.append(option2);
	}else{
		selectObj.append(option3);
		selectObj.append(option4);
	}

	dataTd.append(selectObj);
	
	selectObj.change(function(){
    });

	if('' != selArrayObj){
		selectObj.find('option').each(function(){
        	var value = $(this).val();
			if(value == selArrayObj[6])	{
				selectObj.get(0).value = selArrayObj[6];
				selectObj.change();
			}
        });
    }
}
</script>
</head>
<body  class="pop-window">
<form name="customForm">
<input id="serviceId" name="serviceId" type="hidden" value="<s:property value="serviceId"/>"/>
<div class="pop" style="width:500px;height:700px">
  <div class="pop-top-l">
    <div class="pop-top-r">
      <div class="pop-top-m"> <a id="cancel" class="win-ico win-close"></a> <span class="pop-top-title">自定义规则 </span> </div>
    </div>
  </div>
  <div class="pop-m">
    <div class="pop-content">
      <div class="set-panel02-content-white" style="height:486px"> <span class="r-big-ico r-big-ico-help"></span> <span class="win-button"><span class="win-button-border"><a id="init">默认</a></span></span>
        <div class="clear"></div>
        <div class="sub-panel-open">
          <div class="sub-panel-top"> <span id="error_del" class="r-ico r-ico-close"></span> <span id="error_add" class="r-ico r-ico-add"></span><span class="light-ico light-ico-red"></span> <span class="sub-panel-title">严重</span></div>
          <div class="sub-panel-content">
            <table id="errorTable" border="0" cellpadding="0" cellspacing="0" class="table">
              <tr><td colspan="2">请选择逻辑关系：
              <label><input type="radio" id="errorGroup" name="errorGroup" value="0" checked/>并</label>
              <label><input type="radio" id="errorGroup" name="errorGroup" value="1" />或</label></td></tr>
            </table>
          </div>
        </div>
		<div class="sub-panel-open">
          <div class="sub-panel-top"> <span id="alarm_del" class="r-ico r-ico-close"></span> <span id="alarm_add" class="r-ico r-ico-add"></span><span class="light-ico light-ico-yellow"></span> <span class="sub-panel-title">警告</span></div>
          <div class="sub-panel-content">
            <table id="alarmTable" border="0" cellpadding="0" cellspacing="0" class="table">
              <tr><td colspan="2">请选择逻辑关系：
                <label><input type="radio" id="alarmGroup" name="alarmGroup" value="0" checked />并</label>
                <label><input type="radio" id="alarmGroup" name="alarmGroup" value="1" />或</label></td></tr>
            </table>
          </div>
        </div>
        <div class="sub-panel-open">
          <div class="sub-panel-top"><span class="light-ico light-ico-green"></span> <span class="sub-panel-title">正常：当不符合严重、警告时服务状态为正常。</span></div>
         
        </div>
      </div>
    </div>
  </div>
  <div class="pop-bottom-l">
    <div class="pop-bottom-r">
      <div class="pop-bottom-m"> <span class="win-button"><span class="win-button-border"><a id="cancel">取消</a></span></span> <span class="win-button"><span class="win-button-border"><a id="apply">确定</a></span></span> </div>
    </div>
  </div>
</div>
</form>
</body>
</html>