<!-- 机房-机房巡检-巡检表startPollingInfo.jsp -->
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<%@ page import="com.opensymphony.xwork2.util.*"%>
<title>巡检表</title>
<link rel="stylesheet" href="${ctx}/css/validationEngine.jquery.css" type="text/css" media="screen" title="no title" charset="utf-8" />
<link rel="stylesheet" href="${ctx}/css/common.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/public.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/UIComponent.css" type="text/css" /> 

<script src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script src="${ctx}/js/component/cfncc.js"></script>
<script src="${ctx}/js/component/panel/panel.js"></script>
<script src="${ctx}/js/component/toast/Toast.js"></script>
<script type="text/javascript" src="${ctx}/js/component/comm/winopen.js"></script>
<script type="text/javascript" src="${ctx}/js/room/modalDialogWin.js"></script>
<script language="javascript" type="text/javascript" src="${ctx}/js/component/date/WdatePicker.js" ></script>

<script src="${ctx}/js/jquery.validationEngine-cn.js" type="text/javascript"></script>
<script src="${ctx}/js/jquery.validationEngine.js" type="text/javascript"></script>

<script type="text/javascript">
var toast;
if("<s:property value='saveFlag' />" != null && "<s:property value='saveFlag' />" == "true") {
		parent.window.toast.addMessage("操作成功");
		setTimeout(function(){
			//parent.window.returnValue='true';
			//parent.window.opener.location.href=parent.window.opener.location;
			parent.window.opener.roomClkPollingTabFun();
			parent.window.close();
			},1000);
}else if("<s:property value='saveFlag' />" == "false") {
	try{
		parent.window.toast.addMessage("操作失败");
		parent.window.close();
	}catch(e){
		alert(e);
	}
}

$(document).ready(function() {
	var $pollingTime = $("input[name='pollingTime']");
	$pollingTime.click(function(){
			WdatePicker({startDate:getDate(),dateFmt:'yyyy/MM/dd HH:mm:ss'});
	});
});
function getDate(){
	var now = new Date();
	var year = now.getFullYear();
	var month=now.getMonth()+1;
	var day=now.getDate();
    var hour=now.getHours();
    var minute=now.getMinutes();
    var second=now.getSeconds();
    //var nowdate=year+"-"+month+"-"+day+" "+hour+":"+minute+":"+second;
    var nowdate=year+"-"+month+"-"+day;
    return nowdate;
}
</script>
</head>
<body>
<page:applyDecorator name="popwindow"  title="巡检表">
	
<page:param name="width">800px;</page:param>
<page:param name="topBtn_index_1">1</page:param>
<page:param name="topBtn_id_1">closeId</page:param>
<page:param name="topBtn_css_1">win-ico win-close</page:param>

<page:param name="bottomBtn_index_1">2</page:param>
<page:param name="bottomBtn_id_1">submit</page:param>
<page:param name="bottomBtn_text_1">提交</page:param>

<page:param name="bottomBtn_index_2">3</page:param>
<page:param name="bottomBtn_id_2">save</page:param>
<page:param name="bottomBtn_text_2">保存</page:param>

<page:param name="bottomBtn_index_3">4</page:param>
<page:param name="bottomBtn_id_3">cancel</page:param>
<page:param name="bottomBtn_text_3">取消</page:param>

<page:param name="content">
<form id="startPollingformID" action="" name="startPollingForm" method="post" >
<div class="margin3 h2" style="background:#fff;border-bottom: #eaeaea 1px solid" ><span class="ico ico-tips"></span><span>说明：填写巡检表之后，提交此表才能用于统计数据。</span></div>

<div class="margin3 h2" style="background:#fff">
  <span class="vertical-middle bold">巡检表名称:</span><span class="vertical-middle">
  <input name="pollingTableName" id="pollingTableName" type="text" value="<s:property value='pollingTableName' />" class="validate[required,noSpecialStr]" />
  </span><span class="red">*</span>
  <!-- <span class="black-btn-l" style="margin-left: 60%;"><span class="btn-r"><span class="btn-m"><a>导出</a></span></span></span> -->
