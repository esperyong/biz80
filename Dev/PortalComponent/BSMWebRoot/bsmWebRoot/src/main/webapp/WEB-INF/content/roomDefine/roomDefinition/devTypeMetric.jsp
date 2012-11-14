<!-- 机房-机房定义-机房设施配置-指标 devTypeMetric.jsp -->
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<%@ page import="com.opensymphony.xwork2.util.*"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script src="${ctx}/js/component/cfncc.js"></script>
<script src="${ctx}/js/component/tabPanel/tab.js"></script>
<script type="text/javascript" src="${ctx}/js/component/menu/menu.js"></script>
<script type="text/javascript" src="${ctx}/js/component/popwindow/popwin.js"></script>
<script type="text/javascript" src="${ctx}/js/component/comm/winopen.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery.blockUI.js"></script>
<script type="text/javascript" src="${ctx}/js/component/toast/Toast.js"></script>
<script type="text/javascript" src="${ctx}/js/component/combobox/simplebox.js"></script>
<link rel="stylesheet" href="${ctx}/css/UIComponent.css" type="text/css" /> 

<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>机房设施配置</title>
<%
	int rowInds=0;
%>

					<table>
					<div class="h2"><span class="r-ico r-ico-close" onclick="delMetricFun('<s:property value='catalogId' />','<s:property value='resourceId' />');" alt="删除"></span><span class="r-ico r-ico-add" alt="添加" onclick="addMetricFun('<s:property value='catalogId' />','<s:property value='resourceId' />');"></span></div>
						<thead>
							<tr>
								<th><input type="checkbox" name="checkAll" id="<s:property value='resource.id' />_checkAll" onclick="selectAll('<s:property value='resourceId' />',this);"/>全选</th>
								<th>指标名称</th>
								<th>指标类型</th>
								<th>监控频度</th>
								<th>阈值</th>
								<th>事件</th>
								<th>级别</th>
								<th>是否告警</th>
								<th>编辑</th>
							</tr>
						</thead>
						<tbody>
						<s:iterator value="resource.metric" id="mapSun" status="indexSun" >
							<tr>
								<td>
									<input type="hidden" name="metrics[<%=rowInds %>].id" value="<s:property value='#mapSun.value.id' />" />
									<input type="checkbox" name="<s:property value='resource.id' />_checkOne" value="<s:property value='#mapSun.value.id' />" />
								</td>
								<td>
									<input type="hidden" name="metrics[<%=rowInds %>].name" value="<s:property value='#mapSun.value.name' />" />
									<s:property value="#mapSun.value.name" />
								</td>
								<td>
									<input type="hidden" name="metrics[<%=rowInds %>].basic.type" value="<s:property value='#mapSun.value.basic.type' />" />
									<s:property value="#mapSun.value.basic.typeName" />
								</td>
								<s:iterator value="#mapSun.value.basic" id="map">
									<s:if test="'frequency'==#map.key">
										<s:set value="#map.value" name="aaa"></s:set>
									</s:if>
									<s:if test="'minvalue'==#map.key">
										<s:set value="#map.value" name="minvalue"></s:set>
									</s:if>
									<s:if test="'maxvalue'==#map.key">
										<s:set value="#map.value" name="maxvalue"></s:set>
									</s:if>
				   				</s:iterator>
								<td>
								<SELECT id="<s:property value='#mapSun.value.id' />_chooseFrequency" name="metrics[<%=rowInds %>].basic.frequency" class="validate[required]" style="width:62px;left:-4px;position:relative">
					   				<s:iterator value="allFrequency" id="map">
					   					<s:if test="#map.key==#aaa">
					   					<option value="<s:property value="#map.key" />" selected="selected"><s:property value="#map.value" /></option>
					   					</s:if>
					   					<s:else>
					   					<option value="<s:property value="#map.key" />" ><s:property value="#map.value" /></option>
					   					</s:else>
					   					
					   				</s:iterator>
					   			</SELECT>
								</td>
								<td>
									<ul>
										<input type="hidden" name="metrics[<%=rowInds %>].basic.unit" value="<s:property value='#mapSun.value.basic.unit' />" />
										<input type="hidden" name="metrics[<%=rowInds %>].basic.minvalue" value="<s:property value='#mapSun.value.basic.minvalue' />" />
										<input type="hidden" name="metrics[<%=rowInds %>].basic.maxvalue" value="<s:property value='#mapSun.value.basic.maxvalue' />" />
										<s:if test="#mapSun.value.basic.maxvalue!=''">
											<s:if test="#mapSun.value.basic.type.startsWith('digital')">
												<li> 
													<div class="cue-min">
														<div class="limit limit-red" style="display:"></div>
														<div class="cue-content">
															<span class="cue-min-red" style="height:40%">
																<span class="cue-min-note cue-min-note-red"><s:if test="#mapSun.value.basic.minvaluestate==1"><s:property value="#mapSun.value.basic.minvalue" /></s:if><s:if test="#mapSun.value.basic.maxvaluestate==1"><s:property value="#mapSun.value.basic.maxvalue" /></s:if> <s:property value="#mapSun.value.basic.unit" /></span>
															</span>
														 	<span class="cue-min-green">
														 		<span class="cue-min-note cue-min-note-green" ><s:if test="#mapSun.value.basic.minvaluestate==0"><s:property value="#mapSun.value.basic.minvalue" /></s:if><s:if test="#mapSun.value.basic.maxvaluestate==0"><s:property value="#mapSun.value.basic.maxvalue" /></s:if> <s:property value="#mapSun.value.basic.unit" /></span>
														 	</span>	
														 </div>
														  <div class="limit limit-green"></div>
													</div>
												</li>
											</s:if>
											<s:else>
												
												<li> 
													<div class="cue-min">
														<div class="limit limit-red" style="display:"></div>
														<div class="cue-content">
															<span class="cue-min-red" style="height:35%" >
																<span class="cue-min-note cue-min-note-green"><s:property value="#mapSun.value.basic.maxvalue" /> <s:property value="#mapSun.value.basic.unit" /></span>
															</span>
														 	<span class="cue-min-green" style="height:35%;top:35%">
														 		<span class="cue-min-note cue-min-note-green" ><s:property value="#mapSun.value.basic.minvalue" /> <s:property value="#mapSun.value.basic.unit" /></span>
														 	</span>	
														 	<span class="cue-min-red" style="height:30%;top:70%" >
														 	</span>
														 </div>
														  <div class="limit limit-red"></div>
													</div>
											</li>
											</s:else>
										</s:if>
											<s:else>
												<li>-</li>
											</s:else>
										<!-- 
										<li>
											<s:property value="#maxvalue" /><s:property value="#mapSun.value.basic.unit" />
										</li>
										<input type="hidden" name="metrics[<%=rowInds %>].basic.maxvalue" value="<s:property value='#mapSun.value.basic.maxvalue' />" />
										<li>
											<s:property value="#minvalue" /><s:property value="#mapSun.value.basic.unit" />
										</li>
										 -->
									</ul>
								</td>
								<td>
									<!-- 信息指标不展现此列 -->
									<s:if test="#mapSun.value.basic.type!='info'"> 
										<ul>
											<input type="hidden"
												name="metrics[<%=rowInds %>].errordef.name"
												value="<s:property value='#mapSun.value.errordef.name' />">
											</input>
											<input type="hidden"
												name="metrics[<%=rowInds %>].errordef.type"
												value="<s:property value='#mapSun.value.errordef.type' />">
											</input>
											<li class="red">
												<s:property value="#mapSun.value.errordef.name" />
											</li>
											<input type="hidden"
												name="metrics[<%=rowInds %>].normaldef.name"
												value="<s:property value='#mapSun.value.normaldef.name' />">
											<input type="hidden"
												name="metrics[<%=rowInds %>].normaldef.type"
												value="<s:property value='#mapSun.value.normaldef.type' />">
											</input>
											<li style="color:#00ff00">
												<s:property value="#mapSun.value.normaldef.name" />
											</li>
										</ul>
									</s:if>
									<s:else>
										<ul>
											<li>-</li>
										</ul>
									</s:else>
								</td>
								<td>
									<!-- 信息指标不展现此列 -->
									<s:if test="#mapSun.value.basic.type!='info'"> 
									<ul>
										<li style="height:100%">
											<s:set value="#mapSun.value.errordef.level" name="errorDef"></s:set>
											<SELECT id="<s:property value='#mapSun.value.id' />_errorLevel" name="metrics[<%=rowInds %>].errordef.level" class="validate[required]" style="width:62px;left:-4px;position:relative">
											<s:iterator value="allEventLevel" id="map">
												<s:if test="#errorDef==#map.key">
													<option value="<s:property value="#map.key" />" selected="selected" ><s:property value="#map.value" /></option>
												</s:if>
												<s:else>
													<option value="<s:property value="#map.key" />" ><s:property value="#map.value" /></option>
												</s:else>
						   					</s:iterator>
						   					</SELECT>
								   		</li>
										<li style="height:100%">
											<s:set value="#mapSun.value.normaldef.level" name="normalDef"></s:set>
											<SELECT id="<s:property value='#mapSun.value.id' />_normalLevel" name="metrics[<%=rowInds %>].normaldef.level" class="validate[required]" style="width:62px;left:-4px;position:relative">
											<s:iterator value="allEventLevel" id="map">
												<s:if test="#normalDef==#map.key">
													<option value="<s:property value="#map.key" />" selected="selected" ><s:property value="#map.value" /></option>
												</s:if>
												<s:else>
													<option value="<s:property value="#map.key" />" ><s:property value="#map.value" /></option>
												</s:else>
						   					</s:iterator>
						   					</SELECT>
										</li>
									</ul>
									</s:if>
									<s:else>
										<ul>
											<li>-</li>
										</ul>
									</s:else>
								</td>
								<td>
									
									<!-- 信息指标不展现此列 -->
									<s:if test="#mapSun.value.basic.type!='info'"> 
									<ul>
										<li><s:set value="#mapSun.value.errordef.isAlarm" name="erroralarm" />
										   <!-- <input type="hidden" id="metrics[<%=rowInds %>].errordef.isAlarm" name="metrics[<%=rowInds %>].errordef.isAlarm" value="<s:property value='#mapSun.value.errordef.isAlarm'/>" /> -->
											<input type="checkbox" name="metrics[<%=rowInds %>].errordef.isAlarm" value="true"  <s:if test="#erroralarm=='true'">checked</s:if> />
										    
										</li>
										<li><s:set value="#mapSun.value.normaldef.isAlarm" name="normalalarm" />
										    <!-- <input type="hidden" name="metrics[<%=rowInds %>].normaldef.isAlarm" value="<s:property value='#mapSun.value.normaldef.isAlarm'/>" /> -->
											<input type="checkbox" name="metrics[<%=rowInds %>].normaldef.isAlarm" value="true" <s:if test="#normalalarm=='true'">checked</s:if> />
										    
										</li>
									</ul>
									</s:if>
									<s:else>
										<ul>
											<li>-</li>
										</ul>
									</s:else>
								</td>
								<td><div class="ico ico-edit" onclick="updateMetricFun('<s:property value='catalogId' />','<s:property value='resource.id' />','<s:property value='#mapSun.value.id' />');"></div></td>
							</tr>
							<%rowInds++; %>
						</s:iterator>
						</tbody>
					</table>
					
