/*
* Componet Name: JDynamicTabPanel
* Author: qiaozheng
* Version: 1.0
* Date: 2010.09
* Desc: 动态创建Tab页签组件
*
*/
function default_JDynamicTabPanel_DomStruFn(conf){
	
	this.tabsPanelSettings = $.extend({
		id: "jTabsPage-1",
		animated: "" // 动画效果speed("slow", "normal", "fast", or number)
	}, conf||{});
	
	//tab content内部是否只读
	this.contentDisabled = false;
	
	this.panelObj = $('<div id="'+this.tabsPanelSettings.id+'"/>');
	this.panelObj.addClass("set-panel-content");
	
	var $titleLocalPanel = $('<div elID="jTabsTitleLocalPanel"/>');
	$titleLocalPanel.addClass('settab-mid');
	
	var $titleLocal = $('<div elID="jTabsTitleLocal"><ul/></div>');
	$titleLocal.addClass("settab-foot");
	
	$titleLocalPanel.append($titleLocal);
	
	this.panelObj.append($titleLocalPanel);
	
	var $contentContainer = $('<div elID="jTabsContentContainer"/>');
	this.panelObj.append($contentContainer);
	
}

function default_JDynamicTabPanel_DomCtrlFn(conf){
	
}
function defatule_JDynamicTabPanel_ComponetFn(conf){
	var globalObj = this;
	var settings = globalObj.tabsPanelSettings;
	
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
	 * 添加内嵌组件tab页签
	 * param JSONObject tabInfo(tabID, label, height)
	 * param Object innerElement (tab页内部包含的组件对象)
	 * param JSONObject userData (用户数据对象)
	 * param function clickCallFunc (点击Tab页签回调函数)
	 * return Element (返回新添加的Tab)
	 */
	this.addInnerComponetTab = function(tabInfo, innerElement, userData, clickCallFunc){
		var $userDataDiv = $('<div jTabUserDataArea="true"/>');
		$userDataDiv.hide();
		if(userData != null && userData != ""){
			for(var key in userData){
				$userDataDiv.attr(key, userData[key]);
			}
		}
		
		var $tab_li = $('<li tabID="'+tabInfo.tabID+'"><div class="tab-l"><div class="tab-r"><div class="tab-m"><a href="#" >'+tabInfo.label+'</a></div></div></div></li>');
		$tab_li.append($userDataDiv);
		globalObj.panelObj.find('div[elID="jTabsTitleLocal"]>ul').append($tab_li);

		var $tabContentLocal = $('<div tabID="'+tabInfo.tabID+'"/>');
		$tabContentLocal.addClass("set-panel-content-white");
		$tabContentLocal.css("height", tabInfo.height);
		$tabContentLocal.css("overflow", "auto");
		$tabContentLocal.hide();

		$tabContentLocal.append(innerElement);

		globalObj.panelObj.find('div[elID="jTabsContentContainer"]').append($tabContentLocal);

		var tempPanelObj = globalObj.panelObj;
		$tab_li.bind('click', function(){
			if(clickCallFunc != null && clickCallFunc != ""){
				var paramMap = {};
				if(userData != null && userData != ""){
					for(var key in userData){
						paramMap[key] = userData[key];
					}
				}
				paramMap["tabID"] = tabInfo["tabID"];
				paramMap["label"] = tabInfo["label"];
				paramMap["height"] = tabInfo["height"];
				
				clickCallFunc(paramMap);
			}
			tempPanelObj.find('div[elID="jTabsTitleLocal"]>ul>li').removeClass('nonce');
		
			$tab_li.addClass('nonce');

			tempPanelObj.find('div[elID="jTabsContentContainer"]>div').hide();

			var $contentLocal = tempPanelObj.find('div[elID="jTabsContentContainer"]>div[tabID="'+$tab_li.attr("tabID")+'"]');
			//判断是否添加动画效果
			if(settings.animated != null && settings.animated != ""){
				$contentLocal.show(settings.animated);
			}else{
				$contentLocal.show();
			}
		});
		return $tab_li.get(0);
	}
	/**
	 * 添加页面tab页签
	 * param JSONObject tabInfo(tabID, label, height)
	 * param String path (tab页内部包含的页面路径)
	 * param JSONObject userData (用户数据对象)
	 * param function clickCallFunc (点击Tab页签回调函数)
	 * return Element (返回新添加的Tab)
	 */
	this.addPageTab = function(tabInfo, path, userData, clickCallFunc){
		var $userDataDiv = $('<div jTabUserDataArea="true"/>');
		$userDataDiv.hide();
		if(userData != null && userData != ""){
			for(var key in userData){
				$userDataDiv.attr(key, userData[key]);
			}
		}

		var $tab_li = $('<li tabID="'+tabInfo.tabID+'"><div class="tab-l"><div class="tab-r"><div class="tab-m"><a href="#" >'+tabInfo.label+'</a></div></div></div></li>');
		$tab_li.append($userDataDiv);
		globalObj.panelObj.find('div[elID="jTabsTitleLocal"]>ul').append($tab_li);
		
		var $tabContentLocal = $('<div tabID="'+tabInfo.tabID+'"/>');
		$tabContentLocal.addClass("set-panel-content-white");
		$tabContentLocal.css("height", tabInfo.height);
		$tabContentLocal.css("overflow", "auto");
		$tabContentLocal.hide();

		globalObj.panelObj.find('div[elID="jTabsContentContainer"]').append($tabContentLocal);

		var tempPanelObj = globalObj.panelObj;
		$tab_li.bind('click', function(){
			if(clickCallFunc != null && clickCallFunc != ""){
				var paramMap = {};
				if(userData != null && userData != ""){
					for(var key in userData){
						paramMap[key] = userData[key];
					}
				}
				paramMap["tabID"] = tabInfo["tabID"];
				paramMap["label"] = tabInfo["label"];
				paramMap["height"] = tabInfo["height"];
				
				clickCallFunc(paramMap);
			}
			tempPanelObj.find('div[elID="jTabsTitleLocal"]>ul>li').removeClass('nonce');
			$tab_li.addClass('nonce');
			tempPanelObj.find('div[elID="jTabsContentContainer"]>div').hide()
			var $contentLocal = tempPanelObj.find('div[elID="jTabsContentContainer"]>div[tabID="'+$tab_li.attr("tabID")+'"]');
			
			
			var $iframeObj = tempPanelObj.find('div[elID="jTabsContentContainer"] iframe[elID=jTabsContentIframe]');
			if($iframeObj.size() == 0){
				$iframeObj = $("<iframe elID='jTabsContentIframe' frameborder='NO' border='0' scrolling='yes' noresize framespacing='0' style='width:100%; height:100%'/>");
				$iframeObj.attr("allowtransparency", true);
				//iframe内容load完成事件监听器
				$iframeObj.bind("load", function(){
					//alert($($iframeObj.get(0).contentWindow.document).find("div"));
					if(settings.contentDisabled){
						
						$($iframeObj.get(0).contentWindow.document.body).find("*").each(function(){
//							if(this.tagName == "DIV"
//								|| this.tagName == "SPAN"
//								|| this.tagName == "UL"
//								|| this.tagName == "LI"
//								|| this.tagName == "FORM"
//								|| this.tagName == "TABLE"
//								|| this.tagName == "IMG"
//								|| this.tagName == "SELECT"
//								|| this.tagName == "INPUT"
//								|| this.tagName == "TEXTAREA"
//								|| this.tagName == "FILE"
//								|| this.tagName == "BUTTON"
//								|| this.tagName == "SUBMIT"){
								this.disabled = settings.contentDisabled;
								//$(this).attr("disabled", "disabled");
//							}
						});
						
					}
				});
			}
			$iframeObj.attr("src", path);
			$contentLocal.append($iframeObj);
			//判断是否添加动画效果
			if(settings.animated != null && settings.animated != ""){
				$contentLocal.show(settings.animated);
			}else{
				$contentLocal.show();
			}
		});
		return $tab_li.get(0);
	}
	/**
	 * 注册tab页面 点击事件监听器
	 * param function func 事件监听函数
	 */
	this.click = function(func){
		 globalObj.panelObj.find('div[elID="jTabsTitleLocal"]>ul>li').bind("click", function(){
			var $this = $(this);
			
			var $contentLocal = globalObj.panelObj.find('div[elID="jTabsContentContainer"]>div[tabID="'+$this.attr("tabID")+'"]');
			var paramMap = {};
			paramMap["tabID"] = $this.attr("tabID");
			paramMap["label"] = $this.text();
			paramMap["height"] = $contentLocal.css("height");
			func(paramMap);
		});
	}
	/**
	 * 设置所有Tab页中,content部分的可用性
	 * param boolean state
	 */
	this.setContentDisabled = function(state){
		//设置内嵌iframe load内容的只读性
		settings.contentDisabled = state;
	}
	/**
	 * 设置所有Tab页中,content部分内嵌组件的可用性
	 * param boolean state
	 */
	this.setInnerComponetDisabled = function(state){
		//设置内嵌组件只读性
		var $tabContent = globalObj.panelObj.find('div[elID="jTabsContentContainer"]>div[tabID]');
		$tabContent.find("*").each(function(){
			this.disabled = state;
		});
	}
	/**
	 * 设置tab页签是否可用
	 * param String tabID
	 * param boolean state
	 */
	this.setTabDisabled = function(tabID, state){
		var $tab_li = globalObj.panelObj.find('div[elID="jTabsTitleLocal"]>ul>li[tabID="'+tabID+'"]');
		$tab_li.attr("disabled", state);
	}
	/**
	 * 设置所有tab页签是否可用
	 * param boolean state
	 */
	this.setAllTabsDisabled = function(state){
		var $tab_lis = globalObj.panelObj.find('div[elID="jTabsTitleLocal"]>ul>li[tabID]');
		$tab_lis.attr("disabled", state);
	}
	/**
	 * 获取某个用户数据属性值
	 * param String tabID
	 * param String attributeName
	 * return string
	 */
	this.getUserData = function(tabID, attributeName){
		var $tabUserDataObj = globalObj.panelObj.find('div[elID="jTabsTitleLocal"]>ul>li[tabID="'+tabID+'"]>div[jTabUserDataArea="true"]');
		return $tabUserDataObj.attr(attributeName);
	}
	/**
	 * 设置当前要展开的tab页签
	 * param tabID要展开的tab页签ID
	 */
	this.expanseTab = function(tabID){
		globalObj.panelObj.find('div[elID="jTabsTitleLocal"]>ul>li[tabID="'+tabID+'"]').click();
	}
	
}

 var JDynamicTabPanel = function(){
  function innerJDynamicTabPanel(conf, cfncconf){
	cfncconf = cfncconf ? cfncconf :{};
	$.extend(conf, cfncconf);
	this.init(conf, {domStru: "default_JDynamicTabPanel_DomStruFn",
					domCtrl: "default_JDynamicTabPanel_DomCtrlFn",
					compFn: "defatule_JDynamicTabPanel_ComponetFn"
				  });    
  }
  
  CFNC.registDomStruFn("default_JDynamicTabPanel_DomStruFn", default_JDynamicTabPanel_DomStruFn);
  CFNC.registDomCtrlFn("default_JDynamicTabPanel_DomCtrlFn", default_JDynamicTabPanel_DomCtrlFn);
  CFNC.registComponetFn("defatule_JDynamicTabPanel_ComponetFn", defatule_JDynamicTabPanel_ComponetFn);
  
  return innerJDynamicTabPanel;
 }();

$.apply(JDynamicTabPanel, Componet);