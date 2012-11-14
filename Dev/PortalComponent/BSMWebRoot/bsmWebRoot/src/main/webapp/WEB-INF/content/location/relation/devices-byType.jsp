<!-- WEB-INF\content\location\relation\devices-byType.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mocha.bsm.action.location.relation.util.BeanSort.OrderType" %>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<%@ include file="/WEB-INF/common/loading.jsp" %>

<div style="overflow:hidden;" >
<form id="searchCondition">
	<s:select id="condition" name="searchCondition.condition" list="#{'equipName':'设备名称', 'ip':'设备IP', 'resurceType':'设备类型' }"></s:select>
	<s:textfield name="searchCondition.conditionValue"></s:textfield>
	<span class="ico" id="search"></span>
	<s:hidden name="searchCondition.equipmentIds" value="%{equipmentIds}"/>
	<!--
	<s:checkboxlist name="searchCondition.restultSearch" list="#{'1':'在结果中搜索 '}"></s:checkboxlist>
	-->
	<span class="operation-ico operation-ico-columnset"></span>
	<input type="hidden" id="sortIdHidden" name="sortIdHidden" value="ip" />
	<input type="hidden" id="sortColIdHidden" name="sortColIdHidden" value="ASC" />
	<input type="hidden" id="pageIdHidden" value="<s:property value='pageData.pageIndex'/>" />
</form>	
</div>
<page:applyDecorator name="indexcirgrid">  
    <page:param name="id">tableId</page:param>
    <page:param name="height">525px</page:param>
	 <page:param name="width">100%</page:param>
    <page:param name="linenum">${pageData.pageSize}</page:param>
    <page:param name="tableCls">grid-gray</page:param>
    <page:param name="gridhead">[{colId:"equipmentId", text:"<input type='checkbox' id='eqAll' style='cursor:pointer' />"},{colId:"id", text:"id",hidden:true},{colId:"ip", text:"设备IP"},{colId:"mac", text:"MAC地址"},{colId:"equipName", text:"设备名称"},{colId:"resurceType", text:"设备类型"},{colId:"area", text:"地区"},{colId:"builder", text:"大楼"},{colId:"floor", text:"楼层"},{colId:"room", text:"房间"},{colId:"see", text:"查看"},{colId:"description", text:"备注"},{colId:"operation", text:"操作"}]</page:param>
    <page:param name="gridcontent">${devices}</page:param>
</page:applyDecorator>
<div id="pagination" style="width:100%"></div>
   
