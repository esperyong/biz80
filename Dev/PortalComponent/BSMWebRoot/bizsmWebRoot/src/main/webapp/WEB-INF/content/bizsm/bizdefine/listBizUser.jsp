<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!--
 author:liuyong
 description:业务单位列表
 uri:{domainContextPath}/bizuser/
 -->
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>列出所有业务单位用于选择业务单位到topo</title>
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css" />
<style type="text/css">
	.bizimgnobr{display:inline-block;width:70px;overflow:hidden;border:0px solid red;text-overflow:ellipsis;cursor:hand}
</style>
<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="${ctx}/js/bizservice/ajaxcommon.js"></script>
<script type="text/javascript" src="${ctx}/js/bizservice/common.js"></script>
<script>
var confirmConfig = {width: 300,height: 80};
$(function(){

	$('div.img-show').css({width:"100%",height:"250px",overflowY:"auto",overflowX:"hidden"});

	var curr_runState = parent.parent.parent.leftFrame.serviceRunStateGlobal;
	if(curr_runState == "true"){
		$('span[elID="close_icon"]').addClass("r-ico r-ico-close-off");
		$('span[elID="add_icon"]').addClass("r-ico r-ico-add-off");
		$('span[elID="edit_icon"]').addClass("r-ico r-ico-edit-off");

		$('span[elID="close_icon"]').css("cursor", "default");
		$('span[elID="add_icon"]').css("cursor", "default");
		$('span[elID="edit_icon"]').css("cursor", "default");
	}else{
		$('span[elID="close_icon"]').addClass("r-ico r-ico-close");
		$('span[elID="add_icon"]').addClass("r-ico r-ico-add");
		$('span[elID="edit_icon"]').addClass("r-ico r-ico-edit");
	}

	$('.r-ico-add').click(function(){
		var returnValue = showModalPopup("${ctx}/bizsm/bizservice/ui/create-bizuser", 'Create User Biz', "254px", '470px');
		if(returnValue){
			if(returnValue == "success"){
				window.location.reload();
			}
		}
	});

	$('.r-ico-edit').click(function(){
		var $selectedObj = $('#img-box>ul>li.on');
		if($selectedObj.size() == 0){
			//alert("请选择要编辑的业务单位。");
			var _information  = top.information();
			_information.setContentText("请选择要编辑的业务单位。");
			_information.show();
			return;
		}
		var uriStr = $selectedObj.find(">nobr>span").attr("uri");
		var returnValue = showModalPopup("${ctx}/bizsm/bizservice/ui/modify-bizuser?dataURI="+uriStr, 'Modify User Biz', "254px", '470px');
		if(returnValue){
			if(returnValue == "success"){
				parent.parent.parent.leftFrame.f_updateLeftPanel();
				//call flash 同步业务单位编辑
				parent.editComplete("bizuser", uriStr);
				window.location.reload();
			}
		}
	});

	$('#img-box>ul>li').click(function(event){
		var $this = $(this);

		event.stopPropagation();

		var $oldClicked = $('#img-box>ul>li.on');
		$oldClicked.removeClass("on");
		$oldClicked.attr("isClicked", "false");

		$this.attr("isClicked", "true");
		$this.addClass("on");

		//call flash
		parent.choose("bizuser", $this.find(">nobr>span").attr("uri"));
	});

	$('#img-box>ul>li').hover(function(){
		var $this = $(this);
		//$('#img-box>ul>li.on').removeClass("on");
		$this.addClass("on");
	}, function(){
		var $this = $(this);
		if($this.attr("isClicked") != "true"){
			$this.removeClass("on");
		}
	});

	$('.r-ico-close').click(function(){
		var $Obj = $('#img-box>ul>li');
		if($Obj.size() == 0){
			//alert("请选择要删除的业务单位。");
			var _information  = top.information();
			_information.setContentText("没有要删除的记录。");
			_information.show();
			return;
		}

		var $selectedObj = $('#img-box>ul>li.on');
		if($selectedObj.size() == 0){
			//alert("请选择要删除的业务单位。");
			var _information  = top.information();
			_information.setContentText("请至少选择一项。");
			_information.show();
			return;
		}

		var _confirm = top.confirm_box(confirmConfig);
		_confirm.setContentText("此操作不可恢复，是否确认执行？"); //提示框
		_confirm.show();
		_confirm.setConfirm_listener(function() {
			_confirm.hide();
			var uriStr = $selectedObj.find(">nobr>span").attr("uri");
			$.ajax({
				  type: 'DELETE',
				  url: "${ctx}/"+uriStr,
				  contentType: "application/xml",
				  data: "",
				  processData: false,
				  beforeSend: function(request){
					  httpClient = request;
				  },
				  cache:false,
				  error: function (request) {
						var errorMessage = request.responseXML;
						var $errorObj = $(errorMessage).find('FieldErrors>FieldError');
						$errorObj.each(function(i){
							var fieldId = $(this).find('FieldId').text();
							var field = document.getElementById(fieldId);
							var errorInfo = $(this).find('ErrorInfo').text();
							//alert(errorInfo);
							var _information  = top.information();
							_information.setContentText(errorInfo);
							_information.show();
							field.focus();
						});
				  },
				  success: function(msg){
					 //call flash 同步业务单位编辑
					parent.deleteComplete("bizuser", uriStr);
					 window.location.reload();
				  }
			});
		});
		_confirm.setCancle_listener(function(){
			_confirm.hide();
		});

	});

	$('div.set-panel-content-white').click(function(event){
		var $oldClicked = $('#img-box>ul>li.on');
		$oldClicked.removeClass("on");
		$oldClicked.attr("isClicked", "false");

		//call flash (取消当前tab页中选中的内容)
		parent.unChoose();
	});

});

