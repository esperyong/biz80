<!-- content/profile/userdefine/processChildInsSelect.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!--<fieldset class="blue-border" style="width:630px;">-->
<!--<legend>选择${resName}</legend>-->

<br/>
<div class="vertical-middle margin3" style="padding:5px; width:630px;">
<span class="left"><span class="ico ico-tips"></span>点击
  <IMG src="${ctx}/images/add-button1.gif">
  添加进程，将进程添加到当前策略经行监控。
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 </span>
<span class="right" id="refresh">
<IMG src="${ctx}/images/add-button1.gif">
  <span id="addProess" style="cursor:pointer;">添加进程</span>
<IMG src="${ctx}/images/add-button1.gif">
  <span id="delProess" style="cursor:pointer;">删除进程</span>
</span>
<div class="left" style="width:38%;">
  <div class="panel-gray">
    <div class="panel-gray-top"> 
   		<span class="ico ico-filter"></span>
    	<input name="find_value" id="find_value" type="text" size="20" value="输入IP或名称过滤" />
    	<span class="ico ico-find"></span>
    </div>
    <div>
    	<table class="tableboder table-noborder table-width100">
	      <thead>
	        <tr>
	          <th width="12%"></th>
	          <th width="40%">资源名称</th>
	          <th width="48%">IP地址</th>
	        </tr>
	      </thead>
	    </table>
    </div>
    <div style="overflow-x:hidden;overflow-y:scroll;height: 400px;">
	      <table class="tableboder table-noborder">
	      <tbody id="left_res">
			<s:iterator value="mainResInsInfo" id="inc" status="st">
	        <tr style="cursor: pointer;" id="<s:property value="#inc.instanceId"/>" <s:if test="#st.even == true">class="tr-grey"</s:if> filter="<s:property value="#inc.instanceName"/>_<s:property value="#inc.ip"/>">
	          <td width="12%"><input type="checkbox" id="M_<s:property value="#inc.instanceId"/>" <s:if test="#inc.isSelected">checked="checked"</s:if>/></td>
	          <td width="40%" title="<s:property value="#inc.instanceName"/>"><div style="width: 75px; text-overflow: ellipsis; overflow: hidden;"><NOBR><s:property value="#inc.instanceName"/></NOBR></div></td>
	          <td title="<s:property value="#inc.ip"/>"><s:property value="#inc.ip"/></td>
	        </tr>
			</s:iterator>
	      </tbody>
	    </table>
   </div>
  </div>
</div>
<div class="right" style="width:61%;">
  <div class="panel-gray">
    <div class="panel-gray-top" style="height: 26px;"> 
    	<span>进程列表：</span>
     </div>
     <div>
    	<table class="tableboder table-noborder table-width100">
	     <thead>
          <th width="8%"></th>
          <th width="30%">资源名称</th>
          <th width="62%">进程名称</th>
        </tr>
      </thead>
	    </table>
    </div>
    <div style="overflow-x:hidden;overflow-y:scroll;height: 400px;">
	      <table class="tableboder table-noborder">
		       <tbody id="right_res">
			      <s:iterator value="mainResInsInfo" id="inc" status="st">
				      <tr <s:if test="#inc.isSelected==false">style="display: none;"</s:if> pid="<s:property value="#inc.instanceId"/>" <s:if test="#st.even == true">class="tr-grey"</s:if>>
				          <td width="12%" ><input type="checkbox"  id="s_<s:property value="#inc.instanceId"/>"/></td>
				          <td width="25%" title="<s:property value="#inc.instanceName"/>">
				          	<div style="width: 105px; text-overflow: ellipsis; overflow: hidden;"><NOBR><s:property value="#inc.instanceName"/></NOBR></div>
				          </td>
				          <td width="63%">
					          <ul>
						         <s:iterator value="#inc.children" id="child">
						  			<li title="<s:property value="#child.instanceName"/>" monitor="<s:property value="#child.state"/>"><div style="width: 215px; text-overflow: ellipsis; overflow: hidden;"><NOBR>
						  			<input type="checkbox" value="<s:property value="#child.instanceId"/>" name="resInsSelect.instanceIds" <s:if test="#child.isSelected==true">checked="checked"</s:if>/>
						  			<!-- else中是以前的代码如果需求有变化将还原成else中的代码 -->
						  			<s:if test="#child.state == 'ico ico-backplane-nomonitoring'">
				                        <span class="ico ico-backplane-normal" style="text-align: left;cursor:none;"></span>
				                    </s:if><s:else>
				                        <span class="<s:property value="#child.state"/>" style="text-align: left;cursor:none;"></span>
				                    </s:else>
						  			<s:property value="#child.instanceName"/></NOBR></div>
						  			</li>
				  			     </s:iterator>
			  			      </ul>
					      </td>
					  </tr>
				  </s:iterator>
	      	   </tbody>
	     </table>
   </div>
  </div>
