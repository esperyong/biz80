<!-- 机房-机房定义-单个添加设备  addDeviceInfo.jsp -->
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<%@ page import="com.opensymphony.xwork2.util.*"%>
<title>添加设备</title>
<link rel="stylesheet" href="${ctx}/css/validationEngine.jquery.css" 
	type="text/css" media="screen" title="no title" charset="utf-8" />

<link rel="stylesheet" href="${ctx}/css/common.css"
	type="text/css" />
<link rel="stylesheet" href="${ctx}/css/validationEngine.jquery.css"
	type="text/css" />
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css">
<link href="${ctx}/css/button-module.css" rel="stylesheet" type="text/css">
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="${ctx}/css/UIComponent.css" type="text/css" /> 
<script src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script src="${ctx}/js/jquery.validationEngine-cn.js" type="text/javascript"></script>
<script src="${ctx}/js/jquery.validationEngine.js" type="text/javascript"></script>
<script src="${ctx}/js/component/cfncc.js"></script>
<script src="${ctx}/js/component/panel/panel.js"></script>
<script src="${ctx}/js/component/toast/Toast.js"></script>
<script src="${ctx}/js/component/gridPanel/grid.js"></script>
<script src="${ctx}/js/component/gridPanel/indexgrid.js"></script>
<script type="text/javascript" src="${ctx}/js/component/combobox/simplebox.js"></script>

<%
	ValueStack vs = (ValueStack)request.getAttribute("struts.valueStack");
	String saveFlag = "";
	if(null != vs && !"".equals(vs)){
		if(vs.findValue("saveFlag") != null && !"".equals(vs.findValue("saveFlag"))){
			saveFlag = (String)vs.findValue("saveFlag");
		}
	}
%>
<script>
if("<%=saveFlag%>" == "true") {
	var loadStr = window.opener.location.href;
	if(loadStr.indexOf("IndexVisit")>=0){
		window.opener.deviceManagerFunClk();
	}else if(loadStr.indexOf("ResourcePropertyVisit")>=0){
		window.opener.deviceManagerFunClk();
	}else{
		//var loadStr2 = window.opener.opener.location.href;
		if(loadStr.indexOf("ResourceProperty")>=0){
			window.opener.deviceManagerFunClk();
		}
	}
	
	window.close();
}
</script>
</head>

<body>
<page:applyDecorator name="popwindow"  title="添加">
	
	<page:param name="width">500px;</page:param>
	<page:param name="topBtn_index_1">1</page:param>
	<page:param name="topBtn_id_1">closeId</page:param>
	<page:param name="topBtn_css_1">win-ico win-close</page:param>
	
	<page:param name="bottomBtn_index_1">1</page:param>
	<page:param name="bottomBtn_id_1">submit</page:param>
	<page:param name="bottomBtn_text_1">确定</page:param>
	
	<page:param name="bottomBtn_index_2">2</page:param>
	<page:param name="bottomBtn_id_2">cancel</page:param>
	<page:param name="bottomBtn_text_2">取消</page:param>
	
	<page:param name="content">
