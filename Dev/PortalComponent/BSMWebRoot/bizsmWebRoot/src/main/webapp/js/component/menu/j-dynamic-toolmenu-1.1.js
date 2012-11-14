/*
* Componet Name: JDynamicToolMenu
* Author: qiaozheng
* Version: 1.0
* Date: 2010.10
* Desc: 动态创建Tool菜单
*
*/
function default_JDynamicToolMenu_DomStruFn(conf){

	this.popMenuSettings = $.extend({
		id: "jToolMenu-1",
		btnImagePath: "",
		btnClassName: "",
		menuItemWidth: "125px"
	}, conf||{});
	
	this.panelObj = $('<div id="'+this.popMenuSettings.id+'"/>');
	this.panelObj.css("display", "inline");
	
	var $menuBox = $('<div elID="jToolMenuBox" class="buttonmenu" style="position:absolute; list-style:none;"><ul></ul></div>');
	$menuBox.css("width", this.popMenuSettings.menuItemWidth);
	$menuBox.hide();
	this.panelObj.append($menuBox);
	
	$menuBox.hover(function(){
	}, function(event){
		$menuBox.slideUp(300);
	});
	$(document).click(function(event){
		$menuBox.fadeOut(300);
		event.stopPropagation();
		return null;
	});
	
	var $toolBtn = null;
	if(this.popMenuSettings.btnClassName != null 
			&& this.popMenuSettings.btnClassName != ""){
		$toolBtn = $('<span id="jDToolMenuBtn" class="'+this.popMenuSettings.btnClassName+'"/>');
	}else if(this.popMenuSettings.btnImagePath != null 
			&& this.popMenuSettings.btnImagePath != ""){
		$toolBtn = $('<image id="jDToolMenuBtn" src="'+this.popMenuSettings.btnImagePath+'" style="cursor:hand"/>');
	}
	
	this.panelObj.append($toolBtn);
	
	var tempPanelObj = this.panelObj;
	$toolBtn.click(function(event){
		event.stopPropagation();

		var $this = $(this);
		var topNum = $this.offset().top+$this.height();
		var leftNum = $this.offset().left+$this.width();
		//关闭所有已经打开的工具菜单
		$('div[elID="jToolMenuBox"]').fadeOut(300);
		
		var $menuBox = tempPanelObj.find('>div[elID="jToolMenuBox"]');

		var bodyWidth = $('body').width();
		var htmlHeight = $('html').height();
		var bodyHeight = $('body').height();
		var menuBoxWidth = $menuBox.width();
		var menuBoxHeight = $menuBox.height();
		var calcHeight = (htmlHeight>bodyHeight)?htmlHeight:bodyHeight; //最大高度 比较html与body的高度
		if(calcHeight<menuBoxHeight+topNum){topNum = calcHeight-menuBoxHeight;} //超 高
		if(bodyWidth<menuBoxWidth+leftNum){leftNum = bodyWidth-menuBoxWidth;} //超 宽
		
		$menuBox.css("left", (leftNum-5)+"px");
		$menuBox.css("top", (topNum-5)+"px");
		$menuBox.css("z-index", 1000);
		$menuBox.show(300);
		
		event.stopPropagation();
		//event.preventDefault();
		return null;
	});
	
}

