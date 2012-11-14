<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html>
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<%@ include file="/WEB-INF/common/userinfo.jsp" %>
<title>预置账户</title>
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js" ></script>
<script type="text/javascript" src="${ctx}/js/component/cfncc.js" ></script>
<script type="text/javascript" src="${ctx}/js/component/popwindow/popwin.js"></script>
<script type="text/javascript" src="${ctx}/js/component/comm/winopen.js"></script> 
<script type="text/javascript" src="${ctx}/js/component/gridPanel/grid.js"></script>
<script type="text/javascript" src="${ctx}/js/component/gridPanel/indexgrid.js"></script>
<script type="text/javascript" src="${ctx}/js/discovery/preuser-list.js" ></script>
<script type="text/javascript">
<s:if test="accountJson != '[]'">
$(function(){
    var gp = new GridPanel({id:"preUserListGrid",
         width:700,
         columnWidth:{allCheck:50,accountId:100,domainName:100,remarks:200,instanceCount:150,opertor:50},
         plugins:[SortPluginIndex,TitleContextMenu],
         sortColumns:[{index:"accountId",defSorttype:"up"},{index:"domainName"},{index:"instanceCount"}],
         sortLisntenr:function($sort) {
                var colId = $sort.colId;
                var sortType = $sort.sorttype;
           		$.post("preuser-list-sortuser.action?colId=" + colId + "&sortType=" + sortType, function(data){
           			gp.loadGridData(data.accountJson);
             	});
         },
		 contextMenu:function(td){
		    // alert("=="+td.colId);
		 }
	},{gridpanel_DomStruFn:"index_gridpanel_DomStruFn",gridpanel_DomCtrlFn:"index_gridpanel_DomCtrlFn",gridpanel_ComponetFn:"index_gridpanel_ComponetFn"}
	);
    gp.rend([{index:"allCheck",fn:function(td){
       		var hashId = td.value.hashId; 
       		// alert(hashId);
            $chk = $('<input name="hashId" type="checkbox" value="' + hashId + '" onclick="cancelChecked();"/>');
            return $chk;
         }},{index:"remarks",fn:function(td){
			$count = $('<span title="' + td.html + '"><nobr>'+td.html+'</nobr></span>');
			   return $count;
         }},{index:"instanceCount",fn:function(td){
        	 if (td.html != "0") {
        		$count = $('<font align="right">'+td.html+'个<span><span class="gray-btn-l"><span class="btn-r"><span class="btn-m"><a>查看</a></span></span></span></font></span>');  
        	 } else {
        		$count = $('<font align="right">'+td.html+'个</font>');
        	 }
			   $count.children().bind("click",function(){
				    var url = "instance-list.action?hashId=" + td.value.hashId;
				    //window.open(url, "null", "width=600,height=590");
				    winOpen({url:url,width:600,height:590,scrollable:false,name:'instancelist'});
			   });
			   return $count;
			  
         }}, {index:"domainName",fn:function(td){
        	 $count = $('<span title="' + td.html + '">'+td.html+'</span>');
			   return $count;
			  
         }}, {index:"accountId",fn:function(td){
			  $font = $('<a style="cursor:pointer" title="' + td.html + '">' + td.html + '</a>');
			  $font.bind("click",function(){
				var url = "preuser-add.action?hashId=" + td.value.hashId;
				//window.open(url, "null", "width=450,height=270");
				winOpen({url:url,width:450,height:270,scrollable:false,name:'preuseradd'});
           	  });
              return $font;
         }
	}]);
    
   // gp.loadGridData([[{value:2,text:1},{value:2,text:2},{value:2,text:3},{value:2,text:4}]]);
    $("#btn").click(function(){
		gp.colControl(["accountId"],["instanceCount","remarks"]);
    });
    $("#btn1").click(function(){
   		gp.colControl(["remarks"],["instanceCount","accountId"]);
    });
});
</s:if>
</script>
</head>
</head>
<body>
<!-- <input id="btn" type="button" value="one">  -->
<!-- <input id="btn1" type="button" value="two">  -->
<form id="form1" name="form1" action="method">
	<div id="find-right" height="500" border="1">
		<div class="h2">
			<span id="sp_user_delete" title="删除" class="r-ico r-ico-delete"></span>
			<span id="sp_user_add" title="添加" class="r-ico r-ico-add"></span>
			<span class="ico ico-note"></span>专为操作系统设置预置账户用于发现，后续修改操作系统用户名密码时只需修改预置账户即可。
		</div>
		
			<page:applyDecorator name="indexgrid">  
		       <page:param name="id">preUserListGrid</page:param>
		       <page:param name="width">200px</page:param>
		       <page:param name="linenum">0</page:param>
		       <page:param name="tableCls">grid-black</page:param>
		       <page:param name="gridhead">[{colId:"allCheck", text:"<input id='checkAll' name='checkAll' type='checkbox'/>"},{colId:"accountId", text:"用户名"},{colId:"domainName",text:"所属<%=domainPageName%>"},{colId:"remarks",text:"备注"},{colId:"instanceCount",text:"使用此账户的资源"},{colId:"hashId",text:"head4",hidden:true}]</page:param>
		       <page:param name="gridcontent">${accountJson}</page:param>
		    </page:applyDecorator>
	</div>
</form>
</body>
</html>