<!--		<s:form id="formID" action="AddDeviceInfo" name="AddDeviceInfoForm" method="post" namespace="/roomDefine">-->
		<form id="formID" action="${ctx}/roomDefine/AddDeviceInfo.action" name="AddDeviceInfoForm" method="post" >
	<div style="display:none"><span class="ico ico-note"></span><span>说明：添加机房设备，可添加新设备或从系统中选择已有设备。</span></div>
	<div>
	   		<ul class="fieldlist-n">
	   			<li>
	   				<input type="radio"  name="chooseDis" value="hasDevice" checked="checked" style="width:20px;"  />选择已有设备
		   			<input type="radio"  name="chooseDis" value="newDevice"  style="width:20px;"  />新增设备
		   		</li>
		   		<li>
		   			<span  class="field">设备名称</span>
		   			<span>：<input type="text" class="validate[required,noSpecialStr,length[0,30]]" name="deviceName" id="deviceName" size="40"/></span>
		   			<span class="black-btn-l" id="selectImg" style="width:100px"><span class="btn-r"><span class="btn-m"><a>选择设备</a></span></span></span>
		   			<!-- <img src="${ctx}/images/ico/sousuo.gif" width="18" height="18" id="selectImg" style="display:none;cursor: pointer;"/> -->
		   			<span class="txt-red" style="position:relative;top:2px">*</span>
		   		</li>
		   		<li>
		   			<span  class="field">IP地址</span>
		   			<span>：<input type="text" name="ipAddress" id="ipAddress" size="40" /></span>
		   			<span class="txt-red" style="position:relative;top:2px;left:3px;display:none">*</span>
		   		</li>
		   		<li>
		   			<span  class="field">MAC地址</span>
		   			<span>：<input type="text" class="validate[length[0,30]]" name="macAddress" id="macAddress" size="40"/></span>
		   		</li>
		   		<li>
		   			<span  class="field">设备类型</span>
		   			<!--  
		   			<span>：<SELECT id="chooseDev" name="chooseDev" class="validate[required]">
		   				<option value="" >请选择设备类型</option>
		   				<s:iterator value="capacityMap" id="map">
		   					<option value="<s:property value="#map.key" />" ><s:property value="#map.value" /></option>
		   				</s:iterator>
		   			</SELECT></span>
		   			<span class="txt-red" style="position:relative;top:4px">*</span>
		   			<span>
		   			-->
		   			<span>：<s:select id="level2Type1" name="level2Type1" class="validate[required]"  list="level2Type" listKey="resourceCategoryGroupId" listValue="resourceGroupName" style="position:relative;left:-5px">
					</s:select>
					<select id="lowerLayers1" name="lowerLayers1" style="width:100px">
					</select>
					</span>
					<span class="txt-red" style="position:relative;top:3px">*</span>
		   			</span>
		   		</li>
		   		<li style="vertical-align:baseline;">
		   			<span class="field" title="所属<s:property value='domainPageName' />">所属<s:property value='domainPageName' /></span>
		   			<span>：<s:select list="allDomains" cssClass="validate[required]" name="field1" id="field1" listKey="ID" listValue="name" style="position:relative;left:3px;width:220px" /></span>
		   			<span class="txt-red" style="line-height:20px;position:relative;top:2px">*</span>
		   		</li>
		   		<s:if test="jiguiNo==''">
		   		<li>
		   			<span  class="field">机柜号</span>
		   			<span>：<input type="text" class="validate[noSpecialStr2,length[0,30]]" name="cabinetNo" id="cabinetNo" size="40"/></span>
		   		</li>
		   		</s:if>
		   		<s:else>
		   		
		   			<li><span class="field" size="40">机柜号</span>
		   				<span>：<s:property value='jiguiNo' /></span>
		   			</li>
					<input type="hidden" name="cabinetNo" id="cabinetNo" value="<s:property value='jiguiNo' />"/>
		   		</s:else>
		   		
		   		<li>
		   			<span  class="field">机框号</span>
		   			<span>：<input type="text" class="validate[noSpecialStr2,length[0,30]]" name="frameNo" id="frameNo" size="40"/></span>
		   		</li>
		   		
		   		<li>
		   			<span  class="field">设备号</span>
		   			<span>：<input type="text" class="validate[noSpecialStr2,length[0,30]]" name="deviceNo" id="deviceNo" size="40"/></span>
		   		</li>
		   		<li>
		   			<span class="field">备注</span>
		   			<span>：<textarea name="notes" id="notes" cols="42" rows="2" class="validate[length[0,200]]"></textarea></span>
		   		</li>
		   	</ul>
		   	<div style="display:none"><span class="ico ico-note"></span><span>1.IP地址格式为：IP/掩码，例如：192.168.12.3/255.255.255.0。</span>
		   		<br/>
		   		<span style="position:relative;left:31px">若不输入掩码默认为255.255.255.0</span>
		   		<br/>
		   		<span style="position:relative;left:23px">2.多个IP或MAC地址";"分割</span>
		   	</div>
   		</div>	
