<!-- 机房-机房定义-图片管理 imageManagerInfo.jsp -->
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<%@ page import="com.opensymphony.xwork2.util.*"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>图片管理</title>
<style>
	.currentPic{
		border:1px solid #ccc;
		background:blue;
	}
	.normalPic{
		border:1px solid #fff;
		background:#fff;
	}
</style>
<link rel="stylesheet" href="${ctx}/css/master.css"
	type="text/css" />
<link rel="stylesheet" href="${ctx}/css/public.css"
	type="text/css" />
	<link rel="stylesheet" href="${ctx}/css/UIComponent.css" type="text/css" /> 
<script src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="${ctx}/js/component/cfncc.js"></script>
<script type="text/javascript" src="${ctx}/js/component/panel/panel.js"></script>
<script type="text/javascript" src="${ctx}/js/component/tabPanel/tab.js"></script>
<script type="text/javascript"
	src="${ctx}/js/component/tabPanel/j-dynamic-tab.js"></script>
<script type="text/javascript"	src="${ctx}/js/component/plugins/jquery.ui.core.js"></script>
<script type="text/javascript"	src="${ctx}/js/component/plugins/jquery.ui.widget.js"></script>
<script type="text/javascript"	src="${ctx}/js/component/plugins/jquery.ui.mouse.js"></script>
<script type="text/javascript"	src="${ctx}/js/component/plugins/jquery.ui.draggable.js"></script>
<script type="text/javascript"	src="${ctx}/js/component/plugins/jquery.ui.slider.js"></script>
<script type="text/javascript" src="${ctx}/js/component/combobox/simplebox.js"></script>
<script>
<%ValueStack vs = (ValueStack) request
					.getAttribute("struts.valueStack");
			//String turn = "";
			if (null != vs && !"".equals(vs)) {
				//if(vs.findValue("turn") != null && !"".equals(vs.findValue("turn"))){
				//	turn = (String)vs.findValue("turn");
				//}
			}%>  
</script>
</head>
<body>
<page:applyDecorator name="popwindow"  title="图片管理">
	<page:param name="width">700px</page:param>
	<page:param name="topBtn_index_1">1</page:param>
	<page:param name="topBtn_id_1">closeId</page:param>
	<page:param name="topBtn_css_1">win-ico win-close</page:param>
	
	<page:param name="content">
		<page:applyDecorator name="tabPanel">  
	       <page:param name="id">mytabChild</page:param>
	       <page:param name="width">685</page:param>
	       <page:param name="tabBarWidth">400</page:param>
	       <page:param name="cls">tab-grounp</page:param>
	       <page:param name="current">1</page:param> // 默认显示第几个
	       <page:param name="tabHander">[{text:'机房',id:'tab1'},{text:'背景',id:'tab2'}]</page:param>
	       <page:param name="content_1">
		   <div class="picmanage-img-content" >
		   <ul class="picmanage-title">
			  <li class="title-txt" style="width:100%">请选择图片类型：
			    <select id="typeid" name="typeid" onchange="changeTypeid();">
				<s:iterator value="catalog" id="map">
					<s:iterator value="#map.value.resource" id="mapChild"
						status="indexChild">
						<option value="<s:property value="#mapChild.value.type" />@@<s:property value='#map.key' />"><s:property value="#mapChild.value.name" /></option>
					</s:iterator>
				</s:iterator>
				<option value="room@@room">机房</option>
				</select>
				
			  </li>
			</ul>
		   </div>
		   <div class="picmanage-img-content" id="content1Id" style="background-color:#FFFFFF">
	       
	       </div>
	       </page:param>
	       <page:param name="content_2" >
	       	<div class="picmanage-img-content" id="content2Id" style="background-color:#FFFFFF"></div>
	       </page:param>
	    </page:applyDecorator>	
	</page:param>
</page:applyDecorator>
<input type="hidden" name="tabChange" id="tabChange" />
<input type="hidden" name="clkImage" id="clkImageId" />
</body>
</html>
<script type="text/javascript">
function getSelVal() {
	var selVal = $("#typeid option:selected").val();
	var selArr = selVal.split("@@");
	var typeid = selArr[0];
	return typeid;
}
$(function(){
	var tp = new TabPanel({id:"mytabChild",
		//isclear:true,
		listeners:{
			/*changeBefore:function(tab){
	        	alert(tab.index+"before");
	        	return true;
	        },*/
	        change:function(tab){
		        targetType = tab.id=="tab2"?"tab2"
		        		 :tab1;
	   		 if(tab.id=="tab1"){
	   			//$("#content1Id").html("");
	   			//$("#content1Id").append($("#roomChange1Id").html());
	   			//$("#content1Id").show("slow");
	   			tab1Fun();
	       	 }else{
	       		tab2Fun();
	         }
	        	
	        }/*,
	        changeAfter:function(tab){
	    		alert(tab.index);
			}*/
		}}
		);
	tab1Fun();
});
function tab1Fun() {
	$("#clkImageId").val("");
	$("#tabChange").val("tab1");
	var typeid = getSelVal();
	ajaxChooseTabFun(typeid,"content1Id","${ctx}/roomDefine/ImageManagerVisit!innerHtmlVisit.action");
	window.opener.refreshDraw();
}
function tab2Fun() {
	$("#clkImageId").val("");
	$("#tabChange").val("tab2");
	var typeid = "background";
		ajaxChooseTabFun(typeid,"content2Id","${ctx}/roomDefine/ImageManagerVisit!innerHtmlVisit.action");
		window.opener.refreshDraw();
}
function ajaxChooseTabFun(typeid,contentId,url) {
	//alert(roomId);
	$.ajax({
		type: "post",
		dataType:'html', //接受数据格式 
		cache:false,
		data:"typeid="+typeid, 
		url: url,
		//url: "${ctx}/roomDefine/ResMetricVisit.action",
		beforeSend: function(XMLHttpRequest){
		//ShowLoading();
		},
		success: function(data, textStatus){
			//alert($("#dynamicJspId")[0]);
			$("#"+contentId).find("*").unbind();
			$("#"+contentId).html("");
			$("#"+contentId).append(data);
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
/**
 * 选择类型
 */
function changeTypeid() {
	var typeid = getSelVal();
	var contentId = "content1Id";
	ajaxChooseTypeFun(contentId,typeid,"${ctx}/roomDefine/ImageManagerVisit!changeType.action")
}
function ajaxChooseTypeFun(contentId,typeid,url) {
	//alert(roomId);
	$.ajax({
		type: "post",
		dataType:'html', //接受数据格式 
		cache:false,
		data:"typeid="+typeid, 
		url: url,
		//url: "${ctx}/roomDefine/ResMetricVisit.action",
		beforeSend: function(XMLHttpRequest){
		//ShowLoading();
		},
		success: function(data, textStatus){
			$("#"+contentId).find("*").unbind();
			$("#"+contentId).html("");
			$("#"+contentId).append(data);
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
//SimpleBox.renderAll();
</script>