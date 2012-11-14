<!-- 机房-机房定义-绘图-组件 deviceMgr.jsp -->
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

<div class="set-panel-content">
      <div class="set-panel-content-white" id="bgDiv">
        <div class="sub-panel-open">
          <div class="sub-panel-top"><span class="ico ico-minus" id="roomIcoId" btn="btn"></span> <span class="sub-panel-title vertical-middle">机房</span> </div>
          <div class="sub-panel-content" id="roomIcoId_div">
            <div class="img-showRoom">
              <ul name="customulsame">
              	<s:iterator value="room_alias" id="map">
              	 <s:set value="#map.value.fileName" name="liID" />
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
                <li id="<%=liID%>" onclick="changeRoomPic('<s:property value='#map.value.type' />','${ctx}/flash/pic/<s:property value='#map.value.fileName'/>',this);" ><img src="${ctx}/flash/pic/<s:property value='#map.value.fileName' />" 
						
						style="cursor: hand" alt="<s:property value='#map.value.name' />" />
						<span class="more"><s:property value='#map.value.name' /></span>
				</li>
				</s:iterator>
              </ul>
            </div> 
          </div>
        </div>
       <div class="sub-panel-open">
          <div class="sub-panel-top"><span class="ico ico-minus" id="roomDevIcoId" btn="btn"></span> <span class="sub-panel-title vertical-middle">机房设施</span> </div>
          <div class="sub-panel-content" id="roomDevIcoId_div">
            <div class="img-showRoom">
              <ul name="customulsamedev">
              	<s:iterator value="device_alias" id="map">
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
                <li id=<%=liIDDev %> onclick="add('<s:property value='#map.value.type' />','${ctx}/flash/pic/<s:property value='#map.value.fileName'/>',this);" >
                	<img
					src="${ctx}/flash/pic/<s:property value='#map.value.fileName' />" 
					
					style="cursor: hand" alt="<s:property value='#map.value.name' />" />
                	<span class="more"><s:property value='#map.value.name' /></span>
                </li>
                </s:iterator>
              </ul>
            </div> 
          </div>
        </div>
        <div class="sub-panel-open">
          <div class="sub-panel-top"><span class="ico ico-minus" id="roomJiGuiId" btn="btn"></span> <span class="sub-panel-title vertical-middle">机柜:</span> </div>
          <div class="sub-panel-content" id="roomJiGuiId_div">
            <div class="img-showRoom">
              <ul>
              	<s:iterator value="jigui_alias" id="map">
              	<s:set value="#map.value.fileName" name="liIDBox" />
					<%
						Object theObjBox = pageContext.getAttribute("liIDBox");
							String liIDBox = "";
							if (null != theObjBox) {
								liIDBox = theObjBox.toString();
								if (liIDBox.indexOf(".") > 0) {
									String[] split = liIDBox.split("\\.");
									liIDBox = split[0];
								}
							}
					%>
                <li id=<%=liIDBox%> onclick="add('<s:property value='#map.value.type' />','${ctx}/flash/pic/<s:property value='#map.value.fileName'/>',this);" >
                	<img
					src="${ctx}/flash/pic/<s:property value='#map.value.fileName' />" 
					style="cursor: hand" alt="<s:property value='#map.value.name' />" />
                	<span class="more"><s:property value='#map.value.name' /></span>
                </li>
                </s:iterator>
              </ul>
            </div> 
          </div>
        </div>
        <div class="sub-panel-open">
          <div class="sub-panel-top"><span class="ico ico-minus" id="roomEnvironmentId" btn="btn"></span> <span class="sub-panel-title vertical-middle">机房环境:</span> </div>
          <div class="sub-panel-content" id="roomEnvironmentId_div">
            <div class="img-showRoom">
              <ul>
              	<s:iterator value="invironment_alias" id="map">
              	<s:set value="#map.value.fileName" name="liIDOper" />
					<%
						Object theObjOper = pageContext.getAttribute("liIDOper");
							String liIDOper = "";
							if (null != theObjOper) {
								liIDOper = theObjOper.toString();
								if (liIDOper.indexOf(".") > 0) {
									String[] split = liIDOper.split("\\.");
									liIDOper = split[0];
								}
							}
					%>
                <li id="<%=liIDOper%>" onclick="add('<s:property value='#map.value.type' />','${ctx}/flash/pic/<s:property value='#map.value.fileName'/>',this);">
                	<img
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

//添加机房组件
function add(type,image,obj){
	var theObj={};
	theObj.type = type;
	theObj.image = image;
	//parent.document.getElementById("MachineRoomGraph").excuteFunction("createnode",theObj);

	var str = obj.id;
	if (currID!=""){
		$("#"+currID).removeClass("on");
	}
	
	//if (currID != str){
		$("#"+str).addClass("on");
		currID=str;
		parent.document.getElementById("MachineRoomGraph").excuteFunction("createnode",theObj);
	//}
	/*
	else{
		parent.document.getElementById("MachineRoomGraph").excuteFunction("cancelcreate",theObj);
		currID="";
	}
	*/
	chooseFlag = "true"
	
}
var currID="";
var chooseFlag="false";
//设置背景图片
function changeRoomPic(type,image,obj){
	var theObj={};
	
	//$("#"+thisName).addClass("on");
	theObj.value = image;
	parent.document.getElementById("MachineRoomGraph").excuteFunction("setbackgroundpic",theObj);

	var str = obj.id;
	if (currID!=""){
		$("#"+currID).removeClass("on");
	}
	
	if (currID != str){
		$("#"+str).addClass("on");
		currID=str;
	}else{
		currID="";
	}
	chooseFlag = "true"
	
}

$("#bgDiv").click(function(){
	
	if (chooseFlag != "true"){
		$("#"+currID).removeClass("on");
		currID = "";
		var theObj={};
		parent.document.getElementById("MachineRoomGraph").excuteFunction("cancelcreate",theObj);
	}
	chooseFlag = "false";
	
	
	
})

$("document").ready(function() {
	var sp = $(".set-panel-content").find('span[btn="btn"]');
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

