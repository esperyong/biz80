<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<div class="pic-alert padding5 border-bottom"><b>组件信息-${resInstanceName}</b></div>
<s:if test="componentInfoVOs == null">
<div class="grid-black" style="height:360px;">
	<div class="formcontent" style="height:360px;">
		<table style="height:360px;width:100%;">
			<tbody>
				<tr>
					<td class="nodata vertical-middle" style="text-align:center;">
						<span class="nodata-l">
						<span class="nodata-r">
						<span class="nodata-m"> <span class="icon">当前无数据</span> </span>
						</span>
						</span>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</div>
</s:if>
<s:else>
<div class="padding8 f-relative" style="height:360px;overflow-y:auto;overflow-x:hidden;">
<s:iterator value="componentInfoVOs" var="componentInfo" status="status">
	<page:applyDecorator name="accordionAddSubPanel">
		<page:param name="id">panelid_<s:property value="#status.index" /></page:param>
		<page:param name="title"><s:property value="#componentInfo.resourceName" />(<s:property value="#componentInfo.instanceNum" />)</page:param>
		<page:param name="width">240px</page:param>
		<page:param name="display"><s:if test="#status.first"></s:if><s:else>collect</s:else></page:param>
		<page:param name="cls">fold-blue</page:param>
		<page:param name="content">
		<!-- content start -->
			    <page:applyDecorator name="indexgrid">
			       <page:param name="id">gridid_<s:property value="#status.index" /></page:param>
			       <page:param name="width">240px</page:param>
			       <page:param name="linenum">0</page:param>
			       <page:param name="tableCls">grid-black</page:param>
			       <page:param name="gridhead">[{colId:"resInstanceName",text:"名称"}]</page:param>
			       <page:param name="gridcontent"><s:property value="#componentInfo.content" escape="false" /></page:param>
			     </page:applyDecorator>
		<!-- content end -->
		</page:param>
	</page:applyDecorator>
    <script type="text/javascript">
    var gp_<s:property value="#status.index" /> = new GridPanel({id:"gridid_<s:property value='#status.index' />",
		unit:"%",
		columnWidth:{resInstanceName:100}},
		{gridpanel_DomStruFn:"index_gridpanel_DomStruFn",
		gridpanel_DomCtrlFn:"index_gridpanel_DomCtrlFn",
		gridpanel_ComponetFn:"index_gridpanel_ComponetFn"});
    gp_<s:property value="#status.index" />.rend();
		
	var accordPanel_<s:property value="#status.index" /> = new AccordionPanel({id : "panelid_<s:property value='#status.index' />"}, {
		DomStruFn : "addsub_accordionpanel_DomStruFn",
		DomCtrlFn : "addsub_accordionpanel_DomCtrlFn"
	});
    </script>
</s:iterator>
</div>
</s:else>