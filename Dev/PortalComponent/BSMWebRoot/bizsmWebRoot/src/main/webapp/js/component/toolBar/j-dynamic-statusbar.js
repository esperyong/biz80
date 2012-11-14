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
	
	this.statusInfoObj = {};
	this.statusInfoObj["red"] = new Array();
	this.statusInfoObj["yellow"] = new Array();
	this.statusInfoObj["green"] = new Array();
	this.statusInfoObj["gray"] = new Array();
	
	this.totalCount = 0;
	
	var $labelItem = $('<li elID="statusbarLabelArea"><span class="title">'+this.statusbarSettings.label+'</span></li>');
	
	var $totalItem = $('<li elID="statusbarTotalArea"><span class="title">总数</span>：<a class="txtunderline"></a></li>');
	$totalItem.find('>a').css("cursor", "hand");
	$totalItem.find('>a').text(this.totalCount);
	
	var $statusRedItem = $('<li elID="statusbarRed"><span class="lamp lamp-red"></span>：<a class="txtunderline"></a></li>');
	$statusRedItem.find('>span').css("cursor", "default");
	$statusRedItem.find('>a').css("cursor", "hand");
	$statusRedItem.find('>a').text((this.statusInfoObj["red"]).length);
	
	var $statusYellowItem = $('<li elID="statusbarYellow"><span class="lamp lamp-yellow"></span>：<a class="txtunderline"></a></li>');
	$statusYellowItem.find('>span').css("cursor", "default");
	$statusYellowItem.find('>a').css("cursor", "hand");
	$statusYellowItem.find('>a').text(this.statusInfoObj["yellow"].length);
	
	var $statusGreenItem = $('<li elID="statusbarGreen"><span class="lamp lamp-green"></span>：<a class="txtunderline"></a></li>');
	$statusGreenItem.find('>span').css("cursor", "default");
	$statusGreenItem.find('>a').css("cursor", "hand");
	$statusGreenItem.find('>a').text(this.statusInfoObj["green"].length);
	
	var $statusGrayItem = $('<li elID="statusbarGray"><span class="lamp lamp-gray"></span>：<a class="txtunderline"></a></li>');
	$statusGrayItem.find('>span').css("cursor", "default");
	$statusGrayItem.find('>a').css("cursor", "hand");
	$statusGrayItem.find('>a').text(this.statusInfoObj["gray"].length);
	
	var $statusItemContainer = $('<ul elID="statusbarItemContainer"/>');
	
	$statusItemContainer.append($labelItem);
	$statusItemContainer.append($totalItem);
	
	$statusItemContainer.append($statusRedItem);
	$statusItemContainer.append($statusYellowItem);
	$statusItemContainer.append($statusGreenItem);
	$statusItemContainer.append($statusGrayItem);
	
	this.panelObj.append($statusItemContainer);
	
	//this.panelObj.append(this.statusPoPObj);
	
	var statusInfoTemp = this.statusInfoObj;
	$statusItemContainer.find("a.txtunderline").click(function(event){
		var $this = $(this);
		
		var rightFrameObj = parent.rightFrame;

		if($this.text() == "0"){
			//$statusItemContainer.find('a[showFlag="true"]').attr("showFlag", "false");
			$statusItemContainer.find('a[showFlag="true"]').click();
			return false;
		}

		if($this.attr("showFlag") == "true"){
			var $statusPoPDivRoot = $(rightFrameObj.document.body).find("#statusPoPDivRoot");
			if($statusPoPDivRoot.size() > 0){
				$statusPoPDivRoot.empty();
			}
			$this.attr("showFlag", "false");
		}else{
			$statusItemContainer.find('a[showFlag="true"]').attr("showFlag", "false");
			var $statusPoPObj = $('<div elID="statusPoPPanel" class="layers-view"></div>');
			var $popTop = $('<div elID="statusPoPTop"><div class="img left-top"></div><div class="img right-top"></div></div>');
			var $popBottom = $('<div elID="statusPoPBottom"><div class="img left-bottom"></div><div class="img right-bottom"></div></div>');
			var $popContent = $('<div elID="statusPoPContent" class="layers-view-content"><ul class="list"></ul></div>');
			
			var $statusUL = $popContent.find('>ul');

			var statusArray = new Array();
			var statusColor = $this.parent('li[elID^="statusbar"]').attr("elID");
			if(statusColor == "statusbarRed"){
				statusArray = statusInfoTemp["red"];
				for(var i=0; i<statusArray.length; i++){
					var statusLi = $('<li id="'+statusArray[i].id+'"><nobr><span class="lamp lamp-red"></span><div style="display:inline;vertical-align:middle;width:140px;overflow:hidden;border:0px solid red;text-overflow:ellipsis;cursor:default;">'+statusArray[i].name+'</div></nobr></li>');
					$statusUL.append(statusLi);
					
				}
			}else if(statusColor == "statusbarYellow"){
				statusArray = statusInfoTemp["yellow"];
				for(var i=0; i<statusArray.length; i++){
					var statusLi = $('<li id="'+statusArray[i].id+'"><nobr><span class="lamp lamp-yellow"></span><div style="display:inline;vertical-align:middle;width:140px;overflow:hidden;border:0px solid red;text-overflow:ellipsis;cursor:default;">'+statusArray[i].name+'</div></nobr></li>');
					$statusUL.append(statusLi);
					
				}
			}else if(statusColor == "statusbarGreen"){
				statusArray = statusInfoTemp["green"];
				for(var i=0; i<statusArray.length; i++){
					var statusLi = $('<li id="'+statusArray[i].id+'"><nobr><span class="lamp lamp-green"></span><div style="display:inline;vertical-align:middle;width:140px;overflow:hidden;border:0px solid red;text-overflow:ellipsis;cursor:default;">'+statusArray[i].name+'</div></nobr></li>');
					$statusUL.append(statusLi);
					
				}
			}else if(statusColor == "statusbarGray"){
				statusArray = statusInfoTemp["gray"];
				for(var i=0; i<statusArray.length; i++){
					var statusLi = $('<li id="'+statusArray[i].id+'"><nobr><span class="lamp lamp-gray"></span><div style="display:inline;vertical-align:middle;width:140px;overflow:hidden;border:0px solid red;text-overflow:ellipsis;cursor:default;">'+statusArray[i].name+'</div></nobr></li>');
					$statusUL.append(statusLi);
					
				}
			}else if(statusColor == "statusbarTotalArea"){
				var statusArray = statusInfoTemp["red"];
				for(var i=0; i<statusArray.length; i++){
					var statusLi = $('<li id="'+statusArray[i].id+'"><nobr><span class="lamp lamp-red"></span><div style="display:inline;vertical-align:middle;width:140px;overflow:hidden;border:0px solid red;text-overflow:ellipsis;cursor:default;">'+statusArray[i].name+'</div></nobr></li>');
					$statusUL.append(statusLi);
					
				}
				var statusArray = statusInfoTemp["yellow"];
				for(var i=0; i<statusArray.length; i++){
					var statusLi = $('<li id="'+statusArray[i].id+'"><nobr><span class="lamp lamp-yellow"></span><div style="display:inline;vertical-align:middle;width:140px;overflow:hidden;border:0px solid red;text-overflow:ellipsis;cursor:default;">'+statusArray[i].name+'</div></nobr></li>');
					$statusUL.append(statusLi);
					
				}
				var statusArray = statusInfoTemp["green"];
				for(var i=0; i<statusArray.length; i++){
					var statusLi = $('<li id="'+statusArray[i].id+'"><nobr><span class="lamp lamp-green"></span><div style="display:inline;vertical-align:middle;width:140px;overflow:hidden;border:0px solid red;text-overflow:ellipsis;cursor:default;">'+statusArray[i].name+'</div></nobr></li>');
					$statusUL.append(statusLi);
					
				}
				var statusArray = statusInfoTemp["gray"];
				for(var i=0; i<statusArray.length; i++){
					var statusLi = $('<li id="'+statusArray[i].id+'"><nobr><span class="lamp lamp-gray"></span><div style="display:inline;vertical-align:middle;width:140px;overflow:hidden;border:0px solid red;text-overflow:ellipsis;cursor:default;">'+statusArray[i].name+'</div></nobr></li>');
					$statusUL.append(statusLi);
					
				}
			}
			
			var $bizAnanlysisFlagDiv = $(rightFrameObj.document.body).find('div[elID="bizAnanlysisFlag"]');
			var bottomNum = 25;
			if($bizAnanlysisFlagDiv.size() > 0){
				bottomNum = -3;
			}

			$statusPoPObj.append($popTop);
			$statusPoPObj.append($popBottom);
			$statusPoPObj.append($popContent);
			//$statusPoPObj.hide();
			$statusPoPObj.css("position", "absolute");
			$statusPoPObj.css("z-index", "1001");
			$statusPoPObj.css("width", "200px");
			$statusPoPObj.css("height", "200px");

			//$statusPoPObj.css("top", $(rightFrameObj.document.body).height()-215);
			$statusPoPObj.css("bottom",  bottomNum);
			$statusPoPObj.css("left", $this.offset().left-30);
			
			var $tempPOP = $('<div></div>');
			var $statusPoPDivRoot = $(rightFrameObj.document.body).find("#statusPoPDivRoot");
			if($statusPoPDivRoot.size() > 0){
				$statusPoPDivRoot.empty();

				$tempPOP.append($statusPoPObj);
				$statusPoPDivRoot.append($tempPOP.html());
			}else{
				$statusPoPDivRoot = $('<div id="statusPoPDivRoot"></div>');
				$statusPoPDivRoot.append($statusPoPObj);
				$tempPOP.append($statusPoPDivRoot);

				$(rightFrameObj.document.body).append($tempPOP.html());
			}
			//$(rightFrameObj.document.body).find("#statusPoPDivRoot").append($statusPoPObj);

			$this.attr("showFlag", "true");

			//$statusPoPObj.show();
		}
		
		//alert($(rightFrameObj.document.body).html());
		//alert($(parent.parent.parent.document.body).html());
		//popObjTemp.appendTo($(parent.parent.parent.document.body));
		//alert($(parent.parent.document.body).html());
	});
	
	/**
	* 关闭弹出的状态窗口
	* 
	*/
	this.closePoP = function(){
		$statusItemContainer.find('a[showFlag="true"]').click();
	}
	
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
	* 设置状态栏显示项目
	* param String colorName 颜色名称
	* param Array statusInfoArray 颜色对应的数据对象
	*
	*/
	this.setColorStatus = function(colorName, statusInfoArray){
		var $itemContainer = globalObj.panelObj.find('>ul[elID="statusbarItemContainer"]');
		
		var $redLocal = $itemContainer.find('>li[elID="statusbarRed"]>a');
		var $yellowLocal = $itemContainer.find('>li[elID="statusbarYellow"]>a');
		var $greenLocal = $itemContainer.find('>li[elID="statusbarGreen"]>a');
		var $grayLocal = $itemContainer.find('>li[elID="statusbarGray"]>a');
		
		if(colorName == "red"){
			$redLocal.text(statusInfoArray.length);
			globalObj.statusInfoObj["red"] = statusInfoArray;
		}else if(colorName == "yellow"){
			$yellowLocal.text(statusInfoArray.length);
			globalObj.statusInfoObj["yellow"] = statusInfoArray;
		}else if(colorName == "green"){
			$greenLocal.text(statusInfoArray.length);
			globalObj.statusInfoObj["green"] = statusInfoArray;
		}else if(colorName == "gray"){
			$grayLocal.text(statusInfoArray.length);
			globalObj.statusInfoObj["gray"] = statusInfoArray;
		}
		
		globalObj.totalCount = globalObj.statusInfoObj["red"].length + globalObj.statusInfoObj["yellow"].length + globalObj.statusInfoObj["green"].length + globalObj.statusInfoObj["gray"].length;
		
		var $totalLocal = $itemContainer.find('>li[elID="statusbarTotalArea"]>a');
		$totalLocal.text(globalObj.totalCount);

		globalObj.closePoP();
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