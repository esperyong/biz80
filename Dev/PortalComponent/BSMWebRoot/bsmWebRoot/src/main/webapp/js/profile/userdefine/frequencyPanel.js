var FreqPanel = { };

FreqPanel.renderAll = function(){
  	var self = this;
		self.panel ;
		self.text = {};
		self.showText = {};
		self.title = $("<b>监控频度</b>");
		self.context = $("<div></div>");
		self.all = $("<div></div>");
		self.all.append(self.title).append(self.context);
	var defineWeeks = ["周一","周二","周三","周四","周五","周六","周日"];

	$("[id=monitorFreq]").each(function(i,e){
		var _e = $(e);
		var text =  _e.html();
		self.text[i] = text;
		var strs = text.split(" ");
		var weeks = strs[0].split(",");
		
		var time = strs[1];
		if(weeks.length > 4){
				self.showText[i] = weeks.slice(0,4).concat("<br>...").join(",");
		}else{
				self.showText[i] = text;
		}
		_e.attr("index",i);
		_e.html(self.showText[i]);
		$(this).mouseover(function(event){
			self.context.html(self.text[i]);
				if(!self.panel){
						self.panel = new winPanel({
		                            html:self.all,
		                            width:300,
		                            isDrag:false,
		                            x:event.pageX,
		                            y:event.pageY
		                  },{
		                    winpanel_DomStruFn:"blackLayer_winpanel_DomStruFn"
		                  }); 
					}
					$(this).mouseout(function(){
						if(self.panel){
								self.panel.close();
								self.panel = undefined ;
							}
						
						});
					
		})
		
	});
}