function default_JDynamicToolMenu_DomCtrlFn(conf){
	
}
function defatule_JDynamicToolMenu_ComponetFn(conf){
	var globalObj = this;
	var settings = globalObj.popMenuSettings;
	
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
	 * 添加菜单项
	 * param JSONObject menuInfo (menuID, label, icoClassName)
	 * param JSONObject userData (用户数据对象)
	 * param function clickCallFunc (点击菜单项事件监听函数)
	 */
	this.addMenuItem = function(menuInfo, userData, clickCallFunc){
		var $userDataDiv = $('<div jToolMenuUserDataArea="true"/>');
		$userDataDiv.hide();
		if(userData != null && userData != ""){
			for(var key in userData){
				$userDataDiv.attr(key, userData[key]);
			}
		}
		
		var $menuUL = globalObj.panelObj.find('>div[elID="jToolMenuBox"]>ul');
		var $menuSpan = $("<span>"+menuInfo["label"]+"</span>");
		var $li = $("<li menuID='"+menuInfo["menuID"]+"'></li>");
		$li.append($menuSpan);
		//$li.addClass("div_RightMenuUlLi");
		$li.addClass(menuInfo["icoClassName"]);
		
		$li.append($userDataDiv);
		$menuUL.append($li);
		
		$li.bind("mouseover", function(event){
			$(this).addClass("div_RightMenuULLIRM_mouseover");
		});
		$li.bind("mouseout", function(event){
			$(this).removeClass("div_RightMenuULLIRM_mouseover");
		});
		$li.bind("click", function(event){
			if(clickCallFunc != null && clickCallFunc != ""){
				var paramMap = {};
				if(userData != null && userData != ""){
					for(var key in userData){
						paramMap[key] = userData[key];
					}
				}
				paramMap["menuID"] = menuInfo["menuID"];
				paramMap["label"] = menuInfo["label"];
				paramMap["icoClassName"] = menuInfo["icoClassName"];
				
				clickCallFunc(paramMap);
			}
			event.stopPropagation();
			return null;
		});
		
		return $li.get(0);
	}
	/**
	 * 设置菜单选项是否可用
	 * param String menuID
	 * param boolean state
	 */
	this.setMenuItemDisabled = function(menuID, state){
		var $toolMenu_li = globalObj.panelObj.find('>div[elID="jToolMenuBox"]>div[elID="jToolMenuLocal"]>ul[elID="jToolMenuLocalUL"]>li[menuID="'+menuID+'"]');
		$toolMenu_li.attr("disabled", state);
	}
	/**
	 * 设置所有菜单选项是否可用
	 * param boolean state
	 */
	this.setAllMenuItemsDisabled = function(state){
		var $toolMenu_lis = globalObj.panelObj.find('>div[elID="jToolMenuBox"]>div[elID="jToolMenuLocal"]>ul[elID="jToolMenuLocalUL"]>li[menuID]');
		$toolMenu_lis.attr("disabled", state);
	}
	/**
	 * 获取某个用户数据属性值
	 * param String menuID
	 * param String attributeName
	 * return string
	 */
	this.getUserData = function(menuID, attributeName){
		var $toolMenuUserDataObj = globalObj.panelObj.find('>div[elID="jToolMenuBox"]>div[elID="jToolMenuLocal"]>ul[elID="jToolMenuLocalUL"]>li[menuID="'+menuID+'"]>div[jToolMenuUserDataArea="true"]');
		return $toolMenuUserDataObj.attr(attributeName);
	}
	/**
	 * 展开菜单项
	 * param double menuPosX 菜单X坐标位置
	 * param double menuPosY 菜单Y坐标位置
	 */
	this.open = function(menuPosX, menuPosY){
		var $menuBox = globalObj.panelObj.find('>div[elID="jToolMenuBox"]');
		$menuBox.css("left", menuPosX+"px");
		$menuBox.css("top", menuPosY+"px");
		$menuBox.css("z-index", 101);
		
		$menuBox.show(300);
	}
	/**
	 * 关闭菜单项
	 */
	this.close = function(){
		var $menuBox = globalObj.panelObj.find('>div[elID="jToolMenuBox"]');
		//$menuBox.hide(300);
		$menuBox.fadeOut(300);
	}
	
}

var JDynamicToolMenu = function(){
  function innerJDynamicToolMenu(conf, cfncconf){
	cfncconf = cfncconf ? cfncconf :{};
	$.extend(conf, cfncconf);
	this.init(conf, {domStru: "default_JDynamicToolMenu_DomStruFn",
					domCtrl: "default_JDynamicToolMenu_DomCtrlFn",
					compFn: "defatule_JDynamicToolMenu_ComponetFn"
				  });    
  }
  
  CFNC.registDomStruFn("default_JDynamicToolMenu_DomStruFn", default_JDynamicToolMenu_DomStruFn);
  CFNC.registDomCtrlFn("default_JDynamicToolMenu_DomCtrlFn", default_JDynamicToolMenu_DomCtrlFn);
  CFNC.registComponetFn("defatule_JDynamicToolMenu_ComponetFn", defatule_JDynamicToolMenu_ComponetFn);
  
  return innerJDynamicToolMenu;
}();

$.apply(JDynamicToolMenu, Componet);