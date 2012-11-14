<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=7" />
<title>设置</title>
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/topn.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/jquery-ui/treeview.css" rel="stylesheet" type="text/css" ></link>
<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="${ctx}/js/component/treeView/tree.js"></script>
<script src="${ctx}/js/component/cfncc.js"></script>
<script src="${ctx}/js/component/panel/panel.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery.form.js"></script>
<script src="${ctx}/js/component/toast/Toast.js"></script>
<script src="${ctx}/js/component/popwindow/popwin.js"></script>
<style type="text/css">
.example {/* make the box translucent (80% opaque) */
	height:20px;
	width:0px;
	cursor:pointer;
	opacity: 0; /* Firefox， Safari(WebKit)， Opera */
	-ms-filter: alpha(opacity=0); /* IE 8 */
	filter: alpha(opacity=0); /* IE 4-7 */
	zoom: 1;/* set zoom， width or height to trigger hasLayout in IE 7 and lower */
}
.box img {/*设置图片垂直居中*/ vertical-align:middle;}
</style>
</head>
<body>
<page:applyDecorator name="popwindow"  title="设置">
    <page:param name="width">700px;</page:param>
	<page:param name="topBtn_index_1">1</page:param>
	<page:param name="topBtn_id_1">topBtn1</page:param>
	<page:param name="topBtn_css_1">win-ico win-close</page:param>
    
    <page:param name="bottomBtn_index_1">1</page:param>
	<page:param name="bottomBtn_id_1">ok_button</page:param>
	<page:param name="bottomBtn_text_1">确定</page:param>
	
    <page:param name="bottomBtn_index_2">2</page:param>
	<page:param name="bottomBtn_id_2">cancel_button</page:param>
	<page:param name="bottomBtn_text_2">取消</page:param>
	
	<page:param name="content">
		<s:form id="viewset">
			<input type="hidden" name="businessViewSet.tempDir" value="${businessViewSet.tempDir}" id="tempDir">
			<table class="custom-slide" style="width:700px" border="1">
			<thead>
				<tr>
					<th width="56">序号</th>
					<th width="147">视图标题</th>
	                <th width="134">视图Logo</th>
	                <th width="63"></th>
	                <th width="178">视图内容</th>
	                <th width="94">操作</th>
				</tr>
			</thead>
			<tbody>
				<s:iterator value="businessViewSet.businessViewObjs" status="st" id="viewObj">
					<tr <s:if test="#st.even">class="color"</s:if>>
					  <td height="26">
					  	<span class="number" style="cursor:auto;">${viewObj.id}</span>
					  	<input type="hidden" name="businessViewSet.businessViewObjs[${st.index }].id" value="${viewObj.id }">
					  </td>
					  <td>
					  	<s:textfield name="businessViewSet.businessViewObjs[%{#st.index}].viewTitle" value="%{#viewObj.viewTitle}"/>
					  </td>
					  <td>
					  	<span class="box"><s:if test="#viewObj.imgPath != null"><img src="${ctx}/${viewObj.imgPath }" width="60" height="25"/></s:if></span>
					  	<input type="hidden" name="businessViewSet.businessViewObjs[${st.index }].imgName" value="${viewObj.imgName }">
					  </td>
					  <td>
					  	<input type="file" name="myFile" class="example" style="position:absolute;" id="file_${st.index }"/>
					  	<span class="gray-btn-l" id="button_${st.index }"><span class="btn-r"><span class="btn-m"><a >&nbsp;&nbsp;&nbsp;&nbsp;浏&nbsp;&nbsp;&nbsp;览&nbsp;&nbsp;&nbsp;&nbsp;</a></span></span></span>
					  </td>
					  <td>
					  	<s:textfield name="businessViewSet.businessViewObjs[%{#st.index}].viewObjName" value="%{#viewObj.viewObjName}" cssClass="viewtree" cssStyle="cursor:pointer;" readonly="true"/>
					  	<input type="hidden" name="businessViewSet.businessViewObjs[${st.index }].viewObjId" value="${viewObj.viewObjId }">
					  	<input type="hidden" name="businessViewSet.businessViewObjs[${st.index }].moduleId" value="${viewObj.moduleId }">
					  	<input type="hidden" name="businessViewSet.businessViewObjs[${st.index }].url" value="${viewObj.url }">
					  </td>
					  <td><s:if test="#viewObj.id > 1"><span class="topn-portlet-ico topn-portlet-ico-up "  title="上移"></span></s:if> <s:if test="#viewObj.id < 10"><span class="topn-portlet-ico topn-portlet-ico-down-off " title="下移"></span></s:if> <span class="ico ico-delete" title="删除"></span></td>
			        </tr>
				</s:iterator>
				<tr>
			      <td colspan="6"><div class="left margin8"><b>注：</b></div>
			        <div class="left  margin3" style="line-height:20px;">1.<b>建议Logo图片不要超过190*40像素。</b>像素<br />
			          2.<b>Logo图片大小不能超过2M。</b><br />
			          3.<b>图片只能上传jpg、jpeg、gif、png、swf这几种格式。</b><br />
			        </div></td>
			    </tr>
				<%--<tr>
					<td colspan="6" class="blackbg">幻灯片设置</td>
				</tr>
				<tr>
			      <td colspan="6"><div class="left lineheight26"><b>切换频率：</b></div>
			        <div class="left lineheight26"><s:select list="#{'15':'15','30':'30','60':'60','90':'90'}" name="businessViewSet.switchFrequency"/>(秒)</span></td>
			    </tr>
				<tr>
				  <td colspan="6"><div class=" title left"><b>切换频率：</b></div>
				  <span><s:select list="#{'15':'15','30':'30','60':'60','90':'90'}" name="businessViewSet.switchFrequency"/>(秒)</span>
				  <div class="speed left"><div class="ico"></div></div></td>
				</tr> --%>
				</tbody>
			</table>
		</s:form>
	</page:param>
