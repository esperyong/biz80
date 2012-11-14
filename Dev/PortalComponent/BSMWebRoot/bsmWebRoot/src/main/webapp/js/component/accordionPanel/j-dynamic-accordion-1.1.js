/*
* Componet Name: JDynamicAccordionPanel
* Author: qiaozheng
* Version: 1.0
* Date: 2010.09
* Desc: 动态创建折叠组件
*
*/
function default_JDynamicAccordionPanel_DomStruFn(conf){
	
	this.accordionSettings = $.extend({
		id:"jAccordion-1",
		globalContentHeight:"230px",
		panelTopClassName:"set-panel-top",
		panelIcoClassName:"set-panel-ico",
		panelTitleClassName:"set-panel-title",
		panelContentClassName:"set-panel-content",
		panelBlockStyle:"blackbox",//tree
		slid:false,
		fillSpace:false,
		autoHeight:false
	}, conf||{});
	
	//slab content内部是否只读
	this.contentDisabled = false;
	
	if(this.accordionSettings.panelBlockStyle.toLowerCase() == "tree"){
		this.accordionSettings.panelTopClassName = "tree-panel-top";
		this.accordionSettings.panelIcoClassName = "tree-panel-ico";
		this.accordionSettings.panelTitleClassName = "tree-panel-title";
		this.accordionSettings.panelContentClassName = "tree-panel-content-top";
	}
	
	this.panelObj = $("<div id='"+this.accordionSettings.id+"'/>");	
}

