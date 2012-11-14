<!-- WEB-INF\content\location\relation\devices.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html>
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<%@ include file="/WEB-INF/common/loading.jsp" %>
<link href="${ctxCss}/UIComponent.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/common.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/button-module.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/portal02.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/public.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/master.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/validationEngine.jquery.css" rel="stylesheet" />
<link href="${ctx}/flash/history/history.css" />
<script src="${ctxJs}/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="${ctxJs}/component/plugins/jquery.ui.core.js"></script>
<script type="text/javascript" src="${ctxJs}/component/plugins/jquery.ui.widget.js"></script>
<script type="text/javascript" src="${ctxJs}/component/plugins/jquery.ui.mouse.js"></script>
<script type="text/javascript" src="${ctxJs}/component/plugins/jquery.ui.draggable.js"></script>
<script type="text/javascript" src="${ctxJs}/jquery.layout-1.2.0.js"></script>
<script src="${ctxJs}/jquery.select.js"></script>
<script type="text/javascript" src="${ctxJs}/component/cfncc.js"></script>
<script type="text/javascript" src="${ctxJs}/component/tabPanel/tab.js"></script>
<script type="text/javascript" src="${ctxJs}/component/panel/panel.js"></script>
<script type="text/javascript" src="${ctxJs}/component/gridPanel/grid.js"></script>
<script type="text/javascript" src="${ctxJs}/component/gridPanel/indexgrid.js"></script>
<script type="text/javascript" src="${ctxJs}/component/gridPanel/page.js"></script>
<script type="text/javascript" src="${ctxJs}/component/menu/menu.js"></script>
<script type="text/javascript" src="${ctxJs}/component/comm/winopen.js"></script>
<script type="text/javascript" src="${ctxJs}/monitor/Util.js"></script>
<!-- 
<script type="text/javascript" src="/pureportal/js/monitor/ResourceUtil.js"></script> -->
<script type="text/javascript" src="${ctxJs}/component/toast/Toast.js"></script>
<script type="text/javascript" src="${ctxJs}/component/popwindow/popwin.js"></script>
<script type="text/javascript" src="${ctxJs}/component/combobox/simplebox.js"></script>
<script src="${ctxJs}/jquery.blockUI.js" type="text/javascript"></script>

