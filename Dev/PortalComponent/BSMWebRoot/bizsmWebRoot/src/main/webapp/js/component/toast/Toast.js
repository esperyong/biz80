var Toast = function(conf){
    function innerToast(conf,mvc){
      mvc = mvc ? mvc :{};
      $.extend(conf,mvc);
      this.init(conf,{domStru:mvc.toast_DomStruFn ? mvc.toast_DomStruFn  : "default_toast_DomStruFn",
                      domCtrl:mvc.toast_DomCtrlFn ? mvc.toast_DomCtrlFn : "defatul_toast_DomCtrlFn",
                      compFn:mvc.toast_ComponetFn ? mvc.toast_ComponetFn : "default_toast_ComponetFn"
                    });  
    }
    CFNC.registDomStruFn("default_toast_DomStruFn",default_toast_DomStruFn);
    CFNC.registDomCtrlFn("defatul_toast_DomCtrlFn",defatul_toast_DomCtrlFn);
    CFNC.registComponetFn("default_toast_ComponetFn",default_toast_ComponetFn);
    
    
    return innerToast;
}();

function default_toast_DomStruFn(conf){
  	var self = this;
  	self.height = 93;  
  	self.width = 360;
  	self.count=0;  //当前显示出来的个数
  	if (document.documentElement && document.documentElement.clientHeight && document.documentElement.clientWidth){
  	    self.docHeight=document.documentElement.clientHeight;
  	    self.docWidth = document.documentElement.clientWidth; 
  	}
	
  	self.createToast = function(text,position){
    	  var left,top;
    	  
    	  if(position.indexOf("B")!=-1){
    	    top = self.docHeight - self.height * self.count;
    	  }else if(position.indexOf("T")!=-1){
          top = self.height * (self.count);
          top = top == 0 ? -(self.height) : self.height;
    	  }
    	  if(position.indexOf("L")!=-1){
    	    left = 5;
    	  }else if(position.indexOf("R")!=-1){
    	    left = self.docWidth-self.width;
    	  }else if(position.indexOf("C")!=-1){
    	    left = self.docWidth/2-self.width/2;
    	  }
    	  
    		var $div = $('<div class="w-message" style="z-index:10000;overflow:hidden;position:absolute;left:'+left+'px;top:'+top+'px;width:'+self.width+'px;height:0px"></div>');
    		$div.append('<span class="w-message-font">'+text+'</span>');
    		$("body").append($div);
    		self.count = self.count+1;
    		return $div;
  	}
}

function defatul_toast_DomCtrlFn(conf){
	var self = this;
	self.bindMove = function ($toast,position){
		var top = $toast.position().top;
		if(position.indexOf("B")!=-1){
  		$toast.animate({height:self.height+"px",top:(top-self.height-5)+"px"});
		}else if(position.indexOf("T")!=-1){
		  top = top < 0 ? 0 : (self.count-1)*self.height;
		  $toast.animate({height:self.height+"px",top:(top-5)+"px"});
		}
		setTimeout(function(){
			$toast.fadeOut(function(){
				$toast.unbind();
				$toast.parent()[0].removeChild($toast[0]);
				self.count = self.count - 1;
			});
		},5000);
	}
	function move(){
	}
}

function default_toast_ComponetFn(conf){
	var self = this;
	self.addMessage = function(text){
		
		var $toast = self.createToast(text,conf.position);
		self.bindMove($toast,conf.position)
	}
}
$.apply(Toast,Componet);
