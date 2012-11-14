<!-- 机房-机房定义-机房设施管理-单个添加类型   addTypeInfo.jsp -->
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<%@ page import="com.opensymphony.xwork2.util.*"%>
<title>添加类型</title>
<link rel="stylesheet" href="${ctx}/css/validationEngine.jquery.css" 
	type="text/css" media="screen" title="no title" charset="utf-8" />
<link rel="stylesheet" href="${ctx}/css/public.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/UIComponent.css" type="text/css" /> 
<script src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script src="${ctx}/js/jquery.validationEngine-cn.js" type="text/javascript"></script>
<script src="${ctx}/js/jquery.validationEngine.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/js/component/cfncc.js"></script>
<script type="text/javascript" src="${ctx}/flash/swfobject.js"></script>
<script type="text/javascript" src="${ctx}/js/component/combobox/simplebox.js"></script>
<%
	ValueStack vs = (ValueStack) request
			.getAttribute("struts.valueStack");
	String saveFlag = "";
	if (null != vs && !"".equals(vs)) {
		if (vs.findValue("saveFlag") != null
				&& "true".equals(vs.findValue("saveFlag"))) {
			saveFlag = (String) vs.findValue("saveFlag");
		}
	}
%>
</head>
<script>
if("<%=saveFlag%>" != null && "<%=saveFlag%>" != "") {
	//var loadStr = window.opener.location.href;
	window.opener.location.href=window.opener.location; 
	window.close();
}
</script>
<body>
<page:applyDecorator name="popwindow"  title="添加类型">
	
	<page:param name="width">400px;</page:param>
	<page:param name="topBtn_index_1">1</page:param>
	<page:param name="topBtn_id_1">closeId</page:param>
	<page:param name="topBtn_css_1">win-ico win-close</page:param>
	
	<page:param name="bottomBtn_index_1">2</page:param>
	<page:param name="bottomBtn_id_1">submit</page:param>
	<page:param name="bottomBtn_text_1">确定</page:param>
	
	<page:param name="bottomBtn_index_2">3</page:param>
	<page:param name="bottomBtn_id_2">cancel</page:param>
	<page:param name="bottomBtn_text_2">取消</page:param>
	
	<page:param name="content">
		<form id="formID" action="${ctx}/roomDefine/AddType.action" name="AddTypeForm" method="post" enctype="multipart/form-data" >
<!--	<div><span class="ico ico-note"></span><span>说明：添加机房设备，可添加新设备或从系统中选择已有设备。</span></div>-->
	<div>
	   		<ul class="fieldlist-n">
		   		<li>
		   			<span  class="field">所属一级类型</span>
		   			<span>：</span>
		   			<span style="position:relative;top:5px"><select name="chooseOneType" id="chooseOneType">
		   			<s:iterator value="catalog" id="map" status="index">
		   				<s:if test="chooseOneType==#map.key">
		   					<option value="<s:property value='#map.key' />" selected="selected" ><s:property value="#map.value.desc" /></option>
		   				</s:if>
		   				<s:else>
		   					<option value="<s:property value='#map.key' />"><s:property value="#map.value.desc" /></option>
		   				</s:else>
		   				
		   				
		   			</s:iterator>
		   			</select>
		   			</span>
		   			<span class="red">*</span>
		   		</li>
		   		<li>
		   			<span  class="field">类型名称</span>
		   			<span>：</span>
		   			<input type="text" class="validate[required,noSpecialStr,length[0,30],ajax[duplicateMetricName]]" name="typeName" id="typeName" size="40" value="<s:property value='typeName'/>"/>
		   			<span class="red">*</span>
		   		</li>
		   		<li>
		   			<span  class="field">对应图片</span>
		   			<span>：</span>
		   			<!-- 
		   			<input type="file" name="upload" value="" id="upload" onKeyDown="DisabledKeyInput();" />
					<span><span><span><a id="Upload_0" onclick="return validatorFun();" style="cursor: pointer">上传</a></span></span></span>-->
