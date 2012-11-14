<!-- WEB-INF\content\location\status\batchAddDevices.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<script type="text/javascript" src="${ctxJs}/jquery-1.4.2.min.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctxJs}/jquery.validationEngine-cn.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctxJs}/jquery.validationEngine.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctxJs}/component/plugins/jquery.ui.core.js"></script>
<script type="text/javascript" src="${ctxJs}/component/plugins/jquery.ui.widget.js"></script>
<script type="text/javascript" src="${ctxJs}/component/plugins/jquery.ui.mouse.js"></script>
<script type="text/javascript" src="${ctxJs}/component/plugins/jquery.ui.draggable.js"></script>
<script type="text/javascript" src="${ctxJs}/jquery.layout-1.2.0.js"></script>
<script type="text/javascript" src="${ctxJs}/component/cfncc.js"></script>
<script type="text/javascript" src="${ctxJs}/component/accordionPanel/accordionLeft.js"></script>
<script type="text/javascript" src="${ctxJs}/component/tabPanel/tab.js"></script>
<script type="text/javascript" src="${ctxJs}/component/panel/panel.js"></script>
<script type="text/javascript" src="${ctxJs}/component/treeView/tree.js"></script>
<script type="text/javascript" src="${ctxJs}/component/gridPanel/grid.js"></script>
<script type="text/javascript" src="${ctxJs}/component/gridPanel/indexgrid.js"></script>
<script type="text/javascript" src="${ctxJs}/component/gridPanel/page.js"></script>
<script type="text/javascript" src="${ctxJs}/component/menu/menu.js"></script>
<script type="text/javascript" src="${ctxJs}/component/comm/winopen.js"></script>
<script type="text/javascript" src="${ctxJs}/monitor/Util.js"></script>
<!-- 
<script type="text/javascript" src="${ctxJs}/monitor/ResourceUtil.js"></script> -->
<script type="text/javascript" src="${ctxJs}/component/toast/Toast.js"></script>
<script type="text/javascript" src="${ctxJs}/component/popwindow/popwin.js"></script>
<script type="text/javascript" src="${ctxJs}/component/combobox/simplebox.js"></script>
<script src="${ctxJs}/jquery.blockUI.js" type="text/javascript"></script>
  <div class="panel-gray">
	  <div class="h1">
	  	<select name="searchTypeWait" id="selectId">
	  		<option value="ip">IP地址</option>
	  		<option value="equipName">设备名称</option>
	  		<option value="resurceType">设备类型</option>
	  	</select><span>：</span>
	  	<span>
	  		<input type="text" name="inputVal" id="inputVal" />
	  	</span>
	  	<span class="ico ico-select" id="searchWaitId"></span>
	  </div>
	
  	<page:applyDecorator name="indexcirgrid">  
     <page:param name="id">options</page:param>
     <page:param name="width">480px</page:param>
     <page:param name="height">430px</page:param>
     <page:param name="tableCls">grid-gray</page:param>
     <page:param name="gridhead">[
     {colId:"id", text:"<input type='checkbox' id='eqAll' style='cursor:pointer' />"},
     {colId:"ip", text:"设备IP"},{colId:"mac", text:"MAC地址"},
     {colId:"equipName", text:"设备名称"},
     {colId:"resurceType", text:"设备类型"}]</page:param>
     <page:param name="gridcontent">${devices }</page:param>
    </page:applyDecorator>
    <div id="pageover" style="overflow:hidden;width:100%" ></div>
	<input type="hidden" id="sortIdHidden" name="sortIdHidden" value="ip" />
	<input type="hidden" id="sortColIdHidden" name="sortColIdHidden" value="ASC" />
	<input type="hidden" id="pageIdHidden" name="pageData.pageIndex" value="<s:property value='pageData.pageIndex'/>" />
  </div>