function f_onImgError(imgObj, newImgSrc){
	var $imgObj = $(imgObj);
	if($imgObj.attr("isExec") == null
		|| $imgObj.attr("isExec") != "true"){
		$imgObj.attr("isExec", "true");
		$imgObj.attr("src",'${ctx}/'+newImgSrc);
	}
}
/*
function showModalPopup(URL,name,height,width) {
	var properties = "resizable=no;center=yes;help=no;status=no;scroll=no;dialogHeight = " + height;
	properties = properties + ";dialogWidth=" + width;
	var leftprop, topprop, screenX, screenY, cursorX, cursorY, padAmt;
	screenY = document.body.offsetHeight;
	screenX = window.screen.availWidth;

	leftvar = (screenX - width) / 2;
	rightvar = (screenY - height) / 2;
	leftprop = leftvar;
	topprop = rightvar;

	properties = properties + ", dialogLeft = " + leftprop;
	properties = properties + ", dialogTop = " + topprop;

	return window.showModalDialog(URL,name,properties);
}
*/
</script>
</head>
<body>
	<div class="set-panel-content-white">
		<div class="sub-panel-open">
		 <div class="sub-panel-top">
			<span elID="close_icon" title="删除"></span>
			<span elID="add_icon" title="添加"></span>
			<span elID="edit_icon" title="编辑"></span>
		 </div>
		 <s:if test="model.users.size == 0">
			<div class="new-machineroom">
				<div class="add-button2" style="position:absolute; top:40px; left:60px;"><span style="top:35px;left:23px;width:150px">请点击&nbsp;<img src="${ctx}/images/add-button1.gif" width="10" height="10" border="0"/>&nbsp;按钮新建一个业务单位</span></div>
				<div class="clear"></div>
			</div>
		 </s:if>
		 <s:else>
			 <div id="img-box" class ="img-show">
				<ul>
				<s:iterator value="model.users" status="status">
					<li>
						<nobr>
							<img src='${ctx}<s:property value="iconImageUri"/>' onerror="f_onImgError(this, '<s:property value="defaultIconImageUri"/>')" style='display:none' onload="javascript:this.style.display='';"/>
							<span class="bizimgnobr" title='<s:property value="name"/>' uri='<s:property value="uri"/>' bizUserID='<s:property value="id"/>'><s:property value="name"/></span>
						</nobr>
					</li>
				</s:iterator>
				</ul>
			  </div>
		 </s:else>
	   </div>
	</div>
</body>
</html>