</div>
</div>
<!--</fieldset>-->
<script type="text/javascript">
var path = '${ctx}';
function chooseResLeft(tag){
	
	var right_res = $("#right_res");
	var insId = $(tag).attr('id').replace('M_','');
	$obj = $('#s_'+insId).parentsUntil('tr').parent();
	//$('#s_'+insId).attr('checked',$(tag).attr('checked'));
	//chooseResRight($('#s_'+insId));
	right_res.prepend($obj);
	if($(tag).attr('checked')){
		$obj.css('display','block');
	}else{
		$obj.css('display','none');
	}
}
var monitor_state_array = [];

monitor_state_array['ico ico-backplane-normal'] = "monitor";
monitor_state_array['ico ico-backplane-nomonitoring'] = "monitor";
monitor_state_array['ico ico-backplane-monitoring-question'] = "monitor";
monitor_state_array['ico ico-backplane-canntuse'] = "unmonitor";
monitor_state_array['ico ico-backplane-disconnect'] = "monitor";


monitor_state_array['all'] = undefined;
function chooseMonitorState() {
	var $monitor_state = $("[name=_monitor_state]:checked");
	var monitor_state = $monitor_state.length > 0 ? $monitor_state.next().attr('class') : 'all';
	var mainResources = $("#left_res").children();
	var childArray = [];
	mainResources.each(function(){
		var m_res = $(this);
		if(!m_res.is(":hidden") && m_res.find("[id^=M_]").is(":checked")) {
			childArray.push($("#right_res [pid=" + m_res.attr("id") + "]"));
		}
	});
	$.each(childArray,function(i,e){
		var lis = $(e).find("ul").children();
		if( monitor_state_array[monitor_state] == undefined){
			lis.show();
		}else{
			$.each(lis,function(i,e){
				var li = $(e);
				if(monitor_state_array[monitor_state] === monitor_state_array[li.attr("monitor")]){
					li.show();
				}else{
					li.hide();
				}
			});
		}
	});
}
function chooseResRight(tag){
	$('[name=modifyListen.resSelect]').val(true);
	$(tag).parent().parent().find("input[name='resInsSelect.instanceIds']").attr("checked", $(tag).attr("checked"));
	
}

function checkForm() {
	$checkboxes = $("input[name='resInsSelect.instanceIds']:checked");
	var _information;
	if($checkboxes.length == 0) {
		_information = new information({text:"至少选择一个右侧进程。"});
		_information.show();
		return false;
	}
	return true;
}

