<%--  
 *************************************************************************
 * @source  : deploy-map.jsp
 * @desc    : Mocha BSM 8.0.1
 *------------------------------------------------------------------------
 * VER  DATE         AUTHOR      DESCRIPTION
 * ---  -----------  ----------  -----------------------------------------
 * 1.0  2011.9.6	 qs     	   模型映射配置
 * ----------- ----------  -----------------------------------------------
 * Copyright(c) 2011 mochasoft,  All rights reserved.
 *************************************************************************
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<%@ include file="/WEB-INF/common/loading.jsp" %>
<html>
<head>
<title>${requestScope.title}</title>
<link rel="stylesheet" href="${ctxCss}/validationEngine.jquery.css" type="text/css" media="screen" title="no title" charset="utf-8" />
<link rel="stylesheet" href="${ctxCss}/public.css" type="text/css" />
<link rel="stylesheet" href="${ctxCss}/common.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="${ctxCss}/button-module.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="${ctxCss}/master.css" type="text/css" />
<link rel="stylesheet" href="${ctxCss}/jquery-ui/treeview.css" type="text/css" />
<link rel="stylesheet" href="${ctxCss}/UIComponent.css" type="text/css" />
<link rel="stylesheet" href="${ctxCss}/device-ico.css" type="text/css" />
<link rel="stylesheet" href="${ctxCss}/jquery-ui/treeview.css" type="text/css"></link>
<script type="text/javascript" src="${ctxJs}/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="${ctxJs}/component/cfncc.js"></script>
<script type="text/javascript" src="${ctxJs}/jquery.layout-1.2.0.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery.blockUI.js"></script>
<script type="text/javascript" src="${ctxJs}/component/accordionPanel/accordionLeft.js"></script>
<script type="text/javascript" src="${ctxJs}/component/panel/panel.js"></script>
<script type="text/javascript" src="${ctxJs}/component/treeView/tree.js"></script>
<script type="text/javascript" src="${ctxJs}/component/gridPanel/grid.js"></script>
<script type="text/javascript" src="${ctxJs}/component/gridPanel/indexgrid.js"></script>
<script type="text/javascript" src="${ctxJs}/component/gridPanel/page.js"></script>
<script type="text/javascript" src="${ctxJs}/component/menu/menu.js"></script>
<script type="text/javascript" src="${ctx}/js/component/popwindow/popwin.js" ></script>
<script type="text/javascript" src="${ctx}/js/jquery.blockUI.js"></script>
<script type="text/javascript" src="${ctx}/js/component/comm/winopen.js"></script>
<script type="text/javascript" src="${ctx}/js/component/treeView/tree.js"></script>
<script type="text/javascript" src="${ctx}/js/monitor/Util.js"></script>
<script type="text/javascript">
var rootMap = new Map();
var rootPropMap = new Map();
var childMap = new Map();
var childKeyMap = new Map();
$(function(){
	var $isRoot = $("#isRoot");
	var $currentNodeKey = $("#currentNodeKey");
	var $componentMapDiv = $("#componentMapDiv");
	var isTopoMap = "${requestScope.isTopoMap}";
	var $propMapDiv = $("#propMapDiv");
	if(isTopoMap!="true"){
		$propMapDiv.hide().attr("disabled","disabled");
		clearNullLine("metricMapGrid");
	}else{
		clearNullLine("metricMapGrid");
		clearNullLine("topoMapGrid");
	}
	$componentMapDiv.hide().attr("disabled","disabled");
	var gp = new GridPanel({id:"metricMapGrid",
		unit:"%",
		columnWidth:{
		commonMetricName:50,
		modelMetricName:50}
	},{gridpanel_DomStruFn:"index_gridpanel_DomStruFn",gridpanel_DomCtrlFn:"index_gridpanel_DomCtrlFn",gridpanel_ComponetFn:"index_gridpanel_ComponetFn"});
	
	var topoGrid = new GridPanel({id:"topoMapGrid",
		unit:"%",
		columnWidth:{
		commonPropName:40,
		modelPropName:60}
	},{gridpanel_DomStruFn:"index_gridpanel_DomStruFn",gridpanel_DomCtrlFn:"index_gridpanel_DomCtrlFn",gridpanel_ComponetFn:"index_gridpanel_ComponetFn"});
	
	topoGrid.rend([{index:"modelPropName",fn:function(td){
		var select;
		if(td.value.commonPropId==""){
			select = null;
		}else{
			var metricArr = "";
			if(td.html!=""){
				metricArr = (new Function("return" + td.html))();
			}
			if(metricArr.length > 0){
				var selectValue;
				var key;
				var nodeKey = $currentNodeKey.val();
				var selected;
				if($isRoot.val()=="true"){
					key = td.value.commonPropId;
					selectValue = rootPropMap.get(key);
				}else{
					key = td.value.commonPropId + nodeKey + "_modelProp";
					selectValue = childMap.get(key);
				}
				select = "<select name='modelChildProp' commonPropId='"+td.value.commonPropId+"'>";
				select += "<option value=-1>请选择属性</option>";
				for(var i = 0; i < metricArr.length; i++){
					if(selectValue==metricArr[i].modelPropId){
						selected = "selected";
					}else if(td.value.modelPropId!="" && td.value.modelPropId==metricArr[i].modelPropId){
						if($isRoot.val()=="true"){
							rootPropMap.put(td.value.modelPropId,metricArr[i].modelPropId);
						}else{
							var nodeKey = $currentNodeKey.val();
							childMap.put(td.value.modelPropId+nodeKey+"_modelProp",metricArr[i].modelPropId);
						}
						selected = "selected";
					}else{
						selected = "";
					}
					select += "<option value='"+metricArr[i].modelPropId+"' "+selected+">" + metricArr[i].modelPropName + "</option>";
				}
				select += "</select>";
			}else if($isRoot.val()=="false"){
				select = "<select name='modelChildProp' commonPropId='"+td.value.commonPropId+"'>";
				select += "<option value=-1>请选择属性</option>";
				select += "</select>";
			}
		}
		return select;	
	}}]);
	
	gp.rend([{index:"modelMetricName",fn:function(td){
		var select;
		if(td.value.commonMetricId==""){
			select = null;
		}else{
			var metricArr = "";
			if(td.html!=""){
				metricArr = (new Function("return" + td.html))();
			}
			if(metricArr.length > 0){
				var selectValue;
				var key;
				var nodeKey = $currentNodeKey.val();
				var selected;
				if($isRoot.val()=="true"){
					key = td.value.commonMetricId;
					selectValue = rootMap.get(key);
				}else{
					key = td.value.commonMetricId + nodeKey + "_modelMetric";
					selectValue = childMap.get(key);
				}
				select = "<select name='modelChildMetric' commonMetricId='"+td.value.commonMetricId+"'>";
				select += "<option value=-1>请选择指标</option>";
				for(var i = 0; i < metricArr.length; i++){
					if(selectValue==metricArr[i].modelMetricId){
						selected = "selected";
					}else if(td.value.modelMetricId!="" && td.value.modelMetricId==metricArr[i].modelMetricId){
						if($isRoot.val()=="true"){
							rootMap.put(td.value.commonMetricId,metricArr[i].modelMetricId);
						}else{
							var nodeKey = $currentNodeKey.val();
							childMap.put(td.value.commonMetricId+nodeKey+"_modelMetric",metricArr[i].modelMetricId);
						}
						selected = "selected";
					}else{
						selected = "";
					}
					select += "<option value='"+metricArr[i].modelMetricId+"' "+selected+">" + metricArr[i].modelMetricName + "</option>";
				}
				select += "</select>";
			}else if($isRoot.val()=="false"){
				select = "<select name='modelChildMetric' commonMetricId='"+td.value.commonMetricId+"'>";
				select += "<option value=-1>请选择指标</option>";
				select += "</select>";
			}
		}
		return select;	
	}}]);
	
	var treeId = $("#treeId").val();
	var tree = new Tree({
		id : treeId,
		listeners : {
			nodeClick : function(node,event) {
				if(isTopoMap!="true"){
					modelTreeNodeClickFunction(node);	
				}else{
					topoTreeNodeClickFunction(node);
				}
			}
		}
	});
	var rootNodeId = tree.getRoot().getFirstChild().getId();
	
	var $modelChildsType = $("#modelChildsType");
	$modelChildsType.change(function(){
		if(isTopoMap!="true"){
			modelSelectNodeClickFunction();	
		}else{
			topoSelectNodeClickFunction();
		}
	});
	
	selectChange();
	
	$("#app_button").click(function(){
		if(isTopoMap!="true"){
			submitData(true);	
		}else{
			submitDataForTopo(true);
		}
	});
	
	$("#confirm_button").click(function(){
		if(isTopoMap!="true"){
			submitData(false);	
		}else{
			submitDataForTopo(false);
		}
		window.close();
	});
	
	$("#win-close").click(function(){
		window.close();
	});
	
	$("#cancel_button").click(function(){
		window.close();
	});
	
	function updateSelectContent(content,contentforProp){
		$("#metricMapGrid").find("select").each(function(index){
			var self = $(this);
			self.empty();
			self.append(content);
		});
		if(isTopoMap=="true"){
			$("#topoMapGrid").find("select").each(function(index){
				var self = $(this);
				self.empty();
				self.append(contentforProp);
			});
		}
	}
	
	function clearNullLine(tableid){
		$("#"+tableid).find("td").each(function(){
			var self = $(this);
			if(self.children().size()==0){
				self.parent().remove();
			}
		});
	}
	
	function selectChange(){
		var $modelChildMetric = $("select[name='modelChildMetric']");
		$modelChildMetric.bind("change",function(){
			var self = $(this);
			var selectValue = self.val();
			var commonMetricId = self.attr("commonMetricId");
			if(selectValue!=-1){
				if($isRoot.val()=="true"){
					rootMap.put(commonMetricId,selectValue);
				}else{
					var nodeKey = $currentNodeKey.val();
					childMap.put(commonMetricId+nodeKey+"_modelMetric",selectValue);
				}
			}else{
				if($isRoot.val()=="true"){
					rootMap.remove(commonMetricId);
				}else{
					var nodeKey = $currentNodeKey.val();
					childMap.remove(commonMetricId+nodeKey+"_modelMetric");
				}
			}
		});
		if(isTopoMap=="true"){
			var $modelChildProp = $("select[name='modelChildProp']");
			$modelChildProp.bind("change",function(){
				var self = $(this);
				var selectValue = self.val();
				var commonPropId = self.attr("commonPropId");
				if(selectValue!=-1){
					if($isRoot.val()=="true"){
						rootPropMap.put(commonPropId,selectValue);
					}else{
						var nodeKey = $currentNodeKey.val();
						childMap.put(commonPropId+nodeKey+"_modelProp",selectValue);
					}
				}else{
					if($isRoot.val()=="true"){
						rootPropMap.remove(commonPropId);
					}else{
						var nodeKey = $currentNodeKey.val();
						childMap.remove(commonPropId+nodeKey+"_modelProp");
					}
				}
			});
		}
	}
	
	function submitData(isload){
		if(isload){
			$.blockUI({message:$('#loading')});
		}
		var rootArr = rootMap.arr;
		var temp = [];
		var resourceId = $("#resourceId").val();
		temp.push("<input type='hidden' name='resourseMaps[0].isRoot' value='true'/>");
		temp.push("<input type='hidden' name='resourseMaps[0].resourseId' value='"+rootNodeId+"'/>");//构造主资源时需要的资源类别组id
		temp.push("<input type='hidden' name='resourseMaps[0].modelcomponentId' value='"+resourceId+"'/>");//构造主资源时需要的模型id
		for(var i=0;i<rootArr.length;i++){
			temp.push("<input type='hidden' name='resourseMaps[0].metricMaps["+i+"].commonMetricId' value='"+rootArr[i].key+"'/>");
			temp.push("<input type='hidden' name='resourseMaps[0].metricMaps["+i+"].modelMetricId' value='"+rootArr[i].value+"'/>");
		}
		var childKeyArr = childKeyMap.arr;
		var childArr = childMap.arr;
		for(var i=0;i<childKeyArr.length;i++){
			temp.push("<input type='hidden' name='resourseMaps["+(i+1)+"].resourseId' value='"+childKeyArr[i].key+"'/>");//构造子资源时需要的资源类别id
			var childKey = childKeyArr[i].key+"_modelComponent";
			var metrickey = childKeyArr[i].key+"_modelMetric";
			var k = 0;
			for(var j=0;j<childArr.length;j++){
				var key = childArr[j].key;
				if(key.indexOf(childKey)!=-1){
					temp.push("<input type='hidden' name='resourseMaps["+(i+1)+"].modelcomponentId' value='"+childArr[j].value+"'/>");//构造子资源时需要的模型组件id
				}else if(key.indexOf(metrickey)!=-1){
					temp.push("<input type='hidden' name='resourseMaps["+(i+1)+"].metricMaps["+k+"].commonMetricId' value='"+key.substring(0,key.indexOf(metrickey))+"'/>");
					temp.push("<input type='hidden' name='resourseMaps["+(i+1)+"].metricMaps["+(k++)+"].modelMetricId' value='"+childArr[j].value+"'/>");
				}
			}
		}
		$("#modelMapForm").empty().append(temp.join(""));
		var ajaxParam = $("#modelMapForm").serialize();
		$.ajax({
            type: "POST",
            dataType: 'json',
            data: ajaxParam, 
            url: "${ctx}/monitorsetting/model/modelDeploy!updateModelMap.action",
            success: function(data, textStatus) {
            	if(isload){
            		if(data.responseInfo=="success"){
                		$.unblockUI();
                	}
            	}
            },
            error:function(msg) {
				alert(msg);
		    }
        });
	}
	
	function submitDataForTopo(isload){
		if(isload){
		$.blockUI({message:$('#loading')});
		}
		var temp = [];
		var rootArr = rootMap.arr;
		var resourceId = $("#resourceId").val();
		temp.push("<input type='hidden' name='resourseMaps[0].isRoot' value='true'/>");
		temp.push("<input type='hidden' name='resourseMaps[0].modelcomponentId' value='"+resourceId+"'/>");
		for(var i=0;i<rootArr.length;i++){
			temp.push("<input type='hidden' name='resourseMaps[0].metricMaps["+i+"].commonMetricId' value='"+rootArr[i].key+"'/>");
			temp.push("<input type='hidden' name='resourseMaps[0].metricMaps["+i+"].modelMetricId' value='"+rootArr[i].value+"'/>");
		}
		var rootPropArr = rootPropMap.arr;
		for(var i=0;i<rootPropArr.length;i++){
			temp.push("<input type='hidden' name='resourseMaps[0].propMaps["+i+"].commonPropId' value='"+rootPropArr[i].key+"'/>");
			temp.push("<input type='hidden' name='resourseMaps[0].propMaps["+i+"].modelPropId' value='"+rootPropArr[i].value+"'/>");
		}
		var childArr = childMap.arr;
		var j = 0,k = 0;
		var propKey = "_modelProp";
		var metrickey = "_modelMetric";
		var childId = $modelChildsType.val();
		if(childId!=-1){
			temp.push("<input type='hidden' name='resourseMaps[1].modelcomponentId' value='"+childId+"'/>");
		}
		for(var i=0;i<childArr.length;i++){
			var key = childArr[i].key;
			if(key.indexOf(metrickey)!=-1){
				temp.push("<input type='hidden' name='resourseMaps[1].metricMaps["+j+"].commonMetricId' value='"+key.substring(0,key.indexOf(metrickey))+"'/>");
				temp.push("<input type='hidden' name='resourseMaps[1].metricMaps["+(j++)+"].modelMetricId' value='"+childArr[i].value+"'/>");
			}else if(key.indexOf(propKey)!=-1){
				temp.push("<input type='hidden' name='resourseMaps[1].propMaps["+k+"].commonPropId' value='"+key.substring(0,key.indexOf(propKey))+"'/>");
				temp.push("<input type='hidden' name='resourseMaps[1].propMaps["+(k++)+"].modelPropId' value='"+childArr[i].value+"'/>");
			}
		}
		$("#modelMapForm").empty().append(temp.join(""));
		var ajaxParam = $("#modelMapForm").serialize();
		$.ajax({
            type: "POST",
            dataType: 'json',
            data: ajaxParam, 
            url: "${ctx}/monitorsetting/model/modelDeploy!updateTopoMap.action",
            success: function(data, textStatus) {
            	if(isload){
            		if(data.responseInfo=="success"){
                		$.unblockUI();
                	}
            	}
            },
            error:function(msg) {
				alert(msg);
		    }
        });
	}
	
	function modelTreeNodeClickFunction(node){
		var resourceId = $("#resourceId").val();
		var data = "resourceId="+resourceId;
		$componentMapDiv.hide().attr("disabled","disabled");
		$isRoot.val("true");
		if(node.isLeaf()){
			$currentNodeKey.val(node.getId());
			$componentMapDiv.show().removeAttr("disabled");
			$("#componentType").html(node.getText());
			$isRoot.val("false");
			childKeyMap.put(node.getId(),node.getId());
			$modelChildsType.val(-1);
			var resourceChildId = "";
			$.ajax({
	            type: "POST",
	            dataType: 'json',
	            data: "resourceId="+resourceId+"&resourceTypeId="+node.getId(), 
	            url:"${ctx}/monitorsetting/model/modelDeploy!queryModelComponentMap.action",
	            success: function(data, textStatus) {
	            	var selectValue = data.responseInfo;
					if(selectValue!=""){
						var nodeKey = $currentNodeKey.val();
						childMap.put(selectValue+nodeKey+"_modelComponent",selectValue);
					}
					$modelChildsType.find("option").each(function(){
						var self = $(this);
						var nodeKey = $currentNodeKey.val();
						var key = self.val() + nodeKey + "_modelComponent";
						if(childMap.get(key)!=null){
							self.attr("selected","selected");
							resourceChildId = "&resourceChildId="+self.val();
						}
					});
					data = "resourceId="+resourceId+"&resourceTypeId="+node.getId()+resourceChildId;
					ajaxLoad(data);
	            }
	        });
		}else{
			ajaxLoad(data);
		}
	}
	
	function ajaxLoad(data){
		$.ajax({
            type: "POST",
            dataType: 'json',
            data: data, 
            url:"${ctx}/monitorsetting/model/modelDeploy!queryModelMap.action",
            success: function(data, textStatus) {
            	gp.loadGridData(data.responseInfo);
            	clearNullLine("metricMapGrid");
            	selectChange();
            }
        });
	}
	
	function topoTreeNodeClickFunction(node){
		$componentMapDiv.hide().attr("disabled","disabled");
		$isRoot.val("true");
		var resourceId = $("#resourceId").val();
		var data = "isRoot="+$isRoot.val()+"&resourceId="+resourceId;
		if(node.isLeaf()){
			$componentMapDiv.show().removeAttr("disabled");
			$("#componentType").html(node.getText());
			$isRoot.val("false");
			var selectValue = $modelChildsType.val();
			var resourceChildId = "";
			if(selectValue!=-1){
				resourceChildId = "&resourceChildId="+selectValue;
			}
			data = "resourceId="+resourceId+resourceChildId;
		}
		$.ajax({
            type: "POST",
            dataType: 'json',
            data: data, 
            url:"${ctx}/monitorsetting/model/modelDeploy!queryTopoMap.action",
            success: function(data, textStatus) {
            	gp.loadGridData(data.responseInfo);
            	topoGrid.loadGridData(data.propResponseInfo);
            	clearNullLine("metricMapGrid");
        		clearNullLine("topoMapGrid");
            	selectChange();
            }
        });
	}
	
	function modelSelectNodeClickFunction(){
		var options = "<option value=-1>请选择指标</option>";
		var selectValue = $modelChildsType.val();
		if(selectValue!=-1){
			var nodeKey = $currentNodeKey.val();
			childMap.put(selectValue+nodeKey+"_modelComponent",selectValue);
			$.ajax({
                type: "POST",
                dataType: 'json',
                data:"resourceId="+selectValue, 
                url:"${ctx}/monitorsetting/model/modelDeploy!queryModelMetricById.action",
                success: function(data, textStatus) {
                	var metricArr = (new Function("return" + data.responseInfo))();
                	if(metricArr.length > 1){
                		for(var i = 0; i < metricArr.length; i++){
                    		options += "<option value='"+metricArr[i].modelMetricId+"'>" + metricArr[i].modelMetricName + "</option>";
        				}
                	}else{
                		options += data.responseInfo;
                	}
                	updateSelectContent(options);
                }
            });	
		}
		updateSelectContent(options);
	}
	
	function topoSelectNodeClickFunction(){
		var options = "<option value=-1>请选择指标</option>";
		var optionsforProp = "<option value=-1>请选择属性</option>";
		var selectValue = $modelChildsType.val();
		if(selectValue!=-1){
			$.ajax({
                type: "POST",
                dataType: 'json',
                data:"resourceId="+selectValue+"&isTopoMap=true", 
                url:"${ctx}/monitorsetting/model/modelDeploy!queryModelMetricById.action",
                success: function(data, textStatus) {
                	var metricArr = (new Function("return" + data.responseInfo))();
                	if(metricArr.length > 1){
                		for(var i = 0; i < metricArr.length; i++){
                    		options += "<option value='"+metricArr[i].modelMetricId+"'>" + metricArr[i].modelMetricName + "</option>";
        				}
                	}else{
                		options += data.responseInfo;
                	}
                	var propArr = (new Function("return" + data.propResponseInfo))();
                	if(propArr.length > 1){
                		for(var i = 0; i < propArr.length; i++){
                			optionsforProp += "<option value='"+propArr[i].modelPropId+"'>" + propArr[i].modelPropName + "</option>";
        				}
                	}else{
                		optionsforProp += data.propResponseInfo;
                	}
                	updateSelectContent(options,optionsforProp);
                }
            });
		}
		updateSelectContent(options,optionsforProp);
	}
	
});
</script>
</head>
<body>
<page:applyDecorator name="popwindow"  title="${requestScope.title}">
    <page:param name="width">690px;</page:param>
    <page:param name="height">440px;</page:param>
    <page:param name="style">overflow:hidden;</page:param>
	<page:param name="topBtn_index_1">1</page:param>
	<page:param name="topBtn_id_1">win-close</page:param>
	<page:param name="topBtn_css_1">win-ico win-close</page:param>
	<page:param name="topBtn_title_1">关闭</page:param>
    <page:param name="bottomBtn_index_1">1</page:param>
	<page:param name="bottomBtn_id_1">confirm_button</page:param>
	<page:param name="bottomBtn_text_1">确定</page:param>
	<page:param name="bottomBtn_index_2">2</page:param>
	<page:param name="bottomBtn_id_2">cancel_button</page:param>
	<page:param name="bottomBtn_text_2">取消</page:param>
	<page:param name="bottomBtn_index_3">3</page:param>
	<page:param name="bottomBtn_id_3">app_button</page:param>
	<page:param name="bottomBtn_text_3">应用</page:param>
    <page:param name="content">
		<div style="width:200px;height:420px;overflow-y:auto;" class="margin5 left grayborder">
		${responseInfo}
		</div>
		<div style="height:420px;overflow-y:auto;" class="margin5 fold-blue grayborder bg f-relative">
		<form id="modelMapForm"></form>
		<input type="hidden" name="resourceId" id="resourceId" value="${requestScope.resourceId}" />
		<input type="hidden" name="treeId" id="treeId" value="${requestScope.treeId}" />
		<input type="hidden" name="isRoot" id="isRoot" value="true"/>
		<input type="hidden" name="currentNodeKey" id="currentNodeKey" value="" />
		<div id="componentMapDiv">
		<div class="h1" style="background: #f2f2f2;">组件类型映射</div>
		<ul class="fieldlist-n">
		<li><span class="field">组件类型</span>：<span class="field" id="componentType"></span></li>
		<li><span class="field">模型组件名称</span>：
		<select id="modelChildsType">
		<option value=-1>请选择</option>
		<s:iterator value="resourseMaps">
			<option value="${modelcomponentId}">${modelcomponentName}</option>
		</s:iterator>
		</select></li>
		</ul>
		</div>
		<div class="h1" style="background: #f2f2f2;">指标映射</div>
		<div class="margin8">
		<page:applyDecorator name="indexcirgrid">
	     <page:param name="id">metricMapGrid</page:param>
	     <page:param name="width">100%</page:param>
	     <page:param name="height">100%</page:param>
	     <page:param name="tableCls">grid-black</page:param>
	     <page:param name="gridhead">
	     [{colId:"commonMetricId", hidden:true},
	      {colId:"modelMetricId", hidden:true},
	      {colId:"commonMetricName", text:"公有指标名称"},
	      {colId:"modelMetricName", text:"模型指标名称"}]
	     </page:param>
	     <page:param name="gridcontent">${datas}</page:param>
	    </page:applyDecorator>
		</div>
		<div id="propMapDiv">
		<div class="h1" style="background: #f2f2f2;">属性映射</div>
		<div class="margin8">
		<page:applyDecorator name="indexcirgrid">
	     <page:param name="id">topoMapGrid</page:param>
	     <page:param name="width">100%</page:param>
	     <page:param name="height">100%</page:param>
	     <page:param name="tableCls">grid-black</page:param>
	     <page:param name="gridhead">
	     [{colId:"commonPropId", hidden:true},
	      {colId:"modelPropId", hidden:true},
	      {colId:"commonPropName", text:"属性"},
	      {colId:"modelPropName", text:"模型指标名称"}]
	     </page:param>
	     <page:param name="gridcontent">${propDatas}</page:param>
	    </page:applyDecorator>
		</div>
		</div>
		</div>
	</page:param>
</page:applyDecorator>
</body>
</html>