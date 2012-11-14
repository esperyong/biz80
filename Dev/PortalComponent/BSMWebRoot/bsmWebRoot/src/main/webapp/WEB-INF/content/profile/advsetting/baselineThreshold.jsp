<!-- content/profile/advsetting/baselineThreshold.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<page:applyDecorator name="accordionAddSubPanel"  >
		 <page:param name="id">BaseLine</page:param>
	     <page:param name="title">基线</page:param>
	     <page:param name="height">348px</page:param>
	     <page:param name="width">687px</page:param>
	     <page:param name="cls">fold-blue</page:param>
	     <page:param name="display"><%=c1%></page:param>
	     <page:param name="float">true</page:param>
	    
	     <page:param name="content">
	     
<table style="margin:  5px 0px 5px 20px;"><thead>
	     	<tr><td width="20px;"><span class="ico ico-tips"></span></td><td>基线：即按时间段为指标设置不同的阈值。</td></tr>
	     	<tr><td>&nbsp;</td><td>说明：当不在基线设置的时间范围内时，将采用指标定义中设置的阈值。</td></tr>
	     	</thead>
	     </table>
	     <%-- 
	     <div id="Threshold_model" style="display: none;">
	     	<s:iterator value="thresold_models" id="th" status="i">
	     	<input type="hidden" name="thresold_models[${i.index}].thresholdId" id="" value="${th.thresholdId}" />	
	     	<input type="hidden" name="thresold_models[${i.index}].comparison" id="" value="${th.comparison}" />	
	     	<input type="hidden" name="thresold_models[${i.index}].unit" id="" value="${th.unit}" />	
	     	<input type="hidden" name="thresold_models[${i.index}].color" id="" value="${th.color}" />	
	     	<input type="hidden" name="thresold_models[${i.index}].thresholdValue" id="" value="${th.thresholdValue}" />	
	     	</s:iterator>
	     </div>
	      --%>
	     <div id="Threshold_model_set" style="display: none;">
	     	<div id="Threshold_values">
	     	<s:iterator value="thresold_models" id="th" status="i">
	     	<input type="hidden" name="thresold_models[${i.index}].thresholdId" id="" value="${th.thresholdId}" />
	     	<input type="hidden" name="thresold_models[${i.index}].comparison" id="" value="${th.comparison}" />
	     	<input type="hidden" name="thresold_models[${i.index}].unit" id="" value="${th.unit}" />
			<s:set name="unit" value="#th.unit"/>
	     	<input type="hidden" name="thresold_models[${i.index}].flapping" id="" value="${th.flapping}" />	
	     	<input type="hidden" name="thresold_models[${i.index}].color" id="" value="${th.color}" />	
	     	<input type="hidden" name="thresold_models[${i.index}].thresholdValue" id="" value="${th.thresholdValue}" />
	     	<s:if test="#th.color=='red'"><s:set name="redWidth" value="#th.thresholdValue"/></s:if>
  			<s:if test="#th.color=='yellow'"><s:set name="yeWidth" value="#th.thresholdValue"/></s:if>
	     	</s:iterator>
	     	</div>
	     	 <page:applyDecorator name="threshold_t">
				<page:param name="unit">${unit}</page:param>
				<page:param name="red_value">${redWidth}</page:param>
				<page:param name="yellow_value">${yeWidth}</page:param>
			</page:applyDecorator>
	     </div>
	     
	     <fieldset class="blue-border" style="width:630px;" id='daliy_fieldset'>
	     <span><input type="checkbox" name="" id="activation_threshold" checked="true" />激活基线设置(此设置决定基线设置是否生效)</span>
			<legend><input type="radio" name="baseLineType" value='daliy' <s:if test="baseLineType=='DailyPeriod'">checked</s:if> id="daliyOfBaseLineType" /><label for="daliyOfBaseLineType"><b>天基线</b></label></legend>
		     <div class="monitor">
		     <div style="width: 100%;text-align: right;height: 20px;"><span class="r-ico r-ico-delete" id='delBaseLine' title="删除"></span><span class="r-ico r-ico-add" id='addBaseLine' title="添加"></span></div>
				<ul  class="monitor-items" id='daliy'>
					<li>
						<table class="monitor-items-head" >
					  		<thead>
					  			<tr>
					  			<th width="10%"><input type="checkbox" id='checkAll'/></th>
					  			<th width="45%">时间</th>
					  			<th width="45%">阈值</th>
					  			</tr>
					  		</thead>
					  	</table>
					</li>
				<s:iterator value="baseLine" id="bl" status="st1">
					<s:if test="%{#bl.periodId == 'DailyPeriod'}">
					<li name="baseLineItem"> 
					<table class="monitor-items-list"> 
						<tbody id="DailyPeriod"> 
							<tr> 
								<td width="6%"><input type="checkbox" name="singleCheck"/>
								<input type="hidden" name="baseLine[${st1.index}].periodId" value="${bl.periodId }"/>
								</td>
								<td width="50%">
								<s:textfield name="baseLine[%{#st1.index}].fromTime" id="timeForm_%{st1.index}_fromTime" size="5" cssClass="validate[funcCall[startTimeLarge]]"></s:textfield>
								至<s:textfield name="baseLine[%{#st1.index}].toTime" id="timeTo_%{st1.index}_toTime"  size="5" cssClass="validate[funcCall[endTimeSmall]]"></s:textfield>
								<input type="hidden" name="baseLine[${st1.index}].inUse" value="${bl.inUse}"/>
								</td>
								<td width="44%">
								<div>
								<s:iterator value="#bl.thresholdSettings" status="st2" id="th">
								<input type="hidden" name="baseLine[${st1.index}].thresholdSettings[${st2.index}].thresholdId" value="${th.thresholdId}"/>
								<input type="hidden" name="baseLine[${st1.index}].thresholdSettings[${st2.index}].comparison" value="${th.comparison}"/>
								<input type="hidden" name="baseLine[${st1.index}].thresholdSettings[${st2.index}].unit" value="${th.unit}"/>
								<input type="hidden" name="baseLine[${st1.index}].thresholdSettings[${st2.index}].flapping" value="${th.flapping}"/>
								<input type="hidden" name="baseLine[${st1.index}].thresholdSettings[${st2.index}].color" value="${th.color}"/>
								<input type="hidden" name="baseLine[${st1.index}].thresholdSettings[${st2.index}].thresholdValue" style="color:${th.color};" value="${th.thresholdValue}"/>
								<s:property value="baseLine[%{#st1.index}].thresholdSettings[%{#st2.index}].unit"/>
								<!-- 设置颜色值 -->
								<s:if test="#th.color=='red'"><s:set name="redHeight" value="#th.thresholdValue"/></s:if>
		  						<s:if test="#th.color=='yellow'"><s:set name="yeHeight" value="#th.thresholdValue"/></s:if>
								</s:iterator>
								</div>
								<page:applyDecorator name="threshold_t">
									<page:param name="unit">${th.unit}</page:param>
									<page:param name="red_value">${redHeight}</page:param>
									<page:param name="yellow_value">${yeHeight}</page:param>
								</page:applyDecorator>
								</td>
							</tr>
						</tbody>
					</table>
					</li>
					</s:if>
				</s:iterator>
				</ul></div>
			</fieldset>
		     <fieldset class="blue-border" style="width:630px;" id='weekly_fieldset'>
				<legend><input type="radio" name="baseLineType" value="weekly" <s:if test="baseLineType=='WeeklyPeriod'">checked</s:if> id="weeklyOfBaseLineType"></input><label for="weeklyOfBaseLineType"><b>周基线<b/></label></legend>
			     <div class="monitor">
			     <div style="width: 100%;text-align: right;height: 20px;"><span class="r-ico r-ico-delete" id='delBaseLine' title="删除"></span><span class="r-ico r-ico-add" id='addBaseLine' title="添加"></span></div>
					<ul  class="monitor-items" id='weekly'>
						<li>
							<table class="monitor-items-head" >
						  		<thead><tr><th width="10%"><input type="checkbox" id='checkAll'/></th>
						  			<th width="45%">时间</th>
						  			<th width="45%">阈值</th>
						  			</tr></thead></table>
						</li>
						<s:iterator value="baseLine" id="bl" status="st1">
						<s:if test="%{#bl.periodId != 'DailyPeriod' && #bl.periodId != 'ExactTimePeriod'}">
						<li name="baseLineItem"> <table class="monitor-items-list">
						<tbody id="<s:property value="#bl.periodId"/>"> 
						<tr> <td width="6%">
						<input type="checkbox" name="singleCheck"/>
						<input type="hidden" name="baseLine[${st1.index}].periodId" value="${bl.periodId }"/> 
						</td>
									<td width="50%"><s:select list='@com.mocha.bsm.profile.type.PeriodIdEnum@values()' listKey='key' listValue='value' name="baseLine[%{#st1.index}].periodId"/>
									<s:textfield name="baseLine[%{#st1.index}].fromTime" id="timeForm_%{#st1.index}_fromTime" size="5" cssClass="validate[funcCall[startTimeLarge]]"></s:textfield>至<s:textfield name="baseLine[%{#st1.index}].toTime" id="timeTo_%{#st1.index}_toTime"  size="5" cssClass="validate[funcCall[endTimeSmall]]"></s:textfield>
									<input type="hidden" name="baseLine[${st1.index}].inUse" value="${bl.inUse}"/>
									</td>
									<td width="44%">
									<div>
									<s:iterator value="#bl.thresholdSettings" status="st2" id="th">
									<input type="hidden" name="baseLine[${st1.index}].thresholdSettings[${st2.index}].thresholdId" value="${th.thresholdId }"/>
									<input type="hidden" name="baseLine[${st1.index}].thresholdSettings[${st2.index}].comparison" value="${th.comparison }"/>
									<input type="hidden" name="baseLine[${st1.index}].thresholdSettings[${st2.index}].unit" value="${th.unit }"/>
									<input type="hidden" name="baseLine[${st1.index}].thresholdSettings[${st2.index}].flapping" value="${th.flapping }"/>
									<input type="hidden" name="baseLine[${st1.index}].thresholdSettings[${st2.index}].color" value="${th.color }"/>
									<input type="hidden" name="baseLine[${st1.index}].thresholdSettings[${st2.index}].thresholdValue" value="${th.thresholdValue }"/>
									<!-- 设置颜色值 -->
									<s:if test="#th.color=='red'"><s:set name="redHeight" value="#th.thresholdValue"/></s:if>
			  						<s:if test="#th.color=='yellow'"><s:set name="yeHeight" value="#th.thresholdValue"/></s:if>
									</s:iterator>
									</div>
									<page:applyDecorator name="threshold_t">
									<page:param name="unit">${th.unit}</page:param>
									<page:param name="red_value">${redHeight}</page:param>
									<page:param name="yellow_value">${yeHeight}</page:param>
								</page:applyDecorator>
									</td>
								</tr>
							</tbody>
						</table>
						</li>
						</s:if>
					</s:iterator>
						</ul></div>
				</fieldset>
				<fieldset class="blue-border" style="width:630px;" id='exactTime_fieldset'>
					<legend><input type="radio" name="baseLineType" value="exactTime" <s:if test="baseLineType=='ExactTimePeriod'">checked</s:if> id="exactTimeOfBaseLineType"></input><label for="exactTimeOfBaseLineType"><b>指定时间基线<b/></label></legend>
					<div class="monitor">
					
			     <div style="width: 100%;text-align: right;height: 20px;"><span class="r-ico r-ico-delete" id='delBaseLine' title="删除"></span><span class="r-ico r-ico-add" id='addBaseLine' title="添加"></span></div>
					<ul  class="monitor-items" id='exactTime'>
						<li>
							<table class="monitor-items-head" >
						  		<thead><tr><th width="10%"><input type="checkbox" id='checkAll'/></th>
						  			<th width="45%">时间</th>
						  			<th width="45%">阈值</th>
						  			</tr></thead></table>
						</li>
						<s:iterator value="baseLine" id="bl" status="st1">
						<s:if test="%{#bl.periodId == 'ExactTimePeriod'}">
						<li name="baseLineItem">
							<table class="monitor-items-list">
								<tbody id="<s:property value="#bl.periodId"/>">
									<tr>
										<td width="6%">
											<input type="checkbox" name="singleCheck"/>
											<input type="hidden" name="baseLine[${st1.index}].periodId" value="${bl.periodId }"/> 
										</td>
										<td width="50%">
										<s:textfield name="baseLine[%{#st1.index}].formDate" id="dateForm_%{#st1.index}" size="8"></s:textfield><s:textfield name="baseLine[%{#st1.index}].fromTime" id="timeForm_%{#st1.index}" size="5"></s:textfield>至<s:textfield name="baseLine[%{#st1.index}].toDate" id="dateForm_%{#st1.index}" size="8"></s:textfield> <s:textfield name="baseLine[%{#st1.index}].toTime" id="timeTo_%{#st1.index}"  size="5"></s:textfield><input type="hidden" name="baseLine[${st1.index}].inUse" value="${bl.inUse}"/>
										</td>
									<td width="44%">
									<div>
									<s:iterator value="#bl.thresholdSettings" status="st2" id="th">
									<input type="hidden" name="baseLine[${st1.index}].thresholdSettings[${st2.index}].thresholdId" value="${th.thresholdId }"/>
									<input type="hidden" name="baseLine[${st1.index}].thresholdSettings[${st2.index}].comparison" value="${th.comparison }"/>
									<input type="hidden" name="baseLine[${st1.index}].thresholdSettings[${st2.index}].unit" value="${th.unit }"/>
									<input type="hidden" name="baseLine[${st1.index}].thresholdSettings[${st2.index}].color" value="${th.color }"/>
									<input type="hidden" name="baseLine[${st1.index}].thresholdSettings[${st2.index}].thresholdValue" value="${th.thresholdValue }"/>
									<%-- 设置颜色值 --%>
									<s:if test="#th.color=='red'"><s:set name="redHeight" value="#th.thresholdValue"/></s:if>
			  						<s:if test="#th.color=='yellow'"><s:set name="yeHeight" value="#th.thresholdValue"/></s:if>
									</s:iterator>
									</div>
									<page:applyDecorator name="threshold_t">
										<page:param name="unit">${th.unit}</page:param>
										<page:param name="red_value">${redHeight}</page:param>
										<page:param name="yellow_value">${yeHeight}</page:param>
									</page:applyDecorator>
									</td>
								</tr>
							</tbody>
						</table>
						</li>
						</s:if>
					</s:iterator>
						</ul>
						</div>
					
				</fieldset>
</page:param>
	</page:applyDecorator>