var isFirstVisit = true;
$(function() {
  var tree = new Tree({id:metricTreeId,currentColor:"#FF0",color:"#FFF",listeners:{
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
  //默认选中第一个节点
  var root = tree.getRoot();
  var node = root.getFirstChild();
  node.click();
  tree.setCurrentNode(node.getId());
  isFirstVisit = false;
  // 把手型去掉。。。
  $("#metricTreeId span[type=ico]").each(function(){
    this.style.cursor = 'default';
  });
}); // end ready
