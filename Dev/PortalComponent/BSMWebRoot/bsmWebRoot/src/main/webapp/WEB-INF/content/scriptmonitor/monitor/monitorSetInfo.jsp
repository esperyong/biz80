<!-- 机房-机房定义-监控设置 monitorSetInfo.jsp -->
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<%@ page import="com.opensymphony.xwork2.util.*"%>
<title>监控设置</title>
<link rel="stylesheet" href="${ctx}/css/validationEngine.jquery.css" type="text/css" media="screen" title="no title" charset="utf-8" />
<link rel="stylesheet" href="${ctx}/css/portal.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/common.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/master.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/public.css" type="text/css" />

<%
	ValueStack vs = (ValueStack)request.getAttribute("struts.valueStack");
	String saveFlag = "";
	if(null != vs && !"".equals(vs)){
		if(vs.findValue("saveFlag") != null && "true".equals(vs.findValue("saveFlag"))){
			saveFlag = (String)vs.findValue("saveFlag");
		}
	}
%>
</head>
<script>
if("<%=saveFlag%>" != null && "<%=saveFlag%>" != "") {
	window.location.href='${ctx}/roomDefine/IndexVisit.action';
	//window.monitorSetFunClk();
}
</script>
  <body>
	<page:applyDecorator name="tabPanel">  
       <page:param name="id">mytab</page:param>
       <page:param name="width">750</page:param>
       <page:param name="background">#fff</page:param>
       <page:param name="tabBarWidth">400</page:param>
       <page:param name="cls">tab-grounp</page:param>
       <page:param name="current">1</page:param> // 默认显示第几个
       <page:param name="tabHander">[{text:"常规信息",id:"tab1"},{text:"设施管理",id:"tab2"},{text:"状态定义",id:"tab3"},{text:"告警定义",id:"tab4"}]</page:param>
       <page:param name="content_1">
       
        <s:form id="formID" action="" name="MonitorSetVisitForm" method="post" namespace="/roomDefine" theme="simple">
   		<div>
	   		<ul class="fieldlist" >
		   		<li>
		   			<span  class="field">机房名称:</span>
		   			<input type="text" class="validate[required,length[0,30]]" name="roomName" id="roomName" size="40" value="<s:property value='roomName' />" />
		   			<span class="red">*</span>
		   		</li>
		   		<li>
		   			<span class="field">备注:</span>
		   			<textarea name="desc" id="textarea" cols="42" rows="2" class="validate[length[0,200]]"><s:property value='desc' /></textarea>
		   		</li>
		   		<li style="vertical-align:baseline;">
		   			<span class="field">所属域:</span>
		   			<s:select list="allDomains" cssClass="validate[required]" name="domain" value="%{domain}" id="domain" listKey="ID" listValue="name" />
		   		</li>
		   		<li>
		   			<span  class="field">机房管理员:</span>
		   			<input type="text" class="validate[length[0,30]]" name="administrator" id="administrator" size="40" value="<s:property value='administrator' />" />
		   		</li>
		   		<li>
					<span class="field">机房视频：</span>集成第三方视频系统
					<input type="radio" name="isVideo" value="true" id="yesID" <s:if test="isVideo=='true'">checked="checked"</s:if> />是
		   			<input type="radio" name="isVideo" value="false" id="noID" <s:if test="isVideo=='false'">checked="checked"</s:if> />否
		   		</li>
		   		<div id="videoId"></div>
		   		<li class="last" id="tableDivId">
						<span class="field">关联网络拓扑：</span><span  class="field-table">
                        <span class="field-table-tr-ico"><span class="r-ico r-ico-close" id="delId"></span>
                        <span class="r-ico r-ico-add" id="addId"></span>
                        </span>
                        <table class="grid-gray-fontwhite" id="NDtb">
						<thead>
							<tr>
								<th width="9%"><input type="checkbox" name="CAName" id="CAName" /></th>
								<th width="91%">关联网络拓扑</th>
							</tr>
						</thead>
						<tbody>
							<tr>
							<td><input type="checkbox" name="CBName" id="CBName"/></td>
							<td>
	 							<select name="network">
	 								<s:iterator id="map" value="allFocus" status="focus">  
           							 	<s:iterator value="allFocus[#focus.index]">   
               					 			<option value='<s:property value="key" />@<s:property value="value" />'><s:property value="value" /></option>
           							 	</s:iterator>  
           							 </s:iterator>
    							</select>
 							</td>
							</tr>
						</tbody>
						</table>
                        </span>
				</li>
		   	</ul>
		   	<ul class="panel-button">
				<li><span></span><a id="submit" onClick="">应用</a></li>
		    </ul>
   		</div>
   		<input type="hidden" name="roomId" id="roomId" value="<s:property value='roomId'/>">
   		<input type="hidden" name="ipAddressHid" id="ipAddressHid" value="<s:property value='ipAddress'/>">
   		<input type="hidden" name="portHid" id="portHid" value="<s:property value='port'/>">
   		<input type="hidden" name="networkHid" id="networkHid" value="<s:property value='network'/>">
   </s:form>
    
       </page:param>
       <page:param name="content_2">
       	<div class="clear" id="dynamicJsp2Id"></div>
       </page:param>
       <page:param name="content_3">
	   	<div class="clear" id="dynamicJsp3Id"></div>
	   </page:param>
       <page:param name="content_4">
       	<div class="clear" id="dynamicJsp4Id"></div>
       </page:param>
     </page:applyDecorator>
   	 <div id="videoModId" style="display:none">
   	 	<li>
   	 	<span class="field"></span>
   	 	<span class="field-table">
		<span class="field-table-tr-ico">
        <span class="r-ico r-ico-close" id="delDetailRow"></span>
        <span class="r-ico r-ico-add" id="addNewRow"></span>
        </span>
		<table id="tb" class="grid-gray-fontwhite">
		<thead>
			<tr>
				<th width="9%"><input type="checkbox" name="allCheck" id="allCheck" /></th>
				<th width="45%">视频服务器IP地址</th>
				<th width="46%">端口</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td><input type="checkbox" name="CK" id="CK"/></td>
				<td><input type="text" id="ipAddress" name="ipAddress" class="validate[required,ipAddress]" /></td>
				<td><input type="text" id="port" name="port" class="validate[required,onlyNumber,funcCall[validatePort]]" /></td>
			</tr>
		</tbody>
		</table>
		</span>
		</li>		
	  </div> 
  
   
  </body> 


