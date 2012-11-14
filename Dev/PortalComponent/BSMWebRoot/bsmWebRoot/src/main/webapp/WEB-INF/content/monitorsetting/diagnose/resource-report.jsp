<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<div class="left-content" style="width:100%;">
	<div class="panel-gray">
		<div class="panel-gray-top">&nbsp;</div>
		<div class="panel-gray-content">
			<page:applyDecorator name="indexgrid">  
			   	<page:param name="id">decoratorGridpanel</page:param>
			   	<page:param name="tableCls">grid-gray</page:param>
       			<page:param name="linenum">0</page:param>
			   	<page:param name="gridhead">[{colId:"dmsName", text:"DMS"},{colId:"ipAddress",text:"IP地址"},{colId:"port",text:"端口"},{colId:"os",text:"操作系统"},{colId:"response",text:"响应时间"},{colId:"method",text:"采集方式"},{colId:"detail",text:"诊断报告"},{colId:"isHasDetailHidden",text:"",hidden:true},{colId:"osTypeHidden",text:"",hidden:true},{colId:"ipHidden",text:"",hidden:true},{colId:"serverIdHidden",text:"",hidden:true},{colId:"portHidden",text:"",hidden:true}]</page:param>
			   	<page:param name="gridcontent">${result}</page:param>
			</page:applyDecorator>
		</div>
	</div>
</div>