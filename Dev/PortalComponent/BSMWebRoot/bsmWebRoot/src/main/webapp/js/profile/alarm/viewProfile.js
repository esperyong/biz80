$(function(){
	$.blockUI({message:$('#loading')});
    var gp = new GridPanel({id:"viewProfile_div",
        					columnWidth:{profileName:"30",domain:"20",resourceName:"30",userName:"20"},
        					unit: "%",
        					plugins:[SortPluginIndex],
    						sortColumns:[{index:"profileName",defSorttype:"down"},
    						             {index:"domain"}, 
    						             {index:"resourceName"},
    						             {index:"userName"}],
    						sortLisntenr:function($sort){
    				              var orderType = "desc";
    				              if($sort.sorttype == "up"){
    				                   orderType = "asc";
    				              }
    				              var ajaxParam = "ruleId="+$("#vp_id").val()+"&orderBy="+$sort.colId+"&orderType="+orderType;
    				        $.ajax({
    				              type: "POST",
    				              dataType:'json',
    				              url: path+"/profile/alarm/sortViewProfile.action?"+ajaxParam,
    				              success: function(data, textStatus){
    				        			gp.loadGridData(data.dataList);
    				              }
    				        });
    				        }},{gridpanel_DomStruFn:"index_gridpanel_DomStruFn",gridpanel_DomCtrlFn:"index_gridpanel_DomCtrlFn",gridpanel_ComponetFn:"index_gridpanel_ComponetFn"});
    
    gp.rend([{index:"profileName",fn:function(td){
    	if(td.html == "") {return;}
		$font = $('<span title="'+td.html+'">'+td.html+'</span>');
		return $font;
	}
	},{index:"domain",fn:function(td){
		if(td.html == "") {return;}
		$font = $('<span title="'+td.html+'">'+td.html+'</span>');
		return $font;
	}
	},{index:"resourceName",fn:function(td){
		if(td.html == "") {return;}
		$font = $('<span title="'+td.html+'">'+td.html+'</span>');
		return $font;
	}
	},{index:"userName",fn:function(td){
		if(td.html == "") {return;}
		$font = $('<span title="'+td.html+'">'+td.html+'</span>');
		return $font;
	}
	}]);
    $.unblockUI();
});