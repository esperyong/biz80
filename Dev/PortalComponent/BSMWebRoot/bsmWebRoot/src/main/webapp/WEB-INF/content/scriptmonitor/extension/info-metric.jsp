<%--  
 *************************************************************************
 * @source  : info-metric.jsp
 * @desc    : Mocha BSM 8.0
 *------------------------------------------------------------------------
 * VER  DATE         AUTHOR      DESCRIPTION
 * ---  -----------  ----------  -----------------------------------------
 * 1.0  2011.5.16	 huaf     	 指标定义
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
<div style="background-color:#000;height:100%;overflow:auto"> 
  <div style="background-color:#fff">
  <div class="fold-blue padding5" style="margin-bottom:8px;">
  <div class="fold-top"> 
  <span class="fold-top-title left">可用性指标</span>
  
  <span class="right"><span onclick="delMetricFun('availMetircBox','<s:property value="resourceId"/>')" class="r-ico r-ico-close"></span> 
  <span onclick="addMetricFun('<s:property value='@com.mocha.bsm.script.monitor.obj.extension.ResourceMetric@METRIC_AVAIL'/>')" class="r-ico r-ico-add"></span></span></div>
  <div>
    <table class="monitor-items-head02 border-gray" width="100%" cellspacing="0" cellpadding="0" >
      <thead>
        <tr>
          <th width="4%"><label>
            <input name="availMetircBoxAll" onclick="setAllSelectFun('availMetricBoxAll','availMetircBox');" type="checkbox" id="availMetricBoxAll" />
          </label></th>
          <th width="36%" height="24">指标名称</th>
          <th width="52%">指标描述</th>
          <th width="8%">操作</th>
          </tr>
        </thead>
        <tbody>
        <s:set name="availList" value="resourceMetrics[@com.mocha.bsm.script.monitor.obj.extension.ResourceMetric@METRIC_AVAIL]"/>
        <s:iterator value="#availList" id="list">
          <tr>
	          <td><input name="metricIdBox" type="checkbox" checkBoxName="availMetircBox" onclick="alertAllCheckBoxFun('availMetricBoxAll','availMetircBox');"  id="availMetircBox" value="<s:property value='#list.metricId'/>" /></td>
	          <td height="24"><s:property value="#list.metricName"/></td>
	          <td><s:property value="#list.description"/></td>
	          <td><span style="cursor:pointer" onclick="executeMetricOperate('<s:property value='#list.metricId'/>')" class="ico ico-t-right"></span></td>
          </tr>
        </s:iterator>
       </tbody>
    </table>
  </div>
  </div>
  <div class="fold-blue padding5" style="margin-bottom:8px;">
  <div class="fold-top"> 
  <span class="fold-top-title left">性能指标</span>
  <span class="right"><span onclick="delMetricFun('perfMetircBox','<s:property value="resourceId"/>')" class="r-ico r-ico-close"></span> 
  <span onclick="addMetricFun('<s:property value='@com.mocha.bsm.script.monitor.obj.extension.ResourceMetric@METRIC_PERF'/>')" class="r-ico r-ico-add"></span></span></div>
  <div>
    <table class="monitor-items-head02 border-gray" width="100%" cellspacing="0" cellpadding="0">
      <thead>
        <tr>
          <th width="4%"><label>
            <input name="perfMetircBoxAll" onclick="setAllSelectFun('perfMetircBoxAll','perfMetircBox');" type="checkbox" id="perfMetircBoxAll" />
          </label></th>
          <th width="36%" height="24">指标名称</th>
          <th width="52%">指标描述</th>
          <th width="8%">操作</th>
          </tr>
        </thead>
        <tbody>
	        <s:set name="perfList" value="resourceMetrics[@com.mocha.bsm.script.monitor.obj.extension.ResourceMetric@METRIC_PERF]"/>
	        <s:iterator value="#perfList" id="list">
	          <tr>
		          <td><input name="metricIdBox" type="checkbox" checkBoxName="perfMetircBox" onclick="alertAllCheckBoxFun('perfMetircBoxAll','perfMetircBox');" id="perfMetircBox<s:property value='#list.metricId'/>" value="<s:property value='#list.metricId'/>" /></td>
		          <td height="24"><s:property value="#list.metricName"/></td>
		          <td><s:property value="#list.description"/></td>
		          <td><span style="cursor:pointer" onclick="executeMetricOperate('<s:property value='#list.metricId'/>')" class="ico ico-t-right"></span></td>
	          </tr>
	        </s:iterator>  
      	</tbody>
    </table>
  </div>
  </div>
  <div class="fold-blue padding5" style="margin-bottom:8px;">
  <div class="fold-top"> 
  <span class="fold-top-title left">配置指标</span>
  <span class="right"><span onclick="delMetricFun('confMetircBox','<s:property value="resourceId"/>')" class="r-ico r-ico-close"></span> 
  <span onclick="addMetricFun('<s:property value='@com.mocha.bsm.script.monitor.obj.extension.ResourceMetric@METRIC_CONFIG'/>')" class="r-ico r-ico-add"></span></span></div>
  <div>
    <table class="monitor-items-head02 border-gray" width="100%" cellspacing="0" cellpadding="0">
      <thead>
        <tr>
          <th width="4%"><label>
            <input name="confMetircBoxAll" onclick="setAllSelectFun('confMetircBoxAll','confMetircBox');" type="checkbox" id="confMetircBoxAll" />
          </label></th>
          <th width="36%" height="24">指标名称</th>
          <th width="52%">指标描述</th>
          <th width="8%">操作</th>
          </tr>
        </thead>
        <tbody>
        	<s:set name="configList" value="resourceMetrics[@com.mocha.bsm.script.monitor.obj.extension.ResourceMetric@METRIC_CONFIG]"/>
	        <s:iterator value="#configList" id="list">
	          <tr>
		          <td><input name="metricIdBox" checkBoxName="confMetircBox" onclick="alertAllCheckBoxFun('confMetircBoxAll','confMetircBox');"  type="checkbox" id="confMetircBox" value="<s:property value='#list.metricId'/>" /></td>
		          <td height="24"><s:property value="#list.metricName"/></td>
		          <td><s:property value="#list.description"/></td>
		          <td><span style="cursor:pointer" onclick="executeMetricOperate('<s:property value='#list.metricId'/>')" class="ico ico-t-right"></span></td>
	          </tr>
	        </s:iterator>  
        </tbody>
    </table>
  </div>
  </div>
  <div class="fold-blue padding5" style="margin-bottom:8px;">
  <div class="fold-top"> 
  <span class="fold-top-title left">信息指标</span>
  <span class="right"><span onclick="delMetricFun('infoMetircBox','<s:property value="resourceId"/>')" class="r-ico r-ico-close"></span> 
  <span onclick="addMetricFun('<s:property value='@com.mocha.bsm.script.monitor.obj.extension.ResourceMetric@METRIC_INFO'/>')" class="r-ico r-ico-add"></span></span></div>
  <div>
    <table class="monitor-items-head02 border-gray" width="100%" cellspacing="0" cellpadding="0">
      <thead>
        <tr>
          <th width="4%"><label>
            <input name="infoMetircBoxAll"  onclick="setAllSelectFun('infoMetircBoxAll','infoMetircBox');" type="checkbox" id="infoMetircBoxAll" />
          </label></th>
          <th width="36%" height="24">指标名称</th>
          <th width="52%">指标描述</th>
          <th width="8%">操作</th>
          </tr>
        </thead>
        <tbody>
        	<s:set name="infoList" value="resourceMetrics[@com.mocha.bsm.script.monitor.obj.extension.ResourceMetric@METRIC_INFO]"/>
	        <s:iterator value="#infoList" id="list">
	          <tr>
		          <td><input name="metricIdBox" checkBoxName="infoMetircBox" onclick="alertAllCheckBoxFun('infoMetircBoxAll','infoMetircBox');" type="checkbox" id="infoMetircBox" value="<s:property value='#list.metricId'/>" /></td>
		          <td height="24"><s:property value="#list.metricName"/></td>
		          <td><s:property value="#list.description"/></td>
		          <td><span style="cursor:pointer" onclick="executeMetricOperate('<s:property value='#list.metricId'/>')" class="ico ico-t-right" title="操作"/></td>
	          </tr>
	        </s:iterator>  
        </tbody>
    </table>
  </div>
  </div>
  </div>
</div>
<script>
	function addMetricFun(metricCategoryId){
		var resourceId = "<s:property value='resourceId'/>";
		openWinFun("${ctx}/scriptmonitor/repository/addMetric.action?resourceId="+resourceId+"&metric.metricType="+metricCategoryId,"addMetric","tab2");
	}
	function executeMetricOperate(metricId){
		var resourceId = "<s:property value='resourceId'/>";
		var parentId = "<s:property value='parentId'/>";
		var mc = new MenuContext({x:0,y:0,width:100,
			listeners:{click:function(id){alert(id)}}},
			{menuContext_DomStruFn:"ico_menuContext_DomStruFn"}
		);
		mc.position(event.x,event.y);
		mc.addMenuItems([[ 
		{ico:"edit",text:"编辑指标",id:"editMetric",listeners:{
			click:function(){
				openWinFun("${ctx}/scriptmonitor/repository/addMetric.action?parentId="+parentId+"&resourceId="+resourceId+"&metricId="+metricId,"editMetric","tab2");
			}
		}}
		]]);
	}
	$(document).ready(function(){
		dialogResize();
	});
	
</script>
