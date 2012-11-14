<!-- 机房-机房定义-机房设施配置 devTypeManagerInfo.jsp -->
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<%@ page import="com.opensymphony.xwork2.util.*"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" ">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>机房监控管理</title>
<link rel="stylesheet" href="${ctx}/css/public.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/UIComponent.css" type="text/css" />
<script src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script src="${ctx}/js/component/cfncc.js"></script>
<script src="${ctx}/js/component/tabPanel/tab.js"></script>
<script type="text/javascript" src="${ctx}/js/component/menu/menu.js"></script>
<script type="text/javascript" src="${ctx}/js/component/popwindow/popwin.js"></script>
<script type="text/javascript" src="${ctx}/js/component/comm/winopen.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery.blockUI.js"></script>
<script type="text/javascript" src="${ctx}/js/component/toast/Toast.js"></script>
<script>

<%
ValueStack vs = (ValueStack)request.getAttribute("struts.valueStack");
String turn = "";
if(null != vs && !"".equals(vs)){
	if(vs.findValue("turn") != null && !"".equals(vs.findValue("turn"))){
		turn = (String)vs.findValue("turn");
	}
}
%>  
if("<%=turn%>" == "right") {
	window.parent.location.href=window.parent.location;
	opener.roomLayoutIdFunClk();
	window.close();
}else if("<%=turn%>" == "use"){
	window.location.href="${ctx}/roomDefine/DevTypeManagerVisit.action";
	opener.roomLayoutIdFunClk();
}else{
	//window.close();
}
</script>
</head>
<body>
<form action="" method="post" name="formName" id="formID">
<page:applyDecorator name="popwindow"  title="机房监控管理">
	<page:param name="width">940px;</page:param>
	<page:param name="topBtn_index_1">1</page:param>
	<page:param name="topBtn_id_1">closeId</page:param>
	<page:param name="topBtn_css_1">win-ico win-close</page:param>
	
	<page:param name="bottomBtn_index_1">1</page:param>
	<page:param name="bottomBtn_id_1">submit</page:param>
	<page:param name="bottomBtn_text_1">确定</page:param>
	
	<page:param name="bottomBtn_index_2">2</page:param>
	<page:param name="bottomBtn_id_2">cancel</page:param>
	<page:param name="bottomBtn_text_2">取消</page:param>
	
	<page:param name="bottomBtn_index_3">3</page:param>
	<page:param name="bottomBtn_id_3">use</page:param>
	<page:param name="bottomBtn_text_3">应用</page:param>
	<page:param name="content">
	<div style="height: 30px">
		<ul style="top: 5px;position: relative;">
			<li>
			<!-- <span class="ico ico-note"></span>--><span><img src="${ctx}/images/ico/tips16.png" alt="" style="top: 3px;position: relative" /></span>
			<span>在机房定义中增加的机房设施的类型都在此处维护。增删改设施类型并为其设置默认监控指标及其取值方式。           </span>
			<!-- <span class="r-ico r-ico-add" id="addType" alt="添加"></span> -->
			<span class="black-btn-l" style="right:-230px;position: relative"><span class="btn-r"><span class="btn-m"><a id="addType">添加类型</a></span></span></span>
			</li>
		</ul>
	</div>
<!--	<div class="monitor" id="roomDivId">-->
	<div class="" id="roomDivId">
<!--	<ul class="monitor-items">-->
	<ul class="">
		<li>
		<table class="monitor-items-head">
			<thead>
				<tr>
					<th>一级类型</th>
					<th>二级类型</th>
					<th>类别</th>
					<th>操作</th>
				</tr>
			</thead>
		</table>
		</li>
		<s:iterator value="catalog" id="map" status="index">
<!--			<option value="<s:property value="#map.key" />" ><s:property value="#map.value" /></option>-->
			<li>
			<table class="monitor-items-list">
				<tbody>
					<tr>
					<!--	判断默认首tr样式要展开				-->
