<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- 
	@page : 资源选择列表页面.jsp 
	@auther : weiyi@rd.mochasoft.com.cn
--%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<page:applyDecorator name="indexcirgrid">
      <page:param name="id">tableId</page:param>
      <page:param name="height">335px</page:param>
      <page:param name="width">98%</page:param>
      <page:param name="tableCls">grid-blue</page:param>
      <page:param name="lineHeight">27px</page:param>
      <page:param name="gridhead">${displayVO.head}</page:param>
      <page:param name="gridcontent">${displayVO.content}</page:param>
    </page:applyDecorator>
<div id="page"></div>
<script src="${ctx}/js/component/gridPanel/grid.js"></script>
<script src="${ctx}/js/component/gridPanel/indexgrid.js"></script>
<script src="${ctx}/js/component/gridPanel/page.js"></script>
<script type="text/javascript">
var pageCount = Number('${displayVO.totalPage}');
var columnW;
columnW = {resInstanceId:"5",resIpAddress:"30",resInstanceName:"35",resInstanceCategory:"30"};
var gp = new GridPanel({id:"tableId",
	columnWidth:columnW,
	unit: "%",
	plugins:[SortPluginIndex],
	sortColumns:[{index:"resIpAddress"},
	             {index:"resInstanceName",defSorttype:"down"}],
	sortLisntenr:function($sort){
			//alert($sort.colId+"#"+$sort.sorttype+"#"+page);
          var orderType = "desc";
          if($sort.sorttype == "up"){
                  orderType = "asc";
          }
          $("#orderBy").val($sort.colId);
          $("#orderType").val(orderType);
          var page = $("#currentPage").val();
 		  var ajaxParam = $("#filterForm").serialize();
		    $.ajax({
		         type: "POST",
		         dataType:'json',
		         url: path+"/businesscomponent/resChoice!jsonPageing.action",
		         data : ajaxParam,
		         success: function(data, textStatus){
		    		if(data.displayVO){
				 		gp.loadGridData(data.displayVO.content);
				 		//$.unblockUI();
					}  
		         },
		         error:function(e){
			         $("body").html(e.responseText);
			        }
		    });
    }},
    {gridpanel_DomStruFn:"index_gridpanel_DomStruFn",gridpanel_DomCtrlFn:"index_gridpanel_DomCtrlFn",gridpanel_ComponetFn:"index_gridpanel_ComponetFn"});
gp.rend([{index:"resInstanceId",fn:function(td){
		if(td.html){
		var $r ;
		if(singleSelection && singleSelection==="true"){
			$r= $("<input type=\"radio\" value="+td.html+" name=\"singleSelection\"/>");
			$r.bind("change",function(){singleSelectId(td.html)});
		}else{
			var ischeck="";
			if(map[td.html]){
				ischeck = "checked=checked"
			}
			$r= $("<input type=\"checkbox\" value="+td.html+" "+ischeck+"/>");
			$r.bind("change",function(){
					var ischecked = $(this).attr("checked");
					if(ischecked){
						addId(td.html);
					}else{
						removeId(td.html);
					}
			});
		}	
		return $r;}
}},
{index:"resIpAddress",fn:function(td){
	if(td.html){
		var ips = td.html.split(",");
		var $r ;
		if(ips.length > 1 ){
			$r = $("<select></select>");
			for(var index=0; index < ips.length ; index++){
				$r.append("<option value=\"" + ips[index] + "\" >" + ips[index] + "</option>");
			}
		}else{
			$r = $("<span title=\""+ips[0]+"\">"+ips[0]+"</span>");
		}
		
		return $r;}	
}},
{index:"resInstanceName",fn:function(td){
	if(td.html){
		var str = td.html.split(",");
		var name=str[0];
		var id=str[1];
		var $r = $("<span title='"+name+"' style=\"cursor:pointer;\">"+name+"</span>");
		return $r;}	
}},
{index:"effecteInstance",fn:function(td){
	if(td.html){
		var $r = $("<span class=\"ico\" title="+td.html+" />");
		$r.click(function(){
				alert(td.html);
		})
		return $r;}	
}}]);
var page = new Pagination({applyId:"page",listeners:{
    pageClick:function(page){
		 $.blockUI({message:$('#loading')});
		 $("#currentPage").val(page);
		 var ajaxParam = $("#filterForm").serialize();
		 $.ajax({
			   type: "POST",
			   dataType:"json",
			   url: path + "/businesscomponent/resChoice!jsonPageing.action",
			   data: ajaxParam + "&currentPage="+page,
			   success: function(data, textStatus){
				 	if(data.displayVO){
				 		gp.loadGridData(data.displayVO.content);
				 		$.unblockUI();
					}  
			   }
		 });
    }
}});
page.pageing(pageCount,1);
/*
$(".roundedform-top").find("input","[colId=resInstanceId]").click(function(){
	//$(".roundedform-content").find("input","[colId=resInstanceId]").attr("checked",$(this).attr("checked"));
	var ischecked = $(this).attr("checked");
	$(".roundedform-content").find("input","[colId=resInstanceId]").each(function(i,e){
		$(e).attr("checked",ischecked);
		if($(e).attr("checked")){
			addId($(e).val());
		}else{
			removeId($(e).val());
		}
	});
});
*/
$(".roundedform-content").find("input","[colId=resInstanceId]").click(function(){
	if($(this).attr("type")=="checkbox"){
		if(!$(this).attr("checked")){
			$(".roundedform-top").find("input","[colId=resInstanceId]").attr("checked",$(this).attr("checked"));
			removeId($(this).val());
		}else{
			addId($(this).val());
		}
	}else{
		singleSelectId($(this).val());
	}
	
});
$("#resAllId").bind('change',function(){
    $("td[colId=resInstanceId]").find("input","[type=checkbox]").attr("checked",$(this).attr("checked")).change();
  });
</script>