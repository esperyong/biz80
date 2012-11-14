<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>选择监控策略</title>
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css"/>
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css"/>
<link href="${ctx}/css/common.css" rel="stylesheet" type="text/css"/>
<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css"/>
<link rel="stylesheet" type="text/css" href="${ctx}/css/validationEngine.jquery.css" />
<script src="${ctx}/js/jquery-1.4.2.min.js" type="text/javascript"></script>
<script src="${ctx}/js/jquery.blockUI.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/js/monitor/Util.js"></script>
<script type="text/javascript" src="${ctx}/js/component/cfncc.js"></script>
<script type="text/javascript" src="${ctx}/js/component/combobox/simplebox.js"></script>
<script type="text/javascript" src="${ctx}/js/component/comm/winopen.js"></script>
 <script type="text/javascript" src="${ctx}/js/component/popwindow/popwin.js"></script>
<style type="text/css">.inputoff{color:#CCCCCC}</style>
</head>
<body>
 <div id="loading" class="loading" style="display:none;"
       ><div class="loading-l"
                ><div class="loading-r"
                    ><div class="loading-m"
                         ><span class="loading-img">载入中，请稍候...</span 
                    ></div
                 ></div
      ></div
 ></div>
<DIV id="errorDiv" style="FILTER: alpha(opacity=87); ZOOM: 1; TOP: 46px; LEFT: 693px;display:none;position:absolute;top:28px;left:220px;" class="formError txt1formError" jQuery1310972789366="10"><DIV class=formErrorContent><FONT color=red>*</FONT> 请选择策略。<BR></DIV>
<DIV class=formErrorArrow>
<DIV class=line10></DIV>
<DIV class=line9></DIV>
<DIV class=line8></DIV>
<DIV class=line7></DIV>
<DIV class=line6></DIV>
<DIV class=line5></DIV>
<DIV class=line4></DIV>
<DIV class=line3></DIV>
<DIV class=line2></DIV>
<DIV class=line1></DIV></DIV></DIV>

<page:applyDecorator name="popwindow"  title="选择监控策略">
    <page:param name="width">380px;</page:param>
    <page:param name="height">125px;</page:param>
	<page:param name="topBtn_index_1">1</page:param>
	<page:param name="topBtn_id_1">closeWindow</page:param>
	<page:param name="topBtn_css_1">win-ico win-close</page:param>
    <page:param name="topBtn_title_1">关闭</page:param>
    <page:param name="bottomBtn_index_1">1</page:param>
	<page:param name="bottomBtn_id_1">submitForm</page:param>
	<page:param name="bottomBtn_text_1">确定</page:param>
	<page:param name="bottomBtn_index_2">2</page:param>
	<page:param name="bottomBtn_id_2">logout</page:param>
	<page:param name="bottomBtn_text_2">取消</page:param>
    <page:param name="content">
    <div id="_chooseProfile" style="height: 135px">
    <form id="form1" action="" method="post">
	       <input type="hidden" name="instanceId" id="instanceId" value="<s:property value="instanceId"/>"/>
	       <input type="hidden" name="currentProfileID" id="currentProfileID" value="<s:property value="currentProfileID"/>"/>
	       <ul class="fieldlist">
	             <li><span class="field" style="float:left;height:21px;line-height:21px;">当前使用的策略：</span>
                         <span style="float:left;height:21px;line-height:21px;"><s:if test="currentProfileType=='CustomizeProfile'">个性化监控设置</s:if><s:else><s:property value="currentProfileName"/></s:else></span>
				  </li>
				  <li><span class="field" style="float:left;height:21px;line-height:21px;">将资源加入策略：</span>
                         <s:select name="belongProfile"  style="float:left;height:21px;line-height:21px;width:160px" list="profileMap" listKey="key"  listValue="value" headerKey="0" headerValue="---------请选择策略---------"/><span id="noChoose">请选择策略</span> 
				  </li>
	       </ul>
	 </form>
    </div>
	</page:param>
</page:applyDecorator>
</body>
<script type="text/javascript">
var path = "<%=request.getContextPath()%>";
if (!window.Monitor) {
    window.Monitor = {};
}
Monitor.Resource = {};
Monitor.Resource.right = {};
Monitor.Resource.right.monitorList = {};
Monitor.Resource.right.monitorList.modiColProfile = function(rowIndex,value){
	window.opener.Monitor.Resource.right.monitorList.modiColProfile(rowIndex,value);
	logout();
};
function logout()
{
  window.opener = null;
  window.open("", "_self");
  window.close();
}
$(function() {
	 SimpleBox.renderToUseWrap([{selectId:"belongProfile",maxHeight:"65",contentId:"_chooseProfile"}]);
//	SimpleBox.renderAll('_chooseProfile');
	$("#noChoose").hide();
	$("#errorDiv").hide();
	$("#errorDiv").click(function(){
	  $(this).hide();
	});
	$("#submitForm").click(function (){
		var instanceId = $("#instanceId").val();
	    var rowIndex = "<s:property value="rowIndex"/>";
		if($("#belongProfile").val() == "CustomProfile"){
		    $.blockUI({message: $('#loading')});
		    $.ajax({
		        type: "POST",
		        dataType: 'json',
		        url: path + "/monitor/monitorAjaxList!judgeResourceOperate.action?isMenu=false&isMonitor=monitor&instanceId=" + instanceId,
		        success: function(data, textStatus) {
		            $.unblockUI();
		            if (data.allowable == "monitor" || data.allowable == "") {
		                winOpen({
		                    url: path + "/profile/customProfile/queryCustomProfile.action?instanceId=" + instanceId + "&rowIndex=" + rowIndex,
		                    width: 770,
		                    height: 1200,
		                    scrollable: true,
		                    name: 'customProfile'
		                });
		                //logout();
		            } else {
		                var _information = Monitor.Resource.infomation;
		                if (data.allowable == "delete") {
		                    _information.setContentText("该资源已删除。"); //提示框 
		                    _information.show();
		                }
		                if (data.allowable == "unMonitor") {
		                    _information.setContentText("该资源未监控。"); //提示框 
		                    _information.show();
		                }
		                window.opener.Monitor.refresh();
		                logout();
		            }
		        }
		    });
		    return false;
		}
		if($("#belongProfile").val() == "0"){
			//$("#noChoose").show();
			$("#errorDiv").show();
			return false;
		}
		 var ajaxParam = $("#form1").serialize();
		 ajaxParam = ajaxParam+"&belongProfileName="+$("#belongProfile").find("option:selected").text();
	    // alert(ajaxParam);
	     $.blockUI({message:$('#loading')});
			$.ajax({
			   type: "POST",
			   dataType:'json',
			   url: path+"/monitor/monitorAjaxList!changeProfile.action",
			   data: ajaxParam,
			   success: function(data, textStatus){
	               var json = data.gridJson;
	               //if("SystemProfile" == json){
	                   
	                   window.opener.Monitor.Resource.right.monitorList.modiColProfile('<s:property value="rowIndex"/>',json);
	               //}
	               //if("UserDefineProfile" == json){
	            	//   window.opener.Monitor.Resource.right.monitorList.modiColProfile('<s:property value="rowIndex"/>',"UserDefineProfile");
	                 //  }
	               //if("CustomizeProfile" == json){
	            	//   window.opener.Monitor.Resource.right.monitorList.modiColProfile('<s:property value="rowIndex"/>',"CustomizeProfile");
	                 //    }
	               $.unblockUI();
			       logout();
			   }
			});
	 });
	$("#closeWindow,#logout").click(function() {
		 logout();
	});
	
  $("#belongProfile").change(function() {
    $("#errorDiv").hide();
  });
	//SimpleBox.renderAll('profileSelect');
});


</script>
</html>