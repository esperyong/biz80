<!-- WEB-INF\content\location\relation\excel-templates-upload.jsp -->
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="com.mocha.bsm.location.enums.EquipmentTypeEnum" %>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<base target="_self">
<title>导入设备位置信息</title>
<link rel="stylesheet" href="${ctxCss}/common.css"
	type="text/css" />
	<link href="${ctxCss}/master.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/public.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/UIComponent.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/validationEngine.jquery.css" rel="stylesheet" type="text/css" media="screen" title="no title" charset="utf-8" />
<script src="${ctxJs}/jquery-1.4.2.min.js"></script>
<script src="${ctxJs}/jquery.validationEngine-cn.js" type="text/javascript"></script>
<script src="${ctxJs}/jquery.validationEngine.js" type="text/javascript"></script>
<script src="${ctxJs}/location/dialogResize.js"></script>
<script src="${ctx}/js/component/cfncc.js"></script>
<script src="${ctx}/js/component/toast/Toast.js"></script>
</head>
<script type="text/javascript">

//验证不为空 上传文件类型错误
function validatorFun(){
	 var toast = new Toast({position:"CT"});
	var upload = $("#upload").val();
	var bool = checkUploadFile(upload);
	if(upload == null || upload == ""){
		toast.addMessage("上传路径不允许为空");
	}else if(!bool){
		toast.addMessage("上传格式不符");
	}else{
		$("form").attr("action","${ctx}/location/relation/importDevices!uploadFile.action");
		$("form").attr("target","");
		$("form").submit();
	}
}

//过滤上传格式
function checkUploadFile(upload) {
	var file1 = "xls";
	var fileCheck = upload;
	if(fileCheck != "")
	{
		var s = fileCheck.match(/^(.*)(\.)(.{1,8})$/)[3];
		s = s.toLowerCase();
		var bM = false;
		if(s == file1) bM=true;
		if(!bM){
			document.getElementById("upload").value='';//清空file框
			return false;
		}
	}
	return true;
}

//屏蔽输入
function DisabledKeyInput(){
   if(event.keyCode!=8&&event.keyCode!=46) event.returnValue=false;
   if(event.ctrlKey) return false;
}

$(document).ready(function() {
	
	$.validationEngineLanguage.allRules.keyTest = {
			  "alertText":"<font color='red'>*</font> 请选择${domainTitle}",
			  "nname":"checkKey"
	}	
	
	$("form").validationEngine({
		promptPosition:"centerRight", 
		validationEventTriggers:"keyup blur change",
		inlineValidation: true,
		scroll:false,
		success:false
	})
	$("#closeId").click(function(){
		window.close();
	});
	$("#next").click(validatorFun);
	
		$("input[name='resType']").change(function(){
			if(this.checked){
			$("#downloadIdother").hide();
			$("#downloadIdOtherServer").hide();
			$("#downloadId"+this.value).show();
			}
			
		});
	
$("#other").click(function () {
	$("form").attr("action","${ctx}/location/relation/importDevices!downloadExcel.action?resType=other");
	$("form").attr("target","submitIframe");
	$("form").submit();
});
$("#otherServer").click(function () {
	$("form").attr("action","${ctx}/location/relation/importDevices!downloadExcel.action?resType=OtherServer");
	$("form").attr("target","submitIframe");
	$("form").submit();
});
});

function checkKey(){
		var value=$('#domainId').val();
		if(value==""){
		return true;
		}
		return false;

	}

</script>
<body> 
<page:applyDecorator name="popwindow"  title="导入">
	<page:param name="width">560px</page:param>
	<page:param name="topBtn_index_1">1</page:param>
	<page:param name="topBtn_id_1">closeId</page:param>
	<page:param name="topBtn_css_1">win-ico win-close</page:param>
		
	<page:param name="bottomBtn_index_1">1</page:param>
	<page:param name="bottomBtn_id_1">next</page:param>
	<page:param name="bottomBtn_text_1">下一步</page:param>
	
	<page:param name="content">
		<div id="title1Div" class="panel-titlebg">
		<ul class="panel-multili"  style="width: 560px" >
		<li><span >1.选择导入Excel文件</span></li></ul></div>
		
		<div id="oneDiv">
		<form action="${ctx}/location/relation/importDevices!uploadFile.action"
			 method="post" enctype="multipart/form-data">
		<ul class="panel-multili"  style="width: 560px" >
			<li>	
						<span>导入类型：</span>
						<input name="resType" type="radio" value="<%=EquipmentTypeEnum.othernetworkdevice %>" checked="checked"/>
						<span>网络设备</span>&nbsp;&nbsp;&nbsp;
						<input name="resType" type="radio" value="<%=EquipmentTypeEnum.otherserver %>"/>
						<span>服务器/PC</span>
			</li>
			<li>
						<span style="margin-left:36px;">${domainTitle}：</span>
						<s:select name="domainId" id="domainId" list="domains" listKey="ID" listValue="name"
							  headerKey="" headerValue="请选择" cssClass="validate[funcCall[keyTest]]"></s:select>
						<span class="red">*</span>
			</li>
		</ul>
		</div>	
		<!-- 
		<div id="title1Div1" class="panel-titlebg">
		<input  type="hidden" name="resType" value='${resType}'/>
		<input  type="hidden" name="domainId" value='${domainId}'/>
		<ul class="panel-multili"  style="width: 450px" >
		<li><span >2.选择导入Excel文件</span></li></ul></div>
		-->
		<div id="oneDiv">
		<ul class="fieldlist-n"  style="width: 560px"  >
			<li>
			<span style="margin-left:3px;">选择文件：</span><input id="text" type="text"/>
			<span class="buttoncopy">       
		       <input type="file" name="upload" id="upload" value="" onKeyDown="DisabledKeyInput();" onchange="$('#text').val(this.value);" class="validate[required]"/>
		       </span>
			</li>
		</ul>
		<ul id="downloadIdother" class="panel-multili">
			<li>导入的Excel可使用自定义文件，或点击
			<span id="other" class="red" style="cursor:pointer">此处</span>下载标准网络设备导入模板。</li>
		</ul>
		<ul id="downloadIdOtherServer" class="panel-multili" style="display:none">
			<li>导入的Excel可使用自定义文件，或点击
			<span id="otherServer" class="red" style="cursor:pointer">此处</span>下载标准服务器/PC导入模板。</li>
		</ul>
		<ul class="panel-multili">
			<li>注：1.导入的excel文件不支持EXCEL2007版本。</li>
			<li><span style="margin-left:25px;"></span>2.默认取第一个Sheet页的内容。</li>
		</ul>
		</div>	
		</form>
	</page:param>
</page:applyDecorator>
<iframe name="submitIframe" id="submitIframeId" frameborder="0" scrolling="no" height="0" width="0" src=""></iframe>
</body>
</html>