<!-- WEB-INF\content\location\status\statusDevices.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<script type="text/javascript" src="/pureportal/js/component/plugins/jquery.ui.core.js"></script>
<script type="text/javascript" src="/pureportal/js/component/plugins/jquery.ui.widget.js"></script>
<script type="text/javascript" src="/pureportal/js/component/plugins/jquery.ui.mouse.js"></script>
<script type="text/javascript" src="/pureportal/js/component/plugins/jquery.ui.draggable.js"></script>
<script type="text/javascript" src="/pureportal/js/jquery.layout-1.2.0.js"></script>
<script type="text/javascript" src="/pureportal/js/component/cfncc.js"></script>
<script type="text/javascript" src="/pureportal/js/component/accordionPanel/accordionLeft.js"></script>
<script type="text/javascript" src="/pureportal/js/component/tabPanel/tab.js"></script>
<script type="text/javascript" src="/pureportal/js/component/panel/panel.js"></script>
<script type="text/javascript" src="/pureportal/js/component/treeView/tree.js"></script>
<script type="text/javascript" src="/pureportal/js/component/gridPanel/grid.js"></script>
<script type="text/javascript" src="/pureportal/js/component/gridPanel/indexgrid.js"></script>
<script type="text/javascript" src="/pureportal/js/component/gridPanel/page.js"></script>
<script type="text/javascript" src="/pureportal/js/component/menu/menu.js"></script>
<script type="text/javascript" src="/pureportal/js/component/comm/winopen.js"></script>
<script type="text/javascript" src="/pureportal/js/monitor/Util.js"></script>
<!-- 
<script type="text/javascript" src="/pureportal/js/monitor/ResourceUtil.js"></script> -->
<script type="text/javascript" src="/pureportal/js/component/toast/Toast.js"></script>
<script type="text/javascript" src="/pureportal/js/component/popwindow/popwin.js"></script>
<script type="text/javascript" src="/pureportal/js/component/combobox/simplebox.js"></script>
<div style="overflow:hidden;">
<span id="del" class="panel-gray-ico panel-gray-ico-close"></span>
<span id="add" class="panel-gray-ico panel-gray-ico-add"></span>
 		<select name="searchTypeWait" id="selectId">
		  		<option value="ip">IP地址</option>
		  		<option value="equipName">设备名称</option>
		  		<option value="resurceType">设备类型</option>
		  	</select><span>：</span>
		  	<span>
		  		<input type="text" name="inputVal" id="inputVal"/>
		</span>
	    <span class="ico ico-select" id="search"></span>
 		<!-- 
 		<input type="checkbox" name="selectCheck" value="1" />
 		 -->
 		</div>

<page:applyDecorator name="indexcirgrid">  
    <page:param name="id">tableId</page:param>
    <page:param name="width">745px</page:param>
    <page:param name="linenum">${pageData.pageSize}</page:param>
    <page:param name="height">400px</page:param>
    <page:param name="tableCls">grid-gray</page:param>
    <page:param name="gridhead">[
    {colId:"equipmentId", text:"<input type='checkbox' id='eqAll' value=''>"},{colId:"id", text:"id",hidden:true},
    {colId:"ip", text:"设备IP"},
    {colId:"mac", text:"MAC地址"},
    {colId:"equipName", text:"设备名称"},
    {colId:"equipNumber", text:"设备号"},
    {colId:"adminName", text:"用户名"},
    {colId:"description", text:"备注"}]</page:param>
    <page:param name="gridcontent">${devices }</page:param>
</page:applyDecorator>
 <div id="pageover" style="overflow:hidden;width:100%" ></div>
<input type="hidden" id="sortIdHidden" name="sortIdHidden" value="ip" />
<input type="hidden" id="sortColIdHidden" name="sortColIdHidden" value="ASC" />
<input type="hidden" id="pageIdHidden" name="pageData.pageIndex" value="<s:property value='pageData.pageIndex'/>" />
 <!-- 
    {colId:"cabinetNumb", text:"机柜号"},
    {colId:"frameNumb", text:"机框号"}, 
