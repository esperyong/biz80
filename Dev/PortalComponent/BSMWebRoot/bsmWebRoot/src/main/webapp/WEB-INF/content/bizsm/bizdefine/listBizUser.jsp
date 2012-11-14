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
<link href="${ctx}/css/portal.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="${ctx}/js/bizservice/ajaxcommon.js"></script>
<script>
$(function(){
	
	$('.r-ico-add').click(function(){
		var returnValue = showModalPopup("${ctx}/bizsm/bizservice/ui/create-bizuser", 'Create User Biz', "260px", '423px');
		if(returnValue){
			if(returnValue == "success"){
				window.location.reload();
			}
		}
	});
	
	$('.r-ico-edit').click(function(){
		var $selectedObj = $('#img-box>ul>li.on');
		if($selectedObj.size() == 0){
			alert("请选择要编辑的业务单位。");
			return;
		}
		var uriStr = $selectedObj.find(">span").attr("uri");
		var returnValue = showModalPopup("${ctx}/bizsm/bizservice/ui/modify-bizuser?dataURI="+uriStr, 'Modify User Biz', "260px", '423px');
		if(returnValue){
			if(returnValue == "success"){
				parent.f_updateLeftPanel();
				parent.editComplete("bizuser", uriStr);
				window.location.reload();
			}
		}
	});

	$('#img-box>ul>li').click(function(){
		var $this = $(this);
		
		var $oldClicked = $('#img-box>ul>li.on');
		$oldClicked.removeClass("on");
		$oldClicked.attr("isClicked", "false");

		$this.attr("isClicked", "true");
		$this.addClass("on");
		
		//call flash
		parent.choose("bizuser", $this.find(">span").attr("uri"));
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
		var $selectedObj = $('#img-box>ul>li.on');
		if($selectedObj.size() == 0){
			alert("请选择要删除的业务单位。");
			return;
		}
		if(confirm("确认要删除业务单位？")){
			var uriStr = $selectedObj.find(">span").attr("uri");
			uriStr = "${ctx}/"+uriStr;
			$.ajax({
				  type: 'DELETE',
				  url: uriStr,
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
							alert(errorInfo);
							field.focus();
						});
				  },
				  success: function(msg){
					 window.location.reload();
				  }			  		  
			});	
		}
		
	});
	
});

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
</script>
</head>
<body>
	<div class="set-panel-content-white">
		<div class="sub-panel-open">
		 <div class="sub-panel-top">
			<span class="r-ico r-ico-close"></span>
			<span class="r-ico r-ico-add"></span>
			<span class="r-ico r-ico-edit"></span>
		 </div>
		 <div id="img-box" class ="img-show">
			<ul>
			<s:iterator value="model.users" status="status">
				<li>
					<img src="${ctx}/images/bizservice-default/default-bizuser-icon.png"/>
					<span style="cursor:hand" uri='<s:property value="uri"/>' bizUserID='<s:property value="id"/>'>
						<s:property value="name"/>
					</span>
				</li>
			</s:iterator>
			</ul>
		 </div>    
	   </div> 
	</div>
</body>
</html>