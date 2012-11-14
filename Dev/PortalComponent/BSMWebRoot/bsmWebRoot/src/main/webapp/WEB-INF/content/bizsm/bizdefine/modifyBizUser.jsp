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

<style type="text/css">
	.selectedTr{background:gray;color:white}
</style>

<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js"></script>


<script src="${ctx}/js/component/cfncc.js" type="text/javascript"></script>



<script type="text/javascript">
	
	$(function() {
		
		$("#ipAddArea").css("position", "absolute");
		$("#ipAddArea").css("top", "10px");
		$("#ipAddArea").css("left", "10px");
		$("#ipAddArea").css("z-index", "10");
		$('#ipAddArea').hide();
		
		//装载数据
		f_loadData("${ctx}<%=dataURI%>.xml");
		
		
		$('#addBtn').click(function(){
			$('#ipAddArea #ipAddr').val("");
			$('#ipAddArea #addIP').get(0).checked = true;
			
			$('#ipAddArea').attr("model", "addnew");
			$('#ipAddArea').slideDown(300);

			$('#ipAddArea #ipAddr').focus();
		});
		$('#deleteBtn').click(function(){
			var selectedTr = $('#ipArea>table tr.selectedTr').get(0);
			if(selectedTr == null || selectedTr.rowIndex < 0){
				alert("请选择要删除的数据。");
				return;
			}
			$('#ipArea>table').get(0).deleteRow(selectedTr.rowIndex);
		});
		$('#editBtn').click(function(){
			var $selectedTr = $('#ipArea>table tr.selectedTr');
			var selectedTr = $selectedTr.get(0);
			if(selectedTr != null && selectedTr.rowIndex > -1){
				var ipTypeStr = $selectedTr.attr("ipType");
				$('#ipAddArea input[name=ipType]').each(function(cnt){
					if(this.value == ipTypeStr){
						this.checked = true;
					}
				});
				$('#ipAddArea #ipAddr').val($selectedTr.text());
				
				$('#ipAddArea').attr("model", "edit");
				$('#ipAddArea').show(300);

				$('#ipAddArea #ipAddr').focus();
				$('#ipAddArea #ipAddr').select();
			}else{
				if(selectedTr == null || selectedTr.rowIndex < 0){
					alert("请选择要操作的数据。");
					return;
				}
			}
		});

		$('#execBtnForIPAddArea').click(function(){
			var ipTypeStr = $('#ipAddArea input[name=ipType]:checked').val();
			var ipVal = $('#ipAddArea #ipAddr').val();
			if($.trim(ipVal) == ""){
				alert("ip地址不能为空。");
				$('#ipAddArea #ipAddr').focus();
				$('#ipAddArea #ipAddr').select();
				return;
			}
			
			if(ipTypeStr == "1"){
				if(!f_ipValidate(ipVal)){
					alert("ip地址无效。");
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
						alert("ip地址段不能为空。");
						$('#ipAddArea #ipAddr').focus();
						$('#ipAddArea #ipAddr').select();
						return;
					}
				}else{
					alert("请输入ip地址段(如：192.168.1.1/1)。");
					$('#ipAddArea #ipAddr').focus();
					$('#ipAddArea #ipAddr').select();
					return;
				}
				if(!f_ipValidate(realIP)){
					alert("ip地址无效。");
					$('#ipAddArea #ipAddr').focus();
					$('#ipAddArea #ipAddr').select();
					return;
				}
				if(suffixIdx != -1){
					if(ipAreaNum > 32){
						alert("ip地址段不能大于32。");
						$('#ipAddArea #ipAddr').focus();
						$('#ipAddArea #ipAddr').select();
						return;
					}
				}
			}

			var modelStr =  $('#ipAddArea').attr("model");
			if(modelStr == "edit"){
				var $selectedTr = $('#ipArea>table tr.selectedTr');
				//selectedTr.innerText = ipVal;
				$selectedTr.find(">td").text(ipVal); 
				$selectedTr.attr("ipType", ipTypeStr);
			}else{
				if(f_isExists(ipVal)){
					alert("ip地址已经在列表中存在。");
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
			$('#ipAddArea').fadeOut(500);
		
		});

		$('#cancelBtnForIPAddArea,#closeBtnForIPAddArea').click(function(){
			$('#ipAddArea').slideUp(300);
		});

		$('#cancelBtn,#closeIcon').bind("click", function(){
			window.close();
		});

		$('#execBtn').bind("click", function(){
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
							field.focus();
						});
				  },
				  success: function(msg){
					  //var uri = httpClient.getResponseHeader("Location");
					  window.returnValue = "success";
					  window.close();
				  }			  		  
			});	
		});

		$('input[name=bizUserName]').focus();
		$('input[name=bizUserName]').select();

	});
	
	/**
	*加载当前业务单位数据
	*
	*/
	function f_loadData(uri){
		$.get(uri,{},function(data){
			var $data = $(data);
			$('#bizName_txt').val($data.find("name").text());
			$('#bizID_hidden').val($data.find("id").text());

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
	*判断数据是否在表格中存在
	*
	*return boolean
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
		/*
		<BizUser>
		  <name>北京电视台</name>
		  <id>1</id>
		  <uri>/bizuser/1</uri>
		  <ips class="tree-set">
			<no-comparator/>
			<IPv4>
			  <ipStr>192.168.6.241</ipStr>
			</IPv4>
		  </ips>
		  <vlsms class="tree-set">
			<no-comparator/>
			<VLSM>
			  <IpAddress>
				<ipStr>192.168.1.0</ipStr>
			  </IpAddress>
			  <PrefixLength>24</PrefixLength>
			</VLSM>
		  </vlsms>
		</BizUser>
		*/
	}

</script>
</head>
<body  class="pop-window">
<div class="pop" style="width:420px">
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

			<ul class="fieldlist-n">
				<li><span class="field">业务单位：</span><input type="text" id="bizName_txt"/><input type="hidden" id="bizID_hidden"/></li>
				<li><span class="field">图标：</span>
					<img/>
					<span class="gray-btn-l">
							<span class="btn-r">
								<span class="btn-m"><a >更改图标</a></span>
							</span>
					</span>
				</li>
				<li><span class="field">IP范围：</span>
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
			<div  id="ipAddArea" model="edit" class="pop-div">
				<div class="pop-top-l">
					<div class="pop-top-r">
						<div class="pop-top-m">
							<a id="closeBtnForIPAddArea" class="win-ico win-close"></a>
							<span class="pop-top-title">添加</span>
						</div>
					</div>
				</div>
				<div class="pop-middle-l">
					<div class="pop-middle-r">
						<div class="pop-middle-m">
							<div class="pop-content">
								<ul class="fieldlist-n">
									<li>
										<input type="radio" id="addIP" name="ipType" value="1" checked><label for="addIP">增加IP地址</label>
										<input type="radio" id="addIPArea" name="ipType" value="2"><label for="addIPArea">增加IP地址段</label>
									</li>
									<li>
										<span >请输入IP地址：</span><input type="text" id="ipAddr">
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
  </div>
  <div class="pop-bottom-l">
		<div class="pop-bottom-r">
			<div class="pop-bottom-m">
			   &nbsp;&nbsp;&nbsp;
			   <span id="cancelBtn" class="win-button"><span class="win-button-border"><a>取消</a></span></span>
			   &nbsp;&nbsp;
			   <span id="execBtn" class="win-button"><span class="win-button-border"><a>确定</a></span></span>
			</div>
		</div>
  </div>
</div>
</body>
</html>
