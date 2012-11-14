<!-- 机房-机房定义-绘图管理-背景 backgroundMgr.jsp -->
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp"%>
<title></title>
<link rel="stylesheet" href="${ctx}/css/validationEngine.jquery.css"
	type="text/css" media="screen" title="no title" charset="utf-8" />
<link rel="stylesheet" href="${ctx}/css/public.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/master.css" type="text/css" />
<script src="${ctx}/js/jquery-1.4.2.min.js"></script>
<style type="text/css">
.more{
word-break:keep-all;
white-space:nowrap;
overflow:hidden;
text-overflow:ellipsis;
}

.img-showRoom{ overflow:hidden;width:260px;}
.img-showRoom ul{ overflow:hidden; margin:0 ; padding:0;}
.img-showRoom li{ float:left; margin:5px; text-align:center; width:45px;zoom:1;height:65px;}
.img-showRoom li.on{ border:#c6c6c6 1px solid; background:#eee;width:43px;height:63px;}
.img-showRoom li img{ width:40px; height:40px; clear:none; display:block; margin:2px auto; cursor:pointer;}
.img-showRoom li span{ text-align:center;}
</style>
</head>

<body>
<div class="set-panel-content" id="backgroundMgrId">
      <div class="set-panel-content-white">
        <div class="sub-panel-open">
          <div class="sub-panel-top"><span class="ico ico-minus" id="backImgId" btn="btn"></span> <span class="sub-panel-title vertical-middle">背景图片</span> </div>
          <div class="sub-panel-content" id="backImgId_div">
            <div class="img-showRoom">
              <ul>
              	<s:iterator value="background_alias" id="map">
              		<s:set value="#map.value.fileName" name="liIDDev" />
					<%
						Object theObj = pageContext.getAttribute("liIDDev");
							String liIDDev = "";
							if (null != theObj) {
								liIDDev = theObj.toString();
								if (liIDDev.indexOf(".") > 0) {
									String[] split = liIDDev.split("\\.");
									liIDDev = split[0];
								}
							}
					%>
                <li id="<%=liIDDev %>" onclick="background('${ctx}/flash/pic/<s:property value='#map.value.fileName'/>',this);"><img
					src="${ctx}/flash/pic/<s:property value='#map.value.fileName' />" 
					style="cursor: hand" alt="<s:property value='#map.value.name' />" />
					<span class="more"><s:property value='#map.value.name' /></span>
				</li>
				</s:iterator>
              </ul>
            </div> 
          </div>
        </div>
     </div>
</div>
</body>
</html>
<script type="text/javascript">
var currID;
var chooseFlag="false";
function background(image,obj){
	var theObj={};
	/*
	if(image.indexOf("background.png")!=-1){
		theObj.value = "0x959595";
	}
	if(image.indexOf("background2.png")!=-1){
		theObj.value = "0xeca19e";
	}
	if(image.indexOf("background3.png")!=-1){
		theObj.value = "0xd1ac66";
	}
	if(image.indexOf("background4.png")!=-1){
		theObj.value = "0x9fc9e2";
	}
	if(image.indexOf("background5.png")!=-1){
		theObj.value = "0x285550";
	}
	if(image.indexOf("background6.png")!=-1){
		theObj.value = "0xd3ef81";
	}
	if(image.indexOf("background7.png")!=-1){
		theObj.value = "0x000000";
	}
	if(image.indexOf("background8.png")!=-1){
		theObj.value = "0xc6a8f0";
	}
	
	parent.document.getElementById("MachineRoomGraph").excuteFunction("setbackgroundcolor",theObj);
	*/
	theObj.value=image;
	parent.document.getElementById("MachineRoomGraph").excuteFunction("setgraphbackground",theObj);

	var str = obj.id;
	if (currID!="" && currID != str){
		$("#"+currID).removeClass("on");
	}
	
	$("#"+str).addClass("on");
	currID=str;
	chooseFlag = "true";
}

$("#backImgId_div").click(function(){
	if (chooseFlag != "true"){
		$("#"+currID).removeClass("on");
		currID = "";
		var theObj={};
		parent.document.getElementById("MachineRoomGraph").excuteFunction("cancelcreate",theObj);
	}
	chooseFlag = "false";
	
	
	
})

$("document").ready(function() {
	var sp = $("#backgroundMgrId").find('span[btn="btn"]');
	for(var i=0;i<sp.length;i++){
		var $fold = $(sp[i]);
	   	if($fold.hasClass("ico-minus")){//已经开
			$fold.toggle(foldOpen,foldClose);
		}else{
			$fold.toggle(foldClose,foldOpen);
		}
	}
});
function foldOpen() {
	var fold = $(this);
	$("#"+fold.attr("id")+"_div").hide("slow");
	fold.removeClass("ico-minus");
	fold.addClass("ico-plus");
}
function foldClose() {
	var fold = $(this);
	$("#"+fold.attr("id")+"_div").show("slow");
	fold.removeClass("ico-plus");
	fold.addClass("ico-minus");
}
</script>

