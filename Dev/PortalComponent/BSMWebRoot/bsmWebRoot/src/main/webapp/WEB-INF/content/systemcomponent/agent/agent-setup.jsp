<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html>
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title><s:text name="discovery.page"/></title>
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
 <link rel="stylesheet" href="${ctx}/css/UIComponent.css" type="text/css" />
<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js" ></script>
<script type="text/javascript" src="${ctx}/js/component/cfncc.js" ></script>
<script src="${ctx}/js/jquery.blockUI.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/js/component/popwindow/popwin.js" ></script>
</head>
<body>
<form id="formsetup" name="formsetup" method="post">
<input type="hidden" name="agentId" id="agentId" value="${agentId}" />
	<div class="margin5 gray-bottom"> 
	<ul>
	<li><span class="ico ico-tips"/>设置允许与Agent通讯的IP地址。</li>
	<li class="margin3">
		<span class="field-max">允许访问的IP地址</span><span>：<s:textfield name="ipAddress" id="ipAddress" maxlength="" size=""/></span>
		<span class="ico ico-what" title="单个IP地址输入格式为192.168.17.23；&#10;IP地址网段输入格式为192.168.3.*；&#10;IP地址区间输入格式为192.168.50.1-192.168.50.100；"></span>
		<span class="black-btn-l  multi-line" id="addsetup"> <span class="btn-r"> <span class="btn-m"><a >添加</a></span> </span> </span>
	</li>
	<li class="margin3">
		<span class="field-max"></span><span>&nbsp;&nbsp;&nbsp;&nbsp;<s:select name="allowhostList" class="zi" id="allowhostList" style="width: 150px;" size="8"  theme="simple" list="allowhostList" multiple="multiple"></s:select>
		</span><span class="black-btn-l" style="margin-top:-45px;" id="deleteIp"> <span class="btn-r"> <span class="btn-m"><a >删除</a></span></span></span>
	</li>
	<li class="margin3">
		<span class="field-max">调试日志</span><span>：
			<select name="debugStr" id="debugStr">
        		<option value="1" <s:if test="debug==1">selected</s:if>>是</option>
        		<option value="0" <s:if test="debug!=1">selected</s:if>>否</option>
        	</select> </span><span class="ico ico-what" title="[安装目录]\plugin\service\log"></span>
	</li>
</ul>
</div>
<div class="margin5">
<span class="black-btn-l right" id="sp_apply"> <span class="btn-r"> <span class="btn-m"><a >应用</a></span> </span> </span>
</div>
</form>
</body>
<script type="text/javascript">
var info  = new information();
$(document).ready(function() {
	$.blockUI({message:$('#loading')});
	$.unblockUI();
	$("#addsetup").bind("click", function() {
		var $ip = $("input[name='ipAddress']").val();
		//alert($ip);
		if(""!= $ip){
			var regip= /^(([0-1]?\d{1,2}|2[0-4]\d|25[0-5])\.){3}([0-1]?\d{1,2}|2[0-4]\d|25[0-5])$/;
			var flag_ip=regip.test($ip);
			if(flag_ip){
			var len = $("select[name='allowhostList'] option").length
			//alert(len);
			var flag_r="false";
			$("select[name='allowhostList'] option").each(function(){
				if($ip == $(this).text()){
					flag_r = "true";	
					return false;
				}		
			})
			if(flag_r=="false"){
				var op = "<option value='"+$ip+"'>"+$ip+"</option>";
				//alert(op);
				$(op).appendTo($("#allowhostList"));	
			}else{
				info.setContentText("该IP已经添加，不能重复添加");
				info.show();
				return false;
			}
			
			}else{
			     info.setContentText("请输入正确的IP地址");
				 info.show();  
	             return false;
			}	
		}else{
				info.setContentText("IP地址不能为空");
			 	info.show();  
           		return false;
		}
	});
	$("#deleteIp").bind("click", function(){
		var _confirm = new confirm_box({
			text : "是否确认删除？"
		});
		_confirm.show();
		_confirm.setConfirm_listener(function() {
			if(_confirm){
			$("#allowhostList").find('option:selected').remove();
			_confirm.hide();
		}
		});
	});
	$("#sp_apply").bind("click", function(){
		var len = $("select[name='allowhostList'] option").length
		//alert(len);
		var allowhostStr="";
		$("select[name='allowhostList'] option").each(function(){
			if(allowhostStr==""){
				allowhostStr = $(this).text();
			}else{
				allowhostStr = allowhostStr + ";" +$(this).text()
			}
		});	
		//alert(allowhostStr);
		var debug = $("#debugStr").find('option:selected').val();
		var agentId = $("#agentId").val();
		var ajaxParam = "agentId="+agentId+"&debugStr="+debug+"&allowhostStr="+allowhostStr;
		//alert(ajaxParam);
		$.ajax( {
			type : "post",
			url : "agent-setup-apply!apply.action",
			data : ajaxParam,
			success : function(data, textStatus) {
				//alert("成功");
			}
		});
	});
});

</script>
</html>