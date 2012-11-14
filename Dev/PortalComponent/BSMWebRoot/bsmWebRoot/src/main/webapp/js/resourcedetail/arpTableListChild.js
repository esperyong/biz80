$(function(){
	var $formObj = $("#arpListForm");
	var columnW = {ip:"30",mac:"30",port:"20",type:"20"};
	var gp = new GridPanel({id:"tableId",
			unit:"%",
			columnWidth:columnW,
			plugins:[SortPluginIndex],
			sortColumns:[{index:"ip",defSorttype:"down"},{index:"mac"},{index:"port"},{index:"type"}],
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
	              url: path+"/detail/arpjsonSort.action?"+ajaxParam,
	              success: function(data){
	        			gp.loadGridData(data.dataList);
	              },
	              error:function(e){
	              	//alert(e.responseText);
	              }
	        });
	        }},{gridpanel_DomStruFn:"index_gridpanel_DomStruFn",gridpanel_DomCtrlFn:"index_gridpanel_DomCtrlFn",gridpanel_ComponetFn:"index_gridpanel_ComponetFn"});

		gp.rend([{index:"ip",fn:function(td){
			if(td.html == "") return;
			$font = $('<font title="'+td.html+'">'+td.html+'</font>');
			return $font;
		}
		},{index:"mac",fn:function(td){
			if(td.html == "") return;
			$font = $('<font title="'+td.html+'">'+td.html+'</font>');
			return $font;
		}
		},{index:"port",fn:function(td){
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