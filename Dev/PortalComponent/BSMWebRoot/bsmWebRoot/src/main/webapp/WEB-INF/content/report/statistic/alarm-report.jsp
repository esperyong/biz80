<%@ page language="java" contentType="text/html; charset=UTF-8"pageEncoding="UTF-8"%>
	<%@ include file="/WEB-INF/common/taglibs.jsp"%>
	<table  class="tongji-grid table-width100 whitebg grayborder" style="border: 1px solic #ccc; overflow: scroll;">
	<tr>
		<th style="width:170px"><input type="checkbox" id="Alarm_Checkbox" onclick="fullChoice(this)" />标题</th>
		<th style="width:120px">资源类型</th>
		<th >资源 <span class="red">*</span></th>
		<th >组件类型</th>
		<th >组件</th>
		<th >指标<span class="red">*</span></th>
		<th >设置</th>
		<th >预览</th> 
	</tr>
	<tr><td colspan="8" style="padding: 0 0 0 0;height:226px;">
		 <div>
		 	<table id="AlarmTable" border="0" width="100%" cellpadding="0" cellspacing="0">
		 	<s:iterator  var="info" value="reportInfo"  status="stat">
				<s:if test="#stat.count>0">
					<tr id="Alarm_tr_<s:property value="#stat.index" />">
					<td style="width:170px">
					    <input type="checkbox" name="reportInfoName" id="<s:property value="#stat.index" />" />
						<input type="text" id="Alarm_reportInfoName_<s:property value="#stat.index" />" value="<s:property value="#info.name" />" disabled=true/>
						<input type="hidden"  name="reportInfo[<s:property value="#stat.index" />].id" id="Alarm_idValue_<s:property value="#stat.index" />" value="<s:property value="#info.id" />" />
						<input type="hidden"  name="reportInfo[<s:property value="#stat.index" />].name" id="Alarm_nameValue_<s:property value="#stat.index" />"  value="<s:property value="#info.name" />"/>
					</td>
					<td style="width:120px">
						<input type="hidden"  name="reportInfo[<s:property value="#stat.index" />].resoureType" id="Alarm_resoureTypeValue_<s:property value="#stat.index" />" value="<s:property value="#info.resoureType" />"/>
						<input type="hidden"  name="reportInfo[<s:property value="#stat.index" />].resoureName" id="Alarm_resoureNameValue_<s:property value="#stat.index" />" value="<s:property value="#info.resoureName" />"/>
						<input type="hidden"  name="reportInfo[<s:property value="#stat.index" />].resourceModel" id="Alarm_resourceModelValue_<s:property value="#stat.index" />" value="<s:property value="#info.resourceModel" />"/>
						<span id="Alarm_resoureType_<s:property value="#stat.index" />"><s:property value="#info.resoureName" /></span>
					</td>
					<td>
						<input type="hidden"  name="reportInfo[<s:property value="#stat.index" />].resFilter" id="Alarm_resFilter_<s:property value="#stat.index" />" value="<s:property value="#info.resFilter" />"/>
						<input type="hidden"  name="reportInfo[<s:property value="#stat.index" />].resources" id="Alarm_resouresValue_<s:property value="#stat.index" />" value="<s:property value="#info.resources" />"/>
						<input type="hidden"  name="reportInfo[<s:property value="#stat.index" />].customsInfoType" id="Alarm_customsInfoTypeValue_<s:property value="#stat.index" />" value="<s:property value="#info.customsInfoType" />"/>
						<input type="hidden"  name="reportInfo[<s:property value="#stat.index" />].customsCondition" id="Alarm_customsConditionValue_<s:property value="#stat.index" />" value="<s:property value="#info.customsCondition" />" />
						<input type="hidden"  name="reportInfo[<s:property value="#stat.index" />].customsValue" id="Alarm_customsValue_<s:property value="#stat.index" />" value="<s:property value="#info.customsValue" />" />
						<input type="hidden"  name="reportInfo[<s:property value="#stat.index" />].domainId" id="Alarm_domainIdValue_<s:property value="#stat.index" />" value="<s:property value="#info.domainId" />" />
						<span id="Alarm_resoureNum_<s:property value="#stat.index" />" ><s:property value="#info.resourcesNum" />个</span>
					</td>
					<td>
						<input type="hidden"  name="reportInfo[<s:property value="#stat.index" />].componentType" id="Alarm_componentTypeValue_<s:property value="#stat.index" />" value="<s:property value="#info.componentType" />"  />
						<input type="hidden"  name="reportInfo[<s:property value="#stat.index" />].componentName" id="Alarm_componentNameValue_<s:property value="#stat.index" />" value="<s:property value="#info.componentName" />"  />
						<s:if test="#info.componentType!=null">															
							<span id="Alarm_compomentType_<s:property value="#stat.index" />" ><s:property value="#info.componentName" /></span>
						</s:if>
						<s:else>
							<span id="Alarm_compomentType_<s:property value="#stat.index" />" >-</span>
						</s:else>
					</td>
					<td>
						<input type="hidden"  name="reportInfo[<s:property value="#stat.index" />].componentRes" id="Alarm_componentResValue_<s:property value="#stat.index" />" value="<s:property value="#info.componentRes" />" />
						<input type="hidden"  name="reportInfo[<s:property value="#stat.index" />].components" id="Alarm_componentsValue_<s:property value="#stat.index" />" value="<s:property value="#info.components" />" />
						<s:if test="#info.componentType!=null">							
							<span id="Alarm_componentNum_<s:property value="#stat.index" />" ><s:property value="#info.componentsNum" />个</span>
						</s:if>
						<s:else>
							<span id="Alarm_componentNum_<s:property value="#stat.index" />" >-</span>							
						</s:else>						
					</td>
					<td>
						<input type="hidden"  name="reportInfo[<s:property value="#stat.index" />].metrics" id="Alarm_metricValue_<s:property value="#stat.index" />"  value="<s:property value="#info.metrics" />"  />
						<input type="hidden"  name="reportInfo[<s:property value="#stat.index" />].infoMetrics" id="Alarm_infoMetricsValue_<s:property value="#stat.index" />"  value="<s:property value="#info.infoMetrics" />"  />
						<input type="hidden"  name="reportInfo[<s:property value="#stat.index" />].perMetrics" id="Alarm_perMetricsValue_<s:property value="#stat.index" />"  value="<s:property value="#info.perMetrics" />"  />
						<input type="hidden"  name="reportInfo[<s:property value="#stat.index" />].order" id="Alarm_orderValue_<s:property value="#stat.index" />" value="<s:property value="#info.order" />"  />
						<s:if test="#info.metricNum">			
							<span id="Alarm_metricNum_<s:property value="#stat.index" />" ><s:property value="#info.metricNum" />个</span>
						</s:if>
						<s:else>
							<span id="Alarm_metricNum_<s:property value="#stat.index" />" >-</span>												
						</s:else>						
					</td>
					<td>
						<span class="black-btn-l"><span class="btn-r"><span class="btn-m"><a id="Alarm_a3_<s:property value="#stat.index" />" onclick="reSet(this)">设置</a></span></span></span><input type="hidden" id="Alarm_isLoad_<s:property value="#stat.index" />" value="false" /> 
					</td>
					<td>
						<span class="ico ico-select" id="Alarm_preview_<s:property value="#stat.index" />" onclick="preview(this)" title="预览"></span>
					</td>					
				 </tr>
				</s:if>																				
			</s:iterator>
		 	</table>
		 	<input type="hidden" id="AlarmTableNum" value="<s:property value="sign" />"/>	
		 	<s:if test="reportInfo==null">
		 		<div class="textalign" id="Alarm_showAddButton" style="margin-top:80px;"><span >请点击</span><span class="ico ico-add"  title="添加" id="Performance_add" ></span><span>按钮</span></div>
		 	</s:if>							 					 	
		 </div>
		</td>
	</tr>							
	</table>	
	<div id=Alarm_reportInfo>
			<s:iterator  var="info" value="reportInfo"  status="stat">
				<s:if test="#stat.count>0">
					<div id="Alarm_div0_<s:property value="#stat.index" />" style="position:absolute;left:10%;top:1%;width:90%;height:90%;z-index:1000;visibility:hidden"></div>
				</s:if>
			</s:iterator>		
	</div>				
<script type="text/javascript">
$(document).ready(function(){
	var index = parseInt($("#AlarmTableNum").val());
	if(isNaN(index)){
		index = 0;
		$("#Alarm_showAddButton").css("display","block");
	}else{		
		cacheObj.setNum(index);
	}
});
/*$("#Alarm_add").bind("click",function(){
	addReportInfo();
});*/
</script>
