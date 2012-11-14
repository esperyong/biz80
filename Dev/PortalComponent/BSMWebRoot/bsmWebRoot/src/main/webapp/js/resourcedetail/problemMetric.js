var isFirstVisit = true;// 是否第一次访问，第一次访问需要控制loading效果
$(function() {
	//问题关键指标树
	var metricTree = null;
	if(hasMetricTree){
    metricTree = new Tree({id:metricTreeId,currentColor:"#FF0",color:"#FFF",listeners:{
      nodeClick:function(node){
        if(!isFirstVisit){
          $.blockUI({message:$('#loading')});
        }
        var url = node.getValue("url");
        $.loadPage("metricview",path + url,"POST",{instanceId:instanceId},function(){
          //根据最新状态更改指标节点的图标
          var $stateSpan = $("#stateSpan");
          if($stateSpan){
            var className = $stateSpan.attr("class");
            if(className){
              node.setIco(className);
            }
          }
          $.unblockUI();
        }); 
      }
    }});
	}
  //问题组件树
	var compTree = null;
	if(hasCompTree){
    compTree = new Tree({id:comonentTreeId,currentColor:"#FF0",color:"#FFF",listeners:{
      nodeClick:function(node){
        if(!isFirstVisit){
          $.blockUI({message:$('#loading')});
        }
        var url = node.getValue("url");
        $.loadPage("metricview",path + url,"POST",{parentInstanceId:instanceId},function(){
          //根据最新状态更改指标节点的图标
          var $stateSpan = $("#stateSpan");
          if($stateSpan){
            var className = $stateSpan.attr("class");
            if(className){
              node.setIco(className);
            }
          }
          $.unblockUI();
        }); 
      }
    }});
	}
  //默认选中第一个节点
  if(metricTree){
    clickFirstNode(metricTree);
  }else if(compTree){
    clickFirstNode(compTree);
  }
  isFirstVisit = false;
  //问题关键指标
  if($("#problemMericP")){
    $("#problemMericP").bind("click",function(){
      var $metricP = $(this);
      var $componentP = $("#problemComponentP");
      var $compTreeContentDiv = $("#compTreeContentDiv");
      var $metricTreeContentDiv = $("#metricTreeContentDiv");
      $compTreeContentDiv.hide();
      $metricTreeContentDiv.show();
      $compTreeContentDiv.after($componentP);
      clickFirstNode(metricTree);
    });
  }
  //问题组件
  if($("#problemComponentP")){
    $("#problemComponentP").bind("click",function(){
      var $componentP = $(this);
      var $metricP = $("#problemMericP");
      var $compTreeContentDiv = $("#compTreeContentDiv");
      var $metricTreeContentDiv = $("#metricTreeContentDiv");
      $compTreeContentDiv.show();
      $metricTreeContentDiv.hide();
      $metricP.after($componentP);
      clickFirstNode(compTree);
    });
  }
  // 把手型去掉。。。
  $("#metricTreeId span[type=ico],#comonentTreeId span[type=ico]").each(function(){
    this.style.cursor = 'default';
  });
}); // end ready

function clickFirstNode(tree){
  if(tree){
    var root = tree.getRoot();
    var firstLeafNode = getFirstLeafNode(root);
    if(firstLeafNode){
      firstLeafNode.click();
      tree.setCurrentNode(firstLeafNode.getId());
    }
  }
}
//获得树的第一个叶子节点
function getFirstLeafNode(node){
  if(node.isLeaf()){
    return node;
  }
  var childNode = node.getFirstChild();
  return getFirstLeafNode(childNode);
}