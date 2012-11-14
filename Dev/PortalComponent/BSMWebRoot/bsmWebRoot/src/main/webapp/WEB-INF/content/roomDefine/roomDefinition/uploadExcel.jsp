<!--机房-机房定义-上传excel uploadExcel.jsp-->
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<%@ page import="java.util.*,com.opensymphony.xwork2.util.*"%> 
<title>导入</title>
<link rel="stylesheet" href="${ctx}/css/validationEngine.jquery.css" 
	type="text/css" media="screen" title="no title" charset="utf-8" />
<link rel="stylesheet" href="${ctx}/css/common.css"
	type="text/css" />
<link rel="stylesheet" href="${ctx}/css/public.css"
	type="text/css" />
<link rel="stylesheet" href="${ctx}/css/UIComponent.css" type="text/css" />	
<script src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script src="${ctx}/js/jquery.validationEngine-cn.js" type="text/javascript"></script>
<script src="${ctx}/js/jquery.validationEngine.js" type="text/javascript"></script>


</head>


<%
String folderAllPathName = "";
String folderName = "";	
String falshFolderStr = "";
String saveFlag = "";
String errorFlag = "";
String sumErrorInfo = "";
String field = "";
int successCount = 0;
int errorCount = 0;
	//获取封装输出信息的ValueStack对象
	ValueStack vs = (ValueStack)request.getAttribute("struts.valueStack");
	//调用ValueStack的findValue方法获取UploadPictureAction属性值
	if(null != vs && !"".equals(vs)){
		if(vs.findValue("saveFlag") != null && !"".equals(vs.findValue("saveFlag"))){
			saveFlag = (String)vs.findValue("saveFlag");
		}
		if(vs.findValue("errorFlag") != null && !"".equals(vs.findValue("errorFlag"))){
			errorFlag = (String)vs.findValue("errorFlag");
		}
		if(vs.findValue("successCount") != null && !"".equals(vs.findValue("successCount"))){
			successCount = (Integer)vs.findValue("successCount");
		}
		if(vs.findValue("errorCount") != null && !"".equals(vs.findValue("errorCount"))){
			errorCount = (Integer)vs.findValue("errorCount");
		}
		if(vs.findValue("sumErrorInfo") != null && !"".equals(vs.findValue("sumErrorInfo"))){
			sumErrorInfo = (String)vs.findValue("sumErrorInfo");
			//sumErrorInfo = sumErrorInfo.replaceAll("##","<br/>");
		}
		if (vs.findValue("field") != null && !"".equals(vs.findValue("field"))){
			field = (String)vs.findValue("field");
		}
		if(vs.findValue("folderAllPathName") != null && !"".equals(vs.findValue("folderAllPathName"))){
			folderAllPathName = (String)vs.findValue("folderAllPathName");
			folderName = (String)vs.findValue("folderName");
			
			if(null != folderAllPathName && !"".equals(folderAllPathName)){
				folderAllPathName = folderAllPathName.replaceAll("\\\\","//");
			}
			if(folderAllPathName.indexOf("upload")>0){
				String []str = folderAllPathName.split("upload");
				falshFolderStr = "/upload"+str[1];
			}
			if(folderAllPathName != null && !"".equals(folderAllPathName) && saveFlag ==""){
				%>
				<script type="text/javascript">
				$(document).ready(function() {
					if("<%=errorFlag%>" == "true") {
						alert(" 不能解析Excle文件，请重新选择。");
					}else{
						showDiv();
					}
					
				});
				</script>
				<%
			}
		}
	}
	String error = request.getParameter("error");
	if(error != null && !error.equals("")){
		if(error.equals("1")){
			%>
			<script type="text/javascript">
				alert("上传文件大小不能超过5mb");
			</script>
			<%
		}
	}
	
	
%>
<script type="text/javascript">

