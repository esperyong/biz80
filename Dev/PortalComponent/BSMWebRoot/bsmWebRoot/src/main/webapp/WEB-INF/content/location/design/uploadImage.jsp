<!-- WEB-INF\content\location\design\uploadImage.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>添加自定义图片</title>
<link href="${ctxCss}/master.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/public.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/UIComponent.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/button-module.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/validationEngine.jquery.css" rel="stylesheet" type="text/css" media="screen" title="no title" charset="utf-8" />
<script src="${ctxJs}/jquery-1.4.2.min.js" type="text/javascript"></script>
<script src="${ctxJs}/jquery.select.js" type="text/javascript"></script>
<script src="${ctxJs}/jquery.validationEngine-cn.js" type="text/javascript"></script>
<script src="${ctxJs}/jquery.validationEngine.js" type="text/javascript"></script>
<script src="${ctx}/js/component/cfncc.js"></script>
<script src="${ctx}/js/component/toast/Toast.js"></script>
</head>

<body >
<page:applyDecorator name="popwindow"  title="添加自定义图片">
	
	

	
	<page:param name="width">510px</page:param>
	<page:param name="topBtn_index_1">1</page:param>
	<page:param name="topBtn_id_1">closeId</page:param>
	<page:param name="topBtn_css_1">win-ico win-close</page:param>
	
	<page:param name="bottomBtn_index_1">1</page:param>
	<page:param name="bottomBtn_id_1">cancel</page:param>
	<page:param name="bottomBtn_text_1">取消</page:param>
	<page:param name="content">
<s:form id="form1" action="/location/design/designImage!uploadImage.action" enctype="multipart/form-data" >
<ul class="fieldlist-n">
	<li>
		<span>图片名称：</span>
		<s:hidden name="designImage.id"/>
		<s:hidden name="designImage.type"/>
		<s:textfield name="designImage.name" id="designImage_name" cssClass="validate[required]"></s:textfield><span class="red">*</span>
	</li>
	<li>
		<span>上传图片：</span>&nbsp;&nbsp;&nbsp;
		<input type="file" name="image" id="upload" onKeyDown="DisabledKeyInput()"/>
		<span class="gray-btn-l  f-left">
				<span class="btn-r">
					<span class="btn-m"><a onClick="uploadImage()">上传</a></span>
				</span>
		</span>
	</li>
	<li style="height:100%;display:block">
		<p>说明：</p>
		<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1、图片只能上传jpg,jpeg,gif,png,swf这几种文件格式。</p>
		<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2、由于图片颜色会根据状态颜色变化，建议上传矢量图片。</p>
		<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3、图片大小不能超过2M。</p>
	</li>
</ul>
</s:form>

</page:param>
</page:applyDecorator>
<!--
<iframe name="hiddenFrame" style="display:none"></iframe>-->
</body>
<script type="text/javascript">
	
	function showMess(str){
	var toast = new Toast({position:"CT"});
	toast.addMessage(str);
	}
	
	var flag = "${uploadFlag}";
	if(flag != null && flag != ""){
		if(flag == "success"){
			reloadContent();
		}else if(flag == "fileIsNull"){
				showMess("请选择上传文件");
			}else if(flag == "noFiatFileType"){
				$("#designImage_name").val("");
				showMess("请选择正确的文件类型(jpg,jpeg,gif,png,swf)");
			}else if(flag == "overrunFileSize"){
				$("#designImage_name").val("");
				showMess("上传文件大小不能超过" + (${maximumSize}/(1024*1024)) + "M");
			}
		}
	
	var imageType = "jpg,jpeg,gif,png,swf";
	//上传文件 
	function selFile(){
			var $upload = $("#upload");
			//验证不为空
			if($upload == null || $upload.val() == ""){
				return true;
			}
			return false;
	}
	function testFile(){
		var $upload = $("#upload");
			//上传文件类型错误
		var uploadFileTyep = $upload.val().match(/^(.*)(\.)(.{1,8})$/)[3].toLowerCase();
		if(imageType.indexOf(uploadFileTyep)<0){
			form1.reset();
			return true;
		}
		return false;
	}
	
	$(document).ready(function () {
		
		$.validationEngineLanguage.allRules.fileNullTest = {
				  "alertText":"<font color='red'>*</font> 请选择要上传的文件",
				  "nname":"selFile"
		}	
		$.validationEngineLanguage.allRules.fileTest = {
				  "alertText":"<font color='red'>*</font> 上传格式不符,请上传" + imageType + "文件",
				  "nname":"testFile"
		}	
		
		$("#form1").validationEngine({
			promptPosition:"topRight", 
			validationEventTriggers:"keyup blur change",
			inlineValidation: true,
			scroll:false,
			success:false
		});
		
		$("#upload").change(function(){
			if($("#designImage_name").val()==""){
				$("#designImage_name").val(this.value.substring(this.value.lastIndexOf("\\")+1,this.value.lastIndexOf(".")));
			}
		});
		
		// 上传图片，还是编辑图片
		if("${designImage.id}"!=""){
			$("#form1").attr("action","${ctx}/location/design/designImage!editImage.action")
		}

		$("#cancel").click(function(){
			window.close();
		});
		$("#closeId").click(function(){
			window.close();
		});
	});
	
	//屏蔽输入
	function DisabledKeyInput(){
	   if(event.keyCode!=8&&event.keyCode!=46) event.returnValue=false;
	   if(event.ctrlKey) return false;
	}
	
	function uploadImage(){
	
			 $("#upload").attr("class","validate[funcCall[fileNullTest],funcCall[fileTest]]");
			 $("#form1").submit();
			 $("#upload").attr("class","");
	}
	
	function reloadContent(){
		window.opener.location.reload();
		window.close();
		//loadContent("${ctx}/location/relation/electricityMap!showAssociateElectricityMap.action","tabIndex="+tp.currentIndex);
	}
</script>
</html>