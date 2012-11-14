<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!--
	author:qiaozheng
	description:业务服务分析
	uri:{domainContextPath}/bizsm/bizservice/ui/bizservice-analysis
 -->
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>业务服务分析</title>
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/portal.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/portal02.css" rel="stylesheet" type="text/css" />
<style type="text/css" media="screen">
	html,body{height:100%;width:100%}

	.nobrBizName{
        width: 190px;
        overflow: hidden;
        border:0px solid red;
        text-overflow:ellipsis;
		cursor:default;
    }

</style>

<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js"></script>

<script src="${ctx}/js/component/cfncc.js" type="text/javascript"></script>
<script src="${ctx}/js/component/popwin.js" type="text/javascript"></script>

<script src="${ctx}/js/component/date/WdatePicker.js" type="text/javascript"></script>

<script type="text/javascript" src="${ctx}/flash/bizsm/swfobject.js"></script>
<script type="text/javascript" src="${ctx}/js/bizservice/CallFlash.js"></script>
<script type="text/javascript" src="${ctx}/js/bizservice/CallJS.js"></script>

<script type="text/javascript" src="${ctx}/js/bizservice/common.js"></script>


<script language="javascript">

	//var realWidth = 0, realHeight = 0;

	$(function() {

		//realWidth = document.body.clientWidth;
		//realHeight = document.body.clientHeight;

		//初始化左边业务服务分析box样式
		$("#standardNavigateBox #standardNavigateBoxTitle").css("width", "300px");
		$("#standardNavigateBox #standardNavigateBoxBottom").css("width", "300px");
		$("#standardNavigateBox #standardNavigateContent").css("height", "100%");


		//为左边导航添加推拉效果
		$('#pageBorderLocal').toggle(function(event){
			var $thisLocal = $(this);
			$('#pageBorderPanel').animate({
				left:0
			},0, function(){
				$thisLocal.removeClass("bar-left");
				$thisLocal.addClass("bar-right");
			});

			$('#standardNavigateBox').animate({
				width:0,
				opacity:1
			},0);

			$('#topTool_Td').animate({
				width:"8px"
			},0);
		}, function(event){
			var $thisLocal = $(this);

			$('#topTool_Td').animate({
				width:"300px"
			},0);

			$('#standardNavigateBox').animate({
				width:300,
				opacity:1
			},0);

			$('#pageBorderPanel').animate({
				left:300
			},0, function(){
				$thisLocal.removeClass("bar-right");
				$thisLocal.addClass("bar-left");
			});
		});


		//绑定时间范围radio click事件
		$('input[id="timeArea-1_rdo"],input[id="timeArea-2_rdo"]').click(function(){
			var $this = $(this);
			if($this.attr("value") == "1"){
				$('select[id="timeArea_sel"]').attr("disabled", false);
				$('input[id="startDate_txt"],input[id="endDate_txt"]').attr("disabled", true);

				$('#startDate_img').attr("src", "${ctx}/images/date/datePicker-gray.gif");
				$('#endDate_img').attr("src", "${ctx}/images/date/datePicker-gray.gif");
			}else{
				$('select[id="timeArea_sel"]').attr("disabled", true);
				$('input[id="startDate_txt"],input[id="endDate_txt"]').attr("disabled", false);

				$('#startDate_img').attr("src", "${ctx}/images/date/datePicker.gif");
				$('#endDate_img').attr("src", "${ctx}/images/date/datePicker.gif");
			}
		});

		//初始化日历组件样式
		//$wdate = true;
		var $dateTxt = $('input[id="startDate_txt"],input[id="endDate_txt"]');
		//$dateTxt.addClass("Wdate");
		//$dateTxt.css("cursor", "hand");
		$dateTxt.css("border", "0px solid #FF0000");
		$dateTxt.css("border-bottom", "1px solid #CCC");
		$dateTxt.attr("readOnly", true);
		$('#startDate_img,#endDate_img').css("cursor", "hand").click(function(){
			var $this = $(this);

			var inputSrcID = "";
			if($this.attr("id") == "startDate_img"){
				inputSrcID = "startDate_txt";
			}else if($this.attr("id") == "endDate_img"){
				inputSrcID = "endDate_txt";
			}
			WdatePicker({el:inputSrcID});
		});
		/*
		$dateTxt.click(function(event){
			WdatePicker({el:this.id});
		});
		*/

		//分析按钮
		$('#analysis_btn').click(function(){

			var $serviceChked = $('#bizServiceData_Tbl input[type="checkbox"]').filter('input[checked="true"]');
			if($serviceChked.size() == 0){
				//alert("请选择业务服务。");
				var _information  = top.information();
				_information.setContentText("请选择业务服务。");
				_information.show();
				return false;
			}

			if($('input[id="timeArea-2_rdo"]').get(0).checked){
				var s_date = $('input[id="startDate_txt"]').val();
				var e_date = $('input[id="endDate_txt"]').val();
				if(s_date == ""){
					//alert("请选择开始时间！");
					var _information  = top.information();
					_information.setContentText("请选择开始时间！");
					_information.show();
					return false;
				}
				if(e_date == ""){
					//alert("请选择结束时间！");
					var _information  = top.information();
					_information.setContentText("请选择结束时间！");
					_information.show();
					return false;
				}
				var d1 = new Date(s_date.replace(/\-/g, "\/"));
				var d2 = new Date(e_date.replace(/\-/g, "\/"));
				if(d2 < d1) {
					//alert("开始日期不能大于结束日期。");
					var _information  = top.information();
					_information.setContentText("开始日期不能大于结束日期。");
					_information.show();
					return false;
				}
				if(compareDateWithSysDate(d2)){
					//alert("结束日期不能大于系统当前日期。");
					var _information  = top.information();
					_information.setContentText("结束日期不能大于系统当前日期。");
					_information.show();
					return false;
				}
			}

			var kpiValue = $('#kpiIndex_sel>option:selected').attr("value");
			var uriQeuryData = f_makeAnalysisDataStr();
			var uriStr = "${ctx}/bizservice-kpi-statistics/.xml?q="+uriQeuryData;
			//call flash 业务分析分析图标
			contentArea_ifr.analysisChart(uriStr, kpiValue);

		});

		//应用按钮
		$('#apply_btn').click(function(){
			var $serviceChked = $('#bizServiceData_Tbl input[type="checkbox"]').filter('input[checked="true"]');
			/*
			if($serviceChked.size() == 0){
				alert("请选择业务服务。");
				return false;
			}
			*/
			if($('input[id="timeArea-2_rdo"]').get(0).checked){
				var s_date = $('input[id="startDate_txt"]').val();
				var e_date = $('input[id="endDate_txt"]').val();
				if(s_date == ""){
					//alert("请选择开始时间！");
					var _information  = top.information();
					_information.setContentText("请选择开始时间！");
					_information.show();
					return false;
				}
				if(e_date == ""){
					//alert("请选择结束时间！");
					var _information  = top.information();
					_information.setContentText("请选择结束时间！");
					_information.show();
					return false;
				}
				var d1 = new Date(s_date.replace(/\-/g, "\/"));
				var d2 = new Date(e_date.replace(/\-/g, "\/"));
				if(d2 < d1) {
					//alert("开始日期不能大于结束日期。");
					var _information  = top.information();
					_information.setContentText("开始日期不能大于结束日期。");
					_information.show();
					return false;
				}
				if(compareDateWithSysDate(d2)){
					//alert("结束日期不能大于系统当前日期。");
					var _information  = top.information();
					_information.setContentText("结束日期不能大于系统当前日期。");
					_information.show();
					return false;
				}
			}

			var xmlDataStr = '<ServiceKPIConditionConf>';

			xmlDataStr += '<serviceIds>';

			if($serviceChked.size() > 5){
				//alert("最多只能选择5个业务服务。");
				var _information  = top.information();
				_information.setContentText("最多只能选择5个业务服务。");
				_information.show();
				return false;
			}
			$serviceChked.each(function(i){
				var $thisChked = $(this);
				xmlDataStr += '<string>'+$thisChked.attr("value")+'</string>';
			});
			xmlDataStr += '</serviceIds>';

			xmlDataStr += '<indexID>'+$('#kpiIndex_sel>option:selected').attr("value")+'</indexID>';

			xmlDataStr += '<timeInterval>';
			xmlDataStr += '<intervalMin>1440</intervalMin>';
			xmlDataStr += '<disPlay>天</disPlay>';
			xmlDataStr += '</timeInterval>';

			xmlDataStr += '<range>';
			if($('#timeArea-2_rdo').attr("checked") == "true"
				|| $('#timeArea-2_rdo').attr("checked") == true){
				xmlDataStr += '<type>CUSTOM</type>';

				xmlDataStr += '<startTime>'+$('#startDate_txt').val()+'</startTime>';
				xmlDataStr += '<endTime>'+$('#endDate_txt').val()+'</endTime>';
			}else{
				xmlDataStr += '<type>'+$('#timeArea_sel>option:selected').attr("value")+'</type>';
			}
			xmlDataStr += '</range>';
			xmlDataStr += '</ServiceKPIConditionConf>';

			//alert(xmlDataStr);

			$.ajax({
				  type: 'PUT',
				  url: "${ctx}/bizsmconf/service-kpi-scondition",
				  contentType: "application/xml",
				  data: xmlDataStr,
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
					  //alert("操作成功。");
					  var _information  = top.information();
					  _information.setContentText("操作成功。");
					  _information.show();
					  //var uri = httpClient.getResponseHeader("Location");
				  }
			});

		});

		//执行AJAX请求,获取当前所有定义的业务服务列表.
		$.readBizServiceList = function(){
			$.get('${ctx}/bizservice/.xml',{},function(data){
				var $dataTbl = $('#bizServiceData_Tbl');
				$dataTbl.empty();

				var $serviceNodes = $(data).find('BizServices>BizService');//.not('[reference]');
				$serviceNodes.each(function(i){
					var $thisService = $(this);

					var bizIDTemp = $thisService.find('>bizId').text();
					var runStateTemp = $thisService.find('>monitered').text();
					var bizNameTemp =  $thisService.find('>name').text();


					var $rowTemp = $('<tr bizId="'+bizIDTemp+'"></tr>');

					var $tdOneTemp = $('<td width="15%"></td>');
					$tdOneTemp.append('<input type="checkbox" id="'+bizIDTemp+'_chk" name="bizServiceIDs" value="'+bizIDTemp+'">');

					var $tdTwoTemp = $('<td width="85%"></td>');
					$tdTwoTemp.append('<nobr><div class="nobrBizName"><span title="'+bizNameTemp+'">'+bizNameTemp+'</span></div></nobr>');

					$rowTemp.append($tdOneTemp);
					$rowTemp.append($tdTwoTemp);

					$dataTbl.append($rowTemp);

				});

				//设置数据表格隔行换色样式
				$('#bizServiceData_Tbl tr:nth-child(even)').css("backgroundColor", "#CCC");
				$('#bizServiceData_Tbl tr').attr("height", "25px");

				f_readAnalysisData();
			});
		}

		//$('#contentArea_ifr').attr("src", "${ctx}/pages/bizanalysisright.jsp" );

		$.readBizServiceList();

		//contentArea_ifr.eventlist("", 0, 0);

	});

	function f_readAnalysisData(){
		//读取当前分析条件数据.
		//$.readAnalysisData = function(){
			$.get('${ctx}/bizsmconf/service-kpi-scondition.xml',{},function(data){
				var dataTemp = '<ServiceKPIConditionConf>'
								  +'<serviceIds>'
									  +'<string>s19220311312693194461012300539381293701978669</string>'
									  +'<string>s32847852326564682581012300539441293701984509</string>'
									  +'<string>s-85529871716512933841012300539531293701993683</string>'
								  +'</serviceIds>'
								  +'<indexID>FAILURETIMES</indexID>'
								  +'<timeInterval>'
									  +'<intervalMin>1440</intervalMin>'
									  +'<disPlay>天</disPlay>'
								  +'</timeInterval>'
								  +'<range>'
									  +'<type>CUSTOM</type>'
									  +'<startTime>2011-01-13</startTime>'
									  +'<endTime>2011-01-15</endTime>'
								  +'</range>'
							  +'</ServiceKPIConditionConf>';
				//var dataDom = func_asXMLDom(dataTemp);

				var $serviceAnalysisData = $(data).find('ServiceKPIConditionConf:first');

				var idTemp = $serviceAnalysisData.find('>id').text();
				var uriTemp = $serviceAnalysisData.find('>uri').text();

				//设置选中的业务服务
				var $serviceIDs = $serviceAnalysisData.find('>serviceIds>string');
				var $serviceChk = $('#bizServiceData_Tbl input[type="checkbox"]');
				$serviceIDs.each(function(i){
					var $thisServiceID = $(this);
					$serviceChk.filter('[value="'+$thisServiceID.text()+'"]').attr("checked", true);
				});

				//设置KPI指标选中项
				var $kpiIndexSel = $('#kpiIndex_sel');
				var kpiIndex = $serviceAnalysisData.find('>indexID').text();
				$kpiIndexSel.find('>option[value="'+kpiIndex+'"]').attr("selected", true);

				var $rangeEl = $serviceAnalysisData.find('>range');
				var rangeType = $rangeEl.find(">type").text();
				if(rangeType == "CUSTOM"){
					//初始化时间范围radio
					$('input[id="timeArea-2_rdo"]').click();

					$('#startDate_txt').val($rangeEl.find('>startTime').text());
					$('#endDate_txt').val($rangeEl.find('>endTime').text());
				}else{
					//初始化时间范围radio
					$('input[id="timeArea-1_rdo"]').click();
					$('#timeArea_sel>option[value="'+rangeType+'"]').attr("selected", true);
					//var intervalMinTemp = $serviceAnalysisData.find('>timeInterval>intervalMin').text();
				}

				//load flash
				var kpiValue = $('#kpiIndex_sel>option:selected').attr("value");
				var uriQeuryData = f_makeAnalysisDataStr();
				var uriStr = "${ctx}/bizservice-kpi-statistics/.xml?q="+uriQeuryData;
				contentArea_ifr.f_loadCurrFlash(uriStr, kpiValue);
			});
		//}
	}
	/*
	* make分析图标uri data
	* return jsonData
	*/
	function f_makeAnalysisData(){
		var uriInfo = {};
		var serviceIdArray = new Array();
		var $serviceChked = $('#bizServiceData_Tbl input[type="checkbox"]').filter('input[checked="true"]');
		if($serviceChked.size() > 5){
			//alert("最多只能选择5个业务服务。");
			var _information  = top.information();
		    _information.setContentText("最多只能选择5个业务服务。");
		    _information.show();
			return false;
		}
		$serviceChked.each(function(i){
			var $thisChked = $(this);
			serviceIdArray.push($thisChked.attr("value"));
		});
		uriInfo["serviceIds"] = serviceIdArray;
		uriInfo["index"] = $('#kpiIndex_sel>option:selected').attr("value");

		var rangeMap = {};
		if($('#timeArea-2_rdo').attr("checked") == "true"
			|| $('#timeArea-2_rdo').attr("checked") == true){
			rangeMap["rangeType"] = "CUSTOM";
			rangeMap["beginTime"] = $('#startDate_txt').val();
			rangeMap["endTime"] = $('#endDate_txt').val();
		}else{
			rangeMap["rangeType"] = $('#timeArea_sel>option:selected').attr("value");
		}
		rangeMap["interval"] = 1440;

		uriInfo["range"] = rangeMap;
		//alert(eval(uriInfo));
		var _information  = top.information();
		_information.setContentText(eval(uriInfo));
		_information.show();
		return uriInfo;
	}

	function f_makeAnalysisDataStr(){
		var uriInfo = '{';

		var $serviceChked = $('#bizServiceData_Tbl input[type="checkbox"]').filter('input[checked="true"]');
		if($serviceChked.size() > 5){
			//alert("最多只能选择5个业务服务。");
			var _information  = top.information();
			_information.setContentText("最多只能选择5个业务服务。");
			_information.show();
			return false;
		}

		var serviceIdStr = '"serviceIds":[';
		var serviceSize = $serviceChked.size();
		$serviceChked.each(function(i){
			var $thisChked = $(this);
			if(i == (serviceSize-1)){
				serviceIdStr += '"'+$thisChked.attr("value")+'"';
			}else{
				serviceIdStr += '"'+$thisChked.attr("value")+'",';
			}
		});
		serviceIdStr += ']';

		uriInfo += serviceIdStr+',';
		var indexStr =  '"index":"'+$('#kpiIndex_sel>option:selected').attr("value")+'"';

		uriInfo += indexStr+',';

		var rangeStr = '"range":{';
		if($('#timeArea-2_rdo').attr("checked") == "true"
			|| $('#timeArea-2_rdo').attr("checked") == true){
			rangeStr += '"rangeType":"CUSTOM",';
			rangeStr += '"beginTime":"'+$('#startDate_txt').val()+'",';
			rangeStr += '"endTime":"'+$('#endDate_txt').val()+'"';
		}else{
			rangeStr += '"rangeType":"'+ $('#timeArea_sel>option:selected').attr("value")+'"';
		}
		rangeStr += '}';

		uriInfo += rangeStr+',';

		uriInfo += '"interval":'+1440;
		uriInfo += '}';
		return uriInfo;
	}




	if(window.HP){
		 HP.addActivate(function(){
			alert("invoke addActivate");
		 });
		 HP.addSleep(function(){
			alert("invoke addSleep");
		 });
		 HP.addDestory(function(){
			alert("invoke addDestory");
		 });
	}



