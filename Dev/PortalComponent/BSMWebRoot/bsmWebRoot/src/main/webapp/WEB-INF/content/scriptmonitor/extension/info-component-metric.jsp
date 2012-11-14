<%--  
 *************************************************************************
 * @source  : info-component-metric.jsp
 * @desc    : Mocha BSM 8.0
 *------------------------------------------------------------------------
 * VER  DATE         AUTHOR      DESCRIPTION
 * ---  -----------  ----------  -----------------------------------------
 * 1.0  2011.5.19	 huaf     	 组件定义下的指标层
 * ----------- ----------  -----------------------------------------------
 * Copyright(c) 2011 mochasoft,  All rights reserved.
 *************************************************************************
--%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/WEB-INF/common/meta.jsp" %>
<%@ page import="com.opensymphony.xwork2.util.*"%>
<table>
		<thead>
			<tr>
				<th width="4%"><input type="checkbox" onclick="setAllSelectFun('metricBoxAll<s:property value="resourceId"/>','metricBox<s:property value="resourceId"/>');" name="checkAll" id="metricBoxAll<s:property value="resourceId"/>" /></th>
				<th width="18%">指标类型</th>
				<th width="18%">指标名称</th>
				<th width="52%">指标描述</th>
				<th width="8%">操作</th>
			</tr>
		</thead>
		<tbody>
		<s:iterator value="metrics" id="list">
			<tr>
				<td width="4%">
					<label>
            			<input name="checkbox" type="checkbox" checkBoxName="metricBox<s:property value="resourceId"/>" onclick="alertAllCheckBoxFun('metricBoxAll<s:property value="resourceId"/>','metricBox<s:property value="resourceId"/>');" id="checkbox" value="#list.metricId"/>
          			</label>
				</td>
				<td width="18%" height="24"><s:text name="ScriptMonitor.%{#list.metricType}"/></span></td>
				<td width="18%" height="24"><s:property value="#list.metricName"/></span></td>
				<td width="52%"><s:property value="#list.description"/></td>
				<td width="8%"><span style="cursor:pointer" onclick="componentsMetricOperate('<s:property value="#list.resourceId"/>','<s:property value="#list.metricId"/>')" name="operate" class="ico ico-t-right" title="操作"></td>
			</tr>
		</s:iterator>

		</tbody>
</table>
<script>
	function componentsMetricOperate(resourceId,metricId){
		var parentId = "<s:property value='parentId'/>";
		var mc = new MenuContext({x:0,y:0,width:100,
			listeners:{click:function(id){alert(id)}}},
			{menuContext_DomStruFn:"ico_menuContext_DomStruFn"}
		);
		mc.position(event.x,event.y);
		mc.addMenuItems([[
		{ico:"delete",text:"删除",id:"delMetric",listeners:{
			click:function(){
				delMetricFun2(metricId,resourceId);
			}
		}},                  
		{ico:"edit",text:"编辑",id:"editMetric",listeners:{
			click:function(){
				openWinFun("${ctx}/scriptmonitor/repository/addMetric.action?parentId="+parentId+"&resourceId="+resourceId+"&metricId="+metricId,"editMetric","tab2");
			}
		}}
		]]);
	}
</script>