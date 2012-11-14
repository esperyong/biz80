<!-- 机房-机房监控-机房视频  roomVideoInfo.jsp -->
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/WEB-INF/common/meta.jsp" %>
<HTML>
<HEAD>
</HEAD>
<BODY>
<IFRAME id="targetIframe" name='targetIframe' width="100%" height="540" src="${ctx}/video/roomVideoIframeInfo.jsp" scrolling='no' FRAMEBORDER="0"></IFRAME>
<div id="theEnd" style="position:relative"></div>
<BODY>
</HTML>
<SCRIPT LANGUAGE="JavaScript">

function setHeight(theHeight){
	document.all["targetIframe"].height = theHeight;
	if(parent!=null && parent!= this) {
  		if(typeof(parent.setHeight)!="undefined"){
   			parent.setHeight(getTotalHeight());
  		}
  	}
} 

function getTotalHeight(){
	var ele = document.getElementById("theEnd");
	// check it first.
	if (ele != null) {
		return ele.offsetTop;
	}
	return 0;
}
</SCRIPT>