function getFileSize(filename)
{
    // var filename = document.all('fileup').value; //获得上传文件的物理路径
    if(filename =='')
     {
       //alert("你还没有浏览要上传的文件");
return false;
     }

     try {
      
var fso,f,fname,fsize;
var flength=5000; //设置上传的文件最大值（单位：kb），超过此值则不上传。
fso=new ActiveXObject("Scripting.FileSystemObject");
        f=fso.GetFile(filename);//文件的物理路径
fname=fso.GetFileName(filename);//文件名（包括扩展名）
fsize=f.Size; //文件大小（bit）
fsize=fsize/1024;
//去掉注释，可以测试
        //alert("文件路径："+f);
//alert("文件名："+fname);
//alert("文件大小："+fsize+"kb");
if(fsize>flength){
	//alert("上传的文件到小为："+fsize+"kb,\n超过最大限度"+flength+"kb,不允许上传 ");
return false;
}
else{
	//alert("允许上传，文件大小为："+fsize+"kb");
	}
}
      catch(e)
{
alert(e+"\n 跳出此消息框，是由于你的activex控件没有设置好,\n"+
"你可以在浏览器菜单栏上依次选择\n"+
"工具->internet选项->\"安全\"选项卡->自定义级别,\n"+
"打开\"安全设置\"对话框，把\"对没有标记为安全的\n"+
"ActiveX控件进行初始化和脚本运行\"，改为\"启动\"即可");
         return false;
      }
  
   return true;
    
}

if("<%=saveFlag%>" == "true") {
	$(document).ready(function() {
		var loadStr = parent.window.opener.location.href;
		if(loadStr.indexOf("IndexVisit")>=0){
			parent.window.opener.deviceManagerFunClk();
			
		}else if(loadStr.indexOf("DevTypeManagerVisit")>=0){
			parent.window.opener.location.href=parent.window.opener.location; 
		}else{
			parent.window.opener.location.href=parent.window.opener.location;
		}

		parent.$("#successSpanId").html("<%=successCount%>");
		parent.$("#errorSpanId").html("<%=errorCount%>");
		//parent.$("#sumErrorSpanId").html("<%=sumErrorInfo%>");

		var errorStr ="<%=sumErrorInfo%>"; 
		var arr = errorStr.split("##");
		var strError="";
		for (var i=0;i<arr.length-1;i++){
			strError+="<li style='line-height:20px'><span style='width:88%; word-warp: break-word; word-break: break-all; clear: both; float: left;'>"+arr[i]+"</span></li>";
		}

		parent.$("#sumErrorSpanId").html(strError);
		parent.$("#loadingId").hide();
		parent.timeflagFun();
		
		//window.close();
	});
	
	//window.close();
}
//验证不为空 上传文件类型错误
function validatorFun(){
	var roomId = $('#roomIdHidden').val();
	//alert("roomid:"+roomId);
	var upload = $("#upload").val();
	var bool = checkUploadFile(upload);
	//alert(title + "+" + upload);
	if(upload == null || upload == ""){
		alert("上传路径不允许为空");
		return false;
	}else if(!bool){
		alert("上传格式不符");
		return false;
	}else{
		document.uploadForm.action="${ctx}/roomDefine/UploadExcel.action";
		document.uploadForm.target="";
		document.uploadForm.submit();
		return true;
	}
}

//过滤上传格式
function checkUploadFile(upload) {
	var file1 = "xls";
	//var file2 = "rar";
	var fileCheck = upload;
	if(fileCheck != "")
	{
		var s = fileCheck.match(/^(.*)(\.)(.{1,8})$/)[3];
		s = s.toLowerCase();
		var bM = false;
		if(s == file1) bM=true;
		if(!bM){
			document.getElementById("upload").value='';//清空file框
			return false;
		}
	}
	return true;
}

//屏蔽输入
function DisabledKeyInput(){
   if(event.keyCode!=8&&event.keyCode!=46) event.returnValue=false;
   if(event.ctrlKey) return false;
}

function reset(){
	$('form#Upload')[0].reset();
}

