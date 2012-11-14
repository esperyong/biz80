<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<div style="height:236px">
<page:applyDecorator name="indexcirgrid">
				<page:param name="id">choiceResourcePage_${sign }</page:param>
				<page:param name="width">100%</page:param>
				<page:param name="height">241px</page:param>
				<page:param name="tableCls">grid-blue</page:param>
				<page:param name="gridhead">[{colId:"allCheckId", text:"<input type='checkbox' name='checkall' id='checkall_${sign }' onclick='choiceResInstances(this)'/>"},{colId:"COMPOSITOR_DISPLAYNAME", text:"显示名称"},{colId:"COMPOSITOR_IPADDRESS", text:"IP地址"},{colId:"resourceType", text:"资源类型"}]</page:param>
				<page:param name="gridcontent">${resourceInfos }</page:param>
				<page:param name="linenum">12</page:param>
</page:applyDecorator>
<div id="pageResource_${sign }"></div></div>		
<script type="text/javascript">
$(document).ready(function(){
	var gp = new GridPanel({id:"choiceResourcePage_${sign }",
		unit:"%",
		columnWidth:{allCheckId:8,COMPOSITOR_DISPLAYNAME:54,COMPOSITOR_IPADDRESS:18,resourceType:20},
		plugins:[SortPluginIndex],
		sortColumns:[{index:"COMPOSITOR_DISPLAYNAME",defSorttype:"down"},
		{index:"COMPOSITOR_IPADDRESS"}],
		sortLisntenr:function($sort){	
			$.blockUI({message:$('#loading')});
			if($sort.sorttype == "up"){
				$("#order_${sign }").attr("value",'ASC');
			}else{
				$("#order_${sign }").attr("value",'ESC');
			}	
			$("#returnType_${sign }").attr("value","jsonType");
			$("#compositor_${sign }").attr("value",$sort.colId);
			var ajaxParam = $("#resourceForm_${sign }").serialize();
			ajaxParam+="&userId="+userId;
		     $.ajax({
		 		type: "POST",
		 		dataType:'json',
		 		url: "${ctx}/report/statistic/statisticOper!loadChoiceResource.action",
		 		data: ajaxParam,
		 		success: function(data, textStatus){   		 			
		 			gp.loadGridData(data.resourceInfos);
		 			$.unblockUI();
		 		},
		 		error:function(data1,data2,data3){
		 			$.unblockUI();
		 		}});
		     
		}},{gridpanel_DomStruFn:"index_gridpanel_DomStruFn",gridpanel_DomCtrlFn:"index_gridpanel_DomCtrlFn",gridpanel_ComponetFn:"index_gridpanel_ComponetFn"});			
gp.rend([{index:"allCheckId",fn:function(td){
		if(td.html){
			var ips = td.html.split(";");			
			if(ips[0]=="true"){
				$r=$("<input type=\"checkbox\" checked=\"checked\" name=\"check_"+ips[1]+"\" onclick=\"choiceInstance(this)\" value=\""+ips[2]+"\"/>");
			}else{
				$r=$("<input type=\"checkbox\"  name=\"check_"+ips[1]+"\" onclick=\"choiceInstance(this)\" value=\""+ips[2]+"\"/>");
			}		
			return $r;}
}}]);	
	var page = new Pagination({applyId:"pageResource_${sign }",listeners:{
        pageClick:function(page){
          if(page==0){
        	  page=1;
          }         
          $.blockUI({message:$('#loading')});
		  $("#pageNumber_${sign }").attr("value",page);
		  $("#returnType_${sign }").attr("value","jsonType");
		  var ajaxParam = $("#resourceForm_${sign }").serialize();
		  ajaxParam+="&userId="+userId;
		  $.ajax({
		 		type: "POST",
		 		dataType:'json',
		 		url: "${ctx}/report/statistic/statisticOper!loadChoiceResource.action",
		 		data: ajaxParam,
		 		success: function(data, textStatus){    			
		 			gp.loadGridData(data.resourceInfos);
		 			$.unblockUI();
		 			isChecked();
		 		},
		 		error:function(data1,data2,data3){
		 			$.unblockUI();
		 		}
		 	  }
		  );
        }
      }});
    page.pageing(${pageCount},0);
    isChecked();
});

</script>
