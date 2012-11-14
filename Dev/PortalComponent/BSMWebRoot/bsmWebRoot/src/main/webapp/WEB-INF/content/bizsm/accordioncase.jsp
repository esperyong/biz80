<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!-- 
	author:qiaozheng
	description:业务服务定义首页
	uri:{domainContextPath}/bizsm/bizservice/ui/bizdefinemain
 -->
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>服务定义首页</title>

<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/portal.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js"></script>

<script src="${ctx}/js/component/cfncc.js" type="text/javascript"></script>

<script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.core.js"></script>
<script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.widget.js"></script>
<script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.mouse.js"></script>
<script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.draggable.js"></script>
<script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.accordion.js"></script>

<script type="text/javascript" src="${ctx}/js/component/accordionPanel/j-dynamic-accordion.js"></script>

<script type="text/javascript" src="${ctx}/js/component/tabPanel/j-dynamic-tab.js"></script>
<script type="text/javascript" src="${ctx}/js/component/pullBox/j-dynamic-pullbox.js"></script>

<script language="javascript">

	$(function() {
		
			$("#standardAccordionHull #standardAccordionHullTitle").css("width", "250px");
			$("#standardAccordionHull #standardAccordionHullBottom").css("width", "250px");

			//padding-top:5px;padding-left:20px;position:absolute;top:10px;left:0px;z-index:10;
			//$("#standardAccordionHull").css("padding-top", "5px");
			//$("#standardAccordionHull").css("padding-left", "5px");
			$("#standardAccordionHull").css("position", "absolute");
			$("#standardAccordionHull").css("top", "10px");
			$("#standardAccordionHull").css("left", "5px");
			$("#standardAccordionHull").css("z-index", "10");

			/*
			var settingObj = {};

			settingObj["panelName"] = "BizService";
			settingObj["panelWidth"] = "250px";
			settingObj["contentHeight"] = "430px";
			settingObj["panelTop"] = "5px";
			settingObj["panelLeft"] = "10px";
			*/


				$('#standardAccordionHull #jAccordionRoot').empty();
				
				var tp = new JDynamicAccordionPanel({panelName:"Accordion Tree",panelWidth:"200px",contentHeight:"430px",panelTopClassName:"tree-panel-top",panelIcoClassName:"tree-panel-ico",panelTitleClassName:"tree-panel-title",panelContentClassName:"tree-panel-content-top"});
				
				
				tp.addPageSlab({id:"test1",name:"test1",contentHeight:"200px",dataURI:""});
				tp.addPageSlab({id:"test2",name:"test2",contentHeight:"200px",dataURI:""});
				tp.addPageSlab({id:"test3",name:"test3",contentHeight:"200px",dataURI:""});
				
				tp.appendToContainer($('#standardAccordionHull #jAccordionRoot'));

				tp.expanseSlab("test1");

					


			


	});
	

</script>
</head>
<body>
	<div id='standardAccordionHull' class='dragapply'>
		<div id='standardAccordionHullTitle' class='left-panel-open'>
			<div class='left-panel-l'>
				<div class='left-panel-r ui-dialog-titlebar'>
					<div id='accordionDragHandle' class='left-panel-m'>
						<span class='left-panel-title'>Accordion Box</span>
					</div>
				</div>
			</div>
			<div class='left-panel-content'>
				<table width="100%">
					<tr>
						<td width="100%" style="text-align:right;">
							<a id="addBiz-h" href="#">添加</a>
						</td>
					</tr>
					<tr>
						<td>
							<hr/>
						</td>
					</tr>
				</table>
				<div id='jAccordionRoot'></div>
			</div>
			<div id='standardAccordionHullBottom' class='left-panel-close'>
				<div class='left-panel-l'>
					<div class='left-panel-r'>
						<div class='left-panel-m'><span class='left-panel-title'></span></div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div id="rightRoot" style="height:100%;width:100%"></div>
</body>
</html>