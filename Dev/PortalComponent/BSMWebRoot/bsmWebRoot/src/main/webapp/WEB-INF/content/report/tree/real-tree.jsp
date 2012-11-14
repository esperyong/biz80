<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
${treeHtml}
<script type="text/javascript">
var ${treeId} = new Tree({
	id:"${treeId}",
	url:"${ctx}/report/tree/realTreeAction!lazyLoadTree.action",
	param:"userId="+userId+"&queryIp=${queryIp}&queryResourceName=${queryResourceName}&queryNetName=${queryNetName}&childResourceType=${childResourceType}&rootNodeId=",
	plugins:["singleExpend"],	
	listeners:{
  		checkboxClick:function(node) { 			                  
   			if(setTreeNode(node)){
   				var subCategory=categorySignObj.getCategoryObj().subCategory;
   	   			var selectedIds = getSelectNode(subCategory);// FIXME 选中的ID 	
   	   			var uriParam = 'userId='+userId+'&queryIp=${queryIp}&queryResourceName=${queryResourceName}&queryNetName=${queryNetName}&childResourceType=${childResourceType}&selectedIds=' + selectedIds + '&rootNodeId=';   			
   	   			${treeId}.setParam(uriParam);}},
  		expend:function(node){
  			var count=node.childCount();  
  			var name=node.getText().split("(")[0];
  			if(node.getText().split("(")[1].indexOf(".")==-1){  				
  				if(!isNaN(count)){
  	  				if(count!=0){  	  							
  	  	  	  			node.setText(name+"("+count+")");
  	  	 }}}}}}); 
</script>
