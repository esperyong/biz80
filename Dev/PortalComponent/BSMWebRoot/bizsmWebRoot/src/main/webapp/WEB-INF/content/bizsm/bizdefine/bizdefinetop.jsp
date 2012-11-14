<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@taglib prefix="decorator"
 uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@taglib prefix="page" uri="http://www.opensymphony.com/sitemesh/page"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!--
	author:qiaozheng
	description:业务服务定义
	uri:{domainContextPath}/bizsm/bizservice/ui/bizdefine-top
 -->
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>业务服务定义</title>
<link rel="Shortcut icon" type="image/x-icon" href="${ctx}/imac.ico">
<link rel="icon" href="${ctx}/imac.ico" type="image/x-icon" />

<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/portal.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/portal02.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />

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
<script src="${ctx}/js/component/popwin.js" type="text/javascript"></script>

<script type="text/javascript" src="${ctx}/js/bizservice/common.js"></script>
<script src="${ctx}/js/component/date/WdatePicker.js" type="text/javascript"></script>


<script language="javascript">
	var confirmConfig = {width: 300,height: 80};

	var selectedServiceId = ""; //当前展开的业务服务id
	var isClickSlab = false; //是否点击的是左面的服务导航条

	//var callSaveTopoFlagFunc = null;

	//初始化日历组件参数
	$wdate = true;

	$(function(){

		//$('#content_default').hide();
		$('#content_tbl').hide();

		//绑定按钮组click事件
		$('#topBtnPanel>ul>li').click(function(){
			var $this = $(this);

			$('#topBtnPanel>ul>li.focus').removeClass("focus");
			$(this).addClass("focus");

			var btnID = $this.attr("id");
			var srcURI = "";

			var confirmTopoFlag = false;
			//call flash 判断是否需要保存当前拓扑
			if(contentArea_ifr.callSaveTopoFlag != null && contentArea_ifr.callSaveTopoFlag != ""){
				confirmTopoFlag = contentArea_ifr.callSaveTopoFlag();
			}
			//判断左边是否已经提示过保存当前拓扑，如果没提示过则需要提示保存
			if(parent.leftFrame.requiredTipSaveGlobal == true){
				if(confirmTopoFlag){
					var _confirm = top.confirm_box(confirmConfig);
					_confirm.setContentText("是否保存当前拓扑?"); //提示框
					_confirm.show();
					_confirm.setConfirm_listener(function() {
						_confirm.hide();
						//call flash 保存拓扑
						contentArea_ifr.saveTopo("${ctx}");
						//如果点击的是左面的服务导航条,则执行切换拓扑
						if(isClickSlab){
							//srcURI = "${ctx}/bizsm/bizservice/ui/biz-define?serviceId="+selectedServiceId;
							//$('#contentArea_ifr').attr("src", srcURI);
						}
						changeJSPForBtn(btnID);
					});
					_confirm.setCancle_listener(function(){
						_confirm.hide();
						//srcURI = "${ctx}/bizsm/bizservice/ui/biz-define?serviceId="+selectedServiceId;
						//$('#contentArea_ifr').attr("src", srcURI);
						changeJSPForBtn(btnID);
					});
					_confirm.setClose_listener(function(){
						_confirm.hide();

						changeJSPForBtn(btnID);
					});
				}else{
					changeJSPForBtn(btnID);
				}
			}else{
				//设置需要提示保存
				parent.leftFrame.requiredTipSaveGlobal = true;

				changeJSPForBtn(btnID);
			}
			//设置是否点击的是左面的服务导航条
			isClickSlab = false;

			function changeJSPForBtn(btnID){
				if(btnID == "bizdefine_btn"){
					parent.leftFrame.f_loadingServiceList();
					$('#contentArea_ifr').unbind("load");
					srcURI = "${ctx}/bizsm/bizservice/ui/biz-define?serviceId="+selectedServiceId;
					$('#contentArea_ifr').attr("src", srcURI);

				}else if(btnID == "statedefine_btn"){
					//iframe内容load完成事件监听器,如果服务处于运行状态,则屏蔽iframe内容的输入状态.
					$('#contentArea_ifr').bind("load", function(){
						if(parent.leftFrame.serviceRunStateGlobal == "true"){
							$($('#contentArea_ifr').get(0).contentWindow.document.body).find("*").each(function(){
									this.disabled = true;
							});
						}
					});

					srcURI = "${ctx}/bizsm/bizservice/ui/bizstatusmanager!getStatusDefinePage?serviceId="+selectedServiceId;
					$('#contentArea_ifr').attr("src", srcURI);
				}else if(btnID == "monitorset_btn"){
					$('#contentArea_ifr').unbind("load");
					srcURI = "${ctx}/bizsm/bizservice/ui/bizdefine-monitorset?serviceId="+selectedServiceId;
					$('#contentArea_ifr').attr("src", srcURI);
				}

				$('#contentArea_ifr').attr("btnID", btnID);
			}
		});

	});

	/**
	* 加载服务定义项
	* param String defineSubName(服务定义项)
	* param String serviceId(当前点击的服务id)
	*/
	function f_bizServiceDefine(defineSubItem, serviceId){
		selectedServiceId = serviceId;
		isClickSlab = true;
		if(defineSubItem == "bizdefine"){
			$('#bizdefine_btn').click();
		}else if(defineSubItem == "statedefine"){
			$('#statedefine_btn').click();
		}else if(defineSubItem == "monitorset"){
			$('#monitorset_btn').click();
		}
	}
	/**
	* 是否显示默认文本(如果未定义任务业务服务时,需要显示默认提示信息)
	* param boolean disabled
	*
	*/
	function f_disabledDefaultContent(disabled){
		$('#contentArea_ifr').attr("src", "/netfocus/test.html");
		if(disabled){
			$('#content_tbl').hide();
			$('#content_default').show();
		}else{
			$('#content_default').hide();
			$('#content_tbl').show();
		}
	}

	function f_loadContentAreaFrame(){
		/*
		var btnID = $('#contentArea_ifr').attr("btnID");
		if(btnID == "bizdefine_btn"){
			callSaveTopoFlagFunc = contentArea_ifr.callSaveTopoFlag;
		}
		*/
	}
</script>
</head>
<body style="overflow-x:hidden;overflow-y:hidden">
	<table id="content_tbl" width="100%" height="100%" cellpadding="0" cellspacing="0" style="min-height:100%;height:100%;">
		<tr>
			<td>
				<!--按钮群 -->
				<div id="topBtnPanel" class="business-tab" style="width:100%">
					<ul class="business-tab">
						<li id="bizdefine_btn" class="focus"><span></span><a href="#">服务定义</a></li>
						<li id="statedefine_btn"><span></span><a href="#">状态定义</a></li>
						<li id="monitorset_btn"><span></span><a href="#">监控设置</a></li>
					</ul>
				  <div class="clear"></div>
				</div>
			</td>
		</tr>
		<tr height="100%" style="min-height:100%;height:100%;">
			<td width="100%" height="90%" style="min-height:90%;height:90%;">
				<iframe id="contentArea_ifr" frameborder="NO" border="0" scrolling="NO" noresize framespacing="0" style="width:100%; height:100%;background-image:none;background-color:transparent;" onload="javascript:f_loadContentAreaFrame();" allowtransparency="true"></iframe>
			</td>
		</tr>
	</table>
	<div id="content_default" style="width:100%;height;100%;display:none;">
			<span class="business-txt for-inline" style="position:absolute;left:35%;top:50%">未创建业务服务</span>
	</div>
</body>
</html>