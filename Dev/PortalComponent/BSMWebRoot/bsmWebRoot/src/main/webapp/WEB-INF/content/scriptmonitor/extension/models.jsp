<%--  
 *************************************************************************
 * @source  : self-models.jsp
 * @desc    : Mocha BSM 8.0
 *------------------------------------------------------------------------
 * VER  DATE         AUTHOR      DESCRIPTION
 * ---  -----------  ----------  -----------------------------------------
 * 1.0  2011.5.18	 huaf     	 系统模型
 * ----------- ----------  -----------------------------------------------
 * Copyright(c) 2011 mochasoft,  All rights reserved.
 *************************************************************************
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<script>
	var ctx= "${ctx}";
	//var toast;
</script>
<script>
function changeCondition(tag){
	$("#resourceNameVal<s:property value='isExtension'/>").val("");
	$("#categoryGroupNameVal<s:property value='isExtension'/>")[0].selectedIndex=0;
	$("#selectSpan"+tag+" > span").toggle();
}

</script>
<div id="devContent">
	<div class="tab-content-searchlist" style="overflow:hidden;" >
	<form id="searchCondition">
		<s:set name="extension" value="isExtension"/>
		<s:if test="#extension == 'true'">
		<span id="delModel" class="black-btn-l f-right"><span class="btn-r"><span class="btn-m"><a >删除模型</a></span></span></span>
		</s:if>
	    <span id="startModel<s:property value="gridTabId"/>" class="black-btn-l f-right"><span class="btn-r"><span class="btn-m"><a >发布模型</a></span></span></span>
		<s:if test="#extension == 'true'">
		<span id="addModel" class="black-btn-l f-right"><span class="btn-r"><span class="btn-m"><a >新增模型</a></span></span></span>
		</s:if>
		<select id="deviceType" onChange="changeCondition('<s:property value="isExtension"/>');">
			<option value="modelName">模型显示名称</option>
			<option value="modelType">设备类型</option>
		</select>
		<span id="selectSpan<s:property value="isExtension"/>">
			<span id="modelName"><input id="resourceNameVal<s:property value='isExtension'/>" name="resourceNameVal"/></span>
			<span style="display:none" id="modelType">
				<select id="categoryGroupNameVal<s:property value='isExtension'/>" name="categoryGroupNameVal">
					<option value="">全部</option>
					<s:iterator value="deviceTypes" id="map">
						<option value="<s:property value='#map.key'/>"><s:property value="#map.value"/></option>
					</s:iterator>
				</select>
			</span>
		</span>	
		<span class="ico" onclick="searchFun()"></span>		
		<input type="hidden" name="resourceCategoryId" value="<s:property value='resourceCategoryId'/>"/>
		<input type="hidden" id="resourceNameHidden" name="moduleQuery.resourceName"/>
		<input type="hidden" id="categoryGroupNameHidden" name="moduleQuery.categoryGroupName"/>
		<input type="hidden" id="sortIdHidden" name="moduleQuery.orderBy" value="1"/>
   		<input type="hidden" id="sortColIdHidden" name="sortColIdHidden" />
   		<input type="hidden" id="pageIdHidden" name="moduleQuery.pageNumber" value="1"/>
   		<input type="hidden" id="pagesizeHidden" name="moduleQuery.pageSize" value="20"/>
	</form>	
	</div>
	<form id="contentForm">
	<page:applyDecorator name="indexcirgrid">
     <page:param name="id"><s:property value="gridTabId"/></page:param>
     <page:param name="width">100%</page:param>
     <page:param name="height">100%</page:param>
     <page:param name="tableCls">grid-black</page:param>
     <page:param name="gridhead">[{colId:"hiddenResId",hidden:"true"},{colId:"toReleaseIco",hidden:"true"},{colId:"resourceId", text:"<input type='checkbox' id='allCheckBox<s:property value='gridTabId'/>' onclick=\"setAllSelectFun('allCheckBox<s:property value='gridTabId'/>','resourceIdBox<s:property value='gridTabId'/>');\" style='cursor:pointer' />"},{colId:"resourceName", text:"模型显示名称"},{colId:"resourceType", text:"设备类型"},{colId:"resourceDes", text:"备注"},{colId:"updateTime", text:"最近修改时间"},{colId:"operate", text:"操作"},{colId:"toRelease", text:"发布"}]</page:param>
     <page:param name="gridcontent"><s:property value="datas" escape="false"/></page:param>
   </page:applyDecorator>
   <div id="pageDevice<s:property value="gridTabId"/>" style="overflow:hidden;width:100%;" />
   </form>
</div>
<script type="text/javascript">
		var page;
		var gridTabId = "<s:property value='gridTabId'/>";
		var resourceCategoryId = "<s:property value='resourceCategoryId'/>";
		var isExtension = "<s:property value='isExtension'/>";
		var paginationId = "pageDevice"+gridTabId;
		var pageSize = "<s:property value='pageCount' />";
		var currentPage = '1';
		$("#addModel").bind("click",function(){
			openWinFun("${ctx}/scriptmonitor/repository/addModel.action?resourceCategoryId="+resourceCategoryId,"addModel");
		});
		$("#delModel").bind("click",function(){
			var param = $("input[checkBoxName='resourceIdBox<s:property value="gridTabId"/>']:checked").serialize();
			var url = "${ctx}/scriptmonitor/repository/delModelExtend!delModel.action";
			delModelFun(url,param);
		});
		$("#startModel<s:property value='gridTabId'/>").bind("click",function(){
			var data = $("input[checkBoxName='resourceIdBox<s:property value="gridTabId"/>']:checked").serialize();
			publishModelFun2(data);
		});
		function searchFun(){
			$("#resourceNameHidden").val($("#resourceNameVal<s:property value='isExtension'/>").val());
			$("#categoryGroupNameHidden").val($("#categoryGroupNameVal<s:property value='isExtension'/> option:selected").val());
			loadTable();
		}
		$(document).ready(function () {
			if(!toast){
				toast = new Toast({position:"CT"}); 
			}
			/**
			 * Pagination
			 * */
			var $pageIdHidden = $("#pageIdHidden");
			page = new Pagination({
			    applyId: paginationId,
			    listeners: {
			        pageClick: function(page) {
			        	$pageIdHidden.val(page);
					    loadTable();
			        }
			    }
			});
			page.pageing(pageSize,1);
			
			//权限解绑
		});
</script>
<script type="text/javascript" src="${ctx}/js/scriptmonitor/modolExtensionComponent.js"></script>