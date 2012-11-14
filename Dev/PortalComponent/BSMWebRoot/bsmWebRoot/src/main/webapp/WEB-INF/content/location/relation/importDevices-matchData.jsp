<!-- WEB-INF\content\location\relation\excel-templates-upload.jsp -->
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<base target="_self">
<title>导入设备位置信息</title>
<link rel="stylesheet" href="${ctxCss}/common.css"
	type="text/css" />
	<link href="${ctxCss}/master.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/public.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/UIComponent.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/validationEngine.jquery.css" rel="stylesheet" type="text/css" media="screen" title="no title" charset="utf-8" />
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<script src="${ctxJs}/jquery-1.4.2.min.js"></script>
<script src="${ctxJs}/jquery.select.js"></script>
<script src="${ctxJs}/jquery.validationEngine-cn.js" type="text/javascript"></script>
<script src="${ctxJs}/jquery.validationEngine.js" type="text/javascript"></script>
<script src="${ctxJs}/location/dialogResize.js"></script>
</head>
<script type="text/javascript">
var srcSelect = null;
$(document).ready(function() {
	
	$("form").validationEngine({
		promptPosition:"centerRight", 
		validationEventTriggers:"keyup blur change",
		inlineValidation: true,
		scroll:false,
		success:false
	})
	
	$("#closeId").click(function(){
		window.close();
	});
	
	$("#next").click(function(){
		$("form").submit();
	});

	$("#row,#cell").change(function(){
		$.ajax({
			type: "post",
			dataType:'json', //接受数据格式 
			data: $("form").serialize(), 
			url: "${ctx}/location/relation/importDevices!readColumnHeadersMap.action",
			success: function(data, textStatus){
				$("select").html("");

				for(var key in data.columnHeaders){
					$("#headers").append("<option value='"+ key +"'>"+ data.columnHeaders[key] +"</option>");
				}
				//设置全部下拉列表框
				setSelects();
			}
		});
	});
	setSelects();
	dialogCenter();
	$("#row").blur();
});
// 设置下拉列表框
function setSelects(){
	if(!srcSelect){
		srcSelect = $("#headers").get(0)
	}
	srcSelect.add(new Option("请选择",""),0);
	// 设置下拉框的选项集合
	$("#chooseDevName,#ipAddress,#macAddress,#resurceType,#domainName,#areaName,#builderName,#floorName,#roomName,#upIp,#upPort,#wallNumber,#workNumber,#cabinetNumb,#frameNumb,#deviceNo,#userName,#department,#desc")
	.addOptionsBySelect(srcSelect)
	.each(function (){
		var isExist = false;
		// 根据描述信息选择下拉框选项
		var desc = this.parentNode.previousSibling.innerText;
		for(var i=0;i<this.options.length;i++){  
	    	
	        if(this.options[i].text == desc||this.options[i].text == desc+'*') { 
	        	this.options[i].selected = true;
	        	isExist = true;
	            break;   
	        }   
	    };
	    // 选择第一个
	    if(!isExist){
	    	this.value="";
	    }
	});
}
</script>
<body> 
<s:select name="columnHeaders" id="headers" list="columnHeaders" listKey="key" listValue="value" style="display:none"></s:select>
<page:applyDecorator name="popwindow"  title="导入">
	
	<page:param name="width">560px</page:param>
	<page:param name="topBtn_index_1">1</page:param>
	<page:param name="topBtn_id_1">closeId</page:param>
	<page:param name="topBtn_css_1">win-ico win-close</page:param>
	
	<page:param name="bottomBtn_index_1">1</page:param>
	<page:param name="bottomBtn_id_1">next</page:param>
	<page:param name="bottomBtn_text_1">导入</page:param>
	
	<page:param name="content">
	<!--
<div class="panel-titlebg">
<ul class="panel-multili"  style="width: 530px"  >
<li><span class="field" >1.选择设备类型&nbsp;&nbsp;&nbsp;</span></li></ul></div>-->
<div class="panel-titlebg">
<ul class="panel-multili"  style="width: 530px" >
<li><span class="field" >1.选择导入Excel文件</span></li></ul></div>

