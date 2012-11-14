var winPanel = function(conf){
  function innerGridPanel(conf,mvc){
    mvc = mvc ? mvc :{};
    $.extend(conf,mvc);
    this.init(conf,{domStru:mvc.winpanel_DomStruFn ? mvc.winpanel_DomStruFn  : "default_winpanel_DomStruFn",
                    domCtrl:mvc.winpanel_DomCtrlFn ? mvc.winpanel_DomCtrlFn : "defatul_winpanel_DomCtrlFn",
                    compFn:mvc.winpanel_ComponetFn ? mvc.winpanel_ComponetFn : "default_winpanel_ComponetFn"
                  });  
  }
  CFNC.registDomStruFn("default_winpanel_DomStruFn",default_winpanel_DomStruFn);
  CFNC.registDomCtrlFn("defatul_winpanel_DomCtrlFn",defatul_winpanel_DomCtrlFn);
  CFNC.registComponetFn("default_winpanel_ComponetFn",default_winpanel_ComponetFn);
 // $("#draggable").draggable({ snap: true });
  
  return innerGridPanel;
}();



function default_winpanel_DomStruFn(conf){
	var temp = this;
	var cls = conf.cls;
	
	temp.$closeBtn = $("<a class=\"win-ico win-close\"></a>");
	temp.$title = $("<span class=\"pop-top-title\">"+conf.title+"</span>");
	temp.$head = $("<div class=\"panel-top-m\"></div>");
	temp.$head.append(temp.$closeBtn).append(temp.$title);
	
	temp.$content = $("<div class=\"panel-m-content\"></div>"); //内容
	
	temp.$contentBtn = $("<div class=\"panel-m-btn\"></div>");//底部按钮集合
	
	if(conf.tools){
		for(var i=0;i<conf.tools.length;i++){
			var tool = conf.tools[i];
			var $btn = $("<span class=\"black-btn-l\"><span class=\"btn-r\"><span class=\"btn-m\"><a>"+tool.text+"</a></span></span></span>");
			$btn.click(tool.click);
			temp.$contentBtn.append($btn);
		}
	}
	
	
	temp.$moiddle = $("<div class=\"panel-m\"></div>");
	
	
	temp.$moiddle.append(temp.$content).append(temp.$contentBtn);
	
	var $bottom = $("<div class=\"panel-bottom-l\"><div class=\"panel-bottom-r\"><div class=\"panel-bottom-m\"></div></div></div>");
	
	temp.$panel = $("<div class=\""+cls+"\"></div>").append($("<div class=\"panel-top-l\">").append($("<div class=\"panel-top-r\">").append(temp.$head))).append(temp.$moiddle).append($bottom);
	$(document.body).append(temp.$panel);
}


/**新样式*/
function pop_winpanel_DomStruFn(conf){
    var self = this;
    var cls = "pop-div";
  
    self.$closeBtn = $('<a title="关闭" class=\"win-ico win-close\"></a>');
    self.$title = $("<span class=\"pop-top-title\">"+conf.title+"</span>");
    self.$head = $("<div class=\"pop-top-m\"></div>");
    self.$head.append(self.$closeBtn).append(self.$title);
    
    
    self.$content = $("<div class=\"pop-content\"></div>"); //内容
    
    self.$contentBtn = $("<div class=\"pop-bottom-m\"></div>");//底部按钮集合
    
    if(conf.tools){
      for(var i=0;i<conf.tools.length;i++){
        var tool = conf.tools[i];
        var $btn = $("<span class=\"black-btn-l\"><span class=\"btn-r\"><span class=\"btn-m\"><a>"+tool.text+"</a></span></span></span>");
        $btn.click(tool.click);
        self.$contentBtn.append($btn);
      }
    }
    
    
    
    self.$moiddle = $('<div class=\"pop-middle-l\"></div>').append($('<div class=\"pop-middle-r\"></div>').append(self.$content));
    
    var $bottom = $('<div class="pop-bottom-l"></div>').append($('<div class="pop-bottom-r"></div>').append(self.$contentBtn));
    
    self.$panel = $("<div class=\""+cls+"\"></div>").append($("<div class=\"pop-top-l\">").append($("<div class=\"pop-top-r\">").append(self.$head))).append(self.$moiddle).append($bottom);
    $(document.body).append(self.$panel);    
    
    
}
CFNC.registDomStruFn("pop_winpanel_DomStruFn",pop_winpanel_DomStruFn);


