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
<title>指标选择</title>
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
  var ajaxParam = $("#form").serialize(); 
  $('#resoureTypeSelect').change(function(){
	  var resid = $(this).children('option:selected').val();
	  //var resourceId = $("#compselect").children('option:selected').val();
	  $.ajax({
			type: "POST",
			dataType:'json',
			url: "${ctx}/portlet/indicator!changeIndicator.action?resid="+resid,
			data: ajaxParam,
			success: function(data, textStatus){
				try{
				//parentWin.rewrite(data);
				//parentWin.location.reload();
				//changemodel(data);
				changecomponent(data);
				getMetricId(resid,"");
				}catch(e){}
				//window.close();
			},
			fail: function(data, textStatus) {
				alert('fail');
			}
		});
      //alert($(this).children('option:selected').val());  //弹出select的值
  });
  
  $('#compselect').change(function(){
	  var resourceId = $(this).children('option:selected').val();
	  var resid = $("#resoureTypeSelect").children('option:selected').val();
	  getMetricId(resid,resourceId);
  });

  initMetric();
});  


function getMetricId(categoryId,resourceId){
	var ajaxParam = $("#form").serialize();
	$.ajax({
		type: "POST",
		dataType:'json',
		url: "${ctx}/portlet/indicator!getMetricIdByCategoryOrChildResource.action?resid="+categoryId+"&resourceId="+resourceId,
		data: ajaxParam,
		success: function(data, textStatus){
			try{
			//parentWin.rewrite(data);
			//parentWin.location.reload();
			//changemodel(data);
			//changecomponent(data);
			rewriteMetric(data);
			}catch(e){}
			//window.close();
		},
		fail: function(data, textStatus) {
			alert('fail');
		}
	});
	
}
function rewriteMetric(data){
	$("#show_metric").html("");
	var showMetric = (eval(data.metricJsonString))
	for(var i=0;i<showMetric.length;i++){
		$("#show_metric").append("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type='checkbox' name='metric' id='metric_checkbox' value='"+showMetric[i].key+"' />"+showMetric[i].value+"<br>")
	}
}
/* function changemodel(data){
	$("#modelselect").html("");
	if(data.resoureTree && data.resoureTree.length){
		for (var i =0 ; i<data.resoureTree.length ; i++)
		{
			$("#modelselect").append("<option value='"+data.modelList[i].key+"'>"+data.modelList[i].value+"</option>");
		}
		
	}
} */
function changecomponent(data){
	$("#compselect").html("");
	$("#compselect").html("<option value=''>请选择组件</option>");
	var showComponent = (eval(data.componentJsonString));
	if(showComponent && showComponent.length){
		for (var i =0 ; i<showComponent.length ; i++)
		{
			$("#compselect").html($("#compselect").html()+"<option value='"+showComponent[i].key+"'>"+showComponent[i].value+"</option>"); 
		}
		
	}
}

function submitForm() {
	var resourceId = $("#compselect").children('option:selected').val();
	var categoryId = $("#resoureTypeSelect").children('option:selected').val();
    var ajaxParam = $("#form").serialize();
    var parentWin=window.dialogArguments;
	$.ajax({
		type: "POST",
		dataType:'json',
		url: "${ctx}/portlet/indicator!saveIndicator.action?resid="+categoryId+"&resourceId="+resourceId+"&userid=<%=userId%>",
		data: ajaxParam,
		success: function(data, textStatus){
			try{
			parentWin.rewrite(data.viewList);
			//parentWin.location.reload();
			}catch(e){}
			window.close();
		},
		fail: function(data, textStatus) {
			alert('fail');
		}
	});
}
function initMetric()
{
	var resourceId = $("#compselect").children('option:selected').val();
	var categoryId = $("#resoureTypeSelect").children('option:selected').val();
	getMetricId(categoryId,categoryId);
}
</script>
</head>
<body>
<input type="hidden" id="view_type" value="${view_type}"/>
<input type="hidden" id="resid" value="${resid}"/>
<input type="hidden" id="resourceId" value="${resourceId}"/>
<input type="hidden" id="userid" value="${userid}"/>
<s:form id="form"  method="POST">
<page:applyDecorator name="popwindow" title="指标选择">
<page:param name="width">500px;</page:param>
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
<span class="textalign bold">资源类型:</span>
<select id="resoureTypeSelect" name="resourceCategory" style="width:180px"  >      
        <s:iterator  var="resource" value="resoureTree"  status="stat">
<%--          <s:if test="#resource.key==resourceCategory">
          <option selected="selected" value="<s:property value="#resource.key" />"><s:property value="#resource.value" /></option>
         </s:if>
         <s:else> --%>
          <option  value="<s:property value="#resource.key" />"><s:property value="#resource.value" /></option>
         <%-- </s:else> --%>                                     
          </s:iterator>
</select> 

<span class="textalign bold">组件类型:</span>
<select  id="compselect" name="compselect" style="width:180px"  >      
		<option value="">请选择组件</option>
        <s:iterator  var="component" value="componentTree"  status="stat">
         <%-- <s:if test="#component.key==resourceCategory">
          <option selected="selected" value="<s:property value="#resource.key" />"><s:property value="#resource.value" /></option>
         </s:if>
         <s:else> --%>
	     <option  value="<s:property value="#component.key" />"><s:property value="#component.value" /></option>
        <%--  </s:else>  --%>                                    
           </s:iterator> 
</select> 
<br>
<br>
<span class="underline-gray02"></span>
&nbsp;&nbsp;&nbsp;<span>性能指标</span>
<div style ="height:100%;">
<div id="show_metric" style="height: 150px; overflow-y: auto; overflow-x: hidden;">


</div>
</div>
</div>
</page:param>
</page:applyDecorator>
</s:form>
</body>
</html>