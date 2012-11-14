<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!--
	author:qiaozheng
	description:业务服务展示tree view.
	uri:{domainContextPath}/bizsm/bizservice/ui/bizdefine-resourcetreeview
 -->
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>业务服务Tree View</title>
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/portal.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/portal02.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css" />
<style type="text/css">
	<!--
	.nobrResName{width:186px;overflow:hidden;border:0px solid blue;text-overflow:ellipsis;cursor:hand}
	.selectedDataTr{background-color:blue;color:white}
	.selectedDataTd{color:black;font-weight:bold}
	-->
</style>

<script src="${ctx}/js/jquery-1.4.2.min.js" type="text/javascript"></script>
<script src="${ctx}/js/component/cfncc.js" type="text/javascript"></script>

<script type="text/javascript" src="${ctx}/js/bizservice/common.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery.blockUI.js "></script>

<script type="text/javascript">

	var resLevelSelVal_global = "";
	var searchVal_global = "";
	var qTypeSelValue_global = "";

	$(document).ready(function(){

		//显示加载状态条
		$.blockUI({message:$('#loading')});

		$('div[elID="slabPanelRes"]').css({width:"100%",height:"190px",overflowY:"auto",overflowX:"hidden"});

		/**
		* 查询按钮click
		* 根据资源分组id及查询条件查询资源实例数据
		*/
		$('#search_btn').click(function(){
			var resLevelSelVal = $('#resLevelSel').val();
			var searchVal = $.trim($('#search_txt').val()); //获取查询条件
			var qTypeSelValue = $('#qTypeSel>option:selected').attr("value");

			if(searchVal == "请输入IP地址" || searchVal == "请输入资源名称"){
				searchVal = "";
			}

			//设置当前查询条件 全局数据
			resLevelSelVal_global = resLevelSelVal;
			qTypeSelValue_global = qTypeSelValue;
			searchVal_global = searchVal;

			//显示加载状态条
			$.blockUI({message:$('#loading')});
			f_loadSubResCategory(resLevelSelVal, qTypeSelValue, searchVal);
		});

		$('#resLevelSel').change(function(){
			//显示加载状态条
			$.blockUI({message:$('#loading')});

			var qTypeSelValue = $('#qTypeSel>option:selected').attr("value");

			//设置当前查询条件 全局数据
			resLevelSelVal_global = this.value;
			qTypeSelValue_global = qTypeSelValue;
			searchVal_global = "";

			f_loadSubResCategory(this.value, qTypeSelValue, "");
		});

		$('#qTypeSel').change(function(){
			var qTypeSelValue = $(this).find(">option:selected").attr("value");
			if(qTypeSelValue == "ip"){
				$('#search_txt').val("请输入IP地址");
			}else{
				$('#search_txt').val("请输入资源名称");
			}
			$('#search_txt').select();

		});


		$('div.set-panel-content-white').click(function(event){
			var $oldSelectedDiv = $('table tr>td div.selectedDataTd').removeClass("selectedDataTd");

			//call flash (取消当前tab页中选中的内容)
			parent.unChoose();
		});

		
		$('#search_txt').click(function(){
			var $this = $(this);
			if($this.val() == "请输入IP地址" || $this.val() == "请输入资源名称"){
				$this.val("");
			}
		});


		//加载当前资源组数据
		f_loadResCategory();

		$('#search_txt').select();
		$('#search_txt').focus();

	});

