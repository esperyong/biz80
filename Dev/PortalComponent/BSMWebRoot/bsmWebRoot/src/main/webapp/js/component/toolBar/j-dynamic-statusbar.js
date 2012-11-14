/*
* Componet Name: JDynamicStatusbar
* Author: qiaozheng
* Version: 1.0
* Date: 2010.12
* Desc: 动态创建状态统计栏
*/
function default_JDynamicStatusbar_DomStruFn(conf){
	
	this.statusbarSettings = $.extend({
		id: "jStatusbar-1",
		label: "Status Label 1", 
		height: "100%"
	}, conf||{});
	
	this.panelObj = $('<div id="'+this.statusbarSettings.id+'"></div>');
	this.panelObj.addClass('service-bottom');
	
	var $labelItem = $('<li elID="statusbarLabelArea"><span class="title">'+this.statusbarSettings.label+'</span></li>');	
	
	var $totalItem = $('<li elID="statusbarTotalArea"><span class="title">总数</span>：<a class="txtunderline">0</a></li>');
	$totalItem.find('>a').css("cursor", "hand");
	
	var $statusRedItem = $('<li elID="statusbarRed"><span class="light-ico light-ico-red"></span>：<a class="txtunderline">0</a></li>');
	$statusRedItem.find('>span').css("cursor", "default");
	$statusRedItem.find('>a').css("cursor", "hand");
	
	var $statusYellowItem = $('<li elID="statusbarYellow"><span class="light-ico light-ico-yellow"></span>：<a class="txtunderline">0</a></li>');
	$statusYellowItem.find('>span').css("cursor", "default");
	$statusYellowItem.find('>a').css("cursor", "hand");
	
	var $statusGreenItem = $('<li elID="statusbarGreen"><span class="light-ico light-ico-green"></span>：<a class="txtunderline">0</a></li>');
	$statusGreenItem.find('>span').css("cursor", "default");
	$statusGreenItem.find('>a').css("cursor", "hand");
	
	var $statusGrayItem = $('<li elID="statusbarGray"><span class="light-ico light-ico-gray"></span>：<a class="txtunderline">0</a></li>');
	$statusGrayItem.find('>span').css("cursor", "default");
	$statusGrayItem.find('>a').css("cursor", "hand");
	
	var $statusItemContainer = $('<ul elID="statusbarItemContainer"/>');
	
	$statusItemContainer.append($labelItem);
	$statusItemContainer.append($totalItem);
	
	$statusItemContainer.append($statusRedItem);
	$statusItemContainer.append($statusYellowItem);
	$statusItemContainer.append($statusGreenItem);
	$statusItemContainer.append($statusGrayItem);
	
	this.panelObj.append($statusItemContainer);
}

function default_JDynamicStatusbar_DomCtrlFn(conf){
	
}
function defatule_JDynamicStatusbar_ComponetFn(conf){
	var globalObj = this;
	var settings = globalObj.statusbarSettings;
	
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
	 * 添加statusbar
	 * param JSONObject statusValueInfo(red, yellow, green, gray)
	 * param function clickCallFunc (点击工具按钮回调函数)
	 * return Element (返回新添加的Item)
	 */
	this.setAllValues = function(statusValueInfo){

		var $itemContainer = globalObj.panelObj.find('>ul[elID="statusbarItemContainer"]');
		
		var $redLocal = $itemContainer.find('>li[elID="statusbarRed"]>a');
		$redLocal.text(statusValueInfo["red"]);
		var $yellowLocal = $itemContainer.find('>li[elID="statusbarYellow"]>a');
		$yellowLocal.text(statusValueInfo["yellow"]);
		var $greenLocal = $itemContainer.find('>li[elID="statusbarGreen"]>a');
		$greenLocal.text(statusValueInfo["green"]);
		var $grayLocal = $itemContainer.find('>li[elID="statusbarGray"]>a');
		$grayLocal.text(statusValueInfo["gray"]);
		
		var $totalLocal = $itemContainer.find('>li[elID="statusbarTotalArea"]>a');
		$totalLocal.text(statusValueInfo["red"]*1+statusValueInfo["yellow"]*1+statusValueInfo["green"]*1+statusValueInfo["gray"]*1);

	}
	
	this.setValue = function(value, colorName){
		var $itemContainer = globalObj.panelObj.find('>ul[elID="statusbarItemContainer"]');
		
		var $redLocal = $itemContainer.find('>li[elID="statusbarRed"]>a');
		var $yellowLocal = $itemContainer.find('>li[elID="statusbarYellow"]>a');
		var $greenLocal = $itemContainer.find('>li[elID="statusbarGreen"]>a');
		var $grayLocal = $itemContainer.find('>li[elID="statusbarGray"]>a');
		
		if(colorName == "red"){
			$redLocal.text(statusInfo["red"]);
		}else if(colorName == "yellow"){
			$yellowLocal.text(statusInfo["yellow"]);
		}else if(colorName == "green"){
			$greenLocal.text(statusInfo["green"]);
		}else if(colorName == "gray"){
			$grayLocal.text(statusInfo["gray"]);
		}
		var $totalLocal = $itemContainer.find('>li[elID="statusbarTotalArea"]>a');
		$totalLocal.text($redLocal.text()*1+$yellowLocal.text()*1+$greenLocal.text()*1+$grayLocal.text()*1);
	}
}

 var JDynamicStatusbar = function(){
  function innerJDynamicStatusbar(conf, cfncconf){
	cfncconf = cfncconf ? cfncconf :{};
	$.extend(conf, cfncconf);
	this.init(conf, {domStru: "default_JDynamicStatusbar_DomStruFn",
					domCtrl: "default_JDynamicStatusbar_DomCtrlFn",
					compFn: "defatule_JDynamicStatusbar_ComponetFn"
				  });    
  }
  
  CFNC.registDomStruFn("default_JDynamicStatusbar_DomStruFn", default_JDynamicStatusbar_DomStruFn);
  CFNC.registDomCtrlFn("default_JDynamicStatusbar_DomCtrlFn", default_JDynamicStatusbar_DomCtrlFn);
  CFNC.registComponetFn("defatule_JDynamicStatusbar_ComponetFn", defatule_JDynamicStatusbar_ComponetFn);
  
  return innerJDynamicStatusbar;
 }();

$.apply(JDynamicStatusbar, Componet);