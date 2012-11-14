var winPanel = function(conf){
	//alert(conf);
  function innerGridPanel(conf,mvc){
    mvc = mvc ? mvc :{};
    $.extend(conf,mvc);
    this.init(conf,{domStru :  mvc.winpanel_DomStruFn ? mvc.winpanel_DomStruFn  : "default_winpanel_DomStruFn",
                    domCtrl : mvc.winpanel_DomCtrlFn ? mvc.winpanel_DomCtrlFn : "defatul_winpanel_DomCtrlFn",
                    compFn : mvc.winpanel_ComponetFn ? mvc.winpanel_ComponetFn : "default_winpanel_ComponetFn"
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
    self.$title = $("<span class=\"pop-top-title left\">"+conf.title+"</span>");
    self.$head = $("<div class=\"pop-top-m\"></div>");
    //self.$head.append(self.$closeBtn).append(self.$title);
    self.$head.append(self.$title);
    
    var outContent = $("<div class=\"pop-middle-m\"></div>");
    
    //var isFloat = conf["isFloat"] ? conf["isFloat"] : false;
    
    var midContent = $("<div class=\"pop-content\" ></div>").css("position","static");
    self.$content = $("<div class=\"content\" ></div>").css("position","relative"); //内容
    //if(isFloat){
    	//self.$content.css("position","static");
    //}
    
    outContent.append(midContent.append(self.$content));
    
    self.$contentBtn = $("<div class=\"pop-bottom-m\"></div>");//底部按钮集合
    
    self.$moiddle = $('<div class=\"pop-middle-l\"></div>').append($('<div class=\"pop-middle-r\"></div>').append(outContent));
    
    self.$panel = $("<div class=\""+cls+"\"></div>").append($("<div class=\"pop-top-l\">").append($("<div class=\"pop-top-r\">").append(self.$head).append(self.$closeBtn))).append(self.$moiddle);
    if(conf.tools && conf.tools.length > 0){
    	
      for(var i=0;i<conf.tools.length;i++){
        var tool = conf.tools[i];
        var $btn = $("<span class=\"black-btn-l\"><span class=\"btn-r\"><span class=\"btn-m\"><a>"+tool.text+"</a></span></span></span>");
        $btn.click(tool.click);
        self.$contentBtn.append($btn);
      }
      var $bottom = $('<div class="pop-bottom-l" style="position:relative;"></div>').append($('<div class="pop-bottom-r"></div>').append(self.$contentBtn));
      self.$panel.append($bottom);
    }else{
    	var $bottom = $("<div class=\"pop-bottom-nbtn-l\" style=\"position:relative;\"><div class=\"pop-bottom-nbtn-r\"><div class=\"pop-bottom-nbtn-m\"></div></div></div>");
    	self.$panel.append($bottom);
    }
    
    $(document.body).append(self.$panel);    
    
    
}
CFNC.registDomStruFn("pop_winpanel_DomStruFn",pop_winpanel_DomStruFn);


function blackLayer_winpanel_DomStruFn(conf){
	
	 //alert("conf ::"+conf.width);
      var self = this;
      var cls = "pop-black";
    
      self.$head = $("<div class=\"pop-top-m\">页面上部修饰</div>");
      
      self.$content = $("<div class=\"pop-content\"></div>"); //内容
      
      self.$contentBtn = $("<div class=\"pop-bottom-m\">页面下部修饰</div>");
      
      
      self.$moiddle = $('<div class=\"pop-middle-l\"></div>').append($('<div class=\"pop-middle-r\"></div>').append(self.$content));
      
      var $bottom = $('<div class="pop-bottom-l"></div>').append($('<div class="pop-bottom-r"></div>').append(self.$contentBtn));
      
      self.$panel = $("<div class=\""+cls+"\" style=\"left:"+conf.x+"px;top:"+conf.y+"px\"></div>")
	  .append($("<div class=\"pop-top-l\">")
	  .append($("<div class=\"pop-top-r\">")
	  .append(self.$head)))
	  .append(self.$moiddle)
	  .append($bottom);
      $(document.body).append(self.$panel);      
}

CFNC.registDomStruFn("blackLayer_winpanel_DomStruFn",blackLayer_winpanel_DomStruFn);

function blackLayer_winpanel_DomStruFn_Portlet(conf){
	
    var self = this;
    var cls = "pop-black";
    self.$head = $("<div class=\"pop-top-m\">页面上部修饰</div>");
    self.$content = $("<div class=\"pop-content\">"+conf.content+"</div>"); //内容
    self.$contentBtn = $("<div class=\"pop-bottom-m\">页面下部修饰</div>");
    self.$moiddle = $('<div class=\"pop-middle-l\"></div>').append($('<div class=\"pop-middle-r\"></div>').append(self.$content));
    var $bottom = $('<div class="pop-bottom-l"></div>').append($('<div class="pop-bottom-r"></div>').append(self.$contentBtn));
    
    self.$panel = $("<div class=\""+cls+"\" style=\"left:"+conf.x+"px;top:"+conf.y+"px\"></div>")
	  .append($("<div class=\"pop-top-l\">")
	  .append($("<div class=\"pop-top-r\">")
	  .append(self.$head)))
	  .append(self.$moiddle)
	  .append($bottom);
    $(document.body).append(self.$panel);      
}

CFNC.registDomStruFn("blackLayer_winpanel_DomStruFn_Portlet",blackLayer_winpanel_DomStruFn_Portlet);


function blackLayer_winpanel_DomStruFn_table(conf){
	// alert("conf ::"+conf.html);
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

CFNC.registDomStruFn("blackLayer_winpanel_DomStruFn_table",blackLayer_winpanel_DomStruFn_table);

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
	temp.setBackGroundColor = function(color){
		temp.$moiddle.find('.pop-content').css('background-color', color);
	}
	
	
	temp.$panel.width(conf.width);
	temp.$panel.find('.pop-content').height(conf.height);
	temp.$panel.find('.pop-content').css('overflow',"hidden");
	temp.$moiddle.find('.pop-content').css('background-color',conf.color);
	//temp.$panel.height(conf.height);
	//temp.$moiddle.height(conf.height-78);
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
		    temp.$content.find("*").unbind();
		    temp.$content.empty();
		    temp.$content.append(data);
		        if(conf.listeners && conf.listeners.loadAfter){
		          conf.listeners.loadAfter();
		        }		    
		  }
		});
	}
	//////////////////////////////
	temp.creatTable = function(whatTable,titleJson,widthJson,tableJson){
	 
	var $whatTable = $("<span class=\"bold\">"+whatTable+"</span>");
	     var tableStr = (new Function("return"+tableJson))();
	     var titleStr = (new Function("return"+titleJson))();
	     var widthStr = (new Function("return"+widthJson))();
	     var $tableDiv = $("<div class=\"grid-gray\" id=\"tableMonitor\" style=\"width:100%;\"></div>");
	     var $headDiv1 = $("<div class=\"roundedform-top\"></div>");
	     var $headDiv2 = $("<div class=\"top-right\"></div>");
	     var $headDiv3 = $("<div class=\"top-min\"></div>");
	     var $headTable = $("<table class=\"hundred\"></table>");
	     var $tableHead = $("<thead></thead>");
	     var $tr = $("<tr></tr>");
	     if(titleStr){
	     	var titleLen = titleStr.length;
	     	for(var i=0;i<titleLen;i++){
	     		var colId = titleStr[i].colId;
	     		$tr.append($("<th colId=\""+titleStr[i].colId+"\" style=\"width:"+widthStr[colId]+"\"></th>").append("<span style=\"color: #fff; font-weight: bolder;\"/>"+titleStr[i].text+"</span>"));
	        }
	     }
	    
	     $tableHead.append($tr);
	     $headDiv1.append($headDiv2.append($headDiv3.append($headTable.append($tableHead))));
	     var $tableContentDiv = $("<div class=\"roundedform-content\" style=\"height: 100%;\"></div>");
	     var $table =  $("<table style=\"margin-left:-7px;width:455px\"  class=\"hundred\"></table>");
	     var $tableBody = $("<tbody></tbody>");
	     var len = tableStr.length;
	   
	     for(var i=0;i<len;i++){
	     	   var $tr = $("<tr></tr>");
	     	   if(i%2 == 0){
	     	      $tr = $("<tr class=\"gray\"></tr>");
	     	   }else{
	     	       $tr = $("<tr class=\"white\"></tr>");
	     	   }
    		   var $tdName = $("<td></td>");
    		   $tdName.append("<span title=\""+tableStr[i].metricName+"\">"+tableStr[i].metricName+"</span>");
    		   $tr.append($tdName);
    		   if(tableStr[i].currentValue){
    		      var $tdVal = $("<td></td>");;
    		      $tdVal.append("<span title=\""+tableStr[i].currentValue+"\">"+tableStr[i].currentValue+"</span>");
    		   }
    		   $tr.append($tdVal);
    		   var $tdState = $("<td></td>");
    		  // var ling_state = jsonstr[i].state;
    		   $tdState.append($("<span style=\"cursor:default\" class=\""+tableStr[i].state+"\"></span>"));
    		   $tr.append($tdState);
    		   var $tdCollectTime =$("<td></td>");
    		   $tdCollectTime.append($("<span style=\"cursor:default\" title=\""+tableStr[i].collectTime+"\">"+tableStr[i].collectTime+"</span>"));
    		   $tr.append($tdCollectTime);
    		 
    		   $tableBody.append($tr);
	     }
	     $table.append($tableBody);
	  
	     $tableContentDiv.append($table);
	  
	     $tableDiv.append($headDiv1).append($tableContentDiv);
	    
	     temp.$content.find("*").unbind();
		 temp.$content.html("").html($whatTable.append($tableDiv));
	     
	}
	/////////////////////////////
	temp.html = function(html){
		//alert(html);
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
	if(conf.whatTable && conf.tableJson && conf.widthJson && conf.titleJson){
		temp.creatTable(conf.whatTable,conf.titleJson,conf.widthJson,conf.tableJson);
	}
	if(conf.isDrag!==false){
	  if(temp.$panel.draggable){
		  temp.$panel.draggable({ snap: true ,handle: temp.$head});
	  }
	}
	
	if(conf.isautoclose){
        function bodyClick(event){
        	try{
             var pos = temp.getPosition();
             var x = pos.left+temp.getWidth();
             var y  = pos.top+temp.getHeight();
             if(event.pageX>=pos.left && event.pageX<=x && event.pageY >=pos.top && event.pageY <=y){
             	 	return;
           	 }
        	}catch(e){
        		
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



