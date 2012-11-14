/*
* Componet Name: JDynamicTreeview
* Author: qiaozheng
* Version: 1.1
* Date: 2010.10
* Desc: 树形结构组件
*/
function default_JDynamicTreeview_DomStruFn(conf){
	
	this.treeSettings = $.extend({
		id: "jDynamicTreeview-1",
		lineStyle: "defaulttree",
		animated: "", // 动画效果speed("slow", "normal", "fast", or number)
		collapsed: true, //是否折叠起所有子节点
		unique: false //同一层次只允许展开一个
	},conf||{});
	
	this.treeObject = $('<ul id="'+this.treeSettings.id+'"/>');
	this.treeObject.addClass(this.treeSettings.lineStyle);
	this.treeObject.addClass("treeview");
	
	var treeObjectTemp = this.treeObject;
	/**
	* 设置节点的属性等信息
	* param Object $liNode 要操作的nodeLi对象(jquery包装器对象)
	* param JSONObject nodeInfo（nodeID, label, parentNodeID)
	* param boolean nodeSelected 是否添加node选中效果
	* param JSONObject userData (用户数据对象)
	* param Object clickCallFunc 点击节点触发的事件监听器函数
	*
	*/
	this.setLiNode = function($liNode, nodeInfo, nodeSelected, userData, clickCallFunc){

		var $prevAllLastLiNode = $liNode.prevAll('li.last');
		if($prevAllLastLiNode.size() > 0){
			$prevAllLastLiNode.removeClass("last");
		}
		var $prevAllLastExpandableNode = $liNode.prevAll("li.lastExpandable");
		if($prevAllLastExpandableNode.size() > 0){
			$prevAllLastExpandableNode.removeClass("lastExpandable").addClass("expandable");
			$prevAllLastExpandableNode.find('>div').removeClass("lastExpandable-hitarea").addClass("expandable-hitarea");
		}

		$liNode.addClass("last");
		
		// add click listener
		if(clickCallFunc != null && clickCallFunc != ""){
			$liNode.find('>span').hover(function(){
				$(this).addClass('hover');
			}, function(){
				$(this).removeClass('hover');
			});
		}
		$liNode.find('>span').click(function(event){
			var $this = $(this);
			if(nodeSelected){
				var $oldSelected = treeObjectTemp.find("li>span[selected='true']");
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
		
	}

}

function default_JDynamicTreeview_DomCtrlFn(conf){
	
}
function defatule_JDynamicTreeview_ComponetFn(conf){
	var globalObj = this;
	var settings = globalObj.treeSettings;
	
	/**
	 * 将组件添加到容器元素中
	 * param Object container 组件所属容器元素(参数：Element,jquery包装器)
	 */
	this.appendToContainer = function(container){
		if(settings.collapsed == false){
			var tempAnimated = settings.animated;
			settings.animated = "";
			globalObj.treeObject.find('li>span').click();
			settings.animated = tempAnimated;
		}
		globalObj.treeObject.appendTo(container);
		return globalObj.treeObject.get(0);
	}
	/**
	 * 获取组件句柄根元素
	 * return Element
	 */
	this.getComponetHandle = function(){
		if(settings.collapsed == false){
			var tempAnimated = settings.animated;
			settings.animated = "";
			globalObj.treeObject.find('li>span').click();
			settings.animated = tempAnimated;
		}
		return globalObj.treeObject.get(0);
	}
	/**
	 * 添加树组件节点内容
	 * param JSONObject nodeInfo（nodeID, label, parentNodeID)
	 * param boolean nodeSelected 是否添加node选中效果
	 * param JSONObject userData (用户数据对象)
	 * param Object clickCallFunc 点击节点触发的事件监听器函数
	 * 
	 * return Element 返回新添加的node
	 */
	this.addTreeNode = function(nodeInfo, nodeSelected, userData, clickCallFunc){
		var $liTemp = null;
		
		var $userDataDiv = $('<div jTreeUserDataArea="true"/>');
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
					globalObj.setLiNode($liTemp, nodeInfo, nodeSelected, userData, clickCallFunc);
			}else{
				var $ulTemp = $('<ul></ul>');
				$ulTemp.css("overflow", "hidden");

				$liTemp = $('<li nodeID="'+nodeInfo.nodeID+'"><div></div><span>'+nodeInfo.label+'</span></li>');
				$liTemp.addClass("last");
				
				$liTemp.append($userDataDiv);
				
				$ulTemp.append($liTemp);
				$ulTemp.hide();
				
				// add click listener
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
//=================================================================================================================
				$parent_li_node.append($ulTemp);
				$parent_li_node.find('>span').hover(function(){
					$(this).addClass('hover');
				}, function(){
					$(this).removeClass('hover');
				});
				
				if($parent_li_node.hasClass('last')){
					$parent_li_node.removeClass('last').addClass("lastExpandable");
					$parent_li_node.find('>div').addClass("hitarea lastExpandable-hitarea");
				}else{
					$parent_li_node.addClass("expandable");
					$parent_li_node.find('>div').addClass("hitarea expandable-hitarea");
				}

				$parent_li_node.find('>span').toggle(function(event){
					var $thisLi = $(this).parent();
					
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
						$thisLi.find('>ul').slideUp(settings.animated);
					}else{
						$thisLi.find('>ul').hide();
					}

					event.stopPropagation();
					return null;
				});
				$parent_li_node.find('>div').click(function(event){
					$(this).parent().find('>span').click();
					event.stopPropagation();
					return null;
				});
				
			}
		}else{
			$liTemp = $('<li id="li-node-'+nodeInfo.nodeID+'" nodeID="'+nodeInfo.nodeID+'"><div></div><span>'+nodeInfo.label+'</span></li>');
			$liTemp.append($userDataDiv);
			
			globalObj.treeObject.append($liTemp);
			globalObj.setLiNode($liTemp, nodeInfo, nodeSelected, userData, clickCallFunc);
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
		var $userDataObj = globalObj.treeObject.find("li[nodeID='"+nodeID+"']>div[jTreeUserDataArea='true']");
		return $userDataObj.attr(attributeName);
	}
	
	/**
	 * 注册节点 点击事件监听器
	 * param String nodeID 事件源nodeID
	 * param boolean nodeSelected 是否添加node选中效果
	 * param function func 事件监听函数
	 */
	this.nodeClick = function(nodeID, nodeSelected, clickCallFunc){
		globalObj.treeObject.find("li[nodeID='"+nodeID+"']>span").bind("click", function(){
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
				paramMap["nodeID"] = nodeID;
				paramMap["label"] = $this.text();
				clickCallFunc(paramMap);
			}
		});
	}
	
}

var JDynamicTreeview = function(){
  function innerJDynamicTreeview(conf, cfncconf){
	cfncconf = cfncconf ? cfncconf :{};
	$.extend(conf, cfncconf);
	this.init(conf, {domStru: "default_JDynamicTreeview_DomStruFn",
					domCtrl: "default_JDynamicTreeview_DomCtrlFn",
					compFn: "defatule_JDynamicTreeview_ComponetFn"
				  });    
  }
  
  CFNC.registDomStruFn("default_JDynamicTreeview_DomStruFn", default_JDynamicTreeview_DomStruFn);
  CFNC.registDomCtrlFn("default_JDynamicTreeview_DomCtrlFn", default_JDynamicTreeview_DomCtrlFn);
  CFNC.registComponetFn("defatule_JDynamicTreeview_ComponetFn", defatule_JDynamicTreeview_ComponetFn);
  
  return innerJDynamicTreeview;

}();

$.apply(JDynamicTreeview, Componet);