//显示隐藏div
function showDiv(){
	$("#twoDiv").show("slow");
	$("#title2Div").show("slow");
	
	$("#oneDiv").hide("slow");
	$("#first_Shrink").hide();
	
}
//显示隐藏div
function showThreeDiv(){
	$("#title2Div").show("slow");
	$("#title3Div").show("slow");
	$("#threeDiv").show("slow");
	$("#twoDiv").hide("slow");
	$("#oneDiv").hide("slow");
	$("#first_Shrink").hide();
}
function ajaxGetRowCellVal(){
	
	var params = $("#row").val()+","+$("#cell").val();
	//alert(params);
	$.ajax({
		type: "post",
		dataType:'json', //接受数据格式 
		data:"ajaxParam="+params+"&strPath="+'<%=folderAllPathName%>', 
		url: "${ctx}/roomDefine/GetExcelName!getRowCellList.action",
		beforeSend: function(XMLHttpRequest){
		//ShowLoading();
		},
		success: function(data, textStatus){
			$("#twoDiv select").html("");
			//alert($("#twoDiv select")[0]);
			
				
		var arr=new Array("机柜号","机框号","设备名称","IP地址","MAC地址","设备类型","设备号","备注");
		for(var i=0;i<arr.length;i++){
			var ops = [];
			var flag = false;
			
			for(var key in data.devValues){
				//alert("key="+key+"  value="+data.devValues[key]);
				var selected = "";
				var value = data.devValues[key];
				if(arr[i]==value){
					selected = "selected";
					flag =true;
				}else{
					selected = "";
				}
				ops.push("<option value='"+ key +"' "+ selected +">"+ value +"</option>");
			}
			if(!flag){
				ops.push("<option value='' selected></option>");
			}
			$($("#twoDiv select")[i]).append(ops.join(""));
		}	
		//var listJson = $parseJSON(data.devValues);
		},
		complete: function(XMLHttpRequest, textStatus){
		//HideLoading();
		},
		error: function(){
		//请求出错处理
			alert("error");
		}
		});
}

$(document).ready(function() {
	$("#uploadForm").validationEngine({
		promptPosition:"centerRight", 
		validationEventTriggers:"keyup blur change",
		inlineValidation: true,
		scroll:false,
		success:false
	})
	$("#importantForm").validationEngine({
		promptPosition:"centerRight", 
		validationEventTriggers:"keyup blur change",
		inlineValidation: true,
		scroll:false,
		success:false
	})
	$("#row").change(ajaxGetRowCellVal);
	$("#cell").change(ajaxGetRowCellVal);

	// 收缩功能
	$("#first_Shrink").click(function(){
		if($("#first_Shrink").attr("class") == "panel-titleico2" ){
			$("#first_Shrink").removeClass("panel-titleico2");
			$("#first_Shrink").addClass("panel-titleico1");
			$("#oneDiv").hide();
		}else{
			$("#first_Shrink").removeClass("panel-titleico1");
			$("#first_Shrink").addClass("panel-titleico2");
			$("#oneDiv").show();
		}	
	});
	
	// 第二步的收缩功能
	$("#second_shrink").click(function(){
		if($("#second_shrink").attr("class") == "panel-titleico2" ){
			$("#second_shrink").removeClass("panel-titleico2");
			$("#second_shrink").addClass("panel-titleico1");
			$("#twoDiv").hide();
		}else{
			$("#second_shrink").removeClass("panel-titleico1");
			$("#second_shrink").addClass("panel-titleico2");
			$("#twoDiv").show();
		}	
	});
	
});

</script>
<body> 
<page:applyDecorator name="popwindow"  title="导入">
	
	<page:param name="width">540px;</page:param>
	<page:param name="topBtn_index_1">1</page:param>
	<page:param name="topBtn_id_1">closeId</page:param>
	<page:param name="topBtn_css_1">win-ico win-close</page:param>
	
	
	<page:param name="content">
<form id="uploadForm" name="Upload" action="${ctx}/roomDefine/UploadExcel.action" method="post" enctype="multipart/form-data">
<div id="title1Div" class="panel-titlebg"><span></span><span>1.选择导入Excel文件</span><a class="panel-titleico2" name="first_Shrink" id="first_Shrink"  href="#"></a></div>
<div id="oneDiv" name="oneDiv">
	
	<ul class="panel-singleli">
		<li >
			<span class="field" style="overflow: hidden;white-space: nowrap;text-overflow:ellipsis;width:103px;" title="所属<s:property value='domainPageName' />">所属<s:property value='domainPageName' /></span>
	   		<span>：<s:select list="allDomains" cssClass="validate[required]" name="field" id="field" listKey="ID" listValue="name" /></span>
	   		<span class="txt-red" style="line-height:20px">*</span> <span class="ico ico-what" title="设置待添加设备的所属域管理权限。"></span>
		</li>
		<li>
		<span class="field">选择文件</span>
        <span>：</span><input id="text" type="text"/><span class="red">*</span>
        <span class="buttoncopy"><input type="file" name="upload" value="" id="upload" onpropertychange="getFileSize(this.value);" onKeyDown="DisabledKeyInput();" class="validate[required]"/></span>
<script type="text/javascript">
<!--

