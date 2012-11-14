<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="java.util.List"%><html>
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<%@ page import="com.opensymphony.xwork2.util.*"%> 
<base target="_self">
<title>设备列表</title>
<link rel="stylesheet" href="${ctx}/css/validationEngine.jquery.css" type="text/css" media="screen" title="no title" charset="utf-8" />
<link rel="stylesheet" href="${ctx}/css/public.css" type="text/css" />
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css">
<link href="${ctx}/css/button-module.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="${ctx}/css/UIComponent.css" type="text/css" /> 
</head>
<script src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="${ctx}/js/component/cfncc.js"></script>
<script type="text/javascript" src="${ctx}/js/component/gridPanel/grid.js"></script>
<script type="text/javascript" src="${ctx}/js/component/gridPanel/indexgrid.js"></script>
<script type="text/javascript" src="${ctx}/js/component/gridPanel/page.js"></script>
 <script src="${ctx}/js/component/toast/Toast.js"></script>
<%
 	ValueStack vs = (ValueStack) request.getAttribute("struts.valueStack");
 	String jsonStr = "";
 	if (null != vs && !"".equals(vs)) {
 		if (vs.findValue("pollingInfor") != null && !"".equals(vs.findValue("pollingInfor"))) {
 			jsonStr = (String) vs.findValue("pollingInfor");
 		}
 	}
 %> 
 
<body >
 	<page:applyDecorator name="popwindow"  title="巡检明细">
	<page:param name="width">505px;</page:param>
	<page:param name="topBtn_index_1">1</page:param>
	<page:param name="topBtn_id_1">closeId</page:param>
	<page:param name="topBtn_css_1">win-ico win-close</page:param>
	
	<page:param name="content">
		<div style="height:30px"><div style="position:relative;top:8px;left:3px"><span>每月(<s:property value="startTime"/>-<s:property value="endTime"/>)共巡检<s:property value="pollingCount"/>次:</span>
		<span style="background-color:green;height:15px;width:40px;left:-10px;top:-3px;position:relative"><span style="position:relative;left:8px;top:2px">正常</span></span><span style="left:5px"><s:property value="normal"/>次</span>
		<span style="background-color:red;height:15px;width:40px;top:-1px;position:relative"><span style="position:relative;left:8px;top:2px"></span>异常</span><span><s:property value="abnormal"/>次。</span></div>
		</div>
		<page:applyDecorator name="indexgrid">  
		     <page:param name="id">tableId</page:param>
		     <page:param name="width">393px</page:param>
		     <page:param name="height">363px</page:param>
		     <page:param name="linenum">18</page:param>
		     <page:param name="tableCls">grid-gray</page:param>
		     <page:param name="gridhead">[{colId:"pollingDate",text:"巡检时间"},{colId:"pollingTime",text:""},{colId:"state",text:"结论"}]</page:param>
		     <!--<page:param name="gridcontent"><s:property value="deviceInfo" escape="false" /></page:param>-->
		     <page:param name="gridcontent"><%=jsonStr%></page:param>
		     
		</page:applyDecorator>
	</page:param>
</page:applyDecorator>
</body>
</html>
<script type="text/javascript">
var devGp = new GridPanel({id:"tableId",
	unit:"%",
    columnWidth:{pollingDate:3,pollingTime:3,state:4},
    plugins:[TitleContextMenu],
	contextMenu:function(td){}
   },{gridpanel_DomStruFn:"index_gridpanel_DomStruFn",gridpanel_DomCtrlFn:"index_gridpanel_DomCtrlFn",gridpanel_ComponetFn:"index_gridpanel_ComponetFn"});
devGp.rend([{index:"state",fn:function(td){
	
	if(td.html!=""){
		var thisState;
		if(td.html == "true"){
			thisState = "正常";
			$span = '<div style="background-color:green;height:15px;width:40px"><span style="position:relative;left:8px;top:2px">'+thisState+'</span></div>';
		}else{
			thisState = "异常";
			$span = '<div style="background-color:red;height:15px;width:40px"><span style="position:relative;left:8px;top:2px">'+thisState+'</span></div>';
		}
		
		return $span;
	}else{
		return null;
	}
}
},{index:"pollingTime",fn:function(td){

	if (td.html != ""){
		var theData = td.html.split("##");

		if (theData.length>0){
			$span = $('<span value="'+theData[1]+'" style="cursor:pointer">'+theData[0]+'</span>');
			/*
			$span.click(function(){
				window.open("${ctx}/roomDefine/EditPollingVisit.action?id="+$(this).val()+"&operateState=0",null,"height=700,width=820");
				}
			)
			*/
		}
		return $span;
	}else{
		return null;
	}
}
	
}]);

devGp.loadGridData('<%=jsonStr%>');


$("#closeId").click(function(){
	window.close();
});
</script>