<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/WEB-INF/common/meta.jsp" %>
<%@ include file="/WEB-INF/common/userinfo.jsp" %>
<title>加入资源组</title>
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/common.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/validationEngine.jquery.css" type="text/css" media="screen" title="no title" charset="utf-8" />
<script src="${ctx}/js/jquery-1.4.2.min.js" type="text/javascript"></script>
<script src="${ctx}/js/jquery.blockUI.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/js/jquery.validationEngine.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery.validationEngine-cn.js"></script>
<script type="text/javascript" src="${ctx}/js/monitor/Util.js"></script>
<script type="text/javascript" src="${ctx}/js/component/cfncc.js"></script>
<script type="text/javascript" src="${ctx}/js/component/combobox/simplebox.js"></script>
<style type="text/css">
	.inputoff{color:#CCCCCC}
	.field_n{display:inline-block;width:120px; *display:inline;zoom:1;}
</style>
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
<page:applyDecorator name="popwindow"  title="加入资源组">
    <page:param name="width">410px;</page:param>
    <page:param name="height">105px;</page:param>
	<page:param name="topBtn_index_1">1</page:param>
	<page:param name="topBtn_id_1">closeWindow</page:param>
	<page:param name="topBtn_css_1">win-ico win-close</page:param>
	<page:param name="topBtn_title_1">关闭</page:param>
	<page:param name="bottomBtn_index_2">2</page:param>
	<page:param name="bottomBtn_id_2">logout</page:param>
	<page:param name="bottomBtn_text_2">取消</page:param>
	<page:param name="bottomBtn_index_1">1</page:param>
	<page:param name="bottomBtn_id_1">submitForm</page:param>
	<page:param name="bottomBtn_text_1">确定</page:param>
<page:param name="content">
     <form id="form1" method="post" onsubmit="return false;">
     <input type="hidden" name="currentUserId" id="currentUserId" value="<%=userId %>"/>
     <input type="hidden" name="isAdmin" id="isAdmin" value="<%=isAdmin %>"/>
     <div id="hidDiv">
     </div>
     <div id="group" style="height:129px;">
           <ul class="fieldlist">
              <li><span class="field_n" style="float:left;height:21px;line-height:21px;">输入或选择资源组：</span>
                     	<s:if test="resourceGroupList != null">
                     	 <select name="resourceGroupId" id="resourceGroupId" style="width:170px;float:left;height:21px;line-height:21px;">
                     	     <option value="0">请输入或选择资源组</option>
                             <s:iterator value="resourceGroupList" var="group"  status="stat">
                                 <option value="<s:property value="#group.getResourceGroupId()" />"><s:property value="#group.getResourceGroupName()"/></option>
                             </s:iterator>
                         </select><span id="noChoose" style="hidden:true">无可选择资源组</span>
		               </s:if>  
          	  </li>
               <li class="last"><span class="ico ico-note-blue"></span>把所选资源加入资源组</li>
           </ul>
     </div>
     </form>
</page:param>
</page:applyDecorator>
</body>
<script type="text/javascript">
var path = "<%=request.getContextPath()%>";
function logout() {
    window.opener = null;
    window.open("", "_self");
    window.close();
}

function noSelectGroupFun(tag) {
  if($("#resourceGroupId_render_text").val()== "请输入或选择资源组"){
    return true;
  }
  return false;
}
$(function(){
	$("#form1").validationEngine({promptPosition:"bottomRight"});
	settings = {
			promptPosition:"bottomRight",
			validationEventTriggers:"keyup blur change",
			inlineValidation: true,
			scroll:false,
			success:false,
			failure : function() {}
		}
		$.validate = function(form) {
		    $.validationEngine.onSubmitValid = true;
		    if ($.validationEngine.submitValidation(form, settings) == false) {
		        if ($.validationEngine.submitForm(form, settings) == true) {
		            return false;
		        } else {
		            return true;
		        }
		    } else {
		        settings.failure && settings.failure();
		        return false;
		    }
		};

	  $.validationEngineLanguage.allRules.noSelectGroup = {
	      "nname":"noSelectGroupFun",
	      "alertText":"<font color='red'>*</font> 请输入或选择资源组"
	  };
	  
		
	var isMonitor = 'monitor';
	$("#noChoose").hide();
	  var paramMapCreate = opener.Monitor.Resource.right.monitorList.paramMap;
	  if(!paramMapCreate ){
		  paramMapCreate = opener.Monitor.Resource.right.noMonitorList.paramMap;
		  isMonitor = 'noMonitor';
	  }
	  var arr = [];
	  var instanceIdArr = [];
	  var allElemCreate = paramMapCreate.arr;
 	  for(var i=0;i<allElemCreate.length;i++){
 		 instanceIdArr.push(allElemCreate[i].key);
 	 }
	  for(var i=0;i<instanceIdArr.length;i++){
		  arr.push( "<input type='hidden' name='resourceInsId'" +" value='"+instanceIdArr[i]+"'/>"); 
      }
	  $("#hidDiv").append(arr.join(""));
	  for(var i=0;i<allElemCreate.length;i++){
		  if(opener.Monitor.Resource.right.monitorList.paramMap){
			  opener.Monitor.Resource.right.monitorList.paramMap.remove(allElemCreate[i].key);
		  }else{
			  opener.Monitor.Resource.right.noMonitorList.paramMap.remove(allElemCreate[i].key);
		   }
	 }
	  $("#submitForm").click(function (){
	    if(!$.validate($("#form1"))) {return;}
		  if($("#resourceGroupId_render_text").val()== "请输入或选择资源组"){
				//$("#noChoose").show();
				return false;
		  }
		  
		  $.blockUI({message:$('#loading')});
		  var ajaxParam = $("#form1").serialize();
		  $.ajax({
			   type: "POST",
			   dataType:'json',
			   url:path+"/monitor/monitorAjaxList!joinGroupById.action",
			   data: ajaxParam,
			   success: function(data, textStatus){
	    	   		//alert(data.operateSuccess);
	    	   		opener.Monitor.Resource.right.refresh(data.resourceGroupId,isMonitor,"resourceGroupTree","resourceGroup","0","0","/monitor/monitorList.action");
	    	   		$.unblockUI();
	    	   		logout();
			   }
			});
	   });
	  $("#closeWindow,#logout").click(function() {
	    	 logout();
	  });
	  
	  SimpleBox.getIPComboBoxInstance({selectId : 'resourceGroupId',name:'resourceGroupId_Text',validate:'validate[length[0,50,资源组名称],noSpecialStr[资源组名称],funcCall[noSelectGroup]]'});
     // SimpleBox.renderAll('group');
      SimpleBox.renderToUseWrap([{selectId:"resourceGroupId",maxHeight:"70",contentId:"group"}]);
      var $resourceName = $("input[name='resourceGroupId_Text']");
      if( $resourceName.val() == '请输入或选择资源组' ){
      	  $resourceName.addClass("inputoff");
      }else{
    	  $resourceName.removeClass("inputoff");
      }
      $("#resourceGroupId").change(function() {
	     if( $resourceName.val() == '请输入或选择资源组' ){
      	     $resourceName.addClass("inputoff");
      	     $resourceName.attr("disabled",false);
         }else{
        	 $resourceName.removeClass("inputoff");
             $resourceName.attr("disabled","disabled");
         }
	  });
	  $resourceName.bind("focus", function(event) {
		  $resourceName.removeClass("inputoff");
	          if ($resourceName.val() == "请输入或选择资源组") {
		          $resourceName.val("");
	          }
	  });
	  $resourceName.bind("blur", function(event) {
	          var c = $resourceName.val();
	          if (c == null || c == '') {
		          $resourceName.val("请输入或选择资源组");
		          $resourceName.addClass('inputoff');
	          }
	  });
	  
});

</script>
</html>