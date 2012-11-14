/*
* Componet Name: JDynamicTreeview
* Author: qiaozheng
* Version: 1.2
* Date: 2011.04
* Desc: 树形结构组件
*/
/*
	The TreeNode Structure
	<ul style="float:left">
		<li nodeID="" parentNodeID="" isDataNode="">
			<div expandableMarked="true"></div>
			<nobr>
				<div elID="preElContainer" style="display:inline"><img/><img/></div>
				<span elID="jdyTreeNodeLabel">label name</span>
				<div elID="lastElContainer" style="display:inline"><img/></div>
			</nobr>
			<div jTreeUserDataArea="true"/>
		</li>
	</ul>
*/

function default_JDynamicTreeview_DomStruFn(conf){
	
	this.treeSettings = $.extend({
		id: "jDynamicTreeview-1",
		lineStyle: "defaulttree",
		labelOverWidth:"", //树形节点文本显示区域宽度(超出部分将显示为...)
		animated: "", // 动画效果speed("slow", "normal", "fast", or number)
		collapsed: true, //是否折叠起所有子节点
		unique: false //同一层次只允许展开一个
	},conf||{});
	
	this.treeObject = $('<ul id="'+this.treeSettings.id+'" style="float:left"/>');
	this.treeObject.addClass(this.treeSettings.lineStyle);
	this.treeObject.addClass("treeview");
	
	var treeObjectTemp = this.treeObject;
	var treeSettingsTemp = this.treeSettings;
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
			$prevAllLastExpandableNode.find('>nobr>div[expandableMarked]').removeClass("lastExpandable-hitarea").addClass("expandable-hitarea");
		}

		$liNode.addClass("last");
		
		// add click listener
		if(clickCallFunc != null && clickCallFunc != ""){
			$liNode.find('span[elID="jdyTreeNodeLabel"]').hover(function(){
				$(this).addClass('hover');
			}, function(){
				$(this).removeClass('hover');
			});
		}
		$liNode.find('span[elID="jdyTreeNodeLabel"]').click(function(event){
			var $this = $(this);
			if(nodeSelected){
				var $oldSelected = treeObjectTemp.find('li span[elID="jdyTreeNodeLabel"]').filter('[selected="true"]');
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
				paramMap["parentNodeID"] = nodeInfo.parentNodeID;
				//paramMap["imgPath"] = nodeInfo.imgPath;
				clickCallFunc(paramMap);
			}
			
			event.stopPropagation();
			return null;
		});
	}
	/**
	 * param String nodeID
	 * param jqueryObject $liTemp 当前node
	 */
	this.moveSubNodeToNode = function(nodeID, $liTemp){
		
		//判断这个节点下有没有子节点 
		var $subNodes = treeObjectTemp.find(">li[parentNodeID='"+nodeID+"']");
		if($subNodes.size() > 0){
			//创建父节点的ul(子节点节后元素)
			var $subULTemp = $('<ul/>');
			$subULTemp.css("overflow", "hidden");
			$subULTemp.hide();
			$subNodes.each(function(cnt){
				$subULTemp.append($(this));
			});

			var $lastLiTemp = $subULTemp.find(">li:last");
			if($lastLiTemp.hasClass("expandable")){
				$lastLiTemp.removeClass("expandable").addClass("lastExpandable");
				$lastLiTemp.find('>nobr>div[expandableMarked]').removeClass("expandable-hitarea").addClass("lastExpandable-hitarea");
			}
			if($lastLiTemp.hasClass("lastExpandable") == false){
				$lastLiTemp.addClass("last");
			}
			$liTemp.append($subULTemp);
		}

		if($subNodes.size() > 0){
			// 如果这个节点是节点集合中同层节点的最后一个节点，则修改节点显示样式(将图标样式改为lastExpandable<包含子节点>+号样式)
			if($liTemp.hasClass('last')){
				$liTemp.removeClass('last').addClass("lastExpandable");
				$liTemp.find('>nobr>div[expandableMarked]').addClass("hitarea lastExpandable-hitarea");
			}else{
				$liTemp.addClass("expandable");
				$liTemp.find('>nobr>div[expandableMarked]').addClass("hitarea expandable-hitarea");
			}

			//为节点div元素添加click事件
			$liTemp.find('>nobr>div[expandableMarked]').toggle(function(event){
				var $thisLiDiv = $(this);
				var $thisLi = $thisLiDiv.parent('nobr').parent();
				
				//设置treeview组件 div横向滚动条
				//treeObjectTemp.parent().css({overflowX:"scroll",width:"200px"});
				
				//判断是否同级节点只允许展开一个
				if(treeSettingsTemp.unique == true && treeSettingsTemp.collapsed == true){
					var $expandableLiOld = $thisLi.parent().find('>li.collapsable');
					if($expandableLiOld.size() > 0){
						$expandableLiOld.find('>nobr>div[expandableMarked]').click();
					}
					$expandableLiOld = $thisLi.parent().find('>li.lastCollapsable');
					if($expandableLiOld.size() > 0){
						$expandableLiOld.find('>nobr>div[expandableMarked]').click();
					}
				}

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
				
				//判断是否添加动画效果
				if(treeSettingsTemp.animated != null && treeSettingsTemp.animated != ""){
					$thisLi.find('>ul').slideDown(treeSettingsTemp.animated);
				}else{
					$thisLi.find('>ul').show();
				}

				event.stopPropagation();
				return null;
			}, function(event){
				var $thisLiDiv = $(this);
				var $thisLi = $thisLiDiv.parent('nobr').parent();

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
				
				//折起该节点下面,所有处于展开的节点
				$thisLi.find('>ul li.collapsable>nobr>div[expandableMarked],>ul li.lastCollapsable>nobr>div[expandableMarked]').click();
				if(treeSettingsTemp.animated != null && treeSettingsTemp.animated != ""){
					$thisLi.find('>ul').slideUp(treeSettingsTemp.animated);
				}else{
					$thisLi.find('>ul').hide();
				}

				event.stopPropagation();
				return null;
			});
		}
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
			globalObj.treeObject.find('li>nobr>div[expandableMarked]').click();
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
			globalObj.treeObject.find('li>nobr>div[expandableMarked]').click();
			settings.animated = tempAnimated;
		}
		return globalObj.treeObject.get(0);
	}
	/**
	*统计各级包含的子节点个数
	*
	*/
	this.calcCount = function(){
		var $liNode = globalObj.treeObject.find('li');
		$liNode.each(function(cnt){
			var $this = $(this);
			var $subLiNode = $this.find('li[isDataNode="true"]');
			var totalCount = $subLiNode.size();
			if($this.attr("isDataNode") != "true"){
				$this.attr("subCount", totalCount);
				$this.find('span[elID="jdyTreeNodeLabel"]').text($this.find('span[elID="jdyTreeNodeLabel"]').text()+"("+totalCount+")");
			}
		});
	}
	/**
	*统计各级包含的子节点个数
	*
	*/
	this.loadSubCount = function(){
		var $liNode = globalObj.treeObject.find('li');
		$liNode.each(function(cnt){
			var $this = $(this);
			var subCount = $this.find('li[isDataNode="true"]').size();
			if($this.attr("isDataNode") != "true"){
				$this.attr("subCount", subCount);
				$this.find('span[elID="jdyTreeNodeLabel"]').text($this.find('span[elID="jdyTreeNodeLabel"]').text()+"("+subCount+")");
			}
		});
	}
	/**
	 * 获取当前树节点包含的subCount总数
	 * return int 
	 */
	this.getTotalCount = function(){
		var $firstLevelLiNode = globalObj.treeObject.find('>li');
		var totalCount = 0;
		$firstLevelLiNode.each(function(cnt){
			var $this = $(this);
			var tempCount = $this.attr("subCount");
			if(tempCount != null 
					&& tempCount != "" 
				&& tempCount != "undefined"){
				totalCount = totalCount*1+tempCount*1;
			}
		});
		return totalCount;
	}
	/**
	 * 添加树组件节点内容
	 * param JSONObject nodeInfo(nodeID, label, parentNodeID, isDataNode, imgPath)
	 * param boolean nodeSelected 是否添加node选中效果
	 * param JSONObject userData (用户数据对象)
	 * param Array preElArray (节点前面插件集合)
	 * param Array lastElArray (节点后面插件集合)
	 * param Object clickCallFunc 点击节点触发的事件监听器函数
	 * 
	 * return Element 返回新添加的node
	 */
	this.addTreeNode = function(nodeInfo, nodeSelected, userData, preElArray, lastElArray, clickCallFunc){
		var $liTemp = null;
		
		var $userDataDiv = $('<div jTreeUserDataArea="true"/>');
		$userDataDiv.hide();
		if(userData != null && userData != ""){
			for(var key in userData){
				$userDataDiv.attr(key, userData[key]);
			}
		}
		//var imgPath = nodeInfo["imgPath"];
		var $preElContainer = $('<div elID="preElContainer" style="display:inline"/>');
		if(preElArray != null && preElArray.length > 0){
			for(var preCnt=0; preCnt<preElArray.length; preCnt++){
				$preElContainer.append(preElArray[preCnt]);
				//$preElContainer.append('&nbsp;');
			}
		}
		var $lastElContainer = $('<div elID="lastElContainer" style="display:inline"/>');
		if(lastElArray != null && lastElArray.length > 0){
			for(var lastCnt=0; lastCnt<lastElArray.length; lastCnt++){
				//$lastElContainer.append('&nbsp;');
				$lastElContainer.append(lastElArray[lastCnt]);
			}
		}
		var $parent_li_node = globalObj.treeObject.find('li[nodeID="'+nodeInfo.parentNodeID+'"]');
		if($parent_li_node.size() > 0){
			var $parent_li_ul = $parent_li_node.find('>ul');
			if($parent_li_ul.size() > 0){
					$liTemp = $('<li class="nodeli" nodeID="'+nodeInfo.nodeID+'" parentNodeID="'+nodeInfo.parentNodeID+'" isDataNode="'+nodeInfo["isDataNode"]+'"/>');
					//$liTemp.append('<div expandableMarked="true"/>');
					/*
					if(imgPath != null && imgPath != ""){
						$liTemp.append('<img src="'+imgPath+'" border="0" align="bottom" width="15px" height="14px"/>&nbsp;');
					}
					*/
					var $liNobr = $('<nobr></nobr>');
					$liNobr.append('<div expandableMarked="true"/>');
					$liNobr.append($preElContainer);
					
					//add one line
					//$liTemp.append('<span>'+nodeInfo.label+'</span>');
					if(nodeInfo["isDataNode"] == "true" 
						|| nodeInfo["isDataNode"] == true){
						//判断用户是否设置了节点名称超出显示范围值
						if(settings.labelOverWidth != ""){
							$liNobr.append('<span elID="jdyTreeNodeLabel">'+nodeInfo.label+'</span>');
						}else{
							$liNobr.append('<span elID="jdyTreeNodeLabel">'+nodeInfo.label+'</span>');
						}
					}else{
						$liNobr.append('<span elID="jdyTreeNodeLabel">'+nodeInfo.label+'</span>');
					}
					$liNobr.append($lastElContainer);

					$liTemp.append($liNobr);
					$liTemp.append($userDataDiv);
			
					$parent_li_ul.append($liTemp);
					globalObj.setLiNode($liTemp, nodeInfo, nodeSelected, userData, clickCallFunc);
					//将之前属于这个节点的子节点，移动到这个节点下
					globalObj.moveSubNodeToNode(nodeInfo.nodeID, $liTemp);
			}else{
				var $ulTemp = $('<ul></ul>');
				$ulTemp.css("overflow", "hidden");

				$liTemp = $('<li class="nodeli" nodeID="'+nodeInfo.nodeID+'"  parentNodeID="'+nodeInfo.parentNodeID+'" isDataNode="'+nodeInfo["isDataNode"]+'"/>');
				$liTemp.addClass("last");
				
				//$liTemp.append('<div expandableMarked="true"/>');
				/*
				if(imgPath != null && imgPath != ""){
					$liTemp.append('<img src="'+imgPath+'" border="0" align="bottom" width="15px" height="14px"/>&nbsp;');
				}
				*/
				var $liNobr = $('<nobr></nobr>');
				$liNobr.append('<div expandableMarked="true"/>');
				$liNobr.append($preElContainer);
				//add one line
				//$liTemp.append('<span>'+nodeInfo.label+'</span>');
				if(nodeInfo["isDataNode"] == "true" 
					|| nodeInfo["isDataNode"] == true){
					//判断用户是否设置了节点名称超出显示范围值
					if(settings.labelOverWidth != ""){
						$liNobr.append('<span elID="jdyTreeNodeLabel">'+nodeInfo.label+'</span>');
					}else{
						$liNobr.append('<span elID="jdyTreeNodeLabel">'+nodeInfo.label+'</span>');
					}
				}else{
					$liNobr.append('<span elID="jdyTreeNodeLabel">'+nodeInfo.label+'</span>');
				}
				$liNobr.append($lastElContainer);

				$liTemp.append($liNobr);
				$liTemp.append($userDataDiv);
				
				$ulTemp.append($liTemp);
				$ulTemp.hide();
				
				//将之前属于这个节点的子节点，移动到这个节点下
				globalObj.moveSubNodeToNode(nodeInfo.nodeID, $liTemp);
				
				// add click listener
				if(clickCallFunc != null && clickCallFunc != ""){
					$liTemp.find('span[elID="jdyTreeNodeLabel"]').hover(function(){
						$(this).addClass('hover');
					}, function(){
						$(this).removeClass('hover');
					});
				}
				$liTemp.find('span[elID="jdyTreeNodeLabel"]').click(function(event){
					var $this = $(this);
					if(nodeSelected){
						var $oldSelected = globalObj.treeObject.find('li span[elID="jdyTreeNodeLabel"]').filter('[selected="true"]');
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
						paramMap["parentNodeID"] = nodeInfo.parentNodeID;
						//paramMap["imgPath"] = nodeInfo.imgPath;
						clickCallFunc(paramMap);
					}
					
					event.stopPropagation();
					return null;
				});
//=================================================================================================================
				$parent_li_node.append($ulTemp);
				/*
				$parent_li_node.find('span[elID="jdyTreeNodeLabel"]').hover(function(){
					$(this).addClass('hover');
				}, function(){
					$(this).removeClass('hover');
				});
				*/
				
				if($parent_li_node.hasClass('last')){
					$parent_li_node.removeClass('last').addClass("lastExpandable");
					$parent_li_node.find('>nobr>div[expandableMarked]').addClass("hitarea lastExpandable-hitarea");
				}else{
					$parent_li_node.addClass("expandable");
					$parent_li_node.find('>nobr>div[expandableMarked]').addClass("hitarea expandable-hitarea");
				}

				$parent_li_node.find('>nobr>div[expandableMarked]').toggle(function(event){
					var $thisLiDiv = $(this);
					var $thisLi = $thisLiDiv.parent('nobr').parent();
					
					if(settings.unique == true && settings.collapsed == true){
						var $expandableLiOld = $thisLi.parent().find('>li.collapsable');
						if($expandableLiOld.size() > 0){
							$expandableLiOld.find('>nobr>div[expandableMarked]').click();
						}
						$expandableLiOld = $thisLi.parent().find('>li.lastCollapsable');
						if($expandableLiOld.size() > 0){
							$expandableLiOld.find('>nobr>div[expandableMarked]').click();
						}
					}

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
					var $thisLiDiv = $(this);
					var $thisLi = $thisLiDiv.parent('nobr').parent();

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
					//折起该节点下面,所有处于展开的节点
					$thisLi.find('>ul li.collapsable>nobr>div[expandableMarked],>ul li.lastCollapsable>nobr>div[expandableMarked]').click();
					if(settings.animated != null && settings.animated != ""){
						$thisLi.find('>ul').slideUp(settings.animated);
					}else{
						$thisLi.find('>ul').hide();
					}

					event.stopPropagation();
					return null;
				});				
			}
		}else{
			$liTemp = $('<li class="nodeli" nodeID="'+nodeInfo.nodeID+'" parentNodeID="'+nodeInfo.parentNodeID+'" isDataNode="'+nodeInfo["isDataNode"]+'"/>');
			//$liTemp.append('<div expandableMarked="true"/>');
			/*
			if(imgPath != null && imgPath != ""){
				$liTemp.append('<img src="'+imgPath+'" border="0" align="bottom" width="15px" height="14px"/>&nbsp;');
			}
			*/
			var $liNobr = $('<nobr></nobr>');
			$liNobr.append('<div expandableMarked="true"/>');
			$liNobr.append($preElContainer);
			//add one line
			//$liTemp.append('<span>'+nodeInfo.label+'</span>');
			if(nodeInfo["isDataNode"] == "true" 
					|| nodeInfo["isDataNode"] == true){
				//判断用户是否设置了节点名称超出显示范围值
				if(settings.labelOverWidth != ""){
					$liNobr.append('<span elID="jdyTreeNodeLabel">'+nodeInfo.label+'</span>');
				}else{
					$liNobr.append('<span elID="jdyTreeNodeLabel">'+nodeInfo.label+'</span>');
				}
			}else{
				$liNobr.append('<span elID="jdyTreeNodeLabel">'+nodeInfo.label+'</span>');
			}
			$liNobr.append($lastElContainer);

			$liTemp.append($liNobr);
			$liTemp.append($userDataDiv);
			
			globalObj.treeObject.append($liTemp);
			globalObj.setLiNode($liTemp, nodeInfo, nodeSelected, userData, clickCallFunc);
			
			//将之前属于这个节点的子节点，移动到这个节点下
			globalObj.moveSubNodeToNode(nodeInfo.nodeID, $liTemp);
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
	 * 设置所有TreeNode是否可用
	 * param boolean state
	 */
	this.setAllNodesDisabled = function(state){
		var $treeNode_lis = globalObj.treeObject.find('*');
		$treeNode_lis.attr("disabled", state);
	}
	/**
	 * 注册节点 点击事件监听器
	 * param String nodeID 事件源nodeID
	 * param boolean nodeSelected 是否添加node选中效果
	 * param function func 事件监听函数
	 */
	this.addNodeClick = function(nodeID, nodeSelected, clickCallFunc){
		var $liNodeSpan = globalObj.treeObject.find('li[nodeID="'+nodeID+'"] span[elID="jdyTreeNodeLabel"]:first');

		$liNodeSpan.hover(function(){
			$(this).addClass('hover');
		}, function(){
			$(this).removeClass('hover');
		});

		$liNodeSpan.bind("click", function(){
			var $this = $(this);
			
			if(nodeSelected){
				var $oldSelected = globalObj.treeObject.find('li span[elID="jdyTreeNodeLabel"]:first').filter('[selected="true"]');
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
	/**
	* 注册点击所有节点时，触发的事件监听器
	* param function clickCallFunc
	*
	*/
	this.allNodeClick = function(clickCallFunc){
		var $liNodeSpan = globalObj.treeObject.find('li[nodeID] span[elID="jdyTreeNodeLabel"]');
		$liNodeSpan.bind("click", function(){
			var $this = $(this);
			if(clickCallFunc != null && clickCallFunc != ""){
				clickCallFunc();
			}
		});
	}
	/**
	* 注册点击所有折叠项时，触发的事件监听器
	* param function clickCallFunc
	*
	*/
	this.allExpanseNode = function(clickCallFunc){
		var $liExpandableMarkedDiv = globalObj.treeObject.find('li[nodeID]>nobr>div[expandableMarked]');
		$liExpandableMarkedDiv.bind("click", function(){
			var $this = $(this);
			if(clickCallFunc != null && clickCallFunc != ""){
				clickCallFunc();
			}
		});
	}
	/**
	 * 触发点击事件监听器
	 * param String nodeID 事件源nodeID
	 */
	this.nodeClick = function(nodeID){
		var $liNodeSpan = globalObj.treeObject.find('li[nodeID="'+nodeID+'"] span[elID="jdyTreeNodeLabel"]');
		$liNodeSpan.click();
	}
	
	this.setAvailWidth = function(width){
		globalObj.treeObject.css("width", width);
	}
	/**
	* 展开某个节点
	* param String nodeID 节点id
	* param boolean unique 同层是否只允许展开一个节点
	* param function clickCallFunc 节点展开后回调的函数(无回调时,传递null)
	*/
	this.expanseNode = function(nodeID, unique, nodeSelected, clickCallFunc){
		var $liNode = globalObj.treeObject.find('li[nodeID="'+nodeID+'"]');
		var $liExpandableMarkedDiv = $liNode.find('>nobr>div[expandableMarked]');
	
		if(unique == true){
			var $expandableLiOld = $liNode.parent().find('>li.collapsable');
			if($expandableLiOld.size() > 0){
				$expandableLiOld.find('>nobr>div[expandableMarked]').click();
			}
			$expandableLiOld = $liNode.parent().find('>li.lastCollapsable');
			if($expandableLiOld.size() > 0){
				$expandableLiOld.find('>nobr>div[expandableMarked]').click();
			}
		}

		$liExpandableMarkedDiv.click();
		
		if(nodeSelected){
			var $oldSelected = globalObj.treeObject.find('li span[elID="jdyTreeNodeLabel"]').filter('[selected="true"]');
			$oldSelected.attr("selected", "false");
			$oldSelected.removeClass("selectednode");
			
			var $liNodeSpan = $liNode.find('span[elID="jdyTreeNodeLabel"]:first');
			$liNodeSpan.attr("selected", "true");
			$liNodeSpan.addClass("selectednode");
		}

		if(clickCallFunc != null && clickCallFunc != ""){
			var $liNodeSpan = $liNode.find('span[elID="jdyTreeNodeLabel"]:first');
			var paramMap = {};
			paramMap["nodeID"] = nodeID;
			paramMap["label"] = $liNodeSpan.text();
			clickCallFunc(paramMap);
		}
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