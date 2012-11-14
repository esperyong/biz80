<!-- 机房-机房定义-绘图管理 artMgr.jsp -->
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
</style>
</head>

<body>
<div class="set-panel-content" id="shapeMgrId">
      <div class="set-panel-content-white">
        <div class="sub-panel-open">
          <div class="sub-panel-top"><span class="ico ico-minus" id="baseIcoId" btn="btn"></span> <span class="sub-panel-title vertical-middle">基本形状</span> </div>
          <div class="sub-panel-content" id="baseIcoId_div">
            <div class="img-room-show"  style="height:257px" id="focusDiv">
              <ul>
              	<s:iterator value="shape_alias" id="map">
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
                <li id="<%=liIDOper%>" onclick="add('<s:property value='#map.value.type' />','${ctx}/flash/pic/<s:property value='#map.value.fileName'/>',this);" >
                <img src="${ctx}/flash/pic/<s:property value='#map.value.fileName' />" 
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
var currID="";
var chooseFlag="false";
function add(type,image,obj){
	var theObj={};
	theObj.type = type;
	theObj.image = image;
	//parent.document.getElementById("MachineRoomGraph").excuteFunction("createbasicgraph",theObj);
	var str = obj.id;
	
	if (currID!=""){
		$("#"+currID).removeClass("on");
	}
	
	//if (currID != str){
		$("#"+str).addClass("on");
		currID=str;
		parent.document.getElementById("MachineRoomGraph").excuteFunction("createbasicgraph",theObj);
	//}
	chooseFlag = "true";
	/*
	else{
		currID="";
		chooseFlag = "false";
		parent.document.getElementById("MachineRoomGraph").excuteFunction("cancelcreate",theObj);
	}
	*/
}
$("#focusDiv").click(function(){
	if (chooseFlag != "true"){
		/*
		var picArr = $("#baseIcoId_div li");
		for (i=0;i<picArr.length;i++){
			picArr[i].removeClass("on");
		}*/
		$("#"+currID).removeClass("on");
		currID = "";
		var theObj={};
		parent.document.getElementById("MachineRoomGraph").excuteFunction("cancelcreate",theObj);
	}
	chooseFlag = "false";
	
	
	
})
$("document").ready(function() {
	var sp = $("#shapeMgrId").find('span[btn="btn"]');
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

