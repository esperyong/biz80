<!-- WEB-INF\content\location\relation\selectDevices.jsp -->
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
<form id="searchCondition">
	<input type="hidden" id="form_unRelation" name="unRelation"/>
	<input type="hidden" id="sortIdHidden" name="sortIdHidden" value="ip" />
	<input type="hidden" id="sortColIdHidden" name="sortColIdHidden" value="ASC" />
	<input type="hidden" id="pageIdHidden" value="<s:property value='pageData.pageIndex'/>" />
</form>
<div class="" style="heigth:420px;margin:5px;" >	
	<div class="left-n">
	  <div class="bold">待选资源</div>
	  <div class="gray-border">
		<div class="h1">
		  	<select name="searchTypeWait" id="selectId">
		  		<option value="ip">IP地址</option>
		  		<option value="equipName">设备名称</option>
		  		<option value="resurceType">设备类型</option>
		  	</select><span>：</span>
		  	<span>
		  		<input type="text" name="inputVal" id="inputVal"/>
		  	</span>
		  	<span class="ico ico-select" id="searchWaitId"></span>
		  	<!-- 
		  		<input type="checkbox" name="selectResult" id="selectResult">选中结果
		  		 -->
		  </div>
	  	<page:applyDecorator name="indexcirgrid">  
	     <page:param name="id">options</page:param>
	     <page:param name="width">455px</page:param>
	     <page:param name="linenum">15</page:param>
	     <page:param name="height">410px</page:param>
	     <page:param name="tableCls">grid-gray</page:param>
	     <page:param name="gridhead">[{colId:"id", hidden:true},{colId:"ip", hidden:true},{colId:"mac", hidden:true},{colId:"equipName", hidden:true},{colId:"equipType", hidden:true},{colId:"adminName", hidden:true},{colId:"workNumber", hidden:true},{colId:"wallNumber", hidden:true},{colId:"upPort", hidden:true},{colId:"area", text:""},{colId:"dept", text:"设备IP"},{colId:"description", text:"MAC地址"},{colId:"builder", text:"设备名称"},{colId:"resurceType", text:"设备类型"}]</page:param>
	     <page:param name="gridcontent">${devices }</page:param>
	    </page:applyDecorator>
	    <div id="pagination" style="width:465px"></div>
	  </div>
	</div>
</div>

<script type="text/javascript">
	var toast  = null;
	var pageCount = '<s:property value="pageCount" />';
	var gp;
	$("#form_unRelation").val($("#unRelation").val());
	//表单验证
	$(document).ready(function() {
		
		gp = new GridPanel({id:"options",
			width:440,
			columnWidth:{area:20,dept:110,description:140,builder:80,resurceType:90},
			plugins:[SortPluginIndex],
			sortColumns:[{index:"dept",sortord:"0",defSorttype:"up"}],
			sortLisntenr:function($sort){
				$.blockUI({message:$('#loading')});
				var resType = $(".nonce").attr("id");
				var locationId = "${location.locationId}";
				
					var sort="ip";
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
		         var url = "${ctx}/location/relation/device!selectDevicesJson.action";
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
			                },error: function(e){
							//alert(e.responseText);
							}
			            });
			}
			},{gridpanel_DomStruFn:"index_gridpanel_DomStruFn",gridpanel_DomCtrlFn:"index_gridpanel_DomCtrlFn",gridpanel_ComponetFn:"index_gridpanel_ComponetFn"})
		gp.rend([{index:"area",fn:function(td){
			return td.value.id==""?" ":$('<input type="radio" name="equipmentIds">').click(function(){
				returnObject.id=td.value.id;
				returnObject.ip=td.value.ip;
				returnObject.mac=td.value.mac;
				returnObject.equipName=td.value.equipName;
				returnObject.equipType=td.value.equipType;
				returnObject.resurceType=td.value.resurceType;
				returnObject.adminName=td.value.adminName;
				returnObject.workNumber=td.value.workNumber;
				returnObject.wallNumber=td.value.wallNumber;
				returnObject.upPort=td.value.upPort;
			});
		}},{index:"builder",fn:function(td){
			return td.value.equipName==""?"":"<span title='"+td.value.equipName+"' style='width:100%'>"+td.value.equipName+"</span>";
		}},{index:"dept",fn:function(td){
   				if(td.value.ip!="" && td.value.ip!=" ") {
   	   				var ipStr = td.value.ip+"";
   	   				//ipStr = ipStr.substring(2,ipStr.length-2);
   	   				var ipStr = ipStr.split(",");
   	   				if (ipStr.length > 1){
   	   					$select = $('<select id=ip'+td.rowIndex+' style="width:110px;"></select>');
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
   				if(td.value.mac!="" && td.value.mac!=" ") {
   	   				var macStr = td.value.mac+"";
   	   				//ipStr = ipStr.substring(2,ipStr.length-2);
   	   				var macStr = macStr.split(",");
   	   				if (macStr.length > 1){
   	   					$select = $('<select id=imac'+td.rowIndex+' style="width:130px;"></select>');
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
   	   	}}]);
		
		// 设置左的宽度
		$(".left-n").width(480);

		$("#searchWaitId").click(function(){
			$.blockUI({message:$('#loading')});
			var resType = $(".nonce").attr("id");
			var locationId = "${location.locationId}";
			var searchTypeWait = $("#selectId").val();
			var inputVal = $("#inputVal").val();
			var result =  $("#searchCondition").serialize()+"&searchTypeWait="+searchTypeWait+"&inputVal="+inputVal+"&location.locationId=" + locationId  + "&resType=" + resType;
	         var url = "${ctx}/location/relation/device!selectDevicesJson.action";
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
		$('.combobox').parent().css('position', '');
	});
	var page = new Pagination({applyId:"pagination",listeners: {
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
	    var url = "${ctx}/location/relation/device!selectDevicesJson.action";
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
	    }});
		page.pageing(pageCount,1);
		SimpleBox.renderAll();
		$('.combobox').parent().css('position', '');
</script>