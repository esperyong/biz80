<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<form name="componentdiagnoseformname" id="componentdiagnoseformname">
<div style="width:100%;">

	<div class="margin5" style="width: 99%;">
		<ul>
			<li class="margin3">
				<span class="field-max">待诊断系统组件：</span><span>${componentSelect }</span>
			</li>
			<li class="margin3">
				<span class="field-max"></span><span class="black-btn-l right"><span class="btn-r"><span class="btn-m"><a id="componentdiagnosebutton">诊断</a></span></span></span>
				<span class="black-btn-l f-right" style="display:none;"><span class="btn-r"><span class="btn-m"><a id="componentexportbutton">导出</a></span></span></span>
			</li>
		</ul>
	</div>
	<div style="width:99%;" id="componentreport">
		<div class="panel-gray clear">
			<div class="panel-gray-top  txt-center"></div>
			<div class="panel-gray-content" style="height:310px;">
				<div class="txt-center vertical-middle" style="margin-top:150px;">
					<span class="for-inline vertical-middle"><span class="icon-tips" /></span>
					<span class="for-inline bold">请点击</span>
					<span class="black-btn-l" style="cursor:default;"><span class="btn-r"><span class="btn-m"><a>诊断</a></span></span></span>
					<span class="for-inline bold">生成报告</span>
				</div>
			</div>
		</div>
	</div>
</div>
</form>