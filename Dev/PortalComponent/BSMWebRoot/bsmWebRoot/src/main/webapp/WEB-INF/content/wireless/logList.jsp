<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<meta name="decorator" content="headfoot" />
	<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css"/>
	<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css"/>
	<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css"/>
	<script src="${ctx}/js/jquery-1.4.2.min.js"></script>
	
	<script type="text/javascript">
		var path = "${ctx}";
	</script>
</head>
<body>
<%@ include file="/WEB-INF/common/loading.jsp" %>
<page:applyDecorator name="headfoot">
<page:param name="body">
<form name="wireListForm" id="wireListForm" method="post">
<input type="hidden" name="forPageVO.orderColumn" value="${forPageVO.orderColumn}" id="orderColumn"/>
<input type="hidden" name="forPageVO.orderType" value="${forPageVO.orderType}" id="orderType"/>
<input type="hidden" name="forPageVO.currentPage" value="${forPageVO.currentPage}" id="currentPage"/>
<input type="hidden" name="instanceId" value="${instanceId}" id="instanceId"/>
 <div style="height:400px;">
 	<div class="h1">
			<span><font color="white">资源类型：</font></span>
			<span>
				 <s:select list="%{@com.mocha.bsm.wireless.util.ListTitleUtil@getResourceSelectList()}" name="forPageVO.resourceType" listKey="key" listValue="value"  headerKey="" headerValue="全部"/>
			</span>
			<span>
			    <s:select list="%{@com.mocha.bsm.wireless.type.QueryTypeEnum@values()}" name="forPageVO.queryType" listKey="key" listValue="value"/>
				<input type="text" name="forPageVO.queryValue" id="searchValue" value="请输入条件进行搜索" size="20" onblur="trySet(this,'请输入条件进行搜索')" onfocus="tryClear(this,'请输入条件进行搜索')" />
			</span>
			<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
			<span><font color="white">执行时间：</font></span>
			<span><s:textfield id="startTime" name="forPageVO.startTime" cssClass="validate[funcCall[startTimeNull],funcCall[startTimeLarge]]"/></span>
			<span><font color="white">到</font></span>
			<span><s:textfield id="endTime" name="forPageVO.endTime" cssClass="validate[funcCall[endTimeNull],funcCall[endTimeSmall]]"/></span>
			<span class="ico"  title="点击进行搜索"></span>
	</div>
	<div id="child_cirgrid">
		<s:action name="actionResultListChild"  namespace="/wireless/actionResultForPage"  executeResult="true" ignoreContextParams="true" flush="false" />
	 </div>
 </div>
</form>
</page:param>
</page:applyDecorator>

<script src="${ctx}/js/jquery.blockUI.js"></script>
<script src="${ctx}/js/component/plugins/jquery.ui.core.js"></script>
<script src="${ctx}/js/component/plugins/jquery.ui.widget.js"></script>
<script src="${ctx}/js/component/plugins/jquery.ui.mouse.js"></script>
<script src="${ctx}/js/component/plugins/jquery.ui.draggable.js"></script>
<script src="${ctx}/js/component/cfncc.js"></script>
<script src="${ctx}/js/component/gridPanel/grid.js"></script>
<script src="${ctx}/js/component/gridPanel/indexgrid.js"></script>
<script src="${ctx}/js/component/gridPanel/page.js"></script>
<script src="${ctx}/js/component/date/WdatePicker.js"></script>
<script>
var gp = null;
var promptInfo = null;
var searchTip = "请输入条件进行搜索";
$(function(){
	$formObj = $("#wireListForm");
	var $searchType = $('#searchType');
	var $searchValue = $('#searchValue');
	
	$("#startTime","#wireListForm").bind("click", function(){
		WdatePicker({
			//startDate:getDate(n),
			dateFmt:'yyyy-MM-dd HH:mm:ss'
		});
	});
	
	$("#endTime","#wireListForm").bind("click", function(){
		WdatePicker({
			//startDate:getDate(n),
			dateFmt:'yyyy-MM-dd HH:mm:ss'
		});
	});

	$(".ico-find").click(function(){
		$.blockUI({message:$('#loading')});
		if($searchValue.val() == searchTip) {
			$searchValue.val("");
		}
		var grid = $("#child_cirgrid");
		var ajaxParam = $formObj.serialize();
		 $.ajax({
			   type: "POST",
			   dataType:'json',
			   url:path+"/wireless/actionResultForPage/actionResultJsonSort.action",
			   data: ajaxParam,
			   success: function(data, textStatus){
				 if(data.forPageVO.dataList){
				 	if($searchValue.val()=="") {
						$searchValue.val(searchTip);
					}
					if(gp != null){
					 	gp.loadGridData(data.forPageVO.dataList);
					}
				 }
				 $.unblockUI();
		   	   }
		 });
	});
});

function trySet(obj,txt){
	if(obj.value==""){
		obj.value = txt;
	}
}
function tryClear(obj,txt){
	if(obj.value==txt){
		obj.value = '';
	}
}

function validateStartTimeNull() {
	var timeType = $("input[name='eventQuery.timeType']:checked","#queryform").val();
	var startTimeValue = $("input[name='eventQuery.startTime']","#queryform").val();
	if((timeType == "timeRange") && (startTimeValue == "")){
		return true;
	}
	return false;
}

function validateEndTimeNull() {
	var timeType = $("input[name='eventQuery.timeType']:checked","#queryform").val();
	var endTimeValue = $("input[name='eventQuery.endTime']","#queryform").val();
	if((timeType == "timeRange") && (endTimeValue == "")){
		return true;
	}
	return false;
}

function validateTimeRange() {
	var timeType = $("input[name='eventQuery.timeType']:checked","#queryform").val();
	var startTimeValue = $("input[name='eventQuery.startTime']","#queryform").val();
	var endTimeValue = $("input[name='eventQuery.endTime']","#queryform").val();
	if(timeType == "timeRange"){
		if(startTimeValue != "" && endTimeValue != ""){
			if(startTimeValue > endTimeValue){
				return true;
			}else{
				return false;
			}
		}else{
			return true;
		}
	}
	return false;
}
</script>
</body>
</html>