$("#upload").change(type);
function type(){
	
	var text = document.getElementById("text");
	//alert($('input[type="file"]').val());
	text.value = $('input[type="file"]').val();
}
-->
</script>
		</li>
	</ul>
	<ul class="panel-multili">
		<li>说明：1.可使用自定义Excel文件或在<span id="downloadId" class="red" style="cursor:pointer">此处</span>下载模板。</li>
		<li style="text-indent:36px;">2.默认取第一个Sheet页的内容。</li>
		<li style="text-indent:36px;">3.文件大小不能超过5MB。</li>
	</ul>
    <ul class="panel-button">
		<li><span></span><a id="Upload_0" onClick="return validatorFun();">下一步</a></li>
    </ul>
</div>	
<input type="hidden" id="roomIdHidden" name="roomId" value="<s:property value='roomId'/>" />
</form>
<div id="title2Div" style="display:none" class="panel-titlebg"><span></span><span>2.匹配表单项</span><a class="panel-titleico2" id="second_shrink" name="second_shrink" href="#"></a></div>
<form id="importantForm" name="importantForm" action="${ctx}/roomDefine/ImportantExcel.action" method="post" >
<input type="hidden" name = "devicefield" id="devicefield" value="<s:property value='field'/>"/>
<div id="twoDiv" style="display:none">
 	<table class="panel-table" align="center">
  		<tr>
  			<th width="30%">机房设备表列名</th>
  			<th>导入Excel表单列名（表头起始行
  			<input type="text" class="validate[custom[onlyPositiveNumber],required,length[0,2]]" name="row" id="row" size="2" value="2" />
  			<!--  列-->
  			<input type="hidden" class="validate[custom[onlyPositiveNumber],required,length[0,2]]" name="cell" id="cell" size="2" value="1" />
  			）
  			</th>
  		</tr>
  		<tr>
  			<td>设备名称</td>
            <td>
  			<SELECT id="chooseDevName" name="chooseDevName" class="" style="width:200px">
<!--   				<option value="" selected="selected">设备名称</option>-->
   				<s:iterator value="devValues" id="map">
				  <s:if test="#map.value=='设备名称'">
 				  	<option value="<s:property value="#map.key" />" selected="selected" ><s:property value="#map.value" /></option>
 				  </s:if>
 				  <s:else>
 				  	<option value="<s:property value="#map.key" />" ><s:property value="#map.value" /></option>
 				  </s:else>
				</s:iterator>
   			</SELECT>
            </td>
  		</tr>
  		<tr class="bgcolor">
  			<td>IP地址</td>
  			<td>
            <SELECT id="ipAddress" name="ipAddress" class="validate[required]" style="width:200px">
<!--   				<option value="" selected="selected">IP地址</option>-->
   				<s:iterator value="devValues" id="map">
				  <s:if test="#map.value=='IP地址'">
 				  	<option value="<s:property value="#map.key" />" selected="selected" ><s:property value="#map.value" /></option>
 				  </s:if>
 				  <s:else>
 				  	<option value="<s:property value="#map.key" />" ><s:property value="#map.value" /></option>
 				  </s:else>
				</s:iterator>
   			</SELECT>
   			<span class="red">*</span>
            </td>
  		</tr>
  		<tr >
  			<td>MAC地址</td>
  			<td>
   			<SELECT id="macAddress" name="macAddress" class="validate[required]" style="width:200px">
<!--   				<option value="" selected="selected">MAC地址</option>-->
   				<s:iterator value="devValues" id="map">
				  <s:if test="#map.value=='MAC地址'">
 				  	<option value="<s:property value="#map.key" />" selected="selected" ><s:property value="#map.value" /></option>
 				  </s:if>
 				  <s:else>
 				  	<option value="<s:property value="#map.key" />" ><s:property value="#map.value" /></option>
 				  </s:else>
				</s:iterator>
   			</SELECT>
   			
   			<span class="red">*</span>
            </td>
  		</tr>
  		<tr class="bgcolor">
  			<td>设备类型</td>
  			<td>
            <SELECT id="deviceType" name="deviceType" class="" style="width:200px">
<!--   				<option value="" selected="selected">设备类型</option>-->
   				<s:iterator value="devValues" id="map">
				  <s:if test="#map.value=='设备类型'">
 				  	<option value="<s:property value="#map.key" />" selected="selected" ><s:property value="#map.value" /></option>
 				  </s:if>
 				  <s:else>
 				  	<option value="<s:property value="#map.key" />" ><s:property value="#map.value" /></option>
 				  </s:else>
				</s:iterator>
   			</SELECT>
            </td>
  		</tr>
  		<tr>
  			<td>机柜号</td>
            <td>
  			<SELECT id="choosejigui" name="choosejigui" class="" style="width:200px">