id:30,
			ip:90,
			mac:120,
			equipName:80,
			cabinetNumb:70,
			frameNumb:70,
			equipNumber:70,
			adminName:80,
			description:60-->
  

<script type="text/javascript">
	var gp;
	var pageCount = '<s:property value="pageCount" />';
	$(document).ready(function(){
		gp = new GridPanel({id:"tableId",
			width:100,
			columnWidth:{
			equipmentId:7,
			ip:23,
			mac:23,
			equipName:12,
			equipNumber:12,
			adminName:12,
			description:11},
			unit:"%",
			plugins:[SortPluginIndex],
			sortColumns:[{index:"ip",sortord:"0",defSorttype:"up"}],
			sortLisntenr:function($sort){
            $.blockUI({message:$('#loading')});
			var resType = $(".nonce").attr("id");
				var sort=$sort.colId;
	       	    var sortCol=$sort.sorttype;
				if(sortCol=="up"){
					sortCol="ASC";
				}else{
					sortCol="DESC";
				}
	       	 	$("#sortIdHidden").val(sort);
	    		$("#sortColIdHidden").val(sortCol);
				var searchTypeWait = $("#selectId").val();
				var inputVal = $("#inputVal").val();
	    		var page = $("#pageIdHidden").val();
	       	 	if(null == page || "" == page){
	           	    page = '<s:property value="pageData.pageIndex" />';
	           	}
	       	 var result =  "searchTypeWait="+searchTypeWait+"&inputVal="+inputVal+"&curPageCount=" + page  + "&orderProperty=" + sort + "&orderType=" + sortCol+"&location.locationId=" + locationId  + "&resType=" + resType;
	       	 
	         var url = "${ctx}/location/status/status!statusDevicesJson.action";
		            $.ajax({
		                type: "POST",
		                dataType: 'json',
		                data:result,
		             	url:url,
		                success: function(data, textStatus) {
		        			gp.loadGridData(data.devices);
		        			$(".nLine").attr("style","height:26px");
		        			$.unblockUI();
							SimpleBox.renderAll();
							$('.combobox').parent().css('position', ''); 
		                }
		            });
			}
		},{gridpanel_DomStruFn:"index_gridpanel_DomStruFn",gridpanel_DomCtrlFn:"index_gridpanel_DomCtrlFn",gridpanel_ComponetFn:"index_gridpanel_ComponetFn"});
		gp.rend([{index:"equipmentId",fn:function(td){
			return td.value.id==""?"":$('<input type="checkbox" name="equipmentIds" value="'+td.value.id+'">');
		}},{index:"mac",fn:function(td){
   				if(td.html!=" " && td.html!=" ") {
   	   				var macStr = td.html+"";
   	   				//ipStr = ipStr.substring(2,ipStr.length-2);
   	   				var macStr = macStr.split(",");
   	   				if (macStr.length > 1){
   	   					$select = $('<select id=imac'+td.rowIndex+' style="width:140px;"></select>');
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
   	   	}},{index:"ip",fn:function(td){
   				if(td.html!="" && td.html!=" ") {
   	   				var ipStr = td.html+"";
   	   				var ipStr = ipStr.split(",");
   	   				if (ipStr.length > 1){
   	   					$select = $('<select id=ip'+td.rowIndex+' style="width:120px;" iconIndex="0" iconTitle="管理IP" iconClass="combox_ico_select f-absolute"></select>');
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
   	   	}},{index:"description",fn:function(td){
        	return td.value.id==""?"":jQuery('<span class="ico ico-file" title="' + td.html + '"></span>').click(function(event){
	    		panel = new winPanel({
			        url:"${ctx}/location/relation/device!editRemark.action?equipment.equipName=edit&equipment.Id=" + td.value.id,
			        width:280,
			        x:event.pageX-280,
			        y:event.pageY,
			        isDrag:false,
					isautoclose:true
				},{winpanel_DomStruFn:"blackLayer_winpanel_DomStruFn"});
				});
		}}]);
	    
	    $("#add").click(function(){
	    	window.open("${ctx}/location/status/status!batchAdd.action?location.locationId="+locationId);
	    });
	    
	    $("#del").click(function(){
	    	
	    	var $eqIds =$("input[name=equipmentIds]:checked");
	    	if($eqIds.size()>0){
	    		var confirm_batdel = new confirm_box({text:"该操作不可恢复，是否确认删除？"});
	    		confirm_batdel.show();
	    		confirm_batdel.setConfirm_listener(function(){
	    		confirm_batdel.hide();
		    			 $.ajax({
								url: 		"${ctx}/location/status/status!delete.action",
								data:		"location.locationId=" + locationId + "&" + $eqIds.serialize(),
								cache:		false,
								success: function(data, textStatus){
									loadContent("${ctx}/location/status/status!showDefineStatus.action");
								}
							});
		    	});
		    	confirm_batdel.setCancle_listener(function(){
		    		confirm_batdel.hide();
					});
	    	} else {
	    		showMess("请至少选择一项");
	    	}
	    });
	    
		$("#eqAll").click(function(){
			$("input[name=equipmentIds]").attr("checked", this.checked);
		});
		$("#search").click(function(){
			$.blockUI({message:$('#loading')});
			var resType = $(".nonce").attr("id");
			var searchTypeWait = $("#selectId").val();
			var inputVal = $("#inputVal").val();
			var result = "searchTypeWait="+searchTypeWait+"&inputVal="+inputVal+"&location.locationId=" + locationId  + "&resType=" + resType;
	         var url = "${ctx}/location/status/status!statusDevicesJson.action";
		            $.ajax({
		                type: "POST",
		                dataType: 'json',
		                data:result,
		             	url:url,
		                success: function(data, textStatus) {
							gp.loadGridData(data.devices);
							$(".nLine").attr("style","height:26px");
							page.pageing(data.pageCount,1);
							SimpleBox.renderAll();
							$('.combobox').parent().css('position', ''); 
							$.unblockUI();
		                },
			                error: function(e){
			                	alert(e.responseText);
			                	}
		            });
		});
		SimpleBox.renderAll();
		$('.combobox').parent().css('position', ''); 
	});
	
	function showMess(str){
		var toast = new Toast({position:"CT"});
		toast.addMessage(str);
	}
	
	var page = new Pagination({
    applyId: "pageover",
    listeners: {
    pageClick: function(page) {
	$.blockUI({message:$('#loading')});
	$("#pageIdHidden").val(page);
    var sort=$("#sortIdHidden").val();
    var sortCol=$("#sortColIdHidden").val();
    var resType = $(".nonce").attr("id");
	var searchTypeWait = $("#selectId").val();
	var inputVal = $("#inputVal").val();
    var result = "searchTypeWait="+searchTypeWait+"&inputVal="+inputVal+"&location.locationId=" + locationId  + "&resType=" + resType+"&pageData.pageIndex=" + page  + "&orderProperty=" + sort + "&orderType=" + sortCol;
    var url = "${ctx}/location/status/status!statusDevicesJson.action";
            $.ajax({
                type: "POST",
                dataType: 'json',
        		data:result, 
        		url: url,
                success: function(data, textStatus) {
    				gp.loadGridData(data.devices);
    				$(".nLine").attr("style","height:26px");
					$.unblockUI();
					SimpleBox.renderAll();
					$('.combobox').parent().css('position', ''); 
                }
            });
        }
    }
});
page.pageing(pageCount,1);

SimpleBox.renderAll();
$('.combobox').parent().css('position', '');
</script>
