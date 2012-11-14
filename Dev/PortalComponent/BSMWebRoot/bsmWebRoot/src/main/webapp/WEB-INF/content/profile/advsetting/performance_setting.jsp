<!-- content/profile/advsetting/performance_setting.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@ include file="/WEB-INF/common/meta.jsp"%>
		<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css" ></link>
		<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" ></link>
		<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css" ></link>
		<link href="${ctx}/css/jquery-ui/jquery.ui.datepicker.css" rel="stylesheet" type="text/css"></link>
		<link type="text/css" href="${ctx}/css/validationEngine.jquery.css" rel="stylesheet" media="screen" title="no title" charset="utf-8" />
		<style>
		.timeEntry_control {
			vertical-align: middle;
			margin-left: 1px;
		}
		.timeEntry_wrap{
		}
		.addBackground {
			background:gray;
			color:white;
		}
		</style>
		<script type="text/javascript">
		<%
			String monitorFreq = request.getParameter("monitorFreq");
			String c1,c2,c3;
			if(null == monitorFreq ){
				c1 = "expend";
				c2 = c3 = "collect";
			}else{
				c2 = "expend";
				c1 = c3 = "collect";
			}
		%>
	 path = '${ctx}';
	 var monitorFreq = '<%=request.getParameter("monitorFreq")%>';
	 var isEdit = Boolean(${isEdit});
	</script>
	<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js"></script>
	<script type="text/javascript" src="${ctx}/js/jquery-query.js"></script>
	<script type="text/javascript" src="${ctx}/js/component/cfncc.js"></script>
	<script type="text/javascript" src="${ctx}/js/component/panel/panel.js"></script>
	<script type="text/javascript" src="${ctx}/js/component/toast/Toast.js"></script>
	<script type="text/javascript" src="${ctx}/js/component/slider/slider.js"></script>
	<script type="text/javascript" src="${ctx}/js/component/popwindow/popwin.js"></script>
	<script type="text/javascript" src="${ctx}/js/component/accordionPanel/accordionPanel.js"></script>
	<script type="text/javascript" src="${ctx}/js/component/accordionPanel/accordionAddSubPanel.js"></script>
	<script type="text/javascript" src="${ctx}/js/component/slider/numberSlider.js"></script>
	<script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.datepicker.js"></script>
	<script type="text/javascript" src="${ctx}/js/component/plugins/jquery.timeentry.min.js"></script>
	<script type="text/javascript" src="${ctx}/js/jquery.validationEngine-cn.js"></script> 
	<script type="text/javascript" src="${ctx}/js/jquery.validationEngine.js"></script>
	<script type="text/javascript" src="${ctx}/js/profile/userdefine/baselineValidate.js"></script>
	<script type="text/javascript" src="${ctx}/js/profile/userdefine/metricAdvSetting.js"></script>
	<script type="text/javascript" src="${ctx}/js/profile/userdefine/noAccessTime.js"></script>
	</head>
	<body>
	<%@ include file="/WEB-INF/common/loading.jsp" %>
	<page:applyDecorator name="popwindow"  title="${advSettingTitle}-指标设置">
	<page:param name="width">700px;</page:param>
	<page:param name="height">440px;</page:param>
	<page:param name="topBtn_index_1">1</page:param>
	<page:param name="topBtn_id_1">win-close</page:param>
	<page:param name="topBtn_css_1">win-ico win-close</page:param>
	<page:param name="topBtn_title_1">关闭</page:param>
	
	<page:param name="bottomBtn_index_1">1</page:param>
	<page:param name="bottomBtn_id_1">confirm_button</page:param>
	<page:param name="bottomBtn_text_1">确定</page:param>
	
	<page:param name="bottomBtn_index_2">2</page:param>
	<page:param name="bottomBtn_id_2">cancel_button</page:param>
	<page:param name="bottomBtn_text_2">取消</page:param>
	<page:param name="content">
	<!-- baseline start -->
	<form id="performance">
		<input type="hidden" name="resourceId" id="resourceId" value="${resourceId}"/>
		<input type="hidden" name="profileId" id="profileId" value="${profileId}"/>
		<input type="hidden" name="metricId" id="metricId" value="${metricId}"/>
		<input type="hidden" name="isCustomProfile" id="isCustomProfile" value="${isCustomProfile}"/>
	 <page:applyDecorator name="accordionAddSubPanel"  >
		 <page:param name="id">BaseLine</page:param>
	     <page:param name="title">基线</page:param>
	     <page:param name="height">348px</page:param>
	     <page:param name="width">687px</page:param>
	     <page:param name="cls">fold-blue</page:param>
	     <page:param name="display"><%=c1%></page:param>
	     <page:param name="float">true</page:param>
	    
	     <page:param name="content">
	     <div id="baselineContent" style="overflow-y:auto;">
	     <table style="margin:  5px 0px 5px 20px;"><thead>
	     	<tr><td width="20px;"><span class="ico ico-tips"></span></td><td>基线：即按时间段为指标设置不同的阈值。</td></tr>
	     	<tr><td>&nbsp;</td><td>说明：当不在基线设置的时间范围内时，将采用指标定义中设置的阈值。</td></tr>
	     	</thead>
	     </table>
	     <div id="Threshold_model_set" style="display: none;">
	     	<div id="Threshold_values">
	     	<!-- 模型的值 -->
	     	<s:iterator value="thresold_models" id="th" status="i">
	     	<s:if test="#th.comparison==\">\"  || #th.comparison==\">=\" "><%--正常情况 --%>
	     	<s:set name="isInclue" value="true" />
	     	<input type="hidden" name="thresold_models[${i.index}].thresholdId" id="" value="${th.thresholdId}" />
	     	<input type="hidden" name="thresold_models[${i.index}].comparison" id="" value="${th.comparison}" />
	     	<input type="hidden" name="thresold_models[${i.index}].unit" id="" value="${th.unit}" />
			<s:set name="unit" value="#th.unit"/>
	     	<input type="hidden" name="thresold_models[${i.index}].flapping" id="" value="${th.flapping}" />	
	     	<input type="hidden" name="thresold_models[${i.index}].color" id="" value="${th.color}" />	
	     	<input type="hidden" name="thresold_models[${i.index}].thresholdValue" id="" value="${th.thresholdValue}" />
	     	<s:if test="#th.color=='red'"><s:set name="redWidth" value="#th.thresholdValue"/></s:if>
  			<s:if test="#th.color=='yellow'"><s:set name="yeWidth" value="#th.thresholdValue"/></s:if>
	     	</s:if>
	     	<s:else><%--非正常情况(阈值相反，或者包含不包含) --%>
									<s:if test="#th.comparison!=\"equalsnull\"">
										<s:set name="isInclue" value="false" />
									</s:if>
			<span>
				<input type="hidden"
						name="thresold_models[${i.index}].thresholdId"
						value="${th.thresholdId}" />
				<s:if test="#th.comparison == \"contains\"  || #th.comparison == \"!contains\" "><%-- 包含不包含 --%>
					<s:if test="#th.color=='red'||#th.color=='yellow'||#th.color=='green'">
					<s:select list="#{'contains':'包含','!contains':'不包含' }" 
					name="thresold_models[%{#i.index}].comparison"
					value="#th.comparison"></s:select>
					</s:if><s:else>
							<input type="hidden"
									name="thresold_models[${i.index}].comparison"
									value="${th.comparison}"  />
							</s:else>
				</s:if><s:else><%-- 阈值相反 --%>
				<input type="hidden"
						name="thresold_models[${i.index}].comparison"
						value="${th.comparison}"  />
				</s:else>
				
				<s:if test="#th.color=='red'"><%-- 红色阈值 --%>
				<input type="text" style="color:#ff0000"
						name="thresold_models[${i.index}].thresholdValue"
						value="${th.thresholdValue}"  size="2"/><font color="#ff0000">${th.unit}</font>
				</s:if>
				<s:elseif test="#th.color=='yellow'"><%-- 黄色阈值 --%>
				<input type="text" style="color:#ff9933"
						name="thresold_models[${i.index}].thresholdValue"
						value="${th.thresholdValue}"  size="2"/><font color="#ff9933">${th.unit}</font>
				</s:elseif>
				<s:elseif test="#th.color=='green'"><%-- 绿色阈值 --%>
				<input type="text" style="color:green"
						name="thresold_models[${i.index}].thresholdValue"
						value="${th.thresholdValue}"  size="2"/><font color="green">${th.unit}</font>
				</s:elseif>
				<s:else><%-- 不显示的阈值 --%>
				<input type="hidden"
						name="thresold_models[${i.index}].thresholdValue"
						value="${th.thresholdValue}"  size="2"/>
				</s:else>
				<input type="hidden"
						name="thresold_models[${i.index}].unit"
						value="${th.unit}" />
				<input type="hidden"
						name="thresold_models[${i.index}].flapping"
						value="${th.flapping}" />
						<%--
				<input type="hidden"
				name="metricGruopList[${st1.index}].list[${st2.index}].thresholds[${st3.index}].haveChange"
				value="true" />
						 --%>
			</span>
			</s:else>
	     	</s:iterator>
	     	</div>
	     	<s:if test="#isInclue==true">
	     	<page:applyDecorator name="threshold_t">
				<page:param name="unit">${unit}</page:param>
				<page:param name="red_value">${redWidth}</page:param>
				<page:param name="yellow_value">${yeWidth}</page:param>
			</page:applyDecorator>
			</s:if>
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
								<td width="6%" index="${st1.index}"><input type="checkbox" name="singleCheck"/>
								<input type="hidden" name="baseLine[${st1.index}].periodId" value="${bl.periodId }"/>
								</td>
								<td width="50%" index="${st1.index }">
								<s:textfield name="baseLine[%{#st1.index}].fromTime" id="timeForm_%{st1.index}_fromTime" size="5" cssClass="validate[funcCall[startTimeLarge],funcCall[dateTimeInArray]]"></s:textfield>
								至<s:textfield name="baseLine[%{#st1.index}].toTime" id="timeTo_%{st1.index}_toTime"  size="5" cssClass="validate[funcCall[endTimeSmall],funcCall[dateTimeInArray]]"></s:textfield>
								<input type="hidden" name="baseLine[${st1.index}].inUse" value="${bl.inUse}"/>
								</td>
								<td width="44%" style="height:30px;">
								<%@ include file="thresehold_content.jsp"%>
								</td>
							</tr>
						</tbody>
					</table>
					</li>
					</s:if>
				</s:iterator>
				</ul></div>
			</fieldset
			><fieldset class="blue-border" style="width:630px;" id='weekly_fieldset'>
				<legend><input type="radio" name="baseLineType" value="weekly" <s:if test="baseLineType=='WeeklyPeriod'">checked</s:if> id="weeklyOfBaseLineType" /><label for="weeklyOfBaseLineType"><b>周基线</b></label></legend>
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
						<!--多余的标签 
						<input type="hidden" name="baseLine[${st1.index}].periodId" value="${bl.periodId }"/>
						 --> 
						</td>
									<td width="50%" index="${st1.index }"><s:select list='@com.mocha.bsm.profile.type.PeriodIdEnum@values()' listKey='key' listValue='value' name="baseLine[%{#st1.index}].periodId"/>
									<s:textfield name="baseLine[%{#st1.index}].fromTime" id="timeForm_%{#st1.index}_fromTime" size="5" cssClass="validate[funcCall[startTimeLarge],funcCall[dateTimeInArray]]"></s:textfield>至<s:textfield name="baseLine[%{#st1.index}].toTime" id="timeTo_%{#st1.index}_toTime"  size="5" cssClass="validate[funcCall[endTimeSmall],funcCall[dateTimeInArray]]"></s:textfield>
									<input type="hidden" name="baseLine[${st1.index}].inUse" value="${bl.inUse}"/>
									</td>
									<td width="44%" style="height:30px;">
									<%@ include file="thresehold_content.jsp"%>
									</td>
								</tr>
							</tbody>
						</table>
						</li>
						</s:if>
					</s:iterator>
						</ul></div>
				</fieldset
				><fieldset class="blue-border" style="width:630px;" id='exactTime_fieldset'>
					<legend><input type="radio" name="baseLineType" value="exactTime" <s:if test="baseLineType=='ExactTimePeriod'">checked</s:if> id="exactTimeOfBaseLineType" /><label for="exactTimeOfBaseLineType"><b>指定时间基线</b></label></legend>
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
										<td width="50%" index="${st1.index}">
										<s:textfield name="baseLine[%{#st1.index}].formDate" id="dateForm_%{#st1.index}" size="8"></s:textfield><s:textfield name="baseLine[%{#st1.index}].fromTime" id="timeForm_%{#st1.index}" size="5"></s:textfield>至<s:textfield name="baseLine[%{#st1.index}].toDate" id="dateForm_%{#st1.index}" size="8"></s:textfield> <s:textfield name="baseLine[%{#st1.index}].toTime" id="timeTo_%{#st1.index}"  size="5"></s:textfield><input type="hidden" name="baseLine[${st1.index}].inUse" value="${bl.inUse}"/>
										</td>
									<td width="44%" style="height:30px;">
									<%@ include file="thresehold_content.jsp"%>
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
				</div>
		 </page:param>
	</page:applyDecorator>
	 <!-- baseline end -->
	 <!-- 监控频度与连续发生次数 start -->
	 <page:applyDecorator name="accordionAddSubPanel"  >
		 <page:param name="id">tab2</page:param>
	     <page:param name="title">监控频度与连续发生次数 </page:param>
	     <page:param name="height">348px</page:param>
	     <page:param name="width">687px</page:param>
	     <page:param name="cls">fold-blue</page:param>
	     <page:param name="display"><%=c2%></page:param>
	     <page:param name="float">true</page:param>
	     <page:param name="content">
	     <fieldset class="blue-border" style="width:630px;">
			<legend>
			<input type="checkbox" name="freSetting.isExact"  id="fre_isPeriodic" value="${freSetting.isExact}" <s:if test="freSetting.isExact == true">checked="checked"</s:if>></input><label for="fre_isPeriodic"><b>监控频度</b></label></legend>
		    <li style="line-height:30px;">
		    	<span style="padding-left:15px;"></span> 
				<span><span class="ico ico-tips"></span><span>设置指定时间，在指定时间获取指标数据。</span></span>
		    </li> 
		    <li>
		     <table width="550" style="margin-left:30px;border-width:0px;">
		     <tbody>
		     <tr>
		     	<td width="55">指定时间</td><td width="3">：</td><td width="492"><s:select list="@com.mocha.bsm.profile.type.SpecifyFrequencyEnum@values()" listKey="key" listValue="value" id="SpeFreType" name="freSetting.exactTimeType"></s:select></td>
		     </tr>
		     <tr <s:if test="freSetting.exactTimeType!='Weekly'">style='display:none;'</s:if> id="_WeeklyFreSetting">
		     	<td>每周</td><td>：</td><td>
		     	<s:if test="freSetting.exactTimeType!='Weekly'">
		     	<s:checkboxlist disabled='true' name="selectedFre" list='@com.mocha.bsm.profile.type.DayOfWeek@values()' listKey='key' listValue='value' ></s:checkboxlist>
		     	</s:if>
		     	<s:else>
		     	<s:checkboxlist name="selectedFre" list='@com.mocha.bsm.profile.type.DayOfWeek@values()' listKey='key' listValue='value' ></s:checkboxlist>
		     	</s:else>
		     	</td>
		     </tr>
		     <tr <s:if test="freSetting.exactTimeType!='Monthly'">style='display:none;'</s:if> id="_MonthlyFreSetting">
		     	<td>每月</td><td>：</td><td>
		     	<s:if test="freSetting.exactTimeType!='Monthly'">
		     	<s:select disabled='true' list="@com.mocha.bsm.profile.type.DayOf31@values()" listKey='key' listValue='value' name='selectedFre'></s:select></td>
		     	</s:if>
		     	<s:else>
		     	<s:select list="@com.mocha.bsm.profile.type.DayOf31@values()" listKey='key' listValue='value' name='selectedFre'></s:select></td>
		     	</s:else>
		     </tr>
		     <tr id="_DailyFreSetting">
		     	<td><s:if test="freSetting.exactTimeType=='Daily'">每天</s:if></td><td><s:if test="freSetting.exactTimeType=='Daily'">：</s:if></td><td><input type="text" size='5' id='SpeFreTime' name="freSetting.exactTime" <s:if test="freSetting.exactTime == null"> value="09:00:00" </s:if><s:else>value="${freSetting.exactTime }"</s:else>/></td>
		     </tr>
		     </tbody>
		     </table>
		    </li> 
			</fieldset>
	     <fieldset class="blue-border" style="width:630px;">
			<legend><%--<input type="checkbox" id="isEditFlapping" <s:if test="isFlapping" >checked="checked"</s:if> /> <input type="hidden" name="isFlapping" value="${isFlapping}"/>--%><label for="isEditFlapping"><b>连续发生次数</b></label></legend>
		      <li style="line-height:30px;">
		    	<span style="padding-left:15px;"></span> 
				 <span class="ico ico-tips"></span><span>说明：当指标按照所设置的次数，连续超标后，指标状态才会改变。</span>
		    </li> 
		   	 <!-- 
		   	  <input name='flappingCount' size="3"/><span>*</span>
		   	  -->
		   	  <table width="90%" class="tableboder" align="center">
		   	  	<thead style="background-color: #EAEEF1;height: 20px;"><th width="30%">级别</th><th width="40%">连续发生次数</th><th width="30%">&nbsp;</th></thead>
		   	  	<s:iterator value="flappingList" status="i" id="tm">
		   	  	<tbody><tr><td><span class='<s:property value="flappingList[#i.index].flappingImg"/>'> </span><s:property value="flappingList[#i.index].flappingDesc"/></td>
		   	  	<td><span id="numberSliderSpan_${i.index}" style="height:20px;"></span></td><td><s:textfield name="flappingList[%{#i.index}].flappingCount" id="flappingList_%{#i.index}_flappingCount" size="5" cssClass="validate[onlyPositiveNumber]"/>次</td></tr></tbody>
		   	  	</s:iterator>
		   	  </table>
			</fieldset>
		 </page:param>
	</page:applyDecorator>
	 <!-- 监控频度与连续发生次数 end -->
	 <!-- 不监控时间段 start -->
	 <page:applyDecorator name="accordionAddSubPanel"  >
		 <page:param name="id">tab3</page:param>
	     <page:param name="title">不监控时间段 </page:param>
	     <page:param name="height">348px</page:param>
	     <page:param name="width">687px</page:param>
	     <page:param name="cls">fold-blue</page:param>
	     <page:param name="display"><%=c3%></page:param>
	     <page:param name="float">true</page:param>
	     <page:param name="content">
	     <fieldset class="blue-border" style="width:630px;" id="nonAccTime">
			<legend><s:checkbox name="isNonAccessTimes" id="isNonAccessTimes" /><label for="isNonAccessTimes"><b>不监控时间段</b></label></legend>
		   	<s:action name="nonAccessTime" namespace="/profile" executeResult="true" ignoreContextParams="false" flush="false">
		   	</s:action>
			</fieldset>
		 </page:param>
	</page:applyDecorator>
	 <!-- 不监控时间段 end -->
	</form>
	</page:param>
	</page:applyDecorator>
	</body>
</html>