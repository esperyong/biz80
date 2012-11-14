<!-- 机房-机房定义-新建机房 createGeneralInfo.jsp -->
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<%@ page import="com.opensymphony.xwork2.util.*"%> 
<title>新建机房</title>
<link rel="stylesheet" href="${ctx}/css/validationEngine.jquery.css" type="text/css" media="screen" title="no title" charset="utf-8" />
<link rel="stylesheet" href="${ctx}/css/public.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/common.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/UIComponent.css" type="text/css" /> 

<script src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="${ctx}/js/component/cfncc.js"></script>
<script type="text/javascript" src="${ctx}/js/component/combobox/simplebox.js"></script>
<script type="text/javascript" src="${ctx}/js/component/tabPanel/tab.js"></script>
<script src="${ctx}/js/jquery.validationEngine-cn.js" type="text/javascript"></script>
<script src="${ctx}/js/jquery.validationEngine.js" type="text/javascript"></script>

<%
	ValueStack vs = (ValueStack)request.getAttribute("struts.valueStack");
	String jsonStr = "";
	String newRoomId = "";
	if(null != vs && !"".equals(vs)){
		if(vs.findValue("roomName") != null && !"".equals(vs.findValue("roomName"))){
			jsonStr = (String)vs.findValue("roomName");
			newRoomId = (String)vs.findValue("roomId");
		}
	}
%>   
<script>
if("<%=jsonStr%>" != "") {
	parent.window.opener.location.href="${ctx}/roomDefine/IndexVisit.action?roomId="+"<%=newRoomId%>";
	parent.window.close();
}
</script>
</head>

  <body>
  <page:applyDecorator name="popwindow"  title="新建机房">
	
	<page:param name="width">550px;</page:param>
	<page:param name="topBtn_index_1">1</page:param>
	<page:param name="topBtn_id_1">closeId</page:param>
	<page:param name="topBtn_css_1">win-ico win-close</page:param>
	<page:param name="topBtn_title_1">关闭</page:param>
	
	<page:param name="bottomBtn_index_1">1</page:param>
	<page:param name="bottomBtn_id_1">submit</page:param>
	<page:param name="bottomBtn_text_1">确定</page:param>
	
	<page:param name="bottomBtn_index_2">2</page:param>
	<page:param name="bottomBtn_id_2">cancel</page:param>
	<page:param name="bottomBtn_text_2">取消</page:param>
	
	<page:param name="content">
	
	
       
        <s:form id="formID" action="CreateGeneralInfo" name="CreateGeneralInfoForm" method="post" namespace="/roomDefine" theme="simple" target="submitIframe">
   		<div>
	   		<ul class="fieldlist-n">
		   		<li>
		   			<span  class="field">机房名称</span>
		   			<span>：<input type="text" class="validate[required,noSpecialStr,length[0,30],ajax[duplicateMetricName]]" name="roomName" id="roomName" size="40" nospace="true"/></span>
		   			<span class="red" style="line-height:20px">*</span>
		   		</li>
		   		<li style="vertical-align:baseline;">
		   			<span class="field"  title="<s:property value='domainPageName' />" style="overflow: hidden;white-space: nowrap;text-overflow:ellipsis;width:103px;" >所属<s:property value='domainPageName' /></span>
		   			<span>：</span><span style="top:3px;position:relative"><s:select list="allDomains" cssClass="validate[required]" style="width:225px;" name="field" id="field" listKey="ID" listValue="name" /></span>
		   			<span class="txt-red" style="line-height:20px">*</span>
		   		</li>
		   		<li>
		   			<span class="field" style="position:relative;top:0px">备注</span>
		   			<span>：<textarea name="notes" id="textarea" cols="42" rows="2" class="validate[length[0,200]]"></textarea></span>
		   		</li>
		   		<li>
		   			<span class="field">展现方式</span>
		   			<span><div>：<input type="radio" name="disType" value="2D" checked="checked" style="width:20px;" onclick="show();" />图片
		   			<!-- <input type="radio" name="disType" value="3D" style="width:20px;" onclick="show();" />3D模型    -->
		   			<input type="radio" name="disType" value="un3D" style="width:20px;" onclick="show();" />3D
		   			</div></span>
		   		</li>
		   	</ul>
   		</div>
   		<div id="dddModelId" style="display:none">
   		<iframe frameborder="0" id="uploadIframe" name="uploadIframe" src="" scrolling="no" width="550" height="225" marginheight="0" marginwidth="0"></iframe>
   		</div>
   		<input type="hidden"  name="imgName" id="imgName"/>
