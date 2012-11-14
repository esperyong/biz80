<%--  
 *************************************************************************
 * @source  : profile-report.jsp
 * @desc    : Mocha BSM 8.0
 *------------------------------------------------------------------------
 * VER  DATE         AUTHOR      DESCRIPTION
 * ---  -----------  ----------  -----------------------------------------
 * 1.0  2011.5.30	 huaf     	  报表预览
 * ----------- ----------  -----------------------------------------------
 * Copyright(c) 2011 mochasoft,  All rights reserved.
 *************************************************************************
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<%@ include file="/WEB-INF/common/meta.jsp"%>
<link href="${ctxCss}/public.css" rel="stylesheet" type="text/css" />
<link href="${ctxCss}/master.css"  rel="stylesheet" type="text/css"  />
<link href="${ctxCss}/jquery-ui/treeview.css" type="text/css" rel="stylesheet"/>
<link href="${ctxCss}/jquery-ui/jquery.ui.treeview.css" rel="stylesheet"type="text/css">
<link href="${ctxCss}/UIComponent.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/tongjifenxi.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctxJs}/jquery-1.4.2.min.js" ></script>
<script type="text/javascript" src="${ctxJs}/report/statistic/statisticUtil.js"></script>
<script type="text/javascript" src="${ctxJs}/component/cfncc.js"></script>
<script type="text/javascript" src="${ctxJs}/component/tabPanel/tab.js"></script>
<script type="text/javascript" src="${ctxJs}/component/treeView/tree.js"></script>
<script type="text/javascript" src="${ctxJs}/component/menu/menu.js"></script> 
<script type="text/javascript" src="${ctxJs}/component/panel/panel.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery.blockUI.js"></script>
<script type="text/javascript" src="${ctxJs}/component/date/WdatePicker.js"></script>
<page:applyDecorator name="popwindow" title="预览">
	<page:param name="topBtn_index_1">1</page:param>
	<page:param name="width">1000px</page:param> 
	<page:param name="height">600px</page:param>
	<page:param name="topBtn_id_1">previewReportID</page:param>
	<page:param name="topBtn_css_1">win-ico win-close</page:param>
	<page:param name="content">
		<div class="loading" id="loading" style="display:none;">
		 <div class="loading-l">
		  <div class="loading-r">
		    <div class="loading-m">
		       <span class="loading-img">载入中，请稍候...</span> 
		    </div>
		  </div>
		  </div>
		</div> 
			<s:form id="from1">
				<input type="hidden" name="outputType" id="outputType">
				<div>
					<span>产生时间：从</span><input type="text" id="startTime" name="startTimeText" readOnly value="${startTimeText}"/><span>到</span><input type="text" id="endTime" name="endTimeText" readOnly value="${endTimeText}"/>
					<span  id="timeSearch" class="ico" title="搜索" ></span>
					<!--span class="ico ico-excel f-right" style="width:15px;height:15px" name="exportexl" onclick="exportReport(2);"></span-->
					<span class="ico ico-ie f-right" name="exportPdf" onclick="exportReport(3);" title="导出Html">&nbsp;</span>&nbsp;<span class="ico ico-pdf f-right" name="exportPdf" onclick="exportReport(1);" title="导出PDF">&nbsp;</span>&nbsp;<span class="f-right" onclick="showBaseInfo();" style="background:url(${ctxImages}/scriptmonitor/chakangd.gif) 0 0;width:16px; height:16px; display:inline-block;*display:inline;zoom:1; margin-left:3px; margin-right:3px; cursor:pointer; vertical-align:middle;" title="常规信息">&nbsp;</span>
				</div>
					<s:hidden name="profileId" value="%{profileId}"/>
					<s:hidden name="profileName" value="%{profileName}"/>
			</s:form>
			<div class="margin5" id="baseinfo" style="position:absolute;z-index:190;display:none;">
				<ul class="fieldlist-n">
					<li><span  class="field-max">显示名称</span>			<span>：</span><span>${profileName}</span></li>
					<li><span  class="field-max">脚本类别</span>			<span>：</span><span>${groupName}</span></li>
					<li><span  class="field-max">执行脚本服务器IP</span>	<span>&nbsp;：</span><span>${ip}</span></li>
					<li><span  class="field-max">脚本路径及文件名</span>	<span>：</span><span><div style="width:500px;text-overflow:ellipsis;white-space:nowrap;overflow:hidden;">${path}</div></span></li>
					<s:if test="parameters.size()>0">
						<li><span  class="field-max">输入参数</span>			<span>：</span><spa>&nbsp;</span></li>
						<s:iterator value="parameters" status="pst" var="parameter" begin="0" step="2">
							<li><span  class="field-max">&nbsp;</span><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span class="field-min"><s:property value="top"/></span><span>：</span><span><s:property value="parameters[#pst.index*2+1]" /></span></li>
						</s:iterator>
					</s:if>
					<s:else>
						<li><span  class="field-max">输入参数</span>			<span>：</span><spa>-</span></li>
					</s:else>
					<li><span  class="field-max">执行频度</span>			<span>：</span><span>${frequecy}</span></li>
					<li><span  class="field-max">备注</span>				<span>：</span><span>${description}</span></li>
				</ul>
			 </div>
			<div class="margin5">
	             <ul>
	               <li style=" text-align:center">
	              	<span class="txt14 bold">${profileName}</span>
	              </li>
	              <li style=" text-align:center" class="margin5"><span id="sTime"><s:property value="startTimeText"/></span>到<span id="eTime"><s:property value="endTimeText"/></span></li>
	             </ul>
            </div>
            <div id="contentTable" style="margin-height:100px;width:980px">
				<s:action name="profileReport!searchTable" namespace="/scriptmonitor/repository"
						executeResult="true" flush="false">
						<s:param name="profileId" value="<s:property value='profileId' />"/>
				</s:action>
			</div>  
			<iframe id="downLoadF" name="downLoadF" height="0" width="0"></iframe>
	</page:param>