<script type="text/javascript">

	var gp;
	var pageCount = '<s:property value="pageCount" />';
	//表单验证
	$(document).ready(function() {
		var to = new Toast({position:"CT"});
		gp = new GridPanel({id:"options",
			width:480,
			columnWidth:{
			id:30,
			ip:130,
			mac:130,
			equipName:100,
			equipType:90},
			plugins:[SortPluginIndex],
			sortColumns:[{index:"ip",sortord:"0",defSorttype:"up"}],
			sortLisntenr:function($sort){
				$.blockUI({message:$('#loading')});
				var resType = $(".nonce").attr("id");
				var locationId = $("#form1_location_locationId").val();
				
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
		       	 var result =  "searchTypeWait="+searchTypeWait+"&inputVal="+inputVal+"&pageData.pageIndex=" + page  + "&orderProperty=" + sort + "&orderType=" + sortCol+"&location.locationId=" + locationId  + "&resType=" + resType;
		       	//alert(result);
		         var url = "${ctx}/location/status/status!batchAddDevicesJson.action";
			            $.ajax({
			                type: "POST",
			                dataType: 'json',
			                data:result,
			             		url:url,
			                success: function(data, textStatus) {
			        			gp.loadGridData(data.devices);
			        			SimpleBox.renderAll();
								$('.combobox').parent().css('position', ''); 
			        			$.unblockUI();
			                },
			                error: function(e){
			                	alert(e.responseText);
			                	}
			            });
			}
		},{gridpanel_DomStruFn:"index_gridpanel_DomStruFn",gridpanel_DomCtrlFn:"index_gridpanel_DomCtrlFn",gridpanel_ComponetFn:"index_gridpanel_ComponetFn"});
		gp.rend([{index:"id",fn:function(td){
			return td.html==""?" ":$('<input type="checkbox" name="equipmentIds" value="'+td.html+'">');
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
   	   	}},{index:"ip",fn:function(td){
   				if(td.html!="" && td.html!=" ") {
   	   				var ipStr = td.html+"";
   	   				//ipStr = ipStr.substring(2,ipStr.length-2);
   	   				var ipStr = ipStr.split(",");
   	   				if (ipStr.length > 1){
   	   					$select = $('<select id=ip'+td.rowIndex+' name="ipAddress" iconIndex="0" iconTitle="管理IP" iconClass="ico ico-right for-inline f-absolute" style="width:115px;"></select>');
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
   	   	}}]);
		
		$("#eqAll").click(function(){
			$("input[name=equipmentIds]").attr("checked", this.checked);
		});
		
		$("#options").height($("#options")[0].scrollHeight);
		
	

	$("#searchWaitId").click(function(){
		$.blockUI({message:$('#loading')});
		var resType = $(".nonce").attr("id");
		var locationId = $("#form1_location_locationId").val();
		var searchTypeWait = $("#selectId").val();
		var inputVal = $("#inputVal").val();
		var result = "searchTypeWait="+searchTypeWait+"&inputVal="+inputVal+"&location.locationId=" + locationId  + "&resType=" + resType;
         var url = "${ctx}/location/status/status!batchAddDevicesJson.action";
	            $.ajax({
	                type: "POST",
	                dataType: 'json',
	                data:result,
	             	url:url,
	                success: function(data, textStatus) {
						gp.loadGridData(data.devices);
						page.pageing(data.pageCount,1);
						SimpleBox.renderAll();
						$('.combobox').parent().css('position', ''); 
						$.unblockUI();
	                }
	            });
		});
		SimpleBox.renderAll();
		
	});
	
	
	var page = new Pagination({
	applyId: "pageover",
	listeners: {
	pageClick: function(page) {
		if(page == ""){
    		return;
    		}
	$.blockUI({message:$('#loading')});
	$("#pageIdHidden").val(page);
	var sort=$("#sortIdHidden").val();
	var sortCol=$("#sortColIdHidden").val();
	var resType = $(".nonce").attr("id");
	var locationId = $("#form1_location_locationId").val();
	var searchTypeWait = $("#selectId").val();
	var inputVal = $("#inputVal").val();
	var result = "searchTypeWait="+searchTypeWait+"&inputVal="+inputVal+"&location.locationId=" + locationId  + "&resType=" + resType+"&pageData.pageIndex=" + page  + "&orderProperty=" + sort + "&orderType=" + sortCol;
	var url = "${ctx}/location/status/status!batchAddDevicesJson.action";
	//alert(result);
	//var url="${ctx}/roomDefine/DeviceOverviewVisit!searchDeviceMethod.action";
	        $.ajax({
	            type: "POST",
	            dataType: 'json',
	    		data:result, 
	    		url: url,
	            success: function(data, textStatus) {
					gp.loadGridData(data.devices);
					SimpleBox.renderAll();
					$('.combobox').parent().css('position', ''); 
					$.unblockUI();
	            }
	        });
	    }
	}
	});
	page.pageing(pageCount,1);
$('.combobox').parent().css('position', ''); 
</script>