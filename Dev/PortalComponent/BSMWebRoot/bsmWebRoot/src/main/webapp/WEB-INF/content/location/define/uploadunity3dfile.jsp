<!-- WEB-INF\content\location\define\uploadunity3dfile.jsp -->
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
<script type="text/javascript" src="${ctx}/js/room/UnityObject.js"></script>
<script src="${ctx}/js/component/cfncc.js"></script>
<script src="${ctx}/js/component/toast/Toast.js"></script>
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
			if(folderAllPathName.indexOf("location")>0){
				String []str = folderAllPathName.split("location");
				flashFolderStr = "/location"+str[1];
			}
			
		}
		//out.println("folderAllPathName:"+folderAllPathName+"<br>");
		//out.println("flashFolderStr:"+flashFolderStr+"<br>");
		//out.println("folderName:"+folderName+"<br>");
	}else{
		//out.println("folderAllPathName:"+folderAllPathName+"<br>");
		//out.println("flashFolderStr:"+flashFolderStr+"<br>");
		//out.println("folderName:"+folderName+"<br>");
	}
	String error = request.getParameter("error");
	if(error != null && !error.equals("")){
		if(error.equals("1")){
			%>
			<script type="text/javascript">
				window.parent.showMess("上传文件大小不能超过5mb");
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
		window.parent.showMess("上传路径不允许为空");
		return false;
	}else if(!bool){
		window.parent.showMess("上传格式不符");
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

function showDIV1(){
	document.getElementById("content").style.width="730px";
	document.getElementById("contentShow").style.display="none";
}

$(document).ready(function() {
	//var aa = parent.document.getElementById("imgName").value;
	try{
	parent.$("#imgName").val('<%=flashFolderStr%>');
	//parent.$("#imgName").val('<%=folderAllPathName%>');
	//parent.$("#folderName").val('<%=folderName%>');
	}catch(e){
	}
	try{
	var arrRadio = window.parent.document.getElementsByName("location.flashType");
	arrRadio[0].disabled="";
	arrRadio[1].disabled="";
	arrRadio[2].disabled="";
	}catch(e){
		alert("不能单独访问此页");
	    //window.close();
	}
});

</script>
<body> 
<form id="uploadForm" name="Upload" action="${ctx}/location/define/upload3dfile!uploadUnity3D.action" method="post" enctype="multipart/form-data">
	<ul class="fieldlist-n">
		<li>
		<span class="field">Unity3D模型:</span>
		<input type="file" name="upload" value="" id="upload" onKeyDown="DisabledKeyInput();" class="validate[required]" />
		<span><a id="Upload_0" onclick="return validatorFun();" style="cursor: pointer">
			<input style="width:40px;cursor: pointer;" type="button" value="上传"/>
			</a></span>
		
		<span class="red">注：将用到的.unity3d文件及其贴图制作成压缩包上传。</span>&nbsp;&nbsp;
		</li>
		<li >
		<span class="field" style="vertical-align:top;">预览:</span>
		<div class="border-gray" style="display:none" id="un3dId">
		<div id="content" class="content" style="float:left;overflow:hidden; width:550px;overflow-x:hidden">
			<div id="unityPlayer">
			<div class="missing">
			<a href="http://unity3d.com/webplayer/" title="Unity Web Player. Install now!"> 
			<img alt="Unity Web Player. Install now!" src="http://webplayer.unity3d.com/installation/getunity.png" width="193" height="163" /> 
			</a>
			</div>
			</div>
		</div>
		<div id="contentShow" class="content" style="float: left;width: 150px;height:300px; background-color:#000;border-style:solid;border-color:#cccccc;border-width:1px">
<pre style="font-size:8px;color:#fff;">
	
<b style="font-size:11px;">    支持3D展现</b>

  物理位置使用3D图片来展
  现楼层。用户在新建楼层
  时，将3D文件打包上传，
  即可展现3D楼层。 

<b style="font-size:11px;">  体现整体组织结构或</b>
<b style="font-size:11px;">  地域分布</b>
 
  可按公司整体的组织结构
  或地域分布，在物理位置
  中进行定义，一目了然，
  查看公司整体分布。

<b style="font-size:11px;">  和机房的关联</b> 
 
  在从整体定义了物理位置
  之后，针对单个的物理位
  置，例如某个房间、某个
  机房，可关联具体的设备
  ，并且当设备异常时，从
  物理位置的整体视图中能
  够清晰的定位到故障设备
  所在。当故障解决后，可
  在物理位置中快速验证。
</pre>		</div>
		</div>
		</li>
	</ul>
		<input type="hidden" name="uploadFileName" value="" />
		<input type="hidden" name="filePath" value="<%=flashFolderStr %>" />
</form>
</body> 
</html>

<script type="text/javascript">
var url="<%=request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()%>${ctx}";

function GetUnity() {
	if (typeof unityObject != "undefined") {
		return unityObject.getObjectById("unityPlayer");
	}
	return null;
}

if (typeof unityObject != "undefined"&&"<%=flashFolderStr%>" != "") {

$("#un3dId").show("slow");	
setTimeout("showDIV1()",15000);
	 var params = {
                disableContextMenu: true,
                backgroundcolor: "000000",
                bordercolor: "000000",
                textcolor: "FFFFFF",
                logoimage: "${ctx}/flash/logo.png"
                //progressbarimage: "MyProgressBar.png",
                //progressframeimage: "MyProgressFrame.png"
            };
           
    //var WebPlayer_url=url+"/flash/location/unity3d/WebPlayer.unity3d";
    var WebPlayer_url=url+"/flash<%=flashFolderStr%>";
	unityObject.embedUnity("unityPlayer", WebPlayer_url, "730", "300", params);
}



//保存wpf传递过来的变量
function init(){
		//alert(floor_Url);
		//加载模型楼层
		//var floor_Url=url+"/flash<%=flashFolderStr%>";
		//LoadModel(floor_Url);
		//非加载模式
		LoadInternalModel();
		
}
//设置模型类别，可选值：MachineRoom、Floor，这个值决定了刷新数据的类
//function setModelName(){
function configUnity(){
        //楼层
        GetUnity().SendMessage("root", "setModelName", "Floor");
        //设置模型状态： runtime/design/browse，三种模式可选
        GetUnity().SendMessage("root", "ChangeState", "browse");
}  
function LoadModelCompleted(){                                
         //root.SetRefreshUrl(string url, int 刷新时间间隔秒数);
         //GetUnity().SendMessage("root", "SetRefreshInterval", 20);
         //loadData();
}
//非通知Unity加载模型方式
function LoadInternalModel()
{
    GetUnity().SendMessage("root", "LoadInternalModel", "");
}

/*通知Unity加载模型方式
function LoadModel(url){
     GetUnity().SendMessage("root", "LoadModel", url);
}*/
 //设置模型类别，可选值：MachineRoom、Floor，这个值决定了刷新数据的类
function setModelName(){
    //楼层
    GetUnity().SendMessage("root", "setModelName", "Floor");
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
//右键弹出属性框
function showProperty(objectId) {
	//window.open("${ctx}/location/design/node3dattribute.action?locationId=${locationId}"+"&type="+objectId);
}

//清除属性
function removeProperty(objectId) {
	//$("#removeProp").load("${ctx}/location/design/locationmap3d.action?locationId=${locationId}"+"&componentId="+objectId);
}

function suspendProp(objectId)
{
    //selectedModel3d.innerHTML = "显示提示："+objectId;
}
</script>