<!-- 机房-机房定义-显示Unity3D图形 monitorUnify3DRoom.jsp -->
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
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/room.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css"
	href="${ctx}/flash/history/history.css" />
<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="${ctx}/js/component/cfncc.js"></script>
<script type="text/javascript" src="${ctx}/js/component/popwindow/popwin.js" ></script>
<script type="text/javascript" src="${ctx}/flash/swfobject.js"></script>
<script type="text/javascript" src="${ctx}/js/room/modalDialogWin.js"></script>
<script type="text/javascript" src="${ctxJs}/component/comm/winopen.js"></script>
<script type="text/javascript" src="${ctx}/js/room/UnityObject.js"></script>
<script type="text/javascript" src="${ctx}/flash/CaptureScreen.js"></script>
<%
	String roomId = request.getParameter("roomId");
	
	String viewFileName = "";
	String falshFolderStr = "";
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
				viewFileName = viewFileName.replaceAll("\\\\", "//");
				String[] temp = viewFileName.split("/");
				filePath = "/flash/upload/"+temp[temp.length-2]+"/"+temp[temp.length-1];
			}
			if (viewFileName.indexOf("upload") > 0) {
				String[] str = viewFileName.split("upload");
				falshFolderStr = "/upload" + str[1];
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
		unityObject.embedUnity("unityPlayer", "${ctx}<%=filePath%>", $("#dynamicJspId").width()+15 , $(this).height()-120, params, null, unityLoaded);
	}else{
		unityObject.embedUnity("unityPlayer", "${ctx}<%=filePath%>", "100%" , "100%", params, null, unityLoaded);
	}
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
    GetUnity().SendMessage("root", "ChangeState", "runtime");
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
    GetUnity().SendMessage("root", "SetRefreshInterval", 60);
    window.setTimeout(closeHelp,10000)
    if("<s:property value='nodeId'/>" != null && "<s:property value='nodeId'/>"!=""){
    	locatoionNode("<s:property value='nodeId'/>");
    }
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
	suspendProp(id);
}
        //实时获取机房数据
        function loadData() {
        	$.ajax({
        		type: "post",
        		dataType:'String', //接受数据格式 
        		cache:false,
        		data:"action=getStatus&roomId=<%=roomId%>", 
        		url: "<%=request.getScheme() + "://" + request.getServerName()
            		+ ":" + request.getServerPort()%>${ctx}/room/RoomUnifyServlet",
        		beforeSend: function(XMLHttpRequest){
        		//ShowLoading();
        		},
        		success: function(data, textStatus){
        			GetUnity().SendMessage("root", "Refresh", data);   
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

    //悬浮flash打开时调用         
	function suspendProp(objectId)
	{
		document.getElementById("suspendFrame_<s:property value='roomId'/>").style.height="225";
		flashinterval = setInterval(function(){ 
			if(frames["suspendFrame_<s:property value='roomId'/>"].window.suspendLoaded){
				 frames["suspendFrame_<s:property value='roomId'/>"].window.loadResourceData(objectId);
				clearInterval(flashinterval);
			}
		},50);
       
	}

	//悬浮flash关闭时调用
    function suspendPropClosed(){
    	document.getElementById("suspendFrame_<s:property value='roomId'/>").style.height="0";
    }

    function pulldownHeight(height){
    	$("#menuFrame_<s:property value='roomId'/>").height(height);
    }

    //截图完成，把图片回传给截图程序
    function completeGetPng()
    {
        window.external.unity3dCaptureComplete(pngstr);
    }
    
    //unity3d的绝对位置坐标
    function unity3dLocation()
    {
        var pos = getElementPos("unityPlayer");
        return pos.x+","+pos.y;
    }

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

    //首页
    if(window.HP){
    HP.addActivate(function(){
    	document.getElementById("menuFrame_<s:property value='roomId'/>").style.height="25";
    	GetUnity().SendMessage("root", "ChangeState", "runtime");
    });

    HP.addSleep(function(){
    	document.getElementById("menuFrame_<s:property value='roomId'/>").style.height="0";
    	document.getElementById("suspendFrame_<s:property value='roomId'/>").style.height="0";
    	GetUnity().SendMessage("root", "ChangeState", "browse");
    });
    HP.addDestory({});
    }
    
    function closeHelp(){
    	document.getElementById("frmHelp").style.display ="none";
    }

    // 定位节点
    function locatoionNode(UID){
    	GetUnity().SendMessage("root", "select", UID);
    }

    // 显示留言
    function showMsg(msgId){
    	window.open("${ctx}/roomDefine/ShowMsgVisit.action?id="+msgId,null,"height=190,width=350");
    }

    //编辑组件备注调用
    function editResDesc(resourceId,desc){
    	window.open("${ctx}/roomDefine/Desc.action?roomId=<s:property value='roomId'/>&resourceId="+resourceId+"&desc="+desc,"_blank","height=135,width=300");
    	loadResourceData(resourceId);
    }

    //编辑机房备注调用
    function editRoomDesc(desc){
    	window.open("${ctx}/roomDefine/Desc.action?roomId=<s:property value='roomId'/>&desc="+desc,"_blank","height=135,width=300");
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

<div style="height: 100%; width: 100%">

<div id="<s:property value='roomId'/>" class="content">
	<iframe id="menuFrame_<s:property value='roomId'/>" name="menuFrame" src="${ctx}/roomDefine/MonitorVisit!pulldown.action?roomId=<%=roomId%>" scrolling="no"
					frameborder="0" marginheight="0" marginwidth="0" width="450" height="25" allowtransparency="true" style="position:absolute;top:<s:property value='topOffset'/>px;left:0px;z-index:50;background-color:transparent"></iframe>
			
	<div id="unityPlayer" style="width:100%;height:670px;background-color:black">
		
	</div>
	<iframe id="suspendFrame_<s:property value='roomId'/>" name="suspendFrame" src="${ctx}/roomDefine/MonitorVisit!suspend.action?roomId=<%=roomId%>" scrolling="no"
					frameborder="0" marginheight="0" marginwidth="0" width="100%" height="0" allowtransparency="true" style="position:absolute;bottom:0px;left:0px;background-color:transparent"></iframe>
			
	<s:if test="isSelf=='true'">
		<iframe id="frmHelp" name="frmHelp" src="${ctx}/roomDefine/Show3DHelpVisit.action" scrolling="no" frameborder="0" marginheight="0" marginwidth="0" style="height:100%;width:300px;right:0px;position:absolute;top:32px;">
	</s:if>		
	<s:else>
		<iframe id="frmHelp" name="frmHelp" src="${ctx}/roomDefine/Show3DHelpVisit.action" scrolling="no" frameborder="0" marginheight="0" marginwidth="0" style="height:100%;width:300px;right:0px;position:absolute;top:0px;">
	</s:else>
	
	</iframe>
</div>
<div id="removeProp_<s:property value='roomId'/>" style="display: none" >
</div>
</div>

<!-- 
<iframe src="javascript:document.write('<body style=\'background-color:black\'></body>')" frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" style="position:absolute; width:140px; height:100px;  right: 0px; bottom: 10px"></iframe>
-->