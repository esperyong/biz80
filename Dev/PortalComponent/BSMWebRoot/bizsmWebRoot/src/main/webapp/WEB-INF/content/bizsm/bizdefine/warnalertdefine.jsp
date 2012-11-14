<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!--
 author:qiaozheng
 description:业务服务报警定义
 uri:{domainContextPath}/bizsm/bizservice/ui/warnalert-define
 -->

<%@ page import="com.mocha.bsm.commonrule.common.ModuleIdCollection" %>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<%
	String serviceID = request.getParameter("serviceId");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>业务服务报警定义</title>
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css" />
<style type="text/css">
<!--
	.nobrName{
        width: 220px;
        overflow: hidden;
        border: 0px solid red;
        text-overflow:ellipsis;
    }
	.nobrSType{
        width: 220px;
        overflow: hidden;
        border: 0px solid red;
        text-overflow:ellipsis;
    }
	.nobrReceiver{
        width: 220px;
        overflow: hidden;
        border: 0px solid red;
        text-overflow:ellipsis;
    }
-->
</style>
<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="${ctx}/js/bizservice/ajaxcommon.js"></script>
<script type="text/javascript" src="${ctx}/js/bizservice/common.js"></script>

<script src="${ctx}/js/component/cfncc.js" type="text/javascript"></script>
<script src="${ctx}/js/component/popwin.js" type="text/javascript"></script>
<script src="${ctx}/js/component/toast/Toast.js" type="text/javascript"></script>
<script>
var confirmConfig = {width: 300,height: 80};
var toast  = null;
$(function(){
	toast = new Toast({position:"CT"});
	$('#apply_btn_warnalert').click(function(){
		var sendData = f_makeSaveData();
			//alert(sendData);
			$.ajax({
				  type: 'PUT',
				  url: '${ctx}/bizservice/<%=serviceID%>/notification-rule/.xml',
				  contentType: "application/xml",
				  data: sendData,
				  processData: false,
				  beforeSend: function(request){
					  httpClient = request;
				  },
				  cache:false,
				  error: function (request) {
						var errorMessage = request.responseXML;
						var $errorObj = $(errorMessage).find('FieldErrors>FieldError');
						$errorObj.each(function(i){
							var fieldId = $(this).find('FieldId').text();
							var field = document.getElementById(fieldId);
							var errorInfo = $(this).find('ErrorInfo').text();
							var _information  = top.information();
							_information.setContentText(errorInfo);
							_information.show();
							//alert(errorInfo);
							field.focus();
						});
				  },
				  success: function(msg){
					  //var uri = httpClient.getResponseHeader("Location");
					  //alert("操作成功。");
					  //var _information  = top.information();
					  //_information.setContentText("操作成功。");
					  //_information.show();
					  toast.addMessage("保存成功!");
				  }
			});
	});

	$('#add_btn_warnalert').click(function(){
		window.open('/pureportal/profile/alarm/alarmDef.action?commonRule.basicInfo.moduleId=<%=serviceID%>', 'CreateWarnAlertDefine', 'height=600, width=670, top=150, left=300, toolbar=no, menubar=no, scrollbars=yes, resizable=no,location=no, status=no');

		//var returnValue = showModalPopup("/pureportal/profile/alarm/alarmDef.action?commonRule.basicInfo.moduleId=<%=ModuleIdCollection.MODULEID_BIZSERVICE%>", 'Create WarnAlertDefine', '500px', '800px');
		//if(returnValue){
		//	if(returnValue == "success"){
				//window.location.reload();
		//	}
		//}
	});

	$('#del_btn_warnalert').click(function(){
		var $dataTbl = $('#bizWarnData_Tbl');
		var dataTblObj = $dataTbl.get(0);
		var $warnChk = $dataTbl.find('td>input[name="warn_chk"]').filter('input[checked="true"]');
		var dataNum = $dataTbl.find('td>input[name="warn_chk"]').size();
		if(dataNum == 0){
			//alert("请选择要操作的数据。");
			var _information  = top.information();
		    _information.setContentText("没有要删除的记录。");
		    _information.show();
			return false;
		}
		if($warnChk.size() == 0){
			//alert("请选择要操作的数据。");
			var _information  = top.information();
		    _information.setContentText("请至少选择一项。");
		    _information.show();
			return false;
		}
		var _confirm = top.confirm_box(confirmConfig);
		_confirm.setContentText("此操作不可恢复，是否确认执行？"); //提示框
		_confirm.show();
		_confirm.setConfirm_listener(function() {
			_confirm.hide();
			$warnChk.each(function(cnt){
				var $thisChk = $(this);
				if($thisChk.attr("checked") == true){
					var rowIdx = $thisChk.parent('td').parent('tr').get(0).rowIndex;
					dataTblObj.deleteRow(rowIdx);
				}
			});
		});
		_confirm.setCancle_listener(function(){
			_confirm.hide();
		});
	});

	readWarnData();
});
function reloadParentPage(ruleId){
	readWarnData();
}
function readWarnData(){

	var dataTest = '<NotificationRules>'
					+'<bizServiceId>xxx</bizServiceId>'
					+'<NotificationRule>'
						+'<uri>/notification-rule/1234</uri>'
						+'<ruleId>1234</ruleId>'
						+'<moduleId>moduleId</moduleId>'
						+'<isEnable>true</isEnable>'
						+'<domainId>domainId</domainId>'
						+'<createUserId>liuyong</createUserId>'
						+'<ruleName>规则名称</ruleName>'
						+'<ruleDesc>规则</ruleDesc>'
						+'<isUpgradeEnabled>true</isUpgradeEnabled>'
						+'<sendTypeName>'
							  +'<string>邮件</string>'
							  +'<string>声光</string>'
							  +'<string>短信</string>'
						+'</sendTypeName>'
						+'<receiverIds>'
							  +'<string>zhangxu</string>'
							  +'<string>qiaozheng</string>'
							  +'<string>liuyong</string>'
						+'</receiverIds>'
						+'<receivers>'
						+ '<UserInfo>'
							+ '<userName>admin</userName>'
							+ '<userId>user-000000000000001</userId>'
							+ '<userType>SUPERADMIN</userType>'
						  + '</UserInfo>'
						+ '</receivers>'
					+'</NotificationRule>'
					+'<NotificationRule>'
						+'<uri>/notification-rule/1234</uri>'
						+'<ruleId>1234</ruleId>'
						+'<moduleId>moduleId</moduleId>'
						+'<isEnable>true</isEnable>'
						+'<domainId>domainId</domainId>'
						+'<createUserId>liuyong</createUserId>'
						+'<ruleName>规则名称</ruleName>'
						+'<ruleDesc>规则</ruleDesc>'
						+'<isUpgradeEnabled>true</isUpgradeEnabled>'
						+'<sendTypeName>'
							  +'<string>邮件</string>'
							  +'<string>声光</string>'
							  +'<string>短信</string>'
						+'</sendTypeName>'
						+'<receiverIds>'
							  +'<string>zhangxu</string>'
							  +'<string>qiaozheng</string>'
							  +'<string>liuyong</string>'
						+'</receiverIds>'
						+'<receivers>'
						+ '<UserInfo>'
							+ '<userName>admin</userName>'
							+ '<userId>user-000000000000001</userId>'
							+ '<userType>SUPERADMIN</userType>'
						  + '</UserInfo>'
						+ '</receivers>'
					+'</NotificationRule>'
					+'<NotificationRule>'
						+'<uri>/notification-rule/1234</uri>'
						+'<ruleId>1234</ruleId>'
						+'<moduleId>moduleId</moduleId>'
						+'<isEnable>true</isEnable>'
						+'<domainId>domainId</domainId>'
						+'<createUserId>liuyong</createUserId>'
						+'<ruleName>规则名称</ruleName>'
						+'<ruleDesc>规则</ruleDesc>'
						+'<isUpgradeEnabled>true</isUpgradeEnabled>'
						+'<sendTypeName>'
							  +'<string>邮件</string>'
							  +'<string>声光</string>'
							  +'<string>短信</string>'
						+'</sendTypeName>'
						+'<receiverIds>'
							  +'<string>zhangxu</string>'
							  +'<string>qiaozheng</string>'
							  +'<string>liuyong</string>'
						+'</receiverIds>'
						+'<receivers>'
						+ '<UserInfo>'
							+ '<userName>admin</userName>'
							+ '<userId>user-000000000000001</userId>'
							+ '<userType>SUPERADMIN</userType>'
						  + '</UserInfo>'
						+ '</receivers>'
					+'</NotificationRule>'
				+'</NotificationRules>';

	//var dataDom = func_asXMLDom(dataTest);

	$.get('${ctx}/bizservice/<%=serviceID%>/notification-rule/.xml',{},function(data){
		var $dataTbl = $('#bizWarnData_Tbl');
		$dataTbl.empty();
		$dataTbl.append('<tr><th width="5%"><input type="checkbox" name="chk_all"/></th><th width="5%">激活</th><th width="30%">规则名称</th><th width="30%">发送方式</th><th width="30%">接收人</th></tr>');

		var $notificationRule = $(data).find('NotificationRules>NotificationRule');//.not('[reference]');
		$notificationRule.each(function(i){
			var $thisNotificationRule = $(this);

			var ruleIdTemp = $thisNotificationRule.find('>ruleId').text();
			var nameTemp = $thisNotificationRule.find('>ruleName').text();
			var isEnableTemp = $thisNotificationRule.find('>isEnable').text();

			var sendTypesTemp = "";
			var $sendTypes = $thisNotificationRule.find('>sendTypeName>string');
			$sendTypes.each(function(typeCnt){
				var $thisSendType = $(this);
				if(typeCnt != 0){
					sendTypesTemp += ","+$thisSendType.text();
				}else{
					sendTypesTemp += $thisSendType.text();
				}
			});

			/*
			var receiverIdsTemp = "";
			var $receiverIds = $thisNotificationRule.find('>receiverIds>string');
			$receiverIds.each(function(idCnt){
				var $thisReceiverId = $(this);
				if(idCnt != 0){
					receiverIdsTemp += ","+$thisReceiverId.text();
				}else{
					receiverIdsTemp += $thisReceiverId.text();
				}
			});
			*/
			var receiverNameTemp = "";
			var $receiverNames = $thisNotificationRule.find('>receivers>UserInfo>userName');
			$receiverNames.each(function(idCnt){
				var $thisReceiverName = $(this);
				if(idCnt != 0){
					receiverNameTemp += ","+$thisReceiverName.text();
				}else{
					receiverNameTemp += $thisReceiverName.text();
				}
			});

			var $rowTemp = $('<tr isData="true"></tr>');
			$rowTemp.attr("ruleID", ruleIdTemp);

			if("default_rule" == ruleIdTemp){
				$rowTemp.attr("isDefault", "true");
				$rowTemp.attr("disabled", "true");
			}


			var $tdChkTemp = null;
			if("default_rule" == ruleIdTemp){
				$tdChkTemp = $('<td>&nbsp;</td>');
			}else{
				$tdChkTemp = $('<td><input type="checkbox" name="warn_chk"/></td>');
			}

			var $chkEnableTemp = $('<input type="checkbox" name="enable_chk" value="'+isEnableTemp+'"/>');
			if(isEnableTemp == "true"){
				$chkEnableTemp.attr("checked", "true");
			}
			var $tdEnableTemp = $('<td></td>');
			$tdEnableTemp.append($chkEnableTemp);


			var $tdNameTemp = $('<td editHot="true" style="cursor:default"><nobr><div class="nobrName" title="'+nameTemp+'">'+nameTemp+'</div></nobr></td>');
			$tdNameTemp.css("cursor", "hand");

			var $tdSendWayTemp = $('<td style="cursor:default"><nobr><div class="nobrSType" title="'+sendTypesTemp+'">'+sendTypesTemp+'</div></nobr></td>');
			var $tdReciveUser =  $('<td style="cursor:default"><nobr><div class="nobrReceiver" title="'+receiverNameTemp+'">'+receiverNameTemp+'</div></nobr></td>');

			$rowTemp.append($tdChkTemp);
			$rowTemp.append($tdEnableTemp);
			$rowTemp.append($tdNameTemp);
			$rowTemp.append($tdSendWayTemp);
			$rowTemp.append($tdReciveUser);

			$dataTbl.append($rowTemp);
		});

		//绑定全选按钮click事件
		$dataTbl.find('th>input[name="chk_all"]').click(function(event){
			var isChked = $(this).attr("checked");
			$dataTbl.find('td>input[name="warn_chk"]').attr("checked", isChked);
		});

		//点击报警规则名称列,弹出报警规则编辑页面.
		$dataTbl.find('td[editHot="true"]').click(function(event){
			var $thisTd = $(this);
			var ruleIdTemp = $thisTd.parent("tr").attr("ruleId");
			var isDefaultTemp = $thisTd.parent("tr").attr("isDefault");
			if(isDefaultTemp == "true"){
				//点击默认报警规则名称列,弹出默认报警规则页面.
				window.open('/pureportal/profile/alarm/defautAlarmDef.action?commonRule.basicInfo.moduleId=<%=serviceID%>&ruleId='+ruleIdTemp, 'editwarnwindow', 'height=260, width=620, top=150, left=300, toolbar=no, menubar=no, scrollbars=yes, resizable=no,location=no, status=no');
			}else{
				//点击报警规则名称列,弹出报警规则编辑页面.
				window.open('/pureportal/profile/alarm/alarmDef.action?commonRule.basicInfo.moduleId=<%=serviceID%>&ruleId='+ruleIdTemp, 'editwarnwindow', 'height=600, width=670, top=150, left=300, toolbar=no, menubar=no, scrollbars=yes, resizable=no,location=no, status=no');
			}
		});

		//设置数据表格隔行换色样式
		$('#bizWarnData_Tbl tr:nth-child(odd)').addClass("black-grid-graybg");
		//$('#bizWarnData_Tbl tr:nth-child(odd)').css("backgroundColor", "#CCC");
		//$('#bizWarnData_Tbl tr').attr("height", "25px");

	});
}

	/**
	*创建要保存的数据结构
	*
	*return String
	*/
	function f_makeSaveData(){

		var xmlDataStr = '<NotificationRules>';
		xmlDataStr += '<bizServiceId><%=serviceID%></bizServiceId>';
		$('#bizWarnData_Tbl tr').each(function(cnt){
			if(cnt != 0){
				var $this = $(this);
				var ruleIdTemp = $this.attr("ruleID");
				var $isEnableTd = $($this.find('>td').get(1));
				var $isEnabledTemp = $isEnableTd.find('>input[type="checkbox"]').attr("checked");

				xmlDataStr += '<NotificationRule>';
				xmlDataStr += '<ruleId>'+ruleIdTemp+'</ruleId>';
				xmlDataStr += '<isEnable>'+$isEnabledTemp+'</isEnable>';
				xmlDataStr += '</NotificationRule>';
			}
		});

		xmlDataStr += '</NotificationRules>';

		return xmlDataStr;
	}
</script>
</head>
<body>
	<div class="set-panel-content-white">
		<div class="sub-panel-open">
		  <div class="sub-panel-top"><span class="sub-panel-tips vertical-top sub-panel-title">创建告警规则，设置告警的发送方式、接收人、告警时间、告警升级等。</span></div>
		  <div class="sub-panel-content">
			    <div><span id="del_btn_warnalert" class="ico ico-delete right" title="删除"></span><span id="add_btn_warnalert" class="ico ico-add right" title="添加"></span></div>
				<table id="bizWarnData_Tbl" class="black-grid table-width100"></table>
				<div style="clear:both;"></div>
			    <div><span class="win-button" id="apply_btn_warnalert"><span class="win-button-border"><a> 应 用 </a></span></span></div>
		  </div>
		</div>
	</div>
</body>
</html>