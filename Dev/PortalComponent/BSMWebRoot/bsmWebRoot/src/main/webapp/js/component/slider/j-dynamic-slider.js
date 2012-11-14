/*
* Componet Name: JDynamicSlider
* Author: qiaozheng
* Version: 1.0
* Date: 2010.09
* Desc: 动态创建滑动块组件
*/
function default_JDynamicSlide_DomStruFn(conf){
	
	this.slideSettings = $.extend({
		id:"jSliderRange-1",
		range:"min",
		defaultValue:1,
		min:1,
		max:100
	},conf||{});

	this.sliderObj = $('<div id="'+this.slideSettings.id+'"/>');

	this.sliderObj.slider({
		range:this.slideSettings.range,
		value:this.slideSettings.defaultValue,
		min:this.slideSettings.min,
		max:this.slideSettings.max
	});
	
}

function default_JDynamicSlide_DomCtrlFn(conf){
	
}
function defatule_JDynamicSlide_ComponetFn(conf){
	var globalObj = this;
	var settings = globalObj.slideSettings;
	
	/**
	 * 将组件添加到容器元素中
	 * param Object container 组件所属容器元素(参数：Element,jquery包装器)
	 */
	this.appendToContainer = function(container){
		globalObj.sliderObj.appendTo(container);
		return globalObj.sliderObj.get(0);
	}
	/**
	 * 获取组件句柄根元素
	 * return Element
	 */
	this.getComponetHandle = function(){
		return globalObj.sliderObj.get(0);
	}
	/**
	 * 获取当前滑动块组件上显示的值
	 * return String
	 */
	this.getValue = function(){
		return globalObj.sliderObj.slider("value");
	}
	/**
	 * 设置当前滑动块组件上显示的值
	 * param String value
	 */
	this.setValue = function(value){
		globalObj.sliderObj.slider("value", value);
	}
	/**
	 * 注册当前滑动块组件,数值改变时触发的监听器函数
	 * param function func
	 */
	this.change = function(func){
		globalObj.sliderObj.bind("slide", function(event, ui){
			func(ui.value);
		});
	}

}

var JDynamicSlider = function(){
  function innerJDynamicSlide(conf, cfncconf){
	cfncconf = cfncconf ? cfncconf :{};
	$.extend(conf, cfncconf);
	this.init(conf, {domStru: "default_JDynamicSlide_DomStruFn",
					domCtrl: "default_JDynamicSlide_DomCtrlFn",
					compFn: "defatule_JDynamicSlide_ComponetFn"
				  });    
  }
  
  CFNC.registDomStruFn("default_JDynamicSlide_DomStruFn", default_JDynamicSlide_DomStruFn);
  CFNC.registDomCtrlFn("default_JDynamicSlide_DomCtrlFn", default_JDynamicSlide_DomCtrlFn);
  CFNC.registComponetFn("defatule_JDynamicSlide_ComponetFn", defatule_JDynamicSlide_ComponetFn);
  
  return innerJDynamicSlide;
}();

$.apply(JDynamicSlider, Componet);