<!-- 				<option value="" selected="selected">机柜号</option>-->
 				<s:iterator value="devValues" id="map">
 				  <s:if test="#map.value=='机柜号'">
 				  	<option value="<s:property value="#map.key" />" selected="selected" ><s:property value="#map.value" /></option>
 				  </s:if>
 				  <s:else>
 				  	<option value="<s:property value="#map.key" />" ><s:property value="#map.value" /></option>
 				  </s:else>
				</s:iterator>
   			</SELECT>
            </td>
  		</tr>
  		<tr class="bgcolor">
  			<td>机框号</td>
            <td>
  			<SELECT id="choosejikuang" name="choosejikuang" class="" style="width:200px">
<!--   				<option value="" selected="selected">机框号</option>-->
   				<s:iterator value="devValues" id="map">
   			      <s:if test="#map.value=='机框号'">
 				  	<option value="<s:property value="#map.key" />" selected="selected" ><s:property value="#map.value" /></option>
 				  </s:if>
 				  <s:else>
 				  	<option value="<s:property value="#map.key" />" ><s:property value="#map.value" /></option>
 				  </s:else>
				</s:iterator>
   			</SELECT>
            </td>
  		</tr>
  		<tr >
  			<td>设备号</td>
  			<td>
            <SELECT id="deviceNo" name="deviceNo" class="" style="width:200px">
   				<s:iterator value="devValues" id="map">
				  <s:if test="#map.value=='设备号'">
 				  	<option value="<s:property value="#map.key" />" selected="selected" ><s:property value="#map.value" /></option>
 				  </s:if>
 				  <s:else>
 				  	<option value="<s:property value="#map.key" />" ><s:property value="#map.value" /></option>
 				  </s:else>
				</s:iterator>
   			</SELECT>
            </td>
  		</tr>
  		<tr class="bgcolor">
  			<td>备注</td>
  			<td>
            <SELECT id="notes" name="notes" class="" style="width:200px">
   				<s:iterator value="devValues" id="map">
				  <s:if test="#map.value=='备注'">
 				  	<option value="<s:property value="#map.key" />" selected="selected" ><s:property value="#map.value" /></option>
 				  </s:if>
 				  <s:else>
 				  	<option value="<s:property value="#map.key" />" ><s:property value="#map.value" /></option>
 				  </s:else>
				</s:iterator>
   			</SELECT>
            </td>
  		</tr>
  	</table>
	<ul class="panel-multili">
		<li>说明：1.匹配导入Excel表单列和机房设备表单列的对应关系。</li>
		<li style="text-indent:36px;">2.用户可设置 Excel表头信息获取位置，修改行号和列号。</li>
		<li style="text-indent:36px;">3.列名下拉框选择空时，该列数据将保持不变。</li>
	</ul>
    <ul class="panel-button">
		<li>
		<span></span><a id="important_0" onClick="importantExcel();" style="cursor: pointer">导入</a>
		</li>
    </ul>
</div>
<div id="title3Div" style="display:none" class="panel-titlebg"><span></span><span>3.导入结果</span><a class="panel-titleico1" href="#"></a></div>
<div id="threeDiv" style="display:none">
	<ul style="padding:0 5px">
		<li id="loadingId"><span class="" >loading...</span></li>
		<li style="white-space:nowrap;word-wrap:break-word"><span class="bold" style="display:inline-block;width:74%">导入结果：</span><span class="ico ico-excel" id="exportReportId" title="导出报告"></span><span class="">耗用时间：<span id="timeDisId">00:00:00</span></span></li>
	</ul>
	<table class="panel-table" align="center">
  		<tr>
  			<th width="30%">结果</th>
  			<th></th>
  		</tr>
  		<tr>
  			<td>导入成功：</td>
            <td><span id="successSpanId"></span>条</td>
  		</tr>
  		<tr>
  			<td>导入失败：</td>
            <td><span id="errorSpanId" class="red"></span>条 <span class="ico ico-excel" id="exportExcelId"></span></td>
  		</tr>
  		<tr>
  			<td colspan="2">失败原因：<ul style="left:60px;position:relative;top:-22px" id="sumErrorSpanId"></ul></td>