<!--					<s:if test="#index.first">-->
<!--					<td style="font: bold"><span btn="btn" class="ico ico-minus"  id="<s:property value='#map.key' />"></span><s:property value="#map.value.desc" /></td>-->
<!--					</s:if>-->
<!--					<s:else>-->
<!--					<td style="font: bold"><span btn="btn" class="ico ico-plus"  id="<s:property value='#map.key' />"></span><s:property value="#map.value.desc" /></td>-->
<!--					</s:else>-->

						<td style="font: bold"><span btn="btn" class="ico ico-plus"  id="<s:property value='#map.key' />"></span><s:property value="#map.value.desc" /></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
				</tbody>
			</table>
					<!--	判断默认首tr样式要展开				-->
<!--					<s:if test="#index.first">-->
<!--					<div id="<s:property value='#map.key' />_next" style="overflow:hidden">-->
<!--					</s:if>-->
<!--					<s:else>-->
<!--					<div id="<s:property value='#map.key' />_next" style="overflow:hidden;display:none">-->
<!--					</s:else>-->
			
					<div id="<s:property value='#map.key' />_next" style="overflow:hidden" >
					<s:set value="#map.key" name="ic"></s:set>
					<s:iterator value="#map.value.resource" id="mapChild" status="indexChild">
					
					<table class="monitor-items-list">
						<tbody>
						
							<tr>
								<td></td>
								<td style="font: bold"><s:property value="#mapChild.value.name" /> <span btn="fold" id="<s:property value='#mapChild.value.id' />" onclick="focusMetric('<s:property value='#mapChild.value.id' />_next','<s:property value='#ic' />','<s:property value='#mapChild.value.id' />');" class="monitor-ico monitor-ico-open"></span></td>
								<s:if test="#mapChild.value.isDefault==true">
								<td style="font: bold">系统默认类型</td>
								<td><span class="ico ico-edit" title="编辑" onclick="editSecondFun('<s:property value='#ic' />','<s:property value='#mapChild.value.id' />','<s:property value="#mapChild.value.name" />');"></span></td>
								</s:if>
								<s:else>
								<td style="font: bold">自定义类型</td>
								<td>
								<span class="ico ico-edit" title="编辑" onclick="editSecondFun('<s:property value='#ic' />','<s:property value='#mapChild.value.id' />','<s:property value="#mapChild.value.name" />');"></span>
								<span class="ico ico-delete" title="删除" onclick="deleteSecondFun('<s:property value='#ic' />','<s:property value='#mapChild.value.id' />');"></span>
								</td>
								</s:else>
								
							</tr>
						</tbody>
					</table>
					<div class="monitor-target" id="<s:property value='#mapChild.value.id' />_next" style="display:none">

					</div>	
					</s:iterator>	
			</div>

		</li>
			
		</s:iterator>
		
	</ul>
	</div>
	</page:param>
</page:applyDecorator>
<input type="hidden" name="turn" id="turnId" value="right" /> 
</form>
</body>


</html>
<script type="text/javascript">

$("#closeId").click(function (){
	window.close();
})

$("#submit").click(function (){
	$("#formID").attr("action","${ctx}/roomDefine/DevTypeManager.action");
	$("#formID").submit();
})
$("#cancel").click(function(){
	window.close();
})
$("#use").click(function(){
	$("#turnId").val("use");
	$("#formID").attr("action","${ctx}/roomDefine/DevTypeManager.action");
	$("#formID").submit();
});

//添加类型
$("#addType").click(function(){
	var theLeft = (screen.width-400)/2;
	var theTop = (screen.height-250)/2;
	window.open("${ctx}/roomDefine/AddTypeVisit.action","_blank","left="+theLeft+",top="+theTop+",width=400,height=250");
});


