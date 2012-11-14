<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base target="_self">
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>定制视图</title>
<script type="text/javascript">
	var path = '${ctx}';
</script>
<link href="${ctxCss}/UIComponent.css" rel="stylesheet" type="text/css"/>
<link href="${ctxCss}/master.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/public.css" rel="stylesheet" type="text/css" />
<link href="${ctxCss}/jquery-ui/jquery.ui.treeview.css" rel="stylesheet" type="text/css" />
<link href="${ctxCss}/validationEngine.jquery.css" rel="stylesheet" type="text/css" media="screen" title="no title" charset="utf-8" />
<script src="${ctxJs}/jquery-1.4.2.min.js" type="text/javascript"></script>
<script src="${ctxJs}/component/cfncc.js" type="text/javascript"></script>
<script src="${ctxJs}/jquery.validationEngine-cn.js" type="text/javascript"></script>
<script src="${ctxJs}/jquery.validationEngine.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctxJs}/component/treeView/tree.js"></script>
<script type="text/javascript" src="${ctxJs}/jquery.blockUI.js"></script>
<script type="text/javascript" src="${ctxJs}/jquery.validationEngine.js"></script>
<script type="text/javascript" src="${ctxJs}/jquery.validationEngine-cn.js"></script>
<script type="text/javascript" src="${ctxJs}/component/gridPanel/grid.js"></script>
<script type="text/javascript" src="${ctxJs}/component/gridPanel/indexgrid.js"></script>
<script type="text/javascript" src="${ctxJs}/component/gridPanel/page.js"></script>
<script type="text/javascript" src="${ctxJs}/component/toast/Toast.js"></script>
<script type="text/javascript" src="${ctxJs}/component/popwindow/popwin.js"></script>
<script type="text/javascript" src="${ctxJs}/report/history/history.js"></script>
<script type="text/javascript" src="${ctxJs}/report/select.js"></script>
</head>
<body >
<%@ include file="/WEB-INF/common/loading.jsp" %>
<form id="addForm">
<s:hidden id="isAllSelect" name="isAllSelect" value="false"/>
<s:hidden id="isHaveChange" name="isHaveChange" value="false"/>
<page:applyDecorator name="popwindow"  title="定制视图">
	<page:param name="width">800</page:param>
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
		<ul class="fieldlist-n">
			<!-- 视图类型 -->
			<s:hidden name="analysisView.type" value="%{analysisView.type}"/>
			<!-- 用户 -->
			<s:hidden name="analysisView.userId" value="%{analysisView.userId}"/>
			<!-- id -->
			<s:hidden name="analysisView.id" value="%{analysisView.id}"/>
			<!-- 当前资源类型的顶层资源类型ID-->
			<s:hidden name="resourceCategoryTopId"/>
			<!-- 当前选择的组件类型ID-->
			<s:hidden name="defaultChildResourceType" value=""/>
			
			<li id="viewName">
				<span class="field-middle">视图名称：</span> 
				<s:textfield name="analysisView.name" cssClass="validate[required,length[0,50],noSpecialStr]" size="50" value="%{analysisView.name}" id="analysisViewName"/>
				<span class="red">*</span>
			</li>
		</ul>
		<div class="fold-blue" style="width:100%;margin:0 auto;background-color:#fff;">
			<div class="fold-top">
				<span>  选择资源</span>
			</div>
			<div class="h2"><span class="sub-panel-tips">说明：这里只显示具有“性能指标”的资源或组件。</span></div>
			<div class="for-inline margin3">
				<span >资源类型：<label>${resourceCategory }</label><label>${resourceModule }</label></span>				
				<span id="childResSelectSpan"><span id="childResourceTypeTitle">组件类型：</span><label>${childResourceType }</label></span>
			</div>
			<div class="margin3">
			 <span class="for-inline left">
			 	<span>${domainPageName }：<label>${domainSelect }</label></span>
				<label>
				<select name="analysisView.searchType">
					<option value='<s:property value="@com.mocha.bsm.report.vo.AnalysisVO@S_SEARCHTYPE_NAME" />'>按显示名称</option>
					<option value='<s:property value="@com.mocha.bsm.report.vo.AnalysisVO@S_SEARCHTYPE_IPADDRESS" />'>按IP地址</option>
				</select>
				<input name="analysisView.searchValue"  value="请输入条件进行搜索"  onblur="trySet(this,'请输入条件进行搜索')" onfocus="tryClear(this,'请输入条件进行搜索')" />
				</label>
				<span id="queryico" class="ico ico-find"></span>
			 </span>
				<span class="f-right " id="max6" style="display:none;">
				<span >最多选择<span class="red">6</span>个</span>
			   </span>
			</div>
			
			<s:hidden name="resourceIds"/>
			<div id="selectDiv" style="clear: both;overflow-x:hidden;overflow-y:hidden">
				<s:action name="historyAction!selectResource" executeResult="true" namespace="/report/history" flush="false" ></s:action>
			</div>
		</div>
	</page:param>
