/*
* Componet Name: JDynamicVerticalToolbar
* Author: qiaozheng
* Version: 1.0
* Date: 2010.11
* Desc: 动态创建垂直工具条组件
*/
function default_JDynamicVerticalToolbar_DomStruFn(conf){
	
	this.vToolbarSettings = $.extend({
		id: "jVerticalToolbar-1",
		height: "100%"
	}, conf||{});
	
	
	this.panelObj = $('<div id="'+this.vToolbarSettings.id+'"><ul/></div>');
	this.panelObj.addClass("service-tool");
	this.panelObj.css("height", this.vToolbarSettings.height);
	
}

function default_JDynamicVerticalToolbar_DomCtrlFn(conf){
	
}
function defatule_JDynamicVerticalToolbar_ComponetFn(conf){
	var globalObj = this;
	var settings = globalObj.vToolbarSettings;
	
	/**
	 * 将组件添加到容器元素中
	 * param Object container 组件所属容器元素(参数：Element,jquery包装器)
	 */
	this.appendToContainer = function(container){
		globalObj.panelObj.appendTo(container);
		return globalObj.panelObj.get(0);
	}
	/**
	 * 获取组件句柄根元素
	 * return Element
	 */
	this.getComponetHandle = function(){
		return globalObj.panelObj.get(0);
	}
	
	/**
	 * 添加ToolItem页签
	 * param JSONObject itemInfo(itemID, title, className)
	 * param JSONObject userData (用户数据对象)
	 * param function clickCallFunc (点击工具按钮回调函数)
	 * return Element (返回新添加的Item)
	 */
	this.addItem = function(itemInfo, userData, clickCallFunc){
		var $userDataDiv = $('<div jVToolbar="true"/>');
		$userDataDiv.hide();
		if(userData != null && userData != ""){
			for(var key in userData){
				$userDataDiv.attr(key, userData[key]);
			}
		}

		var $item = $('<li itemID="'+itemInfo["itemID"]+'"><span elID="jVToolbarLocalPanel"/></li>');
		var $itemLocalPanel= $item.find(">span[elID='jVToolbarLocalPanel']");
		$itemLocalPanel.addClass("normal");
		
		var $itemLocal = $('<span elID="jVToolbarLocal"/>');
		$itemLocal.addClass("service-tool-ico");
		$itemLocal.addClass(itemInfo["className"]);
		$itemLocal.attr("title", itemInfo["title"]);
		
		$itemLocalPanel.append($itemLocal);
		$item.append($userDataDiv);
		globalObj.panelObj.find(">ul").append($item);
		
		$item.click(function(event){
			globalObj.panelObj.find(">ul>li>span.on").removeClass("on");
			$(this).find(">span[elID='jVToolbarLocalPanel']").addClass("on");
			
			if(clickCallFunc != null && clickCallFunc != ""){
				var paramMap = {};
				if(userData != null && userData != ""){
					for(var key in userData){
						paramMap[key] = userData[key];
					}
				}
				paramMap["itemID"] = itemInfo["itemID"];
				paramMap["title"] = itemInfo["title"];
				paramMap["className"] = itemInfo["className"];
				
				clickCallFunc(paramMap);
				
				event.stopPropagation();
				return null;
			}
		});
		return $item.get(0);
	}
	/**
	 * 获取某个用户数据属性值
	 * param String itemID
	 * param String attributeName
	 * return string
	 */
	this.getUserData = function(itemID, attributeName){
		var $userDataObj = globalObj.panelObj.find(">ul>li[itemID='"+itemID+"']>div[jVToolbar='true']");
		return $userDataObj.attr(attributeName);
	}
	/**
	 * 设置工具选项是否可用
	 * param String itemID
	 * param boolean state
	 */
	this.setItemDisabled = function(itemID, state){
		var $item_li = globalObj.panelObj.find(">ul>li[itemID='"+itemID+"']");
		$item_li.attr("disabled", state);
	}
	
	/**
	 * 设置所有工具选项是否可用
	 * param boolean state
	 */
	this.setAllItemsDisabled = function(state){
		var $item_lis = globalObj.panelObj.find(">ul>li[itemID]");
		$item_lis.attr("disabled", state);
	}
	/**
	 * 按下某个工具选项
	 * param String itemID
	 */
	this.pressItem = function(itemID){
		var $item = globalObj.panelObj.find(">ul>li[itemID='"+itemID+"']");
		$item.click();
	}
}

 var JDynamicVerticalToolbar = function(){
  function innerJDynamicVerticalToolbar(conf, cfncconf){
	cfncconf = cfncconf ? cfncconf :{};
	$.extend(conf, cfncconf);
	this.init(conf, {domStru: "default_JDynamicVerticalToolbar_DomStruFn",
					domCtrl: "default_JDynamicVerticalToolbar_DomCtrlFn",
					compFn: "defatule_JDynamicVerticalToolbar_ComponetFn"
				  });    
  }
  
  CFNC.registDomStruFn("default_JDynamicVerticalToolbar_DomStruFn", default_JDynamicVerticalToolbar_DomStruFn);
  CFNC.registDomCtrlFn("default_JDynamicVerticalToolbar_DomCtrlFn", default_JDynamicVerticalToolbar_DomCtrlFn);
  CFNC.registComponetFn("defatule_JDynamicVerticalToolbar_ComponetFn", defatule_JDynamicVerticalToolbar_ComponetFn);
  
  return innerJDynamicVerticalToolbar;
 }();

$.apply(JDynamicVerticalToolbar, Componet);