<!--机房-机房定义-图片管理-上传图片addCustomImageInfo.jsp-->
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<%@ page import="java.util.*,com.opensymphony.xwork2.util.*"%> 
<title>上传图片</title>
<link rel="stylesheet" href="${ctx}/css/validationEngine.jquery.css" 
	type="text/css" media="screen" title="no title" charset="utf-8" />
<link rel="stylesheet" href="${ctx}/css/common.css"
	type="text/css" />
<link rel="stylesheet" href="${ctx}/css/public.css"
	type="text/css" />
<link rel="stylesheet" href="${ctx}/css/UIComponent.css" type="text/css" />	
<script src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script src="${ctx}/js/jquery.validationEngine-cn.js" type="text/javascript"></script>
<script src="${ctx}/js/jquery.validationEngine.js" type="text/javascript"></script>
</head>
<%
String saveFlag = "";
String typeid = "";
	ValueStack vs = (ValueStack)request.getAttribute("struts.valueStack");
	if(null != vs && !"".equals(vs)){
		if(vs.findValue("saveFlag") != null && !"".equals(vs.findValue("saveFlag"))){
			saveFlag = (String)vs.findValue("saveFlag");
		}
		if(vs.findValue("typeid") != null && !"".equals(vs.findValue("typeid"))){
			typeid = (String)vs.findValue("typeid");
		}
	}
	String error = request.getParameter("error");
	if(error != null && !error.equals("")){
		if(error.equals("1")){
			%>
			<script type="text/javascript">
				alert("上传文件大小不能超过2mb");
			</script>
			<%
		}
	}
	
	
%>
<script type="text/javascript">
if("<%=saveFlag%>" == "saveOK") {
	if("<%=typeid%>" == "background"){
		window.opener.tab2Fun();
	}else{
		window.opener.tab1Fun();
	}
	window.close();
}
//验证不为空 上传文件类型错误
function validatorFun(){
	var upload = $("#upload").val();
	var bool = checkUploadFile(upload);
	var haveFlag = $("#oldName").val();
	var nameLengthFlag = checkUploadFileName(upload);
	
	try{
	var tabval = window.opener.$("#tabChange").val();
	}catch(e){
		tabval = "tab1";
	}
	if(null != haveFlag && haveFlag != "") {//更新时不上传新图片默认还有旧的
		document.Upload.action="${ctx}/roomDefine/AddCustomImageVisit!updateImage.action?tabChange="+tabval;
	}
	/*
	if (!nameLengthFlag){
		alert("文件名不能超过10个字符");
		return false;
	}
	*/
	if(upload == null || upload == ""){
		if(null != haveFlag && haveFlag != "") {//更新时不上传新图片默认还有旧的
			document.Upload.submit();
			return true;
		}else {
			alert("上传路径不允许为空");
			return false;
		}
	}else if(!bool){
		alert("上传格式不符");
		return false;
	}else{
		document.Upload.submit();
		return true;
	}
}

//过滤上传格式
function checkUploadFile(upload) {
	var file1 = "jpg";
	var file2 = "jpeg";
	var file3 = "gif";
	var file4 = "png";
	var file5 = "swf";
	var fileCheck = upload;
	if(fileCheck != "")
	{
		var s = fileCheck.match(/^(.*)(\.)(.{1,8})$/)[3];
		s = s.toLowerCase();
		var bM = false;
		if(s == file1 || s == file2 || s == file3 || s == file4 || s == file5) bM=true;
		if(!bM){
			document.getElementById("upload").value='';//清空file框
			return false;
		}
	}
	return true;
}

// 过滤图片名称长度
function checkUploadFileName(fileName){
	var thisFileName = fileName+""; 
	var thisWords = thisFileName.split("\\");
	var theName = thisWords[thisWords.length-1].split('.');
	
	if (theName[0].length>10){
		return false;
	}
	
	return true;
}

//屏蔽输入
function DisabledKeyInput(){
   if(event.keyCode!=8&&event.keyCode!=46) event.returnValue=false;
   if(event.ctrlKey) return false;
}

function reset(){
	$('form#uploadForm')[0].reset();
}



$(document).ready(function() {
	$("#uploadForm").validationEngine({
		promptPosition:"centerRight", 
		validationEventTriggers:"keyup blur change",
		inlineValidation: true,
		scroll:false,
		success:false
	})
});

</script>
<body > 
<page:applyDecorator name="popwindow"  title="上传自定义图片">
	
	<page:param name="width">500px;</page:param>
	<page:param name="topBtn_index_1">1</page:param>
	<page:param name="topBtn_id_1">closeId</page:param>
	<page:param name="topBtn_css_1">win-ico win-close</page:param>
	
	<page:param name="bottomBtn_index_1">1</page:param>
	<page:param name="bottomBtn_id_1">submit</page:param>
	<page:param name="bottomBtn_text_1">确定</page:param>
	
	<page:param name="bottomBtn_index_2">2</page:param>
	<page:param name="bottomBtn_id_2">cancel</page:param>
	<page:param name="bottomBtn_text_2">取消</page:param>
	
	<page:param name="content">
<form id="uploadForm" name="Upload" action="${ctx}/roomDefine/AddCustomImageVisit!uploadPicture.action" method="post" enctype="multipart/form-data">
	<ul style="background:#fff" style="left:10px;position:relative">
		<li style="height:5px"></li>
		<li style="height:25px"><span  class="field-middle ">图片名称：</span><input type="text"
		class="validate[noSpecialStr,length[0,10]]" name="imageName" id="imageName" size="30"
		value="<s:property value='imageName'/>" /><span class="red">*</span></li>
		<li style="height:25px"><span  class="field-middle ">图片文件：</span><input id="text" type="text" size="30" onKeyDown="DisabledKeyInput();"/><span class="red">*</span>
		<span style="width:200px">
		<span class="black-btn-l" style="position:absolute"><span class="btn-r"><span class="btn-m"><a id="liulanId">浏览</a></span></span></span>
		<input type="file" name="upload" width="40" onKeyDown="DisabledKeyInput();"  value="" id="upload" class="" style="position:relative;z-index:2;width:40px;filter:alpha(opacity=0);-moz-opacity:.0;opacity:0.0; cursor:pointer;"/>
		</span>
		</li>
	</ul>
	<ul style="background:#fff" class="panel-multili">
		<li>说明：1.图片只能上传 jpg、jpeg、gif、png这几种格式。</li>
		<!-- <li style="text-indent: 36px;">2.为方便图片自动调节大小不失真建议上传矢量图。</li> -->
		<li style="text-indent: 36px;">2.图片大小不能超过2M。</li>
	</ul>
<input type="hidden" name="typeid" id="typeid" value="<s:property value='typeid' />" />
<input type="hidden" name="oldName" id="oldName" value="<s:property value='imageName'/>" />
<input type="hidden" name="oldUploadFileName" id="oldUploadFileName" value="<s:property value='oldUploadFileName' />" />
<input type="hidden" name="catalog" id="catalog" value="<s:property value='catalog' />" />
</form>
</page:param>
</page:applyDecorator>

  </body> 
</html>

<script type="text/javascript">
/**
 * 确定
 */
function submitFun() {
	if(!validatorFun()){
	 return false;
	}
	//submitUploadForm();
}
/**
 * 取消
 */
function cancelFun() {
	window.close();
}
$(function() {
	$("#submit").click(submitFun);
	$("#cancel").click(cancelFun);
});
function fileClick() {
	$("#text").val($("#upload").val());
}
$("#upload").change(fileClick);

</script>