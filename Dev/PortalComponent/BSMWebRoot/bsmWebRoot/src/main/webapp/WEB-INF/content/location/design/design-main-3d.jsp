<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<head>
	<%@ include file="/WEB-INF/common/meta.jsp"%>
	<%@ page import="com.opensymphony.xwork2.util.*"%>
	<title>显示Unity3D图形</title>
	<link rel="stylesheet" href="${ctx}/css/validationEngine.jquery.css"
		type="text/css" media="screen" title="no title" charset="utf-8" />
	<link rel="stylesheet" href="${ctx}/css/common.css" type="text/css" />
	<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="${ctx}/js/room/UnityObject.js"></script>
<script type="text/javascript" src="${ctx}/flash/location/unity3d/CaptureScreen.js"></script>
<script type="text/javascript">
var setto;
function mapwidth(){
	return $("#totalDivId").width()-$("#layoutwestId").width();
	}
var url="<%=request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()%>${ctx}";
//document.getElementById("content_3d").style.width=(mainWidth()-190)+"px";
function showDIV1(){
	document.getElementById("content_3d").style.width=mapwidth()+"px";
	document.getElementById("contentShow").style.display="none";
}
function disDIV1(){
	document.getElementById("content_3d").style.width=(mapwidth()-190)+"px";
	document.getElementById("contentShow").style.display="block";
}


function GetUnity() {
		if (typeof unityObject != "undefined") {
				return unityObject.getObjectById("unityPlayer");
			}
			return null;
}
if (typeof unityObject != "undefined") {
	showDIV1();
	clearTimeout(setto);
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
		
		var WebPlayer_url=url+"/flash/${filePath}";
		unityObject.embedUnity("unityPlayer", WebPlayer_url, mainWidth(), "90%", params);
		disDIV1();
		setto=setTimeout("showDIV1()",15000);
}


        
//调用unity3d的方法: 只是unity对象加载完成，模型内容尚未加载，
//因此这时候调用SendMessage还不行
function unityLoaded(){
}
        
//在3d模型中选定一个对象后，显示名称
function setSelectedModel3d(name){
            //selectedModel3d.innerHTML = name;
            //alert(name);
}
            
//Unity向页面请求状态数据
function loadData() {

        	$.ajax({
        		type: "post",
        		dataType:'json', //接受数据格式 
        		cache:false,
        		data:"locationId=${locationId}", 
        		url: url+"/location/design/locationmap3d!get3DComponentXML.action",
        		beforeSend: function(XMLHttpRequest){
        		//ShowLoading();
        		},
        		success: function(data, textStatus){
        			//alert(data.xml3d);
        			GetUnity().SendMessage("root", "Refresh", data.xml3d);   
        		},
        		complete: function(XMLHttpRequest, textStatus){
        		//HideLoading();
        		},
        		error: function(){
        		//请求出错处理
        			//alert("error");
        		}
        		});
        }        
        