</page:applyDecorator>
</form>
</body>
</html>
<script>
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
var toast = new Toast({
					position : "CT"
				});
var childResSelect=$("#childResSelect").val();
$("input[name=defaultChildResourceType]").val(childResSelect);
var map = new Map();
if($("#isAllSelect").val() != "true"){
	var ids = ${resourceIds}+"";
	if(ids != "0"){
		var selectedId = ids.split(",");
		for(var i=0;i<selectedId.length;i++){
			map.put(selectedId[i],"");
		}
	}
}
function changeSelect(){
	$("#pageIndex").val("1");
	var str = $("#addForm").serialize();
	var t_str="";
	if ($("#childResSelect").parent().attr("disabled"))
	{
	var childResSelect=$("#childResSelect").val();
		if (str.indexOf("analysisView.componentType") > -1) {
			var t_names = str.split("&");
			for(var k=0;k<t_names.length;k++){
				 if (t_names[k].indexOf("analysisView.componentType") > -1)
					{t_str =t_str+"analysisView.componentType=&";}
				 else{t_str =t_str+ t_names[k]+'&';}
			   }
		str=t_str;
		}
	}
	
	$.blockUI({message:$('#loading')});
	$.loadPage("selectDiv","${ctx}/report/history/historyAction!selectResource.action","POST",str,function(data){
		$.unblockUI();
		createGridPanel();
	});
	
}

function setSelectReset(){
//alert($("#defaultChildResourceType").val())
	//alert($("#childResSelect").val())
	if ($("#defaultChildResourceType").val()!=$("#childResSelect").val())
	{
			var array = map.arr;
			var ids ="";
			 
			for(var i=0;i<array.length;i++){
				 	ids=ids+array[i].key+",";
				}
				if (ids!="")
				{
					_confirm.setConfirm_listener(function(){
						$("input[name=defaultChildResourceType]").val($("#childResSelect").val());
						var idaa=ids.split(",");
				 		for(var k=0;k<idaa.length;k++){
				 			map.remove(idaa[k]);
				   		}
				   		changeSelect();
				   		_confirm.hide();
					});
					_confirm.setCancle_listener(function(){
					    $("#childResSelect").val($("#defaultChildResourceType").val());
					    _confirm.hide();
					 });
					_confirm.show();
				}
				else
				{
				$("input[name=defaultChildResourceType]").val($("#childResSelect").val());
				changeSelect();}
	}
	else
	{
	 	changeSelect();
	}
	
	
}
function loadResSelect(){
    var resSelect=$("#resSelect").val();
    getResourceCategoryTopId(resSelect)
}

/**
 * 全部选中
 */
function bindAllChoose(chooseAllId, everyId) {
	var checkedLength = $("input[name='" + everyId + "']:checked").length;
	var totalLength = $("input[name='" + everyId + "']").length;
	if (checkedLength == totalLength && totalLength != 0) {
		$("#" + chooseAllId).attr("checked", true);
	} else {
		$("#" + chooseAllId).attr("checked", false);
	}
};
/**
 * 绑定全选
 */
