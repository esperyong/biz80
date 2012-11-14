<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/loading.jsp" %>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<script type="text/javascript">
<!--
	$("#loading_text").html('<s:text name="page.loading.msg" />');
//-->
</script>
<form name="systemlogformname" id="systemlogformname">
<input type="hidden" name="zipPath" id="zipPath">
<div class="manage-content" style="width:100%;">
	<div class="top-l">
      <div class="top-r">
        <div class="top-m"> </div>
      </div>
    </div>
    <div class="mid">
		<div class="h1">
			<span class="bold">当前位置：</span>
			<span>监控配置 / 日志 / 系统日志汇总</span>
		</div>
		<div>
			<span><span class="ico ico-tips"/>说明：为了检查系统服务日常运行情况，需要对其运行日志进行汇总，请点击“日志汇总”对系统日志进行汇总并打包。</span>
			<span class="black-btn-l"><span class="btn-r"><span class="btn-m"><a id="systemlogsummary">日志汇总</a></span></span></span>
		</div>
		<div>
		<page:applyDecorator name="indexgrid">  
		   <page:param name="id">systemlogGridPanel</page:param>
		   <page:param name="height">100%</page:param>
		   <page:param name="tableCls">grid-gray</page:param>
		   <page:param name="gridhead">[{colId:"zipName", text:"日志名称"},{colId:"zipTime",text:"操作时间"},{colId:"zipPath",text:"操作"}]</page:param>
		   <page:param name="gridcontent">${result}</page:param>
		</page:applyDecorator>
		</div>
	</div>
    <div class="bottom-l">
      <div class="bottom-r">
        <div class="bottom-m"> </div>
      </div>
    </div>
</div>
<iframe id="systemlogdownloadframe" name="systemlogdownloadframe" width="0" height="0" frameborder="0" marginheight="0" marginwidth="0" scrolling="no" />
</form>