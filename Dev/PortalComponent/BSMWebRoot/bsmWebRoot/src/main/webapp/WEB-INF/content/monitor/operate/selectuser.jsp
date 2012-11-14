<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html>
<head>
	<%@ include file="/WEB-INF/common/meta.jsp" %>
	<style type="text/css">.span_dot_short{width:200px;text-overflow:ellipsis;white-space:nowrap;overflow:hidden; word-spacing:normal; word-break:normal; display:block;}
</style>
</head>
<body>
<h1>请选择用户名：</h1>
<div style="width:210px;height:100px;overflow-x:hidden;overflow-y:auto;border:1px solid #666;">
<ul id="maintainInfoVoList">
<s:iterator value="maintainInfoVoList" var="user">
<li class="span_dot_short" title="<s:property value="#user.getPrincipalName()" />"><input name="userrdo" type="radio" value="<s:property value="#user.getPrincipalId()"/>" userName="<s:property value="#user.getPrincipalName()" />" tel="<s:property value="#user.getTel()" />" email="<s:property value="#user.getEmail()" />" department="<s:property value="#user.getDepartment()" />" mobile="<s:property value="#user.getMobilePhone()" />"/><s:property value="#user.getPrincipalName()" /></li>
</s:iterator>
</ul>
</div>
<div style="float:right"><input type="button" id="selUserOk" value="确定" /><input type="button" id="selUserCal" value="取消" /></div>
<script type="text/javascript">
	$(function(){
		  var userId = $("#userId").val();
		  //alert(userId);
		  if( userId != "" ){
			  $("input[type=radio]").attr("checked","");
			  $("input[type=radio][value="+userId+"]").attr("checked",true);
			 // $("input[type=radio]").attr("checked",'user-9FHE9ZZELV35LZT');
		  }
		  $("#selUserOk").bind("click",function(){
			  $input = $("#maintainInfoVoList input:checked");
				if(selectUserPanel){
				    selectUserPanel.close("close");
				}
				$("#userId").val($input.val());
				$("#userName").val($input.attr("userName"));
				$("#departmentspan").html($input.attr("department"));
				$("#telphonespan").html($input.attr("tel"));
				$("#emailspan").html($input.attr("email"));
				$("#mobilespan").html($input.attr("mobile"));
			});
			$("#selUserCal").bind("click",function(){
				if(selectUserPanel){
					selectUserPanel.close("close");
				}
			});
	});
	</script>
</body>
</html>