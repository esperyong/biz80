<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<link href="${ctxCss}/master.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${ctxJs}/jquery-1.4.2.min.js" ></script>
<page:applyDecorator name="popwindow"  title="相关事件">
	<%--<page:param name="width">700</page:param>--%>
	<page:param name="content">
	<div  style="text-align:center;"><b>${timeName }</b><b> </b><b>${title}</b><b>事件</b></div>
	<div id="eventContent" style="width:100%"></div>
	</page:param>
</page:applyDecorator>

<script type="text/javascript">
	var param = "instanceId=${instanceId}&metricId=${metricId}&startTime=${startTime}&endTime=${endTime}";
	$(function(){
		$.ajax({
			url 	: "${ctx}/event/extensionEvent!extensionEventList.action",
			data 	: param,
			dataType:	"html",
			cache:		false,
			success:	function(data, textStatus){
				$("#eventContent").html(data);
			}
		});
		
	});
</script>
