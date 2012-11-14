<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<input type="hidden" id="exportJson" name="exportJson" value="<s:property value="exportJson"/>">
<div class="left-content" style="width:100%;">
	<div class="panel-gray">
		<div class="panel-gray-top" style="text-align: center;">诊断信息&nbsp;${currentDate }</div>
		<div class="panel-gray-content">
			<s:iterator value="componentServerId" var="title" status="statusTitle">
				<page:applyDecorator name="accordionAddSubPanel">
					<page:param name="id">accordionPanel_<s:property value="#statusTitle.index" /></page:param>
					<page:param name="title"><s:property value="titleMap.get(#title)" /></page:param>
					<page:param name="width">100%</page:param>
					<page:param name="display"><s:if test="#statusTitle.first"></s:if><s:else>collect</s:else></page:param>
					<page:param name="cls">fold-blue</page:param>
					<page:param name="content">
					<!-- content start -->
					<s:iterator value="contentMap.get(#title)" var="content" status="statusContent">
						<div style="color:black;">
							<fieldset class="blue-border-nblock" >
								<legend><s:property value="#content.get('title')" escape="false"/></legend>
							    <page:applyDecorator name="indexgrid">
							       <page:param name="id">gridPanel_<s:property value="#statusTitle.index" />_<s:property value="#statusContent.index" /></page:param>
							       <page:param name="width">100%</page:param>
							       <page:param name="isPrompt">true</page:param>
							       <page:param name="linenum">0</page:param>
   								   <page:param name="tableCls">grid-gray</page:param>
							       <page:param name="gridhead"><s:property value="#content.get('head')" escape="false"/></page:param>
							       <page:param name="gridcontent"><s:property value="#content.get('body')" escape="false"/></page:param>
							     </page:applyDecorator>
						    </fieldset>
						    <script language="javascript">
							  	var config = {
									  columnWidth:<s:property value="#content.get('columnWidth')" escape="false"/>
								};
								<s:if test="#content.get('title') == '组件服务状态'">
							    	config.render = [{
							    		index:"PortState",
							    		fn:function(td){
							    			var $font;
							    			if(td.html == "正常"){
												 $font = $("<div class='lamp lamp-green-ncursor'></div>");
								             }else if(td.htm =="未知" ){
								             	$font = $("<div class='lamp lamp-gray-ncursor'></div>");
								             }else{
								             	$font = $("<div class='lamp lamp-red-ncursor'></div>");
								             }
								             return $font;
								         }
							    	}];
							    </s:if>
								var gridPanel_<s:property value="#statusTitle.index" />_<s:property value="#statusContent.index" /> = BSM.Monitorsetting.createGridPanel('gridPanel_<s:property value="#statusTitle.index" />_<s:property value="#statusContent.index" />',config);
						    </script>
						    
						</div>
					</s:iterator>
					<!-- content end -->
					</page:param>
				</page:applyDecorator>
				<script language="javascript">
					var accordionPanel_<s:property value="#statusTitle.index" /> = BSM.Monitorsetting.createAccordionPanel('accordionPanel_<s:property value="#statusTitle.index" />');
				</script>
			</s:iterator>
		</div>
	</div>
</div>
<iframe id="DownloadFrame" name="DownloadFrame" width="0" height="0" frameborder="0" marginheight="0" marginwidth="0" scrolling="no" />