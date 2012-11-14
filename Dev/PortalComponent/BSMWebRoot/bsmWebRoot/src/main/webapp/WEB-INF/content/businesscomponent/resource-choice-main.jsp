<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- 
	@page : 资源选择主页面.jsp 
	@auther : weiyi@rd.mochasoft.com.cn
--%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<%@ include file="/WEB-INF/common/meta.jsp" %>
	<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css"/>
	<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css" />
	<link href="${ctx}/css/jquery-ui/treeview.css" rel="stylesheet" type="text/css" ></link>
	<script src="${ctx}/js/jquery-1.4.2.min.js"></script>
	<script src="${ctxJs}/jquery.blockUI.js"></script>
	<script src="${ctx}/js/component/cfncc.js"></script>
	<script src="${ctx}/js/component/treeView/tree.js"></script>
	<script src="${ctx}/js/component/gridPanel/grid.js"></script>
	<script src="${ctx}/js/component/gridPanel/indexgrid.js"></script>
	<script src="${ctx}/js/component/gridPanel/page.js"></script>
	<script src="${ctx}/js/notification/comm.js"></script>
	<script>
		var path = "${ctx}";
		var pageCount = Number("${displayVO.totalPage}");
		var singleSelection = "${queryVO.isSingleSelection}";
		var selectedIds = [];
		var idcode = "${queryVO.idcode}";
		var map = {};
		function addId(newId){
			if(newId && (!map[newId])){
				map[newId] = newId;
			}
		}
		function removeId(oldId){
			if(oldId && map[oldId]){
				map[oldId] = undefined;
				//eval("("+"delete map."+oldId+")");
			}
		}
		function singleSelectId(newId){
			map = {};
			map[newId] = newId;
		}
	</script>
	<title>资源选择</title>
</head>
<body>
<%@ include file="/WEB-INF/common/loading.jsp" %>
<page:applyDecorator name="popwindow"  title="资源选择">
    <page:param name="width">700px;</page:param>
    <page:param name="height">450px;</page:param>
    <page:param name="style">overflow:hidden;</page:param>
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
	<page:param name="bottomBtn_index_3">3</page:param>
	<page:param name="bottomBtn_id_3">app_button</page:param>
	<page:param name="bottomBtn_text_3">应用</page:param>
    <page:param name="content">
		<div style="width: 200px;height:420px;overflow-y:auto;" class="margin5 left grayborder">
		${categoryTree}
		</div>
		<div class="margin5 fold-blue grayborder bg" style="height:420px;overflow:hidden;">
		<div class=h2
		><form id="filterForm"><s:select name="queryVO.monitor" id="queryVO_monitor" list="#{'-1':'全部','monitor':'已监控','unmonitor':'未监控'}"></s:select
		><s:select name="queryVO.queryType" id="queryVO_queryType" list="#{'resIp':'IP地址','resName':'资源名称'}"></s:select><input name="queryVO.queryValue" id="queryVO_queryValue"  class="inputoff" style="height: 20px;" /
		><span title="点击进行搜索" class="ico" id="searchRootRes" ></span
		><input type="hidden" name="queryVO.currentPage" id="currentPage" value="${queryVO.currentPage}" /
		><input type="hidden" name="queryVO.orderBy" id="orderBy" value="resInstanceName" /
		><input type="hidden" name="queryVO.orderType" id="orderType" value="desc" /
		><input type="hidden" name="queryVO.category" id="query_categoryId" value="${queryVO.category}"/
		><input type="hidden" name="queryVO.idcode" id="idcode" value="${queryVO.idcode}"/
		><s:iterator value="queryVO.reserveCategorys" id="cats"  status="st">
		<input type="hidden" name="queryVO.reserveCategorys[${st.index}]" id="reserveCategorys_${st.index}" value="${cats}"/>
		</s:iterator>
		</form></div>
		<div id="resInsList">
		<s:action name="resChoice!resList" executeResult="true" ignoreContextParams="false" flush="false" namespace="/businesscomponent">
				<s:param name="queryVO.orderBy">resInstanceName</s:param>
      			<s:param name="queryVO.orderType">desc</s:param>
		</s:action>
		</div>
		</div>
	</page:param>
	
</page:applyDecorator>

</body>
<style type="text/css">
    .inputoff{color:#CCCCCC;}
</style>
<script type="text/javascript">
var tree = new Tree({
	id : "resCatTree",
	listeners : {
		nodeClick : function(node,event) {
			$("#query_categoryId").val(node.getId());
			$("#queryVO_queryValue").val('');
			loadList();
		}
	}
});

function loadList(loadConf){
	$.blockUI({message:$('#loading')});
	/*
	if($("#queryVO_queryValue").val()=="请输入条件进行搜索"){
		$("#queryVO_queryValue").val('');
	}
	*/
	$("#currentPage").val("1");
	var param = $("#filterForm").serialize();
	$("#resInsList").load(path + "/businesscomponent/resChoice!resList.action", param );
	$.unblockUI();
}
/*
var $searchInput = $("#queryVO_queryValue");
$searchInput.bind({
	focus:function(){
		$searchInput.removeClass();
		if($searchInput.val()=="请输入条件进行搜索"){
			$searchInput.val("");
		}
	},
	blur:function(){
		var text = $searchInput.val();
		if(text==""||text==null){
			$searchInput.val("请输入条件进行搜索");
			$searchInput.addClass("inputoff");
		}
	}
});
*/
$("#searchRootRes").click(function(){
	loadList();
});
$("#confirm_button").click(function(){
	opener && opener.choiceResourceCallback(createResult());
	closeWin();
});
$("#app_button").click(function(){
	opener && opener.choiceResourceCallback(createResult());
});
function createResult(){
	var result = {};
	result.idcode = idcode;
	result.resourceInstances = [];
	for(var i in map){
		if(map[i]){
			result.resourceInstances.push(map[i]);
		}
	}
	return result;
}
</script>
</html>