<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- 
	@page : 时间告警压缩列表外层页.jsp 
	@auther : weiyi@rd.mochasoft.com.cn
--%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<%@ include file="/WEB-INF/common/meta.jsp" %>
	<%-- 
	<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css"/>
	<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css"/>
	<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css" />
	--%>
	<script>
		var path = "${ctx}";
		var pageCount = 1;
	</script>
	<%--
	<title>事件告警压缩</title>
	<script src="${ctx}/js/jquery-1.4.2.min.js" type="text/javascript"></script>
	<script src="${ctx}/js/component/cfncc.js" type="text/javascript"></script>
	<script src="${ctx}/js/component/combobox/simplebox.js"></script>
	<script src="${ctx}/js/component/popwindow/popwin.js"></script>
	 --%>
</head>
<body>
<script type="text/javascript">
win = new confirm_box({title:'提示',text:'此操作不可恢复，是否确认执行此操作？',cancle_listener:function(){win.hide();}});
function reloadGrid(qType,qValue){
	qType = qType ? qType : "resIp";
	qValue = qValue ? qValue : "" ;
	var grid =$("#dataListDiv"); 
	var ajaxParam = {"queryVO.queryType":qType,"queryVO.queryValue":qValue};
	 $.ajax({
		   type: "POST",
		   dataType:'html',
		   url:path+"/effecteresource/effecteRes!allRootDevices.action",
		   data: ajaxParam,
		   success: function(data, textStatus){
		    $(grid).html("");
		    $(grid).append(data);
	   }
	 });
}

function openEditEffecteRelaWindow(rootDevice,isEdit){
	var param = "";
	if(rootDevice){
		param="?effecteResRela.rootDevice="+rootDevice+"&isEdit="+isEdit;
	}else{
		param += "?isReloadRelaDevice=false";
	}
	window.open(path+"/effecteresource/effecteRes!refreshEffecteRela.action"+param,"",'height=480, width=600,  toolbar=no, menubar=no, scrollbars=no,resizable=no,location=no, status=no');
}
</script>
<div class="main-right" id="effecteresource-main-right">
<div class=h1><span class="ico ico-tips"></span><span>影响资源规则：根源资源宕机时，影响资源不发送告警。</span></div>
<form id="effecteRelaForm">
<div class="h1-1"
><span class="black-btn-l right" id="delRes"><span class=btn-r><span class=btn-m><a onfocus="undefined">删除</a></span></span></span
><span class="black-btn-l right" id="newRes"><span class=btn-r><span class=btn-m><a onfocus="undefined">新建</a></span></span></span
><s:select name="queryVO.queryType" id="queryVO_queryType" list="#{'resIp':'IP地址','resName':'资源名称'}"></s:select><input name="queryVO.queryValue" id="queryVO_queryValue"  class="input-single"/
><span title="点击进行搜索" class="ico" id="searchRootRes" ></span
></div>
</form>
<div id="grid_content">
<s:action name="effecteRes!allRootDevices"  namespace="/effecteresource"  executeResult="true" ignoreContextParams="true" flush="false">
	<s:param name="queryVO.queryType" value="'resIp'"></s:param>
</s:action>
</div>
</div>
</body>

<script type="text/javascript">
var $grid_content = $("#grid_content");


$("#searchRootRes").click(function(){
	var qType = $("#queryVO_queryType").val();
	var qValue = $("#queryVO_queryValue").val();
	reloadGrid(qType,qValue);
});
if(isSystemAdmin===true){
	$("#newRes").click(function(){
		openEditEffecteRelaWindow();
	})
	$("#delRes").click(function(){
		var ids = $(".roundedform-content").find(":checked","[colId=resInstanceId]");
		if(ids.length < 1){
			win.setContentText("请至少选择一个根设备!");
			win.setConfirm_listener(function(){win.hide()});
			win.show();
		}else{
			win.setContentText("此操作不可恢复，是否确认执行此操作？");
			win.setConfirm_listener(function(){
				var data = '';
				ids.each(function(i,e){
					data += "&rootDevices=" + $(e).val();
				});
				$.ajax({
					type: "POST",
					data:data,
					url: path+"/effecteresource/effecteRes!delRootDevices.action",
					success: function(data, textStatus){
						reloadGrid();
						win.hide();
					},
					error: function(data, textStatus) {   
						alert("删除失败！");
						win.hide();
					}
				});
			});
			win.show();
		}
	});
}else {
	$("#newRes").hide();
	$("#delRes").hide();
}

</script>
</html>