<!--		   			<span class="red">*</span>-->
					<input type="text" id="txt" name="txt" size="30" style="width:130px" onKeyDown="DisabledKeyInput()"/>
			
					<span style="width:50px">
						<span class="gray-btn-l" style="position:absolute;"><span class="btn-r"><span class="btn-m"><a id="liulanId">浏览</a></span></span></span>
						<input type="file" name="upload" value="" id="upload" onKeyDown="DisabledKeyInput();" onchange="txt.value=this.value" style="position:relative;z-index:0;width:0px;left:-30px;filter:alpha(opacity=0);-moz-opacity:.0;opacity:0.0;cursor:pointer;" size="5" ></input>
					</span>
					<span style="top:-1px;position:relative" class="gray-btn-l"><span class="btn-r"><span class="btn-m"><a id="Upload_0" onclick="return validatorFun();" style="cursor: pointer">上传</a></span></span></span>
		   		</li>
		   		<li >
					<span class="field" style="vertical-align:top;">预览</span>
					<span>：</span>
					<div class="" style="display:none" id="photoId">
					
						<s:if test="uploadFileName.indexOf('swf') >= 0">
							<div id="flashContent">
							<p>To view this page ensure that Adobe Flash Player version 10.0.0
							or greater is installed.</p>
							<script type="text/javascript"> 
											var pageHost = ((document.location.protocol == "https:") ? "https://" :	"http://"); 
											//alert(pageHost);
											document.write("<a href='http://www.adobe.com/go/getflashplayer'><img src='" 
															+ pageHost + "www.adobe.com/images/shared/download_buttons/get_flash_player.gif' alt='Get Adobe Flash player' /></a>" ); 
										</script>
							</div>
							<script type="text/javascript">
				            <!-- For version detection, set to min. required Flash Player version, or 0 (or 0.0.0), for no version detection. --> 
				            var swfVersionStr = "10.0.0";
				            <!-- To use express install, set to playerProductInstall.swf, otherwise the empty string. -->
				            var xiSwfUrlStr = "${ctx}/flash/playerProductInstall.swf";
				            //alert(xiSwfUrlStr);
				            var flashvars = {};
				            var params = {};
				            params.wmode = "transparent";
				            params.quality = "high";
				            params.bgcolor = "#ffffff";
				            params.allowscriptaccess = "sameDomain";
				            params.allowfullscreen = "true";
				            params.isBrowse = "true";
				            params.allowfullscreen = "true";
				            flashvars.isBrowse="false";
				            flashvars.isHomePage="false";
				            var attributes = {};
				            attributes.id = "addType";
				            attributes.name = "addType";
				            attributes.align = "middle";
				            
				            swfobject.embedSWF(
				                "${ctx}/images/content/roomDefine/roomDefinition/upload/<s:property value='uploadFileName' />", "flashContent", 
				                "50%", "50%", 
				                swfVersionStr, xiSwfUrlStr, 
				                flashvars, params, attributes);
							<!-- JavaScript enabled so display the flashContent div in case it is not replaced with a swf object. -->
							swfobject.createCSS("#flashContent", "display:block;text-align:left;");
							</script>
						</s:if>
						<s:else>
							<img style="left:30%;position:relative" src="../images/content/roomDefine/roomDefinition/upload/<s:property value='uploadFileName' />"  />
						</s:else>
					
					</div>
				</li>
		   	</ul>
		   	<ul class="fieldlist-n">
				<li >说明：1.图片只能上传 jpg、jpeg、gif、png这几种格式。</li>
<!--				<li style="text-indent:36px;">2.为方便图片自动调节大小不失真建议上传矢量图。</li>-->
				<li style="text-indent:36px;">2. 图片可调节大小，为防失真建议上传矢量图。     </li>
				<li style="text-indent:36px;">3.图片大小不能超过2M。</li>
			</ul>
   		</div>	
		<input type="hidden" name="roomId" id="roomId" value="<s:property value='roomId' />" />
		<input type="hidden" name="uploadFileName" id="uploadFileName" value="<s:property value='uploadFileName' />" />
   		</form>
	</page:param>
</page:applyDecorator>
</body>
</html>

<script type="text/javascript">
$(document).ready(function() {
	$("#formID").validationEngine({
		promptPosition:"topLeft", 
		validationEventTriggers:"keyup blur change",
		inlineValidation: true,
		scroll:false,
		success:false
	});
	var tystr = $("#typeName").val();
    if(tystr != null && tystr != ""){
	    $("#photoId").attr("style","display:block");
    }
    $.validationEngineLanguage.allRules.duplicateMetricName={
    		"file":"${ctx}/roomDefine/AddType!isExistResourceName.action",
    	    "alertTextLoad":"* 正在验证，请等待",
    	    "alertText":"* 类型名称已经存在"
    	}
    SimpleBox.renderAll();	
});


$("#closeId").click(function (){
	window.close();
});

$("#submit").click(function (){
	var upload = "<s:property value='typeName'/>";//判断后台返回值说明上传过图片

	$("#formID").attr("action","${ctx}/roomDefine/AddType!saveType.action");
	$("#formID").submit();
	/*
	if(upload != null && upload != ""){
		$("#formID").attr("action","${ctx}/roomDefine/AddType!saveType.action");
		$("#formID").submit();
	}else{
		alert("没上传图片");
		return;
	}
	*/
});
$("#cancel").click(function(){
	window.close();
});

//屏蔽输入
function DisabledKeyInput(){
   if(event.keyCode!=8&&event.keyCode!=46) event.returnValue=false;
   if(event.ctrlKey) return false;
}

//验证不为空 上传文件类型错误
function validatorFun(){
	var upload = $("#upload").val();
	var bool = checkUploadFile(upload);
	//alert(title + "+" + upload);
	if(upload == null || upload == ""){
		alert("上传路径不允许为空");
		return false;
	}else if(!bool){
		alert("上传格式不符");
		return false;
	}else{
		$("#formID").submit();
		return true;
	}
}

//过滤上传格式
function checkUploadFile(upload) {
	var file1 = "jpg";
	var file2 = "jpeg";
	var file3 = "gif";
	var file4 = "png";
	var file5 = "swf";
	var fileCheck = upload;
	if(fileCheck != "")
	{
		var s = fileCheck.match(/^(.*)(\.)(.{1,8})$/)[3];
		s = s.toLowerCase();
		var bM = false;
		if(s == file1 || s == file2 || s == file3 || s == file4 || s == file5) bM=true;
		if(!bM){
			document.getElementById("upload").value='';//清空file框
			return false;
		}
	}
	return true;
}
</script>
