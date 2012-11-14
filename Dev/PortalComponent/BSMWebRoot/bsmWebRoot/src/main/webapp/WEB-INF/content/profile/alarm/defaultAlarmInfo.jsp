<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<%@ include file="/WEB-INF/common/meta.jsp" %>
	<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css"/>
	<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css"/>
	<script src="${ctx}/js/jquery-1.4.2.min.js"></script>
</head>
<body>
<page:applyDecorator name="popwindow" title="默认告警规则">
	<page:param name="width">600px;</page:param>
	<page:param name="height">200px;</page:param>
	<page:param name="bottomBtn_index_1">1</page:param>
	<page:param name="bottomBtn_id_1">div_cancel_button</page:param>
	<page:param name="bottomBtn_text_1">关闭</page:param>
	
	<page:param name="topBtn_index_1">1</page:param>
	<page:param name="topBtn_id_1">topBtn1</page:param>
	<page:param name="topBtn_css_1">win-ico win-close</page:param>
	<page:param name="topBtn_title_1">关闭</page:param>
	
	<page:param name="content">
		<ul class="fieldlist">
					<li><span class="field">说明：</span>
						本规则不可删除。系统中所有策略及个性化监控设置，必须使用此告警规则进行告警。 
					</li>
					<li>
						<span class="field">接收方式：</span>
						 告警平台 
					</li>
					<li>
						<span class="field">发送条件：</span>
						 事件产生后立即发送通知 
					</li>
					<li>
						<span class="field">发送告警时间：</span>
						 24小时×7天
					</li>
		</ul>
	</page:param>
</page:applyDecorator>
<script>
$(function(){
	$("#div_cancel_button").click(function(){
		 window.close();
	});
	$("#topBtn1").click(function() {
		window.close();
  	});
});
</script>
</body>
</html>