<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html>
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>预置账户</title>
<script type="text/javascript">
<s:if test="accountJson != '[]'"> 
$(function(){
	var $account_hash_id = $("#account_hash_id").val();
	
    var gp = new GridPanel({id:"tab_account",
         width:300,
         columnWidth:{accountRadio:20,accountId:80,remarks:100},
         plugins:[SortPluginIndex,TitleContextMenu],
         sortColumns:[{index:"accountId",defSorttype:"up"}],
         sortLisntenr:function($sort) {
                //alert($sort.colId);
                //alert($sort.sorttype);
                var colId = $sort.colId;
                var sortType = $sort.sorttype;
         },
		 contextMenu:function(td){
		    // alert("=="+td.colId);
		 }
	},{gridpanel_DomStruFn:"index_gridpanel_DomStruFn",gridpanel_DomCtrlFn:"index_gridpanel_DomCtrlFn",gridpanel_ComponetFn:"index_gridpanel_ComponetFn"}
	);
    gp.rend([{index:"accountIdDisplay",fn:function(td){
       		// alert(td.value.h5);
       		var accountId = td.value.accountId;
            $font = $('<span title=' + accountId + ' >'+accountId+'</span>');
            return $font;
         }}, {index:"remarks",fn:function(td){
				$count = $('<span title="' + td.html + '"><nobr>'+td.html+'</nobr></span>');
			   return $count;
         }},{index:"accountRadio",fn:function(td){
       		var accountId = td.value.accountId;
       		var accountPassword = td.value.accountPassword;
       		// alert(accountId + "," + accountPassword);
       		
       		var checkedStr = "";
       		if ($account_hash_id != null && $account_hash_id == td.value.hashId) {
       			checkedStr = " checked";
       		}
            $obj = $('<input id="' + accountId+ '" name="hashId" type="radio" value="' + td.value.hashId + '" accountId="' + accountId + '" accountPassword="'+ accountPassword + '"' + checkedStr + '/>');
            return $obj;
         }}
         ]);
    
    
});
</s:if>
</script>
</head>
<body>
	<input type="hidden" id="account_page_mark" name="account_page_mark" value="discovery-account"/>
	<page:applyDecorator name="indexgrid">  
       <page:param name="id">tab_account</page:param>
       <page:param name="tableCls">grid-black</page:param>
       <page:param name="linenum">0</page:param>
       <page:param name="gridhead">[{colId:"accountRadio", text:""},{colId:"accountIdDisplay", text:"用户名"},{colId:"remarks",text:"备注"},{colId:"accountId",text:"pw",hidden:true},{colId:"accountPassword",text:"pw",hidden:true},{colId:"hashId",text:"head4",hidden:true}]</page:param>
       <page:param name="gridcontent">${accountJson}</page:param>
    </page:applyDecorator>
</body>
</html>