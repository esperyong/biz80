<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/WEB-INF/common/meta.jsp"%>
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css">
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/jquery-ui/treeview.css" rel="stylesheet" type="text/css" />
<script src="${ctx}/js/component/treeView/tree.js"></script>
</head>
<body>
<div class="pop-middle-m">
  <div class="pop-content"> 
    <!--内容区域-->
   <div class="bold lineheight26">选择脚本</div> 
   <div class=" grayborder02 padding5" style="height:150px;overflow-y:auto;overflow-x:hidden;">
   	${jsonStr}
   </div>
   <div class="margin3"><span class="win-button" id="cancel"><span class="win-button-border"><a>取消</a></span></span><span class="win-button" id="ok"><span class="win-button-border"><a>确定</a></span></span></div>
   <!--内容区域--> 
  </div>
</div>
<script>
$(function() {
	$scriptId=$("#script_Id");
	$scriptName=$("#script_Name");
	$scriptFilePath=$("#script_filePath");
	$scriptIp=$("#script_Ip");
	$actionId=$("#actionId");
	$parameter_div=$("#parameter_div");
	
	var scriptId = null;
	var scriptName = null;
	var scriptFilePath = null;
	var scriptIp = null;
	var tree = new Tree({id:"root"/*,listeners:{
        nodeClick:function(node){
           if(node.isLeaf()) {
               scriptId=node.getId();
               scriptName=node.getText();
               scriptFilePath=node.getValue("filePath");
               scriptIp=node.getValue("serverIp");
           }else {
        	   scriptId = null;
       		   scriptName = null;
       		   scriptFilePath = null;
       		   scriptIp = null;
           }
        }
	}*/});

	$("#cancel").click(function(){
		panelClose();
  	});
  	
	$("#ok").click(function(){
		if(!checkForm()) {
			_information = new information({text:"请选择一个脚本."});
			_information.show();
			return;
		}
		//if($scriptId.val() != scriptId) {
			$scriptId.val(scriptId);
	        $scriptName.val(scriptName);
	        $scriptFilePath.val(scriptFilePath);
	        $scriptIp.val(scriptIp);
	        setParameters(scriptId);
		//}
  	});

  	function setParameters(scriptId) {
		var data = "scriptId="+scriptId+"&actionId="+$actionId.val();
		$.ajax({
			type:"POST",
			url: path+"/wireless/script/scriptParameter.action",
			data:data,
			dataType:"html",
			success: function(data, textStatus) {
				$parameter_div.empty().append(data);
				panelClose();
			},
			error: function(msg) {
				_information = new information({text:"系统异常，请联系管理员。"});
				_information.show();
			}
		});
  	}

  	function checkForm() {
  		$radio = $("input[name=scriptRadio]:checked");
  	  	if($radio.length > 0) {
	  	  scriptId=$radio.attr("nodeId");
	      scriptName=$radio.attr("name");
	      scriptFilePath=$radio.attr("filePath");
	      scriptIp=$radio.attr("serverIp");
	      return true;
  	  	}else {
			return false;
  	  	}
  	}
});
</script>
</body>
</html>
