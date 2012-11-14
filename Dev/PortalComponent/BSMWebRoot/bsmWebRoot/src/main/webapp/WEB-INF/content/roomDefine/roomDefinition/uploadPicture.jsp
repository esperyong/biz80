<!--机房-机房定义-上传图片-->
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<%@ page import="com.opensymphony.xwork2.util.*"%> 
<title>上传图片</title>
<link rel="stylesheet" href="${ctx}/css/validationEngine.jquery.css" type="text/css" media="screen" title="no title" charset="utf-8" />
<link rel="stylesheet" href="${ctx}/css/common.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/public.css" type="text/css" />
<script src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script src="${ctx}/js/jquery.validationEngine-cn.js" type="text/javascript"></script>
<script src="${ctx}/js/jquery.validationEngine.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/js/room/UnityObject.js"></script>
</head>
<%
String folderAllPathName = "";
String folderName = "";	
String flashFolderStr = "";
String fileType = "";
String filePath = "";
	//获取封装输出信息的ValueStack对象
	ValueStack vs = (ValueStack)request.getAttribute("struts.valueStack");
	//调用ValueStack的findValue方法获取UploadPictureAction属性值
	if(null != vs && !"".equals(vs)){
		if(vs.findValue("folderAllPathName") != null && !"".equals(vs.findValue("folderAllPathName"))){
			folderAllPathName = (String)vs.findValue("folderAllPathName");
			folderName = (String)vs.findValue("folderName");
			fileType = (String)vs.findValue("fileType");
			
			if(null != folderAllPathName && !"".equals(folderAllPathName)){
				folderAllPathName = folderAllPathName.replaceAll("\\\\", "//");
			}
			if(folderAllPathName.indexOf("upload")>0){
				String []str = folderAllPathName.split("upload");
				flashFolderStr = "/flash/upload"+str[1];
			}
			//out.println("folderAllPathName:"+folderAllPathName);
			//out.println("flashFolderStr:"+flashFolderStr);
			//out.println("folderName:"+folderName);
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
	var file2 = "rar";
	var fileCheck = upload;
	var thisReturn = true;
	if(fileCheck != "")
	{
		var s = fileCheck.match(/^(.*)(\.)(.{1,8})$/)[3];
		s = s.toLowerCase();
		var bM = false;
		if(s == file1 || s == file2) bM=true;
		if(!bM){
			document.getElementById("upload").value='';//清空file框
			document.getElementById("txt").value='';
			thisReturn = false;
		}
	}
	
	/*
	if(fileCheck.substr(fileCheck.length-4,3) != file1 && fileCheck.substr(fileCheck.length-4,3) != file2 ){
		return false;
	}
	*/
	return thisReturn;
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
	}catch(e){
	}
	try{
	var arrRadio = window.parent.document.getElementsByName("disType");
	arrRadio[0].disabled="";
	arrRadio[1].disabled="";
	}catch(e){
		alert("不能单独访问此页");
		window.close();
	}
});

</script>

<form id="uploadForm" name="Upload" action="${ctx}/roomDefine/UploadPicture.action" method="post" enctype="multipart/form-data">
	<ul class="fieldlist-n">
			<li>
			<span class="field">机房模型</span>
			<span>：<input type="text" id="txt" name="txt" value="<%=flashFolderStr %>" size="30" style="width:130px"  class="validate[required]" onKeyDown="DisabledKeyInput()"/><span class="red">*</span></span>
			
			<span style="width:50px">
				<span class="gray-btn-l" style="position:absolute"><span class="btn-r"><span class="btn-m"><a id="liulanId">浏览</a></span></span></span>
				<input type="file" name="upload" value="" class="validate[required]" id="upload" onKeyDown="DisabledKeyInput();" onchange="txt.value=this.value" style="position:relative;z-index:0;width:0px;left:-30px;filter:alpha(opacity=0);-moz-opacity:.0;opacity:0.0;cursor:pointer;" size="5" ></input>
			</span>
			<span class="gray-btn-l" style="position:relative;top:1px"><span class="btn-r"><span class="btn-m"><a id="Upload_0" onclick="return validatorFun();" style="cursor: pointer">上传</a></span></span></span>
			
			<br/><span class="txt-red"> 注：将制作好的3D机房压缩包上传，格式支持.zip。 </span>&nbsp;&nbsp;
			</li>
		<li > 
		
		<div id="previewborder" style="border-color:#0000CC; border:1px 1px solid #000000;height: 140px;width:98%">
			<span class="field" style="position:relative;top:48%;left:45%">预览区</span>
		</div>
		<div class="border-gray" style="display: none" id="un3dId">
		<div class="content">
			<div id="unityPlayer">
			<div class="missing"><a href="http://unity3d.com/webplayer/"
				title="Unity Web Player. Install now!"> <img
				alt="Unity Web Player. Install now!"
				src="http://webplayer.unity3d.com/installation/getunity.png"
				width="193" height="63" /> </a></div>
			</div>
		</div>
		</div>
		
	</li>
	</ul>
	
	<input type="hidden" name="fileType" value="<s:property value='fileType' />" />
	<input type="hidden" name="uploadFileName" value="" />
