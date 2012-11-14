<%--  
 *************************************************************************
 * @source  : deploy-frame.jsp
 * @desc    : Mocha BSM 8.0.1
 *------------------------------------------------------------------------
 * VER  DATE         AUTHOR      DESCRIPTION
 * ---  -----------  ----------  -----------------------------------------
 * 1.0  2011.8.23	 qs     	   模型部署
 * ----------- ----------  -----------------------------------------------
 * Copyright(c) 2011 mochasoft,  All rights reserved.
 *************************************************************************
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<div id="devContent">
	<div class="margin8"><span class="ico ico-tips"></span>在此处添加或更新监控模型，自定义模型可设置模型映射关系，更新模型Logo，删除。</div> 
	<div class="tab-content-searchlist">
	<div class="margin8">
	<form id="searchCondition">
		<span id="delModel" class="black-btn-l f-right"><span class="btn-r"><span class="btn-m"><a >删除</a></span></span></span>
	    <span id="addModel" class="black-btn-l f-right"><span class="btn-r"><span class="btn-m"><a >部署</a></span></span></span>
		<select id="searchProp" name="searchProp">
			<option value="<s:text name="%{@com.mocha.bsm.modelsetting.common.Constant@MODELNAME_PROP}" />"><s:text name="%{@com.mocha.bsm.modelsetting.common.Constant@MODELNAME_PROP}" /></option>
			<option value="<s:text name="%{@com.mocha.bsm.modelsetting.common.Constant@CATEGORY_PROP}" />"><s:text name="%{@com.mocha.bsm.modelsetting.common.Constant@CATEGORY_PROP}" /></option>
			<option value="<s:text name="%{@com.mocha.bsm.modelsetting.common.Constant@DEPLOYER_PROP}" />"><s:text name="%{@com.mocha.bsm.modelsetting.common.Constant@DEPLOYER_PROP}" /></option>
		</select>
		<span>：</span><s:textfield id="searchValue" name="searchValue" searchLevel=""></s:textfield><select id="parentSelect" style="display: none;"></select><select id="childSelect" style="display: none;"></select>
		<span>部署时间：从</span><input type="text" id="startTime" name="startTime" />到</span><input type="text" id="endTime" name="endTime" /><span id="searchButton" class="ico" title="搜索"></span>
		<input type="hidden" name="pageSize" id="pageSize" value="20"/>
		<input type="hidden" name="pageNumber" id="pageNumber" value="1" defaultValue="1"/>
		<input type="hidden" name="sortColId" id="sortColId" value=""/>
		<input type="hidden" name="sortColType" id="sortColType" value=""/>
	</form>	
	</div></div>
	<form id="contentForm">
	<page:applyDecorator name="indexcirgrid">
     <page:param name="id">modelDeployGrid</page:param>
     <page:param name="width">100%</page:param>
     <page:param name="height">100%</page:param>
     <page:param name="tableCls">grid-black</page:param>
     <page:param name="gridhead">
     [{colId:"id", hidden:true},
      {colId:"parentTypeId", hidden:true},
      {colId:"ynkey", hidden:true},
      {colId:"modelId",text:"<input type='checkbox' id='checkAll' style='cursor:pointer'/>"},
      {colId:"modelName", text:"模型名称"},
      {colId:"resourceType", text:"资源类型"},
      {colId:"source", text:"来源"},
      {colId:"deployer", text:"部署人员"},
      {colId:"deployDate", text:"最近部署时间"},
      {colId:"operate", text:"操作"}]
     </page:param>
     <page:param name="gridcontent">${datas}</page:param>
   </page:applyDecorator>
   <div id="pageDeploy"/>
   </form>