initTab();
function initTab(){

 	var roomDivId = $("#roomDivId");
	var btns =  roomDivId.find("span[btn='btn']");
	
	for(var i=0,len=btns.length;i<len;i++){
		var $btn = $(btns[i]);
		if($btn.hasClass("ico-plus")){
			
			$btn.toggle(firstbtnOpen,firstbtnClose);
		}else{
			
			$btn.toggle(firstbtnClose,firstbtnOpen);
		}
	}

	function firstbtnClose(){
		var btn = $(this);
		
		$("#"+btn.attr("id")+"_next").hide("slow");
		btn.removeClass("ico-minus");
		btn.addClass("ico-plus");
	}
	
	function firstbtnOpen(){
		
		var btn = $(this);
		$("#"+btn.attr("id")+"_next").show("slow");
		btn.removeClass("ico-plus");
		btn.addClass("ico-minus");
	}

	var folds = roomDivId.find("span[btn='fold']");
	
	for(var i=0,len=folds.length;i<len;i++){
		var $fold = $(folds[i]);
		if($fold.hasClass("monitor-ico-open")){
			
			$fold.toggle(firstFoldOpen,firstFoldClose);
		}else{
			
			$fold.toggle(firstFoldClose,firstFoldOpen);
		}
	}
	
	function firstFoldClose(){
		var fold = $(this);
		$("#"+fold.attr("id")+"_next").hide("fast");
		var obj = fold.attr("id");
		$("#"+obj).removeClass("monitor-ico-close");
		$("#"+obj).addClass("monitor-ico-open");
	}
	
	function firstFoldOpen(){
		var fold = $(this);
		$("#"+fold.attr("id")+"_next").toggle();
		var obj = fold.attr("id");
		$("#"+obj).removeClass("monitor-ico-open");
		$("#"+obj).addClass("monitor-ico-close");
	}
}

$(function() {
	
	
});


//二级菜单编辑
function editSecondFun(ic,id,desc) {
	var descStr = setEncodeURI(desc);
	var theLeft = (screen.width-400)/2;
	var theTop = (screen.height-380)/2;
	window.open("${ctx}/roomDefine/UpdateTypeVisit.action?oneId="+ic+"&twoId="+id+"&descStr="+descStr,"_blank","left="+theLeft+",top="+theTop+",width=380,height=110");
}

//自定义类型的二级菜单删除
function deleteSecondFun(ic,id) {
	var _confirm = new confirm_box({text:"是否确认执行此操作？"});
	_confirm.setConfirm_listener(function(){
		
		$.ajax({
			   type: "POST",
			   url: "${ctx}/roomDefine/DeleteUserDefineType!getUserName.action",
			   data: "resourceId="+id+"&catalogId="+ic,
			   success: function(msg){
				 var thisData = msg+""; 
				 
			     if(thisData=="true"){
					alert("该设备正在使用不允许删除")
				 }else{
					$("#formID").attr("action","${ctx}/roomDefine/DeleteUserDefineType.action?resourceId="+id+"&catalogId="+ic);
					$("#formID").submit();
				 }
			    	_confirm.hide();
			   }
			});
		
		//$("#formID").attr("action","${ctx}/roomDefine/DeleteUserDefineType.action?resourceId="+id+"&catalogId="+ic);
		//$("#formID").submit();
		//_confirm.hide();
	});
	_confirm.show();
}
function focusMetric(divId,ic,id){
	$("#"+divId).load("${ctx}/roomDefine/DevTypeManagerVisit!getMetrics.action?resourceId="+id+"&catalogId="+ic);
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
 * 对传递值进行解码
 */
function setdecodeURI(str){
  var result = decodeURI(str); 
  result =  decodeURI(result); 
  return result;
}

if("<s:property value='resourceId' />"!="" && "<s:property value='catalogId' />"!=""){
	focusMetric("<s:property value='resourceId' />_next","<s:property value='catalogId' />","<s:property value='resourceId' />");
}
</script>