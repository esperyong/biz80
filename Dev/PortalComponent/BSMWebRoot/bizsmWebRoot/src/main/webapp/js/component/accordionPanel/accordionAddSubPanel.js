




function addsub_accordionpanel_DomStruFn(conf){
	var temp = this;
	temp.$accPanel = $("#"+conf.id);
	temp.$accBtn = $(temp.$accPanel.children("div:eq(0)").children("span:eq(0)"));
	temp.$accContent = $(temp.$accPanel.children("div:eq(1)"));
}

function addsub_accordionpanel_DomCtrlFn(conf){
	var temp = this;
	defatul_accordionpanel_DomCtrlFn.call(temp,conf);
	//折叠按钮
	temp.foldBtnChange= function(action){
		var collect = "ico-minus";
		var expend = "ico-plus";
		if(action=="expend"){
			temp.$accBtn.removeClass(expend).addClass(collect);
		}else{
			temp.$accBtn.removeClass(collect).addClass(expend);
		}
	};
}

CFNC.registDomStruFn("addsub_accordionpanel_DomStruFn",addsub_accordionpanel_DomStruFn);
CFNC.registDomCtrlFn("addsub_accordionpanel_DomCtrlFn",addsub_accordionpanel_DomCtrlFn);