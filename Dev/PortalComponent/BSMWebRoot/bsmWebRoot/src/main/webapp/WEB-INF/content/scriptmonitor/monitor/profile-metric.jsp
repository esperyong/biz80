<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script type="text/javascript">
<!--
$(document).ready(function(){
	$metrics = $("#metrics");
//	metricIndex=${size};
	$splitValue = $("input[name='splitValue']");
	$delMetrics = $("#delMetrics");
	$createMetrics = $("#createMetrics");
	if($splitValue.val()==""){
		$splitValue.val(",");
	}
	$("#run").click(function(){
		executeScript();
	});
	$createMetrics.click(function(){
		var splitValue = $splitValue.val();
		if(!$.validate($('#splitIdDiv'))){
				return false;
		}
		if(splitValue!=""){
			var resultValue = $("input[name=\"runResult\"]").val().split(splitValue);
			if(resultValue!=""){
				metricIndex=0;
				$metrics.empty();
				creatMetricTable(resultValue);
			}
		}
	});
	$delMetrics.click(function(){
		$("input:checkbox:checked",$metrics).parents("tr").remove();
		dialogResize();
	});
	isVisible($delMetrics,$createMetrics);
});
function newMetric(index,value){
	
	var html = "";
	html += "<tr><td align=\"middle\"><input type=\"checkbox\"/></td>";
	html += "<td align=\"left\">第<span id=\"rowIndex\">"+(index+1)+"</span>列</td>";
	html += "<td align=\"left\">";
	html += "<input name=\"metricList["+index+"].profileId\" value=\""+profileId+"\" type=\"hidden\"/>";
	html += "<input name=\"metricList["+index+"].metricId\"  value=\"\" jsName=\"metricId\" type=\"hidden\"/>";
	html += "<input name=\"metricList["+index+"].dataIndex\" value=\""+index+"\"type=\"hidden\"/>";
	html += "<input name=\"metricList["+index+"].metricName\" jsName=\"metricName\" type=\"text\" size=\"10\" value=\"默认指标"+(index+1)+"\"/>";
	html += "</td>";
	html += "<td align=\"left\"><select name=\"metricList["+index+"].dataType\" style=\"width:80px\" id='dataType"+index+"'>";
	html += createOptionFun(typeTest(value));
	html += "</select></td></tr>";
	return html;
}
function createOptionFun(dataType){
	var html="";
	<s:iterator value="metrics">
	if("${value}" == dataType){
		html += "<option value=\"${key}\" selected>${value}</option>";
	}else{
		html += "<option value=\"${key}\">${value}</option>";
	}
	</s:iterator>
	return html;
}
function typeTest(value){
	  var dataType;
	  var num = /^\d+(\.\d+)?$/;
	  var boolt = new RegExp("true","i");
	  var boolf = new RegExp("false","i");
	  if(num.test(value)){
		  dataType = "数值";
	  }else if(boolf.test(value)||boolt.test(value)){
		  dataType = "布尔"; 
	  }else{
		  dataType = "字符串";
	  }
	  return dataType;
}

$.validationEngineLanguage.allRules.myNoSpecialStr={
				"regex":"/^$|^[^:;'&#<>()%*?！|\"^*]+$/",
				"alertText":"<font color='red'>*</font> ^^^不能输入非法字符  : ; ' & # < > ( ) % * ? ！ | &quot; ^"
}
//-->
</script>
<div class="blackbg01"><span class="ico ico-help"></span>说明：定义指标的生成规则。</div>
<div class="greytable-titlebg"><span class="greytable-titlebg-ico"></span><b>脚本返回值</b></div>
<div>
<ul class="fieldlist-n">
	<li><span class="field-middle">返回结果</span><span>：</span>
	<!--input name="runResult" value="" size="58" id="runResult" readonly="readonly"></input-->
	<input name="runResult" type="hidden" id="runResultFirst"></input>
	<textarea id="runResult" name="runResultText" cols="85" rows="5" readonly="readonly" wrap="off">
	</textarea>
	<span class="black-btn-l  multi-line" id="run" title="获取返回值"><span class="btn-r"><span class="btn-m"><a>获取返回值</a></span>
	</span>(最多支持500字符)</span></li>
</ul>
</div>
<div class="greytable-titlebg"><span class="greytable-titlebg-ico"></span><b>指标定义</b></div>
<div>
<ul class="fieldlist-n" id="splitIdDiv">
	<li><span class="field-middle">分隔符</span><span>：</span>
	<s:textfield name="splitValue" cssClass="validate[length[1,5],myNoSpecialStr]" value="%{splitValue}"></s:textfield>
	<span class="ico ico-what" title="返回值中所使用的分隔符。如果不指定分隔符，系统会使用“空隔”作为分隔符。注意，分隔符不支持：: ; ' & # < > ( ) % * ? ！ | &quot; ^"></span><span id="createMetrics" class="black-btn-l  multi-line"><span class="btn-r"> 
	<span class="btn-m" title="生成指标"><a>生成指标</a></span></span></span><span class="red">*</span>(最多支持10列，每列最多支持50字符)
	<span id="delMetrics" class="panel-gray-ico panel-gray-ico-close" title="删除"></span>
<!--<span id="addMetrics" class="panel-gray-ico panel-gray-ico-add"></span>-->
	</li>
</ul>
</div>
<div style="margin: 10px;" class="greywhite-border">
<table class="hundred">
	<thead>
		<tr class="monitor-items-head">
			<th width="10%">&nbsp;</th>
			<th>返回值</th>
			<th>指标名称</th>
			<th>类型</th>
		</tr>
	</thead>
	<tbody id="metrics">
		<s:iterator value="scriptMetricList" id="metricList" status="status">
		<tr>
		<td align="middle"><input type="checkbox"/></td>
		<td align="left">第<span id="rowIndex"><s:property value="#metricList.dataIndex+1"/></span>列</td>
		<td align="left">
		<input name="metricList[<s:property value="#status.index"/>].profileId" value="<s:property value="#metricList.profileId"/>" type="hidden"/>
		<input name="metricList[<s:property value="#status.index"/>].metricId"  value="<s:property value="#metricList.metricId"/>" jsName="metricId" type="hidden"/>
		<input name="metricList[<s:property value="#status.index"/>].dataIndex" value="<s:property value="#metricList.dataIndex"/>" type="hidden"/>
		<input name="metricList[<s:property value="#status.index"/>].metricName" value="<s:property value="#metricList.metricName"/>" jsName="metricName" type="text" size="10" />
		</td>
		<td align="left">
		<s:select name="metricList[%{#status.index}].dataType" style="width:80px" id="dataType" value="#metricList.dataType" list="metrics" listKey="key" listValue="value"/>
		</td>
		</tr>
		</s:iterator>
	</tbody>
</table>
</div>