</div>
<div class="fold-blue" id="pollingContentId">
  <div class="fold-h1 bold">巡检内容</div>
  <div class="margin5 h2" style="background:#fff"><ul><li class="for-inline"><span class="vertical-middle bold">巡检时间:</span><span class="vertical-middle">
  <input name="pollingTime" id="pollingTime" type="text" value="" readonly="readonly" class="validate[required]"/>
  </span><span class="red">*</span></li><li class="suojin1em"><span class="vertical-middle bold">巡检人:</span><span class="vertical-middle">
  <input name="pollingPeople" id="pollingPeople" type="text" value="" class="validate[required]" value="<s:property value='currentUser'/>" />
  </span><span class="red">*</span></li><li class="suojin1em"><span class="vertical-middle bold">巡检机房:</span><span class="vertical-middle">
  <s:property value='pollingRoomName' />
  </span></li></ul></div>
  <input type="hidden" name=pollingRoomName value="<s:property value='pollingRoomName' />" /> 
  <s:set name="checkMap" value="newCheck" />
  <s:iterator value="#checkMap" id="map" status="u">
  
  
  <input type="hidden" name="checkList[<s:property value='#u.index'/>].id" value="<s:property value='#map.value.id' />"/>
  <input type="hidden" name="checkList[<s:property value='#u.index'/>].name" value="<s:property value='#map.value.name' />"/>
  <input type="hidden" name="checkList[<s:property value='#u.index'/>].desc" value="<s:property value='#map.value.desc' />"/>  
    
    
    <div class="fold-top"><span class="fold-top-title" id="<s:property value='#map.value.id' />" ><s:property value='#u.index+1' /> : <s:property value='#map.value.name' /></span></div>
	<table class="tablenoboder table-width100">
              <tr>
                <th style="width: 5%"></th>
                <th style="width: 15%">检查项</th>
                <th style="width: 30%">描述</th>
                <th style="width: 30%">情况概要</th>
                <th style="width: 20%">结论</th>
              </tr>
              <s:set name="itemMap" value='#map.value.item' />
              <s:iterator value="#itemMap" id="itemMap" status="offset" >
              <tr>
               <td class="underline"><span <s:if test="#itemMap.value.childItem !=null && #itemMap.value.childItem.size()>0" >class="ico ico-plus"</s:if> btn="itemBtn" id="<s:property value='#itemMap.value.id' />" ></span></td>
                <td class="underline"><s:property value='#itemMap.value.name' /></td>
                <td class="underline"><s:property value='#itemMap.value.desc' /></td>
                <td class="underline"><input type="text" name="checkList[<s:property value='#u.index'/>].item[<s:property value='#offset.index'/>].conditionDesc" value="<s:property value='#itemMap.value.conditionDesc' />"/></td>
                <td class="underline">
                <s:if test="#itemMap.value.conclusion!=null">
	                <s:if test="#itemMap.value.conclusion!='true'">
		                <input type="radio" name="checkList[<s:property value='#u.index'/>].item[<s:property value='#offset.index'/>].conclusion" btn="radioBtn"  value="true"/>正常
		                <input type="radio" name="checkList[<s:property value='#u.index'/>].item[<s:property value='#offset.index'/>].conclusion" btn="radioBtn" checked="checked" value="false"/>异常
	                </s:if>
	                <s:else>
		                <input type="radio" name="checkList[<s:property value='#u.index'/>].item[<s:property value='#offset.index'/>].conclusion" btn="radioBtn" checked="checked" value="true"/>正常
		                <input type="radio" name="checkList[<s:property value='#u.index'/>].item[<s:property value='#offset.index'/>].conclusion" btn="radioBtn" value="false"/>异常
	                </s:else>
                </s:if>
                <s:else>
                	<input type="radio" name="checkList[<s:property value='#u.index'/>].item[<s:property value='#offset.index'/>].conclusion" btn="radioBtn" checked="checked" value="true"/>正常
	                <input type="radio" name="checkList[<s:property value='#u.index'/>].item[<s:property value='#offset.index'/>].conclusion" btn="radioBtn" value="false"/>异常
                </s:else>
                <!-- 
                <input type="radio" name="checkList[<s:property value='#u.index'/>].item[<s:property value='#offset.index'/>].conclusion" btn="radioBtn" checked="checked" value="true"/>正常
                <input type="radio" name="checkList[<s:property value='#u.index'/>].item[<s:property value='#offset.index'/>].conclusion" btn="radioBtn" value="false"/>异常
                 --> 
                <input type ="hidden" name="itemHidden" btn="<s:property value='#itemMap.value.id' />" value="true" />
                <input type ="hidden" name="itemResourceIdHidden" value="<s:property value='#itemMap.value.id' />" />
                
                <input type="hidden" name="checkList[<s:property value='#u.index'/>].item[<s:property value='#offset.index'/>].id" value="<s:property value='#itemMap.value.id' />"/>
                <input type="hidden" name="checkList[<s:property value='#u.index'/>].item[<s:property value='#offset.index'/>].desc" value="<s:property value='#itemMap.value.desc' />"/>
                <input type="hidden" name="checkList[<s:property value='#u.index'/>].item[<s:property value='#offset.index'/>].name" value="<s:property value='#itemMap.value.name' />"/>
                </td>
              </tr>
              <s:if test="#itemMap.value.childItem !=null && #itemMap.value.childItem.size()>0" >
              	<tr style="display:none" id="<s:property value='#itemMap.value.id' />_next" >
                <td colspan="5"><div class="padding8">
			    <table class="tableboder table-width100">
			      <thead>
			        <tr>
			          <th style="width: 25%">子检查项</th>
			          <th style="width: 25%">描述</th>
			          <th style="width: 25%">情况摘要</th>
			          <th style="width: 25%">结论</th>
			        </tr>
			      </thead>
			      <tbody>
			      <s:iterator value="#itemMap.value.childItem" id="childItemMap" status="offset2" >
			      	
              
			      
			        <tr <s:if test="#offset.odd==true">class="tr-grey"</s:if>>
			          <td><s:property value='#childItemMap.value.name' /></td>
			          <td><s:property value='#childItemMap.value.desc' /></td>
			          <td><input type="text" name="checkList[<s:property value='#u.index'/>].item[<s:property value='#offset.index'/>].childItem[<s:property value='#offset2.index'/>].conditionDesc"  value="<s:property value='#childItemMap.value.conditionDesc' />" /></td>
			          <td>
			          <input type="radio" name="checkList[<s:property value='#u.index'/>].item[<s:property value='#offset.index'/>].childItem[<s:property value='#offset2.index'/>].conclusion" btn="radioBtn" checked="checked" value="true"/>正常
                	  <input type="radio" name="checkList[<s:property value='#u.index'/>].item[<s:property value='#offset.index'/>].childItem[<s:property value='#offset2.index'/>].conclusion" btn="radioBtn" value="false"/>异常 
                	  <input type ="hidden" name="childItemHidden" btn="<s:property value='#childItemMap.value.id' />" value="true" />
                	  <input type ="hidden" name="childItemResourceIdHidden" value="<s:property value='#childItemMap.value.id' />" />
			          </td>
			          
			          <input type="hidden" name="checkList[<s:property value='#u.index'/>].item[<s:property value='#offset.index'/>].childItem[<s:property value='#offset2.index'/>].id" value="<s:property value='#childItemMap.value.id' />"/>
			          <input type="hidden" name="checkList[<s:property value='#u.index'/>].item[<s:property value='#offset.index'/>].childItem[<s:property value='#offset2.index'/>].name" value="<s:property value='#childItemMap.value.name' />"/>
			          <input type="hidden" name="checkList[<s:property value='#u.index'/>].item[<s:property value='#offset.index'/>].childItem[<s:property value='#offset2.index'/>].desc" value="<s:property value='#childItemMap.value.desc' />"/>
			          
			          
			        </tr>
			        </s:iterator>
			      </tbody>
			    </table>
  				</div></td>
              	</tr>
              </s:if>
              </s:iterator>
              
  </table>
  
