$(function(){
	var $formObj = $("#nftListForm");
	var $orderBy = $("input[name='orderBy']");
	var $orderType = $("input[name='orderType']");
	var $currentPage = $("input[name='currentPage']");
	var $eventDataId = $("input[name='eventDataId']");
	var columnW = {enabled:"5",time:"13",type:"13",obj:"13",sendmode:"8",reception:"8",sendcontent:"40"};
	if("view" == operateView){
		columnW = {enabled:"10",time:"18",sendmode:"13",reception:"13",sendcontent:"46"};
	}
	var panel1;
	$('#alarmRecord').hide(); 
	var gp = new GridPanel({id:"tableId",
			unit:"%",
			columnWidth:columnW,
			plugins:[SortPluginIndex],
			sortColumns:[{index:"time",defSorttype:"down"}],
			sortLisntenr:function($sort){
	              var orderType = "desc";
	              if($sort.sorttype == "up"){
	                      orderType = "asc";
	              }
	              //var param = "&orderBy="+$sort.colId+"&orderType="+orderType;
	              $orderBy.val($sort.colId);
	              $orderType.val(orderType);
	              var ajaxParam = $formObj.serialize();
	        $.ajax({
	              type: "POST",
	              dataType:'json',
	              url: path+"/notification/jsonSort.action?"+ajaxParam,
	              success: function(data){
	        			gp.loadGridData(data.dataList);
	              },
	              error:function(e){
	              	//alert(e.responseText);
	              }
	        });
	        }},{gridpanel_DomStruFn:"index_gridpanel_DomStruFn",gridpanel_DomCtrlFn:"index_gridpanel_DomCtrlFn",gridpanel_ComponetFn:"index_gridpanel_ComponetFn"});

		if("view" == operateView){
			gp.rend([{index:"enabled",fn:function(td){
				if(td.html == "") return;
				var array = td.html.split(',');
				$font = $('<div style="height: 21px;text-align: center;"><span class="'+array[2]+'" id="'+array[0]+'_state" title="'+array[1]+'"/></div>');
				return $font;
			}
			},{index:"time",fn:function(td){
				if(td.html == "") return;
				$font = $('<font style="height: 21px;text-align: center;" title="'+td.html+'">'+td.html+'</font>');
				return $font;
			}
			},{index:"sendmode",fn:function(td){
				if(td.html == "") return;
				$font = $('<font style="height: 21px;text-align: center;" title="'+td.html+'">'+td.html+'</font>');
				return $font;
			}
			},{index:"reception",fn:function(td){
				if(td.html == "") return;
				$font = $('<font style="height: 21px;text-align: center;" title="'+td.html+'">'+td.html+'</font>');
				return $font;
			}
			},{index:"sendcontent",fn:function(td){
				if(td.html == "") return;
				td.$td.find('span').css({width: '100%',"word-break": 'break-all'});//自动折行
				var td_html = td.$td.html();
				var td_text = $.text(td.$td);
				if(td_html == "") return;
				//var array = td.html.split('@#');
				//$font = $('<font style="height: 21px;text-align: center;" title="'+td.html+'">'+td.html+'</font>');
				$font = $('<font style="height: 21px;width:300px;overflow: hidden; text-overflow:ellipsis;display: inline-block;white-space:nowrap;">'+td.html+'</font>');
				//$font = $('<span style="height: 21px;text-align: center;" title="'+td.html+'">'+td.html+'</span>');
				$font.mouseover(function(event){
				if(panel1){
					panel1.close();
					panel1 = undefined;
				}
				td_html = "<div style=\"height:195px;overflow: auto\">" + td_text + "</div>";
				panel1 = new winPanel({html:td_html
				,x:getX(event.pageX)
				,y:getY(event.pageY)
				,width:300
				,height:200
				,isautoclose: true
				,closeAction: "close"
				, listeners:{ closeAfter:function(){
						//alert("afterClose");
			 			effecteResPanel = null; 
						}
					, loadAfter:function(){ 
//						alert("loadAfter"); 
						} 
					} }
				,{winpanel_DomStruFn:"blackLayer_winpanel_DomStruFn" }); 
				})
				
				return $font;
			}
			}]);
			$('#alarmRecord').show();
		}else{
			gp.rend([{index:"enabled",fn:function(td){
				if(td.html == "") return;
				var array = td.html.split(',');
				$font = $('<div style="height: 21px;text-align: center;"><span class="'+array[2]+'" id="'+array[0]+'_state" title="'+array[1]+'"/></div>');
				return $font;
			}
			},{index:"time",fn:function(td){
				if(td.html == "") return;
				$font = $('<font style="height: 21px;text-align: center;" title="'+td.html+'">'+td.html+'</font>');
				return $font;
			}
			},{index:"type",fn:function(td){
				if(td.html == "") return;
				$font = $('<font style="height: 21px;text-align: center;" title="'+td.html+'">'+td.html+'</font>');
				return $font;
			}
			},{index:"obj",fn:function(td){
				if(td.html == "") return;
				$font = $('<font style="height: 21px;text-align: center;" title="'+td.html+'">'+td.html+'</font>');
				return $font;
			}
			},{index:"sendmode",fn:function(td){
				if(td.html == "") return;
				$font = $('<font style="height: 21px;text-align: center;" title="'+td.html+'">'+td.html+'</font>');
				return $font;
			}
			},{index:"reception",fn:function(td){
				if(td.html == "") return;
				$font = $('<font style="height: 21px;text-align: center;" title="'+td.html+'">'+td.html+'</font>');
				return $font;
			}
			},{index:"sendcontent",fn:function(td){
			    if(td.html == "") return;
			    td.$td.find('span').css({width: '100%',"word-break": 'break-all'});////自动折行
				var td_html = td.$td.html();
				var td_text = $.text(td.$td);
				if(td_html == "") return;
				//var array = td_html.split('@#');
				$font = $('<font style="height: 21px;text-align: center;">'+td_text+'</font>');
//				$font = $('<font style="height: 21px;width:60px;overflow: hidden; text-overflow:ellipsis;display: inline-block;white-space:nowrap;" title="'+td.html+'">'+td.html+'</font>');
				$font.mouseover(function(event){
				if(panel1){
					panel1.close();
					panel1 = undefined;
				}
				//var content = array[1].replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/&lt;br\/&gt;/g, "<br/>");
				td_html = "<div style=\"height:195px;overflow: auto\">" + td_html + "</div>";
				panel1 = new winPanel({html:td_html
				,x:getX(event.pageX)
				,y:getY(event.pageY)
				,width:300
				,height:200
				,isautoclose: true
				,closeAction: "close"
				, listeners:{ closeAfter:function(){
						//alert("afterClose");
			 			effecteResPanel = null; 
						}
					, loadAfter:function(){ 
//						alert("loadAfter"); 
						} 
					} }
				,{winpanel_DomStruFn:"blackLayer_winpanel_DomStruFn" }); 
				})
				
				return $font;
			}
			}]);
			
			var page = new Pagination({applyId:"page",listeners:{
		  		pageClick:function(page){
		  		$currentPage.val(page);
		  		var ajaxParam = $formObj.serialize();
			  		$.ajax({
			   			type: "POST",
			   			dataType:'json',
			   			url: path+"/notification/jsonSort.action",
			   			data: ajaxParam,
			   			success:function(data){
			   			if(data.dataList){
			    			gp.loadGridData(data.dataList);
			   			}
			  			},
			  			error:function(e){
			  				//alert(e.responseText);
			  			}
			  		});
		 		}
	 		}});
	 		$('#alarmRecord').show(); 
		 	page.pageing(pageCount,1);
		}
		function getX(pageX){
			var screenWidth = $(document).width() ;
			 if((pageX + 300) > screenWidth){
			 	pageX = screenWidth - 300 - 5 ;
			 }
			 return pageX;
		}
		function getY(pageY){
			var screenHeight =  $(document).height() ;
			 if((pageY + 200) > screenHeight){
			 	pageY = screenHeight - 300 - 5 ;
			 }
			 return pageY;
		}
		
});
