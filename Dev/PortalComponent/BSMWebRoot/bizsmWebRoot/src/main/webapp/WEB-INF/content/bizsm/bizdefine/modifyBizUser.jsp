<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!--
	author:qiaozheng
	description:创建业务单位
	uri:{domainContextPath}/bizsm/bizservice/ui/create-bizuser
 -->

 <%
	String dataURI = request.getParameter("dataURI");
%>

<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>编辑业务单位</title>

<link href="${ctx}/css/portal.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/validationEngine.jquery.css" rel="stylesheet" type="text/css" />

<style type="text/css">
	.selectedTr{background:gray;color:white}
</style>

<style type="text/css">
.pop-win{ overflow:hidden; margin:0 auto; z-index:999;}
.pop-win-tl{ background:url(../../../images/uicomponent/window/pop-window.gif) left 0 no-repeat; padding-left:10px;}
.pop-win-tr{ background:url(../../../images/uicomponent/window/pop-window.gif) right -29px no-repeat; padding-right:10px;}
.pop-win-tc{ background:url(../../../images/uicomponent/window/pop-window.gif) right -58px repeat-x; overflow:auto;zoom:1;padding:7px 4px 6px;}
.pop-title-m{ background:url(../../../images/uicomponent/window/pop-title-ico.gif) 0% 50% no-repeat; text-indent:0px; color:#fff; font-weight:700; display:inline-block;*display:inline;zoom:1;padding-left:15px; padding-right:0px;}
.pop-title-m span{ font-weight:700; margin-top:1px;}
.pop-title{background:none; padding-right:3px; float:left;zoom:1; display:block; text-indent:0; padding-left:0;}
.pop-win-m{ background:#060606; border:#6d6d6d 1px solid; border-bottom:none; border-top:none; padding:0 5px;}
.pop-win-content{ overflow-x:hidden;overflow-y:auto;background:#fff; border:#6B6B6B 1px solid}
.pop-win-bl{ background:url(../../../images/uicomponent/window/pop-window-bottom.gif) no-repeat left 0;padding-left:10px;}
.pop-win-br{ background:url(../../../images/uicomponent/window/pop-window-bottom.gif) no-repeat right -25px ; padding-right:10px;}
.pop-win-bc{ background:url(../../../images/uicomponent/window/pop-window-bottom.gif) repeat-x left -50px;height:25px; vertical-align:middle; padding:0;}
</style>

<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js"></script>


<script src="${ctx}/js/component/cfncc.js" type="text/javascript"></script>

<script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.core.js"></script>
<script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.widget.js"></script>
<script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.mouse.js"></script>
<script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.draggable.js"></script>

<script src="${ctx}/js/bizservice/common.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/js/jquery.validationEngine.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery.validationEngine-cn.js"></script>

<script src="${ctx}/js/component/popwin.js" type="text/javascript"></script>
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
	var confirmConfig = {width: 200,height: 80};

	$(function() {

		$('#bizUserImg-img').hide();

		$("#ipAddArea").css("position", "absolute");
		$("#ipAddArea").css("top", "10px");
		$("#ipAddArea").css("left", "10px");
		$("#ipAddArea").css("width", "400px");
		$("#ipAddArea").css("z-index", "100");
		$('#ipAddArea').hide();

		//装载数据
		f_loadData("${ctx}<%=dataURI%>.xml");


		$('#addBtn').click(function(){
			$('#ipAddArea-title').text("添加");

			$('#ipAddArea #ipAddr').val("");
			$('input[name="ipType"]').get(0).click();

			$('#ipAddArea').attr("model", "addnew");
			$('#ipAddArea').slideDown(300, function(){
				if($("#middleElement_bgDiv").size() == 0){
					$("<div>").attr("id","middleElement_bgDiv").css(
						{
							position:"absolute",
							left:"0px",
							top:"0px",
							width:$(window).width()+"px",
							height:Math.max($("body").height(),$(window).height())+"px",
							filter:"Alpha(Opacity=40)",
							opacity:"0.4",
							backgroundColor:"#AAAAAA",
							zIndex:"99",
							margin:"0px",
							padding:"0px"
						}
					).appendTo("body");
				}else{
					$("#middleElement_bgDiv").show();
				}
			});
			$('#ipAddArea #ipAddr').focus();
			$('#ipAddArea #ipAddr').select();
		});

		$('#editBtn').click(function(){
			$('#ipAddArea-title').text("编辑");

			var $selectedTr = $('#ipArea>table tr.selectedTr');
			var selectedTr = $selectedTr.get(0);
			if(selectedTr != null && selectedTr.rowIndex > -1){
				var ipTypeStr = $selectedTr.attr("ipType");
				$('#ipAddArea input[name=ipType]').each(function(cnt){
					if(this.value == ipTypeStr){
						//this.checked = true;
						this.click();
					}
				});
				$('#ipAddArea #ipAddr').val($selectedTr.text());

				$('#ipAddArea').attr("model", "edit");
				$('#ipAddArea').slideDown(300, function(){
					if($("#middleElement_bgDiv").size() == 0){
						$("<div>").attr("id","middleElement_bgDiv").css(
							{
								position:"absolute",
								left:"0px",
								top:"0px",
								width:$(window).width()+"px",
								height:Math.max($("body").height(),$(window).height())+"px",
								filter:"Alpha(Opacity=40)",
								opacity:"0.4",
								backgroundColor:"#AAAAAA",
								zIndex:"99",
								margin:"0px",
								padding:"0px"
							}
						).appendTo("body");
					}else{
						$("#middleElement_bgDiv").show();
					}
				});

				$('#ipAddArea #ipAddr').focus();
				$('#ipAddArea #ipAddr').select();
			}else{
				if(selectedTr == null || selectedTr.rowIndex < 0){
					//alert("请选择要操作的数据。");
					var _information  = information();
					_information.setContentText("请选择要操作的数据。");
					_information.show();
					return;
				}
			}
		});
		$('#deleteBtn').click(function(){
			var selectedTr = $('#ipArea>table tr.selectedTr').get(0);
			if(selectedTr == null || selectedTr.rowIndex < 0){
				//alert("请选择要删除的数据。");
				var _information  = information();
				_information.setContentText("请选择要删除的数据。");
				_information.show();
				return;
			}
			$('#ipArea>table').get(0).deleteRow(selectedTr.rowIndex);
		});
		$.validationEngineLanguage.allRules.noConfirm = {
			"nname":"validatenoConfirm",
			"alertText":"ip地址已经在列表中存在。"
		}
		$.validationEngineLanguage.allRules.noConfirm1 = {
			"nname":"validatenoConfirm1",
			"alertText":"ip地址段不能大于32。"
		}
		$.validationEngineLanguage.allRules.noConfirm2 = {
			"nname":"validatenoConfirm2",
			"alertText":"请输入ip地址段(如：192.168.1.1/1-32)。"
		}
		$.validationEngineLanguage.allRules.noConfirm3 = {
			"nname":"validatenoConfirm3",
			"alertText":"ip地址无效。"
		}
		$('#newForm').validationEngine();


		$('#execBtnForIPAddArea').click(function(){
			execBtnForIPAddAreaClick();
		});

		function execBtnForIPAddAreaClick(){
			var ipTypeStr = $('#ipAddArea input[name=ipType]:checked').val();
			var ipVal = $('#ipAddArea #ipAddr').val();
			if($.trim(ipVal) == ""){
				$('#ipAddArea #ipAddr').focus();
				$('#ipAddArea #ipAddr').select();
				return;
			}
			if(ipTypeStr == "1"){
				if(!f_ipValidate(ipVal)){
					$('#ipAddArea #ipAddr').focus();
					$('#ipAddArea #ipAddr').select();
					return;
				}
			}else{
				var suffixIdx = ipVal.lastIndexOf("/");
				var realIP = ipVal;
				var ipAreaNum = 0;
				if(suffixIdx != -1){
					realIP = ipVal.substring(0, suffixIdx);
					ipAreaNum = ipVal.substring(suffixIdx+1);
					if($.trim(ipAreaNum) == ""){
						$('#ipAddArea #ipAddr').focus();
						$('#ipAddArea #ipAddr').select();
						return;
					}
				}else{
					$('#ipAddArea #ipAddr').focus();
					$('#ipAddArea #ipAddr').select();
					return;
				}
				if(!f_ipValidate(realIP)){
					$('#ipAddArea #ipAddr').focus();
					$('#ipAddArea #ipAddr').select();
					return;
				}
				if(suffixIdx != -1){
					if(ipAreaNum > 32){
						$('#ipAddArea #ipAddr').focus();
						$('#ipAddArea #ipAddr').select();
						return;
					}
				}
			}

			var modelStr =  $('#ipAddArea').attr("model");
			if(modelStr == "edit"){
				if(f_editRepeat(ipVal)){
					$('#ipAddArea #ipAddr').focus();
					$('#ipAddArea #ipAddr').select();
					return;
				}
				var $selectedTr = $('#ipArea>table tr.selectedTr');
				//selectedTr.innerText = ipVal;
				$selectedTr.find(">td").text(ipVal);
				$selectedTr.attr("ipType", ipTypeStr);
			}else{
				if(f_isExists(ipVal)){
					$('#ipAddArea #ipAddr').focus();
					$('#ipAddArea #ipAddr').select();
					return;
				}

				var newBlankRow = f_createTableRow(ipTypeStr, ipVal);
				$(newBlankRow).bind("click", function(){
					$('#ipArea>table tr.selectedTr').removeClass("selectedTr");
					$(this).addClass("selectedTr");
					$('#ipArea>table').get(0).selectedTr = this;
				});
			}
			$('#ipAddArea').fadeOut(500, function(){
				$("#middleElement_bgDiv").hide();
			});

		}

		$('#cancelBtnForIPAddArea,#closeBtnForIPAddArea').click(function(){
			$('#ipAddArea').slideUp(300,function(){
				$("#middleElement_bgDiv").hide();
			});
		});

		$('#cancelBtn,#closeIcon').bind("click", function(){
			window.close();
		});

		$('#execBtn').bind("click", function(){
			$('#ipAddArea #ipAddr').removeClass();
			if(!$.validate($("#newForm"))){
				return false;
			}
			var $bizNameInput = $('#bizName_txt');
			var bizNameTemp = $.trim($bizNameInput.val());

			var sendData = f_makeSaveData();
			//alert(sendData);
			$.ajax({
				  type: 'PUT',
				  url: "${ctx}<%=dataURI%>",
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
							alert(errorInfo);
							//field.focus();
						});
				  },
				  success: function(msg){
					  //var uri = httpClient.getResponseHeader("Location");
					  window.returnValue = "success";
					  window.close();
				  }
			});
		});


		$('#changeImg-btn').click(function(event){
			var returnImgSrc = showModalPopup("${ctx}/bizsm/bizservice/ui/bizuser-changeimg", 'Change User Biz Image', "400px", '460px');
			if(returnImgSrc){
				$('#bizUserImg-img').attr("src", "${ctx}"+returnImgSrc);
				$('#bizUserImg-img').attr('uri', returnImgSrc);
			}
		});

		$('input[name="ipType"]').click(function(){
			var valStr = this.value;
			if(valStr == "1"){
				$('#inputIP_label').text("请输入IP地址：");
				$('#ip_note_span').hide();
				$('#ipAddArea #ipAddr').removeClass();
				$('#ipAddArea #ipAddr').addClass("validate[required[ip地址不能为空。],ipAddress[],funcCall[noConfirm]]");
			}else if(valStr == "2"){
				$('#inputIP_label').text("请输入IP地址段：");
				$('#ip_note_span').show();
				$('#ipAddArea #ipAddr').removeClass();
				$('#ipAddArea #ipAddr').addClass("validate[required[ip地址段不能为空。],funcCall[noConfirm3],funcCall[noConfirm1],funcCall[noConfirm2]]");
			}
		});

		$('input[name=bizUserName]').focus();
		$('input[name=bizUserName]').select();

		//$('#ipAddArea').draggable({ handle: $('#ipAddArea>div.pop-top-l') });//,containment:'parent'
		//$('#ipAddArea').add($('#ipAddArea>div.pop-top-l')).disableSelection();

	});

  /**
	* 加载当前业务单位数据
	*/
	function f_loadData(uri){
		$.get(uri,{},function(data){
			var $data = $(data);
			$('#bizName_txt').val($data.find("name").text());
			$('#bizID_hidden').val($data.find("id").text());

			var imgSrc = $data.find("iconImageUri").text();
			var defaultImgSrc = $data.find("defaultIconImageUri").text();

			//onerror="javascript:this.src='/images/logo.jpg'"
			$('#bizUserImg-img').hide();
			$('#bizUserImg-img').attr("src", "${ctx}"+imgSrc);
			$('#bizUserImg-img').attr('uri', imgSrc);
			//$('#bizUserImg-img').attr('onerror', "javascript:this.src='${ctx}/"+defaultImgSrc+"'");
			$('#bizUserImg-img').bind('error', function(){
				if($(this).attr("isExec") == null
					|| $(this).attr("isExec") != "true"){
					$(this).attr("isExec", "true");

					$(this).attr("src",'${ctx}'+defaultImgSrc);
				}
			});
			$('#bizUserImg-img').bind('load', function(){
				$('#bizUserImg-img').show();
			});

			//$('#bizUserImg-img').show();

			$data.find("ips ipStr").each(function(cnt){
				var $this = $(this);
				f_createTableRow("1", $this.text());
			});
			$data.find("vlsms VLSM").each(function(cnt){
				var $this = $(this);
				f_createTableRow("2", $this.find("IpAddress>ipStr").text()+"/"+$this.find("PrefixLength").text());
			});

			$('#ipArea>table tr').bind("click", function(){
				$('#ipArea>table tr.selectedTr').removeClass("selectedTr");
				$(this).addClass("selectedTr");
				$('#ipArea>table').get(0).selectedTr = this;
			});

		});
	}

	/**
	*创建table新行对象
	*param:String ipType, String ipVal
	*
	*return Object
	*/
	function f_createTableRow(ipType, ipVal){
		var tblObj = $('#ipArea>table').get(0);
		var newBlankRow = tblObj.insertRow(-1);

		var $newBlankRow = $(newBlankRow);
		$newBlankRow.css("cursor", "default");
		$newBlankRow.attr("ipType", ipType);

		var newBlankCell = newBlankRow.insertCell(-1);
		$(newBlankCell).text(ipVal);
		return newBlankRow;
	}
	/**
	* 判断数据是否在表格中存在
	* param String data
	* return boolean
	*/
	function f_isExists(data){
		var result = false;
		$('#ipArea>table tr').each(function(cnt){
			var $this = $(this);
			var tempIP = $this.text();
			if(data == tempIP){
				result = true;
			}
		 });
		 return result;
	}
	/**
	* 编辑IP地址时,检查新IP地址是否与其他数据重复
	* param String data
	* return boolean
	*/
	function f_editRepeat(data){
		var result = false;
		$('#ipArea>table tr').each(function(cnt){
			var $this = $(this);

			if($this.hasClass("selectedTr")) return true;

			var tempIP = $this.text();
			if(data == tempIP){
				result = true;
			}
		});
		return result;
	}
	/**
	*验证ip地址有效性
	*param ip
	*
	*return boolean
	*/
	function f_ipValidate(ip) {
		var result = false;
		if (!(/^(\d{1,3})(\.\d{1,3}){3}$/.test(ip))) {
			return false;
		}
		var reSpaceCheck = /^(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9])\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[0-9])$/;
		var validip = ip.match(reSpaceCheck);
		if (validip != null) {
			result = true;
		}
		return result;
	}
	/**
	*创建要保存的数据结构
	*
	*return String
	*/
	function f_makeSaveData(){

		var xmlDataStr = "<BizUser>";
		xmlDataStr += "<id>";
		xmlDataStr += $('#bizID_hidden').val();
		xmlDataStr += "</id>";
		xmlDataStr += "<uri/>";
		xmlDataStr += "<name>";
		xmlDataStr += $('#bizName_txt').val();
		xmlDataStr += "</name>";
		xmlDataStr += "<iconImageUri>"+$('#bizUserImg-img').attr('uri')+"</iconImageUri>";
		xmlDataStr += "<ips class='tree-set'>";
		xmlDataStr += "<no-comparator/>";

		var ipStrBuffer = "", ipAreaStrBuffer = "";
		 $('#ipArea>table tr').each(function(cnt){
			var $this = $(this);
			var tempIP = $this.text();
			var ipTypeStr = $this.attr("ipType");
			if(ipTypeStr == "1"){
				ipStrBuffer += "<IPv4>";
				ipStrBuffer += "<ipStr>"+tempIP+"</ipStr>";
				ipStrBuffer += "</IPv4>";
			}else if(ipTypeStr == "2"){
				var idx = tempIP.lastIndexOf("/");
				ipAreaStrBuffer += "<VLSM>";
				ipAreaStrBuffer += "<IpAddress>";
				ipAreaStrBuffer += "<ipStr>"+tempIP.substring(0, idx)+"</ipStr>";
				ipAreaStrBuffer += "</IpAddress>";
				ipAreaStrBuffer += "<PrefixLength>"+tempIP.substring(idx+1)+"</PrefixLength>";
				ipAreaStrBuffer += "</VLSM>";
			}
		 });

		xmlDataStr += ipStrBuffer;
		xmlDataStr += "</ips>";

		xmlDataStr += "<vlsms class='tree-set'>";
		xmlDataStr += "<no-comparator/>";
		xmlDataStr += ipAreaStrBuffer;
		xmlDataStr += "</vlsms>";


		xmlDataStr += "</BizUser>";

		return xmlDataStr;
	}

	function validatenoConfirm(tag) {
		var result = false;
		var modelStr =  $('#ipAddArea').attr("model");
		var data = $('#ipAddArea #ipAddr').val();

		if(modelStr == "edit"){
			$('#ipArea>table tr').each(function(cnt){
				var $this = $(this);
				if($this.hasClass("selectedTr")) return;
				var tempIP = $this.text();
				if(data == tempIP){
					result = true;
				}
			});
		}
		else{
			$('#ipArea>table tr').each(function(cnt){
				var $this = $(this);
				var tempIP = $this.text();
				if(data == tempIP){
					result = true;
				}
			 });
		}
		return result;
	}

	function validatenoConfirm1(tag) {
		var result = false;
		var ipVal = $('#ipAddArea #ipAddr').val();

		var suffixIdx = ipVal.lastIndexOf("/");
		var ipAreaNum = ipVal.substring(suffixIdx+1);
		if(suffixIdx != -1){
			if(ipAreaNum > 32){
				result = true;
			}
		}

		return result;
	}

	function validatenoConfirm2(tag) {
		var result = false;
		var ipVal = $('#ipAddArea #ipAddr').val();

		var suffixIdx = ipVal.lastIndexOf("/");
		if(suffixIdx == -1){
			result = true;
		}

		return result;
	}

	function validatenoConfirm3(tag) {
		var result = false;
		var ipVal = $('#ipAddArea #ipAddr').val();

		var suffixIdx = ipVal.lastIndexOf("/");
		var realIP = ipVal.substring(0, suffixIdx);
		if(suffixIdx != -1){
			if(!f_ipValidate(realIP)){
				result = true;
			}
		}

		return result;
	}