<!--   		<s:submit name="提交"></s:submit>-->
<!--   		<s:reset name="取消"></s:reset>-->
		<input type="hidden" name="roomId" id="roomId" value="<s:property value='roomId' />" />
		<input type="hidden" name="jiguiNo" id="roomId" value="<s:property value='jiguiNo' />" />
		<input type="hidden" name="resourceId" id="resourceId" value="" />
		<input type="hidden" name="level2Type" id="level2Type" value="<s:property value='level2Type'/>" />
		<input type="hidden" name="lowerLayers" id="lowerLayers" value="<s:property value='lowerLayers'/>" />
		<input type="hidden" name="field" id="field" value="<s:property value='field'/>" />
		
		<input type="hidden" name="defaultLevel2Type" id="defaultLevel2Type" value="<s:property value='level2Type'/>"/>
		<input type="hidden" name="defaultField" id="defaultField" value="<s:property value='field'/>"/>
<!--   		</s:form>-->
   		</form>
	</page:param>
</page:applyDecorator>
	
</body>


</html>
<script type="text/javascript">
var panel;
var layerResource=null;
$(document).ready(function() {

	$("#formID").validationEngine({
		promptPosition:"centerRight", 
		validationEventTriggers:"keyup blur change",
		inlineValidation: true,
		scroll:false,
		success:false
	});

	$.ajax({
		  url:"${ctx}/roomDefine/AddDeviceInfoVisit!getLayerDevice.action",
          dataType:"json",
		  success: function(data,textStatus){
			layerResource = data;
			var layerType='<property value="lowerLayers"/>';
			if(layerType != null){
				$("#level2Type").val(layerType);
				$("#level2Type1").val(layerType);
			}
			
			setTypeSelect();
			//SimpleBox.renderAll();
			setDisable();
		  }
	});
	
	//SimpleBox.renderAll();

	// 默认选择已有设备
	$("#selectImg").show();
	$("#ipAddress").attr("readonly","true");
	$("#deviceName").attr("readonly","true");
	//$("#chooseDev").attr('disabled','disabled');
	$("#macAddress").attr("readonly","true");
	
	//SimpleBox.instanceContent["chooseDev"].disable();	
	$("#ipAddress").css({ "background-color": "#c0c0c0"});
	$("#deviceName").css({ "background-color": "#c0c0c0"});
	//$("#chooseDev").css({ "background-color": "#c0c0c0"});
	$("#macAddress").css({ "background-color": "#c0c0c0"});
	$("#level2Type1").css({ "background-color": "#c0c0c0"});
	$("#lowerLayers1").css({ "background-color": "#c0c0c0"});
	$("#field1").css({ "background-color": "#c0c0c0","color":"#000000"});
	//setDisable();
});

function setDisable(){
	var radioVal = $('input[name=chooseDis][checked]').val(); 
	if(radioVal != null && radioVal == "hasDevice") {

		$("#level2Type1").attr('disabled','disabled');
		$("#lowerLayers1").attr('disabled','disabled');
		$("#field1").attr('disabled','disabled');

		$("#level2Type1").css({ "background-color": "#c0c0c0"});
		$("#lowerLayers1").css({ "background-color": "#c0c0c0"});
		$("#field1").css({ "background-color": "#c0c0c0"});

		$("#level2Type1").css({ "disabledColor": "#000000"});
		$("#lowerLayers1").css({ "disabledColor": "#000000"});
		$("#field1").css({ "disabledColor": "#000000"});
		
		//SimpleBox.instanceContent["level2Type1"].disable();
		//SimpleBox.instanceContent["lowerLayers1"].disable();
		//SimpleBox.instanceContent["field1"].disable();
	}else{
		$("#level2Type1").attr('disabled','');
		$("#lowerLayers1").attr('disabled','');
		$("#field1").attr('disabled','');

		$("#level2Type1").css({ "background-color": "#FFFFFF"});
		$("#lowerLayers1").css({ "background-color": "#FFFFFF"});
		$("#field1").css({ "background-color": "#FFFFFF"});
		
		
		
		//SimpleBox.instanceContent["level2Type1"].enable();
		//SimpleBox.instanceContent["lowerLayers1"].enable();
		//SimpleBox.instanceContent["field1"].enable();
	}
	
}

