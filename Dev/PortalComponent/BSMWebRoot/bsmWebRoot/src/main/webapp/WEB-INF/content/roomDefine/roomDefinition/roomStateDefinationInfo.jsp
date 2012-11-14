<!-- 机房-机房定义-属性-状态设置页面 resStatusSet.jsp -->
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp"%>
<title></title>
<link rel="stylesheet" href="${ctx}/css/validationEngine.jquery.css"
	type="text/css" media="screen" title="no title" charset="utf-8" />
<link rel="stylesheet" href="${ctx}/css/public.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/common.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/master.css" type="text/css" />


</head>

<script type="text/javascript">



</script>
<body>
<form id="roomStateForm" action="" name="RoomStateForm" method="post">
<div class="clear">
<ul>
	<li><img src="${ctxImages}/hong.gif" width="13" height="13" />异常：
	<input type="radio" name="statusSet" value="condition1"
		checked="checked" />机柜指标异常</li>
	<li>
	&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
	<input type="radio" name="statusSet" value="condition2" />机柜指标异常或机柜内任一设备不可用
	</li>
	<li>
	&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
	<input type="radio" name="statusSet" value="condition3" />机柜指标异常或机柜内指定设备不可用
	</li>
</ul>
</div>
<br />
<ul>
	<li><img src="${ctxImages}/lv.gif" width="13" height="13" /> <span
		class="field">正常：不符合异常则状态为正常</span></li>
</ul>
<input type="hidden" name="roomId" id="roomId"
	value="<s:property value='roomId' />" />
<input type="hidden" name="resourceId" id="resourceId"
	value="<s:property value='resourceId' />" />
	
	<ul class="panel-button">
		<li><span></span><a  onclick="submitRoomStateFun();">应用</a></li>
    </ul>
</form>
</body>
</html>
<script type="text/javascript">
function submitRoomStateFun() {
	//alert($("#isJigui").val());
	
	//$("#statusForm").attr("action","${ctx}/roomDefine/ResourceProperty.action");
	$("#statusForm").submit();
}
</script>