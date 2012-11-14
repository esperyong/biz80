<!-- WEB-INF\content\location\view\areaState.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<link href="${ctxCss}/UIComponent.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/common.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/button-module.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/portal02.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/public.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/master.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/validationEngine.jquery.css" rel="stylesheet" />
<link href="${ctx}/flash/history/history.css" />
<link href="${ctxCss}/jquery-ui/treeview.css" rel="stylesheet" type="text/css" />
<script src="${ctxJs}/jquery-1.4.2.min.js"></script>
<script src="${ctxJs}/jquery.select.js"></script>
<script src="${ctxJs}/component/cfncc.js"></script>
<script src="${ctxJs}/component/gridPanel/grid.js"></script>
<script src="${ctxJs}/component/gridPanel/cirgrid.js"></script>
<script src="${ctxJs}/component/gridPanel/indexgrid.js"></script>
<script src="${ctxJs}/component/gridPanel/page.js"></script>
<script src="${ctx}/js/component/combobox/simplebox.js"></script>
<title>区域状态分析</title>
<head>
<script type="text/javascript">
var gp;
//alert('<s:property value="statusListJson" escape="false" />');
$(document).ready(function() {
		gp = new GridPanel({id:"areaTableId",
							width:750,
							columnWidth:{resurceTypeId:30,statusId:20,equipName:110,ip:110,resurceType:70,domain:60,area:60,builder:60,floor:60,room:60,adminName:60,description:50},
							plugins:[SortPluginIndex],
							sortColumns:[],
							sortLisntenr:function($sort){
				                      $.post("gridStore.html",function(data){
				                            gp.loadGridData(data);
				                      });
							}
		},{gridpanel_DomStruFn:"index_gridpanel_DomStruFn",gridpanel_DomCtrlFn:"index_gridpanel_DomCtrlFn",gridpanel_ComponetFn:"index_gridpanel_ComponetFn"})
		.rend([{index: "resurceTypeId",
    	    fn: function(td) { // alert(td.value.hidId);
			
		    if (td.html != "") {
		    	var title = td.html;
		    	  if(!title || title=="-" || title==null || title=="null"){
		    	  	 title = "非网管设备";
		    	  }
		        $font = $('<span class="device-ico '+ title +'" title="'+title+'"/>');
                return $font;
		    }else {
	                return null;
	            }
	    }},{index:"statusId",fn:function(td){
		if(td.html==""){
		return "";
		}
			if(td.html=="a"){
				return jQuery("<span class='lamp lamp-red'></span>");
				}else{
					return jQuery("<span class='lamp lamp-gray'></span>");
					}
		}},{index:"ip",fn:function(td){
   				if(td.html!="" && td.html!=" ") {
   	   				var ipStr = td.html+"";
   	   				var ipStr = ipStr.split(",");
   	   				if (ipStr.length > 1){
   	   					$select = $('<select id=ip'+td.rowIndex+'></select>');
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
	    	return td.html==""?"":jQuery("<span class=\"ico ico-file\" title=\""+td.html+"\"></span>");
		}}]);
		SimpleBox.renderAll();
		$('.combobox').parent().css('position', ''); 
});
</script>
</head>
<body>
<div id="devContent" style="background-color: white;">
	<div style="margin-top: 5px;margin-bottom: 5px;border-bottom: #000 1px solid;padding-bottom: 5px;padding-left:8px;font-weight: bold;">
		物理位置一览&nbsp;-&nbsp;区域状态分析	
	</div>
	<div style="margin-top: 5px;margin-bottom: 5px;padding-left:8px;">
		当前区域状态异常(<span class="lamp lamp-red"></span>),由以下设备导致：	
	</div>
	<page:applyDecorator name="indexcirgrid">  
     <page:param name="id">areaTableId</page:param>
     <page:param name="width">750px</page:param>
     <page:param name="height">500px</page:param>
     <page:param name="tableCls">grid-gray</page:param>
     <page:param name="gridhead">[
     {colId:"resurceTypeId", text:""},
     {colId:"statusId", text:""},
     {colId:"equipName", text:"显示名称"},
     {colId:"ip", text:"IP地址"},
     {colId:"resurceType", text:"设备类型"},
     {colId:"domain", text:"区域"},
     {colId:"area", text:"地区"},
     {colId:"builder", text:"大楼"},
     {colId:"floor", text:"楼层"},
     {colId:"room", text:"房间"},
     {colId:"adminName", text:"用户名"},
     {colId:"description", text:"备注"}
     ]</page:param>
     <page:param name="gridcontent"><s:property value="statusListJson" escape="false" /></page:param>
   </page:applyDecorator>
</div>
</body>