//右键弹出属性框
function showProperty(objectId) {
			window.open("${ctx}/location/design/node3dattribute.action?locationId=${locationId}"+"&type="+objectId);
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
<script type="text/javascript">
            
function loaded(text){
                alert("test loaded ok: " + text);
}

//设置模型类别，可选值：MachineRoom、Floor，这个值决定了刷新数据的类
//function setModelName(){
function configUnity(){
        //楼层
        GetUnity().SendMessage("root", "setModelName", "Floor");
        //设置模型状态： runtime/design/browse，三种模式可选
        GetUnity().SendMessage("root", "ChangeState", "design");
}  
          
//unity 将模型加载完成之后调用init方法
 function init(){
 		//var WebPlayer_url=url+"/flash/${filePath}";
		//加载模型楼层
		//LoadModel(WebPlayer_url);
		LoadInternalModel();
}

//非通知Unity加载模型方式
 function LoadInternalModel()
 {
     GetUnity().SendMessage("root", "LoadInternalModel", "");
 }
            
//通知Unity加载模型
function LoadModel(url){
         GetUnity().SendMessage("root", "LoadModel", url);
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
function LoadModelCompleted(){                                
                //root.SetRefreshUrl(string url, int 刷新时间间隔秒数);
         GetUnity().SendMessage("root", "SetRefreshInterval", 20);
         loadData();
}
            
//单击模型
function clickModel(id, locationId){
                //alert(id);
}

            
//在3d模型中选定一个对象后，显示名称
function setSelectedModel3d(name){
                selectedModel3d.innerHTML = name;
                //alert(name);
}
</script>
<script type="text/javascript">        
//截图完成，把图片回传给截图程序
function completeGetPng(){
                window.external.unity3dCaptureComplete(pngstr);
            }
            
//unity3d的绝对位置坐标
function unity3dLocation(){
			//return "0,200";
            var aaa= getElementPos("unityPlayer");
            return aaa.x+","+aaa.y;
}            
</script>
<script>
function getElementPos(elementId) {
 var ua = navigator.userAgent.toLowerCase();
 var isOpera = (ua.indexOf('opera') != -1);
 var isIE = (ua.indexOf('msie') != -1 && !isOpera); // not opera spoof
 var el = document.getElementById(elementId);
 if(el.parentNode === null || el.style.display == 'none') {
    return false;
 }      
 var parent = null;
 var pos = [];     
 var box;     
 if(el.getBoundingClientRect) { //IE
    box = el.getBoundingClientRect();
    var scrollTop = Math.max(document.documentElement.scrollTop, document.body.scrollTop);
    var scrollLeft = Math.max(document.documentElement.scrollLeft, document.body.scrollLeft);
    return {x:box.left + scrollLeft, y:box.top + scrollTop};
 } else if (document.getBoxObjectFor) { // gecko
    box = document.getBoxObjectFor(el); 
    var borderLeft = (el.style.borderLeftWidth)?parseInt(el.style.borderLeftWidth):0; 
    var borderTop = (el.style.borderTopWidth)?parseInt(el.style.borderTopWidth):0; 
    pos = [box.x - borderLeft, box.y - borderTop];
 } else { // safari & opera
    pos = [el.offsetLeft, el.offsetTop]; 
    parent = el.offsetParent;     
    if (parent != el) { 
     while (parent) { 
      pos[0] += parent.offsetLeft; 
      pos[1] += parent.offsetTop; 
      parent = parent.offsetParent;
     } 
    }   
    if (ua.indexOf('opera') != -1 || ( ua.indexOf('safari') != -1 && el.style.position == 'absolute' )) { 
     pos[0] -= document.body.offsetLeft;
     pos[1] -= document.body.offsetTop;         
    }    
 }              
 if (el.parentNode) { 
    parent = el.parentNode;
 } else {
    parent = null;
 }
 while (parent && parent.tagName != 'BODY' && parent.tagName != 'HTML') { // account for any scrolled ancestors
    pos[0] -= parent.scrollLeft;
    pos[1] -= parent.scrollTop;
    if (parent.parentNode) {
     parent = parent.parentNode;
    } else {
     parent = null;
    }
 }
 return {x:pos[0], y:pos[1]};
 }

</script>
</head>

<div class="content">
<div id="content_3d" style="float:left;overflow:hidden;overflow-x:hidden;height:100%;">
	<div id="unityPlayer">
		<div class="missing">
			<a href="http://unity3d.com/webplayer/"
				title="Unity Web Player. Install now!"> <img
					alt="Unity Web Player. Install now!"
					src="http://webplayer.unity3d.com/installation/getunity.png"
					width="193" height="63" /> </a>
		</div>
	</div>
</div>
<div id="contentShow" style="float: left;width: 180px;height:90%;background-color:#000;border-style:solid;border-color:#cccccc;border-width:1px">
<pre style="font-size:15px;color:#fff;">

<b style="font-size:16px;">    支持3D展现</b>

  物理位置使用3D图片来
  展现楼层。用户在新建
  楼层时，将3D文件打包
  上传，即可展现3D楼层。 

<b style="font-size:16px;">  体现整体组织结构或</b>
<b style="font-size:16px;">  地域分布</b>

  可按公司整体的组织结
  构或地域分布，在物理
  位置中进行定义，一目
  了然，查看公司整体分
  布。 

<b style="font-size:16px;">  和机房的关联</b> 

  在从整体定义了物理位
  置之后，针对单个的物
  理位置，例如某个房间
  、某个 机房，可关联
  具体的设备，并且当设
  备异常时，从物理位置
  的整体视图中能够清晰
  的定位到故障设备所在
  。当故障解决后，可在
  物理位置中快速验证。
</pre>
			</div>
</div>
<div id="removeProp" style="display: none" />