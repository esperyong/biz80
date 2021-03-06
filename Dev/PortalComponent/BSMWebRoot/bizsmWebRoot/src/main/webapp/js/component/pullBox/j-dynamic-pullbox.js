/*
* Componet Name: JDynamicPullPanel
* Author: qiaozheng
* Version: 1.0
* Date: 2010.09
* Desc: 动态创建推拉面板组件
*
*/
function default_JDynamicPullPanel_DomStruFn(conf){

	this.jpullSettings = $.extend({
		id: "jPullbox-1",
		label: "PullBox-1", 
		contentWidth: "400px",
		animated: "" //动画效果speed("slow", "normal", "fast", or number)
	},conf||{});
	
	//tab content内部是否只读
	this.contentDisabled = false;
	
	this.panelObj = $('<div id="'+this.jpullSettings.id+'" style="height:600px;overflow-x:hidden;overflow-y:hidden;"/>');
	
	this.panelObj.append('<div elID="jPullboxPanel" class="content-right" style="height:600px"><div elID="jPullboxLeftHandle" class="content-set-open"><div elID="jPullboxlArrowHot" class="set-button"></div><div elID="jPullboxContentPanel" class="set-content"></div></div></div>');
	
	var $pullBoxTitlePanel = $('<div elID="jPullboxTitlePanel" class="set-panel-title-left"><div class="set-panel-title-right"><div elID="jPullboxTitleLocal" class="set-panel-title-mid"><span class="set-panel-title">'+this.jpullSettings.label+'</span></div></div></div>');
	
	var $pullBoxContentPanel = this.panelObj.find('>div[elID="jPullboxPanel"]>div[elID="jPullboxLeftHandle"]>div[elID="jPullboxContentPanel"]');
	$pullBoxContentPanel.append($pullBoxTitlePanel);
	$pullBoxContentPanel.append('<div elID="jPullboxContentLocal"></div>');

	this.panelObj.find('>div[elID="jPullboxPanel"]>div[elID="jPullboxLeftHandle"]>div[elID="jPullboxContentPanel"]').css("width", this.jpullSettings.contentWidth);
	
	var widthNum = 0;
	var idx = this.jpullSettings.contentWidth.lastIndexOf("px");
	if(idx != -1){
		widthNum = this.jpullSettings.contentWidth.substring(0, idx);
	}else{
		widthNum = this.jpullSettings.contentWidth;
	}
	widthNum = (widthNum*1+16);

	this.panelObj.css("overflow-x", "hidden");
	this.panelObj.css("overflow-y", "hidden");
	this.panelObj.find('>div[elID="jPullboxPanel"]').css('position', 'relative');
	
	var panelObjTemp = this.panelObj;
	var animatedTemp = this.jpullSettings.animated;
	if(animatedTemp == null || animatedTemp == "") animatedTemp = 0;
	
	this.panelObj.find('>div[elID="jPullboxPanel"]>div[elID="jPullboxLeftHandle"]>div[elID="jPullboxlArrowHot"]').css("cursor", "hand").toggle(function(){
		//添加透明度动画
		/*
		panelObjTemp.find('>div[elID="jPullboxPanel"] div[elID="jPullboxContentPanel"]').animate({
			opacity:0
		}, animatedTemp);
		*/
		panelObjTemp.find('>div[elID="jPullboxPanel"]').animate({
				left:panelObjTemp.find('>div[elID="jPullboxPanel"]').position().left+widthNum
		}, animatedTemp, function(){
				panelObjTemp.find('>div[elID="jPullboxPanel"]>div[elID="jPullboxLeftHandle"]').removeClass('content-set-open').addClass("content-set-close");
				//$('#j-pull-root').get(0).scrollLeft = 400;
		});
		
	 }
	 ,function(){
		panelObjTemp.find('>div[elID="jPullboxPanel"]').animate({
				left:panelObjTemp.find('>div[elID="jPullboxPanel"]').position().left-widthNum
		}, animatedTemp, function(){
				//$('#j-div').hide();
				panelObjTemp.find('>div[elID="jPullboxPanel"]>div[elID="jPullboxLeftHandle"]').removeClass('content-set-close').addClass("content-set-open");
		});
		//添加透明度动画
		/*
		panelObjTemp.find('>div[elID="jPullboxPanel"] div[elID="jPullboxContentPanel"]').animate({
			opacity:1
		}, animatedTemp);
		*/
	 });

}

