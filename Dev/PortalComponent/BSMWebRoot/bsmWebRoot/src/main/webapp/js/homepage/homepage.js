function HomePage(){
	var $numbtns = {}; //key:页签编号;value:{index:页签索引,obj:页签按钮对象}
	var contentWidth =0 ;
	var $content = null;
	var $lastBtn = null;
	var currentPage = 0;
	var nowLoadPageId = this.nowLoadPageId = "0"; //当前加载页面Id
	var $parentContent = $("#homepage_ppt");
	var length = 0;
	var frequency = 5000;
	var isAutoPlay = false; //是否是自动播放状态
	
	
	this.init = function(conf){
		if(conf.frequency){
			frequency = (+conf.frequency);
		}
    	
		var numBtns = $("#homepage_btn li[url]");
		for(var i=0;i<numBtns.length;i++){
			var $numBtn = $(numBtns[i]);
			$numbtns[$numBtn.attr("pagenum")] = {index:i,obj:$numBtn};
			if(i==0){
				$lastBtn = $numBtn;
			}
		}
		length = numBtns.length;
		$content = $($parentContent.children()[0]);
		contentWidth = $content.width();
		numBtns.bind("click",btnClick);
		$("#pptplay").toggle(autoshow,stop);
		if($lastBtn){
			load($content,{url:$lastBtn.attr("url")});
		}else{
			$('#homepage_ppt').children('div:eq(0)').children('img').css('display','');
		}
	}
	
	function btnClick(){
		var $btn = $(this);
		changeBtn($btn);
	}
  
	$("#pptsetting").bind("click",function(){
			winOpen({
				width:700,
				height:455,
				url:"/pureportal/homepage/viewSet.action"
			});
		});
	/*
	 * 开始按钮事件
	 */
	function autoshow(){
   
		$('#homepage_btn').children('li').css('cursor','default');
		//isAutoPlay=true;
		Index.collectNorth(function(){
      $("#homepage_ppt").width(Index.centerWidth()-40);
      $("#homepage_ppt").height(Index.centerHeight()-86);
    });
     
		var $playBtn = $(this);
		//	autoInterval = setInterval(function(){
		//		var nextIndex = getNextIndex(currentPage,length);
		//		var nextId = getIdByIndex(nextIndex);
		//		if(nextId){
		//			changeBtn(nextId.obj);
		//		}
				//loadNext($numbtns[nextId].obj);
		//	} , frequency);
		$playBtn.removeClass("full").addClass("exit");
		$playBtn.attr("title","取消全屏");
	}
	/*
	 * 停止按钮事件
	 */
	function stop(){
   
		isAutoPlay = false;
		Index.expendNorth(function(){
    	  $("#homepage_ppt").width(Index.centerWidth()-40);
    		$("#homepage_ppt").height(Index.centerHeight()-86);
    });

		var $btn = $(this);
		$btn.removeClass("exit").addClass("full");
		//clearInterval(autoInterval);
		$btn.attr("title","全屏");
		//if($lastBtn){
		//	load($parentContent,{url:$lastBtn.attr('url')});
		//}
		//alert($lastBtn.attr('url'));
	}
	
	
	function changeBtn($nowBtn){
		$lastBtn.removeClass("on");
		$lastBtn = $nowBtn.addClass("on");
		loadNext($nowBtn);
		$("#homepage_title").text($nowBtn.attr("pagename"));
		var logo = $("#pptlog");
		logo.attr('src',$nowBtn.attr("imgpath"));
		resizeImg(logo[0],190,40);
		currentPage =getBtnIndexById($nowBtn.attr("pagenum"));
	}
	
	function loadNext($btn){
		//var $nextContent = $('<div class="layers" style="position:absolute"></div>');
		//$nextContent.css("left",contentWidth);
		//$parentContent.append($nextContent);
	if(isAutoPlay){
	    var bigImgPath = $btn.attr("bigImgPath");
	    var imgInit = $parentContent.find('[name=imgInit]');
	    var timestamp = '';
	    var date = new Date();
	    timestamp = '?t='+date.getFullYear()
	    +date.getMonth()+date.getDate()+date.getHours()+date.getMinutes()+date.getSeconds()+date.getMilliseconds();
	    bigImgPath+=timestamp;
	    if(imgInit.length <= 0){
	    	
	    	
	      $parentContent.html('<img style="FILTER: revealTrans(duration=1,transition=5);" src="'+bigImgPath+'" name="imgInit"/>');
	    }
    
    	playTran();
    	$($parentContent.find('img')).width(window.screen.width-30);
    	$($parentContent.find('img')).attr('src',bigImgPath);
    }else{
        load($parentContent,{url:$btn.attr("url")});
    }
    
		
		
		//alert(isAutoPlay);
		//$($parentContent.children()[0]).html($nextContent.html());
        //$($parentContent.children()[0]).append($nextContent);
		//nextContent($nextContent);
	}
	
	function playTran(){
		if(document.all){
			var imgInit = $parentContent.find('img')[0];
			imgInit.filters.revealTrans.Transition=23;
			imgInit.filters.revealTrans.apply();
			imgInit.filters.revealTrans.play();
		}
	}
	
	function nextContent($nextContent){
		setTimeout(function(){
			var cleft = $content.position().left;
			var nleft = $nextContent.position().left;
			if(nleft!=0){
				cleft-= 100;
				nleft-= 100;
				if(nleft<=0){
					nleft = 0;
				}
				$content.css("left",cleft+"px");
				$nextContent.css("left",nleft+"px");
				nextContent($nextContent);
			}else{
				$content.remove();
				$content = $nextContent;
				$nextContent = null;
			}
		},10);
	}
	
	function getBtnIndexById(id){
		return $numbtns[id].index;
	}
	
	function getIdByIndex(index){
		for(var i in $numbtns){
			var numbtn = $numbtns[i];
			if(numbtn.index==index) return numbtn;
		}
	}

	
	function getNextIndex(current,count){
		if(current == count-1){ //如果当前为最后一个，返回第一个索引0
			return  0;
		}else{
			return current + 1;
		}
	};
	
		function load($div,param,callback,appendEvent){
			this.loadName = param.name;
			$.ajax({    url:param.url,
                   cache:false,
                   dataType:"html",
                   data:param.param,
                   type:"get",
                   success:function(data){
                       if(callback){
                         callback();
                       }
                       $div.find("*").unbind();
                       $div[0].innerHTML="";
                       $div.append(data);
					   if(appendEvent){
					   		appendEvent();
					   }
                   }
                 });
	}
}

function resizeImg(ImgD,iwidth,iheight){

	var image=new Image();
	image.src=ImgD.src; 
	var K = image.width/image.height;
	if(image.width <= iwidth && image.height <= iheight){
		ImgD.width = image.width;
		ImgD.height = image.height;
	}
	else if(image.width > iwidth && image.height <= iheight){
		ImgD.width = iwidth;
		ImgD.height = iheight * K;
	}else if(image.width <= iwidth && image.height > iheight){
		ImgD.height = iheight;
		ImgD.width = iwidth / K;
	}else{
		ImgD.width = iwidth;
		ImgD.height = iheight * K;
	}
	
}
HP = {
	activates:{},
	sleeps:{},
	destorys:{}
		
};
HP.addActivate = function(fn){
	this.activates[homepage.nowLoadPageId]= fn;
}
HP.addSleep = function(fn){
	this.sleeps[homepage.nowLoadPageId]= fn;
}
HP.addDestory = function(fn){
	this.destorys[homepage.nowLoadPageId] = fn;
}