</page:applyDecorator>
<script type="text/javascript">
$("#previewReportID").click(function(){
	window.close();
});
$("#timeSearch").click(function(){
	$.blockUI({message:$('#loading')});
	$.ajax({
		url:"${ctx}/scriptmonitor/repository/profileReport!searchTable.action",
		data:$("#from1").serialize(),
		dataType:"html",
		type:"post",
		success:function(data,state){
			$.unblockUI();
			$("#contentTable").find("*").unbind().html("");
			$("#contentTable").html(data);
			$("#sTime").html("").append($("#startTime").val());
			$("#eTime").html("").append($("#endTime").val());
		}
	});
});
$("#startTime").bind("click",function(){
	WdatePicker({dateFmt:'<%=com.mocha.bsm.i18n.I18CommonData.getFormatDateTime(null)%>'});
});
$("#endTime").bind("click",function(){
	WdatePicker({dateFmt:'<%=com.mocha.bsm.i18n.I18CommonData.getFormatDateTime(null)%>'});
});

var $effecteResPanel;
function showBaseInfo(){
		var htmlContent = $("#baseinfo").html();
		$effecteResPanel = null;
		$effecteResPanel = new winPanel(
			{html:htmlContent,x: 100,y:100,width:800,isautoclose: true,closeAction: "close"
		    							,listeners:{
									    			closeAfter:function(){
										       			effecteResPanel = null; 
										      		},
										      		loadAfter:function(){} 
									     	}
			} ,{winpanel_DomStruFn:"blackLayer_winpanel_DomStruFn" }
	    );
}

function exportReport(exportType){
	$("#outputType").val(exportType);
	document.from1.action="${ctx}/scriptmonitor/repository/profileReport!export.action";
	document.from1.target="downLoadF";
	document.from1.submit();
	/*
	$.blockUI({message:$('#loading')});
	$("#outputType").val(exportType);
	$.ajax({
		url:"${ctx}/scriptmonitor/repository/profileReport!export.action",
		data:$("#from1").serialize(),
		dataType:"html",
		type:"get",
		success:function(data,state){
			$.unblockUI();
		}
	});
	*/
}
</script>
