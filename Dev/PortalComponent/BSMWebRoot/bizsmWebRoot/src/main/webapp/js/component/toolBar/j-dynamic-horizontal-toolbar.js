/*
* Componet Name: JDynamicHorizontalToolbar
* Author: qiaozheng
* Version: 1.0
* Date: 2010.11
* Desc: 动态创建水平工具条组件
*
*/
function default_JDynamicHorizontalToolbar_DomStruFn(conf){
	
	this.hToolbarSettings = $.extend({
		id: "jHorizontalToolbar-1",
		showBackGround: false
	}, conf||{});

	this.panelObj = $('<div id="'+this.hToolbarSettings.id+'"></div>');

	if(this.hToolbarSettings.showBackGround){
		this.panelObj.addClass("gTlBar");
	}
	
}

function default_JDynamicHorizontalToolbar_DomCtrlFn(conf){
	
}
function defatule_JDynamicHorizontalToolbar_ComponetFn(conf){
	var globalObj = this;
	var settings = globalObj.hToolbarSettings;
	
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
		var $userDataDiv = $('<div jHToolbar="true"/>');
		$userDataDiv.hide();
		if(userData != null && userData != ""){
			for(var key in userData){
				$userDataDiv.attr(key, userData[key]);
			}
		}
		
		var $btnIco = $('<b class="icoBtn"></b>');
		$btnIco.addClass(itemInfo.className);
		$btnIco.attr('title', itemInfo.title);
		
		var $btnLe = $('<div class="btnLe"></div>');
		var $btnRi = $('<div class="btnRi"></div>');

		var $item = $('<div class="tlbtn2"></div>');
		$item.attr('elID', itemInfo.itemID);
		$item.attr('isItemLocal', "true");
		$item.attr('itemSelected', "false");

		$item.append($btnLe);
		$item.append($btnIco);
		$item.append($btnRi);
		$item.append($userDataDiv);

		globalObj.panelObj.append($item);
		
		$item.click(function(event){
			globalObj.panelObj.find(">div[isItemLocal='true'].click").removeClass("click");

			globalObj.panelObj.find(">div[itemSelected='true']").attr("itemSelected", "false");

			$(this).addClass("click");
			$(this).attr("itemSelected", "true");
			
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
	*设置移动到工具选项上的效果
	*
	*/
	this.setItemMouseOn = function(){
		var $item_lis = globalObj.panelObj.find(">div[isItemLocal='true']");
		$item_lis.hover(function(event){
			var $this = $(this);
			if ($this.attr("itemSelected") == 'false') {
				$this.addClass('on');
			}
			event.stopPropagation();
			return null;
		}, function(event){
			var $this = $(this);
			$this.removeClass('on');

			event.stopPropagation();
			return null;
		});
	}
	/**
	 * 获取某个用户数据属性值
	 * param String itemID
	 * param String attributeName
	 * return string
	 */
	this.getUserData = function(itemID, attributeName){
		var $userDataObj = globalObj.panelObj.find(">div[isItemLocal='true']>div[jHToolbar='true']");
		return $userDataObj.attr(attributeName);
	}
	/**
	 * 设置工具选项是否可用
	 * param String itemID
	 * param boolean state
	 */
	this.setItemDisabled = function(itemID, state){
		var $item_li = globalObj.panelObj.find(">div[elID='"+itemID+"']");
		$item_li.attr("disabled", state);
		if(state){
			$item_li.addClass("btndisabled");
			//$item_li.unbind('click');
		}else{
			$item_li.removeClass('btndisabled');
		}
	}
	
	/**
	 * 设置所有工具选项是否可用
	 * param boolean state
	 */
	this.setAllItemsDisabled = function(state){
		var $item_lis = globalObj.panelObj.find(">div[isItemLocal='true']");
		$item_lis.attr("disabled", state);
		if(state){
			$item_li.addClass("btndisabled");
			//$item_li.unbind('click');
		}else{
			$item_li.removeClass('btndisabled');
		}
	}
	/**
	 * 按下某个工具选项
	 * param String itemID
	 */
	this.pressItem = function(itemID){
		var $item = globalObj.panelObj.find(">div[elID='"+itemID+"']");
		$item.click();
	}
}

 var JDynamicHorizontalToolbar = function(){
  function innerJDynamicHorizontalToolbar(conf, cfncconf){
	cfncconf = cfncconf ? cfncconf :{};
	$.extend(conf, cfncconf);
	this.init(conf, {domStru: "default_JDynamicHorizontalToolbar_DomStruFn",
					domCtrl: "default_JDynamicHorizontalToolbar_DomCtrlFn",
					compFn: "defatule_JDynamicHorizontalToolbar_ComponetFn"
				  });    
  }
  
  CFNC.registDomStruFn("default_JDynamicHorizontalToolbar_DomStruFn", default_JDynamicHorizontalToolbar_DomStruFn);
  CFNC.registDomCtrlFn("default_JDynamicHorizontalToolbar_DomCtrlFn", default_JDynamicHorizontalToolbar_DomCtrlFn);
  CFNC.registComponetFn("defatule_JDynamicHorizontalToolbar_ComponetFn", defatule_JDynamicHorizontalToolbar_ComponetFn);
  
  return innerJDynamicHorizontalToolbar;
 }();

$.apply(JDynamicHorizontalToolbar, Componet);