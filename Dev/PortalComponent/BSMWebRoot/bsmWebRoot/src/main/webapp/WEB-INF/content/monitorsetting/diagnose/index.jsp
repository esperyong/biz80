<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/loading.jsp" %>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<script type="text/javascript">
<!--
	$("#loading_text").html('<s:text name="page.loading.msg" />');
//-->
</script>
<div class="manage-content">
	<div class="top-l">
      <div class="top-r">
        <div class="top-m"> </div>
      </div>
    </div>
    <div class="mid">
		<div class="h1">
			<span class="bold">当前位置：</span>
			<span>监控管理 / 工具 / 监控诊断工具</span>
		</div>
		<page:applyDecorator name="tabPanel">  
			<page:param name="id">diagnosemytab</page:param>
		   	<page:param name="cls">tab-grounp</page:param>
		   	<page:param name="background">#FFFFFF;</page:param>
		   	<page:param name="width">99%</page:param>
		   	<page:param name="current">1</page:param> // 默认显示第几个
		   	<page:param name="tabHander">[{text:"系统自检报告",id:"tab1"},{text:"系统组件诊断",id:"tab2"},{text:"监控资源诊断",id:"tab3"}]</page:param>
		   	<page:param name="content_1">
				<s:action name="self-index" executeResult="true" namespace="/monitorsetting/diagnose" flush="false"></s:action>
		   	</page:param>
		</page:applyDecorator>
	</div>
    <div class="bottom-l">
      <div class="bottom-r">
        <div class="bottom-m"> </div>
      </div>
    </div>
</div>