<%--  
 *************************************************************************
 * @source  : index.jsp
 * @desc    : Mocha BSM 8.0
 *------------------------------------------------------------------------
 * VER  DATE         AUTHOR      DESCRIPTION
 * ---  -----------  ----------  -----------------------------------------
 * 1.0  2011.1.28	 huaf     	历史分析左侧树
 * ----------- ----------  -----------------------------------------------
 * Copyright(c) 2011 mochasoft,  All rights reserved.
 *************************************************************************
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<div class="left-panel-content" id="scriptRepository">
	<div class="location-panel-content">
		<div class="add-button1"><span title="定制视图" class="r-ico r-ico-add"></span></div>
		<div id="treeContent">
			<s:property value="leftTreeHtml" escape="false" />
		</div>
	  	<div class="clear"></div>
	</div>
</div>
<script>

var tree;
function initTree(){
	var resGroupOp = new MenuContext({x:20,y:100,width:100,listeners:{click:function(id){alert(id)}}},{menuContext_DomStruFn:"ico_menuContext_DomStruFn"});
	// 创建树
	tree = new Tree({id:"leftTree",listeners:{
	  nodeClick:function(node){
		  loadContent(node.getId());
		  $("#no").hide();
		  $("#have").show();
	  },
	  toolClick:function(node,event){
		  resGroupOp.position(event.pageX,event.pageY); 
		  if(node.getPathId().length == 1){
			  resGroupOp.addMenuItems([
         				[ 
						{ico:"edit",text : "编辑",id : "editView",listeners : {click : function() {
							 editView(node.getId(),"${analysisType}");
							 resGroupOp.hide();
						   }}},
         				  {ico:"delete",text : "删除",id : "delView",listeners : {click : function() {
         					 delView(node.getId(),"${analysisType}");
         					 resGroupOp.hide();
         				   }}}
         				 ]
         		  ]);
		  }
	  }
	  }});
	  
	//第一个树结点id
	var firstNodeId = getFirstId();
	
	if(firstNodeId){
		setCurrentNode(firstNodeId);
		treeTrim();
		$("#no").hide();
		$("#have").show();
	}
}

function setFirstNode(){
	//第一个树结点id
	var firstNodeId = getFirstId();
	if(firstNodeId){
		loadContent(firstNodeId);
	}
}

// 设置树的默认选中节点
function setCurrentNode(nodeId){
treeTrim();
	tree.getNodeById(nodeId).setCurrentNode();
}
//定制视图
$(".r-ico-add").click(function(){
	bindView("${analysisType}");
});

//如果没有视图,显示提示信息
if($("#treeContent").find("span.ico").length <= 0){
	$("#treeContent").html("");
	$("#treeContent").html('<div class="add-button2"><span>请点击 <img src="${ctx}/images/add-button1.gif" onclick="newview()" style="cursor:pointer;"> 按钮新建视图</span></div>');
	$("#no").show();
	$("#have").hide();
}
function newview(){
bindView("${analysisType}");
}
function treeTrim(){

  $('#leftTree li').css('word-wrap','normal');
  $("#leftTree span[type='text']").each(
  function() {
      var text = $(this).text();
      var width = 125;
      var bolder ="";
   var patt1 = /^m_/;
   var nodeid = $(this).parent().attr("nodeid");
   //alert($(this).parent().html())
   //alert(nodeid)
   if(nodeid && patt1.test(nodeid)){
       width = 140;
      }
      $(this).empty();
      if ($(this).parent().html().indexOf("bolder") > -1)
      {
      bolder ="bolder";
      }
      else
      {
      bolder ="normal";
      }
      $(this).append("<span STYLE='width:"+width+"px;overflow: hidden;font-weight: "+bolder+"; text-overflow:ellipsis;display: inline-block;white-space:nowrap;' title='" + text + "'>" + text + "</span>");
     }
    );
}
 $(document).ready(function(){	
   //treeTrim();
   });

</script>