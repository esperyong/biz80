<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<%
  response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
  response.setHeader("Pragma", "no-cache"); //HTTP 1.0
  response.setDateHeader("Expires", 0); //prevents caching at the proxy server
 %>
<script type="text/javascript" src="${ctxJs}/AnyChart.js"></script>
<link rel="stylesheet" href="${ctx}/css/UIComponent.css" type="text/css" />
<div>

<script type="text/javascript">
	var anyChartStr = "${anyChartStr}";
	if(anyChartStr != ""){
	
		var anychart = new AnyChart('${ctxFlash}/AnyChart.swf');
		anychart.waitingForDataText = '';
		anychart.width = '100%';
		anychart.height = 300;
		anychart.wMode = 'transparent';
		anychart.setData(anyChartStr);
		anychart.write();
		parent.document.getElementById("contentFlash").height=anychart.height;
	}
	else
	{
		parent.document.getElementById("contentFlash").height=150;
	}
	
	parent.$.unblockUI(); 
	
</script>
			<s:if test='anyChartStr==""'>
			<div class="roundedform-content">
    		<table class="hundred"  align="center" height="150px"><tbody><tr>
    			<td class="nodata vertical-middle" style="text-align:center;"><span class="nodata-l"><span class="nodata-r"><span class="nodata-m"> 
    				<span class="icon">当前无数据</span> </span></span></span>
    			</td>
    		</tr></tbody></table>
    	   </div>
    	   </s:if>
</div>
<input type="hidden" name="anyChartStr" value="${anyChartStr}"/>
<div style="display:none;">${anyChartStr}</div>