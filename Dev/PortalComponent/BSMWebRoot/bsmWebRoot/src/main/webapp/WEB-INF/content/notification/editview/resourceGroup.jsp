<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<div class="monitor" id="contentDIV2" >
	<div class="panel-gray  table-noborder">
	<div class="panel-gray-top toplinegray">
		<span class=panel-gray-title>资源组</span> 
	</div>
	</div>
	<div class="select-lr">
    	<div class="left">
        	<div class="h2 vertical-middle">待选资源组：
	          <%--<span class="vertical-middle"><input name="textarea" type="text" value="请输入资源名称或IP地址" /></span>
	          <span class="ico ico-select"></span>--%>
        	</div>
        	<div class="time clear" id="unselect_res" style="overflow-y: auto;overflow-x: hidden;height:200px;"><s:property value="leftResGroupsTree" escape="false" /></div>
		</div>
	    <div class="middle" style="margin:0px 8px">
	    	<span class="turn-right" id="resGroup-turn-right"></span> 
	    	<span class="turn-left" id="resGroup-turn-left"></span>
	    </div>
	    <div class="right" style="overflow:hidden;">
	    	<div class="h2 vertical-middle">已选资源组：
	           <%--<span class="vertical-middle"><input name="textarea" type="text" value="请输入资源名称或IP地址" /></span>
	           <span class="ico ico-select"></span>--%>
	           </div>
	        <div class="time clear" id="selected_res" style="overflow-y: auto;overflow-x:hidden;height:200px;"><s:property value="rightResGroupsTree" escape="false" /></div>
		</div>
	</div>
</div>

<script type="text/javascript">
$(function(){
	var leftResourceGroupTree = new Tree({
		id : "LeftResourceGroupTree"
	});
	var rightResourceGroupTree = new Tree({
		id : "RightResourceGroupTree"
	});
	$('#resGroup-turn-right').click(function(){
		moveNodes(leftResourceGroupTree,rightResourceGroupTree);
		
	});
	$('#resGroup-turn-left').click(function(){
		moveNodes(rightResourceGroupTree,leftResourceGroupTree);
	});
	
});

function moveNodes(fromTree,toTree){
	var rootNode = fromTree.getNodeById('selectAll');
	var nodes = rootNode.getCheckedNodes(true);
	$.each(nodes,function(i,e){
			var toTreeHead = toTree.getNodeById('selectAll');
			toTreeHead.appendChild({
				nodeId:e.getId(),
				text:e.getText(),
				isCheckBox:true,
				isClick:false,
				isLeaf:true
			});
			e.delNode();
	});
	rootNode.clearChecked();
};
treeTrim();
function treeTrim(){
	 $('#LeftResourceGroupTree li').css('word-wrap','normal');
	 $("#LeftResourceGroupTree span[type='text']").each(
	   function() {
	    var text = $(this).text();
	    $(this).empty();
	    $(this).append("<span STYLE='width:200px;overflow: hidden; text-overflow:ellipsis;display: inline-block;white-space:nowrap;' title='" + text + "'>" + text + "</span>");
	   }
	  );
}

var pageObj = document.getElementById("contentDIV2");
var pHeight = pageObj.offsetHeight;
parent.setBodyHeight(pHeight);
</script>