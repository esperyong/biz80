<!-- content/profile/userdefine/childInsSelect.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!--<fieldset class="blue-border" style="width:630px;">-->
<!--<legend>选择${resName}</legend>-->

<br/>
<div class="vertical-middle margin3" style="padding:5px; width:630px;">
<span class="left"><span class="ico ico-tips"></span>说明：要刷新设备上的${resName}列表，请在左侧选择设备(最多选择10个)，然后点击“<span class="ico ico-refresh" style="cursor:none;"></span>刷新”按钮。</span><span class="right box" id="refresh" style="width:50px;"><span class="ico ico-refresh"></span><span style="cursor:pointer;">刷新</span></span>
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
     <s:if test="@com.mocha.bsm.profile.common.CommonMethod@isThisType(resId, @com.mocha.bsm.profile.common.Constants@NETWORKINTERFACE)">
      <ul>
        <li class="left"> <span class="ico ico-filter"></span>
        	<select id="state_sel">
        		<option value="monitor_state">状态</option>
        		<option value="monitor_link">链路</option>
        	</select>
        </li>
        
        <li class="left" name="monitor_state"><input name="_monitor_state" type="radio" value="all" onclick="chooseMonitorState()"/>全部</li>
        <li class="left" name="monitor_state"><input name="_monitor_state" type="radio" value="monitor" onclick="chooseMonitorState()"/><span class="ico ico-backplane-normal"></span>可用</li>
        <li class="left" name="monitor_state"><input name="_monitor_state" type="radio" value="unmonitor" onclick="chooseMonitorState()"/><span class="ico ico-backplane-canntuse"></span>不可用</li>
        <li class="left" name="monitor_state"><input name="_monitor_state" type="radio" value="disconnect" onclick="chooseMonitorState()"/><span class="ico ico-backplane-disconnect"></span>未插网线</li>
        
        <li class="left" name="monitor_link" style="display: none;"><input name="_monitor_link" type="radio" value="all_link" onclick="chooseMonitorLink()"/>全部</li>
        <li class="left" name="monitor_link" style="display: none;"><input name="_monitor_link" type="radio" value="device_device" onclick="chooseMonitorLink()"/>设备-设备</li>
        <li class="left" name="monitor_link" style="display: none;"><input name="_monitor_link" type="radio" value="device_server" onclick="chooseMonitorLink()"/>设备-服务器</li>
        <li class="left" name="monitor_link" style="display: none;"><input name="_monitor_link" type="radio" value="device_pc" onclick="chooseMonitorLink()"/>设备-PC</li>
     </ul> 
	</s:if>
     </div>
     <div>
    	<table class="tableboder table-noborder table-width100">
	     <thead>
          <th width="8%"></th>
          <th width="30%">主资源</th>
          <th width="62%">子资源</th>
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
						  			<li title="<s:property value="#child.instanceName"/>" monitor="<s:property value="#child.state"/>" linktype="<s:property value="#child.linkType"/>"><div style="width: 215px; text-overflow: ellipsis; overflow: hidden;"><NOBR>
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
monitor_state_array['ico ico-backplane-disconnect'] = "unReticleMonitor";


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
function chooseMonitorLink() {
	var $device_link = $("[name=_monitor_link]:checked");
	var device_link = $device_link.length > 0 ? $device_link.val() : 'all_link';
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
		if( device_link == 'all_link'){
			lis.show();
		}else{
			$.each(lis,function(i,e){
				var li = $(e);
				if(device_link === li.attr("linktype")){
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
function clickLeftTr(tag){
		var $right_res = $("#right_res");
		var $tr = $(tag);
		$("#left_res tr").removeClass("tr-blue").children("td").removeClass("txt-white");
		$tr.addClass("tr-blue").children("td").addClass('txt-white');
		var id = $tr.attr("id");
		$right_res.children("tr").removeClass("tr-blue").children("td").removeClass('txt-white');
		$right_res.children("tr[pid='"+id+"']").addClass("tr-blue").children("td").addClass('txt-white');

		//当点击撤销主资源实例将子资源实例也撤销
	    if($right_res.children("tr[pid='"+id+"']").find("input[name='resInsSelect.instanceIds']:checked").length>0){
	      $('[name=modifyListen.resSelect]').val(true);
	      $right_res.children("tr[pid='"+id+"']").attr("checked", false);
	      $right_res.children("tr[pid='"+id+"']").find("input[name='resInsSelect.instanceIds']").attr("checked", false);
	    }

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
	$('#refresh').click(function(){
		var profileId = $("input[name=basicInfo.parentId]").val();
		var winOpenObj = {};
		winOpenObj.height = '600';
		winOpenObj.width = '700';
		winOpenObj.name = 'refreshIns';
		winOpenObj.url = path + '/profile/userDefineProfile/forwardRefreshPage.action?profileId='+profileId;
		winOpenObj.scrollable = false;
		winOpen(winOpenObj);
		
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

	$("#state_sel").change(function(){
		 $(this).parent().parent().find("li[name]").hide();
		 $(this).parent().parent().find("li[name="+$(this).val()+"]").show();
	});
	
});
</script>