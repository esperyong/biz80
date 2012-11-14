<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!-- 
	author:qiaozheng
	description: 图标选择
	uri:{domainContextPath}/bizsm/bizservice/ui/bizimg-select

 -->
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<%
	String menuType = request.getParameter("menuType");
	String nodeType = request.getParameter("nodeType");
	String iconFlag = request.getParameter("iconFlag");
	
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>Image Select</title>

<link href="${ctx}/css/portal.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<style type="text/css" media="screen"> 
	html, body	{ height:100%; }
	body { margin:0; padding:0; overflow:auto; text-align:center; 
		   background-color: #ffffff; }   
	#flashContent { display:none; }

	.bizimgnobr{display:inline-block;width:70px;overflow:hidden;border:0px solid red;text-overflow:ellipsis;cursor:hand}
</style>
<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="${ctx}/js/bizservice/ajaxcommon.js"></script>
<script type="text/javascript" src="${ctx}/js/bizservice/common.js"></script>

<script type="text/javascript" src="${ctx}/flash/bizsm/swfobject.js"></script>
<script type="text/javascript" src="${ctx}/js/bizservice/CallFlash.js"></script>
<script type="text/javascript" src="${ctx}/js/bizservice/CallJS.js"></script>
<script>
$(function(){
	f_loadImgList();
});

function f_loadImgList(){
	//var uriStr = '';
	/*
	if("<%=iconFlag%>" == "true"){
		uriStr = '${ctx}/folder/bizsm-customelement-background-icon/image/';
	}
	*/
	var nodeType_JS = "<%=nodeType%>";
	var uriStr = "";
	var startIdx = nodeType_JS.indexOf("folder/");
	var endIdx = nodeType_JS.lastIndexOf("/image");
	var imgFolder = nodeType_JS.substring(startIdx+7, endIdx);
	imgFolder = imgFolder+"-icon";
	uriStr = '${ctx}/folder/'+imgFolder+'/image/';
	//alert("uriStr:"+uriStr);


	$.get(uriStr,{},function(data){
		var dataDom = func_asXMLDom(data);
		
		var $data = $(dataDom);
		//alert($data.find('html').size());
		
		var $ul = $data.find('body>ul');
		var $imgHref = $ul.find('>li.image>a');

		var $imgUL = $('#img-box>ul');
		$imgUL.empty();
		$imgHref.each(function(cnt){
			var $href = $(this);
			var $img = $('<img src="${ctx}'+$href.attr("uri")+'"/>');
			var $span = $('<span class="bizimgnobr" title="'+$.trim($href.text())+'">'+$href.text()+'</span>');
			var $li = $('<li uri="'+$href.attr("uri")+'"></li>');
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
			
		});

		$('#execBtn').click(function(){
			var $selectedLi = $imgUL.find('>li[isClicked="true"]');
			var imgURI = $selectedLi.attr("uri");
			//window.returnValue = imgURI;//$imgUL.find('>li[isClicked="true"]>img').attr("src");
			//window.close();
			imgURI = "${ctx}"+imgURI.replace("-icon", "");
			window.opener.callFlashRefreshResource("<%=menuType%>", imgURI);
			window.close();
		});

		$('#cancelBtn,#closeIcon').bind("click", function(){
			window.close();
		});
	});
}


</script>
</head>
<body  class="pop-window">


		<div class="pop">
			<div class="pop-top-l">
				<div class="pop-top-r">
					<div class="pop-top-m">
						<a id="closeIcon" class="win-ico win-close"></a>
						<span class="pop-top-title">替换图片</span>
					</div>
				</div>
			</div>
			<div class="pop-m">
				<div class="pop-content">
					<ul class="fieldlist-n">
						<li>请选择合适的图片替换当前图片。</li>
						<li>
							<div style="display:inline-block;height:300px;padding:0.5px 0 0 0;border:1px solid #CCC;">
								<div style="height:20px;padding:5px 0 0 5px;background-Color:#CCC;">图标</div>
								<div class="set-panel-content-white">
									<div id="img-box" class ="img-show" style="OVERFLOW-Y: scroll; OVERFLOW-X: hidden; WIDTH: 100%; HEIGHT: 275px;">
										<ul>
										</ul>
									 </div> 
								</div>
							</div>
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
</body>
</html>