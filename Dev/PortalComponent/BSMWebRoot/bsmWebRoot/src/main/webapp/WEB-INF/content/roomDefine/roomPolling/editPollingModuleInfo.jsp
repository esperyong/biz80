<!-- 机房-机房巡检-编辑模板 editPollingModuleInfo.jsp -->
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>编辑巡检模板</title>
<link rel="stylesheet" href="${ctx}/css/validationEngine.jquery.css" 
	type="text/css" media="screen" title="no title" charset="utf-8" />
<link rel="stylesheet" href="${ctx}/css/public.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/tongjifenxi.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/UIComponent.css" type="text/css" /> 
<script src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script src="${ctx}/js/jquery.validationEngine-cn.js" type="text/javascript"></script>
<script src="${ctx}/js/jquery.validationEngine.js" type="text/javascript"></script>
<script src="${ctx}/js/component/cfncc.js"></script>
<script src="${ctx}/js/component/panel/panel.js"></script>
<script src="${ctx}/js/component/toast/Toast.js"></script>
<script type="text/javascript" src="${ctx}/js/component/comm/winopen.js"></script>
<script type="text/javascript" src="${ctx}/js/room/modalDialogWin.js"></script>
<script type="text/javascript" src="${ctx}/js/component/popwindow/popwin.js" ></script>
</head>
<script>
var toast;
if("<s:property value='saveFlag' />" != null && "<s:property value='saveFlag' />" == "true") {
		parent.window.toast.addMessage("操作成功");
		setTimeout(function(){
			//parent.window.returnValue='true';
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

</script>
<body>
<page:applyDecorator name="popwindow"  title="编辑巡检模板">
	
<page:param name="width">800px;</page:param>
<page:param name="topBtn_index_1">1</page:param>
<page:param name="topBtn_id_1">closeId</page:param>
<page:param name="topBtn_css_1">win-ico win-close</page:param>

<page:param name="bottomBtn_index_1">1</page:param>
<page:param name="bottomBtn_id_1">previewPollingTable</page:param>
<page:param name="bottomBtn_text_1">预览巡检表</page:param>

<page:param name="bottomBtn_index_2">2</page:param>
<page:param name="bottomBtn_id_2">submit</page:param>
<page:param name="bottomBtn_text_2">确定</page:param>

<page:param name="bottomBtn_index_3">3</page:param>
<page:param name="bottomBtn_id_3">cancel</page:param>
<page:param name="bottomBtn_text_3">取消</page:param>



<page:param name="content">
<form id="editPollingModuleformID" action="" name="editPollingModuleForm" method="post" >
<div class="margin3"><span class="ico ico-tips"></span><span>说明：编辑机房的巡检内容，巡检机房时以此模板为准。</span></div>
<div class="margin5 h2">
<ul>
<li class="for-inline"><span class="vertical-middle bold">巡检模板名称:</span><span class="vertical-middle">
<input name="pollingModelName" type="text" value="<s:property value='roomPolling.modelName' />" />
</span><span class="red">*</span></li>
<li class="suojin1em"><span class="vertical-middle bold">巡检机房:</span><span class="vertical-middle">
<s:property value="roomName" />
</span></li>
</ul>
</div>
<div class="fold-blue" id="modelDivId">
  <div class="fold-h1 bold">模板内容</div>
  <div class="fold-top"><span class="fold-top-title">1. 常规信息：巡检时需要填写的常规检查项</span></div>
  <div class="padding8">
    <table class="tableboder table-width100">
      <thead>
        <tr>
          <th width="50%">检查项</th>
          <th width="50%">描述</th>
          <th></th>
          <th></th>
        </tr>
      </thead>
      <tbody>
        <tr class="">
          <td>巡检时间</td>
          <td>巡检机房的时间，可修改，但不可超出当天范围。</td>
          <td></td>
          <td></td>
        </tr>
        <tr class="tr-grey">
          <td>巡检人</td>
          <td>巡检人</td>
          <td></td>
          <td></td>
        </tr>
        <tr class="">
          <td>巡检机房</td>
          <td>所巡检的机房</td>
          <td></td>
          <td></td>
        </tr>
      </tbody>
    </table>
  </div>
  <div class="fold-top">
  <span class="black-btn-l right" style="margin-top:-5px;"><span class="btn-r"><span class="btn-m" id="editPollingContentId"><a>编辑巡检内容</a></span></span></span>
  <span class="fold-top-title">2. 机房巡检内容：请选择并设置各个巡检内容中需要包含的检查项、要巡检的设备</span></div>
  <div class="padding8" id="pollingDivId">
    <table class="tableboder table-width100">
    <s:set name="checkMap" value="newCheck" />
    <s:iterator value="#checkMap" id="map">
        <tr>
        <th><span class="ico ico-minus" btn="btn" id="<s:property value='#map.value.id' />"></span> <span class=""><s:property value='#map.value.name' />：<s:property value='#map.value.desc' /></span></th>
      	</tr>
      	<tr id="<s:property value='#map.value.id' />_next">
        <td colspan="4" class="underline-gray02"><div class="padding8">
            <div class="margin3">
            <!--  <span class="black-btn-l right"><span class="btn-r"><span class="btn-m"><a>编辑公有子检查项</a></span></span></span>-->
            <span class="black-btn-l right"><span class="btn-r"><span class="btn-m" id="editItemId_<s:property value='#map.value.id' />" btn="editItemBtn" ><a>编辑检查项</a></span></span></span>
            </div>
            <table class="tableboder table-width100 table-grayborder">
              <tr>
                <th width="25%">检查项</th>
                <th width="25%">描述</th>
                <th width="25%">关联监控资源</th>
                <th width="25%">编辑子检查项</th>
              </tr>
              <s:set name="itemMap" value='#map.value.item' />
              <s:iterator value="#itemMap" id="itemMap" status="offset" >
			  <tr <s:if test="#offset.odd==true">class="tr-grey"</s:if> >
			    <td>
			    	<s:if test="#itemMap.value.childItem.size()>0"><span class="ico ico-plus" btn="childitembtn" id="<s:property value='#itemMap.value.id' />"></span></s:if>
			    	<s:property value='#itemMap.value.name' />
			    </td>
			    <td><s:if test="#itemMap.value.desc!=''"><s:property value='#itemMap.value.desc' /></s:if><s:else>-</s:else></td>
			    <td>
			    <span style="cursor: pointer" class="ico-16 ico-16-chosefloder" title="关联资源" btn="relaMonitorBtn" id="<s:property value='#map.value.id' />@@<s:property value='#itemMap.value.id' />"></span>
			    <s:if test="#itemMap.value.relaResource.length()>0">
			    	<span style="cursor: pointer" class="ico-16 ico-16-del-on" title="删除关联" btn="delRelaMonitorBtn" id="<s:property value='#map.value.id' />@@<s:property value='#itemMap.value.id' />"></span>
			    </s:if>
			    <s:else>
			    	<span class="ico-16 ico-16-del-down"></span>
			    </s:else>
			    </td>
			    <td><span class="ico ico-edit" id="editChildItemId_<s:property value='#map.value.id' />_<s:property value='#itemMap.value.id' />" btn="editChildItem"></span></td>
			  </tr>
			  <tr style="display:none" id="<s:property value='#itemMap.value.id' />_next">
                <td colspan="4">
                <div class="padding8">
			    <table class="tableboder table-width100">
			      <thead>
			        <tr>
			          <th width="33%">检查项</th>
			          <th width="33%">描述</th>
			          <th width="33%">关联监控指标</th>
			          <th width="1%">&nbsp;</th>
			        </tr>
			      </thead>
			      <tbody>
			      <s:iterator value="#itemMap.value.childItem" id="childItemMap" status="childoffset"  >
			        <tr <s:if test="#childoffset.odd==true">class="tr-grey"</s:if>>
			          <td><s:property value='#childItemMap.value.name' /></td>
			          <td><s:if test="#childItemMap.value.desc!=''"><s:property value='#childItemMap.value.desc' /></s:if><s:else>-</s:else></td>
			          <td>
				      <span style="cursor: pointer" class="ico-16 ico-16-chosefloder" title="关联指标" btn="relaMonitorMetricBtn" id="<s:property value='#map.value.id' />@@<s:property value='#itemMap.value.id' />@@<s:property value='#childItemMap.value.id' />"></span>
				        <s:if test="#childItemMap.value.relaMetric != '' && #childItemMap.value.relaMetric != null">
					    	<span style="cursor: pointer" class="ico-16 ico-16-del-on" title="删除关联" btn="delRelaMonitorMetricBtn" id="<s:property value='#map.value.id' />@@<s:property value='#itemMap.value.id' />@@<s:property value='#childItemMap.value.id' />"></span>
					    </s:if>
					    <s:else>
					    	<span class="ico-16 ico-16-del-down"></span>
					    </s:else>
				      </td>
			    	  <td><span value="<s:property value='#childItemMap.value.id' />"></span> </td>
			        </tr>
			      </s:iterator>  
			      </tbody>
			    </table>
			  </div>
			  </td>
               
              </tr>
			  </s:iterator>	 
            </table>
          </div></td>
      	</tr>
      </s:iterator>
      
    </table>
  </div>
</div>
<input type="hidden" name="pollingIndexId" id="pollingIndexId" value="<s:property value='pollingIndexId' />" />
<input type="hidden" name="roomId" id="roomId" value="<s:property value='roomId' />" />
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
$("#previewPollingTable").click(function (){
	$(this).bind("click",{
	src: "${ctx}/roomDefine/PreviewPollingTableVisit.action?pollingIndexId="+$("#pollingIndexId").val(),
	name:"PreviewPollingTableVisit",
	width:"820",
	height:"600"
	},openWindowFun);
})
$("#submit").click(function (){
	$("#editPollingModuleformID").attr("action","${ctx}/roomDefine/EditPollingModuleVisit!editPollingModuleName.action");
	$("#editPollingModuleformID").attr("target","submitIframe");
	$("#editPollingModuleformID").submit();
	//window.close();
})
$("#cancel").click(function(){
	window.close();
})

function openWindowFun(event){
	//alert("aa");
	var winOpenObj = {};
	var src = event.data.src;
	var name = event.data.name;
	var id = $(this).attr("id");
	if(null != id && typeof(id) != "undefined"){
		src=src+"&id="+id;
	}
	var height = event.data.height;
	if(height != null && height != ""){
		winOpenObj.height = height;
	}else{
		winOpenObj.height = '350';
	}
	var width = event.data.width;
	if(width != null && width != ""){
		winOpenObj.width = width;
	}else{
		winOpenObj.width = '600';
	}
	
	winOpenObj.name = name;
	winOpenObj.url = src;
	winOpenObj.scrollable = true;
	winOpen(winOpenObj);
}
/**
 * 折叠check级别的.
 */
function zhedieCheck() {
	var modelDivId = $("#modelDivId");
	var btns = modelDivId.find("span[btn='btn']");
	for(var i=0,len=btns.length;i<len;i++){
		var $btn = $(btns[i]);
		if($btn.hasClass("ico-plus")){
			$btn.toggle(checkBtnOpen,checkBtnClose);
		}else{
			$btn.toggle(checkBtnClose,checkBtnOpen);
		}
	}
}
/**
 * 折叠childItem级别的.
 */
function zhedieChildItem() {
	var modelDivId = $("#modelDivId");
	var btns = modelDivId.find("span[btn='childitembtn']");
	for(var i=0,len=btns.length;i<len;i++){
		var $btn = $(btns[i]);
		if($btn.hasClass("ico-plus")){
			$btn.toggle(checkBtnOpen,checkBtnClose);
		}else{
			$btn.toggle(checkBtnClose,checkBtnOpen);
		}
	}
}
/**
 * 关联监控资源.
 */
function relationMonitorResource() {
	var modelDivId = $("#modelDivId");
	var btns = modelDivId.find("span[btn='relaMonitorBtn']");
	for(var i=0,len=btns.length;i<len;i++){
		var $btn = $(btns[i]);
		$btn.bind("click",{
		src: "${ctx}/roomDefine/RelationMonitorResourceVisit.action?pollingIndexId="+$("#pollingIndexId").val()+"&roomId="+$("#roomId").val()+"&checkId="+$btn.attr("id"),
		name:"relationMonitorResourceVisit",
		height:"540"
		},openWindowFun);
	}
	
}
/**
 * 删除关联监控资源.
 */
function delRelationMonitorResource(){
	var modelDivId = $("#modelDivId");
	var btns = modelDivId.find("span[btn='delRelaMonitorBtn']");
	for(var i=0,len=btns.length;i<len;i++){
		var $btn = $(btns[i]);
		$btn.bind("click",function(td){
			var checkid = $(this).attr("id");
			var _confirm = new confirm_box({text:"此操作将取消检查项及子检查项的所有关联指标，是否执行此操作？"});
			_confirm.show();
			_confirm.setConfirm_listener(function(){
				
				$.ajax({
					url	:	"${ctx}/roomDefine/RelationMonitorResourceVisit!delRelationResource.action",
					data:	"pollingIndexId="+$("#pollingIndexId").val()+"&roomId="+$("#roomId").val()+"&checkId="+checkid,
					dataType : "html",
					cache	 : false,
					succes	 : function(data,testStatus){
						window.toast.addMessage("操作成功");
						refreshWin();
					},
					error:function (XMLHttpRequest, textStatus, errorThrown) {
						
					},
					complete:function (XMLHttpRequest, textStatus) {
						refreshWin();
					}
				});
				_confirm.hide();
			});
			
			
		});
	}
}

function refreshWin(){
	location.reload();
}
/**
 * 关联监控指标.
 */
function relationMonitorMetric() {
	var modelDivId = $("#modelDivId");
	var btns = modelDivId.find("span[btn='relaMonitorMetricBtn']");
	for(var i=0,len=btns.length;i<len;i++){
		var $btn = $(btns[i]);
		$btn.bind("click",{
		src: "${ctx}/roomDefine/RelationMonitorMetricVisit.action?pollingIndexId="+$("#pollingIndexId").val()+"&roomId="+$("#roomId").val()+"&checkId="+$btn.attr("id"),
		name:"relationMonitorMetricVisit",
		height:"540"
		},openWindowFun);
	}
	
}
/**
 * 删除关联监控指标.
 */
function delRelationMonitorMetric(){
	var modelDivId = $("#modelDivId");
	var btns = modelDivId.find("span[btn='delRelaMonitorMetricBtn']");
	for(var i=0,len=btns.length;i<len;i++){
		var $btn = $(btns[i]);
		$btn.bind("click",function(){
			var checkid = $(this).attr("id");
			var _confirm = new confirm_box({text:"是否执行此操作？"});
			_confirm.show();
			_confirm.setConfirm_listener(function(){
				btns.removeClass().addClass("ico-16 ico-16-del-down");
				$.ajax({
					url	:	"${ctx}/roomDefine/RelationMonitorMetricVisit!delRelationMetric.action",
					data:	"pollingIndexId="+$("#pollingIndexId").val()+"&roomId="+$("#roomId").val()+"&checkId="+checkid,
					dataType : "html",
					cache	 : false,
					succes	 : function(data,testStatus){
						window.toast.addMessage("操作成功");
						refreshWin();
					},
					error:function (XMLHttpRequest, textStatus, errorThrown) {
						refreshWin();
					}
				});
				_confirm.hide();
			});
			
		});
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
	toast = new Toast({position:"CT"}); 
	zhedieCheck();
	zhedieChildItem();
	relationMonitorResource();
	delRelationMonitorResource();
	relationMonitorMetric();
	delRelationMonitorMetric();
	/**
	 * 编辑巡检内容.
	 */
	$("#editPollingContentId").bind("click",{
		src: "${ctx}/roomDefine/EditPollingContentVisit.action?pollingIndexId="+$("#pollingIndexId").val(),
		name:"editPollingContentVisit",
		width:"620"
		},openWindowFun);
	/**
	 * 编辑检查项.
	 */
	$("#pollingDivId span[btn='editItemBtn']").bind("click",{
		src: "${ctx}/roomDefine/EditPollingItemVisit.action?pollingIndexId="+$("#pollingIndexId").val(),
		name:"editPollingItemVisit",
		width:"620"
		},openWindowFun);
	/**
	 * 编辑子检查项.
	 */
	$("#pollingDivId span[btn='editChildItem']").bind("click",{
		src: "${ctx}/roomDefine/EditPollingChildItemVisit.action?pollingIndexId="+$("#pollingIndexId").val()+"&roomId="+$("#roomId").val(),
		name:"editPollingChildItemVisit",
		width:"620"
		},openWindowFun);
});
</script>