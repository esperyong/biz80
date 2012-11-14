<!-- 机房-机房定义-显示3D图形 show3DRoom.jsp -->
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<head>
<%@ include file="/WEB-INF/common/meta.jsp"%>
<%@ page import="com.opensymphony.xwork2.util.*"%>
<title>显示3D图形</title>
<link rel="stylesheet" href="${ctx}/css/validationEngine.jquery.css"
	type="text/css" media="screen" title="no title" charset="utf-8" />
<link rel="stylesheet" href="${ctx}/css/public.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/common.css" type="text/css" />
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css" />

<%
	String roomId = request.getParameter("roomId");
	String url = request.getParameter("url");
	
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
	wpfObject.SetMode("design");
	
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

//右键弹出属性框
function showProperty(objectId) {
    //alert("${ctx}/roomDefine/ResourcePropertyVisit.action?roomId="+"<%=roomId%>"+"&componentId="+objectId);
	window.open("${ctx}/roomDefine/ResourcePropertyVisit.action?roomId="+"<%=roomId%>"+"&componentId="+objectId);
}

//清除属性
function removeProperty(objectId) {
	$("#removeProp").load("${ctx}/roomDefine/ResourcePropertyVisit!remove.action?roomId="+"<%=roomId%>"+"&componentId="+objectId);
}
</script>
</head>


	<div class="border-gray" style="display: none" id="xbap" style="height:100%"><iframe
		width="100%" height="420" scrolling="no"
		src="${ctx}/flash/MachineRoom.xbap"></iframe>
	</div>
	<div id="removeProp" style="display: none"/>
