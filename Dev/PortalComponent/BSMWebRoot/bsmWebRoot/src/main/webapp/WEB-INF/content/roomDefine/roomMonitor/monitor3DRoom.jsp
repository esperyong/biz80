<!-- 机房-机房监控-显示3D图形 monitor3DRoom.jsp -->
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<head>
<%@ include file="/WEB-INF/common/meta.jsp"%>
<%@ page import="com.opensymphony.xwork2.util.*"%>
<title>监控3D图形</title>
<link rel="stylesheet" href="${ctx}/css/validationEngine.jquery.css"
	type="text/css" media="screen" title="no title" charset="utf-8" />
<link rel="stylesheet" href="${ctx}/css/common.css" type="text/css" />
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/room.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css" />
<script src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script src="${ctx}/js/jquery.layout-1.2.0.js"></script>
<%
	String roomId = request.getParameter("roomId");
	String viewFileName = "";
	String falshFolderStr = "";
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
			}
			if (viewFileName.indexOf("upload") > 0) {
				String[] str = viewFileName.split("upload");
				falshFolderStr = "/upload" + str[1];
			}
		}
	}
%>
<script type="text/javascript">
//全局变量，用于存储wpf实例
var wpfObject;

//保存wpf传递过来的变量
function init(managedObject){
	if("<%=falshFolderStr%>" == ""){
		return;
	}
	$("#xbap").show("slow");
	wpfObject = managedObject;
	foo();
}

//调用wpf的方法
function foo(){
	//设置浏览或运行模式
	wpfObject.SetMode("runtime");
	
	wpfObject.CallbackWpf("<%=request.getScheme() + "://" + request.getServerName()
					+ ":" + request.getServerPort()%>${ctx}/flash"+"<%=falshFolderStr%>");
    //运行模式下刷新数据
	wpfObject.SetRefreshUrl("<%=request.getScheme() + "://" + request.getServerName()
		+ ":" + request.getServerPort()%>${ctx}/room/RoomUnifyServlet?action=getStatus&roomId=<%=roomId%>",15000);
}

//指定是设计还是运行模式
function setWpfMode(mode){
	wpfObject.SetMode(mode);//runtime
}

//在3d模型中选定一个对象后，显示名称
function setSelectedModel3d(name)
{
    //selectedModel3d.innerHTML = name;
    //alert(name);
}

//悬浮属性框
function suspendProp(objectId) {
	//$("#suspendProp").show("slow");
	//$("#suspendProp").load("${ctx}/roomDefine/ResSuspendProp.action?roomId=<%=roomId%>&componentId="+objectId);
}


</script>
</head>
<page:applyDecorator name="headfoot"> 

<div class="room-menu">
  <div class="title">
  <span class="lamp lamp-green"></span>
  <span class="name"><s:property value='roomName'/></span>
  </div>
  <div class="menu">
    <ul>
	   <li class="first"></li>
	   <li class="normal01"><span class="room-tabico room-tabico-on"></span>机房布局</li>
	   <li class="normal"><span class="room-tabico room-tabico-no"></span>指标分析</li>
	   <li class="normal"><span class="room-tabico room-tabico-no"></span>设备一览</li>
	   <li class="normal"><span class="room-tabico room-tabico-no"></span>网络拓扑</li>
	   <li class="normal"><span class="room-tabico room-tabico-no"></span>告警管理</li>
	   <li class="normal"><span class="room-tabico room-tabico-no"></span>机房视频</li>
	   <li class="jump"><a href="#"><span class="jump-img"></span></a></li>
    </ul>
  </div>
</div>

	<div class="border-gray" id="xbap" style="height:100%;width:100%"><iframe
		width="100%" height="420" scrolling="no"
		src="${ctx}/flash/MachineRoom.xbap"></iframe>
	<div id="suspendProp" style="background:url(${ctxImages}/roomprop.png);position:fixed width:100% height:100%;display:none"/>
	</div>
</page:applyDecorator>