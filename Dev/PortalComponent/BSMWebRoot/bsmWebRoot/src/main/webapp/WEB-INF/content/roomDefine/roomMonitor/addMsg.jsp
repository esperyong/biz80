<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp"%>
<%@ page import="com.opensymphony.xwork2.util.*"%>

<title>留言</title>
<link rel="stylesheet" href="${ctx}/css/validationEngine.jquery.css"
	type="text/css" media="screen" title="no title" charset="utf-8" />
<link rel="stylesheet" href="${ctx}/css/master.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/common.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/public.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/UIComponent.css" type="text/css" /> 
<script src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script src="${ctx}/js/jquery.layout-1.2.0.js"></script>
<script src="${ctx}/js/jquery.validationEngine-cn.js" type="text/javascript"></script>
<script src="${ctx}/js/jquery.validationEngine.js" type="text/javascript"></script>


<script>
if("<s:property value='saveFlag'/>" == "true") {
	opener.document.getElementById("ToolStripComponent").refreshGuestBookData();
	window.close();
}
</script>

</head>
<page:applyDecorator name="popwindow" title="添加留言">

	<page:param name="width">300px;</page:param>
	<page:param name="topBtn_index_1">1</page:param>
	<page:param name="topBtn_id_1">closeId</page:param>
	<page:param name="topBtn_css_1">win-ico win-close</page:param>

	<page:param name="bottomBtn_index_1">1</page:param>
	<page:param name="bottomBtn_id_1">submit</page:param>
	<page:param name="bottomBtn_text_1">确定</page:param>

	<page:param name="bottomBtn_index_2">2</page:param>
	<page:param name="bottomBtn_id_2">cancel</page:param>
	<page:param name="bottomBtn_text_2">取消</page:param>

	<page:param name="content">
		<form id="msgForm" action="${ctx}/roomDefine/Msg!addMsg.action"
			name="msgForm" method="post">
		<div>
		<ul class="fieldlist-n">
				<li><span >主题:</span> <input type="text"
					class="validate[required,length[0,50]]" name="topic"
					id="topic" size="40" value=""></input><span class="txt-red">*</span></li>
				<li><span>保留:</span> <select name="saveDay" id="saveDay">
						<option value="0">不删除</option> 
						<option value="1">1天</option>
						<option value="5">5天</option>
						<option value="10">10天</option>
						<option value="15">15天</option>
					</select>
				</li>
				<li style="display:none"><span class="field" >留言人:</span> <textarea name="user"
					id="user" cols="40" class="validate[length[0,30]]" value=''><s:property value='user'/></textarea></li>
				<li><span >内容:</span> <textarea name="content"
					id="content" cols="42" rows="3" class="validate[length[0,300]]"></textarea></li>
					
		</ul>
		</div>
		<input type="hidden" name="roomId" id="roomId" value="<s:property value='roomId' />" />
	</form>
	</page:param>
</page:applyDecorator>

<script type="text/javascript">

$(document).ready(function() {
	
	$("#msgForm").validationEngine({
		promptPosition:"topLeft", 
		validationEventTriggers:"keyup blur change",
		inlineValidation: true,
		scroll:false,
		success:false
	})
});

$("#closeId").click(function (){
	window.close();
})

$("#submit").click(function (){
	$("#msgForm").submit();
})

$("#cancel").click(function(){
	window.close();
})
</script>