/**
* 加载当前资源组
*
*/
function f_loadResCategory(){
	//{"from":"rescat","params":{"level":2,"name":""}}
	var query = '{"from":"rescat","params":{"level":2}}';
	$.get('${ctx}/bsmrescategory/.xml?q='+query,{},function(data){
		var dataStr = '<ResourceCategorys>'
						+'<ResourceCategory>'
							+'<categoryId>123</categoryId>'
							+'<uri>/bsmrescategory/123</uri>'
							+'<categoryName>网络设备</categoryName>'
							+'<parentId>234</parentId>'
							+'<leaf>false</leaf>'
						+'</ResourceCategory>'
						+'<ResourceCategory>'
							+'<categoryId>002</categoryId>'
							+'<uri>/bsmrescategory/123</uri>'
							+'<categoryName>路由器</categoryName>'
							+'<parentId>234</parentId>'
							+'<leaf>false</leaf>'
						+'</ResourceCategory>'
						+'<ResourceCategory>'
							+'<categoryId>003</categoryId>'
							+'<uri>/bsmrescategory/123</uri>'
							+'<categoryName>主机</categoryName>'
							+'<parentId>234</parentId>'
							+'<leaf>false</leaf>'
						+'</ResourceCategory>'
					+'</ResourceCategorys>';

		//var dataDom = func_asXMLDom(dataStr);
		var $resCategory = $(data).find('ResourceCategorys:first>ResourceCategory');

		var $resLevelSel = $('#resLevelSel');
		$resLevelSel.empty();//清楚select之前所有option

		$resCategory.each(function(i){
			var $thisRes = $(this);

			var categoryIdTemp = $thisRes.find('>categoryId').text();
			var uriTemp = $thisRes.find('>uri').text();
			var categoryNameTemp = $thisRes.find('>categoryName').text();

			var $optionTemp = $('<option></option>');
			$optionTemp.attr("value", categoryIdTemp);
			$optionTemp.text(categoryNameTemp);

			$resLevelSel.append($optionTemp);
		});

		//触发资源分类组select组件change事件加载子资源树形数据.
		$('#resLevelSel').change();

	});
}

/**
* 根据当前分类组id和当前查询的资源名称,加载当前子资源
* param String categoryID
* param String resName
*/
function f_loadSubResCategory(categoryID, qTypeSelValue, qValue){
	//bizsmweb/bsmrescategory/.xml?q=from:link

	var query = '{';
		query += '"from":"rescat",';
		query += '"params":{';
			query += '"fromrescatid":"'+categoryID+'",';
			if(qTypeSelValue == "ip"){
				query += '"ip":"'+qValue+'",';
			}else{
				query += '"name":"'+qValue+'"';
			}
		query += '}';
	query += '}';

	var getURITemp = '${ctx}/bsmrescategory/.xml?q='+query;
	$.get(getURITemp,{},function(data){
		var $slabTable = $('div[elID="slabPanelRes"]>table');
		$slabTable.empty();
		//var dataDom = func_asXMLDom(dataStr);

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

			if(resInsNumTemp == null
				|| resInsNumTemp == ""
				|| resInsNumTemp == "0"){
				return true;
			}

			var $slabItem = $('<tr subCategoryID="'+subCategoryIDTemp+'" class="fold-greybg">'
								 + '<td class="whiteborder">'
									 + '<span elID="userImg-open-hot" class="ico ico-plus"></span>'
									 + subCategoryNameTemp + '('+resInsNumTemp+')'
									// + subCategoryNameTemp
								 + '</td>'
							 + '</tr>');

			var $contentItem = $('<tr elID="contentPanel"><td class="whiteborder" style="padding:8px;"><div></div></td></tr>');
			$contentItem.hide();
			//var $contentPanel = $('<div></div>');
			//$contentPanel.hide();
			//$contentItem.append($contentPanel);

			$slabTable.append($slabItem);
			$slabTable.append($contentItem);
		});
		if($slabTable.find("td.whiteborder").size() == 0){
			$slabTable.empty();
			$slabTable.attr("style","border:0;");
			$slabTable.append("<tr><td><span class='nodata-l'><span class='nodata-r'><span class='nodata-m'><span class='icon'>当前无数据</span></span></span></span></td></tr>");
		}

		//如果业务服务处于运行状态,则禁用click事件
		if(parent.parent.parent.leftFrame.serviceRunStateGlobal != "true"){
			$('span[elID="userImg-open-hot"]').one("click", function(event){
				var $this = $(this);
				var $thisTR = $this.parent().parent();
				var subCategoryIDTemp = $thisTR.attr("subCategoryID");
				var $contentTD = $thisTR.next('tr[elID="contentPanel"]').find('>td>div');
				f_loadPageResource(subCategoryIDTemp, qTypeSelValue, qValue, 1, $contentTD);
				//f_loadResource(subCategoryIDTemp, qValue, $contentTD);
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
		}

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
			pageNo = lastPageNo;
		}else{
			pageNo = currPageNo*1+1;
		}
	}else if(forwardStep == "last"){
		pageNo = lastPageNo;
	}
	/*
	if(searchVal == "请输入IP地址" || searchVal == "请输入资源名称"){
		searchVal = "";
	}
	*/
	f_loadPageResource(categoryID, qTypeSelValue_global, searchVal_global, pageNo, $contentTD);

	//call flash (取消当前tab页中选中的内容)
	parent.unChoose();
}