function setTypeSelect(){
	if (layerResource!=null){
		var $theOption="";
		var isNo=1;
		for (var i=0;i<layerResource.length;i++){
			
			if (layerResource[i].parentID == $("#level2Type1").val()){
				$theOption+='<option value="'+layerResource[i].resourceID+'" >'+layerResource[i].resourceName+'</option>';
			}
			if (layerResource[i].resourceID == $("#level2Type1").val()){
				isNo = 0;	
			}
		}
		
		$("#lowerLayers1").html("");
		$("#lowerLayers1").append($theOption);

		$("#lowerLayers").val($("#lowerLayers1").val());
		
		if (isNo == 0){
			$("#lowerLayers1").hide();
		}else{
			$("#lowerLayers1").show();
		}
		//setDisable();
		
	}
}


$("#level2Type1").change(function(){
	setTypeSelect();
});
$("#lowerLayers1").change(function(){
	$("#lowerLayers").val($("#lowerLayers1").val());
});
$("#field1").change(function(){
	$("#field").val($("#field1").val());
})

$("#selectImg").click(function (){
	var widthVal = document.body.clientWidth/2;
	var heightVal = 100;
	var roomId = $("#roomId").val();
	var jiguiNo = $("#jiguiNo").val();
	
	if(panel){panel.close("close");}
	
	 window.open("${ctx}/roomDefine/BatchAddDeviceNewInfoVisit!getDeviceList.action?roomId="+roomId+"&jiguiNo="+jiguiNo,"blank","height=490,width=505");
	/*
	panel = new winPanel({
		    title:"设备列表",
	        url:"${ctx}/roomDefine/AddDeviceInfoVisit!getSelDeviceList.action",
	        //html:"alskdflaksdflkasdklj",
	        width:458, 
	        height:289,
	        x:widthVal,
		    y:heightVal,
            //cls:"pop-div",
	        isDrag:true,
	        tools:[{
              text:"确定",
            click:function(){
                var radioVal = $("input[name=radioName]:checked").val();
                if(null == radioVal || "" ==radioVal){
					return;
		        }
                var radioArr = radioVal.split(",");
                try{
                	if( null != radioArr && (radioArr.length>0)){
                		//var resourceid = radioArr[0];
	                	$("#resourceId").val(radioArr[0]);
	                	$("#ipAddress").val(radioArr[1]);
	                	$("#deviceName").val(radioArr[2]);
	                	//$("#macAddress").val(radioArr[3]);
	                	var opts = $("#chooseDev option");
	                	for(var i=0,len = opts.length;i<len;i++){
	                		$optVal = $(opts[i]);
							if(radioArr[4]==$optVal.html()){
								$('#chooseDev').val($optVal.val());
							}
		                }
		                if($("#cabinetNo").val()=='' || $("#cabinetNo").val()==null){
	                		$("#cabinetNo").val(radioArr[5]);
		                }
	                	$("#frameNo").val(radioArr[6]);
	                	$("#deviceNo").val(radioArr[7]);
	                	$("#notes").val(radioArr[8]);
	                	panel.close("close");
			        }
	            }catch(e){
					alert("属性异常");
			    }
                
               
               // alert(radioVal);
              //panel.close("close");
            }},{
              text:"取消",
            click:function(){
                panel.close("close");
              }
            }],
	        listeners:{
	          closeAfter:function(){
		          //alert("afterClose");
		          panel = null;
		      },
		      loadAfter:function(){
		          //alert("loadAfter");
		      }
	        }
	},{winpanel_DomStruFn:"pop_winpanel_DomStruFn"});
	*/
});
//取redio判断展现查询图片
$(function() {
    $("input[name='chooseDis']").click(function() {
    	var radioVal = $('input[name=chooseDis][checked]').val(); 
    	if(radioVal != null && radioVal == "hasDevice") {
			$("#selectImg").show();
			$("#ipAddress").attr("readonly","true");
			$("#deviceName").attr("readonly","true");
			$("#macAddress").attr("readonly","true");
			//$("#chooseDev").attr('disabled','disabled');

			$("#ipAddress").css({ "background-color": "#c0c0c0"});
			$("#deviceName").css({ "background-color": "#c0c0c0"});
			$("#chooseDev").css({ "background-color": "#c0c0c0"});
			$("#macAddress").css({ "background-color": "#c0c0c0"});
			$("#level2Type1").css({ "background-color": "#c0c0c0"});
			$("#lowerLayers1").css({ "background-color": "#c0c0c0"});
			$("#field1").css({ "background-color": "#c0c0c0"});
			

        }else {
        	$("#selectImg").hide();
        	$("#ipAddress").removeAttr("readonly","true");
        	$("#deviceName").removeAttr("readonly","true");
        	$("#macAddress").removeAttr("readonly","true");
        	//$("#chooseDev").attr('disabled','');
			
        	$("#ipAddress").css({ "background-color": "#FFFFFF"});
			$("#deviceName").css({ "background-color": "#FFFFFF"});
			$("#chooseDev").css({ "background-color": "#FFFFFF"});
			$("#macAddress").css({ "background-color": "#FFFFFF"});
			$("#level2Type1").css({ "background-color": "#FFFFFF"});
			$("#lowerLayers1").css({ "background-color": "#FFFFFF"});
			$("#field1").css({ "background-color": "#FFFFFF"});
			
			$("#ipAddress").val("");			
        	$("#deviceName").val("");
        	$("#macAddress").val("");        	
        	$("#level2Type1").val($("#defaultLevel2Type").val());
        	$("#field1").val($("#defaultField").val());
        }
    	setDisable();
    });
});

