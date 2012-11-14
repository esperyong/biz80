<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html>
<head>
<%@ include file="/WEB-INF/common/meta.jsp"%>
<%@ include file="/WEB-INF/common/loading.jsp" %>
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="${ctx}/js/component/cfncc.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery.blockUI.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/js/jquery.form.js"></script>
<script type="text/javascript" src="${ctx}/js/component/popwindow/popwin.js" ></script>
<script type="text/javascript">
$(function(){
	var $cancelbutton = $("#cancel_button");
	var $confirmbutton = $("#confirm_button");
	var $closebutton = $("#win-close");
	$confirmbutton.click(function(){
		var value = $("input").val();
		var _information;
		if(value==""){
			_information = new information({text:"模型文件不允许为空。",top:10});
			_information.show();
		}else if(!RegExp("\.(" + ["zip"].join("|") + ")$", "i").test(value)){
			_information = new information({text:"上传模型文件格式不正确。",top:10});
			_information.show();
		}else{
			$.blockUI({message:$('#loading')});
			$("#uploadform").ajaxSubmit({
				url: "${ctx}/monitorsetting/model/fileUpload!uploadModel.action",
				method: "POST",
				dataType: "html",
				success:function(data){
					_information = new information({text:data
						,confirm_listener:function(){
							if(data=='<s:text name="%{@com.mocha.bsm.modelsetting.common.Constant@UPLOAD_MESSAGE_RIGHT}" />'){
								closeWin();
							}
							_information.hide();
						}
						,top:10});
					_information.show();
					$.unblockUI();
				},
				error:function(msg) {
					alert(msg.responseText);
			    }
			});
		}
	});
	$closebutton.click(function(){
		closeWin();
	});
	$cancelbutton.click(function(){
		closeWin();
	});
	function closeWin(){
		window.close();
		if(opener.reloadParentPage){
			opener.reloadParentPage();
		}
	}
});
</script>
</head>
<body>
<page:applyDecorator name="popwindow" title="模型部署">
	<page:param name="width">450px;</page:param>
	<page:param name="height">120px;</page:param>
	<page:param name="topBtn_index_1">1</page:param>
	<page:param name="topBtn_id_1">win-close</page:param>
	<page:param name="topBtn_css_1">win-ico win-close</page:param>
	<page:param name="topBtn_title_1">关闭</page:param>
	
	<page:param name="bottomBtn_index_1">1</page:param>
	<page:param name="bottomBtn_id_1">confirm_button</page:param>
	<page:param name="bottomBtn_text_1">确定</page:param>
	<page:param name="bottomBtn_index_2">2</page:param>
	<page:param name="bottomBtn_id_2">cancel_button</page:param>
	<page:param name="bottomBtn_text_2">取消</page:param>
	<page:param name="content">
	<div class="margin8">
	<form enctype="multipart/form-data" id="uploadform">
  		<span class="field-middle">模型文件</span><span>：</span><input type="file" name="uploadVO.uploadmodel" size="40"/><span class="red">*</span>
	</form>
	</div>
	<div class="margin8"><span class="red">*请上传模型压缩包，格式为zip，大小不能超过5MB。</span></div>
	</page:param>
</page:applyDecorator>
</body>
</html>