</form>
<iframe id="ifrBox" frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" style="display:none;position:absolute; width:35%; height:130;  right: 0px; bottom: 5px"></iframe>
<script type="text/javascript">

var $span = $("<html><body><div style='height:100%;width:100%;background-color:#000000'></div></body></html>");
$("#ifrBox").find("*").unbind();
$("#ifrBox").html("");
$("#ifrBox").append($span);
//document.getElementById("ifrBox").src = $span;

//全局变量，用于存储wpf实例
var wpfObject;

function GetUnity() {
	if (typeof unityObject != "undefined") {     
		return unityObject.getObjectById("unityPlayer");
	}
	return null;
}

if (typeof unityObject != "undefined" &&"<%=flashFolderStr%>" != "" ) {
	$("#un3dId").show("fast");
		
	$("#previewborder").hide();
    var params = {
        disableContextMenu: true,
        backgroundcolor: "000000",
        bordercolor: "000000",
        textcolor: "FFFFFF",
        logoimage: "${ctx}/flash/logo.png",
        hostURL : "${ctx}"
    };
	unityObject.embedUnity("unityPlayer", "${ctx}<%=flashFolderStr%>", "100%", "170", params, null, unityLoaded);
	document.getElementById("ifrBox").style.display="block";
}

//调用unity3d的方法: 只是unity对象加载完成，模型内容尚未加载，
//因此这时候调用SendMessage还不行
function unityLoaded()
{
  
}

//Unity组件加载完成，这是最早的事件
function loaded(text)
{
    alert("test loaded ok: " + text);
}

//Unity将模型加载完成之后调用init方法，一般在这里加载Unity逻辑模型，浏览器不需要直接调用
function init()
{
    //加载模型
    //机房
    if(document.getElementById("un3dId").style.display=="block") {
    		LoadInternalModel();      
    }
}

//Unity调用这个方法，读取客户端配置
function configUnity()  //setModelName ==> configUnity
{
    //设置模型类型：MachineRoom/Floor，这个值决定了刷新数据的类
    //机房
    GetUnity().SendMessage("root", "setModelName", "MachineRoom");                
    
    //设置模型状态： runtime/design/browse，三种模式可选
    GetUnity().SendMessage("root", "ChangeState", "browse")
}

//通知Unity加载物体模型（不包含代码逻辑的模型，一般是有3d模型文件直接转换而成的）
function LoadModel(url)
{
    GetUnity().SendMessage("root", "LoadModel", url);
}
//通知Unity加载物体模型（不包含代码逻辑的模型，一般是有3d模型文件直接转换而成的）
function LoadInternalModel()
{
    GetUnity().SendMessage("root", "LoadInternalModel", "");
}
//Unity加载物体模型完成后调用这个方法
function LoadModelCompleted()
{                                
    //root.SetRefreshUrl(string url, int 刷新时间间隔秒数);
    //GetUnity().SendMessage("root", "SetRefreshInterval", 60);
}

//model
var ModelName;

//模型加载完成，为了能够让浏览器客户端能够对模型进行一些视角的调整，增加这个方法
function customizeModel(modelName)
{
    ModelName = modelName;
    //alert(modelName + ": wait ...");
    
    GetUnity().SendMessage(modelName, "Zoom", 10);
    GetUnity().SendMessage(modelName, "RotateLeft", 0);
    GetUnity().SendMessage(modelName, "RotateDown", 0);
    
}

</script>
