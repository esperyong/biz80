<!-- WEB-INF\content\location\define\upload3dfile.jsp -->
<!--机房-机房定义-上传图片-->
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.util.*,com.opensymphony.xwork2.util.*"%> 
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>上传3D文件</title>

<link rel="stylesheet" href="${ctxCss}/validationEngine.jquery.css" type="text/css" media="screen" title="no title" charset="utf-8" />
<link rel="stylesheet" href="${ctxCss}/common.css" type="text/css" />
<script src="${ctxJs}/jquery-1.4.2.min.js"></script>
<script src="${ctxJs}/jquery.validationEngine-cn.js" type="text/javascript"></script>
<script src="${ctxJs}/jquery.validationEngine.js" type="text/javascript"></script>
</head>
<%
String folderAllPathName = "";
String folderName = "";	
String flashFolderStr = "";
	//获取封装输出信息的ValueStack对象
	ValueStack vs = (ValueStack)request.getAttribute("struts.valueStack");
	//调用ValueStack的findValue方法获取UploadPictureAction属性值
	if(null != vs && !"".equals(vs)){
		if(vs.findValue("folderAllPathName") != null && !"".equals(vs.findValue("folderAllPathName"))){
			folderAllPathName = (String)vs.findValue("folderAllPathName");
			folderName = (String)vs.findValue("folderName");
			
			if(null != folderAllPathName && !"".equals(folderAllPathName)){
				folderAllPathName = folderAllPathName.replaceAll("\\\\", "//");
			}
			if(folderAllPathName.indexOf("upload")>0){
				String []str = folderAllPathName.split("upload");
				flashFolderStr = "/upload"+str[1];
			}
			out.println("folderAllPathName:"+folderAllPathName);
			out.println("flashFolderStr:"+flashFolderStr);
			out.println("folderName:"+folderName);
		}
	}
	String error = request.getParameter("error");
	if(error != null && !error.equals("")){
		if(error.equals("1")){
			%>
			<script type="text/javascript">
				alert("上传文件大小不能超过1mb");
			</script>
			<%
		}
	}
	
	
%>
<script type="text/javascript">
//验证不为空 上传文件类型错误
function validatorFun(){
	var upload = $("#upload").val();
	var bool = checkUploadFile(upload);
	//alert(title + "+" + upload);
	if(upload == null || upload == ""){
		alert("上传路径不允许为空");
		return false;
	}else if(!bool){
		alert("上传格式不符");
		return false;
	}else{
		document.uploadForm.submit();
		return true;
	}
}

//过滤上传格式
function checkUploadFile(upload) {
	var file1 = "zip";
	//var file2 = "rar";
	var fileCheck = upload;
	if(fileCheck != "")
	{
		var s = fileCheck.match(/^(.*)(\.)(.{1,8})$/)[3];
		s = s.toLowerCase();
		var bM = false;
		if(s == file1) bM=true;
		if(!bM){
			document.getElementById("upload").value='';//清空file框
			return false;
		}
	}
	return true;
}

//屏蔽输入
function DisabledKeyInput(){
   if(event.keyCode!=8&&event.keyCode!=46) event.returnValue=false;
   if(event.ctrlKey) return false;
}

function reset(){
	$('form#Upload')[0].reset();
}



$(document).ready(function() {
	//var aa = parent.document.getElementById("imgName").value;
	try{
	parent.$("#imgName").val('<%=folderAllPathName%>');
	parent.$("#folderName").val('<%=folderName%>');
	}catch(e){
	}
	try{
	var arrRadio = window.parent.document.getElementsByName("location.flashType");
	arrRadio[0].disabled="";
	arrRadio[1].disabled="";
	arrRadio[2].disabled="";
	}catch(e){
		alert("不能单独访问此页");
		window.close();
	}
});

</script>
<body> 
<form id="uploadForm" name="Upload" action="${ctx}/location/define/upload3dfile.action" method="post" enctype="multipart/form-data">
	<ul class="fieldlist-n">
		<li>
		<span class="field">3D模型:</span>
		<input type="file" name="upload" value="" id="upload" onKeyDown="DisabledKeyInput();" class="validate[required]" />
		<span><span><span><a id="Upload_0" onclick="return validatorFun();" style="cursor: pointer">上传</a></span></span></span>
		<span class="red">注：将用到的.3ds文件及其贴图制作成压缩包上传。</span>&nbsp;&nbsp;
		</li>
		<li >
		<span class="field" style="vertical-align:top;">预览:</span>
		<div class="border-gray" style="display:none" id="flashId">
		<iframe width="300" height="165" scrolling="no" src="${ctx}/flash/filePreview.xbap" ></iframe>
		</div>
		</li>
	</ul>
</form>
  </body> 
</html>

<script type="text/javascript">

//全局变量，用于存储wpf实例
var wpfObject;

//保存wpf传递过来的变量
function init(managedObject){
	if("<%=flashFolderStr%>" == ""){
		return;
	}
	$("#flashId").show("slow");
	wpfObject = managedObject;
foo();
}

//调用wpf的方法
function foo(){
	//alert("<%=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()%>${ctx}/flash"+"<%=flashFolderStr%>");
	wpfObject.CallBack("<%=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()%>${ctx}/flash"+"<%=flashFolderStr%>");
}

</script>