<%--  
 *************************************************************************
 * @source  : info-component.jsp
 * @desc    : Mocha BSM 8.0
 *------------------------------------------------------------------------
 * VER  DATE         AUTHOR      DESCRIPTION
 * ---  -----------  ----------  -----------------------------------------
 * 1.0  2011.5.19	 huaf     	 组件定义
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
  <div style="background-color:#fff;">
  <div class="fold-blue padding5" style="margin-bottom:8px;">
  <div class="fold-top"> 
  <span class="fold-top-title left">组件列表</span>
  <span class="right"><span id="delComponent"  class="r-ico r-ico-close"></span> 
  <span id="addComponent" class="r-ico r-ico-add"></span></span></div>
  <div>
    <ul class="">
		<li>
		<table class="monitor-items-head">
			<thead>
				<tr>					
					<th width="4%">
						<label>
		            		<input name="checkbox" onclick="setAllSelectFun('componentBoxAll','componentBox');" type="checkbox" id="componentBoxAll" />
		          		</label>
		          	</th>
			        <th width="36%" height="24">组件名称</th>
			        <th width="52%">组件描述</th>
			        <th width="8%">操作</th>
				</tr>
			</thead>
		</table>
		</li>
		<s:iterator value="resourceComponents" id="list">
			<li>
				<table class="monitor-items-list">
					<tbody>
						<tr>
							<td width="4%">
								
								<label>
									<s:if test="#list.extension">
										<input name="componentIdBox" type="checkbox" checkBoxName="componentBox" onclick="alertAllCheckBoxFun('componentBoxAll','componentBox');" id="checkbox" value="<s:property value='#list.resourceId'/>"/>
									</s:if>
									<s:else>
										<input name="componentIdBox" type="checkbox" id="checkbox" value="<s:property value='#list.resourceId'/>" disabled/>
									</s:else>
			            			
			          			</label>
							</td>
							<td width="36%" height="24"><s:property value="#list.resourceName"/><span btn="fold" id="<s:property value="#list.resourceId"/>" class="monitor-ico monitor-ico-open"></td>
							<td width="52%"><s:property value="#list.resourceDescription"/></td>
							<td width="8%"><span style="cursor:pointer" id="componentOperate" onclick="executeOperate('<s:property value="#list.resourceId"/>',<s:property value="#list.extension"/>)"  class="ico ico-t-right" title="操作"/></td>
						</tr>
					</tbody>
				</table>
				<div class="monitor-target" id="<s:property value="#list.resourceId"/>_next" style="display:none"></div>
			</li>
			</s:iterator>
	</ul>
  </div>
  </div>
  </div>
</div>

<script>
	var parentId = "<s:property value='resourceId'/>";
	$("span[btn='fold']").each(function(index){
		$(this).bind("click",function(){
			var resourceId = $(this).attr("id");
			var $html = $("#"+resourceId+"_next");
			if($(this).hasClass("monitor-ico-open")){
				$html.toggle(openBtnFun($(this)));
			}else{
				$html.toggle(closeBtnFun($(this)));
			}
			showMetricFun(parentId,resourceId,$html);
		});
	});
	$("#addComponent").bind("click",function(){
		openWinFun("${ctx}/scriptmonitor/repository/addComponent.action?resourceId="+parentId,"addComponent","tab3");
	});
	$("#delComponent").bind("click",function(){
		var checkBoxValue=$("input[name='componentIdBox']:checked").serialize();
		if(checkBoxValue && checkBoxValue!=""){
			var param = checkBoxValue+"&resourceId=<s:property value='resourceId'/>";
			var url = "${ctx}/scriptmonitor/repository/delModelExtend!delComponent.action";
			delComponentFun(url,param);
		}else{
			doInformatAlter();
			return;
		}
	});
	function executeOperate(resourceId,isExtension){
		var mc = new MenuContext({x:0,y:0,width:100,
			listeners:{click:function(id){alert(id)}}},
			{menuContext_DomStruFn:"ico_menuContext_DomStruFn"}
		);
		mc.position(event.x,event.y);
		if(!isExtension){
			mc.addMenuItems([[
         		{ico:"add",text:"添加指标",id:"addMetric",listeners:{
         			click:function(){
         				openWinFun("${ctx}/scriptmonitor/repository/addMetric.action?parentId="+parentId+"&resourceId="+resourceId,"addMetric","tab3");
         			}
         		}}
         	]]);
		}else{
			mc.addMenuItems([[
          		{ico:"delete",text:"删除",id:"delComponent",listeners:{
          			click:function(){
          				var param = "componentId="+resourceId;
          				var url = "${ctx}/scriptmonitor/repository/delModelExtend!delComponent.action";
          				delComponentFun(url,param);
          			}
          		}},
          		{ico:"edit",text:"编辑组件",id:"editComponent",listeners:{
          			click:function(){
          				openWinFun("${ctx}/scriptmonitor/repository/addComponent.action?resourceId="+parentId+"&componentId="+resourceId,"editComponent","tab3");
          			}
          		}},                  
          		{ico:"add",text:"添加指标",id:"addMetric",listeners:{
          			click:function(){
          				openWinFun("${ctx}/scriptmonitor/repository/addMetric.action?parentId="+parentId+"&resourceId="+resourceId,"addMetric","tab3");
          			}
          		}}
          	]]);
		}
	}
	
	$(document).ready(function(){
		dialogResize();
	});
</script>
