<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>图片管理</title>
<link href="${ctx}/css/portal.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />


<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/portal02.css" rel="stylesheet" type="text/css" />
<style type="text/css">
	.img-show1{ overflow:hidden;width:100%;}
	.img-show1 ul{ overflow:hidden; margin:0 ; padding:0;}
	.img-show1 li{ float:left; margin:5px; text-align:center; width:50px;}
	.img-show1 li.on{ border:#c6c6c6 1px solid; background:#eee;}
	.img-show1 li img{ width:40px; height:40px; clear:none; display:block; margin:2px auto; cursor:pointer;}
	.img-show1 li span{ text-align:center;}

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
	var confirmConfig = {width: 300,height: 80};
	var liIndex = "dc";
	var doMark = "";
	var id = "";
	$(function(){
		$("#fileUpload_area").css("position", "absolute");
		$("#fileUpload_area").css("top", "10px");
		$("#fileUpload_area").css("left", "10px");
		$("#fileUpload_area").css("z-index", "100");
		$("#fileUpload_area").css("width", "440px");
		$('#fileUpload_area').hide();

		//地图分类隐藏
		$('#custom-gp-map-sel').hide();
		$('#img-bg').hide();
		//清空显示区域
		$("#showDefaultImg").empty();
		$("#showDefineImg").empty();

		f_loadImage("folder/bizsm-customelement-baseshape-icon/image/");

		//图片类型select选择
		$('#imgClassSelect').bind("change", function(){
			var selectValue = this.value;
			showImgForSelectValue(selectValue);
		});

		//li选择事件绑定
		$('#dc').bind("click",function(){
			$("#showDefaultImg").empty();
			$("#showDefineImg").empty();
			$('#dc').addClass("nonce");
			$('#bg').removeClass();
			$('#imgClassSelect').show();
			$('#imgClassSelect').val("img-box-custom-gp-baseshape");
			$('#custom-gp-map-sel').hide();
			$('#img-bg').hide();
			f_loadImage("folder/bizsm-customelement-baseshape-icon/image/");
			liIndex = "dc";
		});
		$('#bg').bind("click",function(){
			$("#showDefaultImg").empty();
			$("#showDefineImg").empty();
			$('#bg').addClass("nonce");
			$('#dc').removeClass();
			$('#imgClassSelect').hide();
			$('#custom-gp-map-sel').hide();
			$('#img-bg').show();
			f_loadImage("folder/bizsm-customelement-background-icon/image/");
			liIndex = "bg";
		});

		//绑定切换地图select change事件
		$('#custom-gp-map-sel').bind("change", function(){
			var mapSelVal = this.value;
			if("china" == mapSelVal){
				f_loadImage("folder/bizsm-customelement-map-china-icon/image/");
			}else if("world" == mapSelVal){
				f_loadImage("folder/bizsm-customelement-map-world-icon/image/");
			}
		});

		//删除按钮事件绑定
		$('#btnImgDel').click(function(){
			var $selectedLi = $('#showDefineImg>li[isClicked="true"]');
			if($selectedLi.size() == 0){
				//alert("请选择要删除的数据。");
				var _information  = information();
				_information.setContentText("请选择要删除的数据。");
				_information.show();
				return false;
			}

			var _confirm = confirm_box(confirmConfig);
			_confirm.setContentText("是否删除选中的图片？");
			_confirm.show();
			_confirm.setConfirm_listener(function() {
				_confirm.hide();

				var uriValue;
				if(liIndex == "dc"){
					uriValue = $('#imgClassSelect').val()
				}
				if(liIndex == "bg"){
					uriValue = $('#img-bg').val();
				}

				var uriStr = $selectedLi.attr("uri");
				var uriStr2 = uriStr.replace("-icon", "");

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
						deleteFlashImg(uriStr2,uriValue);
					}
				});
			});
			_confirm.setCancle_listener(function(){
				_confirm.hide();
			});
		});

		//新增按钮事件绑定
		$('#btnImgAdd').click(function(){
			var imgValue = $('#imgClassSelect').val();
			if(imgValue == ""){
				//alert("请选择图片类型。");
				var _information  = information();
				_information.setContentText("请选择图片类型。");
				_information.show();
				return;
			}
			$('#fileUpload_area #img-name').val("");
			$('#fileUpload_area #img-file').val("");

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

				$('#img-name').removeClass("readOnly");
				$('#img-name').focus();

				doMark = "new";
			});
		});

		//编辑按钮事件绑定
		$('#btnImgEdit').click(function(){
			var $selectedLi = $('#showDefineImg>li[isClicked="true"]');
			if($selectedLi.size() == 0){
				//alert("请选择一张图片。");
				var _information  = information();
				_information.setContentText("请选择一张图片。");
				_information.show();
				return false;
			}
			var imgURI = $selectedLi.attr("uri");
			var text = $selectedLi.text();

			$('#fileUpload_area #img-name').val("");
			$('#fileUpload_area #img-file').val("");

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
			});

			$('#img-name').val(text);
			$('#img-name').attr("readOnly", true);

			var src = $('#showDefineImg>li[isClicked="true"]>IMG').attr("src");
			var idx = src.lastIndexOf("/");
			id = src.substring(idx+1);

			doMark = "update";
		});

		//关闭窗口
		$('#closeIcon').bind("click",function(){
			window.close();
		});

		//弹出层取消
		$('#uploadCancle,#closeBtnForUpload').bind("click",function(){
			$('#fileUpload_area').slideUp(300, function(){
				$("#middleElement_bgDiv").hide();
			});
		});

		//弹出层确定按钮
		$("#uploadBtn").click(function(){
			var imageName = $("#img-name").val();
			if($.trim(imageName) == ''){
				//alert("图标名称不能为空。");
				var _information  = information();
				_information.setContentText("图标名称不能为空。");
				_information.show();
				$("#img-name").select();
				$("#img-name").focus();
				return false;
			}
			if(common_specialChar(imageName, /[\"\'%\\:?<>|;&@#*]/)){
				//alert("图标名称不能包含特殊字符(\"'%\\:?<>|;&@#*)。");
				var _information  = information();
				_information.setContentText("图标名称不能包含特殊字符(\"'%\\:?<>|;&@#*)。");
				_information.show();
				$("#img-name").select();
				$("#img-name").focus();
				return false;
			}
			if(imageName.length > 50){
				//alert("图标名称的输入长度不能超过50个字符。");
				var _information  = information();
				_information.setContentText("图标名称的输入长度不能超过50个字符。");
				_information.show();
				$("#img-name").select();
				$("#img-name").focus();
				return;
			}

			 var fileContentName = $("#img-file").val();
			 if($.trim(fileContentName) == ''){
				//alert("没有选择要上传的文件。");
				var _information  = information();
				_information.setContentText("没有选择要上传的文件。");
				_information.show();
				return false;
			 }

			 var idxTemp = fileContentName.lastIndexOf("\\");
			 var fileNameTemp = fileContentName.substring(idxTemp+1);
			 var dotIdx = fileNameTemp.lastIndexOf(".");
			 var fileRealName = fileNameTemp.substring(fileNameTemp, dotIdx);

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

			if(doMark == "new"){
				validate(imageName, fileContentName);
			}
			if(doMark == "update"){
				imgupdate();
			}
		});


	});

	function f_loadImage(uri){
		//显示加载状态条
		$.blockUI({message:$('#loading')});

		$.get('${ctx}/'+uri,{},function(data){
			var dataDom = func_asXMLDom(data);
			var $data = $(dataDom);

			var $ul = $data.find('body>ul');
			var $imgHref = $ul.find('>li.image>a');

			var $imgUL = $("#showDefaultImg");
			$imgUL.empty();

			var $imgUL2 = $("#showDefineImg");
			$imgUL2.empty();

			$imgHref.each(function(cnt){
				var $href = $(this);
				if($href.attr("defaultImage")=="true"){
					var $img = $('<img src="${ctx}/'+$href.attr("uri")+'" width=60 height=55/>');
					var $span = $('<span style="cursor:hand">'+$href.text()+'</span>');
					var $li = $('<li uri="'+$href.attr("uri")+'" shapeType="'+$href.attr("shapeType")+'"></li>');
					$li.append($img);
					$li.append($span);
					$imgUL.append($li);
				}else{
					var $img = $('<img src="${ctx}/'+$href.attr("uri")+'" width=60 height=55/>');
					var $span = $('<span style="cursor:hand">'+$href.text()+'</span>');
					var $li = $('<li uri="'+$href.attr("uri")+'" shapeType="'+$href.attr("shapeType")+'"></li>');
					$li.append($img);
					$li.append($span);
					$imgUL2.append($li);
				}
				//<li><nobr><img src="WebCSSImages/images/backboard/start.png" width="40" height="40" /><span>开始</span></nobr></li>
			});
			f_bindSelect()

			$.unblockUI();// 屏蔽loading
		});
	}

	/**
	* 绑定图标选中效果及点击事件
	*
	*/
	function f_bindSelect(){
		//设置鼠标移动图片选中效果
		$('#showDefineImg>li').hover(function(){
			var $this = $(this);
			$this.addClass("on");
		}, function(){
			var $this = $(this);
			if($this.attr("isClicked") != "true"){
				$this.removeClass("on");
			}
		});

		//点击图片设置选中效果及标识
		$('#showDefineImg>li').click(function(event){
			var $this = $(this);

			event.stopPropagation();

			//判断业务服务是否处于启用状态

			var $oldClicked = $('li.on');

			$oldClicked.removeClass("on");
			$oldClicked.attr("isClicked", "false");

			$this.attr("isClicked", "true");
			$this.addClass("on");
		});
	}

	//自定义图片展示	selectValue：自定义图片类型所选定的值
	function showImgForSelectValue(selectValue){
		if("img-box-custom-gp-map" == selectValue){
			$('#custom-gp-map-sel').show();
			var mapSelVal = $('#custom-gp-map-sel').val();
			if("china" == mapSelVal){
				f_loadImage("folder/bizsm-customelement-map-china-icon/image/");
			}else if("world" == mapSelVal){
				f_loadImage("folder/bizsm-customelement-map-world-icon/image/");
			}
		}else if("img-box-custom-gp-baseshape" == selectValue){
			$('#custom-gp-map-sel').hide();
			f_loadImage("folder/bizsm-customelement-baseshape-icon/image/");
		}else if("img-box-custom-gp-workflow" == selectValue){
			$('#custom-gp-map-sel').hide();
			f_loadImage("folder/bizsm-customelement-workflow-icon/image/");
		}else if("img-box-custom-gp-areanode" == selectValue){
			$('#custom-gp-map-sel').hide();
			f_loadImage("folder/bizsm-customelement-areanode-icon/image/");
		}
	}

	//删除flash相应的图片
	function deleteFlashImg(url,uriValue){
		$.ajax({
			type: 'DELETE',
			url: "${ctx}"+url,
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
				if(liIndex == "dc"){
					showImgForSelectValue(uriValue);
				}
				if(liIndex == "bg"){
					f_loadImage("folder/bizsm-customelement-background-icon/image/");
				}
			}
		});
	}

	//增加图片
	function validate(imageName, fileContentName){
		var url = "";
		if(liIndex == "dc"){
			if( $('#imgClassSelect').val() == "img-box-custom-gp-baseshape"){
				url = "${ctx}/folder/bizsm-customelement-baseshape/image/";
			}
			if( $('#imgClassSelect').val() == "img-box-custom-gp-workflow"){
				url = "${ctx}/folder/bizsm-customelement-workflow/image/";
			}
			if( $('#imgClassSelect').val() == "img-box-custom-gp-areanode"){
				url = "${ctx}/folder/bizsm-customelement-areanode/image/";
			}
			if( $('#imgClassSelect').val() == "img-box-custom-gp-map"){
				if("china" == $('#custom-gp-map-sel').val()){
					url = "${ctx}/folder/bizsm-customelement-map-china/image/";
				}else if("world" == $('#custom-gp-map-sel').val()){
					url = "${ctx}/folder/bizsm-customelement-map-world/image/";
				}
			}
		}
		if(liIndex == "bg"){
			url = "${ctx}/folder/bizsm-customelement-background/image/";
		}

		$.ajax({
			type: 'POST',
			url: url,
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
				$('input[name="imageFile"]').val(encodeURI($('input[name="imageFile"]').val()));
				$("#fileUpload_area #fileUpload_frm").attr("action", url);
				$("#fileUpload_area #fileUpload_frm").submit();
			}
		});
	}

	function success(uriStr){
		var idx = uriStr.lastIndexOf("/");
		var idStr = uriStr.substring(idx+1);
		var targeURI = "";

		if(liIndex == "dc"){
			if( $('#imgClassSelect').val() == "img-box-custom-gp-baseshape"){
				targeURI = "${ctx}/folder/bizsm-customelement-baseshape-icon/image/"+idStr+"?__http_method=PUT&imageName="+$('#img-name').val();
			}
			if( $('#imgClassSelect').val() == "img-box-custom-gp-workflow"){
				targeURI = "${ctx}/folder/bizsm-customelement-workflow-icon/image/"+idStr+"?__http_method=PUT&imageName="+$('#img-name').val();
			}
			if( $('#imgClassSelect').val() == "img-box-custom-gp-areanode"){
				targeURI = "${ctx}/folder/bizsm-customelement-areanode-icon/image/"+idStr+"?__http_method=PUT&imageName="+$('#img-name').val();
			}
			if( $('#imgClassSelect').val() == "img-box-custom-gp-map"){
				if("china" == $('#custom-gp-map-sel').val()){
					targeURI = "${ctx}/folder/bizsm-customelement-map-china-icon/image/"+idStr+"?__http_method=PUT&imageName="+$('#img-name').val();
				}else if("world" == $('#custom-gp-map-sel').val()){
					targeURI = "${ctx}/folder/bizsm-customelement-map-world-icon/image/"+idStr+"?__http_method=PUT&imageName="+$('#img-name').val();
				}
			}
		}
		if(liIndex == "bg"){
			targeURI = "${ctx}/folder/bizsm-customelement-background-icon/image/"+idStr+"?__http_method=PUT&imageName="+$('#img-name').val();
		}
		// call flash
		flashContenObj.takeSnapshot("${ctx}"+uriStr, targeURI, true, "f_takeSnapshotSuccess", "f_takeSnapshotFail");
	}

	function fail(msg){
		alert(msg);
		$.unblockUI();// 屏蔽loading
	}

	function f_takeSnapshotSuccess(){
		$('#fileUpload_area #uploadCancle').click();
		window.location.reload();
		if(liIndex == "dc"){
			$('#dc').click();
		}else{
			$('#bg').click();
		}
		$.unblockUI();// 屏蔽loading
	}

	function f_takeSnapshotFail(){
		alert("上传失败。");
		$.unblockUI();// 屏蔽loading
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

	//flash图片修改
	function imgupdate(){
		var url = "";
		if(liIndex == "dc"){
			if( $('#imgClassSelect').val() == "img-box-custom-gp-baseshape"){
				url = "${ctx}/folder/bizsm-customelement-baseshape/image/"+id+"?__http_method=PUT&mark=edit";
			}
			if( $('#imgClassSelect').val() == "img-box-custom-gp-workflow"){
				url = "${ctx}/folder/bizsm-customelement-workflow/image/"+id+"?__http_method=PUT&mark=edit";
			}
			if( $('#imgClassSelect').val() == "img-box-custom-gp-areanode"){
				url = "${ctx}/folder/bizsm-customelement-areanode/image/"+id+"?__http_method=PUT&mark=edit";
			}
			if( $('#imgClassSelect').val() == "img-box-custom-gp-map"){
				if("china" == $('#custom-gp-map-sel').val()){
					url = "${ctx}/folder/bizsm-customelement-map-china/image/"+id+"?__http_method=PUT&mark=edit";
				}else if("world" == $('#custom-gp-map-sel').val()){
					url = "${ctx}/folder/bizsm-customelement-map-world/image/"+id+"?__http_method=PUT&mark=edit";
				}
			}
		}
		if(liIndex == "bg"){
			url = "${ctx}/folder/bizsm-customelement-background/image/"+id+"?__http_method=PUT&mark=edit";
		}

		$('input[name="imageFile"]').val(encodeURI($('input[name="imageFile"]').val()));
		$("#fileUpload_area #fileUpload_frm").attr("action", url);
		$("#fileUpload_area #fileUpload_frm").submit();
	}

	//flash图片修改成功 后台调用
	function successForUpdate(uriStr){
		var idx = uriStr.lastIndexOf("/");
		var idStr = uriStr.substring(idx+1);
		var targeURI = "";

		if(liIndex == "dc"){
			if( $('#imgClassSelect').val() == "img-box-custom-gp-baseshape"){
				targeURI = "${ctx}/folder/bizsm-customelement-baseshape-icon/image/"+idStr+"?__http_method=PUT&imageName="+$('#img-name').val();
			}
			if( $('#imgClassSelect').val() == "img-box-custom-gp-workflow"){
				targeURI = "${ctx}/folder/bizsm-customelement-workflow-icon/image/"+idStr+"?__http_method=PUT&imageName="+$('#img-name').val();
			}
			if( $('#imgClassSelect').val() == "img-box-custom-gp-areanode"){
				targeURI = "${ctx}/folder/bizsm-customelement-areanode-icon/image/"+idStr+"?__http_method=PUT&imageName="+$('#img-name').val();
			}
			if( $('#imgClassSelect').val() == "img-box-custom-gp-map"){
				if("china" == $('#custom-gp-map-sel').val()){
					targeURI = "${ctx}/folder/bizsm-customelement-map-china-icon/image/"+idStr+"?__http_method=PUT&imageName="+$('#img-name').val();
				}else if("world" == $('#custom-gp-map-sel').val()){
					targeURI = "${ctx}/folder/bizsm-customelement-map-world-icon/image/"+idStr+"?__http_method=PUT&imageName="+$('#img-name').val();
				}
			}
		}
		if(liIndex == "bg"){
			targeURI = "${ctx}/folder/bizsm-customelement-background-icon/image/"+idStr+"?__http_method=PUT&imageName="+$('#img-name').val();
		}

		flashContenObj.takeSnapshot("${ctx}"+uriStr, targeURI, true, "f_takeSnapshotSuccess", "f_takeSnapshotFail");
	}
</script>

</head>

<body onload="f_loadTakeSnapshotFlash()" class="pop-window" style=" width:500px; ">
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
					<a id="closeIcon" class="win-ico win-close"></a><span class="pop-top-title">图片管理</span>
				</div>
			</div>
		</div>
		<div class="pop-m">
			<div class="pop-content">
				<div class="win-content">
					<div class="tab-grounp">
						<div class="tab-mid">
							<div class="tab-foot">
								<ul style=" position:relative; ">
									<li class="nonce" style="cursor:hand; " id="dc">
										<div class="tab-l">
											<div class="tab-r">
												<div class="tab-m"><a>自定义元素</a></div>
											</div>
										</div>
									</li>
									<li style="cursor:hand; " id="bg">
										<div class="tab-l">
											<div class="tab-r">
												<div class="tab-m"><a>背景</a></div>
											</div>
										</div>
									</li>
								</ul>
							</div>
						</div>
					</div>
					<div style="border:#ccc 1px solid; ">
						<div class="p-bg" style=" line-height:25px; padding-left:10px;  ">
							图片类型：
							<select name="select" id="imgClassSelect" style="margin:-2;width:100px; height:21px;  ">
								<option value="img-box-custom-gp-baseshape">基本形状</option>
								<option value="img-box-custom-gp-workflow">流程</option>
								<option value="img-box-custom-gp-areanode">区域与节点</option>
								<option value="img-box-custom-gp-map">地图</option>
							</select>
							<select id="custom-gp-map-sel">
								<option value="china">中国地图</option>
								<option value="world">世界地图</option>
							</select>
							<select name="select" id="img-bg" style="margin:-2;width:100px; height:21px;  ">
								<option value="img-box-custom-gp-baseshape">背景</option>
							</select>
						</div>
						<div style="background:#EAEAEA; height:30px;">
							<div class="left" style=" line-height:30px; "><span class="greytable-titlebg-ico"></span><b>默认图片</b></div>
						</div>
						<div class="img-show1" style="height:70px;overflow-y:auto;overflow-x:hidden" id="showDefaultImg">
							<ul>

							</ul>
						</div>
						<div style="background:#EAEAEA; height:30px;">
							<table>
								<tbody>
									<tr>
										<td style="text-align:left; line-height:30px; "><span class="greytable-titlebg-ico"></span><b>自定义图片<b></td>
										<td style="text-align:right; padding:5px;">
											<ul>
												<li title="编辑" class="picmanage-title pic-edit" style="margin-left:8px; margin-right:20px;" id="btnImgEdit"></li>
												<li title="删除" class="picmanage-title pic-del" style="margin-left:8px; " id="btnImgDel"></li>
												<li title="新增" class="picmanage-title pic-add" id="btnImgAdd"></li>
											</ul>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
						<div class="img-show1" style="height:70px;overflow-y:auto;overflow-x:hidden" id="showDefineImg">
							<ul>

							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="pop-bottom-l">
			<div class="pop-bottom-r">
				<div class="pop-bottom-m"></div>
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