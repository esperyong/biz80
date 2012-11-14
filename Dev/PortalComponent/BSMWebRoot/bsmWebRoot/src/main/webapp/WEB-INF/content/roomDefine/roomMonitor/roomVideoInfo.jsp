<!-- 机房-机房监控-机房视频  roomVideoInfo.jsp -->
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/WEB-INF/common/meta.jsp" %>
<HTML>
<HEAD>
</HEAD>
<BODY>
<div style="position:absolute;top:42px;right:52px">
视频切换:
<select id="chooseVideo" name="chooseVideo" class="validate[required]" onchange="changeVideo();" >
			<s:iterator value="videoIpPort" id="map">
			<s:if test="firstIp==#map.key">
				<option value="<s:property value="#map.key" />:<s:property value="#map.value" />" selected="selected"><s:property value="#map.key" />:<s:property value="#map.value" /></option>
			</s:if>
			<s:else>
				<option value="<s:property value="#map.key" />:<s:property value="#map.value" />"><s:property value="#map.key" />:<s:property value="#map.value" /></option>
			</s:else>
			</s:iterator>
		</select>
</div>
<IFRAME id="targetIframe" name='targetIframe' width="100%" height="540" src="${ctx}/roomDefine/RoomVideoVisit!iframeForword.action?roomId=<s:property value='roomId'/>&firstIp=<s:property value='firstIp'/>&firstPort=<s:property value='firstPort'/>" scrolling='no' FRAMEBORDER="0"></IFRAME>
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
/**
 * 视频切换
 */
function changeVideo() {
	var selVal = $("#chooseVideo option:selected").val();
	var selArr = selVal.split(":");
	var firstIp = selArr[0];
	var firstPort = selArr[1];
	$("#targetIframe").attr("src","${ctx}/roomDefine/RoomVideoVisit!iframeForword.action?roomId=<s:property value='roomId'/>&firstIp="+firstIp+"&firstPort="+firstPort);
}

</SCRIPT>