</script>
</head>
<body>





<table height="100%" border="0">
	<tr>
		<td id="topTool_Td" width="300px">
			<div id='standardNavigateBox' style="position:absolute;top:5px;left:0px;width:275px;z-index:101;min-height:100%;height:100%;">
				<div id='standardNavigateBoxTitle' class='left-panel-open' style="min-height:100%;height:100%;">
					<div class='left-panel-l'>
						<div class='left-panel-r ui-dialog-titlebar'>
							<div class='left-panel-m'>
								<span class='left-panel-title'>业务服务分析</span>
							</div>
						</div>
					</div>
					<div class='left-panel-content' style="min-height:84.5%;height:84.5%;">
						<div id='standardNavigateContent'>
							<div class="b-servies" style="width:">
							  <div class="title-l">
								<div class="title-r">
								  <div class="title-m"><b>业务服务</b></div>
								</div>
							  </div>
							  <div class="list" style="height:140px;">
								<table id="bizServiceData_Tbl" width="100%" cellpadding="0" cellspacing="0"></table>
								<div style="clear:both;"></div>
							  </div>
							  <div class="bottom-l">
								<div class="bottom-r">
								  <div class="bottom-m"></div>
								</div>
							  </div>
							  <div class="sub-1-l">
								<div class="sub-1-r">
								<div class="layers" style="width:200px">
								  </div>
								  <div class="title-txt">KPI指标</div>
								  <div class="sub-1-m">
									<select style="width:120px;margin:4px;" id="kpiIndex_sel">
										<option value="AVAILABILITY">可用性比率</option>
										<option value="MTBF">MTBF</option>
										<option value="MTTR">MTTR</option>
										<option value="FAILURETIMES">故障次数</option>
									</select>
								  </div>
								</div>
							  </div>
							 <div class="sub-2-l">
								<div class="sub-2-r">
								  <div class="title-txt">时间范围</div>
								  <div class="sub-2-m">
										<table id="kpiDataTbl" width="100%">
											<tr>
												<td width="15%">
													<input type="radio" id="timeArea-1_rdo" name="timeArea" value="1">
												</td>
												<td  width="85%">
													<select style="width:100px" id="timeArea_sel">
														<option value="LASTESTWEEK">最近7天</option>
														<option value="LASTESTMONTH">最近30天</option>
													</select>
												</td>
											</tr>
											<tr>
												<td>
													<input type="radio" id="timeArea-2_rdo" name="timeArea" value="2">
												</td>
												<td>
													从&nbsp;<input type="text" id="startDate_txt" style="width:70px;"><img id="startDate_img" src="${ctx}/images/date/datePicker-gray.gif" width="16" height="22" align="absbottom">
												</td>
											</tr>
											<tr>
												<td>
													&nbsp;
												</td>
												<td>
													至&nbsp;<input type="text" id="endDate_txt" style="width:70px;"><img id="endDate_img" src="${ctx}/images/date/datePicker-gray.gif" width="16" height="22">
												</td>
											</tr>
										</table>
								  </div>
								</div>
							  </div>
							  <div class="sub-1-l">
								<div class="sub-1-r">
								  <div class="title-txt">时间间隔</div>
								  <div class="sub-1-m">
									&nbsp;天
								  </div>
								</div>
							  </div>
							</div>

							<div id="btnArea" style="width: 100%;">
								<table id="btnDataTbl" width="100%" style="margin:0px;" cellpadding="0" cellspacing="8">
									<tr>
										<td width="100%" colspan="2" style="text-align:right">
											<div style="display:inline;text-align:right">
												<span class="black-btn-l"><span class="btn-r"><span id="analysis_btn" class="btn-m"><a> 查 询 </a></span></span></span>
												<span class="black-btn-l"><span class="btn-r"><span id="apply_btn" class="btn-m"><a> 保存设置 </a></span></span></span>
											</div>
										</td>
									</tr>
								</table>
							</div>
						</div>
					</div>
					<div id='standardNavigateBoxBottom' class='left-panel-close' style="min-height:15%;height:15%;">
						<div class='left-panel-l'>
							<div class='left-panel-r'>
								<div class='left-panel-m'><span class='left-panel-title'></span></div>
							</div>
						</div>
					</div>
				</div>
			</div>

			<div id="pageBorderPanel" class="bar" style="position:absolute;top:0px;left:300px;min-height:100%;height:100%;z-index:101">
			  <p id="pageBorderLocal" class="bar-left"></p>
			</div>
		</td>
		<td height="100%" style="min-height:100%;height:100%;">
			<div style="margin-left:10px;width:100%;height:100%">
				<iframe id="contentArea_ifr" frameborder="NO" border="0" scrolling="NO" noresize framespacing="0" src="${ctx}/pages/bizanalysisright.jsp" style="width:99.9%; height:100%;background-image:none;background-color:transparent;" allowtransparency="true"></iframe>
			</div>
		</td>
	</tr>
</table>
<div elID="bizAnanlysisFlag"></div>
</body>
</html>