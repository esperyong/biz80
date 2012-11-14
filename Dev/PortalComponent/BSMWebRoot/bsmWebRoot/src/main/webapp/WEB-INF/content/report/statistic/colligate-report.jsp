<%@ page language="java" contentType="text/html; charset=UTF-8"pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<div>
<page:applyDecorator name="popwindow" title="定制汇总报告">
	<page:param name="width">880px</page:param>
	<page:param name="topBtn_index_1">1</page:param>
	<page:param name="topBtn_id_1">colligateReportID</page:param>
	<page:param name="topBtn_css_1">win-ico win-close</page:param>
	
	<page:param name="bottomBtn_index_1">1</page:param>
	<page:param name="bottomBtn_id_1">createColligateReport</page:param>
	<page:param name="bottomBtn_text_1" >确定</page:param>

	<page:param name="bottomBtn_index_2">2</page:param>
	<page:param name="bottomBtn_id_2">cancelColligateReport</page:param>
	<page:param name="bottomBtn_text_2" >取消</page:param>

	<page:param name="bottomBtn_index_3">3</page:param>
	<page:param name="bottomBtn_id_3">applyColligateReport</page:param>
	<page:param name="bottomBtn_text_3" >应用</page:param>
	<page:param name="content">
			<div class="fold-top"><span class="fold-top-title">1.基本信息</span></div>
			<ul class="fieldlist-n" >
				<li><span class="field-middle">报告名称：</span> <input type="text" id="showReportName"><span class="red">*</span></li>
				<li id="statisticDatas"><span class="field-middle">报告周期：</span> 
				<input type="radio" name="statisticDate" id="day" checked="checked" /><span>日报</span> 
				<input type="radio" name="statisticDate" id="week" /> <span>周报</span> 
				<input type="radio" name="statisticDate" id="month" /> <span>月报</span> 
				<input type="radio" name="statisticDate" id="season" /> <span>季报</span> 
				<input type="radio" name="statisticDate" id="year" /> <span>年报</span>
				</li>	
				<li id="statisticTimeBound"></li>
				<li id="statisticSpareTime"></li>
				<li id="statisticMakeTime"></li>
				
			</ul>
			 <ul class="fieldlist-n"><li class="line"> </li></ul>
			<ul class="fieldlist-n">
				<li id="statisticReportShare"><span class="field-middle">共享报告：</span> 
				<input type="radio" name="statisticShare" value="yes"/> <span>是</span> 
				<input type="radio" name="statisticShare" checked="checked" value="no"/> <span>否 </span>
				</li>
				<li id="statisticReportField"><span class="field-middle">共享范围(域)：</span> 
				<input type="checkbox" name="statisticField" checked="checked" disabled=true value="tianjin"/> <span>天津</span> 
				<input type="checkbox" name="statisticField" disabled=true value="beijing"/> <span>北京</span>
				</li>
			</ul>
			<div class="fold-top"> <span class="fold-top-title">2.故障报告内容 </span><span class="red">*</span> <span  class="black-btn-l "><span class="btn-r"><span class="btn-m"><a onclick="send()">选择资源</a></span></span></span><span>0个</span></div>
			<div class="fold-top"> 
			<input type="checkbox" checked="checked"/><span>显示</span>
			<select><option>TOP5</option><option selected="selected">TOP10</option><option>TOP15</option></select><span>图表</span>
			<span>线 |柱</span>
			<span>选择指标：</span><input type="checkbox" checked="checked"/><span>可用性</span><input type="checkbox"/><span>不可用时长</span>
			<input type="checkbox"/><span>MTTR</span><input type="checkbox"/><span>MTBF</span><span>(至少选择一个指标)</span>
			<span class="ico ico-select"></span><span>预览</span>
			<div>Flash</div>
			</div>
			<div class="fold-top"> 
			<span class="fold-top-title">数据汇总 </span>
			<div><page:applyDecorator name="indexcirgrid">
				<page:param name="id">tableFailure</page:param>
				<page:param name="width">100%</page:param>
				<page:param name="height">100%</page:param>
				<page:param name="tableCls">grid-gray</page:param>
				<page:param name="gridhead">[{colId:"id", text:"序号"},{colId:"resoureId", text:"资源"},{colId:"resoureType", text:"资源类型"},{colId:"runTime", text:"运行时间"},{colId:"usability", text:"可用性(%)"},{colId:"unusability", text:"不可用时长(小时)"},{colId:"MTTRTime", text:"MTTR(小时)"},{colId:"MTBFTime", text:"MTBF(小时)"}]</page:param>
				<page:param name="gridcontent">${failureReportInfo }</page:param>
			</page:applyDecorator></div>
			</div>
			<div class="fold-blue">
			  <div class="fold-top"><span class="fold-top-title">3.指标定义</span><span class="red">*</span><span class="ico ico-add" title="添加" id="add-customizationInfo"></span><span class="ico ico-delete" title="删除" id="detele-customizationInfo"></span></div>
			   <div class="padding8"><table id="customizationTable" class="tongji-grid table-width100 whitebg grayborder" style="border:1px solic #ccc;">
			     <tr>
			       <th rowspan="2"><input type="checkbox" id="fullChoiceResource" onclick="fullChoice()"/>名称</th>
			       <th rowspan="2">资源类型</th>
			       <th rowspan="2">资源 <span class="red">*</span></th>
			       <th rowspan="2">指标<span class="red">*</span></th>
			       <th colspan="2"  class="rt  textalign">显示内容</th>
			       <th rowspan="2">预览</th>
			     </tr>
			     <tr>
			       <th class="rb textalign">汇总数据</th>
			       <th class="rb textalign">详细数据</th>     
			     </tr>
			     <tr id="customizationTableInfo"></tr>
			   </table>
			  </div>
			</div>
			<s:form id="reportInfo">
			<input type="hidden" id="statisticReportName" name="reportName"/>
			<input type="hidden" id="statisticReportCyc" name="reportCyc"/>
			<input type="hidden" id="statisticReportCreate" name="reportCreate"/>
			<input type="hidden" id="statisticReportShare" name="reportShare"/>
			<input type="hidden" id="statisticReportField" name="reportField"/>
			</s:form>
	</page:param>
