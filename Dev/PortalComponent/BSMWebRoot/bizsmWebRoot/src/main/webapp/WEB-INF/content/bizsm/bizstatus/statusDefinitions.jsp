<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!--
	author:liuhw
	description:自定义规则
	uri:{domainContextPath}/bizsm/bizservice/ui/bizservicemanager
 -->
<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>规则设定</title>
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/portal.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/portal02.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />

<style type="text/css">
	html,body{height:100%;width:100%}
</style>


<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery.blockUI.js"></script>
<script src="${ctx}/js/component/cfncc.js" type="text/javascript"></script>
<script src="${ctx}/js/component/popwin.js" type="text/javascript"></script>
<script src="${ctx}/js/component/toast/Toast.js" type="text/javascript"></script>

<script type="text/javascript" src="${ctx}/js/bizservice/ajaxcommon.js"></script>
<script>
var confirmConfig = {width: 300,height: 80};
var realWidth = 0, realHeight = 0;

var helpShowState_global = false;

var toast  = null;

$(function(){
	toast = new Toast({position:"CT"});
	realWidth = document.body.clientWidth;
	realHeight = document.body.clientHeight;
	//alert(realHeight);
	$('#statusPanel').css({height:"95%",overflowY:"auto",overflowX:"hidden"});

	$('#defaultStatusContent,#userDefineStatusContent').hide();
	//

	$('#statusHelpPanel_div').css({position:"absolute",top:"15px",right:"120px",zIndex:"100"});

	$('#statusHelp_span').click(function(event){
		event.stopPropagation();

		if(helpShowState_global == false){
			$('#statusHelpPanel_div').slideDown(300, function(){
				helpShowState_global = true;
			});
		}else{
			$('#statusHelpPanel_div').slideUp(300, function(){
				helpShowState_global = false;
			});
		}
	});


	$('body').click(function(event){
		helpShowState_global = false;
		$('#statusHelpPanel_div').slideUp();
	});

	$("#init").click(function(){
		/*var result = window.confirm('按系统默认生成相应规则，并覆盖之前的设置，请确认是否继续？');
		if(result){
			clear();
			var url = '${ctx}/bizservice/<s:property value="serviceId"/>/bizservice-confstatecal/SERIOUS.xml?defaultRule=true';
			displayPage(url, "error");
			var url = '${ctx}/bizservice/<s:property value="serviceId"/>/bizservice-confstatecal/WARNING.xml?defaultRule=true';
			displayPage(url, "alarm");
		}*/

		var _confirm = top.confirm_box(confirmConfig);
		_confirm.setContentText("按系统默认生成相应规则，并覆盖之前的设置，请确认是否继续？"); //提示框
		_confirm.show();
		_confirm.setConfirm_listener(function() {
			_confirm.hide();
			clear();
			var url = '${ctx}/bizservice/<s:property value="serviceId"/>/bizservice-confstatecal/SERIOUS.xml?defaultRule=true';
			displayPage(url, "error");
			var url = '${ctx}/bizservice/<s:property value="serviceId"/>/bizservice-confstatecal/WARNING.xml?defaultRule=true';
			displayPage(url, "alarm");
		});
		_confirm.setCancle_listener(function(){
			_confirm.hide();
		});
	});

	$("#error_add").click(function(){
		addErrorRow();
	});
	$("#error_del").click(function(){
		var dataNum = $('input[id="errorPropId"]').size();
		if(dataNum == 0){
			var _information  = top.information();
			_information.setContentText("没有要删除的记录。");
			_information.show();
			return;
		}
		var checkNum = $('input[id="errorPropId"]:checked').size();
		if(checkNum == 0){
			var _information  = top.information();
			_information.setContentText("请至少选择一项严重规则。");
			_information.show();
			return;
		}
		var _confirm = top.confirm_box(confirmConfig);
		_confirm.setContentText("此操作不可恢复，是否确认执行？"); //提示框
		_confirm.show();
		_confirm.setConfirm_listener(function() {
			_confirm.hide();
			deleteErrorRow();
		});
		_confirm.setCancle_listener(function(){
			_confirm.hide();
		});

	});
	$("#alarm_add").click(function(){
		addAlarmRow();
	});
	$("#alarm_del").click(function(){
		var dataNum = $('input[id="alarmPropId"]').size();
		if(dataNum == 0){
			var _information  = top.information();
			_information.setContentText("没有要删除的记录。");
			_information.show();
			return;
		}
		var checkNum = $('input[id="alarmPropId"]:checked').size();
		if(checkNum == 0){
			var _information  = top.information();
			_information.setContentText("请至少选择一项警告规则。");
			_information.show();
			return;
		}
		var _confirm = top.confirm_box(confirmConfig);
		_confirm.setContentText("此操作不可恢复，是否确认执行？"); //提示框
		_confirm.show();
		_confirm.setConfirm_listener(function() {
			_confirm.hide();
			deleteAlarmRow();
		});
		_confirm.setCancle_listener(function(){
			_confirm.hide();
		});

	});

	//

	$("#apply").click(function(){

		$.blockUI({message:$('#loading')});

		var ruleChked = $($('input[name="rule"]').get(1)).attr("checked");
		if(ruleChked){
			var result = f_userDefineRuleSave();
			if(result){
				f_globalApplySave();
			}
		}else{
			f_globalApplySave();
		}

		$.unblockUI() ;
	});

	//为slab添加展开效果
	$('#defaultStatusSlab').toggle(function(){
		var $this = $(this);
		var $content = $('#defaultStatusContent');
		$content.slideDown(300, function(){
			$this.removeClass("ico-plus").addClass("ico-minus");
		});
	}, function(){
		var $this = $(this);
		var $content = $('#defaultStatusContent');
		$content.slideUp(300, function(){
			$this.removeClass("ico-minus").addClass("ico-plus");
		});
	});

	$('#userDefineStatusSlab').toggle(function(){
		var $this = $(this);
		var $content = $('#userDefineStatusContent');
		$content.slideDown(300, function(){
			$this.removeClass("ico-plus").addClass("ico-minus");
		});
	}, function(){
		var $this = $(this);
		var $content = $('#userDefineStatusContent');
		$content.slideUp(300, function(){
			$this.removeClass("ico-minus").addClass("ico-plus");
		});
	});

	var url = '${ctx}/bizservice/<s:property value="serviceId"/>/bizservice-confstatecal/SERIOUS.xml';
	displayPage(url, "error");
	var url = '${ctx}/bizservice/<s:property value="serviceId"/>/bizservice-confstatecal/WARNING.xml';
	displayPage(url, "alarm");

	$('#defaultStatusSlab').click();



});