function f_loadPageResource(subCategoryID, qTypeSelValue, qValue, pageNo, $contentPanel){
	var param_q = '{';
			param_q += '"from":"res",';
			param_q += '"params":{';
				param_q += '"rescatid":"'+subCategoryID+'",';
				if(qTypeSelValue == "ip"){
					param_q += '"ip":"'+qValue+'",';
				}else{
					param_q += '"name":"'+qValue+'",';
				}
				param_q += '"pagesize":5,';
				param_q += '"pagenum":'+pageNo;
			param_q += '}';
		param_q += '}';

	$.blockUI({message:$('#loading')});

	$.get('${ctx}/bsmrescategory/'+subCategoryID+'/bsmresource/?q='+param_q, {}, function(data){
		$contentPanel.empty();
		$contentPanel.append(data);
		$.unblockUI();
	});
}
function f_loadResource(subCategoryID, resName, $contentPanel){
	$.blockUI({message:$('#loading')});
	$.get('${ctx}/bsmrescategory/'+subCategoryID+'/bsmresource/?q=name:'+resName, {}, function(data){
		//var dataDom = func_asXMLDom(dataStr);
		//alert(data);
		$contentPanel.append(data);
		$.unblockUI();
	});
}
function f_selectResDataRow(resURI){
	/*
	var dataTblObj = document.all.item(this.tableName);
	if(dataTblObj.selectedTr != null){
		dataTblObj.selectedTr.style.backgroundColor = "";
		dataTblObj.selectedTr.style.color = "black";
		//dataTblObj.selectedTr.style.height = "10";
	}
	var rowObj = dataTblObj.rows[rowIndex];
	if(rowObj != null){
		dataTblObj.selectedTr = rowObj;
		rowObj.style.backgroundColor =  this.selectedRowColor;
		rowObj.style.color = this.selectedRowDataColor;
		//rowObj.style.height = "30";
		this.rowClick(rowIndex);
	}
	*/

	window.event.cancelBubble = true;
	//判断业务服务是否处于启用状态
	if(parent.currentServiceRunState == "false"){
		var $oldSelectedDiv = $('table tr>td div.selectedDataTd').removeClass("selectedDataTd");

		var $selectedDiv = $('table tr[resURI="'+resURI+'"]>td div').addClass("selectedDataTd");
		//$selectedTr.addClass("selectedDataTr");

		parent.choose("resource", resURI);
	}

}
</script>
</head>
<body>
	<div class="set-panel-content-white">
		<div class="sub-panel-open">
			<div class="sub-panel-content">
				<div style="display:block;margin:5px;">
					<select id="resLevelSel" style="width:130px"></select>
				</div>
				<div style="display:block;margin:5px;">
					<select id="qTypeSel" style="width:80px">
						<option value="ip">IP地址</option>
						<option value="name">资源名称</option>
					</select>
					<input type="text" size="15" id="search_txt" value="请输入IP地址" style="color:gray"/><span class="ico" title="查询" id="search_btn"></span>
				</div>
				<div elID="slabPanelRes" class="border-gray">
				  <table cellspacing="0" cellpadding="0" class="border-gray" style="width:100%">
				  </table>
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
