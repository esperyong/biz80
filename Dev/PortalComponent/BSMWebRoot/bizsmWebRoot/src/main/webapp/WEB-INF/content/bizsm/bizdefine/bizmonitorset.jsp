<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@taglib prefix="decorator"
 uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@taglib prefix="page" uri="http://www.opensymphony.com/sitemesh/page"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!-- 
	author:qiaozheng
	description:监控设置
	uri:{domainContextPath}/bizsm/bizservice/ui/bizdefine-monitorset

 -->
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<%
	String serviceId = request.getParameter("serviceId");
%>
<title>监控设置</title>
<link rel="Shortcut icon" type="image/x-icon" href="${ctx}/imac.ico">
<link rel="icon" href="${ctx}/imac.ico" type="image/x-icon" />

<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/portal.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/portal02.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/button-module.css" rel="stylesheet" type="text/css">

<link href="${ctx}/css/jquery-ui/jquery.ui.toolbar.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/jquery-ui/jquery.ui.toolmenu.css" rel="stylesheet" type="text/css" />

<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css" />


<style type="text/css" media="screen"> 
	html, body	{ height:100%; }
	body { margin:0; padding:0; overflow:auto; text-align:center; 
		   background-color: #ffffff; }   
	#flashContent { display:none; }
</style>

<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js"></script>

<script src="${ctx}/js/component/cfncc.js" type="text/javascript"></script>

<script type="text/javascript" src="${ctx}/js/bizservice/common.js"></script>

<script language="javascript">

	$(function(){
		//OVERFLOW-Y: scroll; OVERFLOW-X: hidden; WIDTH: 100%; HEIGHT: 394px;
		
		$('#monitorSet').css({height:"100%"});
		$('#monitorSet div[elID="monitorSetContent"]').css({height:"90%",overflowY:"auto",overflowX:"hidden"});

		$('#monitorSet div[elID="monitorTab"]>ul>li').css("cursor", "hand");

		$('#monitorSet div[elID="monitorTab"]>ul>li').click(function(){
			var $this = $(this);
			var tabID = $this.attr("id");
			
			var $oldClicked = $('#monitorSet div[elID="monitorTab"]>ul>li.nonce');
			$oldClicked.removeClass("nonce");
			$oldClicked.attr("isClicked", "false");

			$this.attr("isClicked", "true");
			$this.addClass("nonce");
			
			var contentURI = "";
			if(tabID == "normalDefine_li"){
				contentURI = "bizsm/bizservice/ui/bizservicemanager!getGeneralInfo?serviceId=<%=serviceId%>";
				var $iframe = $('#monitorSet div[elID="monitorSetContent"]>#monitorContentIframe');
				if($iframe.size() == 0){
					$iframe = $("<iframe id='monitorContentIframe' frameborder='NO' border='0' scrolling='YES' noresize framespacing='0' style='width:100%; height:100%'/>");
					var $content = $('#monitorSet div[elID="monitorSetContent"]');
					$content.empty();
					$content.append($iframe);
				}
				$iframe.attr("src", "${ctx}/"+contentURI);
			}else if(tabID == "eventDefine_li"){
				contentURI = "bizsm/bizservice/ui/event-define?serviceId=<%=serviceId%>";
				$('#monitorSet div[elID="monitorSetContent"]').load("${ctx}/"+contentURI);
			}else if(tabID == "offlineTimeDefine_li"){
				contentURI = "bizsm/bizservice/ui/offlinetime-define?serviceId=<%=serviceId%>";
				$('#monitorSet div[elID="monitorSetContent"]').load("${ctx}/"+contentURI);
			}else if(tabID == "warnAlertDefine_li"){
				contentURI = "bizsm/bizservice/ui/warnalert-define?serviceId=<%=serviceId%>";
				$('#monitorSet div[elID="monitorSetContent"]').load("${ctx}/"+contentURI);
			}
			
		});
		
		$('#normalDefine_li').click();
	});
</script>
</head>
<body>
	<div id="monitorSet" class="tab" style="position:absolute;top:10px;left:10px;width:99%;">
		 <div  class="tab-grounp" style="width:null;">
			 <div class="tab-mid" style="width:null">
					<div elID="monitorTab" class="tab-foot">
						<ul style="position:relative;">
							<li id="normalDefine_li" class="nonce">
								<div class="tab-l">
									<div class="tab-r">
										<div class="tab-m">
											<a>常规信息</a>
										</div>
									</div>
								</div>
							</li>
							<li  id="eventDefine_li">
								<div class="tab-l">
									<div class="tab-r">
										<div class="tab-m">
											<a>事件定义</a>
										</div>
									</div>
								</div>
							</li>
							<li  id="offlineTimeDefine_li">
								<div class="tab-l">
									<div class="tab-r">
										<div class="tab-m">
											<a>计划不在线时间</a>
										</div>
									</div>
								</div>
							</li>
							<li  id="warnAlertDefine_li">
								<div class="tab-l">
									<div class="tab-r">
										<div class="tab-m">
											<a>告警定义</a>
										</div>
									</div>
								</div>
							</li>
						</ul>
					</div>
			</div>
		</div>
		<div elID="monitorSetContent" class="tab-content" style="width:99%"></div>
	</div>
</body>
</html>