<!-- 机房-机房定义-图片管理 imageManagerInnerHtmlInfo.jsp -->
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<%@ page import="com.opensymphony.xwork2.util.*"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>图片管理</title>
<%
	ValueStack vs = (ValueStack)request.getAttribute("struts.valueStack");
	String inUse = "";
	if(null != vs && !"".equals(vs)){
		if(vs.findValue("inUse") != null && !"".equals(vs.findValue("inUse"))){
			inUse = (String)vs.findValue("inUse");
		}
	}
%>
<script>

if("<%=inUse%>" == "true"){
	alert("图片已被使用，不允许删除");
	window.colse();
}
</script>
</head>
<form action="" method="post" name="formID" id="formID">
<div id="roomChange1Id" >
<h2>默认图像</h2>
<ul class="contentspace" style="background-color:#FFFFFF">
 <s:iterator value="resImg" id="resImgId">
   <li><img 
src="${ctx}/flash/pic/<s:property value='#resImgId.value.fileName' />" />
<span><s:property value="#resImgId.value.name" /></span></li>
 </s:iterator>
</ul>

<ul class="picmanage-img-content title">
	<li class="titletxt" >自定义图片</li>
	<li class="pic-edit" onclick="modifyPic();" style="position: relative; right: 5px;" title="编辑图片"></li>
	<li class="pic-del" onclick="deletePic();" style="position: relative; right: 5px;"  title="删除图片"></li>
	<li class="pic-add" onclick="addPic();" style="position: relative; right: 5px;" title="添加图片"></li>
</ul>

<ul id="customUl" class="contentspace" customulsame="customulsame" style="background-color:#FFFFFF">

	<s:iterator value="custResImg" id="custResImgId">
		<s:set value="#custResImgId.value.fileName" name="liID" />
		<%
			Object obj = pageContext.getAttribute("liID");
				String liID = "";
				if (null != obj) {
					liID = obj.toString();
					if (liID.indexOf(".") > 0) {
						String[] split = liID.split("\\.");
						liID = split[0];
					}
				}
		%>
		<li id="<%=liID%>" 
			onclick="selectPic(this)"
			picfile="<s:property value='#custResImgId.value.fileName' />"
			picname="<s:property value='#custResImgId.value.name' />"
			pictype="<s:property value='#custResImgId.value.type' />"
			piccatalog="<s:property value='#custResImgId.value.catalog' />">
		<img 
		src="${ctx}/flash/pic/<s:property value='#custResImgId.value.fileName' />" />
		<span><s:property value="#custResImgId.value.name" /></span>	
		</li>
	</s:iterator>
</ul>
</div>
<input type="hidden" id="imageName" name="imageName" value=""></input>
</form>

<script type="text/javascript">
function addImgFun(typeid){
	var selArr = typeid.split("@@");
	window.open("${ctx}/roomDefine/AddCustomImageVisit.action?typeid="+selArr[0]+"&catalog="+selArr[1],"_blank","width=500,height=170");
}
/**
 * 选中自定义图片
 */
function selectPic(obj) {
	$("ul[customulsame='customulsame']>li").removeClass("on");
	//$("#customUl>li").removeClass("currentPic");
	var str = obj.id;
	$("#"+str).addClass("on");
	$("#clkImageId").val(obj.id);
}
/**
 * 编辑图片
 */
function modifyPic() {
	var delID = $("#clkImageId").val();
	if(null == delID || delID == ""){
		alert("请至少选择一项");
		return;
	}
	var imageName =$("#"+delID).attr("picname");
	imageName=setEncodeURI(imageName);
	var picfile =$("#"+delID).attr("picfile");
	var typeid = $("#typeid option:selected").val();
	var tabval = $("#tabChange").val();
	if(null != tabval && tabval =="tab2"){
		typeid="background@@background";
	}
	var selArr = typeid.split("@@");

	window.open("${ctx}/roomDefine/AddCustomImageVisit!updateImageVisit.action?oldUploadFileName="+picfile+"&imageName="+imageName+"&typeid="+selArr[0]+"&catalog="+selArr[1],"_blank","width=500,height=170");
}
/**
 * 删除图片
 */
function deletePic() {
	var delID = $("#clkImageId").val();
	if(null == delID || delID == ""){
		alert("请至少选择一项");
		return;
	}
	var imageName =$("#"+delID).attr("picname");
	var piccatalog =$("#"+delID).attr("piccatalog");
	imageName=setEncodeURI(imageName);
	
	//$("#imageName").val(imageName);
	var tabval = $("#tabChange").val();
	var url ="${ctx}/roomDefine/ImageManagerVisit!deleteImage.action?tabChange="+tabval+"&piccatalog="+piccatalog;
	 //$("#formID").attr("action",url);
	//$("#formID").submit();
	ajaxDelImageFun(imageName,url);
}
function ajaxDelImageFun(imageName,url) {
	//alert(roomId);
	$.ajax({
		type: "post",
		dataType:'json', //接受数据格式 
		cache:false,
		data:"imageName="+imageName, 
		url: url,
		//url: "${ctx}/roomDefine/ResMetricVisit.action",
		beforeSend: function(XMLHttpRequest){
		//ShowLoading();
		},
		success: function(data){
			
			//alert($("#dynamicJspId")[0]);
			
			if(data.inUse == "true"){
				alert("该图片正在使用,不允许删除");
			}
			
			var tabval = $("#tabChange").val();
			if(null != tabval && tabval =="tab2"){
				window.tab2Fun();
			}else{
				window.tab1Fun();
			}
			
		//var listJson = $parseJSON(data.devValues);
		},
		complete: function(XMLHttpRequest, textStatus){
		//HideLoading();
		},
		error: function(XMLHttpRequest, textStatus, errorThrown){
		//请求出错处理
			alert(textStatus);
		}
		});
}
/**
 * 对传递值进行编码
 */
function setEncodeURI(str){
	  var result = encodeURI(str); 
	  result =  encodeURI(result); 
	  return result;
}
/**
 * 添加图片
 */
function addPic() {
	var typeid = $("#typeid option:selected").val();
	var tabval = $("#tabChange").val();
	if(null != tabval && tabval =="tab2"){
		typeid="background@@background";
	}
	addImgFun(typeid);
}

</script>