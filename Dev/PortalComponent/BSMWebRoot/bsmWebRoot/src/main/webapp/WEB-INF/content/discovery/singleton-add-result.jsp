<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html>
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>发现页面</title>
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/validationEngine.jquery.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js" ></script>
<script type="text/javascript" src="${ctx}/js/component/cfncc.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery.validationEngine-cn.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery.validationEngine.js"></script>
<script type="text/javascript" src="${ctx}/js/component/accordionPanel/accordionPanel.js"></script>
<script type="text/javascript" src="${ctx}/js/component/accordionPanel/accordionAddSubPanel.js"></script>
<script type="text/javascript" src="${ctx}/js/component/combobox/simplebox.js"></script>
<script type="text/javascript" src="${ctx}/js/component/popwindow/popwin.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery.blockUI.js" ></script>
<script type="text/javascript">
var ctxpath = "${ctx}";
var groupId = "${groupId}";
var errormsg = "${errorMessage}";
var updateInst = "${updateInst}";
var $sp_disc_result = parent.$("#sp_disc_result");
var time = parent.$('#compact').html();
parent.$('#compact').countdown("destroy");
parent.$('#compact').html(time);

parent.stopLoading();
parent.$("#iframe_discovery").show();



$(document).ready(function() {
  parent.$.unblockUI();
  <s:if test="errorMessage == null">
  $sp_disc_result.removeClass("ico ico-false");
  $sp_disc_result.addClass("ico ico-right");
  if(groupId == 'pc'){
    parent.$("#sp_monitor").hide();
  }else{
    parent.$("#sp_monitor").show();
  }
  parent.$("#sp_finish").show();
  parent.$("#sp_continue").show();
</s:if>
<s:else>
  // 资源实例已经存在，提示用户是否更新.
  if(errormsg=='sameInstanceInBatch' && updateInst != 'true'){
    var confirmConfig = {
        width: 480,
        height: 110
    };
    var _confirm = new confirm_box(confirmConfig);
    _confirm.setContentText("资源已存在，是否更新资源信息？"); //也可以在使用的时候传入
    _confirm.setSubTipText("*IP、MAC不更新，其他信息输入为空时对应信息不更新。");
    _confirm.setConfirm_listener(function() {
      _confirm.hide();
      parent.$.blockUI({message:parent.$('#loading')});
      var formObj = parent.document.getElementById("form1");
      formObj.action = ctxpath + "/discovery/singletonAddResult.action?updateInst=true";
      formObj.submit();
    });
    _confirm.setCancle_listener(function() {
      _confirm.hide();
      $sp_disc_result.removeClass("ico ico-right");
      $sp_disc_result.addClass("ico ico-false");
      parent.$("#sp_finish").show();
      parent.$("#sp_continue").show();
      $("#filacause").show();
    });
    _confirm.setClose_listener(function() {
      _confirm.hide();
      $sp_disc_result.removeClass("ico ico-right");
      $sp_disc_result.addClass("ico ico-false");
      parent.$("#sp_finish").show();
      parent.$("#sp_continue").show();
      $("#filacause").show();
    });
    _confirm.show();
  }else{
	  $sp_disc_result.removeClass("ico ico-right");
	  $sp_disc_result.addClass("ico ico-false");
	  $("#filacause").show();
	  parent.$("#sp_finish").show();
	  parent.$("#sp_continue").show();
  }
</s:else>

  
  
  parent.parent.setNotChange();
	SimpleBox.renderAll();
	$("#form_result").validationEngine({promptPosition:"centerRight"});

	// 变更设备类型
  $("#parentGroupId").change(function(){
    var groupId = this.value;
    var url = ctxpath + "/discovery/singletonAdd!changeCategory.action?parentGroupId=" + groupId;
    ajaxJson(url,null,function(data){
      if(data){
        // 联动子类型
        $("#groupId").empty();
        for(var i=0;i<data.length ;i++){
          //alert(data[i].groupId+"-"+data[i].groupName);
          var option = "<option value='"+data[i].groupId+"'>"+data[i].groupName+"</option>";
          $("#groupId").append(option);
        }
        $("#groupId").change(); // 重新渲染select组件
      }
    });
  });

  // 变更设备类型,如果选择pc隐藏监控按钮
  $("#groupId").change(function(){
    var groupId = this.value;
    if(groupId == "pc"){
      parent.$("#sp_monitor").hide();
    }else{
      parent.$("#sp_monitor").show();
    }
  });

//ajax请求
  var ajaxJson = function(url,param,callback){
    $.ajax({
      url:url,
      dataType:"json",
      cache:false,
      data:param,
      type:"POST",
      success:function(data){
        callback(data);     
      },
      complete:function(){
        //$.unblockUI();
      }
    });
  };
});

function checkForm(){
  return $.validate($("#form_result"));
}
</script>
</head>
<body>
<form id="form_result" name="form_result">
<input type="hidden" id="discovery_successed" value="<s:if test="errorMessage == null">true</s:if><s:else>false</s:else>" />
<input type="hidden" id="instanceId" value="${instanceId}" />
<div class="fold-content" style="height:240px;">
	<s:if test="errorMessage == null">
		<table class="result">
			<thead>
				<tr><th colspan="2">设备名称：<input id="instanceName" name="instanceName" value="${resourceName}" class="validate[required[设备名称],length[0,50,设备名称],noSpecialStr[设备名称]]"/> </th></tr>
			</thead>
			<tbody>
				<tr>
					<td><span style="float:left;height:21px;line-height:21px;">设备类型：</span>
            <s:select list="parentGroupList" id="parentGroupId" name="parentGroupId" listKey="resourceCategoryGroupId" listValue="resourceGroupName" value="%{parentGroupId}"></s:select>
            <s:select list="groupList" id="groupId" name="groupId" isSynchro="1" listKey="resourceCategoryGroupId" listValue="resourceGroupName" value="%{groupId}"></s:select>
            <span class="ico ico-what" title="注:PC不能加入监控。"></span>
					</td>
					<td>IP地址：<s:property value="ipAddress"/></td>
				</tr>
			</tbody>
		</table>
	</s:if>
	<s:else>
		<div class="h3" id="filacause" style="display:none;">
			<span class="bold">失败原因：</span>
			<span><s:text name="%{errorMessage}" /></span>
		</div>
	</s:else>	
	<br/><br/><br/><br/><br/><br/>
</div>
</form>	
</body>
</html>