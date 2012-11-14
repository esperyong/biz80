<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
</head>
<body>

<s:if test="#flag != true">
	<s:set name="parameters" value="parameters"/>
</s:if>
<fieldset class="blue-border" style="width:500px">
   <legend>参数信息</legend>
   <s:if test="#parameters == null || #parameters.size == 0">
	   <table align="center">
	   	<tr>
			<td class="nodata" align="center">
			  <span class="nodata-l">
		            <span class="nodata-r">
		                <span class="nodata-m"><span class="icon">当前无数据</span></span>
		              </span>
		      </span>
			</td>
	   	</tr>
	   </table>
   </s:if>
   <s:else>
	   <ul class="fieldlist-n">
	    <s:iterator value="#parameters" id="object" status="st">
	    <li>
	    
			<span class="field"><s:property value="#object.name"/>&nbsp;</span> 
			<span><s:text name="i18n.wireless.colon"/></span>
			<span>
				<input type="hidden" name="defineVO.parameters[${st.index}].id" value="${object.id}" />
				<span><input type="text" name="defineVO.parameters[${st.index}].value" value="${object.value}"/></span> 
			</span>
		</li>
	    </s:iterator>
	   </ul>
   </s:else>
</fieldset>   
</body>
</html>
