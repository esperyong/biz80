<!-- 机房-机房定义-监控设置-设施管理 deviceManagerTab.jsp -->
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ page import="com.opensymphony.xwork2.util.*"%> 
<%@ include file="/WEB-INF/common/meta.jsp" %>
<link href="${ctx}/css/jquery-ui/treeview.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx}/js/component/treeView/tree.js"></script>
<title>设施管理</title>
<%
	ValueStack vs = (ValueStack)request.getAttribute("struts.valueStack");
	String catalogTree = "";
	if(null != vs && !"".equals(vs)){
		if(vs.findValue("catalogTree") != null && !"".equals(vs.findValue("catalogTree"))){
			catalogTree = (String)vs.findValue("catalogTree");
		}
	}
	
	//String tabStr = "[{text:'常规信息',id:'tab1'},{text:'设备列表',id:'tab2'},{text:'状态定义',id:'tab3'}]";
%>  
<script>

</script>
</head>
  <body>

    <s:form id="formID" action="" name="DeviceManagerForm" method="post" namespace="/roomDefine" theme="simple">
	<div id="leftTreeId" style="float:left;width:20%;height:87%;border:solid 1px #000000;overflow:auto">
	<%=catalogTree %>
	</div>
	<div id="rightTabId" style="width:79%;height:100%;float:right;border:solid 1px #000000;overflow:auto" >
		<div id="treeTabPageId" style="width:100%;height:100%" ></div>
	    
<!--		<ul class="panel-button">-->
<!--			<li><span></span><a id="submit" onClick="">应用</a></li>-->
<!--	    </ul>-->
	</div>
	<input type="hidden" name="roomId" id="roomId" value="<s:property value='roomId'/>">
	</s:form>
  </body> 
</html>

<script type="text/javascript">

function ajaxFun(roomId,nodeId,nodeType,nodeText) {
	$.ajax({
		type: "post",
		dataType:'html', //接受数据格式 
		cache:false,
		data:"roomId="+roomId+"&resourceId="+nodeId+"&resourceType="+nodeType+"&resourceName="+nodeText, 
		url: "${ctx}/roomDefine/ChangeTreeNodeTab.action",
		//url: "${ctx}/roomDefine/ResMetricVisit.action",
		beforeSend: function(XMLHttpRequest){
		//ShowLoading();
		},
		success: function(data, textStatus){
			//alert($("#treeTabPageId")[0]);
			$("#treeTabPageId").find("*").unbind();
			$("#treeTabPageId").html("");
			$("#treeTabPageId").append(data);
			treeTrim();
			//alert(data);
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

function treeTrim(){
	  $('#treeId li').css('word-wrap','normal');
	  $("#treeId span[type='text']").each(
	  function() {
	      var text = $(this).text();
	      var width = 85;
	   var patt1 = /^m_/;
	   var nodeid = $(this).parent().attr("nodeid");
	   if(nodeid && patt1.test(nodeid)){
	       width = 85;
	      }
	      $(this).empty();
	      $(this).append("<span STYLE='width:"+width+"px;overflow: hidden; text-overflow:ellipsis;display: inline-block;white-space:nowrap;' title='" + text + "'>" + text + "</span>");
	     }
	    );
	}

$(document).ready(function() {
	
	var tree = new  Tree({id:"treeId",listeners:{
	    nodeClick:function(node){
	   
	    var nodeText = node.getText();
		var nodestr = node.getId();
		var nodeId = "";
		var nodeType = "";
		if(null != nodestr && (nodestr.indexOf("#")>0)){
			var nodeArr = nodestr.split("#");
			nodeId = nodeArr[1];
			nodeType = nodeArr[1];
		}
		var roomId = $("#roomId").val();
		//alert("nodeType:"+nodeType+":"+roomId+":"+nodeId);
		//alert(ajaxFun);
		ajaxFun(roomId,nodeId,nodeType,nodeText);
			//alert(node.id+"&&"+node.getValue("treeid")+"&&"+node.getValue("treetype"));
	    }
	  }
	});
	
	//alert(thetree);
});
	
$("#submit").click(function (){
		//$("#formID").attr("action","${ctx}/roomDefine/MonitorSetVisit!updateInfo.action");
		tab2SubmitFun();
});

function tab2SubmitFun(){
	$("#formID").submit();
}
if("<s:property value='firstResId'/>" != null && "<s:property value='firstResId'/>" != ""){
	ajaxFun("<s:property value='roomId'/>","<s:property value='firstResId'/>","<s:property value='firstResType'/>","<s:property value='firstResName'/>");
}else{
	$("#treeTabPageId").find("*").unbind();
	$("#treeTabPageId").html("");
	$("#treeTabPageId").append("<div id='no' style='font-size:45px;font-weight:700;text-align:center;width:100%;height:100%; margin:230px auto;'>当前无数据</div>");
	
}

</script>