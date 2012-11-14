<%--  
 *************************************************************************
 * @source  : sysoid-page.jsp
 * @desc    : Mocha BSM 8.0
 *------------------------------------------------------------------------
 * VER  DATE         AUTHOR      DESCRIPTION
 * ---  -----------  ----------  -----------------------------------------
 * 1.0  2011.5.18	 huaf     	 型号配置
 * ----------- ----------  -----------------------------------------------
 * Copyright(c) 2011 mochasoft,  All rights reserved.
 *************************************************************************
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<script type="text/javascript" src="${ctx}/js/scriptmonitor/modelWindow.js"></script>
<script type="text/javascript" src="${ctx}/js/monitorsetting/modelsetting/modelsetting.js"></script>
<div id="devContent">
	<div class="tab-content-searchlist">
	<form id="searchCondition">
		<span id="delSysOid" class="black-btn-l f-right"><span class="btn-r"><span class="btn-m"><a >删除</a></span></span></span>
	    <span id="startSysOid" class="black-btn-l f-right"><span class="btn-r"><span class="btn-m"><a >发布</a></span></span></span>
		<span id="addSysOid" class="black-btn-l f-right"><span class="btn-r"><span class="btn-m"><a >添加</a></span></span></span>
		<span>资源：</span>
		<select id="selectResId" name="sysObjectIDFinder.resource">
			<s:iterator value="resourceTypes" id="map">
				<option value="<s:property value="#map.key"/>"><s:property value="#map.value"/></option>
			</s:iterator>
		</select>
		<span>System OID：</span>
		<s:textfield name="sysObjectIDFinder.oid"></s:textfield>
		<input type="hidden" name="pageSize" value="<s:property value='pageSize'/>"/>
		<input type="hidden" name="pageNum" value="<s:property value='pageNum'/>"/>
		<input type="hidden" name="sortColId" value="<s:property value='sortColId'/>"/>
		<input type="hidden" name="sortColType" value="<s:property value='sortColType'/>"/>
		<span class="ico" onclick="searchFun()"></span>
	</form>	
	</div>
	<form id="contentForm">
	<page:applyDecorator name="indexcirgrid">
     <page:param name="id">modelSettingGrid</page:param>
     <page:param name="width">100%</page:param>
     <page:param name="height">100%</page:param>
     <page:param name="tableCls">grid-black</page:param>
     <page:param name="gridhead">[{colId:"idHidden",text:"<input type='checkbox' id='allCheckBox' onclick='setAllSelectFun(\"allCheckBox\",\"sysoidBox\");' style='cursor:pointer'/>"},{colId:"resource", text:"资源"},{colId:"sysoid", text:"System OID"},{colId:"type", text:"类型"},{colId:"os", text:"操作系统"},{colId:"vender", text:"厂商"},{colId:"model", text:"型号"}]</page:param>
     <page:param name="gridcontent"><s:property value="dispalyJsonDatas" escape="false"/></page:param>
   </page:applyDecorator>
   <div id="pageDevice" style="overflow:hidden;width:100%;" />
   </form>
</div>
<script>
	var toast;
	var page;
	var myGP;
	$(document).ready(function () {
		toast = new Toast({position:"CT"}); 
		var widthVal = 770;
		var widthJson = {idHidden:5,resource:18,sysoid:12,type:20,os:17,vender:10,model:18};
		var sortCloumnsJson = [{index:"sysoid",defSorttype:"up"},{index:"resource"},{index:"os"}];
		myGP = new GridPanel({
			id:"modelSettingGrid",
			columnWidth:widthJson,
			unit:"%",
			plugins:[SortPluginIndex],
			sortColumns:sortCloumnsJson,
			sortLisntenr:function($sort){
				var $sortColId = $("input[name=sortColId]");
				var $sortType = $("input[name=sortColType]");
				$sortColId.val($sort.colId);
				$sortType.val($sort.sorttype);
				loadTable();
	            
			}},
			{	gridpanel_DomStruFn:"index_gridpanel_DomStruFn",
				gridpanel_DomCtrlFn:"index_gridpanel_DomCtrlFn",
				gridpanel_ComponetFn:"index_gridpanel_ComponetFn"
			});
			
			var renderGrid=[];
			
			renderGrid.push({index:"idHidden",fn:function(td){
				var $html = "";
				if(td.html!=""){
					$html = $("<input type='checkbox' name='oids' checkBoxName='sysoidBox' onclick='alertAllCheckBoxFun(\"allCheckBox\",\"sysoidBox\");' style='cursor:pointer' value='"+td.html+"' />");
				}
				return $html; 
			}});
			myGP.rend(renderGrid);
		
		/**
		 * Pagination
		 * */
		page = new Pagination({
		    applyId: "pageDevice",
		    listeners: {
		        pageClick: function(page) {
		        	$("input[name=pageNum]").val(page);
				    loadTable();
		        }
		    }
		});
		var pageSize = "<s:property value='pageCount'/>";
		page.pageing(pageSize,1);
	});

	$("#addSysOid").bind("click",function(){
		var resourceId = openWinFun("${ctx}/monitorsetting/model/sysoidSetting!addSysOid.action","add-sysoid");
		$("#selectResId").attr("value",resourceId);
		loadTable();
	});
	$("#delSysOid").bind("click",function(){
		var serializeVal = $("input[name=oids]:checked").serialize();
		if(serializeVal && serializeVal!=""){
			var _confirm = new confirm_box({text:"是否删除？"});
			_confirm.setConfirm_listener(function(){
				$.ajax({
					url:"${ctx}/monitorsetting/model/sysoidSetting!deleteSysOid.action",
					data:$("input[name=oids]:checked").serialize(),
					type:"POST",
					dataType:"json",
					success:function(data,state){
						toast.addMessage("操作成功。");
						setTimeout(function(){
							loadTable();
						},500);	
					}
				});
				_confirm.hide();
			});
			_confirm.show();
		}else{
			doInformatAlter();
			return;
		}
	});
	$("#startSysOid").bind("click",function(){
		var _confirm = new confirm_box({text:"是否发布？"});
		_confirm.setConfirm_listener(function(){
			$.ajax({
				url:"${ctx}/monitorsetting/model/sysoidSetting!publishFile.action",
				type:"POST",
				dataType:"json",
				success:function(data,state){
					if(data.operateState=="true"){
						toast.addMessage("发布成功。<br/>为确保系统能正常取值，请您手动重启Server。");
					}else{
						toast.addMessage("发布失败。");
					}
				}
			});
			_confirm.hide();
		});
		_confirm.show();
	});
	function searchFun(){
		loadTable();
	}
</script>
