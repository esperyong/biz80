/**
 * 数值滑动条
 *
 * conf对象的属性
 * 		wrapId - 滑动条的外层容器ID
 * 		sliderId - 滑动条ID
 * 		minValue - 最小值
 * 		maxValue - 最大值
 * <---- 以上属性必须设置 ---->
 * 		sliderWidth - 滑动条宽度(默认宽度为110px)
 * 		defaultValue - 默认值
 * 		readOnly - (true, false)
 * 		bindId - 将滑动条的当前值绑定某一显示区域
 *
 */

var NumberSlider = function(){
	function initialization(conf,mvc){
		checkValue(conf);
	    mvc = mvc ? mvc :{};
	    $.extend(conf,mvc);
	    this.init(conf,{domStru :  mvc.numberSlider_DomStruFn ? mvc.numberSlider_DomStruFn  : "default_numberSlider_DomStruFn",
	                    domCtrl : mvc.numberSlider_DomCtrlFn ? mvc.numberSlider_DomCtrlFn : "defatul_numberSlider_DomCtrlFn",
	                    compFn : mvc.numberSlider_ComponetFn ? mvc.numberSlider_ComponetFn : "default_numberSlider_ComponetFn"
	                  });
	}
	function checkValue(conf){
		try{
			if(isNaN(conf.minValue) || isNaN(conf.maxValue) || isNaN(conf.defaultValue)){
				return false;
			}
		}catch(e){
			return false
		}
	}
	CFNC.registDomStruFn("default_numberSlider_DomStruFn",default_numberSlider_DomStruFn);
	CFNC.registDomCtrlFn("defatul_numberSlider_DomCtrlFn",defatul_numberSlider_DomCtrlFn);
	CFNC.registComponetFn("default_numberSlider_ComponetFn",default_numberSlider_ComponetFn);

	return initialization;
}();

function default_numberSlider_DomStruFn(conf){
	var self = this;
	var t_sliderId = conf.sliderId;
	var t_minValue = parseInt(conf.minValue);
	var t_maxValue = parseInt(conf.maxValue);
	var t_style = '';
	if('gray' == conf.style){
		t_style = 'Gray';
	}

	self.sliderId = conf.sliderId;
	self.sliderBlock = t_sliderId +'_slider';
	self.currentValue = (null != conf.defaultValue && parseInt(conf.defaultValue)) ? parseInt(conf.defaultValue) : t_minValue;
	self.bindId = conf.bindId;
	self.minValue = t_minValue;
	self.maxValue = t_maxValue;
	self.readOnly = false;
	//原始的滑动条结构
	//self.$sliderBar = $('<div class="sliderBar'+t_style+'" id="' + t_sliderId + '"></div>');
	//self.$sliderBody = $('<div class="sliderBarBody"><div class="slider" id="' + self.sliderBlock +'"></div><div class="sliderBarLast"></div></div>');
	//self.$sliderMinMax = $('<div class="sliderMinMax" style="width:154px;"><span class="min">'+t_minValue+'</span><span class="max">'+t_maxValue+'</span></div>');

	//新的滑动条结构 By KangQiang for 2011.9.21
	self.$sliderBar = $('<div class="sliderBar01" id="' + t_sliderId + '"></div>');
	self.$sliderBody = $('<div class="sliderBar01-l"><div class="sliderBar01-r"><div class="sliderBar01-m"><div class="slider01" id="' + self.sliderBlock +'"></div></div></div></div>');
	self.$sliderMinMax = $('<div class="sliderMinMax01"><div class="min">'+t_minValue+'</div><div class="max">'+t_maxValue+'</div></div>');
	
	self.$sliderBar.append(self.$sliderBody);
	self.$sliderBar.append(self.$sliderMinMax);
	
	$('#'+conf.wrapId).append(self.$sliderBar);

}

