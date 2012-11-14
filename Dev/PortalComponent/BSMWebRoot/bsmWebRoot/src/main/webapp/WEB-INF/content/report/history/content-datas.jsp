<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<form id="dataStr" method="post">
<input type="hidden" name="anyChartStr" id="anyChartStr" value="${anyChartStr}"/>
</form>
   <script type="text/javascript">
   $(function(){
		 var url=path+"/report/history/historyContentAction!displayFlash.action";
		 $("#dataStr").attr("target","contentFlash");
		 $("#dataStr").attr("action",url);
		 $("#dataStr").submit();
	});
	var gcToggle = "#FFCC66";
	var gcBG = "#F0F9FF";
	</script>
	<div id="datastable" style="overflow:auto;position:relative;">
	<s:if test='anyChartStr!=""'>
   <!-- Top10分析、对比分析数据表 -->
   <table id="dataTable1" class="tongji-grid table-width100 grayborder" style="border:1px solic #ccc;width:99%;">
     <tr>
       <th width="5%" rowspan="2"><span>序号</span></th>
       <th width="30%" rowspan="2"><span id="dataTable1title1">资源名称</span></th>
       <th width="23%" rowspan="2"><span id="dataTable1title2">IP地址</span></th>
       <th width="42%" colspan="4"  class="rt  textalign"><span id="tableTitle1"></span><span id="tableTitle1danwei"></span></th>
     </tr>
     <tr>
       <th width="10%" class="rb textalign"><span>最大值</span></th>
       <th width="10%" class="rb textalign"><span>平均值</span></th>
       <th width="10%" class="rb textalign"><span>最小值</span></th>
       <th width="12%" class="rb textalign"><span>分析</span></th>
     </tr>
     <s:iterator value="analysisDatas" id="vo" status="f">
     	<tr   id="line" bgcolor='#ffffff' onmouseover="this.bgColor='#EAEAEA';"    onMouseOut="this.bgColor='#ffffff'">
	       <td><p class="topn-<s:property value="#f.index+1"/>"><s:property value="#f.index+1"/></p></td>
	       <td><span style="word-break :break-all;"><s:property value="#vo.resName"/></span></td>
	       <td>
	       <s:if test="#vo.ip!=null">
	      <span style="word-break :break-all;"> <s:property value="#vo.ip"/></span>
		   </s:if>
		   <s:else>
		   -
		   </s:else>
		   </td>
	       <td><s:property value="#vo.maxVal"/></td>
	       <td><s:property value="#vo.avgVal"/></td>
	       <td><s:property value="#vo.minVal"/></td>
	       <td><span instance="<s:property value="#vo.instaceId"/>" metricId="<s:property value="#vo.metricId"/>" startTimeLong="<s:property value="#vo.startTime"/>" endTimeLong="<s:property value="#vo.endTime"/>" class="ico ico-t-right"></span></td>
     	</tr>
     </s:iterator>
   </table>
   <!-- 故障分析数据表 -->
   <table id="dataTable2" class="tongji-grid table-width100 whitebg" style="width:99%;">
     <tr>
       <th width="5%">序号</th>
       <th width="35%"><span id="dataTable2title1">资源名称</span></th>
       <th width="35%"><span id="dataTable2title2">IP地址</span></th>
       <th width="15%"><span id="tableTitle2"></span><span id="tableTitle2danwei"></span></th>
       <th width="10%">分析</th>
     </tr>
     <s:iterator value="analysisDatas" id="vo" status="f">
     	<tr id="line" bgcolor='#ffffff' onmouseover="this.bgColor='#EAEAEA';"    onMouseOut="this.bgColor='#ffffff'">
     		<s:if test="#f.index < 10">
     			<td><p class="topn-<s:property value="#f.index+1"/>"><s:property value="#f.index+1"/></p></td>
     		</s:if>
	        <s:else>
	       		<td><p style="text-align:center;"><s:property value="#f.index+1"/></p></td>
	        </s:else>
	       <td><span style="word-break :break-all;"><s:property value="#vo.resName"/></span></td>
	       <td>
	       
	       <s:if test="#vo.ip!=null">
	       <span style="word-break :break-all;"><s:property value="#vo.ip"/></span>
		   </s:if>
		   <s:else>
		   -
		   </s:else>
	       </td>
	       <td><s:property value="#vo.avgVal"/></td>
	       <td><span instance="<s:property value="#vo.instaceId"/>" metricId="<s:property value="#vo.metricId"/>" startTimeLong="<s:property value="#vo.startTime"/>" endTimeLong="<s:property value="#vo.endTime"/>" class="ico ico-t-right"></span></td>
     	</tr>
     </s:iterator>
   </table>
   </s:if>
   </div>
	<script language="javascript">
		var returnType = "${returnType}";
		var anyChartStr = "${anyChartStr}";
		var islink = "${islink}";
		var isHaveRealtimeAnalysis = ('<s:property value="@com.mocha.bsm.report.type.AnalysisType@Malfunction" />' == '${analysisView.type}') ? false : true;
    	var util = "${util}";
    	if (anyChartStr=='')
    	{
    		$("#datastable").height("200px");
    	}
    	//alert(util);
    </script>