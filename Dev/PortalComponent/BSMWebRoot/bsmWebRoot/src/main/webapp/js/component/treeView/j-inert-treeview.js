/*
* Componet Name: JInertTreeview
* Author: qiaozheng
* Version: 1.0
* Date: 2010.10
* Desc: 惰性加载树形结构组件
*/
function default_JInertTreeview_DomStruFn(conf){
	
	this.treeSettings = $.extend({
		id: "jInertTreeview-1",
		lineStyle: "defaulttree",
		animated: "", // 动画效果speed("slow", "normal", "fast", or number)
		collapsed: true, //是否折叠起所有子节点
		unique: false, //同一层次只允许展开一个
		loadedOnlyOnce: true //是否子节点只加载一次数据
	},conf||{});
	
	this.treeObject = $('<ul id="'+this.treeSettings.id+'"/>');
	this.treeObject.addClass(this.treeSettings.lineStyle);
	this.treeObject.addClass("treeview");

}

function default_JInertTreeview_DomCtrlFn(conf){
	
}
function defatule_JInertTreeview_ComponetFn(conf){
	var globalObj = this;
	var settings = globalObj.treeSettings;
	
	/**
	 * 将组件添加到容器元素中
	 * param Object container 组件所属容器元素(参数：Element,jquery包装器)
	 */
	this.appendToContainer = function(container){
		globalObj.treeObject.appendTo(container);
		return globalObj.treeObject.get(0);
	}
	/**
	 * 获取组件句柄根元素
	 * return Element
	 */
	this.getComponetHandle = function(){
		return globalObj.treeObject.get(0);
	}
	/**
	 * 加载组件叶子节点
	 * param JSONObject nodeInfo（nodeID, label, parentNodeID)
	 * param boolean nodeSelected 是否添加node选中效果
	 * param JSONObject userData (用户数据对象)
	 * param Object clickCallFunc 点击节点触发的事件监听器函数
	 * return Element 返回新添加的node
	 */
	this.loadLeafNode = function(nodeInfo, nodeSelected, userData, clickCallFunc){
		var $liTemp = null;
		var $userDataDiv = $('<div jInertTreeUserDataArea="true"/>');
		$userDataDiv.hide();
		if(userData != null && userData != ""){
			for(var key in userData){
				$userDataDiv.attr(key, userData[key]);
			}
		}
		
		var $parent_li_node = globalObj.treeObject.find('li[nodeID="'+nodeInfo.parentNodeID+'"]');
		if($parent_li_node.size() > 0){
			var $parent_li_ul = $parent_li_node.find('>ul');
			if($parent_li_ul.size() > 0){
				$liTemp = $('<li nodeID="'+nodeInfo.nodeID+'"><div></div><span>'+nodeInfo.label+'</span></li>');
				
				$liTemp.append($userDataDiv);
				
				$parent_li_ul.append($liTemp);
			}
		}else{
			$liTemp = $('<li nodeID="'+nodeInfo.nodeID+'"><div></div><span>'+nodeInfo.label+'</span></li>');
			
			$liTemp.append($userDataDiv);
			
			globalObj.treeObject.append($liTemp);

		}
		var $prevAllLastLiNode = $liTemp.prevAll('li.last');
		if($prevAllLastLiNode.size() > 0){
			$prevAllLastLiNode.removeClass("last");
		}
		var $prevAllLastExpandableNode = $liTemp.prevAll("li.lastExpandable");
		if($prevAllLastExpandableNode.size() > 0){
			$prevAllLastExpandableNode.removeClass("lastExpandable").addClass("expandable");
			$prevAllLastExpandableNode.find('>div').removeClass("lastExpandable-hitarea").addClass("expandable-hitarea");
		}
		$liTemp.addClass("last");
		if(clickCallFunc != null && clickCallFunc != ""){
			$liTemp.find('>span').hover(function(){
				$(this).addClass('hover');
			}, function(){
				$(this).removeClass('hover');
			});
		}

		$liTemp.find('>span').click(function(event){
			var $this = $(this);
			if(nodeSelected){
				var $oldSelected = globalObj.treeObject.find("li>span[selected='true']");
				$oldSelected.attr("selected", "false");
				$oldSelected.removeClass("selectednode");
				
				$this.attr("selected", "true");
				$this.addClass("selectednode");
			}
			
			if(clickCallFunc != null && clickCallFunc != ""){
				var paramMap = {};
				if(userData != null && userData != ""){
					for(var key in userData){
						paramMap[key] = userData[key];
					}
				}
				paramMap["nodeID"] = nodeInfo.nodeID;
				paramMap["label"] = nodeInfo.label;
				clickCallFunc(paramMap);
			}
			
			event.stopPropagation();
			return null;
		});
		

		if($liTemp != null){
			return $liTemp.get(0);
		}else{
			return null;
		}
	}
	/**
	 * 加载组件惰性容器节点
	 * param JSONObject nodeInfo（nodeID, label, parentNodeID, subCount)
	 * param JSONObject userData (用户数据对象)
	 * param Object loadSubNodeFunc 点击节点触发的事件监听器函数
	 * return Element 返回新添加的node
	 */
	this.loadTreeNode = function(nodeInfo, userData, loadSubNodeFunc){
		var thisObj = this;
		var $liTemp = null;
		
		var $userDataDiv = $('<div jInertTreeUserDataArea="true"/>');
		$userDataDiv.hide();
		if(userData != null && userData != ""){
			for(var key in userData){
				$userDataDiv.attr(key, userData[key]);
			}
		}
		
		var $parent_li_node = globalObj.treeObject.find('li[nodeID="'+nodeInfo.parentNodeID+'"]');
		if($parent_li_node.size() > 0){
			var $parent_li_ul = $parent_li_node.find('>ul');
			if($parent_li_ul.size() > 0){
				$liTemp = $('<li nodeID="'+nodeInfo.nodeID+'" subNodeCount="'+nodeInfo.subCount+'"><div></div><span>'+nodeInfo.label+'('+nodeInfo.subCount+')</span></li>');
				
				$liTemp.append($userDataDiv);
				
				$parent_li_ul.append($liTemp);
			}
		}else{
			$liTemp = $('<li nodeID="'+nodeInfo.nodeID+'" subNodeCount="'+nodeInfo.subCount+'"><div></div><span>'+nodeInfo.label+'('+nodeInfo.subCount+')</span></li>');
			
			$liTemp.append($userDataDiv);
			
			globalObj.treeObject.append($liTemp);
		}
		
		var $prevAllLastLiNode = $liTemp.prevAll('li.last');
		if($prevAllLastLiNode.size() > 0){
			$prevAllLastLiNode.removeClass("last");
		}
		var $prevAllLastExpandableNode = $liTemp.prevAll("li.lastExpandable");
		if($prevAllLastExpandableNode.size() > 0){
			$prevAllLastExpandableNode.removeClass("lastExpandable").addClass("expandable");
			$prevAllLastExpandableNode.find('>div').removeClass("lastExpandable-hitarea").addClass("expandable-hitarea");
		}

		if(nodeInfo.subCount > 0){
			$liTemp.addClass("lastExpandable");
			$liTemp.find('>div').addClass("hitarea lastExpandable-hitarea");

			var $ulTemp = $('<ul></ul>');
			$ulTemp.css("overflow", "hidden");
			$ulTemp.hide();

			$liTemp.append($ulTemp);

		}else{
			$liTemp.addClass("last");
		}
		
		// add click listener
		if(nodeInfo.subCount > 0){
			$liTemp.find('>span').hover(function(){
				$(this).addClass('hover');
			}, function(){
				$(this).removeClass('hover');
			});

			$liTemp.find('>span').toggle(function(event){
				var $thisLi = $(this).parent();
				
				var subNodeSize = $liTemp.find(">ul>li:first").size();
				if(settings.loadedOnlyOnce == false || subNodeSize == 0){
					if(loadSubNodeFunc != null){
						var paramMap = {};
						if(userData != null && userData != ""){
							for(var key in userData){
								paramMap[key] = userData[key];
							}
						}
						paramMap["nodeID"] = nodeInfo.nodeID;
						paramMap["label"] = nodeInfo.label;
						paramMap["subCount"] = nodeInfo.subCount;
						
						var subNodeObjArray = loadSubNodeFunc(paramMap);
						if(subNodeObjArray != null && subNodeObjArray.length > 0){
							for(var cnt=0; cnt<subNodeObjArray.length; cnt++){
								var subNode = subNodeObjArray[cnt];
								
								if(subNode["isLeaf"] || subNode["isLeaf"] == "true"){
									thisObj.loadLeafNode(subNode, subNode["nodeSelected"], subNode["userData"]
									, function(currentSubNode){return function(theNodeMap){return currentSubNode["loadSubNodeFunc"].call(currentSubNode, theNodeMap);}}(subNode));
								}else{
									thisObj.loadTreeNode(subNode, subNode["userData"]
									, function(currentSubNode){return function(theNodeMap){return currentSubNode["loadSubNodeFunc"].call(currentSubNode, theNodeMap);}}(subNode));
								}
							}
						}
					}
				}
				
				if(settings.unique == true && settings.collapsed == true){
					var $expandableLiOld = $thisLi.parent().find('>li.collapsable');
					if($expandableLiOld.size() > 0){
						$expandableLiOld.find('>span').click();
					}
					$expandableLiOld = $thisLi.parent().find('>li.lastCollapsable');
					if($expandableLiOld.size() > 0){
						$expandableLiOld.find('>span').click();
					}
				}

				var $thisLiDiv = $thisLi.find('>div');
				if($thisLiDiv.hasClass('expandable-hitarea')){
					$thisLiDiv.removeClass('expandable-hitarea');
				}else if($thisLiDiv.hasClass('lastExpandable-hitarea')){
					$thisLiDiv.removeClass('lastExpandable-hitarea').addClass('lastCollapsable-hitarea');
				}
				
				if($thisLi.hasClass('expandable')){
					$thisLi.removeClass("expandable").addClass("collapsable");
				}else if($thisLi.hasClass('lastExpandable')){
					$thisLi.removeClass("lastExpandable").addClass("lastCollapsable");
				}
				
				if(settings.animated != null && settings.animated != ""){
					$thisLi.find('>ul').slideDown(settings.animated);
				}else{
					$thisLi.find('>ul').show();
				}
				
				event.stopPropagation();
				return null;
			}, function(event){
				var $thisLi = $(this).parent();
				var $thisLiDiv = $thisLi.find('>div');
				if($thisLiDiv.hasClass('lastCollapsable-hitarea')){
					$thisLiDiv.removeClass('lastCollapsable-hitarea').addClass('lastExpandable-hitarea');
				}else{
					$thisLiDiv.addClass('expandable-hitarea');
				}
				
				if($thisLi.hasClass('collapsable')){
					$thisLi.removeClass("collapsable").addClass("expandable");
				}else if($thisLi.hasClass('lastCollapsable')){
					$thisLi.removeClass("lastCollapsable").addClass("lastExpandable");
				}
				
				$thisLi.find('>ul li.collapsable>span,>ul li.lastCollapsable>span').click();
				if(settings.animated != null && settings.animated != ""){
					$thisLi.find('>ul').slideUp(settings.animated, function(){
						if(settings.loadedOnlyOnce == false){
							$thisLi.find('>ul').empty();
						}
					});
				}else{
					$thisLi.find('>ul').hide();
					if(settings.loadedOnlyOnce == false){
						$thisLi.find('>ul').empty();
					}
				}

				event.stopPropagation();
				return null;
			});
			$liTemp.find('>div').click(function(event){
				$(this).parent().find('>span').click();
				event.stopPropagation();
				return null;
			});

		}

		if($liTemp != null){
			return $liTemp.get(0);
		}else{
			return null;
		}
	}
	/**
	 * 获取某个用户数据属性值
	 * param String nodeID
	 * param String attributeName
	 * return string
	 */
	this.getUserData = function(nodeID, attributeName){
		var $userDataObj = globalObj.treeObject.find("li[nodeID='"+nodeID+"']>div[jInertTreeUserDataArea='true']");
		return $userDataObj.attr(attributeName);
	}
}

var JInertTreeview = function(){
  function innerJInertTreeview(conf, cfncconf){
	cfncconf = cfncconf ? cfncconf :{};
	$.extend(conf, cfncconf);
	this.init(conf, {domStru: "default_JInertTreeview_DomStruFn",
					domCtrl: "default_JInertTreeview_DomCtrlFn",
					compFn: "defatule_JInertTreeview_ComponetFn"
				  });    
  }
  
  CFNC.registDomStruFn("default_JInertTreeview_DomStruFn", default_JInertTreeview_DomStruFn);
  CFNC.registDomCtrlFn("default_JInertTreeview_DomCtrlFn", default_JInertTreeview_DomCtrlFn);
  CFNC.registComponetFn("defatule_JInertTreeview_ComponetFn", defatule_JInertTreeview_ComponetFn);
  
  return innerJInertTreeview;

}();

$.apply(JInertTreeview, Componet);
