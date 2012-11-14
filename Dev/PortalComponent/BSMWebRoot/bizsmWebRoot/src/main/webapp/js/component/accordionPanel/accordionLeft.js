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
	self.$ad = $("#"+conf.id);
	
	var $panels = self.$ad.children("div");
	
	self.items = [];
	self.current=0;
	for(var i=0;i<$panels.length;i++){
		var $item = $($panels[i]);
		var $content = $item.children("div:last");
		if($content.attr("display")=="block"){
			self.current = i;
		}
		self.items.push({index:i,$head:$item.children("div:first"),$content:$content,$panel:$item});
	}
	
}



function defatul_accordionMenu_DomCtrlFn(conf){
	var self = this;
	self.isanimal = false;
	
	self.interval = null;
	
	self.animal = function(next){
		if(!self.isanimal && next!=self.current){
			self.isanimal = true;
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
			
			self.current = parseInt(next.$head.attr("index"));
			self.interval = setInterval(function(){
				var currentH = current.$content.height();
				var nextH = next.$content.height();
				if(currentH<=0 ){
					clearInterval(self.interval);
					self.isanimal = false;
				}else{
					current.$content.height(currentH-10);
					next.$content.height(nextH+10);
				}
			},10);
		}
	}
}

function default_accordionMenu_ComponetFn(conf){
	var self = this;
	function according(){
		var $head = $(this);
		self.animal(parseInt($head.attr("index")));
		if(conf.listeners && conf.listeners.expend){
			conf.listeners.expend($head.attr("index"));
		}
	}
	
	
	for(var i=0;i<self.items.length;i++){
		var item = self.items[i];
		item.$head.bind("click",according);
	}
}


function inner_accordionMenu_DomStruFn(conf){
	var self = this;
	self.$ad = $("#"+conf.id);
	
	var $panels = self.$ad.children("div");
	
	self.items = [];
	self.current=0;
	for(var i=0;i<$panels.length;i++){
		var $item = $($panels[i]);
		var $head = $item.children("div:first");
		var $content = $item.children("div:last");
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




