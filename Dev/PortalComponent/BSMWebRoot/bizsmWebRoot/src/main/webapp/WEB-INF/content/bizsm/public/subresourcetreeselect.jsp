<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!--
	author:qiaozheng
	description:业务服务tree view选择.
	uri:{domainContextPath}/bizsm/bizservice/ui/bizsubresourcetreeview-select
 -->
<%@ include file="/WEB-INF/common/taglibs.jsp" %>

<%

	String menuType = request.getParameter("menuType");

	//是否来自flash弹出资源树的调用
	String fromFlash = request.getParameter("fromFlash");
	if(fromFlash == null || fromFlash.equals("null")){
		fromFlash = "";
	}

	String resourceId = request.getParameter("resourceId");
	String resourceName = request.getParameter("resourceName");
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>业务服务Tree View</title>
<link rel="stylesheet" href="${ctx}/css/jquery-ui/jquery.ui.treeview.css" />
<link href="${ctx}/css/portal.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<style type="text/css">
	.nobrdevname {
		width: 130px;
        overflow: hidden;
        border: 0px solid blue;
        text-overflow:ellipsis;
    }
	.nobrResName{width:410px;overflow:hidden;border:0px solid blue;text-overflow:ellipsis;cursor:hand}
	.selectedDataTr{background-color:blue;color:white}
	.selectedDataTd{color:black;font-weight:bold}
</style>
<script src="${ctx}/js/jquery-1.4.2.min.js" type="text/javascript"></script>
<script src="${ctx}/js/component/cfncc.js" type="text/javascript"></script>

<script src="${ctx}/js/component/treeView/j-dynamic-treeview-1.1.js" type="text/javascript"></script>

<script type="text/javascript" src="${ctx}/js/bizservice/common.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery.blockUI.js "></script>

<script type="text/javascript">

	var resourceId_global = "", resourceName_global = "";

	var searchVal_global = "";

	$(document).ready(function(){

		//显示加载状态条
		$.blockUI({message:$('#loading')});

		//$('div[elID="slabPanelRes"]').css({width:"100%",height:"210px",overflowY:"auto",overflowX:"hidden"});

		/**
		* 查询按钮click
		* 根据资源分组id及查询条件查询资源实例数据
		*/
		$('#search_btn').click(function(){
			var searchVal = $.trim($('#search_txt').val()); //获取查询条件

			if(searchVal == "请输入组件名称"){
				searchVal = "";
			}

			//设置当前查询条件 全局数据
			searchVal_global = searchVal;

			//显示加载状态条
			$.blockUI({message:$('#loading')});
			f_loadSubResModel("<%=resourceId%>", searchVal);
		});



		$('#execBtn').click(function(){
			//此操作处理的是通过flash弹出资源树,回调操作
			window.opener.callFlashRefreshResource("<%=menuType%>", resourceId_global, resourceName_global);
			window.close();
		});

		$('#cancelBtn,#closeIcon').bind("click", function(){
			window.close();
		});


		//加载当前资源组数据
		f_loadSubResModel("<%=resourceId%>", "");

		$('#search_txt').select();
		$('#search_txt').focus();

	});

/**
* 加载当前资源组
*
*/
function f_loadSubResModel(resourceId, qValue){
//http://192.168.40.100:8888/bizsmweb/bsmresource/CDB7350C8667A94BA92778D72B6224F3/bsmrescomcategory/.xml
	$.get('${ctx}/bsmresource/'+resourceId+'/bsmrescomcategory/.xml',{},function(data){
		var dataStr = ''
			+'<ResourceCategorys>'
				+'<ResourceCategory>'
					+'<categoryId>123</categoryId>'
					+'<uri>/bsmrescategory/123</uri>'
					+'<categoryName>网络设备</categoryName>'
					+'<parentId>234</parentId>'
					+'<leaf>true</leaf>'
					+'<resInsNum>16</resInsNum>'
				+'</ResourceCategory>'
				+'<ResourceCategory>'
					+'<categoryId>002</categoryId>'
					+'<uri>/bsmrescategory/123</uri>'
					+'<categoryName>路由器</categoryName>'
					+'<parentId>234</parentId>'
					+'<leaf>true</leaf>'
					+'<resInsNum>16</resInsNum>'
				+'</ResourceCategory>'
				+'<ResourceCategory>'
					+'<categoryId>003</categoryId>'
					+'<uri>/bsmrescategory/123</uri>'
					+'<categoryName>主机</categoryName>'
					+'<parentId>234</parentId>'
					+'<leaf>true</leaf>'
					+'<resInsNum>18</resInsNum>'
				+'</ResourceCategory>'
			+'</ResourceCategorys>'


		var $slabTable = $('div[elID="slabPanelRes"]>table');
		$slabTable.empty();

		var $resCategory = $(data).find('ResourceCategorys>ResourceCategory');
		$resCategory.each(function(cnt){
			var $thisNode = $(this);

			var isLeafTemp = $thisNode.find('>leaf').text();
			if(isLeafTemp == "false"){
				return true;
			}

			var subCategoryIDTemp = $thisNode.find('>categoryId').text();
			var subCategoryNameTemp  = $thisNode.find('>categoryName').text();
			var resInsNumTemp = $thisNode.find('>resInsNum').text();

			var $slabItem = $('<tr subCategoryID="'+subCategoryIDTemp+'" class="fold-greybg">'
								 + '<td class="whiteborder">'
									 + '<span elID="userImg-open-hot" class="ico ico-plus"></span>'
									// + subCategoryNameTemp + '('+resInsNumTemp+')'
									 + subCategoryNameTemp
								 + '</td>'
							 + '</tr>');

			var $contentItem = $('<tr elID="contentPanel"><td class="whiteborder" style="padding:8px;"><div></div></td></tr>');
			$contentItem.hide();

			$slabTable.append($slabItem);
			$slabTable.append($contentItem);
		});

		$('span[elID="userImg-open-hot"]').one("click", function(event){
			var $this = $(this);
			var $thisTR = $this.parent().parent();
			var subCategoryIDTemp = $thisTR.attr("subCategoryID");
			var $contentTD = $thisTR.next('tr[elID="contentPanel"]').find('>td>div');
			f_loadPageResource(resourceId, subCategoryIDTemp, qValue, 1, $contentTD);
		});

		$('span[elID="userImg-open-hot"]').toggle(function(){
			var $this = $(this);
			var $thisTR = $this.parent().parent();
			var $contentTR = $thisTR.next('tr[elID="contentPanel"]');
			$contentTR.slideDown(0, function(){
				$this.removeClass("ico-plus").addClass("ico-minus");
			});
		}, function(){
			var $this = $(this);
			var $thisTR = $this.parent().parent();
			var $contentTR = $thisTR.next('tr[elID="contentPanel"]');
			$contentTR.slideUp(0, function(){
				$this.removeClass("ico-minus").addClass("ico-plus");
			});
		});


		$('#search_txt').select();
		$('#search_txt').focus();

		$.unblockUI();// 屏蔽loading

	});
}


