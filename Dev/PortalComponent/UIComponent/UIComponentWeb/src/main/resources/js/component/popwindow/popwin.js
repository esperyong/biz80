var PopWindow = function () {
	function innerPopWindow ( conf , mvc ) {
		conf = conf || {} ;
		mvc = mvc || {};
		$.extend(conf,mvc);
		this.init(conf, {domStru:mvc.popWindow_DomStruFn ? mvc.popWindow_DomStruFn  : "default_popWindow_DomStruFn",
                    domCtrl:mvc.popWindow_DomCtrlFn ? mvc.popWindow_DomCtrlFn : "defatul_popWindow_DomCtrlFn",
                    compFn:mvc.popWindow_ComponetFn ? mvc.popWindow_ComponetFn : "default_popWindow_ComponetFn"
                  });
	}
	CFNC.registDomStruFn("default_popWindow_DomStruFn",default_popWindow_DomStruFn);
	CFNC.registDomCtrlFn("defatul_popWindow_DomCtrlFn",defatul_popWindow_DomCtrlFn);
	CFNC.registComponetFn("default_popWindow_ComponetFn",default_popWindow_ComponetFn);
	return innerPopWindow;
}();

/*
	*conf{
	* 	x:(screen.width - 500)/2,
	*	y:(screen.height - 300*2)/2,
	*	width:'500',
	*	height:'300',
	*	title:'title',
	*	topButs:[{_id:'win-close',_class:'pop-quit',_listener:function(){window.close();},_title:'close'}],
	*	botButs:[{_id:'confirm_button',_listener:function(){window.close();},_text:'ok'}],
	*	html:'<a>haha</a>'
	*}
*
*/
function default_popWindow_DomStruFn(conf,mvc){
	var swidth = conf.width || 500;
	var sheight = conf.height || 500;
	var self = this;
	getBrowserProperty.apply(self);
	var defaultValue = {
		x:conf.x || self.scrollLeft + (self.browserwidth - swidth) / 2,
		y:conf.y || self.scrollTop + (self.browserheight - sheight) / 2,
		width:'500',
		height:'300',
		title:'title',
		overlay:true,
		shieldEvent:true,
		topButs:[{_id:'win-close',_class:'pop-quit',_listener:function(){self.hide();},_title:'关闭'}],
		botButs:[{_id:'confirm_button',_listener:function(){window.close();},_text:'ok'}],
		html:'<a>haha</a>'
	}
	$.extend(defaultValue,conf);
	conf = defaultValue;
	
	self.$all = $('<div class="pop-win"></div> ');
	self.title = conf.title;
	
	var $outTop = $('<div class="pop-win-tl"></div>');
	var $midTop = $('<div class="pop-win-tr"></div>');
	var $coreTop = $('<div class="pop-win-tc"></div>');
	var $title = $('<div class="pop-title"><div class="pop-title-m">'+self.title+'</div></div>');
	$coreTop.append($title);
	for(var i in conf.topButs){
		var btn = conf.topButs[i];
		if(btn._id){
			var $a = $('<div class="' + btn._class + '" id="' + btn._id + '"></div>');
			if(btn._title){
				$a.attr('title',btn._title);
			}
			if(btn._listener){
				$a.bind('click',btn._listener);
			}
			$coreTop.append($a);
		}
	}
	$outTop.append($midTop.append($coreTop));
	
	var $middle = $('<div class="pop-win-m"></div>');
	var $html = $(conf.html);
	var $content = $('<div class="pop-win-content"></div>');
	$content.append($html);
	if(conf.height){
		$content.height(conf.height);
	}
	$middle.append($content);

	var $bottom = $('<div class="pop-win-bl"><div class="pop-win-br"><div class="pop-win-bc"></div></div></div>');
	for(var i in conf.botButs){
		var btn = conf.botButs[i];
		if(btn._id){
			var $a = $('<span class="win-button" id="' + btn._id + '"><span class="win-button-border"><a>'+btn._text+'</a></span></span>');
			if(btn._listener){
				$a.bind('click',btn._listener);
			}
			$bottom.find('.pop-win-bc').append($a);
		}
		
	}
		
	if(conf.width){
		self.$all.css("width",conf.width+"px");
	}
	
	self.$all.append($outTop).append($middle).append($bottom).css("top",document.documentElement.scrollTop+conf.y+"px").css("left",conf.x+"px").css("position","absolute").css("z-index","99999").hide();


	$("body").append(self.$all);
}