</s:iterator>
  <table class="tablenoboder table-width100">
  <div class="fold-top"><span class="fold-top-title" id="" >结论</span></div>
  <s:textarea cols="152" rows="5" name="conclusionTextName" ></s:textarea>
  </table>
</div>

<input type="hidden" name="pollingIndexId" id="pollingIndexId" value="<s:property value='pollingIndexId' />" />
<input type="hidden" name="roomId" id="roomId" value="<s:property value='roomId' />" />
</form>
<iframe name="submitIframe" id="submitIframeId" frameborder="0" scrolling="no" height="0" width="0" src=""></iframe>
</page:param>
</page:applyDecorator>
</body>
</html>
<script type="text/javascript">
$("#closeId").click(function (){
	window.close();
})
$("#submit").click(function (){
	$("#startPollingformID").attr("action","${ctx}/roomDefine/StartPollingVisit!savePollingResult.action?stateFlag=1");
	$("#startPollingformID").attr("target","submitIframe");
	$("#startPollingformID").submit();
	//window.close();
})
$("#save").click(function (){
	$("#startPollingformID").attr("action","${ctx}/roomDefine/StartPollingVisit!savePollingResult.action?stateFlag=0");
	$("#startPollingformID").attr("target","submitIframe");
	$("#startPollingformID").submit();
	//window.close();
})
$("#cancel").click(function(){
	window.close();
})