<title>关联设备</title>
<script type="text/javascript">
	var pages;
	var gp;
	var panel;
	var pageCount = '<s:property value="pageCount" />';
	$(document).ready(function() {

		gp = new GridPanel({id:"tableId",
							width:770,
							columnWidth:{see:160,wallNumber:90,workNumber:90,equipNumber:90,ip:120,mac:130,description:50},
							plugins:[SortPluginIndex],
							sortColumns:[{index:"ip",sortord:"0",defSorttype:"up"}],
							sortLisntenr:function($sort){
								$.blockUI({message:$('#loading')});
								var resType = "";
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
							        			gp.loadGridData(data.devices);
												SimpleBox.renderAll();
												$('.combobox').parent().css('position', ''); 
							        			$.unblockUI();
							                }
							            });
							}
		},{gridpanel_DomStruFn:"index_gridpanel_DomStruFn",gridpanel_DomCtrlFn:"index_gridpanel_DomCtrlFn",gridpanel_ComponetFn:"index_gridpanel_ComponetFn"});
		gp.rend([{index:"see",fn:function(td){
			var allPath = td.value.domain;
			if(td.value.builder!="")allPath+="/"+td.value.builder;
			if(td.value.area!="")	allPath+="/"+td.value.area;
			if(td.value.floor!="")	allPath+="/"+td.value.floor;
			if(td.value.room!="")	allPath+="/"+td.value.room;
	    	return "<span title='"+allPath+"' style='width:100%;height:21px;display:inline-block'>"+allPath+"</span>";
		}},{index:"ip",fn:function(td){
   				if(td.html!="" && td.html!=" ") {
   	   				var ipStr = td.html+"";
   	   				//ipStr = ipStr.substring(2,ipStr.length-2);
   	   				var ipStr = ipStr.split(",");
   	   				if (ipStr.length > 1){
   	   					$select = $('<select id=ip'+td.rowIndex+' name="ipAddress"  iconIndex="0" iconTitle="管理IP" iconClass="combox_ico_select f-absolute" style="width:110px;"></select>');
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
		}}]);
		/*
		$("#search").click(function(){
			
			$("#searchCondition").submit();
		});
		*/

		$("#search").click(function(){
			$.blockUI({message:$('#loading')});
			var resType = "";
			var locationId = "${location.locationId}";
			var result =  $("#searchCondition").serialize()+"&location.locationId=" + locationId  + "&resType=" + resType;
			 var url = "${ctx}/location/relation/device!pageDatas.action";
	            $.ajax({
	                type: "POST",
	                dataType: 'json',
	                data:result,
	             	url:url,
	                success: function(data, textStatus) {
						gp.loadGridData(data.devices);
						pages.pageing(data.pageCount,1);
						SimpleBox.renderAll();
						$('.combobox').parent().css('position', ''); 
						$.unblockUI();
	                }
	            });
		});
		
		pages = new Pagination({applyId:"pagination",listeners: {
	    pageClick: function(page) {
	    	if(page == ""){
	    		return;
	    		}
		$.blockUI({message:$('#loading')});
		$("#pageIdHidden").val(page);
	    var sort=$("#sortIdHidden").val();
	    var sortCol=$("#sortColIdHidden").val();
	    var resType ="";
		var locationId = "${location.locationId}";
	    var result =  $("#searchCondition").serialize()+"&location.locationId=" + locationId +"&resType=" + resType+"&pageData.pageIndex=" + page  + "&orderProperty=" + sort + "&orderType=" + sortCol;
	    var url = "${ctx}/location/relation/device!pageDatas.action";
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
	              },error: function(e){
	              	alert(e.responseText)
	              	}
	            });
	        }
	    }});

		pages.pageing(pageCount,1);
		SimpleBox.renderAll();
		//$('.combobox').parent().css('position', ''); 
	});
	

//$('.combobox').parent().css('position', ''); 
</script>
</head>

<body>
<div id="devContent">
	<div style="overflow:hidden;" >
	<form id="searchCondition">
				<!-- 
		<s:hidden name="location.locationId"/>
		<s:hidden name="resType"/>
		<s:select name="searchCondition.condition" list="#{'equipName':'设备名称', 'ip':'设备IP', 'equipNumb':'设备号' }"></s:select> -->

		<s:select name="searchCondition.condition" list="#{'ip':'设备IP', 'equipNumber':'设备号' }"></s:select>
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
     <page:param name="width">770px</page:param>
     <page:param name="linenum">${pageData.pageSize}</page:param>
     <page:param name="lineHeight">10px</page:param>
     <page:param name="height">280px</page:param>
     <page:param name="tableCls">grid-gray</page:param>
     <page:param name="gridhead">[
     {colId:"domain", text:"",hidden:true},
     {colId:"area", text:"",hidden:true},
     {colId:"builder", text:"",hidden:true},
     {colId:"floor", text:"",hidden:true},
     {colId:"room", text:"",hidden:true},
     {colId:"id", text:"",hidden:true},
     {colId:"see", text:"所属区域"},
     {colId:"wallNumber", text:"墙面端口号"},
     {colId:"workNumber", text:"工位号"},
     {colId:"equipNumber", text:"设备号"},
     {colId:"ip", text:"设备IP"},
     {colId:"mac", text:"MAC地址"},
     {colId:"description", text:"备注"}]</page:param>
     <page:param name="gridcontent">${devices}</page:param>
   </page:applyDecorator>
   <div id="pagination" style="width:100%"></div>
</div>

</body>
</html>