function f_globalApplySave(){
	var value = $('input[name="rule"]:checked').val();
	//默认选择默认规则
	var rule = "false";
	if(value == "1"){
		rule = "true";
	}
	var data = "<BizService><confStateCal>"+rule+"</confStateCal></BizService>";
	//alert(data);
	var srvId = "<s:property value="model.bizId"/>";

	$.ajax({
		  type: 'PUT',
		  url: "${ctx}/bizservice/" + srvId,
		  contentType: "application/xml",
		  data: data,
		  processData: false,
		  cache:false,
		  error: function (request) {
				var errorMessage = request.responseXML;
				var $errorObj = $(errorMessage).find('FieldErrors>FieldError');
				$errorObj.each(function(i){
					var fieldId = $(this).find('FieldId').text();
					var field = document.getElementById(fieldId);
					var errorInfo = $(this).find('ErrorInfo').text();
					//alert(errorInfo);
					var _information  = top.information();
					_information.setContentText(errorInfo);
					_information.show();
					field.focus();
				});
		  },
		  success: function(msg){
			  //alert('保存成功!');
			  //var _information  = top.information();
			  //_information.setContentText("保存成功!");
			  //_information.show();
			  toast.addMessage("保存成功!");
		  }
	});
}

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
				//alert("请选择。");
				var _information  = top.information();
			    _information.setContentText("请选择。");
			    _information.show();
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
								var statVals = metricId.split("_");
								var aState = "";
								var pState = "";
								//wangzhenyu delete
								if(statVals[statVals.length-1] == "true"){
									aState = "AVAILABLE";
									pState = this.value;
								}else{
									aState = "AVAILUNKNOWN";
									pState = this.value;
								}

								//aState = "AVAILABLE";
								//pState = this.value;

								srcVal = "\'resinsid\':\'"+resId+"\',\'childresinsid\':\'"+childResId+"\',\'metricid\':\'"+metricId.substring(0,metricId.lastIndexOf('_'))+"\',\'compositestate\':{\'availState\':\'"+aState+"\',\'perfState\':\'"+pState+"\'}";

								//构建json对象
								srcCodeMap["resinsid"] = resId;
								srcCodeMap["childresinsid"] = childResId;
								srcCodeMap["metricid"] = metricId.substring(0,metricId.lastIndexOf('_'));
								var stateMap = {};
								stateMap["availState"] = aState;
								stateMap["perfState"] = pState;
								srcCodeMap["compositestate"] = stateMap;
							}
						}
					}else{//当第二列下拉框选择的是指标
						if(nCount == 3){
							metricId = this.value;
							//metricId.substring(0,this.value.lastIndexOf("_"))
						}
						if(nCount == 4){
							//判断statVal是可用性指标还是性能指标
							var statVals = metricId.split("_");
							var aState = "";
							var pState = "";

							if(statVals[statVals.length-1] == "true"){
								aState = "AVAILABLE";
								pState = this.value;
							}else{
								aState = "AVAILUNKNOWN";
								pState = this.value;
							}

							//aState = "AVAILABLE";
							//pState = this.value;

							srcVal = "\'resinsid\':\'"+resId+"\',\'metricid\':\'"+metricId.substring(0,metricId.lastIndexOf('_'))+"\',\'compositestate\':{\'availState\':\'"+aState+"\',\'perfState\':\'"+pState+"\'}";

							//构建json对象
							srcCodeMap["resinsid"] = resId;
							srcCodeMap["metricid"] = metricId.substring(0,metricId.lastIndexOf('_'));
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
					//alert(errorInfo);
					var _information  = top.information();
					_information.setContentText(errorInfo);
					_information.show();
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

function f_userDefineRuleSave(){
	var errorTableXML = createXML('errorTable', 'errorGroup');
	var alarmTableXML = createXML('alarmTable', 'alarmGroup');
	if(errorTableXML == '' && alarmTableXML == ''){
		//alert('请创建自定义规则。');
		var _information  = top.information();
		_information.setContentText("请创建自定义规则。");
		_information.show();
		return false;
	}
	if(errorTableXML == ''){
		//alert('请创建严重规则。');
		var _information  = top.information();
		_information.setContentText("请创建严重规则。");
		_information.show();
		return false;
	}
	if(alarmTableXML == ''){
		//alert('请创建警告规则。');
		var _information  = top.information();
		_information.setContentText("请创建警告规则。");
		_information.show();
		return false;
	}

	var flag = isSame();
	//wangzenyu delete
	/*if(flag){
		//alert('规则相同');
		var _information  = top.information();
		_information.setContentText("规则相同");
		_information.show();
		return false;
	}*/

	var url = '${ctx}/bizservice/<s:property value="serviceId"/>/bizservice-confstatecal/SERIOUS.xml';
	doRequest('PUT', url, errorTableXML);

	var url = '${ctx}/bizservice/<s:property value="serviceId"/>/bizservice-confstatecal/WARNING.xml';
	doRequest('PUT', url, alarmTableXML);

	return true;
	//alert('保存成功。');
}

function addRow(type, selArrayObj) {
	var srvID = $('#serviceId').val();
	var url = "${ctx}/bizsm/rpc/bizstatusdefineservice!queryServiceTopologyByID?serviceId="+srvID;
	$.getJSON(url,{},function(data){
		var errorTable = $('#'+type+'Table');
		var rowSize = errorTable.find('tr').size();
		var selectObj = $('<select id='+rowSize+type+'Select1 name='+rowSize+type+'Select1 style="width:120px"/>');
		var option = $('<option value="-1">请选择</option>');
		selectObj.append(option);
		$.each(data.menu.items,function(i,value){
	          option = $('<option value='+value.value+' title="'+value.displayName+'">'+value.displayName+'</option>');
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

		selectObj.one("change",function(){
			firstSelectChange(this, dataTd, rowSize, type, selArrayObj);
		});

		if('' != selArrayObj){
			selectObj.find('option').each(function(i){
	        	var value = $(this).val();
				if(value == selArrayObj[0])	{
					errorTable.append(newRow);
					//selectObj.get(0).value = selArrayObj[0];
					selectObj.get(0).selectedIndex = i;
					selectObj.change();

					selectObj.bind("change",function(){
						firstSelectChange(this, dataTd, rowSize, type, "");
					});
				}
	        });
		}else{
			errorTable.append(newRow);
			selectObj.bind("change",function(){
				firstSelectChange(this, dataTd, rowSize, type, "");
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
	if(value == "-1"){
		return;
	}
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
	if(value == "-1"){
		return;
	}
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
	if(id == "-1"){
		return;
	}
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
	var id = selectObj.value;
	if(id == "-1"){
		return;
	}
	createD(resId, id, dataTd, rowSize, ruleType, selArrayObj);
}
//第五列下来框要触发的Change事件
function fiveSelectChange(selectObj, resId, comId, dataTd, rowSize, ruleType, selArrayObj){
	$(selectObj).nextAll().remove();
	var key = selectObj.value;
	if(key == "-1"){
		return;
	}
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
	if(comMetricId == "-1"){
		return;
	}
	createF(comMetricId, resId, comId, dataTd, rowSize, ruleType, selArrayObj);
}

//创建服务对应的下来菜单
function createA1(dataTd, rowSize, ruleType, selArrayObj) {
	var option1 = $('<option value="-1">请选择</option>');
	var option2 = $('<option value="SERIOUS" >严重</option>');
	var option3 = $('<option value="WARNING">警告</option>');
	var selectObj = $('<select id='+rowSize+ruleType+'Select2 name='+rowSize+ruleType+'Select2/>');
	selectObj.append(option1);
	selectObj.append(option2);
	selectObj.append(option3);

	dataTd.append(selectObj);

	selectObj.change(function(){
    });
    if('' != selArrayObj){
    	selectObj.find('option').each(function(i){
        	var value = $(this).val();
			if(value == selArrayObj[1])	{
				//selectObj.get(0).value = selArrayObj[1];
				selectObj.get(0).selectedIndex = i;
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
		selectObj.find('option').each(function(i){
        	var value = $(this).val();
			if(value == selArrayObj[1])	{
				//selectObj.get(0).value = selArrayObj[1];
				selectObj.get(0).selectedIndex = i;
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
	var option4 = $('<option value="AVAILABLE_PERFSERIOUS" title="可用但性能严重超标或组件不可用">可用但性能严重超标或组件不可用</option>');
	var option5 = $('<option value="AVAILABLE_PERFMINOR" title="可用但性能轻微超标">可用但性能轻微超标</option>');
	var option6 = $('<option value="AVAILABLE_PERFUNKNOWN" title="可用但性能未知或组件性能未知">可用但性能未知或组件性能未知</option>');
	var selectObj = $('<select id='+rowSize+ruleType+'Select3 name='+rowSize+ruleType+'Select3 style="width:120px"/>');
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
		selectObj.find('option').each(function(i){
        	var value = $(this).val();
			if(value == selArrayObj[2])	{
				//selectObj.get(0).value = selArrayObj[2];
				selectObj.get(0).selectedIndex = i;
				selectObj.change();
			}
        });
    }
}
//创建资源对应组件的下拉菜单
function createB2(resId, dataTd, rowSize, ruleType, selArrayObj) {
	var url = "${ctx}/bizsm/rpc/bizstatusdefineservice!queryResourceComTypeByResourceId?resourceId="+resId;
	$.getJSON(url,{},function(data){

		var selectObj = $('<select id='+rowSize+ruleType+'Select3 name='+rowSize+ruleType+'Select3 style="width:120px"/>');
		var option = $('<option value="-1">请选择</option>');
		selectObj.append(option);
		$.each(data.menu.items,function(i,value){
	          option = $('<option value='+value.value+' title="'+value.displayName+'">'+value.displayName+'</option>');
	          selectObj.append(option);
       	});

		dataTd.append(selectObj);

		selectObj.change(function(){
			thirdSelectChange(this, 0, resId, dataTd, rowSize, ruleType, selArrayObj);
		});

		if('' != selArrayObj){
			selectObj.find('option').each(function(i){
	        	var value = $(this).val();
				if(value == selArrayObj[2])	{
					//selectObj.get(0).value = selArrayObj[2];
					selectObj.get(0).selectedIndex = i;
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

		var selectObj = $('<select id='+rowSize+ruleType+'Select3 name='+rowSize+ruleType+'Select3 style="width:120px"/>');
		var option = $('<option value="-1">请选择</option>');
		selectObj.append(option);
		$.each(data.menu.items,function(i,value){
	          option = $('<option value='+value.value+' title="'+value.displayName+'">'+value.displayName+'</option>');
	          selectObj.append(option);
       	});

		dataTd.append(selectObj);

		selectObj.change(function(){
			thirdSelectChange(this, 1, resId, dataTd, rowSize, ruleType, selArrayObj);
	    });

		if('' != selArrayObj){
			selectObj.find('option').each(function(i){
	        	var value = $(this).val();
				if(value == selArrayObj[2])	{
					//selectObj.get(0).value = selArrayObj[2];
					selectObj.get(0).selectedIndex = i;
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

		var selectObj = $('<select id='+rowSize+ruleType+'Select4 name='+rowSize+ruleType+'Select4 style="width:120px"/>');
		var option = $('<option value="-1">请选择</option>');
		selectObj.append(option);
		$.each(data.menu.items,function(i,value){
	          option = $('<option value='+value.value+' title="'+value.displayName+'">'+value.displayName+'</option>');
	          selectObj.append(option);
       	});

		dataTd.append(selectObj);

		selectObj.change(function(){
			fourthSelectChange(this, resId, comId, dataTd, rowSize, ruleType, selArrayObj);
		});

		if('' != selArrayObj){
			selectObj.find('option').each(function(i){
	        	var value = $(this).val();
				if(value == selArrayObj[3])	{
					//selectObj.get(0).value = selArrayObj[3];
					selectObj.get(0).selectedIndex = i;
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
		selectObj.find('option').each(function(i){
        	var value = $(this).val();
			if(value == selArrayObj[3])	{
				//selectObj.get(0).value = selArrayObj[3];
				selectObj.get(0).selectedIndex = i;
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
		selectObj.find('option').each(function(i){
        	var value = $(this).val();
			if(value == selArrayObj[4])	{
				//selectObj.get(0).value = selArrayObj[4];
				selectObj.get(0).selectedIndex = i;
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
	var option4 = $('<option value="AVAILABLE_PERFSERIOUS" title="可用但性能严重超标">可用但性能严重超标</option>');
	var option5 = $('<option value="AVAILABLE_PERFMINOR" title="可用但性能严重超标">可用但性能轻微超标</option>');
	var option6 = $('<option value="AVAILABLE_PERFUNKNOWN" title="可用但性能未知">可用但性能未知</option>');
	var selectObj = $('<select id='+rowSize+ruleType+'Select6 name='+rowSize+ruleType+'Select6 style="width:120px"/>');

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
		selectObj.find('option').each(function(i){
        	var value = $(this).val();
			if(value == selArrayObj[5])	{
				//selectObj.get(0).value = selArrayObj[5];
				selectObj.get(0).selectedIndex = i;
				selectObj.change();
			}
        });
    }
}
//创建点组件实例指标对应的下来菜单
function createE2(resId, comId, dataTd, rowSize, ruleType, selArrayObj){
	var url = "${ctx}/bizsm/rpc/bizstatusdefineservice!queryResourceMetricListByResourceId?resourceId="+comId;
	$.getJSON(url,{},function(data){

		var selectObj = $('<select id='+rowSize+ruleType+'Select6 name='+rowSize+ruleType+'Select6 style="width:120px"/>');
		var option = $('<option value="-1">请选择</option>');
		selectObj.append(option);
		$.each(data.menu.items,function(i,value){
	          option = $('<option value='+value.value+' title="'+value.displayName+'">'+value.displayName+'</option>');
	          selectObj.append(option);
       	});

		dataTd.append(selectObj);

		selectObj.change(function(){
			sixSelectChange(this, resId, comId, dataTd, rowSize, ruleType, selArrayObj);
		});

		if('' != selArrayObj){
			selectObj.find('option').each(function(i){
	        	var value = $(this).val();
				if(value == selArrayObj[5])	{
					//selectObj.get(0).value = selArrayObj[5];
					selectObj.get(0).selectedIndex = i;
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
		selectObj.find('option').each(function(i){
        	var value = $(this).val();
			if(value == selArrayObj[6])	{
				//selectObj.get(0).value = selArrayObj[6];
				selectObj.get(0).selectedIndex = i;
				selectObj.change();
			}
        });
    }
}

</script>
</head>
<body>
<input id="serviceId" name="serviceId" type="hidden" value="<s:property value="serviceId"/>"/>
<div id="statusPanel" class="div-zt">
  <div class="table-zt">
	<div class="blackbg"><span class="left margin3"><span id="defaultStatusSlab" class="ico ico-minus"></span><input name="rule" type="radio" value="0" <s:if test="model.confStateCal != true">checked</s:if>/>系统默认规则</span><span class="shuoming sub-panel-tips">通过服务包含的资源，子服务状态自动计算服务状态，不可编辑。</span></div>
	<div id="defaultStatusContent" class="set-panel02-content-white" style="width:null;height:null">
		<div class="clear"></div>
			<div class="sub-panel-open">
			  <div class="sub-panel-top"><span class="light-ico light-ico-red"></span> <span class="sub-panel-title">严重</span></div>
			  <div class="sub-panel-content">
				<table id="errorTable_default" border="0" cellpadding="0" cellspacing="0" class="table">
				  <tr>
					<td>任意一个关联业务服务状态为<span class="light-ico light-ico-red" title="严重"></span>，或者任意一个关联资源状态为<span class="light-ico light-ico-red" title="不可用"></td>
				  </tr>

				</table>
			  </div>
			</div>
			<div class="sub-panel-open">
			  <div class="sub-panel-top"><span class="light-ico light-ico-yellow"></span> <span class="sub-panel-title">警告</span></div>
			  <div class="sub-panel-content">
				<table id="alarmTable_default" border="0" cellpadding="0" cellspacing="0" class="table">
				  <tr>
					<td>任意一个关联业务服务状态为<span class="light-ico light-ico-yellow" title="警告"></span>，或者任意一个关联资源状态为<span class="lightshine-ico lightshine-ico-greenred"  title="资源可用，资源或其组件性能严重超标或某些组件不可用"></span><span class="lightshine-ico lightshine-ico-greenyellow" title="资源可用，资源或其组件性能轻微超标"></span><span class="lightshine-ico lightshine-ico-greengray" title="资源可用，资源或其组件性能未知"></span>
					</td>
				  </tr>

				</table>
			  </div>
			</div>
			<div class="sub-panel-open">
			  <div class="sub-panel-top"><span class="light-ico light-ico-gray"></span>
			  <span class="sub-panel-title">未知</span>
			  </div>
			   <div class="sub-panel-content">
				<table id="unknown_default" border="0" cellpadding="0" cellspacing="0" class="table">
				  <tr>
					<td>所有关联业务服务和资源状态为<span class="light-ico light-ico-gray" title="未知"></span>。</td>

				  </tr>
				</table>
			  </div>
			</div>
			<div class="sub-panel-open">
			  <div class="sub-panel-top"><span class="light-ico light-ico-green"></span>
			  <span class="sub-panel-title">正常</span>
			  </div>
			   <div class="sub-panel-content">
				<table id="normal_default" border="0" cellpadding="0" cellspacing="0" class="table">
				  <tr>
					<td>当不符合严重、警告、未知时服务状态为<span class="light-ico light-ico-green" title="正常"></span>。</td>
				  </tr>
				  <tr><td>&nbsp;</td></tr>
				  <tr><td>注：判断优先级为 严重 -> 警告 -> 未知 -> 正常</td></tr>
				</table>
			  </div>
			</div>
	</div>
  </div>

  <div class="table-zt">
    <div class="blackbg"><span class="left margin3"><span id="userDefineStatusSlab" class="ico ico-plus"></span><input name="rule" type="radio" value="1" <s:if test="model.confStateCal">checked</s:if>/>自定义规则</span><span class="shuoming sub-panel-tips">手工定义状态的规则。</span></div>
	<div id="userDefineStatusContent" class="set-panel02-content-white" style="width:null;height:null">
			<span id="statusHelp_span" class="r-big-ico r-big-ico-help" title="帮助"></span><span class="win-button"><span class="win-button-border"><a id="init">默认</a></span></span>
			<div class="clear"></div>
			<div class="sub-panel-open">
			  <div class="sub-panel-top"> <span id="error_del" class="r-ico r-ico-close" title="删除"></span> <span id="error_add" class="r-ico r-ico-add" title="添加"></span><span class="light-ico light-ico-red"></span> <span class="sub-panel-title">严重</span></div>
			  <div class="sub-panel-content">
				<table id="errorTable" border="0" cellpadding="0" cellspacing="0" class="table">
				  <tr><td colspan="2">请选择逻辑关系：
				  <label><input type="radio" id="errorGroup" name="errorGroup" value="0" checked/>并</label>
				  <label><input type="radio" id="errorGroup" name="errorGroup" value="1" />或</label></td></tr>
				</table>
				<table border="0" cellpadding="0" cellspacing="0" class="table">
				  <tr><td colspan="2">注：请点击<span class="ico ico-add-ncursor"></span>添加规则。</td></tr>
				</table>
			  </div>
			</div>
			<div class="sub-panel-open">
			  <div class="sub-panel-top"> <span id="alarm_del" class="r-ico r-ico-close" title="删除"></span> <span id="alarm_add" class="r-ico r-ico-add" title="添加"></span><span class="light-ico light-ico-yellow"></span> <span class="sub-panel-title">警告</span></div>
			  <div class="sub-panel-content">
				<table id="alarmTable" border="0" cellpadding="0" cellspacing="0" class="table">
				  <tr><td colspan="2">请选择逻辑关系：
					<label><input type="radio" id="alarmGroup" name="alarmGroup" value="0" checked />并</label>
					<label><input type="radio" id="alarmGroup" name="alarmGroup" value="1" />或</label></td></tr>
				</table>
				<table border="0" cellpadding="0" cellspacing="0" class="table">
				  <tr><td colspan="2">注：请点击<span class="ico ico-add-ncursor"></span>添加规则。</td></tr>
				</table>
			  </div>
			</div>
			<div class="sub-panel-open">
			  <div class="sub-panel-top"><span class="light-ico light-ico-gray"></span>
			  <span class="sub-panel-title">未知</span>
			  </div>
			   <div class="sub-panel-content">
				<table id="unknown" border="0" cellpadding="0" cellspacing="0" class="table">
				  <tr>
					<td>所有关联业务服务和资源状态为<span class="light-ico light-ico-gray" title="未知"></span>。</td>

				  </tr>
				</table>
			  </div>
			</div>
			<div class="sub-panel-open">
			  <div class="sub-panel-top"><span class="light-ico light-ico-green"></span>
			  <span class="sub-panel-title">正常</span>
			  </div>
			   <div class="sub-panel-content">
				<table id="normal" border="0" cellpadding="0" cellspacing="0" class="table">
				  <tr>
					<td>当不符合严重、警告、未知时服务状态为<span class="light-ico light-ico-green" title="正常"></span>。</td>
				  </tr>
				</table>
			  </div>
			</div>
	  </div>
  </div>
  <div class="buttonline"><span class="win-button02"><span class="win-button02-border"><a id="apply">应用</a></span></span></div>
</div>

<div id="statusHelpPanel_div" style="display:none" ><img src="${ctx}/images/bizservice-default/status-help.jpg"/></div>

<div class="loading" id="loading" style="display:none;">
	<div class="loading-l">
		<div class="loading-r">
			<div class="loading-m">
				<span class="loading-img">载入中，请稍候...</span>
			</div>
		</div>
	</div>
</div>
</body>
</html>