<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.mocha.bsm.system.SystemContext"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<%@ include file="/WEB-INF/common/meta.jsp"%>
<form name="resourcediagnoseformname" id="resourcediagnoseformname">
	<div class="margin5 gray-bottom" style="width: 99%;">
		<ul>
			<li class="margin3">
				<span class="field-max">待诊断资源所属<%if(SystemContext.isStandAlone()){ %>Server<%}else{ %>DMS<%} %></span><span>：${dmsSelect }</span>
			</li>
			<li class="margin3">
				<span class="field-max">待诊断资源的IP地址</span><span>：<input type="text" name="ipAddress" id="ipAddress"]"></span>
				<span style="padding-left: 10px;">端口：</span><span><input type="text" name="port" id="port" value="7777"></span>
				<span class="gray-btn-l"><span class="btn-r"><span class="btn-m"><a id="jsdiagnoseresourceadd">添加</a></span></span></span>
			</li>
			<li class="margin3">
				<span class="field-max"></span><span>&nbsp;&nbsp;&nbsp;&nbsp;<select id="ipSelect" name="ipSelect" size="7" style="width: 313px;" multiple></select></span>
				<span style="vertical-align: top">
					<span class="gray-btn-l"><span class="btn-r"><span class="btn-m"><a id="jsdiagnoseresourcedelete">删除</a></span></span></span>
				</span>
			</li>
			<li class="margin3">
				<span class="field-max"></span><span style="padding-left: 14px;">注：诊断以Agent方式发现的被监控资源； 可以输入IP网段进行诊断。 例如 ： 192.168.30.*</span><span class="black-btn-l right"><span class="btn-r"><span class="btn-m"><a id="resourcediagnosebutton">诊断</a></span></span></span>
			</li>
		</ul>
	</div>
	<div style="width: 99%;" id="resourcereport">
		<div class="panel-gray clear">
			<div class="panel-gray-top  txt-center"></div>
			<div class="panel-gray-content" style="height:150px;">
				<div class="txt-center vertical-middle" style="margin-top:60px;">
					<span class="for-inline vertical-middle"><span class="icon-tips" /></span>
					<span class="for-inline bold">请点击</span>
					<span class="black-btn-l" style="cursor:default;"><span class="btn-r"><span class="btn-m"><a>诊断</a></span></span></span>
					<span class="for-inline bold">生成报告</span>
				</div>
			</div>
		</div>
	</div>
</form>