/**
 * 折叠item级别的.
 */
function zhedieItem() {
	var modelDivId = $("#pollingContentId");
	var btns = modelDivId.find("span[btn='itemBtn']");
	for(var i=0,len=btns.length;i<len;i++){
		var $btn = $(btns[i]);
		if($btn.hasClass("ico-plus")){
			$btn.toggle(checkBtnOpen,checkBtnClose);
		}else{
			$btn.toggle(checkBtnClose,checkBtnOpen);
		}
	}
}
function checkBtnOpen(){
	var btn = $(this);
	$("#"+btn.attr("id")+"_next").show();
	btn.removeClass("ico-plus");
	btn.addClass("ico-minus");
}
function checkBtnClose(){
	var btn = $(this);
	$("#"+btn.attr("id")+"_next").hide();
	btn.removeClass("ico-minus");
	btn.addClass("ico-plus");
}
$(document).ready(function () {
	$("#startPollingformID").validationEngine();
	toast = new Toast({position:"CT"}); 
	var pollingContentId = $("#pollingContentId");
	var btns = pollingContentId.find("input[btn='radioBtn']");
	btns.click(function (event) {
		//alert($(this).val());
		//alert($(this).attr("name"));
		var nameVal = $(this).attr("name");
		if(null != nameVal && (nameVal.indexOf("radioName_") != -1)) {
			nameVal = nameVal.substring(nameVal.indexOf("_")+1,nameVal.length);
			var hidBtns = pollingContentId.find("input[btn='"+nameVal+"']");
			hidBtns[0].value=$(this).val();
		}
		
	});
	zhedieItem();
	getDefaultDateTime();
});

function getDefaultDateTime(){
	var currDate = new Date(); 
	var thisDataStr = ""
	thisDataStr = thisDataStr+currDate.getFullYear();

	if ((currDate.getMonth()+1)<10){
		thisDataStr = thisDataStr+"/0"+(currDate.getMonth()+1);
	} else{
		thisDataStr = thisDataStr+"/"+(currDate.getMonth()+1);
	}

	if (currDate.getDate() < 10){
		thisDataStr = thisDataStr+"/0"+currDate.getDate();
	}else{
		thisDataStr = thisDataStr+"/"+currDate.getDate();
	}

	if ((currDate.getHours()+1)<10){
		thisDataStr = thisDataStr+" 0"+(currDate.getHours());
	}else{
		thisDataStr = thisDataStr+" "+(currDate.getHours());
	}

	if ((currDate.getMinutes()+1)<10){
		thisDataStr = thisDataStr+":0"+(currDate.getMinutes()+1);
	}else{
		thisDataStr = thisDataStr+":"+(currDate.getMinutes()+1);
	}

	if ((currDate.getSeconds()+1)<10){
		thisDataStr = thisDataStr+":0"+(currDate.getSeconds()+1);
	}else{
		thisDataStr = thisDataStr+":"+(currDate.getSeconds()+1);
	}

	$("#pollingTime").val(thisDataStr);
	$("#pollingPeople").val("<s:property value='currentUser'/>");
	
		
}
</script>