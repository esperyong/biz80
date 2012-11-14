<%@ page language="java" contentType="text/html; charset=UTF-8"pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
	<table  class="tongji-grid table-width100 whitebg grayborder" style="border: 1px solic #ccc; overflow: scroll;">
	<tr>
		<th rowspan="2" style="width:170px"><input type="checkbox" id="Performance_Checkbox" onclick="fullChoice(this)" />标题</th>
		<th rowspan="2" style="width:120px">资源类型</th>
		<th rowspan="2">资源 <span class="red">*</span></th>
		<th rowspan="2">组件类型</th>
		<th rowspan="2">组件</th>
		<th rowspan="2">指标<span class="red">*</span></th>
		<th rowspan="2">设置</th>
		<th colspan="2" class="rt  textalign">显示内容</th>
		<th rowspan="2">预览</th> 
	</tr>
	<tr>
		<th class="rb textalign">汇总数据<span class="ico ico-what" title="当前报告周期内采集到的所有指标值汇总为一条记录，即最大值、最小值、平均值"></span></th>
		<th class="rb textalign">详细数据<span class="ico ico-what" title="当前报告周期内采集到的所有指标值汇总为多条记录，即最大值、最小值、平均值"></span></th>
	</tr>
	<tr><td colspan="10"  style="padding: 0 0 0 0;height:226px;">
		 <div >		 	
		 	<table id="PerformanceTable" border="0" width="100%" cellpadding="0" cellspacing="0">
		 	<s:if test="reportInfo!=null">		 	
		 	<s:iterator  var="info" value="reportInfo"  status="stat">
				<s:if test="#stat.count>0">
					<tr id="Performance_tr_<s:property value="#stat.index" />">
					<td style="width:170px">
					    <input type="checkbox" name="reportInfoName" id="<s:property value="#stat.index" />" />
						<input type="text" id="Performance_reportInfoName_<s:property value="#stat.index" />" value="<s:property value="#info.name" />" disabled=true/>
						<input type="hidden"  name="reportInfo[<s:property value="#stat.index" />].id" id="Performance_idValue_<s:property value="#stat.index" />" value="<s:property value="#info.id" />" />
						<input type="hidden"  name="reportInfo[<s:property value="#stat.index" />].name" id="Performance_nameValue_<s:property value="#stat.index" />"  value="<s:property value="#info.name" />"/>
					</td>
					<td style="width:120px">
						<input type="hidden"  name="reportInfo[<s:property value="#stat.index" />].resoureType" id="Performance_resoureTypeValue_<s:property value="#stat.index" />" value="<s:property value="#info.resoureType" />"/>
						<input type="hidden"  name="reportInfo[<s:property value="#stat.index" />].resoureName" id="Performance_resoureNameValue_<s:property value="#stat.index" />" value="<s:property value="#info.resoureName" />"/>
						<input type="hidden"  name="reportInfo[<s:property value="#stat.index" />].resourceModel" id="Performance_resourceModelValue_<s:property value="#stat.index" />" value="<s:property value="#info.resourceModel" />"/>			
						<span id="Performance_resoureType_<s:property value="#stat.index" />"><s:property value="#info.resoureName" /></span>
					</td>
					<td>
						<input type="hidden"  name="reportInfo[<s:property value="#stat.index" />].resFilter" id="Performance_resFilter_<s:property value="#stat.index" />" value="<s:property value="#info.resFilter" />"/>
						<input type="hidden"  name="reportInfo[<s:property value="#stat.index" />].resources" id="Performance_resouresValue_<s:property value="#stat.index" />" value="<s:property value="#info.resources" />"/>						
						<input type="hidden"  name="reportInfo[<s:property value="#stat.index" />].customsInfoType" id="Performance_customsInfoTypeValue_<s:property value="#stat.index" />" value="<s:property value="#info.customsInfoType" />"/>
						<input type="hidden"  name="reportInfo[<s:property value="#stat.index" />].customsCondition" id="Performance_customsConditionValue_<s:property value="#stat.index" />" value="<s:property value="#info.customsCondition" />" />
						<input type="hidden"  name="reportInfo[<s:property value="#stat.index" />].customsValue" id="Performance_customsValue_<s:property value="#stat.index" />" value="<s:property value="#info.customsValue" />" />
						<input type="hidden"  name="reportInfo[<s:property value="#stat.index" />].domainId" id="Performance_domainIdValue_<s:property value="#stat.index" />" value="<s:property value="#info.domainId" />" />
						<span id="Performance_resoureNum_<s:property value="#stat.index" />" ><s:property value="#info.resourcesNum" />个</span>
					</td>
					<td>
						<input type="hidden"  name="reportInfo[<s:property value="#stat.index" />].componentType" id="Performance_componentTypeValue_<s:property value="#stat.index" />" value="<s:property value="#info.componentType" />"  />
						<input type="hidden"  name="reportInfo[<s:property value="#stat.index" />].componentName" id="Performance_componentNameValue_<s:property value="#stat.index" />" value="<s:property value="#info.componentName" />"  />
						<s:if test="#info.componentType!=null">															
							<span id="Performance_compomentType_<s:property value="#stat.index" />" ><s:property value="#info.componentName" /></span>
						</s:if>
						<s:else>
							<span id="Performance_compomentType_<s:property value="#stat.index" />" >-</span>
						</s:else>
					</td>
					<td>
						<input type="hidden"  name="reportInfo[<s:property value="#stat.index" />].componentRes" id="Performance_componentResValue_<s:property value="#stat.index" />" value="<s:property value="#info.componentRes" />" />						
						<input type="hidden"  name="reportInfo[<s:property value="#stat.index" />].components" id="Performance_componentsValue_<s:property value="#stat.index" />" value="<s:property value="#info.components" />" />						
						<s:if test="#info.componentType!=null">							
							<span id="Performance_componentNum_<s:property value="#stat.index" />" ><s:property value="#info.componentsNum" />个</span>
						</s:if>
						<s:else>
							<span id="Performance_componentNum_<s:property value="#stat.index" />" >-</span>							
						</s:else>						
					</td>
					<td>
						<input type="hidden"  name="reportInfo[<s:property value="#stat.index" />].metrics" id="Performance_metricValue_<s:property value="#stat.index" />"  value="<s:property value="#info.metrics" />"  />
						<input type="hidden"  name="reportInfo[<s:property value="#stat.index" />].infoMetrics" id="Performance_infoMetricsValue_<s:property value="#stat.index" />"  value="<s:property value="#info.infoMetrics" />"  />
						<input type="hidden"  name="reportInfo[<s:property value="#stat.index" />].perMetrics" id="Performance_perMetricsValue_<s:property value="#stat.index" />"  value="<s:property value="#info.perMetrics" />"  />
						<input type="hidden"  name="reportInfo[<s:property value="#stat.index" />].order" id="Performance_orderValue_<s:property value="#stat.index" />" value="<s:property value="#info.order" />"  />
						<s:if test="#info.metricNum">			
							<span id="Performance_metricNum_<s:property value="#stat.index" />" ><s:property value="#info.metricNum" />个</span>
						</s:if>
						<s:else>
							<span id="Performance_metricNum_<s:property value="#stat.index" />" >-</span>												
						</s:else>						
					</td>
					<td>						
						<span class="black-btn-l"><span class="btn-r"><span class="btn-m"><a id="Performance_a3_<s:property value="#stat.index" />" onclick="reSet(this)">设置</a></span></span></span><input type="hidden" id="Performance_isLoad_<s:property value="#stat.index" />" value="false" /> 
					</td>
					<td>
						<s:if test="#info.show1!='true'">
							<input type="checkbox" onclick="choiceShow(this)" id="Performance_show1_<s:property value="#stat.index" />"/>
						</s:if>
						<s:else>
							<input type="checkbox" checked="checked" onclick="choiceShow(this)" id="Performance_show1_<s:property value="#stat.index" />"/>
						</s:else>
						<input type="hidden"  name="reportInfo[<s:property value="#stat.index" />].show1" value="<s:property value="#info.show1" />" id="Performance_show1Value_<s:property value="#stat.index" />" />
						<span>显示</span>
					</td>
					<td>
						<s:if test="#info.show2!='true'">
							<input type="checkbox" onclick="choiceShow(this)" id="Performance_show2_<s:property value="#stat.index" />"/>							
						</s:if>
						<s:else>
							<input type="checkbox" checked="checked" onclick="choiceShow(this)" id="Performance_show2_<s:property value="#stat.index" />"/>
						</s:else>
						<input type="hidden"  name="reportInfo[<s:property value="#stat.index" />].show2" value="<s:property value="#info.show2" />" id="Performance_show2Value_<s:property value="#stat.index" />"/>
						<span>显示</span>
					</td>
					<td>
						<span class="ico ico-select" id="Performance_preview_<s:property value="#stat.index" />" onclick="preview(this)" title="预览"></span>
					</td>					
				 </tr>
				</s:if>																		
			</s:iterator>
			</s:if>
		 	</table>
		 	<input type="hidden" id="PerformanceTableNum" value="<s:property value="sign" />"/>	 
		 	<s:if test="reportInfo==null">
		 		<div class="textalign" id="Performance_showAddButton" style="margin-top:80px;"><span >请点击</span><span class="ico ico-add" title="添加" id="Performance_add" ></span><span>按钮</span></div>
		 	</s:if>		 				 										 					 	
		 </div>
		</td>
	</tr>							
	</table>
	<div id="Performance_reportInfo">
			<s:iterator  var="info" value="reportInfo"  status="stat">
				<s:if test="#stat.count>0">
					<div id="Performance_div0_<s:property value="#stat.index" />" style="position:absolute;left:10%;top:1%;width:90%;height:90%;z-index:1000;visibility:hidden"></div>
				</s:if>
			</s:iterator>		
	</div>							
<script type="text/javascript">
$(document).ready(function(){
	var index = parseInt($("#PerformanceTableNum").val());
	if(isNaN(index)){
		index = 0;
		$("#Performance_showAddButton").css("display","block");
	}else{		
		cacheObj.setNum(index);
	}
});
/*$("#Performance_add").bind("click",function(){
	addReportInfo();
});*/
</script>
