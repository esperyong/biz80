<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!--
 author:
 description:图片上传
 uri:{domainContextPath}/bizsm/bizservice/ui/imageupload
 -->
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>新建服务</title>
<link href="${ctx}/css/portal.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="${ctx}/js/bizservice/ajaxcommon.js"></script>
<script>
$(
		function(){
			$("#upload").click(
				function(){
					var imageName = $("#imageName").val();
					var fileContentName = $("#imageFile").val();
					validate(imageName,fileContentName);
				}
			);
		}
);

function validate(imageName,fileContentName){
	$.ajax({
		  type: 'POST',
		  url: "${ctx}/folder/bizsm-model-icon/image/",
		  contentType: "application/x-www-form-urlencoded",
		  data: "imageName=" + imageName + "&fileContentName=" + fileContentName,
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
			    upload();
		  }
	});
}

function upload(){
	$("#aform").submit();
	//alert("上传成功!");
}
function success(uri){
	//alert("上传成功!" + uri);
	var _information  = top.information();
	_information.setContentText("上传成功!" + uri);
	_information.show();
}
</script>
</head>
<body>
	<form id="aform" enctype="multipart/form-data" action="${ctx}/folder/bizsm-model-icon/image/" method="post" target="iframe_asyncupload" >
		<input type="text" id="imageName" name="imageName"/>
		<input class="input" type="file" id="imageFile" name="imageFile" />
		<input id="upload" type="button" value="upload"/>
	</form>
	<iframe name="iframe_asyncupload" style="border: 0;width: 0px;height: 0px;"></iframe>
</body>
</html>
