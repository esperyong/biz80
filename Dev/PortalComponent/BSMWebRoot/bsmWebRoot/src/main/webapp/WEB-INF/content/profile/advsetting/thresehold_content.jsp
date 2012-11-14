<!-- content/profile/advsetting/thresehold_content.jsp 
此页面是嵌套页面，但是name有问题，有所改动，如果出错将其页面的内容直接放入嵌套页面中
-->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="/WEB-INF/common/taglibs.jsp"%>
<div>
	<s:iterator value="#bl.thresholdSettings" id="th" status="i">
	
	     	<s:if test="#th.comparison==\">\"  || #th.comparison==\">=\" "><%--正常情况 --%>
	     	<s:set name="isInclue" value="true" />
	     	<input type="hidden" name="baseLine[${st1.index}].thresholdSettings[${i.index}].thresholdId" id="" value="${th.thresholdId}" />
	     	<input type="hidden" name="baseLine[${st1.index}].thresholdSettings[${i.index}].comparison" id="" value="${th.comparison}" />
	     	<input type="hidden" name="baseLine[${st1.index}].thresholdSettings[${i.index}].unit" id="" value="${th.unit}" />
			<s:set name="unit" value="#th.unit"/>
	     	<input type="hidden" name="baseLine[${st1.index}].thresholdSettings[${i.index}].flapping" id="" value="${th.flapping}" />	
	     	<input type="hidden" name="baseLine[${st1.index}].thresholdSettings[${i.index}].color" id="" value="${th.color}" />	
	     	<input type="hidden" name="baseLine[${st1.index}].thresholdSettings[${i.index}].thresholdValue" id="" value="${th.thresholdValue}" />
	     	<s:if test="#th.color=='red'"><s:set name="redWidth" value="#th.thresholdValue"/></s:if>
  			<s:if test="#th.color=='yellow'"><s:set name="yeWidth" value="#th.thresholdValue"/></s:if>
  			
	     	</s:if>
	     	<s:else><%--非正常情况(阈值相反，或者包含不包含) --%>
									<s:if test="#th.comparison!=\"equalsnull\"">
										<s:set name="isInclue" value="false" />
									</s:if>
			<span>
				<input type="hidden"
						name="baseLine[${st1.index}].thresholdSettings[${i.index}].thresholdId"
						value="${th.thresholdId}" />
				<s:if test="#th.comparison == \"contains\"  || #th.comparison == \"!contains\" "><%-- 包含不包含 --%>
					<s:if test="#th.color=='red'||#th.color=='yellow'||#th.color=='green'">
					<s:select list="#{'contains':'包含','!contains':'不包含' }" 
					name="thresold_models[%{#i.index}].comparison"
					value="#th.comparison"></s:select>
					</s:if><s:else>
							<input type="hidden"
									name="baseLine[${st1.index}].thresholdSettings[${i.index}].comparison"
									value="${th.comparison}"  />
							</s:else>
				</s:if><s:else><%-- 阈值相反 --%>
				<input type="hidden"
						name="baseLine[${st1.index}].thresholdSettings[${i.index}].comparison"
						value="${th.comparison}"  />
				</s:else>
				
				<s:if test="#th.color=='red'"><%-- 红色阈值 --%>
				<input type="text" style="color:#ff0000"
						name="baseLine[${st1.index}].thresholdSettings[${i.index}].thresholdValue"
						value="${th.thresholdValue}"  size="2"/><font color="#ff0000">${th.unit}</font>
				</s:if>
				<s:elseif test="#th.color=='yellow'"><%-- 黄色阈值 --%>
				<input type="text" style="color:#ff9933"
						name="baseLine[${st1.index}].thresholdSettings[${i.index}].thresholdValue"
						value="${th.thresholdValue}"  size="2"/><font color="#ff9933">${th.unit}</font>
				</s:elseif>
				<s:elseif test="#th.color=='green'"><%-- 绿色阈值 --%>
				<input type="text" style="color:green"
						name="baseLine[${st1.index}].thresholdSettings[${i.index}].thresholdValue"
						value="${th.thresholdValue}"  size="2"/><font color="green">${th.unit}</font>
				</s:elseif>
				<s:else><%-- 不显示的阈值 --%>
				<input type="hidden"
						name="baseLine[${st1.index}].thresholdSettings[${i.index}].thresholdValue"
						value="${th.thresholdValue}"  size="2"/>
				</s:else>
				<input type="hidden"
						name="baseLine[${st1.index}].thresholdSettings[${i.index}].unit"
						value="${th.unit}" />
				<input type="hidden"
						name="baseLine[${st1.index}].thresholdSettings[${i.index}].flapping"
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
	<page:param name="unit">${th.unit}</page:param>
	<page:param name="red_value">${redWidth}</page:param>
	<page:param name="yellow_value">${yeWidth}</page:param>
</page:applyDecorator>
</s:if>