function f_pageForward(categoryID, currPageNo, lastPageNo, forwardStep){

	categoryID = categoryID.substring(1, categoryID.length-1);

	var $contentTD = $('tr[subCategoryID="'+categoryID+'"]').next('tr[elID="contentPanel"]').find('>td>div');

	var pageNo = 1;
	if(forwardStep == "first"){
		pageNo = 1;
	}else if(forwardStep == "pre"){
		if(currPageNo*1 <= 1){
			pageNo = 1;
		}else{
			pageNo = currPageNo*1-1;
		}
	}else if(forwardStep == "next"){
		if(currPageNo*1 >= lastPageNo*1){
			pageNo = lastPageNo*1;
		}else{
			pageNo = currPageNo*1+1;
		}
	}else if(forwardStep == "last"){
		pageNo = lastPageNo;
	}
	f_loadPageResource("<%=resourceId%>", categoryID, searchVal_global, pageNo, $contentTD);

	//call flash (取消当前tab页中选中的内容)
	//parent.unChoose();
}

function f_loadPageResource(resourceId, subCategoryID, qValue, pageNo, $contentPanel){
	var param_q = '{';
			param_q += '"from":"rescom",';
			param_q += '"params":{';
				param_q += '"rescomcatid":"'+subCategoryID+'",';
				param_q += '"resid":"'+resourceId+'",';
				param_q += '"name":"'+qValue+'",';
				param_q += '"pagesize":5,';
				param_q += '"pagenum":'+pageNo;
			param_q += '}';
		param_q += '}';

	$.blockUI({message:$('#loading')});

	$.get('${ctx}/bsmrescom/?q='+param_q, {}, function(data){
		$contentPanel.empty();
		$contentPanel.append(data);
		$.unblockUI();
	});
}
function f_selectResDataRow(resURI){
	window.event.cancelBubble = true;

	var $oldSelectedDiv = $('table tr>td div.selectedDataTd').removeClass("selectedDataTd");

	var $selectedTr = $('table tr[resURI="'+resURI+'"]');
	$selectedTr.find('>td div').addClass("selectedDataTd");

	//此操作处理的是通过flash弹出资源树,回调操作
	resourceId_global = $selectedTr.attr("resID");
	resourceName_global = $selectedTr.find('>td div').text();

	//parent.choose("resource", resURI);

}
</script>
</head>
<body  class="pop-window">
	<div class="pop">
		<div class="pop-top-l">
			<div class="pop-top-r">
				<div class="pop-top-m">
					<a id="closeIcon" class="win-ico win-close"></a>
					<span class="pop-top-title">选择组件</span>
				</div>
			</div>
		</div>
		<div class="pop-m">
			<div class="pop-content">
				<div style="margin:5px;">
					<div style="display:inline;margin:5px;">
					<nobr>
						<span style="display:inline;">资源名称：</span>
						<span  style="cursor:hand;display:inline-block;" id="resName-span" class="nobrdevname" title="<%=resourceName%>"><%=resourceName%></span>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span>搜索：</span><input type="text" id="search_txt" value="请输入组件名称"/>
						<span  class="ico" title="查询" id="search_btn"></span>
					</nobr>
					</div>
					<div elID="slabPanelRes" class="border-gray">
					  <table cellspacing="0" cellpadding="0" class="border-gray" style="width:100%"></table>
					</div>
				</div>
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
