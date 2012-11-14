<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/WEB-INF/common/meta.jsp" %>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<title>机房定义向导</title>
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/tongjifenxi.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/UIComponent.css" type="text/css" /> 

</head>
<body  class="pop-window">
<div class="pop">
	<div class="pop-top-l">
		<div class="pop-top-r">
			<div class="pop-top-m">
				<a class="win-ico win-close" onClick="okClick()"></a>
				<span class="pop-top-title">机房定义向导</span>
			</div>
		</div>
  </div>
	<div class="pop-m">
		<div class="pop-content">
         <!--内容内容内容内容内容内容内容内容内容内容内容--> 
           <div class="room-wizard"> 
             <div class="leftmenu">
               <ul>
                 <li><a class="menu01-on" id="menu01" onClick="menuClick('menu01',1)"></a></li>
                 <li class="fenge"></li>
                 <li onClick="menuClick('menu02',2)"><a class="menu02" id="menu02" ></a></li>
                 <li class="fenge"></li>
                 <li onClick="menuClick('menu03',3)"><a class="menu03" id="menu03"></a></li>
                 <li class="fenge"></li>
                 <li onClick="menuClick('menu04',4)"><a class="menu04" id="menu04"></a></li>
                 <li class="fenge"></li>
                  <li onClick="menuClick('menu05',5)"><a class="menu05" id="menu05"></a></li>
                 <li class="fenge"></li>
                  <li onClick="menuClick('menu06',6)"><a class="menu06" id="menu06"></a></li>
                  
               </ul>
             </div>
             <div class="content">
				<iframe id="contentFrame" style="width:100%;height:100%;overflow:hidden;" src="${ctx}/roomDefine/NavigationHelpInfoVisit.action?stepPage=1"></iframe>
			</div>

 
	
         <!--内容内容内容内容内容内容内容内容内容内容内容-->  
	</div>
	<div class="pop-bottom-l">
		<div class="pop-bottom-r">
			<div class="pop-bottom-m">
			   
               
			</div>
		</div>
	</div>
</div>

</body>
</html>
<script type="text/javascript">
	function okClick(){
		window.close();
	}
	function menuClick(id,page){
		
		var thisClass =id+"-on"; 
		document.all.contentFrame.src = "${ctx}/roomDefine/NavigationHelpInfoVisit.action?stepPage="+page;
		for (var i=1;i<=6;i++){
			if ("menu0"+i != id){
				document.getElementById("menu0"+i).className = "menu0"+i;
			}
		}
		document.getElementById(id).className = id+"-on";
	}
</script>