function default_JDynamicAccordionPanel_DomCtrlFn(conf){
	
}
function defatule_JDynamicAccordionPanel_ComponetFn(conf){
	var globalObj = this;
	var settings = globalObj.accordionSettings;
	
	/**
	 * 将组件添加到容器元素中
	 * param Object container 组件所属容器元素(参数：Element,jquery包装器)
	 */
	this.appendToContainer = function(container){
		globalObj.panelObj.appendTo(container);
		var animatedStr = "";
		if(settings.slid){
			animatedStr = "slide";
		}
		globalObj.panelObj.accordion({animated: animatedStr, fillSpace: settings.fillSpace, autoHeight: settings.autoHeight});//navigation: true
		return globalObj.panelObj.get(0);
	}
	/**
	 * 获取组件句柄根元素
	 * return Element
	 */
	this.getComponetHandle = function(){
		var animatedStr = "";
		if(settings.slid){
			animatedStr = "slide";
		}
		globalObj.panelObj.accordion({animated: animatedStr, fillSpace: settings.fillSpace, autoHeight: settings.autoHeight});//navigation: true
		return globalObj.panelObj.get(0);
	}
	/**
	 * 添加内嵌组件slab(折叠页签）
	 * param JSONObject slabInfo (slabID, label, contentHeight)
	 * param Object innerElement (slab页内部包含的组件对象)
	 * param JSONObject userData (用户数据对象)
	 * param function clickCallFunc (点击Slab折叠页签回调函数)
	 */
	this.addInnerComponetSlab = function(slabInfo, slabICOClassNameArray, innerElement, userData, clickCallFunc){
		var $jAccordionSlab = $("<h3 slabID='"+slabInfo.slabID+"'></h3>");
		var $slabHrefLocal = $("<a href='#'></a>");
		var $topContainer = $("<div class='"+settings.panelTopClassName+"'></div>");
		var $slabICO = $("<div class='"+settings.panelIcoClassName+"'/>");
		var $slabSpan = $("<span nameField='nameField' class='"+settings.panelTitleClassName+"'>"+slabInfo.label+"</span>");
		
		$topContainer.append($slabICO);
		if(slabICOClassNameArray != null 
				&& slabICOClassNameArray != ""){
			for(var i=0; i<slabICOClassNameArray.length; i++){
				var $slabICOTemp = $("<div class='"+slabICOClassNameArray[i]+"'/>");
				$topContainer.append($slabICOTemp);
			}
		}
		$topContainer.append($slabSpan);
		$slabHrefLocal.append($topContainer);
		$jAccordionSlab.append($slabHrefLocal);
		
		var $userDataDiv = $('<div jAccordionUserDataArea="true"/>');
		$userDataDiv.hide();
		if(userData != null && userData != ""){
			for(var key in userData){
				$userDataDiv.attr(key, userData[key]);
			}
		}
		$jAccordionSlab.append($userDataDiv);
		globalObj.panelObj.append($jAccordionSlab);
		
		var heightTemp = slabInfo.contentHeight;
		if(settings.fillSpace){
			heightTemp = settings.globalContentHeight;
		}
		
		var $contentLocal = $("<div elID='jAccordionContentLocal'/>");
		$contentLocal.css("height", heightTemp);
		$contentLocal.append(innerElement);
		
		var $contentContainer = $("<div slabID='"+slabInfo.slabID+"' elID='jAccordionContentContainer' class='"+settings.panelContentClassName+"'/>");
		$contentContainer.append($contentLocal);
		
		globalObj.panelObj.append($contentContainer);
		
		if(clickCallFunc != null && clickCallFunc != ""){
			$jAccordionSlab.click(function(event) {
				var paramMap = {};
				if(userData != null && userData != ""){
					for(var key in userData){
						paramMap[key] = userData[key];
					}
				}
				paramMap["slabID"] = slabInfo["slabID"];
				paramMap["label"] = slabInfo["label"];
				paramMap["contentHeight"] = slabInfo["contentHeight"];
				clickCallFunc(paramMap);
			});
		}
		/*
		$jAccordionSlab.click(function() {
			//this.blur();
		});
		*/
	}

	/**
	 * 添加slab(折叠页签)
	 * param JSONObject slabInfo (slabID, label, contentHeight)
	 * param String path (tab页内部包含的页面路径)
	 * param JSONObject userData (用户数据对象)
	 * param function clickCallFunc (点击Slab折叠页签回调函数)
	 */
	this.addPageSlab = function(slabInfo, slabICOClassNameArray, path, userData, clickCallFunc){
		var $jAccordionSlab = $("<h3 slabID='"+slabInfo.slabID+"'></h3>");
		var $slabHrefLocal = $("<a href='#'></a>");
		var $topContainer = $("<div class='"+settings.panelTopClassName+"'></div>");
		var $slabICO = $("<div class='"+settings.panelIcoClassName+"'/>");
		var $slabSpan = $("<span nameField='nameField' class='"+settings.panelTitleClassName+"'>"+slabInfo.label+"</span>");
		
		$topContainer.append($slabICO);
		if(slabICOClassNameArray != null 
				&& slabICOClassNameArray != ""){
			for(var i=0; i<slabICOClassNameArray.length; i++){
				var $slabICOTemp = $("<div class='"+slabICOClassNameArray[i]+"'/>");
				$topContainer.append($slabICOTemp);
			}
		}
		$topContainer.append($slabSpan);
		$slabHrefLocal.append($topContainer);
		$jAccordionSlab.append($slabHrefLocal);
		
		var $userDataDiv = $('<div jAccordionUserDataArea="true"/>');
		$userDataDiv.hide();
		if(userData != null && userData != ""){
			for(var key in userData){
				$userDataDiv.attr(key, userData[key]);
			}
		}
		$jAccordionSlab.append($userDataDiv);
		globalObj.panelObj.append($jAccordionSlab);
		
		var heightTemp = slabInfo.contentHeight;
		if(settings.fillSpace){
			heightTemp = settings.globalContentHeight;
		}
		
		var $contentLocal = $("<div elID='jAccordionContentLocal'/>");
		$contentLocal.css("height", heightTemp);
		
		var $contentContainer = $("<div slabID='"+slabInfo.slabID+"' elID='jAccordionContentContainer' class='"+settings.panelContentClassName+"'/>");
		$contentContainer.append($contentLocal);
		
		globalObj.panelObj.append($contentContainer);

		//$contentContainer.hide();
		$jAccordionSlab.click(function(event) {
			if(clickCallFunc != null && clickCallFunc != ""){
				var paramMap = {};
				if(userData != null && userData != ""){
					for(var key in userData){
						paramMap[key] = userData[key];
					}
				}
				paramMap["slabID"] = slabInfo["slabID"];
				paramMap["label"] = slabInfo["label"];
				paramMap["contentHeight"] = slabInfo["contentHeight"];
				
				clickCallFunc(paramMap);
			}
			//$("#testContent_"+id).load(conf.contents[id].url);
			var $iframeObj = globalObj.panelObj.find('iframe[elID="jAccordionContentIframe"]');
			if($iframeObj.size() == 0){
				$iframeObj = $("<iframe elID='jAccordionContentIframe' frameborder='NO' border='0' scrolling='NO' noresize framespacing='0' style='width:100%; height:100%'/>");
				$iframeObj.attr("allowtransparency", true);
				//iframe内容load完成事件监听器
				$iframeObj.bind("load", function(){
					if(settings.contentDisabled){
						$($iframeObj.get(0).contentWindow.document.body).find("*").each(function(){
								this.disabled = settings.contentDisabled;
						});
					}
				});
			}
			$iframeObj.attr("src", path);
			globalObj.panelObj.find(">div[slabID='"+slabInfo.slabID+"']>div[elID='jAccordionContentLocal']").append($iframeObj);
		});

	 }
	/**
	 * 为Slab页签bar部分添加内部工具组件
	 * param String slabID
	 * param Object toolElement (参数类型：Element,jquery包装器对象)
	 * param int spaceCount (组件之间空格间隙个数)
	 */
	this.addSlabTool = function(slabID, toolElement, spaceCount){
		var $slabTitleObj = globalObj.panelObj.find(">h3[slabID='"+slabID+"']>a>div");
		var spaceStr = "";
		if(spaceCount != null && spaceCount != ""){
			for(var i=0; i<spaceCount; i++){
				spaceStr += "&nbsp;";
			}
		}
		if(spaceStr != ""){
			$slabTitleObj.append(spaceStr).append(toolElement);
		}else{
			$slabTitleObj.append(toolElement);
		}
	}
	/**
	 * 为所有Slab页签bar部分添加内部工具组件
	 * param Object toolElement (参数：Element,jquery包装器对象)
	 * param int spaceCount (组件之间空格间隙个数)
	 */
	this.addAllSlabTool = function(toolElement, spaceCount){
		var $slabTitleObj = globalObj.panelObj.find(">h3>a>div");
		var spaceStr = "";
		if(spaceCount != null && spaceCount != ""){
			for(var i=0; i<spaceCount; i++){
				spaceStr += "&nbsp;";
			}
		}
		if(spaceStr != ""){
			$slabTitleObj.append(spaceStr).append(toolElement);
		}else{
			$slabTitleObj.append(toolElement);
		}
	}
	
	/**
	 * 注册slab(折叠页签) 点击事件监听器
	 * param function func 事件监听函数
	 */
	this.click = function(func){
		globalObj.panelObj.find("h3").bind("click", function(){
			var $this = $(this);
			
			var $contentLocal = globalObj.panelObj.find(">div[slabID='"+$this.attr("slabID")+"']>div[elID='jAccordionContentLocal']");
			
			var paramMap = {};
			paramMap["slabID"] = $this.attr("slabID");
			paramMap["label"] = $this.find("span[nameField]").val();
			paramMap["contentHeight"] = $contentLocal.css("height");
			func(paramMap);
		});
	}
	/**
	 * 获取某个用户数据属性值
	 * param String slabID
	 * param String attributeName
	 * return string
	 */
	this.getUserData = function(slabID, attributeName){
		var $slabUserDataObj = globalObj.panelObj.find(">h3[slabID='"+slabID+"']>div[jAccordionUserDataArea='true']");
		return $slabUserDataObj.attr(attributeName);
	}

	/**
	 * 设置所有折叠页中,content部分的可用性
	 * param boolean state
	 */
	this.setContentDisabled = function(state){
		//设置内嵌iframe load内容的只读性
		settings.contentDisabled = state;
	}
	/**
	 * 设置所有折叠页中,content部分内嵌组件的可用性
	 * param boolean state
	 */
	this.setInnerComponetDisabled = function(state){
		//设置内嵌组件只读性
		var $slabContent = globalObj.panelObj.find(">div[slabID]");
		$slabContent.find("*").each(function(){
			this.disabled = state;
		});
	}
	/**
	 * 设置当前Slab组件处于展开的slab(折叠页签)
	 * param String slabID
	 */
	this.expanseSlab = function(slabID){
		globalObj.panelObj.find('h3[slabID="'+slabID+'"]').click();
	}
	 /*
	 //$("#accordionDiv").draggable();
	 $('#accordionDragHandle').bind('mouseover',function(){
		$("#standardAccordionHull").draggable();
	 });

	  $('#accordionDragHandle').bind('mouseout',function(){
		//$.cancel();
	 });
	*/
}

var JDynamicAccordionPanel = function(){
  function innerJDynamicAccordionPanel(conf, cfncconf){
	cfncconf = cfncconf ? cfncconf :{};
	$.extend(conf, cfncconf);
	this.init(conf, {domStru: "default_JDynamicAccordionPanel_DomStruFn",
					domCtrl: "default_JDynamicAccordionPanel_DomCtrlFn",
					compFn: "defatule_JDynamicAccordionPanel_ComponetFn"
				  });    
  }
  
  CFNC.registDomStruFn("default_JDynamicAccordionPanel_DomStruFn", default_JDynamicAccordionPanel_DomStruFn);
  CFNC.registDomCtrlFn("default_JDynamicAccordionPanel_DomCtrlFn", default_JDynamicAccordionPanel_DomCtrlFn);
  CFNC.registComponetFn("defatule_JDynamicAccordionPanel_ComponetFn", defatule_JDynamicAccordionPanel_ComponetFn);
  
  return innerJDynamicAccordionPanel;
}();

$.apply(JDynamicAccordionPanel, Componet);