</html>
<script type="text/javascript">

$(function(){
	var tpmyfirst11 = new TabPanel({id:"mytab",
		listeners:{
			/*changeBefore:function(tab){
	        	alert(tab.index+"before");
	        	return true;
	        },*/
	        change:function(tab){
		        targetType = tab.id=="tab2"?"tab2"
		        		 :tab.id=="tab3"?"tab3"
		        		 :tab.id=="tab4"?"tab4":"tab4";
       		 if(tab.id=="tab1"){
				return;
           	 }
           	 var roomId = $("#roomId").val();
           	 	//alert("roomId11:"+roomId);
	        	//tpmyfirst11.loadContent(tab.index,{url:"${ctx}/roomDefine/ChangeTabPageVisit.action?targetType=" + targetType + "&roomId=" + roomId});
           	    ajaxChangeTabPageVisitFun(targetType,roomId);
	        }/*,
	        changeAfter:function(tab){
        		alert(tab.index);
			}*/
    	}}
		); 
});

function ajaxChangeTabPageVisitFun(targetType,roomId) {
	$.ajax({
		type: "post",
		dataType:'html', //接受数据格式 
		cache:false,
		data:"targetType=" + targetType + "&roomId=" + roomId, 
		url: "${ctx}/roomDefine/ChangeTabPageVisit.action",
		//url: "${ctx}/roomDefine/ResMetricVisit.action",
		beforeSend: function(XMLHttpRequest){
		//ShowLoading();
		},
		success: function(data, textStatus){
			//alert($("#treeTabPageId")[0]);
			if(targetType=="tab2"){
				$("#dynamicJsp2Id").find("*").unbind();
				$("#dynamicJsp2Id").html("");
				$("#dynamicJsp2Id").append(data);
			}else if(targetType=="tab3"){
				$("#dynamicJsp3Id").find("*").unbind();
				$("#dynamicJsp3Id").html("");
				$("#dynamicJsp3Id").append(data);	
			}else{
				$("#dynamicJsp4Id").find("*").unbind();
				$("#dynamicJsp4Id").html("");
				$("#dynamicJsp4Id").append(data);	
			}
			//alert(data);
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
	$("#formID").validationEngine({
		promptPosition:"centerRight", 
		validationEventTriggers:"keyup blur change",
		inlineValidation: true,
		scroll:false,
		success:false
	});

	function copyTR() {
		//复制一行
	    var tr = $("#tb tr").eq(1).clone();
	    //tr.find("td").get(0).innerHTML = ++i;
	    tr.show();
	    tr.appendTo("#tb");
	}
	function copyNDTR() {
		//复制一行
	    var tr = $("#NDtb tr").eq(1).clone();
	    //tr.find("td").get(0).innerHTML = ++i;
	    tr.show();
	    tr.appendTo("#NDtb");
	}
	function delFun(){
		//alert("delFun"+$("#NDtb tr:gt(1)"));
		$("#NDtb tr:gt(1)").each(function() {
	        if ($(this).find("#CBName").get(0).checked == true) {
	            $(this).remove();
	        }
	    });
	    $("#CAName").attr("checked", false);
	}
	//全选
	function allCheckFun() {
	    $("#NDtb tr:gt(1)").each(function() {
	        $(this).find("#CBName").get(0).checked = $("#CAName").get(0).checked;
	    });
	}
	 //隐藏模板tr
    $("#tb tr").eq(1).hide();
    //隐藏模板tr
    $("#NDtb tr").eq(1).hide();
    
    $("#addId").click(copyNDTR);
	$("#delId").click(delFun);
	$("#CAName").click(allCheckFun);
	//默认有一行
	copyNDTR();
	
	var nwVal = $("#networkHid").val();
	if(null != nwVal && (nwVal.length>0)){
		var nwArr = nwVal.split(",");
		for(var i=0;i<nwArr.length;i++){
			if(i==0){}else{
				copyNDTR();
			}
			setOptionVal(nwArr[i]);
		}
	}
	
	function setOptionVal(selname){
		var selObj = $("#tableDivId select[name='network']");
		var aa= $(selObj[i]).children("option");
		for (var k=0;k<aa.length;k++){
			//alert(aa[k].value +":" +selname);
			if(aa[k].value == $.trim(selname)){
				$(selObj[i+1]).val($.trim(selname));
				break;
			}
		}
	}
	var isVideo=false;
	//是否集成第三方视频
	$("input[name='isVideo']").click(function () {
		var aa = $("input[name='isVideo']:checked").val();
		if("false" == aa){
			$("#videoId").html("");
			$("#addNewRow").unbind();
			$("#delDetailRow").unbind();
			$("#allCheck").unbind();
			$("#videoId").hide("slow");
			isVideo=false;
		}else{
			if(!isVideo) {
				trueIsVideo();
				isVideo=true;
			}
		}
		//$("#videoId").show("slow");
	});

	function trueIsVideo(){
		$("#videoId").show("slow");
		$("#videoId").append($("#videoModId").html());
		//动态添加
		$("#addNewRow").click(copyTR);
		//动态删除
		$("#delDetailRow").click(function() {
		    $("#tb tr:gt(1)").each(function() {
		        if ($(this).find("#CK").get(0).checked == true) {
		            $(this).remove();
		        }
		    });
		    $("#allCheck").attr("checked", false);
		});
		//全选
		$("#allCheck").click(function() {
		    $("#tb tr:gt(1)").each(function() {
		        $(this).find("#CK").get(0).checked = $("#allCheck").get(0).checked;
		    });
		});
		//默认有一行
		copyTR();
	}

	var cheVal = $("input[name='isVideo']:checked").val();
	if("true" == cheVal){
		trueIsVideo();
		var ipstr = $("#ipAddressHid").val();
		var portstr = $("#portHid").val();
		var ipArr = ipstr.split(",");
		var portArr = portstr.split(",");
		for(var i=0; i<ipArr.length; i++){
			if(i==0){
			}else{
				copyTR();
			}
			setval(ipArr[i],portArr[i]);
		}
		
		//alert(ipArr);
		//trueIsVideo();
	}
	function setval(ip,port) {
		var ipObj = $("#videoId input[name='ipAddress']");
		
		var portObj = $("#videoId input[name='port']");
		$(ipObj[i+1]).val($.trim(ip));
		$(portObj[i+1]).val($.trim(port));
			
	}
});

$("#submit").click(function (){
	try{//提交时隐藏的模板不验证
	var ipObj = $("#videoId input[name='ipAddress']");
	ipObj[0].className="";
	}catch(e){
		//alert(e);
	}
		$("#formID").attr("action","${ctx}/roomDefine/MonitorSetVisit!updateInfo.action");
		$("#formID").submit();
});

function validatePort(){
	var portObj = $("#videoId input[name='port']");
	//alert("length:"+portObj.length);
	for(var i=1;i<portObj.length;i++) {
		var orgval = portObj[i].value;
		if(orgval !=null && orgval !=""){
			try{
				var portVal = parseInt(orgval);
				if(portVal!=orgval){
					//alert(portVal+"=="+orgval);
					return true;
				}
				if(isNaN(portVal)==true){
					return true;
				}
				if(portVal<0 || portVal>65535){
					return true;
				}
			}catch(e){
				return true;
			}
		}else{
			return true;
		}
	}
	return false;
}


</script>
