<!-- 机房-机房定义-监控设置-设施管理 选择不同树的节点显示不同的 changeTreeNodeTab.jsp -->
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ page import="com.opensymphony.xwork2.util.*"%> 
<%@ include file="/WEB-INF/common/meta.jsp" %>
<link href="${ctx}/css/jquery-ui/treeview.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx}/js/component/treeView/tree.js"></script>
<title>tabchange</title>
<%
	ValueStack vs = (ValueStack)request.getAttribute("struts.valueStack");
	String isJigui = "";
	String tabStr = "";
	if(null != vs && !"".equals(vs)){
		
		if(vs.findValue("isJigui") != null && !"".equals(vs.findValue("isJigui"))){
			isJigui = (String)vs.findValue("isJigui");
		}
	}
	if(null != isJigui && "true".equals(isJigui)){
		tabStr = "[{text:'常规信息',id:'tab1'},{text:'设备列表',id:'tab2'},{text:'状态定义',id:'tab3'}]";
	}else{
		tabStr = "[{text:'常规信息',id:'tab1'}]";
	}
	
%>  
<script>

</script>
</head>
  <body>

    <s:form id="formID" action="" name="DeviceManagerForm" method="post"  namespace="/roomDefine" theme="simple">
		
		<page:applyDecorator name="tabPanel" >  
	       <page:param name="id">mytabChild</page:param>
	       <page:param name="width">100%</page:param>
	       <page:param name="background">#fff</page:param>
	       <page:param name="tabBarWidth">100%</page:param>
	       <page:param name="cls">tab-grounp</page:param>
	       <page:param name="current">1</page:param> // 默认显示第几个
	       <page:param name="tabHander"><%=tabStr%></page:param>
	       <page:param name="content_1">
	       <div id="ff" style="overflow-y:auto;height:450px;width:100%" class="f-relative" >
	       <div >
	       	<div class="clear" id="dynamicJsptreeChange1Id" style="width:97%" ></div>
	       </div>
	       </div>
	       </page:param>
	       <page:param name="content_2">
	       <div style="overflow:auto;width:590px">
	       	<div class="clear" id="dynamicJsptreeChange2Id" style="overflow:no;width:590px" ></div>
	       </div>
	       </page:param>
	       <page:param name="content_3">
	        <div style="overflow:auto;width:800px">
	       	<div class="clear" id="dynamicJsptreeChange3Id" style="overflow:auto;width:800px" ></div>
	       	</div>
	       </page:param>
	    </page:applyDecorator>
	    
		
	<input type="hidden" name="roomId" id="roomId" value="<s:property value='roomId'/>">
	<input type="hidden" name="resourceId" id="resourceId" value="<s:property value='resourceId'/>">
	<input type="hidden" name="resourceName" id="resourceName" value="<s:property value='resourceName'/>">
	<input type="hidden" name="isJigui" id="isJigui" value="<%=isJigui%>">
	<input type="hidden" name="capacityId" id="capacityId" value="<s:property value='capacityId'/>">
	</s:form>
  </body> 
</html>

<script type="text/javascript">

$(function(){
	var roomId = $("#roomId").val();
	var resourceId = $("#resourceId").val();
	var isJigui = $("#isJigui").val();
	var capacityId = $("#capacityId").val();
	//alert(resourceId+":"+capacityId);
	var tp = new TabPanel({id:"mytabChild",
		listeners:{
			/*changeBefore:function(tab){
	        	alert(tab.index+"before");
	        	return true;
	        },*/
	        change:function(tab){
		        targetType = tab.id=="tab2"?"tab2"
		        		 :tab.id=="tab3"?"tab3"
		        		 :"tab3";
       		 if(tab.id=="tab1"){
       		    //tp.loadContent(tab.index,{url:"${ctx}/roomDefine/ResMetricVisit.action?targetType=" + targetType});
				ajaxJiGUIFun(roomId,resourceId,"dynamicJsptreeChange1Id","${ctx}/roomDefine/ResMetricVisit.action?treeTarget=true&capacityId="+capacityId+"&isJigui="+isJigui);
           	 }else if(tab.id=="tab2"){
           		ajaxJiGUIFun(roomId,resourceId,"dynamicJsptreeChange2Id","${ctx}/roomDefine/ChooseJiguiDevList.action?treeTarget=true&capacityId="+capacityId+"&isJigui=1");
             }else{
            	 ajaxJiGUIFun(roomId,resourceId,"dynamicJsptreeChange3Id","${ctx}/roomDefine/ResStatusVisit.action?treeTarget=true&capacityId="+capacityId+"&isMonitorSet=true");
             }
	        	
	        }/*,
	        changeAfter:function(tab){
        		alert(tab.index);
			}*/
    	}}
		); 
	ajaxJiGUIFun(roomId,resourceId,"dynamicJsptreeChange1Id","${ctx}/roomDefine/ResMetricVisit.action?treeTarget=true&capacityId="+capacityId+"&isJigui="+isJigui);
});

function ajaxJiGUIFun(roomId,nodeId,divStr,url) {
	var resourceName = $("#resourceName").val();
	//alert(roomId);
	//alert(nodeId);
	$.ajax({
		type: "post",
		dataType:'html', //接受数据格式 
		cache:false,
		data:"roomId="+roomId+"&resourceId="+nodeId+"&resourceName="+resourceName, 
		url: url,
		//url: "${ctx}/roomDefine/ResMetricVisit.action",
		beforeSend: function(XMLHttpRequest){
		//ShowLoading();
		},
		success: function(data, textStatus){
			//alert($("#dynamicJspId")[0]);
			$("#"+divStr).find("*").unbind();
			$("#"+divStr).html("");
			$("#"+divStr).append(data);
		//var listJson = $parseJSON(data.devValues);
		},
		complete: function(XMLHttpRequest, textStatus){
		//HideLoading();
		},
		error: function(){
		//请求出错处理
			alert("error");
		}
		});
}

$("#submit").click(function (){
		//$("#formID").attr("action","${ctx}/roomDefine/MonitorSetVisit!updateInfo.action");
		$("#formID").submit();
});




</script>