function blackLayer_winpanel_DomStruFn(conf){
      var self = this;
      var cls = "pop-black";
    
      self.$head = $("<div class=\"pop-top-m\">页面上部修饰</div>");
      
      self.$content = $("<div class=\"pop-content\"></div>"); //内容
      
      self.$contentBtn = $("<div class=\"pop-bottom-m\">页面下部修饰</div>");
      
      
      self.$moiddle = $('<div class=\"pop-middle-l\"></div>').append($('<div class=\"pop-middle-r\"></div>').append(self.$content));
      
      var $bottom = $('<div class="pop-bottom-l"></div>').append($('<div class="pop-bottom-r"></div>').append(self.$contentBtn));
      
      self.$panel = $("<div class=\""+cls+"\" style=\"left:"+conf.x+"px;top:"+conf.y+"px\"></div>").append($("<div class=\"pop-top-l\">").append($("<div class=\"pop-top-r\">").append(self.$head))).append(self.$moiddle).append($bottom);
      $(document.body).append(self.$panel);      
}

CFNC.registDomStruFn("blackLayer_winpanel_DomStruFn",blackLayer_winpanel_DomStruFn);


//读取结构方式
function blackLayerLoad_winpanel_DomStruFn(conf){
    var self = this;
    self.$panel = $("#"+conf.id);
  var divs  = self.$panel.children("div");
  self.$head = $(divs[0]);
  self.$moiddle = $(divs[1]);
  self.$content = self.$moiddle.children("div").children("div");
  self.$bottom = $(divs[2]);
  
}

CFNC.registDomStruFn("blackLayerLoad_winpanel_DomStruFn",blackLayerLoad_winpanel_DomStruFn);

function defatul_winpanel_DomCtrlFn(conf){
	var temp = this;
	temp.hidden = function(){
		temp.$panel.css("display","none");
	}
	
	temp.show = function(){
		temp.$panel.css("display","block");
	}
	
	temp.setWidth = function(width){
		temp.$panel.width(width);
	}
	
	temp.$panel.width(conf.width);
	temp.setX = function(x){
	  temp.$panel.css("left",x+"px");
	}
	temp.setY = function(y){
	  temp.$panel.css("top",y+"px");
	}
	temp.setPosition = function(x,y){
	  temp.setX(x);
	  temp.setY(y);
	}
	
	temp.getPosition = function(){
		return temp.$panel.position();
	}
	temp.getWidth = function(){
		return temp.$panel.width();
	}
	temp.getHeight = function(){
		return temp.$panel.height();
	}
	
	
	var x = conf.x ? conf.x :0;
	var y = conf.y ? conf.y :0;
	temp.$panel.css("position","absolute");
	temp.setPosition(x,y);
	
}


function default_winpanel_ComponetFn(conf){
	var temp = this;
	
	temp.ajaxLoad = function(url, param){
		temp.$content.find("*").unbind();
		$.ajax({
		  url:url,
		  dataType:"html",
		  cache:false,
		  data:param,
		  type:conf.type?conf.type:"POST",
		  success:function(data){
		    temp.$content.find("*").unbind().html("");
		    temp.$content.append(data);
        if(conf.listeners && conf.listeners.loadAfter){
          conf.listeners.loadAfter();
        }		    
		  }
		});
	}
	
	temp.html = function(html){
		temp.$content.find("*").unbind();
		temp.$content.html("").html(html);
	}
	
	temp.close = function(action){
		if(conf.listeners && conf.listeners.closeBefore){
			conf.listeners.closeBefore();
		}
		
		
		if (action == "close") {
			temp.$panel.find("*").unbind();
			var div = document.createElement("div");
			   div.appendChild(temp.$panel[0]);
			   div.innerHTML="";
			//temp.$panel.remove();
			//document.body.removeChild(temp.$panel[0]);
			//temp.$panel = null;
		}else{
			temp.hidden();
		}
		 $("body").unbind("click",bodyClick);  
		if(conf.listeners && conf.listeners.closeAfter){
			conf.listeners.closeAfter();
		}
	}
	

	if(temp.$closeBtn){
  	temp.$closeBtn.click(function(){
  		temp.close(conf.closeAction?conf.closeAction:"close");
  	});
	  
	}
	
	if(conf.html){
		temp.html(conf.html);
	}else if(conf.url){
		temp.ajaxLoad(conf.url, conf.param);
	}
	
	if(conf.isDrag!==false){
	  if(temp.$panel.draggable){
		  temp.$panel.draggable({ snap: true ,handle: temp.$head});
	  }
	}
	
	if(conf.isautoclose){
        function bodyClick(event){
             var pos = temp.getPosition();
             var x = pos.left+temp.getWidth();
             var y  = pos.top+temp.getHeight();
             if(event.pageX>=pos.left && event.pageX<=x && event.pageY >=pos.top && event.pageY <=y){
            	 	return;
           	 }
              $("body").unbind("click",bodyClick);                    
              temp.close(conf.closeAction ? conf.closeAction: "close");
         }	
        setTimeout(function(){
        	$("body").bind("click",bodyClick);
        	
        },1000);
	}
	
}




$.apply(winPanel,Componet);



