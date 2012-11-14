<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!-- 
	author:liuyong,liuhw
	description:添加业务服务
	uri:{domainContextPath}/bizsm/bizservice/ui/addnewbizservice
 -->
<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>新建服务</title>
<link href="<%=request.getContextPath()%>/css/portal.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/css/portal02.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/bizservice/ajaxcommon.js"></script>
<script>
	$(
			function(){
				$("#confirm").click(
					function(){
						OK();
					}
				);
			}
	);
	
	$(
			function(){
				$("#concel").click(
					function(){
						Cancel();
					}
				);
			}
	);	
	
	$(
			function(){
				$("#close").click(
					function(){
						Cancel();
					}
				);
			}
	);
	
	String.prototype.trim=function(){
   		return this.replace(/(^\s*)|(\s*$)/g, "");
	}
	
	function OK(){
		//var name = $("#model\\.name").attr("value");
		var name = document.getElementById("model.name").value;
		if(name.trim() == ""){
			alert("服务名称不允许为空。");
			document.getElementById("model.name").focus();
			return;
		}
		if(name.length > 50){
			alert("服务名称的输入长度不能超过50个字符。");
			document.getElementById("model.name").focus();
			return;
		}
		var formparamsdata = get_form_params('newForm');
		var domain = document.getElementById("model.belongDomainIds");
		$.each( domain, function(i, n){
			formparamsdata+="&"+domain.id+"="+n.value;
		});
		
		var httpClient;
		$.ajax({
			  type: 'POST',
			  url: "<%=request.getContextPath()%>/bizservice/.xml",
			  contentType: "application/x-www-form-urlencoded",
			  data: 'xhr=1&' + formparamsdata,
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
				  var uri = httpClient.getResponseHeader("Location");
				  window.returnValue = uri;
				  window.close();
			  }			  		  
		});	

		
	}
		
	function Cancel(){
		window.close();
	}
	
</script>
</head>
<body>
	<form id="newForm" name="newForm"  action="self">
	<div class="roundedform">
	<div class="roundedform-top">
		<div class="top-right">
		  <div class="top-min">
				<table class="hundred"><thead><tr><th>
				<div class="theadbar">
				            <a id="close" class="win-ico win-close"></a>
							<div class="theadbar-name">新建服务</div>
						</div></th></tr></thead></table>
			</div>
		</div>
	</div>
	<div class="roundedform-content02">
	    <div><ul class="fieldlist">
					<li>
						<span class="field">服务名称：</span>
						<input id="model.name" name="model.name" type="text" value="" size="30" />
				<span class="red">*</span>
					</li>
					<li><span class="field">所属域：</span>
					<select id="model.belongDomainIds" name="model.belongDomainIds" multiple="multiple" size="4"> 
					<option value="bj">北京</option>
					<option value="sh">上海</option>
					<option value="tj">天津</option>
				</select>
				<span class="ico ico-find"></span>
				<span class="red">*</span></li>
					<li class="last">
					   <span class="black-btn02-l black-btn02-l-blank"><span class="btn-r"><span id="concel" class="btn-m"><a >取消</a></span></span></span>
					   <span class="black-btn02-l  black-btn02-l-blank"><span class="btn-r"><span id="confirm" class="btn-m"><a >确定</a></span></span></span>					</li>
					</li>
				</ul>
		</div>
	</div>
	<div class="roundedform-bottom">
		<div class="bottom-right">
			<div class="bottom-min"></div>
		</div>
	</div>
</div>
	</form>
</body>
</html>