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
	var $deploybutton = $("#deploy_button");
	var $closebutton = $("#win-close");
	$("#deploy_button").click(function(){
		var value = $("input[name='uploadVO.uploadmodel']").val();
		var _information;
		if(value==""){
			_information = new information({text:"模型Logo不允许为空。",top:10});
			_information.show();
		}else if(!RegExp("\.(" + ["jpg","gif","png"].join("|") + ")$", "i").test(value)){
			_information = new information({text:"上传文件格式不正确。",top:10});
			_information.show();
		}else{
			$.blockUI({message:$('#loading')});
			$cancelbutton.hide();
			$deploybutton.hide();
			var resourceId = $("#resourceId").val();
			$("#uploadform").ajaxSubmit({
				url: "${ctx}/monitorsetting/model/fileUpload!uploadLogo.action?resourceId="+resourceId,
				method: "POST",
				dataType: "json",
				success:function(data){
					$cancelbutton.show().find("a").html("完成");
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
			opener.reloadParentPage("true");
		}
	}
});
</script>
</head>
<body>
<page:applyDecorator name="popwindow" title="更新模型Logo">
	<page:param name="width">450px;</page:param>
	<page:param name="height">120px;</page:param>
	<page:param name="topBtn_index_1">1</page:param>
	<page:param name="topBtn_id_1">win-close</page:param>
	<page:param name="topBtn_css_1">win-ico win-close</page:param>
	<page:param name="topBtn_title_1">关闭</page:param>
	
	<page:param name="bottomBtn_index_1">1</page:param>
	<page:param name="bottomBtn_id_1">deploy_button</page:param>
	<page:param name="bottomBtn_text_1">上传</page:param>
	<page:param name="bottomBtn_index_2">2</page:param>
	<page:param name="bottomBtn_id_2">cancel_button</page:param>
	<page:param name="bottomBtn_text_2">取消</page:param>
	<page:param name="content">
	<div class="margin8">
	<form enctype="multipart/form-data" id="uploadform">
		<input type="hidden" name="resourceId" id="resourceId" value="${requestScope.resourceId}" />
  		<span class="field-middle">模型Logo</span><span>：</span><input type="file" name="uploadVO.uploadmodel" size="40"/><span class="red">*</span>
	</form>
	</div>
	<div class="margin8"><span class="red">* 模型Logo用于监控列表和业务服务中显示，格式支持png、jpg、gif。</span></div>
	</page:param>
</page:applyDecorator>
</body>
</html>