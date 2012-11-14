var AccordionPanel = function(){
  function innerAccordionPanel(conf,mvc){
	    mvc = mvc ? mvc :{};
	    $.extend(conf,mvc);
	    this.init(conf,{domStru:mvc.DomStruFn ? mvc.DomStruFn  : "default_accordionpanel_DomStruFn",
	                    domCtrl:mvc.DomCtrlFn ? mvc.DomCtrlFn : "defatul_accordionpanel_DomCtrlFn",
	                    compFn:mvc.ComponetFn ? mvc.ComponetFn : "default_accordionpanel_ComponetFn"
	                  });  
	  }
	  CFNC.registDomStruFn("default_accordionpanel_DomStruFn",default_accordionpanel_DomStruFn);
	  CFNC.registDomCtrlFn("defatul_accordionpanel_DomCtrlFn",defatul_accordionpanel_DomCtrlFn);
	  CFNC.registComponetFn("default_accordionpanel_ComponetFn",default_accordionpanel_ComponetFn);
	  return innerAccordionPanel;
}();



function default_accordionpanel_DomStruFn(conf){
	var temp = this;
	temp.$accPanel = $("#"+conf.id);
	temp.$accBtn = $(temp.$accPanel.children("div:eq(0)").children("span:last"));
	temp.$accContent = $(temp.$accPanel.children("div:eq(1)"));
}



function defatul_accordionpanel_DomCtrlFn(conf){
	var temp = this;
	
	//主体区域折叠
	temp.animalDom = function(height,callback){

		//height = height==0?"0%":"100%";
		temp.$accContent.animate({ height: height}, { queue: false, duration: "normal" ,step:callback} );
	};
	
	//主体区域淡出
	temp.contentFadeOut = function(){
		temp.$accContent.fadeOut("normal");
	};
	
	//主体区域淡入
	temp.contentFadeIn = function(){
		temp.$accContent.fadeIn("slow");
	};

	//折叠按钮
	temp.foldBtnChange= function(action){
		var collect = "fold-ico-up";
		var expend = "fold-ico-down";
		if(action=="expend"){
			temp.$accBtn.removeClass(expend).addClass(collect);
		}else{
			temp.$accBtn.removeClass(collect).addClass(expend);
		}
	};
	
	temp.displayNone = function(){
		temp.$accContent.css("display","none");
		temp.$accContent.css("height",temp.getContentHeight());
	};
	
	temp.displayBlock = function(){
		temp.$accContent.css("display","block");
		temp.$accContent.css("height",temp.getContentHeight());
	};
	
	
	//是否折叠
	temp.isExpend = function(){
		return temp.$accContent.height()!=0;
	};
	
	temp.getContentHeight = function(){
		var height = temp.$accContent.attr("h",height);
		if(!height || height=="null" || height=="0"){
			height = temp.$accContent.innerHeight();
			if(height!=0){
				temp.$accContent.attr("h",height);
			}else{
				height="nan";
			}
		}
		height =parseInt(height);
		if(isNaN(height)){
			height = "100%";
		}else if(height==0){
			height="0px";
		}else{
			height = height+"px";
		}		
		
		return height;
	};

}

function default_accordionpanel_ComponetFn(conf){
	var temp = this;
	temp.state = temp.isExpend() ? "expend" :"collect";  //0表示折叠  1表示展开
	temp.isAnimal = false;  //组件是否正在折叠运动
	
	temp.animal = function(action){
		var height = temp.getContentHeight();
		if(temp.isAnimal) return;
		if(action=="collect"){
			height=0;
		}		
		temp.isAnimal = true;
		temp.animalDom(height,function(){
								temp.isAnimal=false;
						});
	};
	
	temp.expend = function(){
		temp.animal("expend");
		temp.state = "expend";
		temp.foldBtnChange("expend");
		temp.contentFadeIn();
	};
	//动画折叠
	temp.collect = function(){
		temp.animal("collect");
		temp.state = "collect";
		temp.foldBtnChange("collect");
		temp.contentFadeOut();
	};
	//快速折叠
	temp.expendQuick = function(){
		temp.displayBlock();
		temp.state = "expend";
		temp.foldBtnChange("expend");
	};
	temp.collectQuick = function(){
		temp.displayNone();
		temp.state = "collect";
		temp.foldBtnChange("collect");		
	};
	
	temp.$accBtn.click(function(){
		if(temp.state=="expend"){
			temp.collect();
			temp.state="collect";
		}else{
			temp.expend();
			temp.state="expend";
		}
	});
}

$.apply(AccordionPanel,Componet);