<!--   		<s:submit name="提交" onclick="return validatorFun();"></s:submit>-->
<!--   		<s:reset name="取消"></s:reset>-->
   </s:form> 
    
   
  
   
   </page:param>
   </page:applyDecorator>
  </body> 

<iframe name="submitIframe" id="submitIframeId" frameborder="0" scrolling="no" height="0" width="0" src=""></iframe>
</html>
<script type="text/javascript">

$(function(){
    var tp = new TabPanel({id:"mytab"
					
					});
});

//打开新页上传图片
function uploadFun(){
	window.open("uploadPicture.jsp");
}
//
function sjNoRules(){
	if($("#adminName").val() == "sj"){
		return true;
	}else{
		return false;
	}
}
//屏蔽输入
function DisabledKeyInput(){
   if(event.keyCode!=8&&event.keyCode!=46) event.returnValue=false;
   if(event.ctrlKey) return false;
}
//验证不为空 上传文件类型错误
function validatorFun(){
	var_name = $("input[name='disType']:checked").val();
	if(var_name=="dddModel"){
		var uploadBool = document.frames['uploadIframe'].Upload.hasVal.value;
		//alert(uploadBool);
		if(!uploadBool){
			alert("上传文件不能为空");
			return false;
		}else{
			return true;
		}
	}else{
		return true;
	}
	
}

//过滤上传格式
function checkUploadFile(upload) {
	var file1 = "zip";
	var file2 = "rar";
	var file3 = "jar";
	var fileCheck = upload;
	if(fileCheck != "")
	{
		var s = fileCheck.match(/^(.*)(\.)(.{1,8})$/)[3];
		s = s.toLowerCase();
		var bM = false;
		if(s == file1 || s == file2 || s==file3) bM=true;
		if(!bM){
			document.getElementById("upload").value='';//清空file框
			return false;
		}
	}
	return true;
}
//显示3d上传层
function show(){

	var_name = $("input[name='disType']:checked").val();

	if(var_name=="3D"){
		//$("#dddModelId").style
		$("#dddModelId").show("slow");
		$("#uploadIframe").attr("src","${ctx}/roomDefine/UploadPictureVisit.action?fileType=3D");
		window.resizeTo(560,435);
	}else if(var_name=="un3D"){
		$("#dddModelId").show("slow");
		$("#uploadIframe").attr("src","${ctx}/roomDefine/UploadPictureVisit.action?fileType=un3D");
		window.resizeTo(560,435);
	}else{
		window.resizeTo(560,210);
		$("#dddModelId").hide("slow");
	}
}
$(document).ready(function() {
	$.validationEngineLanguage.allRules.duplicateMetricName={
    		"file":"${ctx}/roomDefine/CreateGeneralInfo!validatorRoomName.action",
    	    "alertTextLoad":"* 正在验证，请等待",
    	    "alertText":"* 名称已经存在"
    	}	
	// SUCCESS AJAX CALL, replace "success: false," by:     success : function() { callSuccessFunction() }, 
	$("#formID").validationEngine({
		//topLeft, topRight, bottomLeft, centerRight, bottomRight
		promptPosition:"centerRight", 
		validationEventTriggers:"keyup blur change",
		inlineValidation: true,
		//no scrolling
		scroll:false,
		//containerOverflow:true,  // Enable Overflown mode
		//containerOverflowDOM:"#divOverflown", // The actual DOM element container with overflow scroll on it
		
		//ajaxSubmit: true,
		//ajaxSubmitFile: "ValidationUser.action",
		//ajaxSubmitMessage: "Thank you, we received your inscription!",
		//ajaxSubmitExtraData: "roomName=roooooooo&name=john",
		success:false
       // success : function() { callSuccessFunction() },//验证通过时调用的函数 
	   // failure : function() { alert("验证失败，请检查。");  }//验证失败时调用的函数  
	})
	
	
	SimpleBox.renderAll();
	//$.validationEngine.loadValidation("#date")
	//验证表单返回true还是false
	//alert($("#formID").validationEngine({returnIsValid:true}))
	//$.validationEngine.buildPrompt("#date","This is an example","error")	 		 // Exterior prompt build example								 // input prompt close example
	//$.validationEngine.closePrompt(".formError",true) 							// CLOSE ALL OPEN PROMPTS
});
function callSuccessFunction(){
	alert(0);
}
function callFailFunction(){
	alert(1);
}

$("#closeId").click(function (){
	window.close();
})

$("#submit").click(function (){
	if(validatorFun()){
		if ($("input[name='disType']:checked").val()=="un3D"){
			if($(window.frames["uploadIframe"].document).find("#txt").val() == ''){
				alert("请上传3D文件");
				return;
			}
		}
		
		$("#formID").submit();
	}
})
$("#cancel").click(function(){
	window.close();
})
</script>