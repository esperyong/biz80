var AccordionMenu = function(){
  function innerAccordionMenu(conf,mvc){
    mvc = mvc ? mvc :{};
    $.extend(conf,mvc);
    this.init(conf,{domStru:mvc.accordionMenu_DomStruFn ? mvc.accordionMenu_DomStruFn  : "default_accordionMenu_DomStruFn",
                    domCtrl:mvc.accordionMenu_DomCtrlFn ? mvc.accordionMenu_DomCtrlFn : "defatul_accordionMenu_DomCtrlFn",
                    compFn:mvc.accordionMenu_ComponetFn ? mvc.accordionMenu_ComponetFn : "default_accordionMenu_ComponetFn"
                  });
  }
  CFNC.registDomStruFn("default_accordionMenu_DomStruFn",default_accordionMenu_DomStruFn);
  CFNC.registDomCtrlFn("defatul_accordionMenu_DomCtrlFn",defatul_accordionMenu_DomCtrlFn);
  CFNC.registComponetFn("default_accordionMenu_ComponetFn",default_accordionMenu_ComponetFn);


  return innerAccordionMenu;
}();

function default_accordionMenu_DomStruFn(conf){
	var self = this;
	var cutHeight = conf.cutHeight ? conf.cutHeight:60;
	self.$ad = $("#"+conf.id);
	// -15 是为了去除底边的一级菜单高度
	var height =  document.body.offsetHeight - 15;
	self.$ad.height(height-cutHeight);
	var $panels = self.$ad.children("div");
	self.items = [];
	self.current=0;

	var panelsCount = $panels.length;
	var contentHeight = 41+(panelsCount-1)*30;
	// 改为-30 是因为 左侧panel上下margin都是12 所以改为-24
	self.cHeight = height-60-contentHeight-24;
	for(var i=0; i<panelsCount; i++){
		var $item = $($panels[i]);
		var $content = $item.children("div:last");
		$content.height(self.cHeight);
		if($content.attr("display")=="block"){
			self.current = i;
		}
		self.items.push({index:i,$head:$item.children("div:first"),$content:$content,$panel:$item});
	}
	// 绑定窗口大小改变事件，在窗口大小改变后调成左侧panel的高度
	$(window).resize(function(){
		accordionResize(conf.id, conf.cutHeight);
	});

}



function defatul_accordionMenu_DomCtrlFn(conf){
	var self = this;
	self.isanimal = false;

	self.interval = null;

	self.animal = function(next){
		if(!self.isanimal && next!=self.current){
			self.isanimal = false;
			var next = self.items[next];
			var current = self.items[self.current];

			self.$ad.prepend(next.$panel);
			if(self.current==0){  //如果当前的为第一个，则把它放在新的后面
				next.$panel.after(current.$panel);
			}else if(self.current==self.items.length-1 && next!=0){//如果当前的是索引最后一个，加入到最后一个
				self.$ad.append(current.$panel);
			}else{
				self.items[self.current-1].$panel.before(current.$panel);
			}
			current.$panel.removeClass("left-panel-open").addClass("left-panel-close");
			next.$panel.removeClass("left-panel-close").addClass("left-panel-open");
			// 获取之前显示的模块的高度，以便为将要打开的模块设置高度
			var t_height = current.$panel.height();
			self.current = parseInt(next.$head.attr("index"));

			current.$content.height(0);
			//next.$content.height(self.cHeight);
			// 设置当前打开模块的高度，-30 是为了去除模块标题部分高度
			next.$content.height(t_height-30);
		}
	}
}

