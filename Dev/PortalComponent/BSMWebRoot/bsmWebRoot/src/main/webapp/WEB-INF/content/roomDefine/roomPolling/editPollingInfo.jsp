<!-- 机房-机房巡检-巡检表editPollingInfo.jsp -->
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>编辑巡检</title>
<link rel="stylesheet" href="${ctx}/css/validationEngine.jquery.css" 
	type="text/css" media="screen" title="no title" charset="utf-8" />
<link rel="stylesheet" href="${ctx}/css/public.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/UIComponent.css" type="text/css" /> 
<script src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script src="${ctx}/js/jquery.validationEngine-cn.js" type="text/javascript"></script>
<script src="${ctx}/js/jquery.validationEngine.js" type="text/javascript"></script>
<script src="${ctx}/js/component/cfncc.js"></script>
<script src="${ctx}/js/component/panel/panel.js"></script>
<script src="${ctx}/js/component/toast/Toast.js"></script>
<script type="text/javascript" src="${ctx}/js/component/comm/winopen.js"></script>
<script type="text/javascript" src="${ctx}/js/room/modalDialogWin.js"></script>
<script language="javascript" type="text/javascript" src="${ctx}/js/component/date/WdatePicker.js" ></script>
</head>
<script>
</script>
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
<div class="margin3 h2" style="background:#fff">
  <span class="vertical-middle bold">巡检表名称:</span><span class="vertical-middle">
  <input name="pollingTableName" id="pollingTableName" type="text" value="<s:property value='pollingTableName' />" />
  </span><span class="red">*</span>
  <span class="black-btn-l" style="margin-left: 60%;"><span class="btn-r"><span class="btn-m"><a id="exportId">导出</a></span></span></span> 
