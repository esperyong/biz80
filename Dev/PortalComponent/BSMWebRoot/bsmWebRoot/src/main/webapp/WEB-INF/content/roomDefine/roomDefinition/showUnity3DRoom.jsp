<!-- 机房-机房定义-显示Unity3D图形 showUnify3DRoom.jsp -->
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<head>
<%@ include file="/WEB-INF/common/meta.jsp"%>
<%@ page import="com.opensymphony.xwork2.util.*"%>
<title>显示Unity3D图形</title>
<link rel="stylesheet" href="${ctx}/css/validationEngine.jquery.css"
	type="text/css" media="screen" title="no title" charset="utf-8" />
<link rel="stylesheet" href="${ctx}/css/pubilc.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/common.css" type="text/css" />
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx}/js/room/UnityObject.js"></script>
<%
	String roomId = request.getParameter("roomId");
	String url = request.getParameter("url");
	String viewFileName = "";
	String filePath = "";
	//获取封装输出信息的ValueStack对象
	ValueStack vs = (ValueStack) request
			.getAttribute("struts.valueStack");
	//调用ValueStack的findValue方法获取UploadPictureAction属性值
	if (null != vs && !"".equals(vs)) {
		if (vs.findValue("viewFileName") != null
				&& !"".equals(vs.findValue("viewFileName"))) {
			viewFileName = (String) vs.findValue("viewFileName");

			if (null != viewFileName && !"".equals(viewFileName)) {
				viewFileName = viewFileName.replaceAll("\\\\", "//");
				String[] temp = viewFileName.split("/");
				filePath = "/flash/upload/"+temp[temp.length-2]+"/"+temp[temp.length-1];
			}
		}
	}
%>
<script type="text/javascript">

function GetUnity() {

	if (typeof unityObject != "undefined") {
		return unityObject.getObjectById("unityPlayer");
	}
	return null;
}

if (typeof unityObject != "undefined") {
    var params = {
        disableContextMenu: true,
        backgroundcolor: "000000",
        bordercolor: "000000",
        textcolor: "FFFFFF",
        logoimage: "${ctx}/flash/logo.png",
        hostURL : "${ctx}"
        //progressbarimage: "MyProgressBar.png",
        //progressframeimage: "MyProgressFrame.png"
    };
    browserinfo();

	if (navigator.Actual_Version != "8.0"){
		unityObject.embedUnity("unityPlayer", "${ctx}<%=filePath%>", $("#dynamicJspId").width(), $(this).height()*0.8, params, null, unityLoaded);
		$("#frmHelp").height($(this).height());
	}else{
		unityObject.embedUnity("unityPlayer", "${ctx}<%=filePath%>", "100%","90%", params, null, unityLoaded);
	}
	//unityObject.embedUnity("unityPlayer", "${ctx}<%=filePath%>", $("#dynamicJspId").width(), $(this).height()*0.9, params, null, unityLoaded);
	
    //unityObject.embedUnity("unityPlayer", "${ctx}<%=filePath%>", "100%","90%", params, null, unityLoaded);
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
    //LoadModel("<%=request.getScheme() + "://" + request.getServerName()+ ":" + request.getServerPort()%>${ctx}<%=filePath%>");  
	LoadInternalModel();              
    //LoadModel("http://192.168.30.67:8080/bsm80/unity3d/AssetBundle/MachineRoomBTV.unity3d");
}

//Unity调用这个方法，读取客户端配置
function configUnity()  //setModelName ==> configUnity
{
    //设置模型类型：MachineRoom/Floor，这个值决定了刷新数据的类
    //机房
    GetUnity().SendMessage("root", "setModelName", "MachineRoom");                
    
    //设置模型状态： runtime/design/browse，三种模式可选
    GetUnity().SendMessage("root", "ChangeState", "design");
}

//通知Unity加载物体模型（不包含代码逻辑的模型，一般是有3d模型文件直接转换而成的）
function LoadInternalModel()
{
    GetUnity().SendMessage("root", "LoadInternalModel", "");
}

