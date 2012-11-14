<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<div class="pop-middle-m">
  <div class="pop-content"> 
    <!--内容区域-->
   <div class="bold lineheight26">视图显示内容</div> 
   <div class=" grayborder02 padding5" style="height:260px;overflow-y:auto;overflow-x:hidden;">
   	${viewTree}
   </div>
   <div class="margin3"><span class="win-button" id="cancel"><span class="win-button-border"><a>取消</a></span></span><span class="win-button" id="ok"><span class="win-button-border"><a>确定</a></span></span></div>
   <!--内容区域--> 
  </div>
</div>
<script>
var objId = null;
var objName = null;
var moduleId = null;
var url = null;
$(document).ready(function(){
	var toast = new Toast({position:"CT"});
	var tree = new Tree({id:"viewTree",url:"${ctx}/homepage/viewTree!addTreeNode.action",param:"parentId=",listeners:{
		nodeClick:function(node){
			objId = node.getId();
			objName = node.getText();
			moduleId = node.getValue("moduleId");
			url = node.getValue("url");
		},
		expendBefore:function(node){
			var moduleId = node.getValue("moduleId");
			tree.setParam("moduleId=" + moduleId + "&parentId=");
		}
	}});
	
	$("#cancel").click(function(){
		panelClose();
  	});
  	
	$("#ok").click(function(){
		var urlarr = $("input[name*='].url']");
		var flag = false;
		urlarr.each(function(){
			if($(this).val() == url){
				flag = true;
				return;
			}
		});
		if(url == null) {
			toast.addMessage("请选择视图。");
		} else {
			if(!flag){
				$viewObjName.val(objName);
				var brothers = $viewObjName.nextAll();
				$(brothers[0]).val(objId);
				$(brothers[1]).val(moduleId);
				$(brothers[2]).val(url);
				panelClose();
			}else{
				toast.addMessage("视图已选择。");
			}
		}
  	});
});
</script>