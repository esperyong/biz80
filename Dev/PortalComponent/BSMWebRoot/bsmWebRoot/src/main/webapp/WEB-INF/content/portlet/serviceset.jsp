<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/WEB-INF/common/meta.jsp" %>
<%@ include file="/WEB-INF/common/userinfo.jsp" %>
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/validationEngine.jquery.css" type="text/css" media="screen" title="no title" charset="utf-8" />
<link href="${ctx}/css/jquery-ui/jquery.ui.treeview.css" rel="stylesheet" type="text/css" ></link>
<title></title>
<script type="text/javascript">
var path = "${ctx}";
</script>
<script src="${ctxJs}/jquery-1.4.2.min.js"></script>
<script src="${ctxJs}/jquery.blockUI.js"></script>
<script src="${ctx}/js/component/cfncc.js"></script>
<script src="${ctx}/js/component/treeView/tree.js"></script>
<script src="${ctx}/js/component/menu/menu.js"></script>
<script src="${ctx}/js/component/accordionPanel/accordionPanel.js"></script>
<script src="${ctx}/js/component/accordionPanel/accordionAddSubPanel.js"></script>
<script src="${ctx}/js/component/panel/panel.js"></script>
<script src="${ctx}/js/component/toast/Toast.js"></script>
<script src="${ctx}/js/component/slider/slider.js"></script>
<script src="${ctxJs}/jquery.validationEngine.js" ></script>
<script src="${ctxJs}/jquery.validationEngine-cn.js" ></script>
<script src="${ctxJs}/profile/comm.js" ></script>
<script src="${ctxJs}/component/comm/winopen.js"></script>
<script src="${ctx}/js/component/popwindow/popwin.js"></script>
<style type="text/css">
.focus{
      border:1px solid #f00;
      background:#fcc;
}
#metricSetting table td{
	vertical-align: middle;
	text-align: center;
}
#metricSetting table th{
	vertical-align: middle;
	text-align: center;
}
</style>
<script type="text/javascript">
$(document).ready(function() {
  $("#confirm_button").click(function(){
  submitForm();
  
});
  initCheckbox();
  initChecked();
}); 
var tempservice = "${strservice}";
var service = tempservice.split(",");
  function initChecked(){
 	var checkbox = $("input[name=service]");
	 for (var i=0;i<checkbox.length;i++)
	{
	  for (var j=0;j<service.length ;j++ )
	  {
	   if(service[j]==checkbox[i].value)
	   {checkbox[i].checked=true;break;}
	  }
	}
	
}

function submitForm() {
    var ajaxParam = $("#form").serialize();
    var parentWin=window.dialogArguments;
	$.ajax({
		type: "POST",
		dataType:'json',
		url: "${ctx}/portlet/service!saveServiceSet.action",
		data: ajaxParam,
		success: function(data, textStatus){
			try{
			opener && opener.reWriteCallback(data);
			}catch(e){
			}
			window.close();
		},
		fail: function(data, textStatus) {
			alert('fail');
		}
	});
}
function initCheckbox(){
	var url = "/bizsmweb/bizservice/.xml";
	var xmlDoc=loadXML(url);
	var elements = xmlDoc.getElementsByTagName("BizService");
	 for (var i = 0; i < elements.length; i++) {
		 if( elements[i].parentNode.nodeName == "BizServices" ){
	      var id = elements[i].getElementsByTagName("bizId")[0].firstChild.nodeValue;
	      var name = elements[i].getElementsByTagName("name")[0].firstChild.nodeValue; 
	      $("#checkbox_div").append("<input type='checkbox' name='service' id='service_checkbox' value='"+id+"'/>"+name+"<br>");
		 }
	}
}
</script>
<script type="text/javascript">
loadXML=function (xmlFile){
     var xmlDoc = null ;
   //初始化，给上述定义变量赋值 
  // function showcurcity(){ 
  if(window.ActiveXObject) 
  { 
  xmlDoc=new ActiveXObject("Microsoft.XMLDOM"); 
  xmlDoc.async="false" 
  xmlDoc.load(xmlFile); 
  }
     return  xmlDoc;
}
</script> 
</head>
<body>
<s:form id="form"  method="POST">
<page:applyDecorator name="popwindow" title="服务选择">
<page:param name="width">350px;</page:param>
<page:param name="topBtn_index_1">1</page:param>
<page:param name="topBtn_id_1">win-close</page:param>
<page:param name="topBtn_css_1">win-ico win-close</page:param>
<page:param name="topBtn_title_1">关闭</page:param>

<page:param name="bottomBtn_index_1">1</page:param>
<page:param name="bottomBtn_id_1">confirm_button</page:param>
<page:param name="bottomBtn_text_1">确定</page:param>

<page:param name="bottomBtn_index_2">2</page:param>
<page:param name="bottomBtn_id_2">cancel_button</page:param>
<page:param name="bottomBtn_text_2">取消</page:param>

<page:param name="content">
<div>
<span class="textalign bold">请选择关注服务:</span><br>
<input type="hidden" name="userid" value="<%=userId%>"/>
<div id="checkbox_div" style="height: 150px; overflow-y: auto; overflow-x: hidden;">
</div>
</div>
</page:param>
</page:applyDecorator>
</s:form>
</body>
</html>