//Unity加载物体模型完成后调用这个方法
function LoadModelCompleted()
{                                
    
    GetUnity().SendMessage("root", "SetRefreshInterval", 60);
    window.setTimeout(closeHelp,10000)
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
//单击模型
function clickModel(id, locationId)
{
    alert("id: " + id + ", clickLocationId: " + locationId);
}

//右键弹出属性框
function showProperty(objectId,type) {
	var winOpenObj = {};
	var src = "${ctx}/roomDefine/ResourcePropertyVisit.action?roomId=<s:property value='roomId'/>&componentId="+objectId+"&type="+type;
	var height = '335';
	winOpenObj.width = '850';
	winOpenObj.height = height;
	winOpenObj.url = src;
	winOpenObj.scrollable = true;
	winOpenObj.resizeable = false;
	winOpen(winOpenObj); 
	//window.open("${ctx}/roomDefine/ResourcePropertyVisit.action?roomId=<s:property value='roomId'/>&componentId="+objectId+"&type="+type);
}


		//清除属性
		function removeProperty(objectId) {
			$("#removeProp").load("${ctx}/roomDefine/ResourcePropertyVisit!remove.action?roomId="+"<%=roomId%>"+"&componentId="+objectId);
		}
		//导航栏设置页面层高度
		function unityZoom(height){
			$("#unityPlayer").height(height);
		}
		function saveFlash(){
		}

		//window.setTimeout(closeHelp,10000)
	    function closeHelp(){
	    	document.getElementById("frmHelp").style.display ="none";
	    }	

	    function browserinfo(){   
	    	var Browser_Name=navigator.appName;   
	    	var Browser_Version=parseFloat(navigator.appVersion);   
	    	var Browser_Agent=navigator.userAgent;   
	    	var Actual_Version,Actual_Name;
	    	var is_IE=(Browser_Name=="Microsoft Internet Explorer");//判读是否为ie浏览器   10.        
	    	var is_NN=(Browser_Name=="Netscape");//判断是否为netscape浏览器   
	    	var is_op=(Browser_Name=="Opera");//判断是否为Opera浏览器  
	        if(is_NN){   //upper 5.0 need to be process,lower 5.0 return directly  
	    		if(Browser_Version>=5.0){   
	    			if(Browser_Agent.indexOf("Netscape")!=-1){   
	    				var Split_Sign=Browser_Agent.lastIndexOf("/");   
	    				var Version=Browser_Agent.lastIndexOf(" ");  
	    				var Bname=Browser_Agent.substring(0,Split_Sign);   
	    				var Split_sign2=Bname.lastIndexOf(" ");   
	    				Actual_Version=Browser_Agent.substring(Split_Sign+1,Browser_Agent.length);
	    				Actual_Name=Bname.substring(Split_sign2+1,Bname.length);
	    			}
	    			if(Browser_Agent.indexOf("Firefox")!=-1){
	    				var Split_Sign=Browser_Agent.lastIndexOf("/");
	    				var Version=Browser_Agent.lastIndexOf(" ");
	    				Actual_Version=Browser_Agent.substring(Split_Sign+1,Browser_Agent.length);
	    				Actual_Name=Browser_Agent.substring(Version+1,Split_Sign);
	    			}
	    			if(Browser_Agent.indexOf("Safari")!=-1){
	    				if(Browser_Agent.indexOf("Chrome")!=-1){
	    					var Split_Sign=Browser_Agent.lastIndexOf(" ");
	    					var Version=Browser_Agent.substring(0,Split_Sign);
	    					var Split_Sign2=Version.lastIndexOf("/");
	    					var Bname=Version.lastIndexOf(" ");
	    					Actual_Version=Version.substring(Split_Sign2+1,Version.length);
	    					Actual_Name=Version.substring(Bname+1,Split_Sign2);
	    				}else{
	    					var Split_Sign=Browser_Agent.lastIndexOf("/");
	    					var Version=Browser_Agent.substring(0,Split_Sign);
	    					var Split_Sign2=Version.lastIndexOf("/");
	    					var Bname=Browser_Agent.lastIndexOf(" ");
	    					Actual_Version=Browser_Agent.substring(Split_Sign2+1,Bname);
	    					Actual_Name=Browser_Agent.substring(Bname+1,Split_Sign);
	    				} 
	    			}
	    		}else{
	    			Actual_Version=Browser_Version;
	    			Actual_Name=Browser_Name;
	    		}
	    	}else if(is_IE){
	    		var Version_Start=Browser_Agent.indexOf("MSIE");
	    		var Version_End=Browser_Agent.indexOf(";",Version_Start);
	    		Actual_Version=Browser_Agent.substring(Version_Start+5,Version_End)
	    		Actual_Name=Browser_Name;
	    		if(Browser_Agent.indexOf("Maxthon")!=-1||Browser_Agent.indexOf("MAXTHON")!=-1){
	    			var mv=Browser_Agent.lastIndexOf(" ");
	    			var mv1=Browser_Agent.substring(mv,Browser_Agent.length-1);
	    			mv1="遨游版本:"+mv1;
	    			Actual_Name+="(Maxthon)";
	    			Actual_Version+=mv1;
	    		}
	    	}else if(Browser_Agent.indexOf("Opera")!=-1){
	    		Actual_Name="Opera";
	    		var tempstart=Browser_Agent.indexOf("Opera");
	    		var tempend=Browser_Agent.length;
	    		Actual_Version=Browser_Version;
	    	}else{
	    		Actual_Name="Unknown Navigator";
	    		Actual_Version="Unknown Version";
	    	}
	    	navigator.Actual_Name=Actual_Name;
	    	navigator.Actual_Version=Actual_Version;
	    	this.Name=Actual_Name;
	    	this.Version=Actual_Version;
	    } 	
</script>


</head>


<div class="content">
<div id="unityPlayer" style="z-index: 1;margin-left:200">
<div class="missing">
	<a href="${ctx}/flash/UnityWebPlayer.exe"
	title="Unity Web Player. Install now!"> 
	<img alt="Unity Web Player. Install now!" src="${ctx}/flash/pic/getunity.png"
	width="193" height="63" /> </a></div>
</div>
<iframe id="frmHelp" name="frmHelp" src="${ctx}/roomDefine/Show3DHelpVisit.action" scrolling="no" frameborder="0" marginheight="0" marginwidth="0" style="height:95%;width:300px;right:0px;position:absolute;top:10px;;overflow:hidden">
</iframe>
</div>
<!-- 
<iframe src="javascript:document.write('<body style=\'background-color:black\'></body>')" frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" style="position:absolute; width:140px; height:100px;  right: 0px; bottom: 10px"></iframe>
 -->
<div id="removeProp" style="display: none" />

