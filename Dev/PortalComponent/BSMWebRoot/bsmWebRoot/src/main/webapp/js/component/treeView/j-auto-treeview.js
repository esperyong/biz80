/*
* Componet Name: JAutoTreeView
* Author: qiaozheng
* Version: 1.0
* Date: 2010.09
* Desc: 树形结构组件
*/
function default_JAutoTreeView_DomStruFn(conf){

	this.initTree = function(){
		var tree_nodes = conf.nodes;
		if(tree_nodes == null) return;

		var size = tree_nodes.length;		
		if(size > 0){
			var $treeRoot = $('body>#jquery-smart-tree');
			if($treeRoot.size() == 0){
				$('body').append('<ul id="jquery-smart-tree" class="treeview-black"></ul>');
				$treeRoot = $('body>#jquery-smart-tree');
			}
			for(var i=0; i<size; i++){
				var node = tree_nodes[i];
				if(node.level == 1){
					var $liTemp = $('<li id="li-node-'+node.id+'"><span>'+node.name+'</span></li>');
					$treeRoot.append($liTemp);
				}else{
					var $parent_li_node = $('body>#jquery-smart-tree #li-node-'+node.parentID);
					if($parent_li_node.size() > 0){
						var $parent_li_ul = $parent_li_node.find('>ul');
						if($parent_li_ul.size() == 0){
								var $ulTemp = $('<ul></ul>');
								var $liTemp = null;
								if(node.clickFunc != null){
									$liTemp = $('<li id="li-node-'+node.id+'"><span><a target="'+node.target+'">'+node.name+'</a></span></li>');
									//$liTemp.find('>span>a').bind("click", function(){});
								}else{
									$liTemp = $('<li id="li-node-'+node.id+'"><span>'+node.name+'</span></li>');
								}
								$ulTemp.append($liTemp);
								$parent_li_node.append($ulTemp);
						}else{
							var $liTemp = null;
							if(node.clickFunc != null){
								$liTemp = $('<li id="li-node-'+node.id+'"><span><a target="'+node.target+'">'+node.name+'</a></span></li>');
								//$liTemp.find('>span>a').bind("click", function(){alert(node["name"]);});
							}else{
								$liTemp = $('<li id="li-node-'+node.id+'"><span>'+node.name+'</span></li>');
							}
							$parent_li_ul.append($liTemp);
						}
					}
				}
			}
		}
		//alert($('body').html());
	}
}

function default_JAutoTreeView_DomCtrlFn(conf){
	
}
function defatule_JAutoTreeView_ComponetFn(conf){
	 var temp = this;
	 temp.initTree();
	//alert( $("#jquery-smart-tree").html());
	 $("#jquery-smart-tree").treeview({
		animated: 300,
		persist: "location",
		collapsed: true,//是否都折叠
		unique: false//同一层次只允许展开一个
	});
}

var JAutoTreeView = function(){
  function innerJAutoTree(conf,cfncconf){
	cfncconf = cfncconf ? cfncconf :{};
	$.extend(conf,cfncconf);
	this.init(conf,{domStru:cfncconf.default_JAutoTreeView_DomStruFn ? cfncconf.default_JAutoTreeView_DomStruFn  : "default_JAutoTreeView_DomStruFn",
					domCtrl:cfncconf.default_JAutoTreeView_DomCtrlFn ? cfncconf.default_JAutoTreeView_DomCtrlFn : "default_JAutoTreeView_DomCtrlFn",
					compFn:cfncconf.defatule_JAutoTreeView_ComponetFn ? cfncconf.defatule_JAutoTreeView_ComponetFn : "defatule_JAutoTreeView_ComponetFn"
				  });    
  }
  
  CFNC.registDomStruFn("default_JAutoTreeView_DomStruFn",default_JAutoTreeView_DomStruFn);
  CFNC.registDomCtrlFn("default_JAutoTreeView_DomCtrlFn",default_JAutoTreeView_DomCtrlFn);
  CFNC.registComponetFn("defatule_JAutoTreeView_ComponetFn",defatule_JAutoTreeView_ComponetFn);
  
  return innerJAutoTree;

}();

$.apply(JAutoTreeView, Componet);
