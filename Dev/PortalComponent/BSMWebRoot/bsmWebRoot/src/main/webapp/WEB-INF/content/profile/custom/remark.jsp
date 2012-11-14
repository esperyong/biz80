<!-- content/profile/custom/remark.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<div class="pop-middle-m">
  <div class="pop-content"> 
   <div style="height:130px;overflow-y:auto;overflow-x:hidden;">
    <form id="formname">
    	<input type="hidden" name="instanceId" value="${instanceId}"/>
		<s:textarea name="description" id="description" cols="36" rows="8" onblur="trySet(this,'请输入备注')" onfocus="tryClear(this,'请输入备注')" ></s:textarea>
    </form>
   </div>
   <div class="margin3"><span class="win-button" id="cancel"><span class="win-button-border"><a>取消</a></span></span><span class="win-button" id="ok"><span class="win-button-border"><a>确定</a></span></span></div>
  </div>
</div>
<script>
var areaTip = "请输入备注";
$(function() {
	$description = $("#description");
	if($description.val() == "-") {
		$description.val("请输入备注");
	}
	$("#ok").click(function(){
		if($description.val() == areaTip) {
			$description.val("");
		}
		if(!checkRemarkLength()) {
			return false;
		}
		var ajaxParam = $("#formname").serialize();
		$.ajax({
			type:"POST",
			cache:false,
			url:path+"/profile/customProfile/saveRemark.action",
			data: ajaxParam,
			success:function(data){
			}
		});	
	   panelClose();
   });
  
   $("#cancel").click(function(){
	   panelClose();
   });
});

function trySet(obj,txt){
	if(obj.value=="-" || obj.value == ""){
		obj.value = txt;
	}
}
function tryClear(obj,txt){
	if(obj.value==txt){
		obj.value = '';
	}
}

function checkRemarkLength() {
	feildLength = $("#description").attr('value').replace(/[^\x00-\xff]/g,"**").length;
	if(feildLength > 200) {
		var _information = new information({text:"备注的输入长度不能超过200个字符。"});
		_information.show();
		return false;
	}
	return true;
}
</script>