</page:applyDecorator>
</div>
<script type="text/javascript">
//默认弹出时显示的内容
$(function(){
	var reportName=$("#scustomReportName").val();
	$("#showReportName").val(reportName);
	$("#statisticReportName").val(reportName);
	$("#statisticTimeBound").html("<span class=\"field-middle\"><span>事件范围:</span></span>"+dayHtml.join(""));
	$("#statisticSpareTime").html("<span class=\"field-middle\"><span></span></span><input type=\"checkbox\"/><span>空闲：</span></span>"+dayHtml.join(""));	
	$("#statisticMakeTime").html("<span class=\"field-middle\"><span>生成时间:</span></span><span>每天</span><span id=\"dayPoint\">9</span><span>点生成日报</span>");	
})
//选择事件
$("input[name$='statisticDate']").click(function(){	
	reportCyc(this);
});
//报表共享事件
$("input[name$='statisticShare']").click(function(){
	reportShare(this);
});
//报表域
$("input[name$='statisticField']").click(function(){
	reportField(this);
});
//添加性能报告指标 
$("#addReportInfo").click(function(){		
		popWindow("${ctx}/report/statistic/statisticManage!loadAddReportInfo.action",550,150);
});
//删除
$("#deteleReport").click(function(){
	deteleTableRow(this);
});
//确定
$("#createColligateReport").click(function(){
	submit();
});
//应用
$("#applyColligateReport").click(function(){
	apply();
});
//取消返回
$("#cancelColligateReport").click(function(){
	backWindow();
});
</script>