</script>
</head>
<body  class="pop-window">
<form id="newForm">
<div class="pop" style="width:470px">
	<div class="pop-top-l">
		<div class="pop-top-r">
			<div class="pop-top-m">
				<a id="closeIcon" class="win-ico win-close"></a>
				<span class="pop-top-title">编辑业务单位</span>
			</div>
		</div>
	</div>
	<div class="pop-m">
		<div class="pop-content">
<div  style="height:20px">&nbsp;</div>
			<ul class="fieldlist-n">
				<li><span class="field" style="width:60px">业务单位</span><span>：</span><input type="text" id="bizName_txt" class="validate[required[业务单位],length[0,50,服务名称],noSpecialStr[服务名称]]"/><input type="hidden" id="bizID_hidden"/><span class="red">*</span></li>
				<li><span class="field" style="width:60px">图标</span><span>：</span>
					<img id="bizUserImg-img" width="40" height="33"/>
					<span class="gray-btn-l">
							<span class="btn-r">
								<span id="changeImg-btn" class="btn-m"><a >更改图标</a></span>
							</span>
							<span class="red">*</span>
					</span>
				</li>
				<li><span class="field" style="width:60px;vertical-align:top">IP范围</span><span style="vertical-align:top">：</span>
					<div id="ipArea" class="for-textarea" style="height:100px;width:200px;overflow-x:hidden;overflow-y:scroll;border:1px solid; scrollbar-face-color: #333333; scrollbar-shadow-color: #808080; scrollbar-highlight-color: #333333; scrollbar-3dlight-color: #808080; scrollbar-darkshadow-color: #333333; scrollbar-track-color: #191919; scrollbar-arrow-color: #CCCCCC">
							<table width="100%" align="center"></table>
					</div>
					<div class="for-inline">
						<span id="addBtn" class="gray-btn-l">
							<span class="btn-r">
								<span class="btn-m"><a>添加</a></span>
							</span>
						</span>
						<span id="editBtn" class="gray-btn-l">
							<span class="btn-r">
								<span class="btn-m"><a>编辑</a></span>
							</span>
						</span>
						<span id="deleteBtn" class="gray-btn-l">
							<span class="btn-r">
								<span class="btn-m"><a>删除</a></span>
							</span>
						</span>
					</div>
				</li>
			</ul>
		</div>

		<div  id="ipAddArea" model="edit" class="pop-div">
			<div class="pop-top-l" style="cursor:default">
				<div class="pop-top-r"  style="cursor:default">
					<div class="pop-top-m"  style="cursor:default">
						<a id="closeBtnForIPAddArea" class="win-ico win-close" style="cursor:hand"></a>
						<span id="ipAddArea-title" class="pop-top-title">添加</span>
					</div>
				</div>
			</div>
			<div class="pop-middle-l">
				<div class="pop-middle-r">
					<div class="pop-middle-m">
						<div class="pop-content">
							<ul class="fieldlist-n">
								<li>
									<input type="radio" id="addIP" name="ipType" value="1" checked><label for="addIP">IP地址</label>
									<input type="radio" id="addIPArea" name="ipType" value="2"><label for="addIPArea">IP地址段</label>
								</li>
								<li>
									<span id="inputIP_label">请输入IP地址：</span><input type="text" id="ipAddr"><span class="red">*</span>
								</li>
								<li>
									<span id="ip_note_span" style="display:none">注：输入格式为IP地址/子网掩码。例如：192.168.1.1/27</span>
								</li>
							</ul>
					  </div>
					</div>
				</div>
			</div>
			<div class="pop-bottom-l">
				<div class="pop-bottom-r">
					<div class="pop-bottom-m">
					   <span id="execBtnForIPAddArea" class="black-btn-l"><span class="btn-r"><span class="btn-m"><a>确定</a></span></span></span>
					   <span id="cancelBtnForIPAddArea" class="black-btn-l"><span class="btn-r"><span class="btn-m"><a>取消</a></span></span></span>
					</div>
				</div>
			</div>
	   </div>

  </div>
  <div class="pop-bottom-l">
		<div class="pop-bottom-r">
			<div class="pop-bottom-m">
			   <span id="cancelBtn" class="win-button"><span class="win-button-border"><a>取消</a></span></span>
			   <span id="execBtn" class="win-button"><span class="win-button-border"><a>确定</a></span></span>
			</div>
		</div>
  </div>
</div>
</form>
</body>

<script type="text/javascript">
 $(function(){
$("#newForm").validationEngine();
})
</script>
</html>
