$(function(){
	var $formObj = $("#netstatListForm");
	var columnW = {protocol:"11",localaddr:"19",localport:"18",remoteaddr:"18", remoteport:"18", status:"16"};
	var gp = new GridPanel({id:"tableId",
			unit:"%",
			columnWidth:columnW,
			plugins:[SortPluginIndex],
			sortColumns:[
			             {index:"localaddr"},
			             {index:"localport"},
			             {index:"remoteaddr"},
			             {index:"remoteport"},
			             {index:"status", defSorttype:"down"}
			],
			sortLisntenr:function($sort){
	              var orderType = "desc";
	              if($sort.sorttype == "up"){
	                      orderType = "asc";
	              }
	              var param = "&orderBy="+$sort.colId+"&orderType="+orderType;
	              //$orderBy.val($sort.colId);
	              //$orderType.val(orderType);
	              var ajaxParam = $formObj.serialize()+param;
	        $.ajax({
	              type: "POST",
	              dataType:'json',
	              url: path+"/detail/netstatjsonSort.action?"+ajaxParam,
	              success: function(data){
	        			gp.loadGridData(data.dataList);
	              },
	              error:function(e){
	              	//alert(e.responseText);
	              }
	        });
	        }},{gridpanel_DomStruFn:"index_gridpanel_DomStruFn",gridpanel_DomCtrlFn:"index_gridpanel_DomCtrlFn",gridpanel_ComponetFn:"index_gridpanel_ComponetFn"});

		gp.rend([{index:"protocol",fn:function(td){
			if(td.html == "") return;
			$font = $('<font title="'+td.html+'">'+td.html+'</font>');
			return $font;
		}
		},{index:"localaddr",fn:function(td){
			if(td.html == "") return;
			$font = $('<font title="'+td.html+'">'+td.html+'</font>');
			return $font;
		}
		},{index:"localport",fn:function(td){
			if(td.html == "") return;
			$font = $('<font title="'+td.html+'">'+td.html+'</font>');
			return $font;
		}
		},{index:"remoteaddr",fn:function(td){
			if(td.html == "") return;
			$font = $('<font title="'+td.html+'">'+td.html+'</font>');
			return $font;
		}
		},{index:"remoteport",fn:function(td){
			if(td.html == "") return;
			$font = $('<font title="'+td.html+'">'+td.html+'</font>');
			return $font;
		}
		},{index:"status",fn:function(td){
			if(td.html == "") return;
			$font = $('<font title="'+td.html+'">'+td.html+'</font>');
			return $font;
		}
		}]);
});
$("#win-close").bind("click", function() {
	window.close();
});