function bindNumberSliderDragEvent(sliderObj){
	var domId = sliderObj.sliderBlock;
	var t_dom = document.getElementById(domId);
	//初始化参数
	var t_dragDom = $('#'+domId);
	//鼠标的 X 和 Y 轴坐标
	var t_mouseDownX = t_mouseDownY = 0;
	var t_domX = t_dom.parentNode.offsetLeft;
	var t_domY = t_dom.offsetTop;
	var t_domWidth = t_dom.parentNode.offsetWidth;
	
	t_domWidth = 0 == t_domWidth ? parseInt($('#'+sliderObj.sliderId).css('width')) : t_domWidth;

	var t_min = sliderObj.minValue;
	var t_max = sliderObj.maxValue;
	var t_offsetValue = 4;

	t_dragDom.bind('mousedown', function(evt){
		// 计算拖动对象的坐标
		t_mouseDownX = evt.pageX - t_dom.offsetLeft;
		t_mouseDownY = evt.pageY - t_dom.offsetTop;
		t_dom.setCapture && t_dom.setCapture();
		$(document).bind('mousemove',mouseMove).bind('mouseup',mouseUp);
	});
	//移动事件
	function mouseMove(evt){
		var t_currentX = evt.pageX - t_mouseDownX;
		t_currentX = t_currentX <= t_domX ? 4 : t_currentX;
		t_currentX = t_currentX >= t_domWidth-6 ? t_domWidth-6 : t_currentX;

		t_dragDom.css('left',t_currentX+'px');
		t_currentX = t_currentX == 4 ? t_min : t_currentX-4;
		t_currentX = t_currentX == t_domWidth-t_domX-4 ? t_domWidth-t_domX : t_currentX;

		var t_step = (t_domWidth-10)/(t_max-t_min);
		t_step = t_step <= 0 ? 1:t_step;

		var t_sliderValue = parseInt(t_currentX/t_step);
		if(t_currentX/t_step == t_min/t_step || t_sliderValue==0){
			sliderObj.currentValue = t_min;
		}else {
			sliderObj.currentValue = t_sliderValue+t_min;
		}

		sliderObj.setBindObjValue(sliderObj.currentValue);

	}
	function mouseUp(evt){
		t_dom.releaseCapture && t_dom.releaseCapture();
		$(document).unbind('mousemove',mouseMove).unbind('mouseup',mouseUp);
	}
}

function defatul_numberSlider_DomCtrlFn(conf){
	var self = this;
	self.getSliderValue = function(){
		return self.currentValue;
	}
	self.setSliderValue = function(sliderValue){
		var t_sliderValue = parseInt(sliderValue);
		if(!isNaN(t_sliderValue) && !self.readOnly){

			t_sliderValue = t_sliderValue > conf.maxValue ? conf.maxValue : t_sliderValue;
			t_sliderValue = t_sliderValue < conf.minValue ? conf.minValue : t_sliderValue;

			var domId = self.sliderBlock;
			var t_dragDom = $('#'+domId);
			var t_dom = document.getElementById(domId);
			var t_domWidth = t_dom.parentNode.offsetWidth;
			if(t_domWidth == 0){
				t_domWidth = conf.sliderWidth;
			}
			var t_step = t_domWidth/conf.maxValue;

			t_step = t_step <= 0 ? 1:t_step;

			var t_realSliderValue = t_sliderValue;
			t_realSliderValue = t_realSliderValue == 1 ? 0.5 :t_realSliderValue;
			var t_currentX = parseInt(t_realSliderValue*t_step);
			t_dragDom.css('left',t_currentX+'px');

			self.currentValue = t_sliderValue;

			self.setBindObjValue(t_sliderValue);
		}
	}
	
	self.isReadOnly = function(isReadOnly){
		if(isReadOnly){
			$('#'+self.sliderBlock).unbind('mousedown');
			self.readOnly = true;
		}else{
			bindNumberSliderDragEvent(self);
			self.readOnly = false;
		}
	}
	self.setBindObjValue = function(value){
		try{
			$('#'+self.bindId).val(self.currentValue);
		}catch(e){
			$('#'+self.bindId).text(self.currentValue);
		}
	}
}

/*
 * 用于设置滑动条的默认值与可使用状态
 * */
function default_numberSlider_ComponetFn(conf){
	var self = this;
	
	
	if(conf.sliderWidth){
		$('#'+conf.sliderId).css('width', conf.sliderWidth);
	}

	bindNumberSliderDragEvent(self);

	if(conf.defaultValue){
		self.setSliderValue(conf.defaultValue);
	}
	if(conf.readOnly){
		self.isReadOnly(conf.readOnly);
	}
	if(self.bindId){
		self.setBindObjValue(self.currentValue);
		$('#'+self.bindId).change(function(){
			var t_value = $(this).val();
			self.setSliderValue(t_value);
		})
	}

}


$.apply(NumberSlider,Componet);