function default_JDynamicPullPanel_DomCtrlFn(conf){
	
}
function defatule_JDynamicPullPanel_ComponetFn(conf){
	var globalObj = this;
	var settings = globalObj.accordionSettings;
	
	/**
	 * 将组件添加到容器元素中
	 * param Object container 组件所属容器元素(参数：Element,jquery包装器)
	 */
	this.appendToContainer = function(container){
		globalObj.panelObj.appendTo(container);

		globalObj.panelObj.parent().css("overflow-x", "hidden");
		globalObj.panelObj.parent().css("overflow-y", "hidden");
		globalObj.panelObj.css('position', 'relative');

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
	 * 添加标题工具按钮
	 * param JSONObject btnInfo (btnID, title, icoClassName)
	 * param JSONObject userData (用户数据对象)
	 * param function clickCallFunc (点击工具按钮回调函数)
	 */
	this.addTitleToolBtn = function(btnInfo, userData, clickCallFunc){

		var $userDataDiv = $('<div jPullboxUserDataArea="true"/>');
		$userDataDiv.hide();
		if(userData != null && userData != ""){
			for(var key in userData){
				$userDataDiv.attr(key, userData[key]);
			}
		}

		var $jPullboxTitleLocal = globalObj.panelObj.find('>div[elID="jPullboxPanel"]>div[elID="jPullboxLeftHandle"]>div[elID="jPullboxContentPanel"]>div[elID="jPullboxTitlePanel"] div[elID="jPullboxTitleLocal"]');

		var $icoBtn = $('<span></span>');
		$icoBtn.attr("btnID", btnInfo["btnID"]);
		$icoBtn.attr("title", btnInfo["title"]);
		$icoBtn.addClass(btnInfo["icoClassName"]);
		
		$icoBtn.append($userDataDiv);
		$jPullboxTitleLocal.append($icoBtn);

		if(clickCallFunc != null && clickCallFunc != ""){
			$icoBtn.click(function(event) {
				var paramMap = {};
				if(userData != null && userData != ""){
					for(var key in userData){
						paramMap[key] = userData[key];
					}
				}
				paramMap["btnID"] = btnInfo["btnID"];
				paramMap["label"] = btnInfo["icoClassName"];
				paramMap["title"] = btnInfo["title"];
				clickCallFunc(paramMap);
			});
		}
	}
	/**
	 * 添加内嵌组件
	 * param Object innerElement (内部包含的组件对象)
	 */
	this.addInnerComponet = function(innerElement){
		var $jpullContentLocalObj = globalObj.panelObj.find('>div[elID="jPullboxPanel"]>div[elID="jPullboxLeftHandle"]>div[elID="jPullboxContentPanel"]>div[elID="jPullboxContentLocal"]');
		$jpullContentLocalObj.empty();
		$jpullContentLocalObj.append(innerElement);
	}
	/**
	 * 添加内嵌页面
	 * param String path (内部包含的页面路径)
	 */
	this.addPageContent = function(path){
		var $jpullContentLocalObj = globalObj.panelObj.find('>div[elID="jPullboxPanel"]>div[elID="jPullboxLeftHandle"]>div[elID="jPullboxContentPanel"]>div[elID="jPullboxContentLocal"]');
		
		var $contentIframe = $jpullContentLocalObj.find('iframe[id="jpull-content-iframe"]');
		if($contentIframe.size() == 0){
			$contentIframe = $("<iframe id='jpull-content-iframe' frameborder='NO' border='0' scrolling='yes' noresize framespacing='0' style='width:100%; height:100%'/>");
			$contentIframe.attr("allowtransparency", true);
			//iframe内容load完成事件监听器
			$contentIframe.bind("load", function(){
				if(settings.contentDisabled){
					$($iframeObj.get(0).contentWindow.document.body).find("*").each(function(){
							this.disabled = settings.contentDisabled;
					});
				}
			});
			$jpullContentLocalObj.append($contentIframe);
		}
		$contentIframe.attr("src", path);
	}
	/**
	 * 设置content部分的可用性
	 * param boolean state
	 */
	this.setContentDisabled = function(state){
		//设置内嵌iframe load内容的只读性
		settings.contentDisabled = state;
	}
	/**
	 * 设置content部分内嵌组件的可用性
	 * param boolean state
	 */
	this.setInnerComponetDisabled = function(state){
		//设置内嵌组件只读性
		var $jpullContentLocalObj = globalObj.panelObj.find('>div[elID="jPullboxPanel"]>div[elID="jPullboxLeftHandle"]>div[elID="jPullboxContentPanel"]>div[elID="jPullboxContentLocal"]');
		$jpullContentLocalObj.find("*").each(function(){
			this.disabled = state;
		});
	}

}

var JDynamicPullPanel = function(){
  function innerJDynamicPullPanel(conf, cfncconf){
	cfncconf = cfncconf ? cfncconf :{};
	$.extend(conf, cfncconf);
	this.init(conf, {domStru: "default_JDynamicPullPanel_DomStruFn",
					domCtrl: "default_JDynamicPullPanel_DomCtrlFn",
					compFn: "defatule_JDynamicPullPanel_ComponetFn"
				  });    
  }
  
  CFNC.registDomStruFn("default_JDynamicPullPanel_DomStruFn", default_JDynamicPullPanel_DomStruFn);
  CFNC.registDomCtrlFn("default_JDynamicPullPanel_DomCtrlFn", default_JDynamicPullPanel_DomCtrlFn);
  CFNC.registComponetFn("defatule_JDynamicPullPanel_ComponetFn", defatule_JDynamicPullPanel_ComponetFn);
  
  return innerJDynamicPullPanel;
}();

$.apply(JDynamicPullPanel, Componet);