<div class="panel-titlebg">
<ul class="panel-multili"  style="width: 530px" >
<li><span class="field" >2.匹配表单项</span>
</li></ul></div>
<div>
	<ul class="panel-multili">
		<li>说明：1.匹配导入Excel表单和关联设备表的列名对应关系。</li>
		<li style="text-indent:36px;">2.可设置Excel表头信息获取位置，修改行号和列号。</li>
		<li style="text-indent:36px;">3.列表下拉框可以选择为空。</li>
	</ul>
<form action="${ctx}/location/relation/importDevices!importDatas.action" method="post" >
<input type="hidden" name="resType" value='${resType}'/>
<input type="hidden" name="domainId" value='${domainId}'/>
<input type="hidden" name="tempFileName" value="${tempFileName }"/>

<div style="overflow-y:auto;height:400px;overflow-x:hidden;width=95%">
<table class="panel-table" align="center" width="530px" >
  <tr><th width="30%">导入设备表列名</th>
  		<th>导入Excel表单列名（表头起始行
  		<input type="text" name="row" id="row" size="2" value="${row }" 
  				class="validate[custom[onlyPositiveNumber],required,length[0,2]]"/>
  			列<input type="text" name="cell" id="cell" size="2" value="${cell }" 
  				class="validate[custom[onlyPositiveNumber],required,length[0,2]]"/>
  			）</th>
  </tr>
<tr>
<td>设备名称</td>
<td><select id="chooseDevName" name="matchDatas.chooseDevName" style="width:200px"></select><span class="red">*</span></td></tr>

<tr class="bgcolor"><td>设备IP</td>
<td><select id="ipAddress" name="matchDatas.ipAddress" class="validate[required]" style="width:200px"></select><span class="red">*</span></td></tr>
<tr><td>MAC地址</td>
<td><select id="macAddress" name="matchDatas.macAddress" class="validate[required]" style="width:200px"></select><span class="red">*</span></td></tr>
  	<tr class="bgcolor"><td>设备类型</td>
  	<td><select id="resurceType" name="matchDatas.resurceType" class="validate[required]" style="width:200px"></select><span class="red">*</span></td></tr>
	<tr><td>区域</td>
	<td><select id="domainName" name="matchDatas.domainName" style="width:200px"></select></td></tr>
  	<tr class="bgcolor"><td>地区</td><td><select id="areaName" name="matchDatas.areaName"  style="width:200px"></select></td></tr>
  	<tr><td>大楼</td><td><select id="builderName" name="matchDatas.builderName" style="width:200px"></select></td></tr>
  	<tr class="bgcolor"><td>楼层</td><td><select id="floorName" name="matchDatas.floorName" style="width:200px"></select></td></tr>
  	<tr><td>房间</td><td><select id="roomName" name="matchDatas.roomName" style="width:200px"></select></td></tr>
<s:if test="%{@com.mocha.bsm.location.enums.EquipmentTypeEnum@othernetworkdevice!=resType}">
	 <tr class="bgcolor"><td>上联设备IP</td><td><select id="upIp" name="matchDatas.upIp" style="width:200px"></select></td></tr>
	 <tr><td>上联设备端口</td><td><select id="upPort" name="matchDatas.upPort" style="width:200px"></select></td></tr>
	 <tr class="bgcolor"><td>墙面端口号</td><td><select id="wallNumber" name="matchDatas.wallNumber" style="width:200px"></select></td></tr>
	 <tr><td>工位号</td><td><select id="workNumber" name="matchDatas.workNumber" style="width:200px"></select></td></tr>
	 
</s:if>
<s:else>
	<tr class="bgcolor"><td>机柜号</td><td><select id="cabinetNumb" name="matchDatas.cabinetNumb"  style="width:200px"></select></td></tr>
  	<tr><td>机框号</td><td><select id="frameNumb" name="matchDatas.frameNumb"  style="width:200px"></select></td></tr>
</s:else>
    <tr class="bgcolor"><td>设备号</td><td><select id="deviceNo" name="matchDatas.deviceNo"  style="width:200px"></select></td></tr>
  	<tr><td>用户名</td><td><select id="userName" name="matchDatas.userName"  style="width:200px"></select></td></tr>
  	<tr class="bgcolor"><td>所属部门</td><td><select id="department" name="matchDatas.department"  style="width:200px"></select></td></tr>
  	<tr><td>备注</td><td><select id="desc" name="matchDatas.desc"  style="width:200px"></select></td></tr>
 </table>
</div>
</form>
</page:param>
</page:applyDecorator>
</body> 
</html>