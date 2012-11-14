<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<link href="${ctxCss}/public.css" rel="stylesheet" type="text/css" />
<link href="${ctxCss}/jquery-ui/treeview.css" rel="stylesheet"type="text/css">
<link href="${ctxCss}/UIComponent.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/tongjifenxi.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctxJs}/jquery-1.4.2.min.js" ></script>
<script type="text/javascript" src="${ctxJs}/component/treeView/tree.js"></script>
<script type="text/javascript" src="${ctxJs}/component/cfncc.js"></script>
<script type="text/javascript" src="${ctxJs}/component/tabPanel/tab.js"></script>
<script type="text/javascript" src="${ctxJs}/component/menu/menu.js"></script> 
<script type="text/javascript" src="${ctxJs}/component/panel/panel.js"></script>
<script type="text/javascript" src="${ctxJs}/component/date/WdatePicker.js"></script>
<script type="text/javascript" src="${ctxJs}/component/accordionPanel/accordionLeft.js"></script>
<script type="text/javascript" src="${ctxJs}/report/statistic/statisticMetric.js"></script>
<page:applyDecorator name="popwindow" title="选择人员">
	<page:param name="topBtn_index_1">1</page:param>
	<page:param name="topBtn_id_1">choicePersonal</page:param>
	<page:param name="topBtn_css_1">win-ico win-close</page:param>
	
	<page:param name="bottomBtn_index_1">1</page:param>
	<page:param name="bottomBtn_id_1">submitChoicePersonal</page:param>
	<page:param name="bottomBtn_text_1" >确定</page:param>

	<page:param name="bottomBtn_index_2">2</page:param>
	<page:param name="bottomBtn_id_2">cancelChoicePersonal</page:param>
	<page:param name="bottomBtn_text_2" >取消</page:param>

	<page:param name="content">
		<div class="panel-gray-top"><span class="panel-gray-title">选择人员</span></div>
		<div class="panel-gray-content" id="personalTree" style="width: 97%;height: 335px;overflow-y:auto;">
			${userTreeHtml }
		</div>
	</page:param>
</page:applyDecorator>
<input type="hidden" id="userIds" value=""/>
<input type="hidden" id="userNames" value=""/>
<script type="text/javascript">
var userTree = new Tree({
	id:"userTree",
	listeners:{
  		checkboxClick:function(node) {
  			if(node.isLeaf()){
  				var userId=$("#userIds").val();
  	  			var userName=$("#userNames").val();
  	  			if(node.isChecked()){			
  	  				if(objValue.isNotEmpty(userId)){
  	  					userId+=";"+node.getId();
  	  					userName+=";"+node.getText();
  	  				}else{
  	  					userId=node.getId();
  	  					userName=node.getText();
  	  				} 				
  	  			}else{
  	  				var array=userId.split(";");
  	  				deleteArrayValue(array,node.getId());
  	  				userId=getArrayValue(array,";");
  	  				
  	  				array=userName.split(";");
  	  				deleteArrayValue(array,node.getText());
  	  				userName=getArrayValue(array,";");  				  				
  	  			}
  	  			$("#userIds").val(userId);
  	  			$("#userNames").val(userName);
  			}else{
  				var userId=$("#userIds").val();
  				var userName=$("#userNames").val();
  				var nodes=node.getCheckedNodes(true);
  				for(var i=0;i<nodes.length;i++){
  					if(objValue.isNotEmpty(userId)){
  	  					userId+=";"+nodes[i].getId();
  	  					userName+=";"+nodes[i].getText();
  	  				}else{
  	  					userId=nodes[i].getId();
  	  					userName=nodes[i].getText();
  	  				}
  				}
  				$("#userIds").val(userId);
  				$("#userNames").val(userName);
  			}		
  		}
 	}
}); 
//取消提交
$("#cancelChoicePersonal").click(function(){
	window.close();
});
$("#choicePersonal").click(function(){
	window.close();
});
//确定提交
$("#submitChoicePersonal").click(function(){
	var userIds=$("#userIds").val();
	var userNames=$("#userNames").val();
	if(objValue.isNotEmpty(userIds)){
		dialogArguments.setPersonal(userIds,userNames);		
	}
	window.close();
});
</script>	