</div>
<div class="fold-blue" id="pollingContentId">
  <div class="fold-h1 bold">巡检内容</div>
  <div class="margin5 h2" style="background:#fff"><ul><li class="for-inline"><span class="vertical-middle bold">巡检时间:</span><span class="vertical-middle">
  <input name="pollingTime" id="pollingTime" type="text" value="<s:property value='pollingTime' />" readonly="readonly"/>
  </span><span class="red">*</span></li><li class="suojin1em"><span class="vertical-middle bold">巡检人:</span><span class="vertical-middle">
  <input name="pollingPeople" type="text" value="<s:property value='pollingPeople' />" />
  </span><span class="red">*</span></li><li class="suojin1em"><span class="vertical-middle bold">巡检机房:</span><span class="vertical-middle">
  <s:property value='pollingRoomName' />
  </span></li>
  </ul></div>
  <input type="hidden" name=pollingRoomName value="<s:property value='pollingRoomName' />" /> 
  <s:set name="checkMap" value="newCheck" />
  <s:iterator value="#checkMap" id="map" status="u">
  
  	  <input type="hidden" name="checkList[<s:property value='#u.index'/>].id" value="<s:property value='#map.value.id' />"/>
	  <input type="hidden" name="checkList[<s:property value='#u.index'/>].name" value="<s:property value='#map.value.name' />"/>
	  <input type="hidden" name="checkList[<s:property value='#u.index'/>].desc" value="<s:property value='#map.value.desc' />"/>  
  
    <div class="fold-top"><span class="fold-top-title" id="<s:property value='#map.value.id' />" ><s:property value='#u.index+1' /> : <s:property value='#map.value.name' /></span></div>
	<table class="tablenoboder table-width100">
              <tr>
                <th style="width:2%"></th>
                <th style="width:20%">检查项</th>
                <th style="width:30%">描述</th>
                <th style="width:30%">情况概要</th>
                <th style="width:18%">结论</th>
              </tr>
              <s:set name="itemMap" value='#map.value.item' />
              <s:iterator value="#itemMap" id="itemMap" status="offset" >
              <tr>
               <td class="underline"><span <s:if test="#itemMap.value.childItem !=null && #itemMap.value.childItem.size()>0" >class="ico ico-plus"</s:if> btn="itemBtn" id="<s:property value='#itemMap.value.id' />" ></span></td>
                <td class="underline"><s:property value='#itemMap.value.name' /></td>
               <td class="underline"><s:property value='#itemMap.value.desc' /></td>
                <td class="underline"><input type="text" name="checkList[<s:property value='#u.index'/>].item[<s:property value='#offset.index'/>].conditionDesc" value="<s:property value='#itemMap.value.conditionDesc' />"/></td>
                <td class="underline">
                <s:if test="#itemMap.value.conclusion=='true'">
                <input type="radio" name="checkList[<s:property value='#u.index'/>].item[<s:property value='#offset.index'/>].conclusion" btn="radioBtn" checked="checked" value="true"/>正常
                <input type="radio" name="checkList[<s:property value='#u.index'/>].item[<s:property value='#offset.index'/>].conclusion" btn="radioBtn" value="false"/>异常 
                </s:if>
                <s:else>
                <input type="radio" name="checkList[<s:property value='#u.index'/>].item[<s:property value='#offset.index'/>].conclusion" btn="radioBtn"  value="true"/>正常
                <input type="radio" name="checkList[<s:property value='#u.index'/>].item[<s:property value='#offset.index'/>].conclusion" btn="radioBtn" checked="checked" value="false"/>异常 
                </s:else>
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
			          <th style="width:20%">子检查项</th>
			          <th style="width:30%"> 描述</th>
			          <th style="width:30%">情况摘要</th>
			          <th style="width:20%">结论</th>
			        </tr>
			      </thead>
			      <tbody>
			      <s:iterator value="#itemMap.value.childItem" id="childItemMap" status="offset2" >
			        <tr <s:if test="#offset.odd==true">class="tr-grey"</s:if>>
			          <td><s:property value='#childItemMap.value.name' /></td>
			          <td><s:property value='#childItemMap.value.desc' /></td>
			          <!-- <td><input type="text" name="checkList[<s:property value='#u.index'/>].item[<s:property value='#offset.index'/>].childItem[<s:property value='#offset2.index'/>].childStateDesc" value="<s:property value='#childItemMap.value.conditionDesc' />"/></td> -->
			          <td><input type="text" name="checkList[<s:property value='#u.index'/>].item[<s:property value='#offset.index'/>].childItem[<s:property value='#offset2.index'/>].conditionDesc" value="<s:property value='#childItemMap.value.conditionDesc' />"/></td>
			          <td>
			          <s:if test="#childItemMap.value.conclusion=='true'">
              		  <input type="radio" name="checkList[<s:property value='#u.index'/>].item[<s:property value='#offset.index'/>].childItem[<s:property value='#offset2.index'/>].conclusion" btn="radioBtn" checked="checked" value="true"/>正常
             		  <input type="radio" name="checkList[<s:property value='#u.index'/>].item[<s:property value='#offset.index'/>].childItem[<s:property value='#offset2.index'/>].conclusion" btn="radioBtn" value="false"/>异常 
                	  </s:if>
                	  <s:else>
                	  <input type="radio" name="checkList[<s:property value='#u.index'/>].item[<s:property value='#offset.index'/>].childItem[<s:property value='#offset2.index'/>].conclusion" btn="radioBtn"  value="true"/>正常
                	  <input type="radio" name="checkList[<s:property value='#u.index'/>].item[<s:property value='#offset.index'/>].childItem[<s:property value='#offset2.index'/>].conclusion" btn="radioBtn" checked="checked" value="false"/>异常 
                	  </s:else>
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
<input type="hidden" name="id" id="id" value="<s:property value='id' />" />
</form>
<iframe name="submitIframe" id="submitIframeId" frameborder="0" scrolling="no" height="0" width="0" src=""></iframe>
</page:param>
</page:applyDecorator>
</body>
</html>
<script>
$("#closeId").click(function (){
	window.close();
})
$("#submit").click(function (){
	$("#startPollingformID").attr("action","${ctx}/roomDefine/StartPollingVisit!editPollingResult.action?pollingRecordId=${id}&stateFlag=1");
	$("#startPollingformID").attr("target","submitIframe");
	$("#startPollingformID").submit();
	//window.close();
})
$("#save").click(function (){
	$("#startPollingformID").attr("action","${ctx}/roomDefine/StartPollingVisit!editPollingResult.action?pollingRecordId=${id}&stateFlag=0");
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

$(document).ready(function () {
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

	var $pollingTime = $("input[name='pollingTime']");
	$pollingTime.click(function(){
			WdatePicker({startDate:getDate(),dateFmt:'yyyy/MM/dd HH:mm:ss'});
	});
	
	zhedieItem();
	if("0" == "${operateState}"){
		var inputs = document.getElementsByTagName("input");
		for(var i = 0; i < inputs.length;i++){
			inputs[i].disabled=true;
		}

		// dk add 所有的textarea不可编辑
		var textAreas = document.getElementsByTagName("textarea");
		for (var areas = 0;areas<textAreas.length;areas++){
			textAreas[areas].disabled = true;
		}
		
		$("#submit").hide();
		$("#save").hide();
		$("#cancel").hide();

		document.title = "查看巡检";
	}else{
		document.title = "编辑巡检";
	}
	
});

$('#exportId').click(function() {
	var id = $('#id').val();
	window.open("${ctx}/roomDefine/ExportPolling!exportPollingRecord.action?id="+id,"_blank","width=400,height=250");
});
</script>