function defatul_popWindow_DomCtrlFn(conf){
	var self = this;
	self.show = function(conf){
		conf = conf || {};
		self.$all.fadeIn('fast');
	var defaultValue = {shieldEvent:true};
	$.extend(defaultValue,conf);
	conf = defaultValue;
	if(conf.shieldEvent){
		if(conf.overlay){
			overlay({opacity: 0.5});
			
		}else{
			overlay({opacity: 0.1});
		}
		
	}else{

	}

	};
	
	self.hide = function(){
		self.$all.fadeOut('fast');
		$('[id=overlay]').remove();
	};
	
	self.setTitle = function(title){
		self.title = title;
		self.$all.find('.pop-top-title').html(self.title);
	}
	
	self.setContentText = function (text){
		self.$all.find('span.txt').html(text);
	}
	
	self.setContentHtml = function(html){
		self.$all.find('.pop-win-content').html($(html));
	
	}
	self.setSubTipText = function(text){
		var tip = self.$all.find('span[id=subTip]');
		tip.attr({title:text,style:"color:red;"})
		tip.html(text);
		var tipdiv = self.$all.find('div[id=subtipDiv]');
		tipdiv.width ( self.$all.width() * 0.8);
	}
	self.setConfirm_listener = function(lis){
		self.$all.find('#confirm_button').unbind();
		self.$all.find('#confirm_button').bind('click',lis);
	}
	self.setCancle_listener = function(lis){
		self.$all.find('#cancle_button').unbind();
		self.$all.find('#cancle_button').bind('click',lis);
	}
	self.setClose_listener = function(lis) {
		self.$all.find('#win-close').unbind();
		self.$all.find('#win-close').bind('click',lis);
	}
	self.offset=function(conf){
		self.$all.css(conf);
	}
}
	overlay = function(ops,id){	//覆盖层
		ops = ops || {};
		var ops = $.extend({
				position: 'fixed', top: 0, left: 0,
				width: '100%',height: '100%',
				opacity: 0.9, background: 'black', zIndex: 99
			}, ops),
		id = id || 'overlay';
		if( $.fn.ie6 ) ops = $.extend(ops, {
			position: 'absolute',
			width: Math.max($(window).width(),$(document.body).width()),
			height: Math.max($(window).height(),$(document.body).height()) });

		return $('<div class="overlay" id="'+id+'"/>').appendTo(document.body).css(ops);
	};

function default_popWindow_ComponetFn(conf){

}
function getBrowserProperty(){
	var windowobj = $(window);
	this.browserwidth = windowobj.width();
	this.browserwidth = windowobj.width();
	this.browserheight = windowobj.height();
	this.scrollLeft = windowobj.scrollLeft();
	this.scrollTop = windowobj.scrollTop();
}

$.apply(PopWindow,Componet);

/*
*确认对话框，‘确定取消’
*
*/
var confirm_box = function(conf){
	conf = conf || {};
	var defaultValue = {text:'',cancle_listener:function(){popwind.hide()},close_listener:function(){popwind.hide()}};
	$.extend(defaultValue,conf);
	conf = defaultValue;
	if(typeof(conf.cancle_listener)=='string'){
		conf.cancle_listener = function(){popwind.hide()};
	}
	function close(){
		conf.close_listener && conf.close_listener();
		popwind.hide();
	}
	var popwind = new PopWindow({
		width  : conf.width  || 350,
		height : conf.height || 90,
		title  : conf.title  || '提示',
		overlay: conf.overlay,
		html   : '<div class="promp-win-content" style="text-align: left; padding-left: 5px; padding-top: 8px;"><span class="promp-win-ico promp-win-ico-question"><span class="txt" style="padding-left: 10px;">' + conf.text + '</span></span><div id="subtipDiv" style="text-align: center; width: 200px; margin: 0px auto; text-overflow: ellipsis; white-space: nowrap; overflow: hidden;"><span  id="subTip" ></span></div></div>',
		topButs:[{_id:'win-close',_class:'pop-quit',_listener:close,_title:'关闭'}],
		botButs:[{_id:'cancle_button',_listener:conf.cancle_listener,_text:'取消'},{_id:'confirm_button',_listener:conf.confirm_listener,_text:'确认'}]
		
	});
	return popwind;
};

/*
*提示对话框，‘确定’
*
*/
var information = function(conf){
	conf = conf || {};
	var defaultValue = {text:'',
			shieldEvent:true,
			confirm_listener:function(){popwind.hide()},
			close_listener:function(){popwind.hide()}
	};
	$.extend(defaultValue,conf);
	conf = defaultValue;
	function close(){
		conf.close_listener && conf.close_listener();
		popwind.hide();
	}
	var popwind = new PopWindow({
		width  : conf.width  || 350,
		height : conf.height || 80,
		x      : conf.left,
		y      : conf.top,
		title  : conf.title  || '提示',
		overlay: conf.overlay,
		shieldEvent : true,
		html   : '<div class="promp-win-content"><span class="promp-win-ico promp-win-ico-alert"><span class="txt">' + conf.text + '</span></span><div id="subtipDiv" style="text-align: center; width: 200px; margin: 0px auto; text-overflow: ellipsis; white-space: nowrap; overflow: hidden;"><span  id="subTip" ></span></div></div>',
		botButs:[{_id:'confirm_button',_listener:conf.confirm_listener,_text:'确认'}],
		topButs:[{_id:'win-close',_class:'pop-quit',_listener:close,_title:'关闭'}]
	});
	return popwind;
};