<script type="text/javascript">

function selectAll(id,obj) {
	if(obj.checked) {
		$("[name='"+id+"_checkOne']").attr("checked",'true');//全选
	}else{
		$("[name='"+id+"_checkOne']").removeAttr("checked");//取消全选
	}
}

//添加指标
function addMetricFun(ic,id) {
	var theLeft=(screen.width - 450)/2;
	var theTop = (screen.height - 330)/2;
	window.open("${ctx}/roomDefine/AddMetricVisit.action?modifytype=model&resourceId="+id+"&catalogId="+ic,"_blank","left="+theLeft+",top="+theTop+",width=450,height=330,scrollbars=yes");
}

//删除指标
function delMetricFun(ic,id) {
	var _confirm = new confirm_box({text:"是否确认执行此操作？"});
	
	_confirm.setConfirm_listener(function(){
		var checkName = id+"_checkOne";
		var che = $("input[name='"+checkName+"']:checkbox:checked");  
		var delId = "";
		 if(che != null && (che.length>0)) {
			 for(i=0;i<che.length;i++) {
				 delId += $(che[i]).val() +",";
			 }
		 }

		 $("#formID").attr("action","${ctx}/roomDefine/DeleteMetric.action?type=model&resourceId="+id+"&catalogId="+ic+"&delId="+delId);
		$("#formID").submit();
		_confirm.hide();
	});
	_confirm.show();
	
}

//更新指标
function updateMetricFun(ic,resId,id) {
	var theLeft=(screen.width - 450)/2;
	var theTop = (screen.height - 330)/2;
	window.open("${ctx}/roomDefine/UpdateMetricVisit.action?modifytype=model&catalogId="+ic+"&resourceId="+resId+"&metricId="+id,"_blank","left="+theLeft+",top="+theTop+",width=450,height=330,scrollbars=yes");
}

function alarmClick(alarm){
	alarm.value = alarm.checked; 
}
SimpleBox.renderAll();
</script>