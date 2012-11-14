<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html>
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>查看资源</title>
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js" ></script>
<script type="text/javascript" src="${ctx}/js/component/cfncc.js" ></script>
<script type="text/javascript" src="${ctx}/js/component/popwindow/popwin.js"></script>
<script type="text/javascript" src="${ctx}/js/component/comm/winopen.js"></script> 
<script type="text/javascript" src="${ctx}/js/component/accordionPanel/accordionPanel.js"></script>
<script type="text/javascript" src="${ctx}/js/component/gridPanel/grid.js"></script>
<script type="text/javascript" src="${ctx}/js/component/gridPanel/indexgrid.js"></script>
<script type="text/javascript" src="${ctx}/js/component/combobox/simplebox.js"></script>
<script type="text/javascript" src="${ctx}/js/discovery/instance-list.js"></script>
<script type="text/javascript">
var $hashId = "${hashId}";
var $categoryGroup = "${categoryGroup}";
<s:if test="instanceJson != null && instanceJson != '' && instanceJson != '[]'">
$(function(){
    var gp = new GridPanel({id:"instanceListGrid",
         width:700,
         columnWidth:{allCheck:50,accountId:200,remarks:250,instanceCount:230},
         plugins:[SortPluginIndex,TitleContextMenu],
         sortColumns:[{index:"name",defSorttype:"up"},{index:"categoryGroupName"}],
         sortLisntenr:function($sort) {
                // alert($sort.colId);
                //alert($sort.sorttype);
                var colId = $sort.colId;
                var sortType = $sort.sorttype;
                //gp.loadGridData('${instanceJson}');
           		$.post("instance-list-sortinstance.action?hashId=${hashId}&colId=" + colId + "&sortType=" + sortType, function(data){
           			gp.loadGridData(data.instanceJson);
					SimpleBox.renderAll();
             	});
         },
		 contextMenu:function(td){
		    // alert("=="+td.colId);
		 }
	},{gridpanel_DomStruFn:"index_gridpanel_DomStruFn",gridpanel_DomCtrlFn:"index_gridpanel_DomCtrlFn",gridpanel_ComponetFn:"index_gridpanel_ComponetFn"}
	);
    
    
    gp.rend([{index:"allCheck",fn:function(td){
    	 var instanceId = td.value.id; 
    		//alert(instanceId);
         $chk = $('<input name="instanceIds" type="checkbox" value="' + instanceId + '" onclick="cancelChecked();" />');
         return $chk;
      }
	}]);
	SimpleBox.renderAll();
});
</s:if>
</script>
</head>
<body class="pop-window">
<form id="form1" name="form1" method="post">
<page:applyDecorator name="popwindow"  title="查看资源">
  
  <page:param name="width">600px</page:param>
  <page:param name="topBtn_index_1">1</page:param>
  <page:param name="topBtn_id_1">closeId</page:param>
  <page:param name="topBtn_css_1">win-ico win-close</page:param>
  
  <page:param name="content">
  		<div class="margin5" style="width:99%;">
  			${categoryGroupSelect }
			<s:select id="criteriaType" name="criteriaType" list="#{'2':'IP地址', '1':'资源名称'}" value="criteriaType"/>
			<s:textfield id="criteria" name="criteria" key="$criteria"/>
			<span id="sp_search" class="ico ico-select"></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<span class="black-btn-l"><span class="btn-r"><span class="btn-m"><a id="sp_delete">删除</a></span></span></span>
		</div>
		<div style="width:99%;">
			<page:applyDecorator name="indexgrid">  
		       <page:param name="id">instanceListGrid</page:param>
		       <page:param name="width">200px</page:param>
		       <page:param name="height">500px</page:param>
		       <page:param name="tableCls">grid-black</page:param>
		       <page:param name="linenum">0</page:param>
		       <page:param name="gridhead">[{colId:"allCheck", text:"<input id='checkAll' type='checkbox'/>"},{colId:"name", text:"资源名称"},{colId:"ip",text:"IP地址"},{colId:"categoryGroupName",text:"资源类型"},{colId:"id",text:"head4",hidden:true}]</page:param>
		       <page:param name="gridcontent">${instanceJson}</page:param>
		    </page:applyDecorator>
		</div>
  </page:param>
</page:applyDecorator>
</form>
</body>
</html>
