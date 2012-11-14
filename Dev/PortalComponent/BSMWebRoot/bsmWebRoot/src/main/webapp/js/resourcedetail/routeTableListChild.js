$(function(){
	var $formObj = $("#routeListForm");
	var columnW = {destination:"20",mask:"20",nexthop:"20",protocol:"20",type:"20"};
	var gp = new GridPanel({id:"tableId",
			unit:"%",
			columnWidth:columnW,
			plugins:[SortPluginIndex],
			sortColumns:[{index:"destination",defSorttype:"down"},{index:"mask"},{index:"nexthop"},{index:"protocol"},{index:"type"}],
			sortLisntenr:function($sort){
	              var orderType = "desc";
	              if($sort.sorttype == "up"){
	                      orderType = "asc";
	              }
	              var param = "&orderBy="+$sort.colId+"&orderType="+orderType;
	              var ajaxParam = $formObj.serialize() + param;
	        $.ajax({
	              type: "POST",
	              dataType:'json',
	              url: path+"/detail/routejsonSort.action?"+ajaxParam,
	              success: function(data){
	        			gp.loadGridData(data.dataList);
	              },
	              error:function(e){
	              	//alert(e.responseText);
	              }
	        });
	        }},{gridpanel_DomStruFn:"index_gridpanel_DomStruFn",gridpanel_DomCtrlFn:"index_gridpanel_DomCtrlFn",gridpanel_ComponetFn:"index_gridpanel_ComponetFn"});

		gp.rend([{index:"intention",fn:function(td){
			if(td.html == "") return;
			$font = $('<font title="'+td.html+'">'+td.html+'</font>');
			return $font;
		}
		},{index:"code",fn:function(td){
			if(td.html == "") return;
			$font = $('<font title="'+td.html+'">'+td.html+'</font>');
			return $font;
		}
		},{index:"nexthop",fn:function(td){
			if(td.html == "") return;
			$font = $('<font title="'+td.html+'">'+td.html+'</font>');
			return $font;
		}
		},{index:"routeaccord",fn:function(td){
			if(td.html == "") return;
			$font = $('<font title="'+td.html+'">'+td.html+'</font>');
			return $font;
		}
		},{index:"type",fn:function(td){
			if(td.html == "") return;
			$font = $('<font title="'+td.html+'">'+td.html+'</font>');
			return $font;
		}
		}]);
});

$("#win-close").bind("click", function() {
	window.close();
});