function allChoose(chooseAllId, everyId) {
	var checked = $("#" + chooseAllId).attr("checked");
	$("input[name='" + everyId + "']").each(function(){
		$(this).attr("checked",checked);
		if(checked){
			map.put($(this).val(),"");
		}else{
			map.remove($(this).val());
		}
	});
	//$("input[name='" + everyId + "']").attr("checked", checked);
};
var _confirm = null;
$(function(){
 _confirm = new confirm_box({text:"由于您选择了不同的组件类型，之前选择的会失效？",overlay:false});
 _confirm1 = new confirm_box({text:"由于您选择了不同的资源类型，之前选择的会失效？",overlay:false});
	$("#addForm").validationEngine();
	settings = {
		promptPosition : "centerRight",
		validationEventTriggers : "keyup blur change",
		inlineValidation : true,
		scroll : false,
		success : false
	}
	$.validate = function(form) {
		$.validationEngine.onSubmitValid = true;
		if ($.validationEngine.submitValidation(form, settings) == false) {
			if ($.validationEngine.submitForm(form, settings) == true) {
				return false;
			} else {
				return true;
			}
		} else {
			settings.failure && settings.failure();
			return false;
		}
	};
	
	$("#closeId").click(function (){
		window.close();
	});
	$("#cancel").click(function(){
		window.close();
	});
	$("#submit").click(function(){
	
	var viewName=$("#analysisViewName").val();
	if(objValue.isNotEmpty(viewName)){
		if(str.getLength(viewName)>50){
			toast.addMessage("视图名称过长！");
			return false;
		}
	}
	else
	{
		toast.addMessage("视图名称不能为空！");
			return false;
	}
	if("${analysisView.resourceCategory}" == ""){
			toast.addMessage("当前没有资源，无法新建视图");
			return false;
		}
	if ($("#isAllSelect").val()== "false")
	{
		
		if('${analysisView.type}' == '<s:property value="@com.mocha.bsm.report.type.AnalysisType@Comparison" />'){
			if(map.size() > 6){
				toast.addMessage("对比分析视图最多选6个资源/组件");
				return false;
			}
		}
		if(!$.validate($("#addForm"))){
			return false;
		}
		var ids = getResIds();
		if(ids == ""){
				toast.addMessage("请选择资源/组件");
				return false;
		}
		$("input[name=resourceIds]").val(ids);
	 }
	    isSameName();
	});
	$("#resSelect").change(function(){
		loadResSelect();
	});
	$("#domainSelect").change(function(){
		changeSelect();
	});
	$("#childResSelect").change(function(){
		setSelectReset();
	});
	$("#resSecondSelect").change(function(){
		changeSelect();
	});
	$("#queryico").click(function(){
		changeSelect();
	});
	
	createGridPanel();
	
	loadchildResSelect($("#resSelect").val(),$("#childResSelect"));
	
	if ($("#analysisView_type").val()=="Malfunction")
	{
		$("#childResourceTypeTitle").hide();
		$("#childResSelect").hide();
		$("#childResSelect").attr("disabled","disabled");
	}
	var str = {};
	str.getLength = function(str) {
	var realLength = 0, len = str.length, charCode = -1;
	for (var i = 0; i < len; i++) {
		charCode = str.charCodeAt(i);
		if (charCode >= 0 && charCode <= 128) realLength += 1;
		else realLength += 2;
	}
	return realLength;
};
	resize();
	// 重置页面大小
	function resize(){
		var width = document.body.scrollWidth + 30;
		var height = document.body.scrollHeight + 2;
		var showx = screen.availWidth / 2 - width / 2;
		var showy = screen.availHeight / 2 - height / 2; 
		window.dialogTop = showy+"px"; 
		window.dialogLeft = showx+"px"; 
		window.dialogHeight = height+"px"; 
		window.dialogWidth = width+"px"; 
		
		//window.dialogHeight=(document.body.scrollHeight+10)+"px";
		//window.dialogWidth=(document.body.scrollWidth+10)+"px";
	}
});

</script>
