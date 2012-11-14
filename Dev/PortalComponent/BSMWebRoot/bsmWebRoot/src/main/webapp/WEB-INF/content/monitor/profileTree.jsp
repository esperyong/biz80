<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<dl id="profile_Tree">
   <dt id="monitorProfile"><span class="ico ico-monitor"></span><span style="cursor:default">监控策略(</span><span id="profileCount">0</span><span>)</span></dt>
       <dd id="systemProfile" style="margin-left:20px" clickname="/profile/profileListQuery.action?profileDefType=SystemProfile"><span class="ico ico ico-default"/></span><span name="explain" style="cursor:pointer">系统默认(</span><span id="systemProfileCount">0</span><span>)</span></dd>
       <dd id="userDefineProfile" style="margin-left:20px" clickname="/profile/profileListQuery.action?profileDefType=UserDefineProfile"><span class="ico ico-user-defined"/></span><span name="explain" style="cursor:pointer">用户自定义(</span><span id="userDefineProfileCount">0</span><span>)</span></dd>
   <dt id="alarm" clickname="/profile/alarm/alarmList.action"><span class="ico ico-alert"></span><span name="explain" style="cursor:pointer">告警规则(</span><span id="alarmCount">0</span><span>)</span></dt>
   <dt id="event" clickname="/effecteresource/effecteRes.action"><span class="ico ico-rs-setting" ></span><span name="explain" style="cursor:pointer">影响资源设置</span></dt>
</dl>                                                 
<script type="text/javascript">
function userDefineProfileRefresh(profileId,ddId){
	  if(ddId == null){
	     ddId = "userDefineProfile";
	  }
	  changeProfileTreeCount();
	  $("#profile_Tree span[name='explain']").removeClass("pitchUp");
	  $("#"+ddId+" span[name='explain']").addClass("pitchUp");
	  var userDefineUrl = $("#"+ddId).attr("clickname")+"&profileId="+profileId;
	  change(userDefineUrl,"#main-right");
}
function alarmListRefresh(){
	changeProfileTreeCount();
   	$("#profile_Tree span[name='explain']").removeClass("pitchUp");
	$("#alarm span[name='explain']").addClass("pitchUp");
	var userDefineUrl = $("#alarm").attr("clickname");
	change(userDefineUrl,"#main-right");
}
function changeSystemProfileCount(count){
	$("#systemProfileCount").html(count);
	$("#profileCount").html(parseInt(count)+parseInt($("#userDefineProfileCount").text()));
}
function changeUserDefineProfileCount(count){
	$("#userDefineProfileCount").html(count);
	$("#profileCount").html(parseInt(count)+parseInt($("#systemProfileCount").text()));
}
function alarmCount(count){
	$("#alarmCount").html(count);
}
function change(url,divId){
	//$.blockUI({message:$('#monitorListLoading')});
	$.ajax({
	    type: "POST",
	    dataType: 'html',
	    url: path + url,
	    success: function(data, textStatus) {
	        $(divId).find("*").unbind();
	        $(divId).html("");
	        $(divId).append(data);
	       /// $.unblockUI();
	    }
	});
}
function changeProfileTreeCount(){
	$.ajax({
	    type: "POST",
	    dataType: 'json',
	    url: path + '/profile/calcLeftTreeNum.action',
	    success: function(data, textStatus) {
		       var jsonstr = (new Function("return "+data.dataList))();
		       if(jsonstr){
		    		   changeSystemProfileCount(jsonstr[0]);
		    		   changeUserDefineProfileCount(jsonstr[1]);
		    		   alarmCount(jsonstr[2]);
			   }
	    }
	});
}
$(function(){
   changeProfileTreeCount();
   $("#profile_Tree span[name='explain']").removeClass("pitchUp");
   $("#systemProfile span[name='explain']").addClass("pitchUp");
   $("#resourceOrProfile dd[clickname]").click(function(){
   $("#profile_Tree span[name='explain']").removeClass("pitchUp");
   $(this).find("span[name='explain']").addClass("pitchUp");
		change($(this).attr("clickname"),"#main-right");
   });
   $("#resourceOrProfile dt[clickname]").click(function(){
	    $("#profile_Tree span[name='explain']").removeClass("pitchUp");
	    $(this).find("span[name='explain']").addClass("pitchUp");
	    change($(this).attr("clickname"),"#main-right");
    });
});
</script>