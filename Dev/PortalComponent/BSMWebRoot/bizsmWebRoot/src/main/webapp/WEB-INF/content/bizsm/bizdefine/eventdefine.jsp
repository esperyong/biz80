<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!--
 author:qiaozheng
 description:业务服务事件定义
 uri:{domainContextPath}/bizsm/bizservice/ui/event-define
 -->
<%@ page import="com.mocha.bsm.bizsm.adapter.event.BizServiceStateChangeEvent"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<%
	String serviceID = request.getParameter("serviceId");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>业务服务事件定义</title>
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/portal.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/portal02.css" rel="stylesheet" type="text/css" />
<style type="text/css">
<!--
.nobrName{
        width: 200px;
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
<script src="${ctx}/js/component/toast/Toast.js" type="text/javascript"></script>

<script>
var confirmConfig = {width: 300,height: 80};
var toast  = null;
$(function(){
	toast = new Toast({position:"CT"});
	$('#apply_btn').click(function(){
		var sendData = f_makeSaveData();
			//alert(sendData);
			$.ajax({
				  type: 'PUT',
				  url: "${ctx}/bizsmconf/event-send-strategy",
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
							//alert(errorInfo);
							var _information  = top.information();
							_information.setContentText(errorInfo);
							_information.show();
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

	//执行AJAX请求,获取当前业务服务事件报警.
			var dataStr = '<EventSendStrategyConf>'
								+'<bizServiceId>123</bizServiceId>'
								+'<strategys>'
									+'<EventSendStrategy>'
										+'<sendNotification>true</sendNotification>'
										+'<serverity>4</serverity>'
										+'<distState>SERIOUS</distState>'
										+'<strategyDescription>服务状态转变为严重</strategyDescription>'
									+'</EventSendStrategy>'
									+'<EventSendStrategy>'
										+'<sendNotification>true</sendNotification>'
										+'<serverity>4</serverity>'
										+'<distState>WARNING</distState>'
										+'<strategyDescription>服务状态转变为警告</strategyDescription>'
									+'</EventSendStrategy>'
									+'<EventSendStrategy>'
										+'<sendNotification>false</sendNotification>'
										+'<serverity>4</serverity>'
										+'<distState>UNKNOWN</distState>'
										+'<strategyDescription>服务状态转变为未知</strategyDescription>'
									+'</EventSendStrategy>'
									+'<EventSendStrategy>'
										+'<sendNotification>false</sendNotification>'
										+'<serverity>4</serverity>'
										+'<distState>NORMAL</distState>'
										+'<strategyDescription>服务状态恢复正常</strategyDescription>'
									+'</EventSendStrategy>'
								+'</strategys>'
							+'</EventSendStrategyConf> ';

			//var dataDom = func_asXMLDom(dataStr);
			$.get('${ctx}/bizsmconf/event-send-strategy.xml?serviceId=<%=serviceID%>',{},function(data){
				var $dataTbl = $('#bizServiceData_Tbl');
				$dataTbl.empty();
				$dataTbl.append('<tr><th width="50%" style="text-align:left">事件名称</th><th width="20%" style="text-align:left">级别</th><th width="30%" style="text-align:left">是否报警</th></tr>');

				var $serveritySelect = $('<select name="serverity_sel"></select>');
				$serveritySelect.append('<option value="<%=BizServiceStateChangeEvent.SERVERITY_FATAL%>" title="">致命</option>');
				$serveritySelect.append('<option value="<%=BizServiceStateChangeEvent.SERVERITY_SERIOUS%>" title="">严重</option>');
				$serveritySelect.append('<option value="<%=BizServiceStateChangeEvent.SERVERITY_SECONDARY%>" title="">次要</option>');
				$serveritySelect.append('<option value="<%=BizServiceStateChangeEvent.SERVERITY_WARNING%>" title="">警告</option>');
				$serveritySelect.append('<option value="<%=BizServiceStateChangeEvent.SERVERITY_INFORMATIONAL%>" title="">信息</option>');
				$serveritySelect.append('<option value="<%=BizServiceStateChangeEvent.SERVERITY_UNKNOWN%>" title="">未知</option>');

				var $eventSendData = $(data).find('EventSendStrategyConf>strategys>EventSendStrategy');//.not('[reference]');
				$eventSendData.each(function(i){
					var $thisEventSendData = $(this);

					var nameTemp = $thisEventSendData.find('>strategyDescription').text();
					var serverityTemp = $thisEventSendData.find('>serverity').text();
					var distStateTemp = $thisEventSendData.find('>distState').text();
					var sendNotificationTemp =  $thisEventSendData.find('>sendNotification').text();
					var distStateTemp =  $thisEventSendData.find('>distState').text();


					var $rowTemp = $('<tr isData="true"></tr>');
					$rowTemp.attr("distState", distStateTemp);

					var $tdNameTemp = $('<td><nobr><div class="nobrName" style="cursor:hand" title="'+nameTemp+'">'+nameTemp+'</div></nobr></td>');
					//var $tdDistStateTemp = $('<td><span>&nbsp;'+distStateTemp+'</span></td>');
					var $serveritySelectTemp = $serveritySelect.clone();
					$serveritySelectTemp.find('>option[value="'+serverityTemp+'"]').attr("selected", "true");
					var $tdDistStateTemp = $('<td></td>').append($serveritySelectTemp);
					var $tdSendNotificationTemp = $('<td>&nbsp;</td>');

					var $sendNotificationChkTemp = $('<input type="checkbox" name="sendNotification" value="'+sendNotificationTemp+'"/>');
					if(sendNotificationTemp == "true"){
						$sendNotificationChkTemp.attr("checked", "true");
					}
					$tdSendNotificationTemp.append($sendNotificationChkTemp);

					$rowTemp.append($tdNameTemp);
					$rowTemp.append($tdDistStateTemp);
					$rowTemp.append($tdSendNotificationTemp);

					$dataTbl.append($rowTemp);
				});

				//设置数据表格隔行换色样式
				$('#bizServiceData_Tbl tr:nth-child(odd)').addClass("black-grid-graybg");
				//$('#bizServiceData_Tbl tr').attr("height", "25px");
			});
});

	/**
	*创建要保存的数据结构
	*
	*return String
	*/
	function f_makeSaveData(){

		var xmlDataStr = '<EventSendStrategyConf>';
		xmlDataStr += '<bizServiceId><%=serviceID%></bizServiceId>';
		xmlDataStr += '<strategys>';

		$('#bizServiceData_Tbl tr').each(function(cnt){
			if(cnt != 0){
				var $this = $(this);
				var distStateTemp = $this.attr("distState");

				var $tempTdOne = $($this.find('>td').get(0));
				var $tempTdTwo = $($this.find('>td').get(1));
				var $tempTdThree = $($this.find('>td').get(2));
				xmlDataStr += '<EventSendStrategy>';

				xmlDataStr +='<sendNotification>'+$tempTdThree.find('>input[type="checkbox"]').attr("checked")+'</sendNotification>';
				xmlDataStr +='<serverity>'+$tempTdTwo.find('>select>option:selected').attr("value")+'</serverity>';
				xmlDataStr +='<distState>'+distStateTemp+'</distState>';
				//xmlDataStr +='<distState>SERIOUS</distState>';
				xmlDataStr +='<strategyDescription>'+$tempTdOne.find('>nobr>div').text()+'</strategyDescription>';
				xmlDataStr += '</EventSendStrategy>';
			}
		});

		xmlDataStr += '</strategys>';
		xmlDataStr += '</EventSendStrategyConf>';

		return xmlDataStr;
	}

</script>
</head>
<body>
	<div class="set-panel-content-white">
		<div class="sub-panel-open">
			<div class="sub-panel-content">
			   <div></div>
			   <div style="height:300px;"><table id="bizServiceData_Tbl" class="black-grid table-width100" cellpadding="0" cellspacing="0"></table><div style="clear:both;"></div></div>
			   <div><span class="win-button" id="apply_btn"><span class="win-button-border"><a> 应 用 </a></span></span></div>
            </div>
          </div>
	  </div>
</body>
</html>