$("#closeId").click(function (){
	window.close();
})

$("#submit").click(function (){
	var radioVal = $('input[name=chooseDis][checked]').val(); 
	if(radioVal != null && radioVal == "hasDevice") {
		if($("#deviceName").val()==''){
			alert("请选择设备");
			return;
		}
	}
	$("#formID").submit();
})
$("#cancel").click(function(){
	window.close();
})

function setDevInfo(radioVal){
	if(null == radioVal || "" ==radioVal){
		return;
    }
    var radioArr = radioVal.split(";");
    try{
    	if( null != radioArr && (radioArr.length>0)){
        	$("#resourceId").val(radioArr[0]);
        	$("#ipAddress").val(radioArr[1].split(",")[0]);
        	
        	$("#deviceName").val(radioArr[2]);
        	$("#macAddress").val(radioArr[3]);
        	
			$("#field1").val(radioArr[radioArr.length-1]);
			$("#field").val(radioArr[radioArr.length-1]);
        	var deviceType="";
        	for (var i=0;i<layerResource.length;i++){
        		if (layerResource[i].resourceName == radioArr[4]){
        			$("#level2Type1").val(layerResource[i].parentID);
        			$("#level2Type").val(layerResource[i].parentID);
        			deviceType = layerResource[i].resourceID;
            	}
            }
        	setTypeSelect();
        	$("#lowerLayers").val(deviceType);
        	$("#lowerLayers1").val(deviceType);
            /*
        	var opts = $("#chooseDev option");
        	for(var i=0,len = opts.length;i<len;i++){
        		$optVal = $(opts[i]);
				if(radioArr[4]==$optVal.html()){
					$('#chooseDev').val($optVal.val());
				}
            }
            */
            if($("#cabinetNo").val()=='' || $("#cabinetNo").val()==null){
        		$("#cabinetNo").val(radioArr[5]);
            }
        	$("#frameNo").val(radioArr[6]);
        	$("#deviceNo").val(radioArr[7]);
        	$("#notes").val(radioArr[8]);
        }
    }catch(e){
		alert("属性异常");
    }
}

</script>