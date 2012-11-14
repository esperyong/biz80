<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!--
	author:qiaozheng
	description: 业务单位图标切换
	uri:{domainContextPath}/bizsm/bizservice/ui/bizuser-changeimg
 -->
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>替换图标</title>

<link href="${ctx}/css/portal.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<style type="text/css" media="screen">
	html, body	{ height:100%; }
	body { margin:0; padding:0; overflow:auto; text-align:center;
		   background-color: #ffffff; }
	#flashContent { display:none; }

	.bizimgnobr{display:inline-block;width:70px;overflow:hidden;border:0px solid red;text-overflow:ellipsis;cursor:hand}

</style>
<style type="text/css">
.pop-win{ overflow:hidden; margin:0 auto; z-index:999;}
.pop-win-tl{ background:url(../../../images/uicomponent/window/pop-window.gif) left 0 no-repeat; padding-left:10px;}
.pop-win-tr{ background:url(../../../images/uicomponent/window/pop-window.gif) right -29px no-repeat; padding-right:10px;}
.pop-win-tc{ background:url(../../../images/uicomponent/window/pop-window.gif) right -58px repeat-x; overflow:auto;zoom:1;padding:7px 4px 6px;}
.pop-title-m{ background:url(../../../images/uicomponent/window/pop-title-ico.gif) 0% 50% no-repeat; text-indent:0px; color:#fff; font-weight:700; display:inline-block;*display:inline;zoom:1;padding-left:15px; padding-right:0px;}
.pop-title-m span{ font-weight:700; margin-top:1px;}
.pop-title{background:none; padding-right:3px; float:left;zoom:1; display:block; text-indent:0; padding-left:0;}
.pop-win-m{ background:#060606; border:#6d6d6d 1px solid; border-bottom:none; border-top:none; padding:0 5px;}
.pop-win-content{ overflow-x:hidden;overflow-y:auto;background:#fff; border:#6B6B6B 1px solid}
.pop-win-bl{ background:url(../../../images/uicomponent/window/pop-window-bottom.gif) no-repeat left 0;padding-left:10px;}
.pop-win-br{ background:url(../../../images/uicomponent/window/pop-window-bottom.gif) no-repeat right -25px ; padding-right:10px;}
.pop-win-bc{ background:url(../../../images/uicomponent/window/pop-window-bottom.gif) repeat-x left -50px;height:25px; vertical-align:middle; padding:0;}
</style>

<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script src="${ctx}/js/component/cfncc.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/js/bizservice/ajaxcommon.js"></script>
<script type="text/javascript" src="${ctx}/js/bizservice/common.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery.blockUI.js "></script>

<script type="text/javascript" src="${ctx}/flash/bizsm/swfobject.js"></script>
<script type="text/javascript" src="${ctx}/js/bizservice/CallFlash.js"></script>
<script type="text/javascript" src="${ctx}/js/bizservice/CallJS.js"></script>

<script src="${ctx}/js/component/popwin.js" type="text/javascript"></script>
<script>
	var confirmConfig = {width: 200,height: 80};

	$(function(){
		$("#fileUpload_area").css("position", "absolute");
		$("#fileUpload_area").css("top", "10px");
		$("#fileUpload_area").css("left", "10px");
		$("#fileUpload_area").css("z-index", "100");
		$("#fileUpload_area").css("width", "440px");
		$('#fileUpload_area').hide();

		$('#addBtn').click(function(){
			$('#fileUpload_area #img-name').val("");

			$('#fileUpload_area').slideDown(300, function(){
				if($("#middleElement_bgDiv").size() == 0){
					$("<div>").attr("id","middleElement_bgDiv").css(
						{
							position:"absolute",
							left:"0px",
							top:"0px",
							width:$(window).width()+"px",
							height:Math.max($("body").height(),$(window).height())+"px",
							filter:"Alpha(Opacity=40)",
							opacity:"0.4",
							backgroundColor:"#AAAAAA",
							zIndex:"99",
							margin:"0px",
							padding:"0px"
						}
					).appendTo("body");
				}else{
					$("#middleElement_bgDiv").show();
				}

				$('#fileUpload_area #img-name').focus();
			});
		});
		$('#deleteBtn').click(function(){

			var $selectedLi = $('#img-box>ul>li[isClicked="true"]');
			if($selectedLi.size() == 0){
				//alert("请选择要删除的数据。");
				var _information  = information();
				_information.setContentText("请选择要删除的数据。");
				//alert($('.pop-win').html());
				_information.show();
				return false;
			}

			var defaultImageTemp = $selectedLi.attr("defaultImage");
			if(defaultImageTemp == "true"){
				//alert("不能删除系统默认业务单位图标。");
				var _information  = information();
				_information.setContentText("不能删除系统默认业务单位图标。");
				_information.show();
				return false;
			}
			var uriStr = $selectedLi.attr("uri");

			//var idx = uriStr.indexOf("folder/");
			//var lastIdx = uriStr.indexOf("/image");
			//var folderIdStr = uriStr.substring(idx+1, lastIdx);
			var uriStr2 = uriStr.replace("bizsm-model-icon", "bizsm-model");

			$.ajax({
				type: 'DELETE',
				url: "${ctx}"+uriStr,
				contentType: "application/x-www-form-urlencoded",
				processData: false,
				cache:false,
				error: function (request) {
					var errorMessage = request.responseXML;
					var $errorObj = $(errorMessage).find('FieldErrors>FieldError');
					$errorObj.each(function(i){
						var fieldId = $(this).find('FieldId').text();
						var field = document.getElementById(fieldId);
						var errorInfo = $(this).find('ErrorInfo').text();
						alert(errorInfo);
						field.focus();
					});
				},
				success: function(msg){
				  f_deleteImg(uriStr2);
				}
			 });


		});
		$('#fileUpload_area #uploadCancle,#fileUpload_area #closeBtnForUpload').click(function(){
			$('#fileUpload_area').slideUp(300, function(){
				$("#middleElement_bgDiv").hide();
			});
		});

		$("#fileUpload_area #uploadBtn").click(function(){
			 var imageName = $("#fileUpload_area #img-name").val();
			 if($.trim(imageName) == ''){
				//alert("图标名称不能为空。");
				var _information  = information();
				_information.setContentText("图标名称不能为空。");
				_information.show();
				$("#fileUpload_area #img-name").select();
				$("#fileUpload_area #img-name").focus();
				return false;
			 }
			 if(common_specialChar(imageName, /[\"\'%\\:?<>|;&@#*]/)){
				//alert("图标名称不能包含特殊字符(\"'%\\:?<>|;&@#*)。");
				var _information  = information();
				_information.setContentText("图标名称不能包含特殊字符(\"'%\\:?<>|;&@#*)。");
				_information.show();
				$("#fileUpload_area #img-name").select();
				$("#fileUpload_area #img-name").focus();
				return false;
			 }
			 if(imageName.length > 50){
				//alert("图标名称的输入长度不能超过50个字符。");
				var _information  = information();
				_information.setContentText("图标名称的输入长度不能超过50个字符。");
				_information.show();
				$("#fileUpload_area #img-name").select();
				$("#fileUpload_area #img-name").focus();
				return;
			}

			 var fileContentName = $("#fileUpload_area #img-file").val();
			 if($.trim(fileContentName) == ''){
				//alert("没有选择要上传的文件。");
				var _information  = information();
				_information.setContentText("没有选择要上传的文件。");
				_information.show();
				return false;
			 }
			 /*
			 if(common_fileExists(fileContentName) == false){
				 alert("要上传的文件不存在，请重新选择上传文件。");
				 return false;
			 }
			*/
			 var idxTemp = fileContentName.lastIndexOf("\\");
			 var fileNameTemp = fileContentName.substring(idxTemp+1);
			 var dotIdx = fileNameTemp.lastIndexOf(".");
			 var fileRealName = fileNameTemp.substring(fileNameTemp, dotIdx);
			 /*
			 if(common_strInvalid(fileRealName)){
				alert("上传的图片文件名称不能包含特殊字符(\"\'<>``!@#$%^&*+\/\/\/\\//?,.)");
				return false;
			 }
			 */
			 var typeName = fileNameTemp.substring(dotIdx+1);
			 typeName = typeName.toLowerCase();
			 if(typeName != "jpg"
						&& typeName != "jpeg"
						&& typeName != "gif"
						&& typeName != "png"
						&& typeName != "swf"){
				//alert("上传的图标文件类型只能是(jpg、jpeg、gif、png、swf)。");
				var _information  = information();
				_information.setContentText("上传的图标文件类型只能是(jpg、jpeg、gif、png、swf)。");
				_information.show();
				return false;
			 }
			 //显示加载状态条
			$.blockUI({message:$('#loading')});

			fileContentName = encodeURI(fileContentName);

			 validate(imageName, fileContentName);
		});

		//f_loadTakeSnapshotFlash();
		f_loadImgList();
	});

	function f_loadImgList(){
		$.get('${ctx}/folder/bizsm-model-icon/image/',{},function(data){
			var dataDom = func_asXMLDom(data);

			var $data = $(dataDom);
			//alert($data.find('html').size());

			var $ul = $data.find('body>ul');
			var $imgHref = $ul.find('>li.image>a');

			var $imgUL = $('#img-box>ul');
			$imgUL.empty();
			$imgHref.each(function(cnt){
				var $href = $(this);

				var defaultImageTemp = "false";
				var theDefaultImage = $href.attr("defaultImage");
				if(theDefaultImage != null && theDefaultImage != ""){
					defaultImageTemp = theDefaultImage;
				}

				var $img = $('<img src="${ctx}'+$href.attr("uri")+'"/>');
				var $span = $('<span class="bizimgnobr" title="'+$.trim($href.text())+'">'+$href.text()+'</span>');
				var $li = $('<li uri="'+$href.attr("uri")+'"></li>');
				$li.attr("defaultImage", defaultImageTemp);

				var $nobr = $('<nobr></nobr>');
				$nobr.append($img);
				$nobr.append($span);
				$li.append($nobr);
				$imgUL.append($li);
			});

			$imgUL.find('>li').hover(function(){
				var $this = $(this);
				$this.addClass("on");
			}, function(){
				var $this = $(this);
				if($this.attr("isClicked") != "true"){
					$this.removeClass("on");
				}
			});

			$imgUL.find('>li').click(function(){
				var $this = $(this);

				var $oldClicked = $('#img-box>ul>li.on');
				$oldClicked.removeClass("on");
				$oldClicked.attr("isClicked", "false");

				$this.attr("isClicked", "true");
				$this.addClass("on");

				//call flash
				//parent.choose("bizuser", $this.attr("uri"));
			});

			$('#execBtn').click(function(){
				var $selectedLi = $imgUL.find('>li[isClicked="true"]');
				var imgURI = $selectedLi.attr("uri");
				window.returnValue = imgURI;//$imgUL.find('>li[isClicked="true"]>img').attr("src");
				window.close();
			});

			$('#cancelBtn,#closeIcon').bind("click", function(){
				window.close();
			});
		});
	}
	function f_deleteImg(uri){
		 $.ajax({
			type: 'DELETE',
			url: "${ctx}"+uri,
			contentType: "application/x-www-form-urlencoded",
			processData: false,
			cache:false,
			error: function (request) {
			   var errorMessage = request.responseXML;
			var $errorObj = $(errorMessage).find('FieldErrors>FieldError');
			$errorObj.each(function(i){
			 var fieldId = $(this).find('FieldId').text();
			 var field = document.getElementById(fieldId);
			 var errorInfo = $(this).find('ErrorInfo').text();
			 alert(errorInfo);
			 field.focus();
			});
			},
			success: function(msg){
			  f_loadImgList();
			}
		 });
	}

	function validate(imageName, fileContentName){
		$.ajax({
			type: 'POST',
			url: "${ctx}/folder/bizsm-model/image/",
			contentType: "application/x-www-form-urlencoded",
			data: "imageName=" + imageName + "&fileContentName=" + fileContentName,
			processData: false,
			cache:false,
			error: function (request) {
			   var errorMessage = request.responseXML;
				var $errorObj = $(errorMessage).find('FieldErrors>FieldError');
				$errorObj.each(function(i){
				 var fieldId = $(this).find('FieldId').text();
				 var field = document.getElementById(fieldId);
				 var errorInfo = $(this).find('ErrorInfo').text();
				 alert(errorInfo);
				 field.focus();
				});

				$.unblockUI();// 屏蔽loading
			},
			success: function(msg){
			   uploadCallback(msg);
			}
		});
	}

	function uploadCallback(msg){
		$('input[name="imageFile"]').val(encodeURI($('input[name="imageFile"]').val()));
		$("#fileUpload_area #fileUpload_frm").attr("action", "${ctx}/folder/bizsm-model/image/");
		$("#fileUpload_area #fileUpload_frm").submit();
	}

	function success(uriStr){
		var idx = uriStr.lastIndexOf("/");
		var idStr = uriStr.substring(idx+1);
		var targeURI = "${ctx}/folder/bizsm-model-icon/image/"+idStr+"?__http_method=PUT&imageName="+$('#img-name').val();
		// call flash
		flashContenObj.takeSnapshot("${ctx}"+uriStr, targeURI, true, "f_takeSnapshotSuccess", "f_takeSnapshotFail");
	}
	function fail(msg){
		alert(msg);
		$.unblockUI();// 屏蔽loading
	}
	function f_takeSnapshotSuccess(){
		f_loadImgList();
		$('#fileUpload_area #uploadCancle').click();
		$.unblockUI();// 屏蔽loading
	}
	function f_takeSnapshotFail(){
		//alert("上传失败。");
		var _information  = information();
		_information.setContentText("上传失败。");
		_information.show();
		$.unblockUI();// 屏蔽loading
	}

	function flashflag(){
		//alert("flash load.");
	}
	function f_loadTakeSnapshotFlash(){
		var swfVersionStr = "10.0.0";
		var xiSwfUrlStr = "playerProductInstall.swf";
		var flashvars = {};
		//flashvars["uri"] = "./testAssets/FullData.xml";
		flashvars["webRootPath"] = "${ctx}/";
		flashvars["picwidth"] = "55";//要生成图标的宽度
		flashvars["picheight"] = "55";//要生成图标的高度


		var params = {};
		params.quality = "high";
		params.bgcolor = "#ffffff";
		params.allowscriptaccess = "always";
		params.wmode = 'transparent';
		params.allowfullscreen = "false";
		params.enablejs= "true";

		var attributes = {};
		attributes.id = "TakeSnapshot";
		attributes.name = "TakeSnapshot";
		attributes.align = "middle";
		swfobject.embedSWF(
			"${ctx}/flash/bizsm/TakeSnapshot.swf", "flashContent",
			"0", "0",
			swfVersionStr, xiSwfUrlStr,
			flashvars, params, attributes);
		swfobject.createCSS("#flashContent", "display:block;text-align:left;");

		initFlashContentObj("TakeSnapshot");
	}

</script>
</head>
<body onload="f_loadTakeSnapshotFlash()" class="pop-window">

	<div id="flashContent" style="position:absolute;top:0px;left:0px;z-index:-101;height:0;width:0;display:none"></div>

	<div id="fileUpload_area" class="pop-div" style="display:none;">
		<form id="fileUpload_frm" enctype="multipart/form-data" method="post" target="iframe_asyncupload">
			<div class="pop-top-l" style="cursor:default">
				<div class="pop-top-r"  style="cursor:default">
					<div class="pop-top-m"  style="cursor:default">
						<a id="closeBtnForUpload" class="win-ico win-close" style="cursor:hand"></a>
						<span class="pop-top-title">添加图标</span>
					</div>
				</div>
			</div>
			<div class="pop-middle-l">
				<div class="pop-middle-r">
					<div class="pop-middle-m">
						<div class="pop-content">
							<ul class="fieldlist-n">
								<li>
									图标名称&nbsp;：<input type="text" id="img-name" name="imageName" style="width:200px"><span class="red">*</span>
								</li>
								<li>
									图标文件&nbsp;：<input type="file" id="img-file" name="imageFile" style="width:200px"><span class="red">*</span>
								</li>
								<li>
									说明&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;：1、图标文件只能上传jpg、jpeg、gif、png、swf格式。<br/>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									2、图标文件大小不能超过2M。
								</li>
							</ul>
					  </div>
					</div>
				</div>
			</div>
			<div class="pop-bottom-l">
				<div class="pop-bottom-r">
					<div class="pop-bottom-m">
					   <span id="uploadBtn" class="black-btn-l"><span class="btn-r"><span class="btn-m"><a>确定</a></span></span></span>
					   <span id="uploadCancle" class="black-btn-l"><span class="btn-r"><span class="btn-m"><a>取消</a></span></span></span>
					</div>
				</div>
			</div>
		</form>
		<iframe name="iframe_asyncupload" style="border: 0;width: 0px;height: 0px;"></iframe>
	</div>

		<div class="pop">
			<div class="pop-top-l">
				<div class="pop-top-r">
					<div class="pop-top-m">
						<a id="closeIcon" class="win-ico win-close"></a>
						<span class="pop-top-title">替换图标</span>
					</div>
				</div>
			</div>
			<div class="pop-m">
				<div class="pop-content">
					<ul class="fieldlist-n">
						<li>请选择合适的图标替换当前图标。</li>
						<li>
							<table width="100%" align="center">
								<tr>
									<td width="80%">
										<div style="display:inline-block;height:300px;padding:0.5px 0 0 0;border:1px solid #CCC;">
											<div style="height:20px;padding:5px 0 0 5px;background-Color:#CCC;">图标</div>
											<div class="set-panel-content-white">
												<div id="img-box" class ="img-show" style="OVERFLOW-Y: scroll; OVERFLOW-X: hidden; WIDTH: 100%; HEIGHT: 275px;">
													<ul>
													</ul>
												 </div>
											</div>
										</div>
									</td>
									<td>
										<div class="for-inline">
											<span id="addBtn" class="gray-btn-l">
												<span class="btn-r">
													<span class="btn-m"><a>&nbsp;&nbsp;&nbsp;&nbsp;添加&nbsp;&nbsp;&nbsp;&nbsp;</a></span>
												</span>
											</span>
											<span id="deleteBtn" class="gray-btn-l">
												<span class="btn-r">
													<span class="btn-m"><a>&nbsp;&nbsp;&nbsp;&nbsp;删除&nbsp;&nbsp;&nbsp;&nbsp;</a></span>
												</span>
											</span>
										</div>
									</td>
								</tr>
							</table>
						</li>
					</ul>
				</div>
		  </div>
		  <div class="pop-bottom-l">
				<div class="pop-bottom-r">
					<div class="pop-bottom-m">
					   <span id="cancelBtn" class="win-button"><span class="win-button-border"><a>取消</a></span></span>
					   <span id="execBtn" class="win-button"><span class="win-button-border"><a>确定</a></span></span>
					</div>
				</div>
		  </div>
		</div>

		<div class="loading" id="loading" style="display:none;">
		 <div class="loading-l">
		  <div class="loading-r">
			<div class="loading-m">
			   <span class="loading-img">载入中，请稍候...</span>
			</div>
		  </div>
		  </div>
		</div>

</body>
</html>