<script type="text/javascript">
	
	var grid,panel,page;
	var pageCount = '<s:property value="pageCount" />';
	$(document).ready(function() {
	    grid = new GridPanel({id:"tableId",
							//width:100%,
							columnWidth:{equipmentId:5,ip:12,mac:14,equipName:10,resurceType:10,area:7,builder:7,floor:7,room:7,see:7,description:7,operation:7},
							unit:"%",
							plugins:[SortPluginIndex],
							sortColumns:[{index:"ip",sortord:"0",defSorttype:"up"}],
							sortLisntenr:function($sort){
								$.blockUI({message:$('#loading')});
								var resType = $(".nonce").attr("id");
								var locationId = "${location.locationId}";
									var sort=$sort.colId;
						       	    var sortCol=$sort.sorttype;
									if(sortCol=="up"){
										sortCol="ASC";
									}else{
										sortCol="DESC";
									}
						       	 	$("#sortIdHidden").val(sort);
						    		$("#sortColIdHidden").val(sortCol);
						    		var page = $("#pageIdHidden").val();
						       	 	if(null == page || "" == page){
						           	    page = '<s:property value="pageData.pageIndex" />';
						           	}
								
						       	 var result = $("#searchCondition").serialize()+"&pageData.pageIndex=" + page  + "&orderProperty=" + sort + "&orderType=" + sortCol+"&location.locationId=" + locationId  + "&resType=" + resType;
						       	 
						         var url = "${ctx}/location/relation/device!pageDatas.action";
							            $.ajax({
							                type: "POST",
							                dataType: 'json',
							                data:result,
							             	url:url,
							                success: function(data, textStatus) {
							        			grid.loadGridData(data.devices);
							        			$(".nLine").attr("style","height:26px");
												SimpleBox.renderAll();
							        			$('.combobox').parent().css('position', ''); 
							        			$.unblockUI();
							                }
							            });
							}
		},{gridpanel_DomStruFn:"index_gridpanel_DomStruFn",gridpanel_DomCtrlFn:"index_gridpanel_DomCtrlFn",gridpanel_ComponetFn:"index_gridpanel_ComponetFn"});
		// 设置数据显示格式
	    grid.rend([{index:"equipmentId",fn:function(td){
	    	return td.value.id==""?" ":$('<input type="checkbox" name="equipmentIds" value="'+td.value.id+'">');
		}},{index:"see",fn:function(td){
	    	return td.value.id==""?"":jQuery("<span class=\"ico ico-examine\"></span>").click(function(event){
	    		panel = new winPanel({
						        url:"${ctx}/location/relation/device!deviceInfo.action?equipment.Id=" + td.value.id+ "&resType=" + $("li[class=nonce]").attr("id"),
						        width:280,
						        x:event.pageX-280,
						        y:event.pageY,
						        isDrag:false,
								isautoclose:true
	    				},{winpanel_DomStruFn:"blackLayer_winpanel_DomStruFn"});
	    		});
		}},{index:"ip",fn:function(td){
   				if(td.html!="" && td.html!=" ") {
   	   				var ipStr = td.html+"";
   	   				//ipStr = ipStr.substring(2,ipStr.length-2);
   	   				var ipStr = ipStr.split(",");
   	   				if (ipStr.length > 1){
   	   					$select = $('<select id=ip'+td.rowIndex+' iconIndex="0" iconTitle="管理IP" iconClass="combox_ico_select f-absolute" style="width:110px;"></select>');
	   	   				for (var i=0;i<ipStr.length;i++){
	   	   					$("<option value='"+i+"'>"+ipStr[i]+"</option>").appendTo($select)//添加下拉框的option	
	   	   	   			}
	   	   	   			return $select;
   	   	   			}else{
   	   	   				$span = $('<span>'+ipStr[0]+'</span>');
  						return $span; 
   	   	   	   		}
   	   			}else{
   	   				return null;
   	   	   		}
   	   	}},{index:"mac",fn:function(td){
   				if(td.html!="" && td.html!=" ") {
   	   				var macStr = td.html+"";
   	   				//ipStr = ipStr.substring(2,ipStr.length-2);
   	   				var macStr = macStr.split(",");
   	   				if (macStr.length > 1){
   	   					$select = $('<select id=imac'+td.rowIndex+' style="width:120px;"></select>');
	   	   				for (var i=0;i<macStr.length;i++){
	   	   					$("<option value='"+i+"'>"+macStr[i]+"</option>").appendTo($select)//添加下拉框的option	
	   	   	   			}
	   	   	   			return $select;
   	   	   			}else{
   	   	   				$span = $('<span>'+macStr[0]+'</span>');
  						return $span; 
   	   	   	   		}
   	   			}else{
   	   				return null;
   	   	   		}
   	   	}},{index:"description",fn:function(td){
   	   		
	    	return td.value.id==""?"":jQuery("<span class=\"ico ico-file\" title=\""+td.html+"\"></span>").click(function(event){
	    		panel = new winPanel({
	    				    			
			        url:"${ctx}/location/relation/device!editRemark.action?equipment.equipName=edit&equipment.Id=" + td.value.id,
			        width:280,
			        x:event.pageX-280,
			        y:event.pageY,
			        isDrag:false,
					isautoclose:true
				},{winpanel_DomStruFn:"blackLayer_winpanel_DomStruFn"});
				});
		}},{index:"operation",fn:function(td){
	    	return td.value.id==""?"":jQuery("<span class=\"ico ico-t-right\"></span>").click(function(event){
				mc.addMenuItems([[{ico:"export",text:"导出",id:"exp",listeners:{
						click:function(){
					    	var elemIF = document.createElement("iframe");   
					    	elemIF.src = "${ctx}/location/relation/device!exportExcel.action?resType="+resType+"&equipmentIds="+td.value.id;
					    	elemIF.style.display = "none";   
					    	document.body.appendChild(elemIF);
							$(".buttonmenu").hide();
						  }
					}},{ico:"delete",text:"删除",id:"del",listeners:{
						click:function(){
							
								var confirm_del = new confirm_box({text:"是否确认删除？"});
								confirm_del.show();
								confirm_del.setConfirm_listener(function(){
								//prompt("",td.html);
								confirm_del.hide();
						    	$.ajax({
									url: 		ctx + "/location/relation/device!delete.action",
									data:		"location.locationId="+locationId + "&equipmentIds=" + td.value.id,
									dataType: 	"html",
									cache:		false,
									success: function(data, textStatus){
										$("#search").click();
										showMess("删除成功");
									}
						    	});
						    confirm_del.setCancle_listener(function(){
									confirm_del.hide();
								});
								
							});
							$(".buttonmenu").hide();
						  }
					}},{ico:"edit",text:"编辑",id:"edit",listeners:{
						click:function(){
							window.open("${ctx}/location/relation/device!edit.action?location.locationId="+locationId+"&equipmentIds="+td.value.id+ "&resType=" + $("li[class=nonce]").attr("id"));
							$(".buttonmenu").hide();
						  }
						  
					}}
					]]);
	    		mc.position(event.pageX,event.pageY)
	    	});
		}}]);

		$("#eqAll").click(function(){
			$("input[name=equipmentIds]").attr("checked", this.checked);
		});
		
		/*
		$("#search").click(function(){
			tp.loadContent(tp.currentIndex,{url:"${ctx}/location/relation/device!devices.action?" + getParams()});
		});
		*/
		$("#search").click(function(){
				$.blockUI({message:$('#loading')});
				var resType = $(".nonce").attr("id");
				var locationId = "${location.locationId}";
				var result =  $("#searchCondition").serialize()+"&location.locationId=" + locationId  + "&resType=" + resType;
				 var url = "${ctx}/location/relation/device!pageDatas.action";
		            $.ajax({
		                type: "POST",
		                dataType: 'json',
		                data:result,
		             	url:url,
		                success: function(data, textStatus) {
							grid.loadGridData(data.devices);
							$(".nLine").attr("style","height:26px");
							page.pageing(data.pageCount,1);
							SimpleBox.renderAll();
							$('.combobox').parent().css('position', ''); 
							$.unblockUI();
		                }
		            });
		});
SimpleBox.renderAll();
	$('.combobox').parent().css('position', ''); 

	});

	page = new Pagination({applyId:"pagination",listeners: {
    pageClick: function(page) {
		if(page == ""){
    		return;
    		}
	$.blockUI({message:$('#loading')});
	$("#pageIdHidden").val(page);
    var sort=$("#sortIdHidden").val();
    var sortCol=$("#sortColIdHidden").val();
    var resType = $(".nonce").attr("id");
	var locationId = "${location.locationId}";
    var result =  $("#searchCondition").serialize()+"&location.locationId=" + locationId  + "&resType=" + resType+"&pageData.pageIndex=" + page  + "&orderProperty=" + sort + "&orderType=" + sortCol;
    var url = "${ctx}/location/relation/device!pageDatas.action";
            $.ajax({
                type: "POST",
                dataType: 'json',
        		data:result, 
        		url: url,
                success: function(data, textStatus) {
    				grid.loadGridData(data.devices);
    				$(".nLine").attr("style","height:26px");
					SimpleBox.renderAll();
					$('.combobox').parent().css('position', ''); 
					$.unblockUI();
                }
            });
        }
    }});
	page.pageing(pageCount,1);


	// 加载分页数据
	function LoadDatas(){
		
		$.ajax({
			url: 		ctx + "/location/relation/device!pageDatas.action",
			data:		getParams(),
			dataType: 	"json",
			cache:		false,
			success: function(data, textStatus){
				grid.loadGridData(data.devices)
				page.pageing(data.pageData.pageCount,data.pageData.pageIndex);
				SimpleBox.renderAll();
			}
		});
	}
	// 请求参数
	function getParams(){
		return $("#searchCondition").serialize()
		+ "&resType=" + resType 
		+ "&location.locationId=" + locationId
		+ "&orderProperty=" + grid.currentSort.attr("colId") 
		+ "&orderType="	+ (grid.currentSort.attr("sorttype")=="up"?"<%=OrderType.ASC%>":"<%=OrderType.DESC%>")
		+ "&pageData.pageIndex=" + page.current 
		+ "&pageData.pageSize=" + ${pageData.pageSize};
	}
	function showMess(str){
	var toast = new Toast({position:"CT"});
	toast.addMessage(str);
}
</script>

