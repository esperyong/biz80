<!-- WEB-INF\content\location\define\create3dfloor.jsp -->
<!-- 创建物理位置之Floor 3d  -->
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<%@ page import="com.opensymphony.xwork2.util.*"%> 
<title>常规信息</title>
<link rel="stylesheet" href="${ctx}/css/validationEngine.jquery.css" type="text/css" media="screen" title="no title" charset="utf-8" />
<link rel="stylesheet" href="${ctx}/css/public.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/common.css" type="text/css" />
<link href="${ctxCss}/UIComponent.css" rel="stylesheet" type="text/css">
<!--<link rel="stylesheet" href="${ctx}/css/template.css" type="text/css" media="screen" title="no title" charset="utf-8" />-->
<script src="${ctxJs}/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="${ctxJs}/component/cfncc.js"></script>
<script type="text/javascript" src="${ctxJs}/component/tabPanel/tab.js"></script>
<script src="${ctxJs}/jquery.validationEngine-cn.js" type="text/javascript"></script>
<script src="${ctxJs}/jquery.validationEngine.js" type="text/javascript"></script>
<script src="${ctxJs}/location/dialogResize.js" type="text/javascript"></script>
<script src="${ctx}/js/component/cfncc.js"></script>
<script src="${ctx}/js/component/toast/Toast.js"></script>
<%
	ValueStack vs = (ValueStack)request.getAttribute("struts.valueStack");
	String jsonStr = "";
	if(null != vs && !"".equals(vs)){
		if(vs.findValue("floorname") != null && !"".equals(vs.findValue("floorname"))){
			jsonStr = (String)vs.findValue("floorname");
		}
	}
%>   
<script>
//alert('<%=jsonStr%>');
if("<%=jsonStr%>" != "") {
	//alert('jsonStr');
	//window.opener.location.href="${ctx}/roomDefine/IndexVisit.action";
	window.close();
}
</script>
</head>

  <body>
  <page:applyDecorator name="popwindow"  title="物理位置">
	
	<page:param name="width">na760px;</page:param>
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
	
       <page:param name="width">750</page:param>
       <page:param name="tabBarWidth">400</page:param>
       <page:param name="cls">tab-grounp</page:param>
       <page:param name="current">1</page:param>
 		<s:form id="addForm" action="/location/define/floor.action">
 		
  		<input type="hidden" name="uploadFileName" value="" />
		<s:hidden name="location.parentId"></s:hidden>
			<ul class="fieldlist-n">
				<li><span class="field">子区域名称：</span>
					<s:textfield name="location.name" cssClass="validate[required,length[0,50],custom[noSpecialStr]]" id="name"></s:textfield><span class="red">*</span></li>
				<li><span class="field">子区域类型：</span>
					<s:textfield name="location.type" value="楼层" disabled="true" ></s:textfield>
				<li><span class="field">备注：</span>
					<s:textarea name="location.remarks" id="remarks" cssClass="validate[length[0,200],custom[noSpecialStr]]" ></s:textarea>
				</li>
				<li>
		   			<span class="field">展现方式:</span>
		   			<input  type="radio" name="location.flashType" value="2D" checked="checked" style="width:20px;" onclick="show();" />图片
		   			<input  type="hidden" name="location.flashType" value="3D" style="width:20px;" onclick="show();" />
		   			<input  type="radio" name="location.flashType" value="un3D" style="width:20px;" onclick="show();" />UNITY3D模型
		   		</li>
			</ul>
   		
   		<div id="dddModelId" style="display:none">
   		<iframe onLoad="dialogResize();" frameborder="0" id="uploadIframe" name="uploadIframe" src="" scrolling="no" width="705" height="350" marginheight="0" marginwidth="0"></iframe>
   		</div>
   		<input type="hidden"  name="imgName" id="imgName"/>
   		<input type="hidden"  name="folderName" id="folderName"/>
   		</s:form> 
       </page:param>
 </page:applyDecorator>
       

   
  
   
  
  </body> 


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

function showMess(str){
	var toast = new Toast({position:"CT"});
	toast.addMessage(str);
}

//屏蔽输入
function DisabledKeyInput(){
   if(event.keyCode!=8&&event.keyCode!=46) event.returnValue=false;
   if(event.ctrlKey) return false;
}
//验证不为空 上传文件类型错误
function validatorFun(){
	
	var_name = $("input[name='location.flashType']:checked").val();
	if(var_name=="un3D"){
		var uploadBool = document.frames['uploadIframe'].Upload.filePath.value;
		//alert(uploadBool);
		if(!uploadBool){
			showMess("上传文件不能为空");
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

	var_name = $("input[name='location.flashType']:checked").val();

	if(var_name=="3D"){
		$("#dddModelId").show("slow");
		$("#uploadIframe").attr("src","${ctx}/location/define/upload3dfile!init.action?fileType=3D");
	}else if(var_name=="un3D"){
		$("#dddModelId").show("slow");
		$("#uploadIframe").attr("src","${ctx}/location/define/upload3dfile!initUn3D.action?fileType=un3D");
	}else{
		$("#dddModelId").hide("slow");
	}
}
$(document).ready(function() {
	// SUCCESS AJAX CALL, replace "success: false," by:     success : function() { callSuccessFunction() }, 
	$("#addForm").validationEngine({
			promptPosition:"centerRight", 
			validationEventTriggers:"keyup blur change",
			inlineValidation: true,
			scroll:false,
			success:false
		});
	
	$.validationEngineLanguage.allRules.duplicateLocationName = {
		  "file":"${ctx}/location/check/locationcheck.action?location_type=location_floor",
		  "alertTextLoad":"<font color='red'>*</font> 正在验证，请等待",
		  "alertText":"<font color='red'>*</font> 同级区域／子区域名称重复"
		}
	
	
	//$.validationEngine.loadValidation("#date")
	//验证表单返回true还是false
	//alert($("#formID").validationEngine({returnIsValid:true}))
	//$.validationEngine.buildPrompt("#date","This is an example","error")	 		 // Exterior prompt build example								 // input prompt close example
	//$.validationEngine.closePrompt(".formError",true) 							// CLOSE ALL OPEN PROMPTS
	$("#submit").click(function(){
	//alert($("#name").val());
	//alert($("#remarks").val());
	//alert($("input[name='location.flashType']:checked").val());
	//alert($("#imgName").val());
	 settings = {
	   promptPosition:"topRight", 
	   validationEventTriggers:"keyup blur change",
	   inlineValidation: true,
	   scroll:false,
	   success:false
	 }

	
	 if(!$.validate($('#addForm'),settings)) {
		 return;
		}else{
			if(validatorFun()){
				opener.saveProperty({
				name:$("#name").val(),
				remarks:$("#remarks").val(),
				flashType:$("input[name='location.flashType']:checked").val(),
				filePath:$("#imgName").val()
				});
				$("#addForm").submit();
				window.close();
			}
		}
	});



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

$("#cancel").click(function(){
	window.close();
})
</script>