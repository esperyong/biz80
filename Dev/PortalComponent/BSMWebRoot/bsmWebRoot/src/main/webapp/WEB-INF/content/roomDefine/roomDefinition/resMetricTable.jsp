<!-- 机房-机房定义-属性-指标页面 resMetricTable.jsp -->
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<script type="text/javascript" src="${ctx}/js/component/combobox/simplebox.js"></script>
<table>
<div class="h2">
<span class="r-ico r-ico-close" alt="删除" onclick="delMetricFun('<s:property value='roomId' />','<s:property value='fitRes.catalog.id' />','<s:property value='fitRes.id' />');"></span>
<span class="r-ico r-ico-add" alt="添加" onclick="addMetricFun('<s:property value='roomId' />','<s:property value='fitRes.catalog.id' />','<s:property value='fitRes.id' />');"></span>
</div>
	<thead>
		<tr>
			<th><input type="checkbox" id="allChoose" name="allChoose" onClick="allCheck()" value="dd" />全选</th>
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
		<s:iterator value="fitRes.metric" id="mapSun" status="stat">
			<tr>
				<!-- 全选 -->
				<td><input type="hidden"
					name="metrics[<s:property value='%{#stat.index}'/>].id"
					value="<s:property value='#mapSun.value.id' />" /> <input
					type="checkbox" name="<s:property value='fitRes.id' />_checkOne"
					value="<s:property value='#mapSun.value.id' />" /></td>
				<!-- 指标名称 -->
				<td><input type="hidden"
					name="metrics[<s:property value='%{#stat.index}'/>].name"
					value="<s:property value='#mapSun.value.name' />"> </input> <input
					type="hidden"
					name="metrics[<s:property value='%{#stat.index}'/>].basic.type"
					value="<s:property value='#mapSun.value.basic.type' />"> </input> <span title="<s:property
					value="#mapSun.value.name" />"><s:property
					value="#mapSun.value.name" /></span></td>
				<!-- 指标类型  -->
				<td>
				<input type="hidden"
					name="metrics[<s:property value='%{#stat.index}'/>].typeName"
					value="<s:property value='#mapSun.value.basic.typeName' />"> </input>  <s:property
					value="#mapSun.value.basic.typeName" />
				</td>
				<!-- 监控频度 -->
				<td ><s:iterator value="#mapSun.value.basic" id="map">
					<s:if test="'frequency'==#map.key">
						<s:set value="#map.value" name="aaa"></s:set>
					</s:if>
					<s:if test="'maxvalue'==#map.key">
						<s:set value="#map.value" name="maxvalue"></s:set>
					</s:if>
					<s:if test="'minvalue'==#map.key">
						<s:set value="#map.value" name="minvalue"></s:set>
					</s:if>
				</s:iterator> <SELECT id="<s:property value='#mapSun.value.id' />_frequency" style="width:62px;left:-4px;position:relative"
					name="metrics[<s:property value='%{#stat.index}'/>].basic.frequency"
					class="validate[required]">
					<s:iterator value="allFrequency" id="map">
						<s:if test="#map.key==#aaa">
							<option value="<s:property value="#map.key" />"
								selected="selected"><s:property value="#map.value" /></option>
						</s:if>
						<s:else>
							<option value="<s:property value="#map.key" />"><s:property
								value="#map.value" /></option>
						</s:else>

					</s:iterator>
				</SELECT></td>
				<!-- 阈值 -->
				<td>
				
				<s:if test="#mapSun.value.basic.maxvalue == ''">
						<span>-</span> 
				</s:if>
				<s:else>
				<ul>
					<input type="hidden"
						name="metrics[<s:property value='%{#stat.index}'/>].basic.unit"
						value="<s:property value='#mapSun.value.basic.unit' />" />
					<input type="hidden"
						name="metrics[<s:property value='%{#stat.index}'/>].basic.maxvalue"
						value="<s:property value='#mapSun.value.basic.maxvalue' />" />


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
					<input type="hidden"
						name="metrics[<s:property value='%{#stat.index}'/>].basic.minvalue"
						value="<s:property value='#mapSun.value.basic.minvalue' />" />
					<!-- 
					<li><s:property value="#mapSun.value.basic.minvalue" /> <s:property
						value="#mapSun.value.basic.unit" /></li>
					-->
					
				</ul>
				</s:else>
				</td>
				<!-- 事件 -->
				<td>
				<!-- 信息指标不展现此列 -->
				<s:if test="#mapSun.value.basic.maxvalue!=''"> 
				<ul>
					<input type="hidden"
						name="metrics[<s:property value='%{#stat.index}'/>].errordef.name"
						value="<s:property value='#mapSun.value.errordef.name' />">
					</input>
					<input type="hidden"
						name="metrics[<s:property value='%{#stat.index}'/>].errordef.type"
						value="<s:property value='#mapSun.value.errordef.type' />">
					</input>
					<li class="red">异常</li>
					<input type="hidden"
						name="metrics[<s:property value='%{#stat.index}'/>].normaldef.name"
						value="<s:property value='#mapSun.value.normaldef.name' />">
					<input type="hidden"
						name="metrics[<s:property value='%{#stat.index}'/>].normaldef.type"
						value="<s:property value='#mapSun.value.normaldef.type' />">
					</input>
					<li style="color:#00ff00">恢复正常</li>
				</ul>
				</s:if>
				<s:else>
					<span>-</span>
				</s:else>
				</td>
				<!-- 级别 -->
				<td>
				<!-- 信息指标不展现此列 -->
				<s:if test="#mapSun.value.basic.maxvalue!=''"> 
				<ul>
					<li style="height:100%"><s:set value="#mapSun.value.errordef.level"
						name="errorDef"></s:set> <SELECT
						id="<s:property value='#mapSun.value.id' />_errorLevel"
						name="metrics[<s:property value='%{#stat.index}'/>].errordef.level"
						class="validate[required]" style="width:62px;left:-4px;position:relative">
						<s:iterator value="allEventLevel" id="map">
							<s:if test="#errorDef==#map.key">
								<option value="<s:property value="#map.key" />"
									selected="selected"><s:property value="#map.value" /></option>
							</s:if>
							<s:else>
								<option value="<s:property value="#map.key" />"><s:property
									value="#map.value" /></option>
							</s:else>
						</s:iterator>
					</SELECT></li>
					<li style="height:100%"><s:set value="#mapSun.value.normaldef.level"
						name="normalDef"></s:set> <SELECT
						id="<s:property value='#mapSun.value.id' />_normalLevel"
						name="metrics[<s:property value='%{#stat.index}'/>].normaldef.level"
						class="validate[required]" style="width:62px;left:-4px;position:relative">
						<s:iterator value="allEventLevel" id="map">
							<s:if test="#normalDef==#map.key">
								<option value="<s:property value="#map.key" />"
									selected="selected"><s:property value="#map.value" /></option>
							</s:if>
							<s:else>
								<option value="<s:property value="#map.key" />"><s:property
									value="#map.value" /></option>
							</s:else>
						</s:iterator>
					</SELECT></li>
				</ul>
				</s:if>
				<s:else>
					<span>-</span>
				</s:else>
				</td>

				<!-- 是否告警 -->
				<td>
				<!-- 信息指标不展现此列 -->
				<s:if test="#mapSun.value.basic.maxvalue!=''"> 
				<ul>
   			       <li><s:set value="#mapSun.value.errordef.isAlarm" name="erroralarm" />
   			        <input type="checkbox" name="metrics[<s:property value='%{#stat.index}'/>].errordef.isAlarm" value="true" <s:if test="#erroralarm=='true'">checked</s:if> />
    		      </li>
    		      <li><s:set value="#mapSun.value.normaldef.isAlarm" name="normalalarm" />
    		        <input type="checkbox" name="metrics[<s:property value='%{#stat.index}'/>].normaldef.isAlarm" value="true" <s:if test="#normalalarm=='true'">checked</s:if> />
     		      </li>
     		    </ul>
     		    </s:if>
     		    <s:else>
					<span>-</span>
				</s:else>
				</td>
				<!-- 取值 -->
				<td><div class="ico ico-edit" onclick="modifyMetricFun('<s:property value='roomId' />','<s:property value='fitRes.catalog.id' />','<s:property value='fitRes.id' />','<s:property value='#mapSun.value.id' />','<s:property value='#mapSun.value.basic.type' />');"></div></td>
				</td>
			</tr>
		</s:iterator>
	</tbody>
</table>
<input type="hidden" name="roomId" id="roomId"
	value="<s:property value='roomId' />" />
<input type="hidden" name="delMetricId" id="delMetricId"
	value="" />
<input type="hidden" name="isModelRes" id="isModelRes"
	value="<s:property value='isModelRes' />" />
<input type="hidden" name="metricType" id="metricType"
	value="" />
<script type="text/javascript">
	function allCheck(){
		//alert($("#allChoose").attr("checked"));
		var i;
		for(i=0;i<$("table").find("input").length;i++){
			if ($("table").find("input").get(i).name == '<s:property value="fitRes.id" />_checkOne'){
				$("table").find("input").get(i).checked = $("#allChoose").attr("checked"); 
			}
		}
	}
	SimpleBox.renderAll();
</script>