</page:applyDecorator>
</body>
<script type="text/javascript">
var panel;
var $viewObjName;
$(document).ready(function(){
	decorator();
	$("#topBtn1").click(function() {
		window.close();
  	});
	$("#ok_button").click(function() {
		submitViewSet();
  	});
	$("#cancel_button").click(function() {
		closeWindow();
  	});
  	$(".viewtree").click(function(event){
  		$viewObjName = $(this)
  		openViewTree(event);
  	});
  	$(".ico-delete").click(function(){
  		var $tr = $(this).parent().parent();
  		$tr.children().each(function(index,domEle){
			if(index != 0) {
				$(domEle).children("input").val("");
				if(index == 2) {
					$(domEle).find("img").remove();
				}
			}
  	  	});
  		decorator();
  	});
  	$(".topn-portlet-ico-up").click(function(){
  		move("up",$(this));
  	});
  	$(".topn-portlet-ico-down-off").click(function(){
  		move("down",$(this));
  	});
  	uploadImg();
  	//filePosition();
  	
});

function decorator() {
	$(".viewtree").each(function(){
		if($(this).val() == "") {
			$(this).val("请点击文本框选择内容");
		}
  	});
}

function move(ope,move_button) {
	var tr_src = move_button.parent().parent();
	var tr_dist = null;
	if("up" == ope){
		tr_dist = tr_src.prev();
	}else{
		tr_dist = tr_src.next();
	}
	var input_src_arr = tr_src.find("input");
	var input_dist_arr = tr_dist.find("input");
	var temp = "";
	for(var i = 0; i < input_src_arr.length; i++){
		if($(input_src_arr[i]).attr("type") != "file" && $(input_src_arr[i]).prev().attr("class") != "number"){
			temp = $(input_src_arr[i]).val();
			$(input_src_arr[i]).val($(input_dist_arr[i]).val());
			$(input_dist_arr[i]).val(temp);
		}
	}
	var img_src = tr_src.find(".box");
	var img_dist = tr_dist.find(".box")
	temp = img_src.html();
	img_src.html(img_dist.html());
	img_dist.html(temp);
	animateDisplay(tr_dist);
}

function animateDisplay(obj_dist) {
	var bgcss = obj_dist.css("backgroundColor");
	var count = 0;
	var num = window.setInterval(function(){
			if(count < 600){
				changeBgColor(obj_dist,bgcss); 
				count += 100;
			}else{
				clearInterval(num);
			}
		},100);
}