function default_accordionMenu_ComponetFn(conf){
	var self = this;
	var according = function (){
		var $head = $(this);
		self.animal(parseInt($head.attr("index")));
		if(conf.listeners && conf.listeners.expend){
			conf.listeners.expend($head.attr("index"));
		}
	}
	self.changeItemName = function(index,text) {
		self.$ad.find('div[dindex='+index+']').find('div[index='+index+']:first').find("span").html(text);
		return self;
	}
	self.unbinding = function(index) {
		self.$ad.find('div[dindex='+index+']').find('div[index='+index+']:first').unbind("click",according);
		self.$ad.find('div[dindex='+index+']').find('div[index='+index+']:first').unbind("animateEvent",according);
		return self;
	}
	self.binding = function(conf) {
		self.$ad.find('div[dindex='+conf.index+']').find('div[index='+conf.index+']:first').unbind().bind("click",conf.fn);
		return self;
	}
	self.bindAnimate = function(index) {
		self.$ad.find('div[dindex='+index+']').find('div[index='+index+']:first').unbind("animateEvent",according);
		self.$ad.find('div[dindex='+index+']').find('div[index='+index+']:first').bind("animateEvent",according).trigger("animateEvent");
		return self;
	}
	for(var i=0;i<self.items.length;i++){
		var item = self.items[i];
		item.$head.bind("click",according);
	}
}


function inner_accordionMenu_DomStruFn(conf){
	var self = this;
	self.$ad = $("#"+conf.id);
	var parentHeight = self.$ad.parent().height();
	var $panels = self.$ad.children("div");

	self.items = [];
	self.current=0;
	var panelsCount = $panels.length;
	self.cHeight = parentHeight - panelsCount*24-30;
	for(var i=0; i<panelsCount; i++){
		var $item = $($panels[i]);
		var $head = $item.children("div:first");
		var $content = $item.children("div:last");
		$content.height(self.cHeight);
		if($item.hasClass("tree-panel-open")){
			self.current = i;
		}
		self.items.push({index:i,$head:$head,$content:$content,$panel:$item});
	}

}

CFNC.registDomStruFn("inner_accordionMenu_DomStruFn",inner_accordionMenu_DomStruFn);
function inner_accordionMenu_DomCtrlFn(conf){
	var self = this;

	self.animal = function(next){
		if(!self.isanimal && next!=self.current){
			self.isanimal = true;
			var n= self.items[next];
			var current = self.items[self.current];
			current.$panel.removeClass("tree-panel-open").addClass("tree-panel-close");
			n.$panel.removeClass("tree-panel-close").addClass("tree-panel-open");
			self.current= next;
			self.isanimal = false;
		}
	};
}

CFNC.registDomCtrlFn("inner_accordionMenu_DomCtrlFn",inner_accordionMenu_DomCtrlFn);



$.apply(AccordionMenu,Componet);



function accordionResize(panelId, otherHeight){
	if(null != panelId){
		//当页面改变大小时 修改左侧panel的整体高度
		var cutHeight = otherHeight ? otherHeight:60;

		var t_panel = $("#"+panelId);
		var height =  document.body.offsetHeight - 15;

		t_panel.height(height-cutHeight);
		var $panels = t_panel.children("div");


		var panelsCount = $panels.length;
		var contentHeight = 41+(panelsCount-1)*30;
		var cHeight = height-60-contentHeight-24;
		for(var i=0; i<panelsCount; i++){
			var $item = $($panels[i]);
			var $content = $item.children("div:last");
			$content.height(cHeight);

		}

		//修改左侧panel中每个模块下子模块的高度
		var t_panel_kids = t_panel.find('.left-panel-open').find('.tree-panel-close');
		var t_openKids = t_panel.find('.left-panel-open').find('.tree-panel-open');
		var t_panelsCount = t_panel_kids.length;

		if(panelsCount > 0){
			var t_height = t_panel.find('.left-panel-open').children("div:last").height();
			var t_cHeight = t_height - (t_panelsCount+1)*24-30;

			var $item = $(t_openKids[0]);
			var $head = $item.children("div:first");
			var $content = $item.children("div:last");
			$content.height(t_cHeight);

			for(var i=0; i<panelsCount; i++){
				var $item = $(t_panel_kids[i]);
				var $head = $item.children("div:first");
				var $content = $item.children("div:last");
				$content.height(t_cHeight);
			}
		// 如果没有关闭的子模块 可能只有一个模块
		}else{
			var t_height = t_panel.find('.left-panel-open').children("div:last").height();
			var t_cHeight = t_height -30;

			var $item = $(t_openKids[0]);
			var $head = $item.children("div:first");
			var $content = $item.children("div:last");
			$content.height(t_cHeight);
		}
	}

}
