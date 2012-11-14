<%--  
 *************************************************************************
 * @source  : script-repositorys.jsp
 * @desc    : Mocha BSM 8.0
 *------------------------------------------------------------------------
 * VER  DATE         AUTHOR      DESCRIPTION
 * ---  -----------  ----------  -----------------------------------------
 * 1.0  2011.1.12	 huaf     	  脚本库详细页面
 * ----------- ----------  -----------------------------------------------
 * Copyright(c) 2011 mochasoft,  All rights reserved.
 *************************************************************************
--%>
<!-- WEB-INF\content\scriptmonitor\repository\script-repository.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<div class="tab-content-searchlist">
	<span id="addScriptTemplate" class="black-btn-l f-right"><span class="btn-r"><span class="btn-m"><a >添加</a></span></span></span>
    <span id="delScriptTemplate" class="black-btn-l f-right"><span class="btn-r"><span class="btn-m"><a >删除</a></span></span></span>
    <div name="isSearch">
    	<s:if test="nodeId.indexOf('-') == -1">
    	  <span class="txt-white">分类：</span>
    	  <s:select id="groupId" name="scriptTemplate.groupId" list="groups" listKey="id" listValue="name" headerKey="all" headerValue="全部"></s:select>
    	</s:if>
    	<span class="txt-white">名称：</span>	
    	<input type="text" id="serchMonitor" value="${serchMonitor}"><span id="serchMonitorBut" class="ico"></span>
   </div>
</div>
 <page:applyDecorator name="indexcirgrid">  
          <page:param name="id">tableMonitorScript</page:param>
          <page:param name="width">100%</page:param>
          <page:param name="height">100%</page:param>
          <page:param name="lineHeight">27px</page:param>
          <page:param name="tableCls">grid-black</page:param>
          <page:param name="gridhead">[
          {colId:"id", hidden:true},
          {colId:"temp", text:"<input type='checkbox' name='checkAll' id='checkAllId' style='cursor:pointer'/>"},
          {colId:"groupId", text:"脚本类型"},
          {colId:"name", text:"脚本名称"},
          {colId:"filePath", text:"脚本路径及文件名"},
          {colId:"remark", text:"备注"},
          {colId:"temp1", text:"执行"}]</page:param>
       	  <page:param name="gridcontent">${scriptsJSON}</page:param>
    </page:applyDecorator>	 
	<div id="scriptpage">
	</div>
	<input type="hidden" id="sortColId" value="${sortColumnId}">
	<input type="hidden" id="sortOrder" value="${order}">
	<input type="hidden" id="currentPageHidden" value="${page}">
<script>
	<s:if test="edit">
	//添加
	$("#addScriptTemplate").click(function(){
		addScriptTemplate(currentNodeId.split("<%=com.mocha.bsm.script.monitor.action.ScriptRepositoryTreeHelper.SPLIT_SYMBOL%>")[0]);
	});
	//删除
	$("#delScriptTemplate").click(function(){
		delScriptTemplate($("input[name=\"scriptTemplateIds\"]:checked").serialize());
	});
	
	//全选
	$("#checkAllId").click(function(){
		var $scriptTemplateIds = $("input[name=\"scriptTemplateIds\"]");
		$scriptTemplateIds.attr("checked",this.checked);
	});
	</s:if>
	var scriptTemplates = new GridPanel({id:"tableMonitorScript",
		columnWidth:{temp:5,groupId:15,name:20,filePath:30,remark:20,temp1:10},
		unit:"%",
		plugins:[SortPluginIndex],
		sortColumns:[{index:"name",sortord:"0",defSorttype:"up"},
		{index:"filePath",sortord:"1"},{index:"remark",sortord:"2"}],
		sortLisntenr:function($sort){
			$("#sortColId").val($sort.colId);
			$("#sortOrder").val($sort.sorttype);
			loadPageContent();
		}},
		{gridpanel_DomStruFn:"index_gridpanel_DomStruFn",gridpanel_DomCtrlFn:"index_gridpanel_DomCtrlFn",gridpanel_ComponetFn:"index_gridpanel_ComponetFn"});
	
	scriptTemplates.rend([{index:"name",fn:function(td){
		return td.value.id==""? "":$('<span onclick="editScriptTemplate(\''+td.value.id+'\')" style="cursor:hand;">'+td.$td.find("*").html()+'</span>');
	}},{index:"temp",fn:function(td){
		return td.value.id==""? "":$('<input type="checkbox" name="scriptTemplateIds" value="'+td.value.id+'">');
	}},{index:"temp1",fn:function(td){
		return td.value.id==""?"":$('<span onclick="inputScriptParamter(\''+td.value.id+'\')" style="cursor:pointer;"><img src="${ctxImages}/scriptmonitor/btn_zhixing.jpg" border="0"/></span>');
	}}]);
	
	//分页 	功能未实现
	var scriptpage = new Pagination({applyId:"scriptpage",listeners:{
		pageClick:function(pageValue){
			$("#currentPageHidden").val(pageValue);
			loadPageContent();
		}
	}});
	scriptpage.pageing(${pageCount},${page});
	
	function loadPageContent(){
		var nameValue = $('#serchMonitor').val();
		var groupValue = $('#groupId').val();
		if(groupValue == 'all'){
			groupValue = '';
		}
		loadContent('${nodeId}',nameValue,groupValue,$("#currentPageHidden").val(),$("#sortColId").val(),$("#sortOrder").val(),scriptTemplates,scriptpage);
	}
	
	/*查询条件，检索*/
	$("#serchMonitorBut").click(function(){
		var nameValue = $('#serchMonitor').val();
		var groupValue = $('#groupId').val();
		$("#currentPageHidden").val(""); //检索，从第一页开始
		loadPageContent();
	});
	
	//bundleTemplateNameEdit();
</script>