function changeBgColor(obj_dist,bgcss){
	if((bgcss == "#f0f0f0" && bgcss == obj_dist.css("backgroundColor")) 
			|| (bgcss == "transparent" && bgcss == obj_dist.css("backgroundColor"))){
		obj_dist.css("backgroundColor","red");
	}else if(bgcss == "#f0f0f0" && obj_dist.css("backgroundColor") == "red"){
		obj_dist.css("backgroundColor","#f0f0f0");
	}else if( bgcss == "transparent" && obj_dist.css("backgroundColor") == "red"){
		obj_dist.css("backgroundColor","transparent");
	}
}

function filePosition() {
	var $buttons = $(".gray-btn-l");
	var $files = $("[name=myFile]");
	for(var i = 0; i < $buttons.length; i++){
		var b_offset = $($buttons[i]).offset();
		var left = b_offset.left;
		var top = b_offset.top;
		$($files[i]).offset({top:top,left:left});
	}
}

function lockFile(obj) {
	$(":file").attr("disabled","disabled");
	obj.attr("disabled","");
}

function unlockFile() {
	$(":file").attr("disabled","");
}

function uploadImg() {
	$(":file").change(function() {
		var value = $(this).val();
		if(checkImage(value)){
			upload($(this));
		}
	});
}

function checkImage(imagePath) {
	if(imagePath == "") {
		var _information = new information({text:"请选择图片。"});
		_information.show();
		return false;
	}
	var extStart = imagePath.lastIndexOf("."); 
    var ext = imagePath.substring(extStart,imagePath.length).toUpperCase();
    if(ext != ".BMP" && ext != ".PNG" && ext != ".GIF" && ext != ".JPG" && ext != ".JPEG"){ 
    	var _information = new information({text:"图片限于bmp,png,gif,jpeg,jpg格式。"});
		_information.show();
	    return false; 
    }
    var fso = new ActiveXObject("Scripting.FileSystemObject");
    if(fso.GetFile(imagePath).size > (2 * 1024 * 1024)){  
    	var _information = new information({text:"图片不能大于2M。"});
		_information.show();     
	 	return false; 
    }
	return true;
}

function upload(obj) {
	var $viewset = $('#viewset');
	$viewset.attr("enctype","multipart/form-data");
	$viewset.ajaxSubmit({
		//method: 'POST',//方式
		url: "${ctx}/homepage/imageUpLoad.action",//表单的action
		dataType:'html',
		beforeSubmit:function() {
			lockFile(obj);
		},
		success: (function(data){
			unlockFile();
			obj.val("");
			var returnJson = (new Function("return " + $(data).html()))();
			var imagePath = returnJson.imagePath;
			var imageFileName = returnJson.imageFileName;
			var img = $("<img>").attr("src","${ctx}/" + imagePath).attr("width","60").attr("height","25");
			obj.parent().prev().children("span").html(img);
			obj.parent().prev().children("input").val(imageFileName);
		}),
		error:function(msg) {
			alert(msg.responseText);
		}
	});
}

function openViewTree(event) {
	panel = new winPanel({
			type: "POST",
			url: "${ctx}/homepage/viewTree.action",
			width: 260,
			x: 350,//event.pageX - 300,
			isautoclose: false,
			y: 30,//event.pageY,
			closeAction: "close",
			listeners: {
	 			closeAfter: function() {
		  			//stopRefresh();
		  			//self.avgCpuRTAnalysis = null;
	 			},
	 			loadAfter: function() {
	 				//popShowFlash("DeviceAvgCPUUtil",icoId,"cpu利用率(%)实时分析","%");
	 			}
			}
		},
		{winpanel_DomStruFn: "blackLayer_winpanel_DomStruFn"}
	); 
}

function panelClose() {
	panel.close("close");
}

function submitViewSet() {
	$("#viewset").attr("enctype","application/x-www-form-urlencoded");
	var ajaxParam = $("#viewset").serialize();
	$.ajax({
		type: "POST",
		dataType:'json',
		url: "${ctx}/homepage/viewSet!saveViewSet.action",
		data: ajaxParam,
		success: function(data, textStatus){
			opener.location.reload();
			closeWindow();
		}
	});
}

function closeWindow() {
	var tempDir = $("#tempDir").val();
	$.ajax({
		type: "GET",
		dataType:'json',
		url: "${ctx}/homepage/viewSet!delTempImg.action?businessViewSet.tempDir=" + tempDir,
		success: function(data, textStatus){
			window.close();
		}
	});
}
</script>
</html>