<!--            <td class="red"></td>-->
  		</tr>
  	</table>
</div>
<input type="hidden" name="folderAllPathName" value="<%=folderAllPathName%>">
<input type="hidden" id="roomIdHidden" name="roomId" value="<s:property value='roomId'/>" />
<input type="hidden" id="errorJsonStr" name="errorJsonStr" value="<s:property value='errorJsonStr'/>" />
<input type="hidden" id="successCount" name="successCount" value="<%=successCount%>" />
<input type="hidden" id="errorCount" name="errorCount" value="<%=errorCount%>" />
<input type="hidden" id="sumErrorInfo" name="sumErrorInfo" value="<%=sumErrorInfo%>" />
</form>
</page:param>
</page:applyDecorator>
<iframe name="submitIframe" id="submitIframeId" frameborder="0" scrolling="no" height="0" width="0" src=""></iframe>
  </body> 
</html>

<script type="text/javascript">

String.prototype.trim = function(){   
	  return this.replace(/(^\s*)|(\s*$)/g,"");   
}

//验证数字
function checkNum(value){
	 var rep = /[^0-9]/;
	 var v = value.match(rep);
	 if (v != null) {
	      return false;
	   }
	 return true;
}



function importantExcel(){
	var roomId = $('#roomIdHidden').val();
	//alert("importantExcel():roomId=="+roomId);
	
	$("#importantForm").attr("target","submitIframe");
	$("#importantForm").submit();
	//document.importantForm.submit();
	showThreeDiv();
	//耗时启动计时器
	startTime();
}

var h=0;
var m=0;
var s=0;
var timeclose = false;
function startTime() {
// add a zero in front of numbers<10
h=checkTime(h,"hh");
m=checkTime(m,"mm");
s=checkTime(s,"ss");
$("#timeDisId").html(h+":"+m+":"+s);
if(!timeclose) {
	setTimeout('startTime()',1000);
}
}

function checkTime(i,str) {
	if(str == "ss" && i<60){
		i++;
		i=iszero(i);
	}
	if(i==60 && str == "ss" ){
		i=0;
		if(m<60){
		m++;
		}
		
	}
	if(str == "mm" ||str == "hh"){
		i=Number(i);
		i=iszero(i);
		//alert(i);
	}
	if(i==60 && str == "mm"){
		i=0;
		if(h<60){
		h++;
		}
	}
	
  	return i;
}
function iszero(i){
	if (i<10){
		i="0" + i;
	}
	return i;
}
//$("#loadingId").click(timeflagFun);
function timeflagFun() {
	timeclose = true;
}
/**
 * 导出加入失败的excel记录.
 */
$("#exportExcelId").click(function () {
	var str ="";
	try{
		str = document.submitIframe.$("#errorJsonStr").val();
	}catch(e){
		str = $("#errorJsonStr").val();
	}
	$("#errorJsonStr").val(str);
	$("#importantForm").attr("action","${ctx}/roomDefine/ImportantExcel!exportErrorExcel.action");
	//$("#importantForm").attr("target","submitIframe");
	$("#importantForm").submit();
});
/**
 * 导出 报告excel.
 */
$("#exportReportId").click(function () {
	var str = "";
	var successCount = "";
	var errorCount = "";
	var sumErrorInfo = "";
	try{
		str = document.submitIframe.$("#errorJsonStr").val();
		successCount = document.submitIframe.$("#successCount").val();
		errorCount = document.submitIframe.$("#errorCount").val();
		sumErrorInfo = document.submitIframe.$("#sumErrorInfo").val();
	}catch(e){
		str = $("#errorJsonStr").val();;
		successCount = ("#successCount").val();
		errorCount = $("#errorCount").val();
		sumErrorInfo = $("#sumErrorInfo").val();
	}
	$("#errorJsonStr").val(str);
	$("#successCount").val(successCount);
	$("#errorCount").val(errorCount);
	$("#sumErrorInfo").val(sumErrorInfo);
	$("#importantForm").attr("action","${ctx}/roomDefine/ImportantExcel!exportReportExcel.action");
	$("#importantForm").submit();
});
$("#downloadId").click(function () {
	$("#uploadForm").attr("action","${ctx}/roomDefine/ImportantExcel!downloadExcel.action");
	$("#uploadForm").attr("target","submitIframe");
	$("#uploadForm").submit();
});
</script>