</div>
<script type="text/javascript">
$(function(){
	var $startTime = $("#startTime");
	var $endTime = $("#endTime");
	var $searchProp = $("#searchProp");
	var $parentSelect = $("#parentSelect");
	var $childSelect = $("#childSelect");
	var $searchValue = $("#searchValue");
	$searchProp.change(function(){
		if($searchProp.val()=="资源类型"){
			selectChange("",$parentSelect);
			$searchValue.hide();
		}else{
			$parentSelect.hide();
			$childSelect.hide();
			$searchValue.val("").show();
		}
	});
	$parentSelect.change(function(){
		var selectValue = $parentSelect.val();
		if(selectValue!=-1){
			var data = "resCategoryGroupId="+selectValue;
			selectChange(data,$childSelect);
			$searchValue.val("").val($parentSelect.val()).attr("searchLevel","parent");
		}
	});
	$childSelect.change(function(){
		var selectValue = $childSelect.val();
		if(selectValue!=-1){
			$searchValue.val("").val($childSelect.val()).attr("searchLevel","child");
		}
	});
	$("#checkAll").click(function() {
		if($(this).attr("checked")) {
			$("[name='pageResult.modelIds']").attr("checked",'true');//全选
		}else {
			$("[name='pageResult.modelIds']").removeAttr("checked");//取消全选
		}
  	});
	$("#addModel").click(function(){
		var winObj = {};
		winObj.url="${ctx}/monitorsetting/model/modelDeploy!importModel.action";
		winObj.name="importmodel";
		winObj.width="460";
		winObj.height="180";
		winOpen(winObj);
	});
	$("#delModel").click(function(){
		var modelIds = $("input[name='pageResult.modelIds']:checked").serialize();
		if(modelIds!=""){
			var _confirm = new confirm_box({text:"是否删除模型？"});
			_confirm.setConfirm_listener(function(){
				delModelDeploy(modelIds);
				_confirm.hide();
			});
			_confirm.show();
	    }else{
	    	var _information = new information({text:"请选择一条数据。"});
			_information.show();
	    }
	});
	$startTime.click(function(){
		WdatePicker({dateFmt:'yyyy/MM/dd HH:mm:ss'});
	});
	$endTime.click(function(){
		WdatePicker({dateFmt:'yyyy/MM/dd HH:mm:ss'});
	});
	var gp = new GridPanel({id:"modelDeployGrid",
		unit:"%",
		columnWidth:{
		modelId:10,
		modelName:20,
		resourceType:20,
		source:10,
		deployer:10,
		deployDate:15,
		operate:15},
		plugins:[SortPluginIndex],
		sortColumns:[{index:"modelName",sortord:"0",defSorttype:"up"},{index:"resourceType",sortord:"1"},{index:"source",sortord:"2"},{index:"deployer",sortord:"3"},{index:"deployDate",sortord:"4"}],
		sortLisntenr:function($sort){
			var sortCol = $sort.colId;
   	    	var sortType = $sort.sorttype;
   	    	var pageNumber = $("#pageNumber").val();
   	    	var pageSize = $("#pageSize").val();
   	    	$("#sortColId").val(sortCol);
   	    	$("#sortColType").val(sortType);
   	    	var url="${ctx}/monitorsetting/model/pageQuery!handlePageQuery.action";
			$.ajax({
                type: "POST",
                dataType: 'json',
                data:"pageResult.pageNumber="+ pageNumber + "&pageResult.pageSize=" + pageSize + "&pageResult.sortType=" + sortType + "&pageResult.sortColName=" + sortCol, 
                url:url,
                success: function(data, textStatus) {
                	gp.loadGridData(data.responseInfo);
                }
            });
		}
	},{gridpanel_DomStruFn:"index_gridpanel_DomStruFn",gridpanel_DomCtrlFn:"index_gridpanel_DomCtrlFn",gridpanel_ComponetFn:"index_gridpanel_ComponetFn"});
	//为表格每一行进行渲染
	gp.rend([{index:"modelId",fn:function(td){
		var $font;
		if(td.value.id==""){
			$font=null;
		}else{
			var disabled = td.value.ynkey=="system" ? "disabled=disabled" : "";
			$font = $('<input type="checkbox" name="pageResult.modelIds" value="'+td.html+'" '+disabled+'>');
		}
		return $font;
	}},{index:"modelName",fn:function(td){
		var $font;
		if(td.value.id==""){
			$font=null;
		}else{
			$font = $('<span class="device-ico RID_'+td.value.id+'" title="'+td.html+'"></span><span title="'+td.html+'">'+td.html+'</span>');
		}
		return $font;
	}},{index:"operate",fn:function(td){
		var $font;
		if(td.value.id=="" || td.value.ynkey=="system"){
			$font=null;
		}else{
			$font = $('<span class="ico ico-t-right"></span>');
			$font.bind("click",function(event){
				var y = $(this).offset().top+5;
				var x = $(this).offset().left+5;
				var menu = new MenuContext({
			        x: x,
			        y: y,
			        width: 120,
			        plugins:[duojimnue],
			        listeners: {
			            click: function(id) {
			            }
			        }
			    });
		        if(td.value.parentTypeId!="application"){
		        	menu.addMenuItems([[
									  	{text:"模型映射配置",id:"modelRMap",listeners:{
					  						click:function(){
					  							var winObj = {};
					  							winObj.url="${ctx}/monitorsetting/model/modelDeploy!configModelMap.action?resourceId="+td.value.id+"&treeId=modelMapTree";
					  							winObj.name="configmodel";
					  							winObj.width="700";
					  							winObj.height="500";
					  							winOpen(winObj);
					  						}
					  					}},
					  					{text:"拓扑映射配置",id:"topoRMap",listeners:{
						  					click:function(){
						  						var winObj = {};
					  							winObj.url="${ctx}/monitorsetting/model/modelDeploy!configTopoMap.action?resourceId="+td.value.id+"&treeId=topoMapTree";
					  							winObj.name="configtopo";
					  							winObj.width="700";
					  							winObj.height="500";
					  							winOpen(winObj);
						  					}
						  				}},
						  				{text:"更新模型Logo",id:"modelLogo",listeners:{
						  					click:function(){
						  						var winObj = {};
						  						winObj.url="${ctx}/monitorsetting/model/modelDeploy!importLogo.action?resourceId="+td.value.id;
						  						winObj.name="updateLogo";
						  						winObj.width="460";
						  						winObj.height="180";
						  						winOpen(winObj);
						  					}
						  				}}
				    			     ]]);
				}else{
					menu.addMenuItems([[
									  	{text:"模型映射配置",id:"modelRMap",listeners:{
					  						click:function(){
					  							var winObj = {};
					  							winObj.url="${ctx}/monitorsetting/model/modelDeploy!configModelMap.action?resourceId="+td.value.id+"&treeId=modelMapTree";
					  							winObj.name="configmodel";
					  							winObj.width="700";
					  							winObj.height="500";
					  							winOpen(winObj);
					  						}
					  					}},
						  				{text:"更新模型Logo",id:"modelLogo",listeners:{
						  					click:function(){
						  						var winObj = {};
						  						winObj.url="${ctx}/monitorsetting/model/modelDeploy!importLogo.action?resourceId="+td.value.id;
						  						winObj.name="updateLogo";
						  						winObj.width="460";
						  						winObj.height="180";
						  						winOpen(winObj);
						  					}
						  				}}
				    			     ]]);
				}
			});
		}
		return $font;
	}}]);
	var pageCount = '${pageResult.pageCount}';
	var page = new Pagination({
		applyId:"pageDeploy",
		listeners:{
		pageClick:function(page){
			var sortType=$("#sortColType").val();
		    var sortCol=$("#sortColId").val();
		    var pageSize = $("#pageSize").val();
			$("#pageNumber").val(page);
		    var url="${ctx}/monitorsetting/model/pageQuery!handlePageQuery.action";
		    $.ajax({
                type: "POST",
                dataType: 'json',
                data:"pageResult.pageNumber="+ page + "&pageResult.pageSize=" + pageSize + "&pageResult.sortType=" + sortType + "&pageResult.sortColName=" + sortCol, 
                url:url,
                //请求成功后的回调函数,date:返回的json串,testStatus:状态码
                success: function(data, textStatus) {
                	gp.loadGridData(data.responseInfo);
                }
            });
		}
	}});
	page.pageing(pageCount,1);
	function delModelDeploy(ids){
		var sortType=$("#sortColType").val();
	    var sortCol=$("#sortColId").val();
	    var pageSize = $("#pageSize").val();
	    var pageNumber = $("#pageNumber").val();
	    var url="${ctx}/monitorsetting/model/modelDeploy!handleModelDelete.action";
	    $.ajax({
			url: url,
			data: ids +"&pageResult.pageNumber="+ pageNumber + "&pageResult.pageSize=" + pageSize + "&pageResult.sortType=" + sortType + "&pageResult.sortColName=" + sortCol,
			dataType: 'json',
			type: "POST",
			success: function(data){
				gp.loadGridData(data.responseInfo);
				var pageCount = data.pageResult.pageCount;
				page.pageing(pageCount,pageNumber);
				$("#checkAll").removeAttr("checked");
			}
		});
	}
	$("#searchButton").click(function(){
		var startTime =  $("#startTime").val();
		var endTime = $("#endTime").val();
		var searchValue = $searchValue.val();
		var searchProp = $searchProp.val();
		var searchLevel = $searchValue.attr("searchLevel");
		var pageSize = $("#pageSize").val();
	    var pageNumber = $("#pageNumber").attr("defaultValue");
	    var url = "${ctx}/monitorsetting/model/modelDeploy!handleConditionQuery.action";
	    if(startTime!="" && endTime!="" && startTime>endTime){
	    	var _information = new information({text : "开始时间不能大于结束时间。"});
	        _information.show();
	        return;
	    }
	    var resourceTypeLevel = "";
	    if(searchLevel!=""){
	    	resourceTypeLevel = "&pageResult.resourceTypeLevel="+searchLevel;
	    }
		$.ajax({
			url: url,
			data: "pageResult.pageNumber="+ pageNumber + "&pageResult.pageSize=" + pageSize + "&pageResult.searchProperty=" + searchProp + "&pageResult.searchValue=" + searchValue 
			+ "&pageResult.startDate=" + startTime + "&pageResult.endDate=" + endTime + resourceTypeLevel,
			dataType: 'json',
			type: "POST",
			success: function(data){
				gp.loadGridData(data.responseInfo);
				var pageCount = data.pageResult.pageCount;
				page.pageing(pageCount,1);
			}
		});
	});
	function selectChange(data,$select){
		var options = "<option value=-1>请选择</option>";
		$.ajax({
			url: "${ctx}/monitorsetting/model/modelDeploy!initResType.action",
			data: data,
			dataType: 'json',
			type: "POST",
			success: function(data){
				var typeArr = (new Function("return" + data.responseInfo))();
				if(typeArr.length>1){
					for(var i = 0; i < typeArr.length; i++){
						options += "<option value='"+typeArr[i].resTypeId+"'>" + typeArr[i].resTypeName + "</option>";
					}
				}
				$select.empty().append(options).show();
			}
		});
	}
});
function reloadParentPage(allPage){
	if(allPage){
		$.ajax({
			url: "${ctx}/monitorsetting/model/sysoidSetting.action",
			dataType: 'html',
			type: "post",
			success: function(data){
				$("#globalsettingmainright").empty().append(data);
				url = "modelDeploy!showAllDeploy.action";
				tp.loadContent(1,{url:"${ctx}/monitorsetting/model/"+url,callback:function(){$.unblockUI();}});
			}
		});
	}
	url = "modelDeploy!showAllDeploy.action";
	tp.loadContent(1,{url:"${ctx}/monitorsetting/model/"+url,callback:function(){$.unblockUI();}});
}
</script>