<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<div class="pop-middle-m">
  <div class="pop-content"> 
    <!--内容区域-->
   <div class="bold lineheight26">请选择用户名：</div> 
   <div class=" grayborder02 padding5" style="height:150px;overflow-y:auto;overflow-x:hidden;">
   	<s:iterator value="allUsers" id="id" status="status">
		<div id="select_user">
			<input type="checkbox" name="users" value="${id.userId}" id="${id.userId}_user" /><span><s:property value="%{#id.userName}"/>(<s:property value="%{#id.role}"/>)</span>
		</div>
	</s:iterator>
   </div>
   <div class="margin3"><span class="win-button" id="cancel"><span class="win-button-border"><a>取消</a></span></span><span class="win-button" id="ok"><span class="win-button-border"><a>确定</a></span></span></div>
   <!--内容区域--> 
  </div>
</div>
<script>
$(function() {
	var $click_btn_type = $("input[name='click_btn_type']");
	var $userObj = $("input[name='users']");
	var $IdObj;
	if($click_btn_type.val() == "C") {
		$IdObj = $("#receiveUserIds");
	}else if($click_btn_type.val() == "U") {
		$IdObj = $("#upgradeUserIds");
	}

	$userObj.attr("checked", "");
	$IdObj.children().each(function(){
		var $checkbox_obj = $("#"+$(this).val()+"_user");
		if($checkbox_obj != null) {
			$checkbox_obj.attr("checked", true);
		}
	});

	$("#ok").click(function(){
	   var type = $click_btn_type.val();
	   var $receiveUserNames = $("#receiveUserIds");
	   var $upgradeUserNames = $("#upgradeUserIds");
		
	   var array = new Array;
	   $("input[name='users']:checked").each(function(){
		   array.push("<option value='"+$(this).val()+"'>"+$(this).next().text()+"</option>"); 
	   });
	   if(type == "C") {
		   $receiveUserNames.html("").append(array.join(""));
	   }else if(type="U") {
		   $upgradeUserNames.html("").append(array.join(""));
	   }
	   panelClose();
   });
  
   $("#cancel").click(function(){
	   panelClose();
   });
});
</script>