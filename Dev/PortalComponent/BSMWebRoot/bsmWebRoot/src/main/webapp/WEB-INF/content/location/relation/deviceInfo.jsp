<!-- WEB-INF\content\location\relation\deviceInfo.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base target="_self">
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>显示关联设置</title>
<script src="${ctxJs}/component/toast/Toast.js"></script>
<script type="text/javascript">

</script>
</head>

<body >
<div class="black-bottom"><span  class="bold">设备详细信息</span></div>
<div>
<ul class="fieldlist-n">
	
	
	
	<s:if test="resType=='networkdevice'">
	<li><span class="field">机柜号</span>${equipment.cabinetNumb}</li>
	<li><span class="field">机框号</span>${equipment.frameNumb }</li>	
	</s:if>
	<s:else>
	<li><span class="field">上联设备IP</span>${equipment.upIp}</li>
	<li><span class="field">上联设备接口</span>${equipment.upPort}</li>
	<li><span class="field">墙面端口</span>${equipment.wallNumber}</li>
	<li><span class="field">工位号</span>${equipment.workNumber}</li>
	</s:else>
	<li><span class="field">设备号</span>${equipment.equipNumber }</li>
	<li><span class="field">用户名</span>${equipment.adminName }</li>
	<li><span class="field">所属部门</span>${equipment.dept }</li>
</ul>
</div>
</body>
</html>