function clickLeftTr(tag){
		var $right_res = $("#right_res");
		var $tr = $(tag);
		$("#left_res tr").removeClass("tr-blue").children("td").removeClass("txt-white");
		$tr.addClass("tr-blue").children("td").addClass('txt-white');
		var id = $tr.attr("id");
		$right_res.children("tr").removeClass("tr-blue").children("td").removeClass('txt-white');
		$right_res.children("tr[pid='"+id+"']").addClass("tr-blue").children("td").addClass('txt-white');
		$obj = $('#s_'+id).parentsUntil('tr').parent();
		$right_res.prepend($obj);
}
function clickRightTr(tag){
	var $tr=$(tag);
	$("#right_res tr").removeClass("tr-blue").children("td").removeClass("txt-white");;
	$tr.addClass("tr-blue").children("td").addClass('txt-white');		
	var id = $tr.attr("pid");
	var $left_res = $("#left_res");
	$left_res.children("tr").removeClass("tr-blue").children("td").removeClass('txt-white');
	$left_res.children("tr[id='"+id+"']").addClass("tr-blue").children("td").addClass('txt-white');
}
$(function(){
	$('#addProess').click(function(){
		var profileId = $("input[name=basicInfo.parentId]").val();
		var resourceId = $("input[name=basicInfo.resourceId]").val();
		var winOpenObj = {};
		winOpenObj.height = '600';
		winOpenObj.width = '700';
		winOpenObj.name = 'refreshProcessIns';
		winOpenObj.url = path + '/profile/userDefineProfile/forwardProessPage.action?profileId='+profileId+'&resId='+resourceId;
		winOpenObj.scrollable = false;
		winOpen(winOpenObj);
		
	});
	$('#delProess').click(function(){
		if(!checkForm()) {
			return;
		}
		var confirm_process = new confirm_box({text:"是否确认删除右侧所选进程？"});
		confirm_process.show();
		confirm_process.setConfirm_listener(function(){
		confirm_process.hide();
			$checkboxes = $("input[name='resInsSelect.instanceIds']:checked");
			var instanceIds = "";
			for(var i=0 ; i < $checkboxes.length ; i++){
					if(instanceIds == ""){
						instanceIds = $checkboxes[i].value;
					}else{
						instanceIds += ";"+$checkboxes[i].value;
						}
				}
			$.blockUI({message:$('#loading')});
			$.ajax({
				method:'POST',
				url : '${ctx}/profile/userDefineProfile/removeProcess.action?instanceId='+instanceIds,
				dataType:"json",
				success:function(data){
					$.unblockUI();
          window.location.href=window.location.href;
				},
				error:function(msg) {
					alert( msg.responseText);
			   }
			});
    	});
		confirm_process.setCancle_listener(function(){
			confirm_process.hide();
			});
		
	});
	$('[name=resInsSelect.instanceIds]').bind('change',function(){
		$('[name=modifyListen.resSelect]').val(true);
	});
	$('[id^=M_]').bind('change',function(){
		$('[name=modifyListen.resSelect]').val(true);
		chooseResLeft(this);
	});
	$('[id^=s_]').bind('change',function(){
		$('[name=modifyListen.resSelect]').val(true);
		chooseResRight(this);
	});
	$('tr','#left_res').click(function(){
		clickLeftTr(this);
	});
	$('tr','#right_res').click(function(){
		clickRightTr(this);
	});
	var tip = "输入IP或名称过滤";
	$(".ico-find").click(function(){

		var profile_enable = $("[name='basicInfo.enable']").val();
		if(profile_enable === 'true'){
			return;
		}
		
		/*
		var profile_enable = Boolean($("[name='basicInfo.enable']").val());
		if(profile_enable === true){
			return;
		}
		*/
		var fText = $("#find_value").val() != tip ? $("#find_value").val() : '';
		$('[name=modifyListen.resSelect]').val(true);
		$("#left_res").find(":checkbox").each(function(){
			$(this).attr("checked",false);
			$(this).change();
		});
		$("#left_res").children(":not(tr[filter*='"+fText+"'])").hide();
		$("#left_res").children("tr[filter*='"+fText+"']").show();
	});
	$("#find_value").focus(function(){
		if($(this).val() === tip){
			$(this).val('');
		}
	})
	$("#find_value").blur(function(){
		if($(this).val() === ''){
			$(this).val(tip);
		}
	})
});

</script>