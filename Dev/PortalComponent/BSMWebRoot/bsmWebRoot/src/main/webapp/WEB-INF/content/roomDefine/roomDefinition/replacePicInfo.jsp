<!-- 机房-机房定义-图片管理 imageManagerInnerHtmlInfo.jsp -->
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<%@ page import="com.opensymphony.xwork2.util.*"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>替换图片</title>
<link rel="stylesheet" href="${ctx}/css/validationEngine.jquery.css" 
	type="text/css" media="screen" title="no title" charset="utf-8" />
<link rel="stylesheet" href="${ctx}/css/common.css"
	type="text/css" />
<link rel="stylesheet" href="${ctx}/css/public.css"
	type="text/css" />
<link rel="stylesheet" href="${ctx}/css/UIComponent.css" type="text/css" />
<style>
.currentPic{
	border:1px solid #ccc;
	background:blue;
}
.normalPic{
	border:1px solid #fff;
	background:#fff;
}
</style>
<script src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script src="${ctx}/js/jquery.validationEngine-cn.js" type="text/javascript"></script>
<script src="${ctx}/js/jquery.validationEngine.js" type="text/javascript"></script>
<script>
<%ValueStack vs = (ValueStack) request
					.getAttribute("struts.valueStack");
			//String turn = "";
			if (null != vs && !"".equals(vs)) {
				//if(vs.findValue("turn") != null && !"".equals(vs.findValue("turn"))){
				//	turn = (String)vs.findValue("turn");
				//}
			}%>  
</script>
</head>
<body>
<page:applyDecorator name="popwindow"  title="替换图片">
	<page:param name="width">700px</page:param>
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
	<div style="height:450px">
<form action="" method="post" name="formName" id="formID">
<div><span class="ico ico-note"></span><span>说明：请选择合适的图片替换当前图片。</span></div>
<div class="picmanage-img-content" >
<h2>默认图像</h2>
<ul class="contentspace" customulsame="customulsame">
	<s:iterator value="resImg" id="resImgId">
<s:set value="#resImgId.value.fileName" name="lioneID" />
<%
	Object obj = pageContext.getAttribute("lioneID");
		String lioneID = "";
		if (null != obj) {
			lioneID = obj.toString();
			if (lioneID.indexOf(".") > 0) {
				String[] split = lioneID.split("\\.");
				lioneID = split[0];
			}
		}
%>
  <li onclick="selectPic(this)" id="<%=lioneID%>" picfile="<s:property value='#resImgId.value.fileName' />">
  <img src="${ctx}/flash/pic/<s:property value='#resImgId.value.fileName' />" />
  <span><s:property value="#resImgId.value.name" /></span>
  </li>
</s:iterator>
</ul>

<ul class="picmanage-img-content title">
	<li class="titletxt" >自定义图片</li>
</ul>
<ul class="contentspace" id="customUl" customulsame="customulsame">
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
			pictype="<s:property value='#custResImgId.value.type' />">
	<img src="${ctx}/flash/pic/<s:property value='#custResImgId.value.fileName' />" />
	<span><s:property value="#custResImgId.value.name" /></span>
	</li>
	</s:iterator>
</ul>
</div>


<input type="hidden" name="typeId" id="typeId" value="<s:property value='typeId' />" />
<input type="hidden" name="clkImageFile" id="clkImageFile" value="" />
</form>
</div>
</page:param>
</page:applyDecorator>
</body>
</html>
<script type="text/javascript">
/**
 * 确定
 */
function submitFun() {
	var imageName = $("#clkImageFile").val();
	if (imageName != null && imageName!=""){
		window.opener.subPic("${ctx}/flash/pic/"+imageName);
	}
	
	window.close();
}
/**
 * 取消
 */
function cancelFun() {
	window.close();
}
$(function() {
	$("#submit").click(submitFun);
	$("#cancel").click(cancelFun);
});
/**
 * 选中自定义图片
 */
function selectPic(obj) {
	$("ul[customulsame='customulsame']>li").removeClass("on");
	//$("#customUl>li").removeClass("currentPic");
	var str = obj.id;
	$("#"+str).addClass("on");
	$("#clkImageFile").val(obj.picfile);
}


</script>