$(function(){
	$.blockUI({message:$('#loading')});
    var gp = new GridPanel({id:"viewAlarmRule_div",
        					columnWidth:{ruleName:"25",sendMethod:"30",receivers:"30",isUpgrade:"15"},
        					unit: "%",
        					plugins:[SortPluginIndex],
    						sortColumns:[{index:"ruleName",defSorttype:"down"},
    						             {index:"isUpgrade"}],
    						sortLisntenr:function($sort){
    				              var orderType = "desc";
    				              if($sort.sorttype == "up"){
    				                   orderType = "asc";
    				              }
    				              var ajaxParam = "profileId="+$("#va_id").val()+"&orderBy="+$sort.colId+"&orderType="+orderType;
    				        $.ajax({
    				              type: "POST",
    				              dataType:'json',
    				              url: path+"/profile/sortViewAlarm.action?"+ajaxParam,
    				              success: function(data, textStatus){
    				        			gp.loadGridData(data.dataList);
    				              }
    				        });
    				        }},{gridpanel_DomStruFn:"index_gridpanel_DomStruFn",gridpanel_DomCtrlFn:"index_gridpanel_DomCtrlFn",gridpanel_ComponetFn:"index_gridpanel_ComponetFn"});
        					
    
    gp.rend([{index:"ruleName",fn:function(td){
    	if(td.html == "") {return;}
		$font = $('<span title="'+td.html+'">'+td.html+'</span>');
		return $font;
	}
	},{index:"sendMethod",fn:function(td){
		if(td.html == "") {return;}
		var $select = "";
        var sendMethods = td.html.split('@');
        if(sendMethods.length > 1){
                $select = "<select style='width:120px;'>";
                for(var i = 0; i < sendMethods.length; i++){
                	$select += "<option>" + sendMethods[i] + "</option>";
                }
                $select += "</select>";
        }else{
                $select = td.html;
        }
        return $select;
	}
	},{index:"receivers",fn:function(td){
		if(td.html == "") {return;}
		var $select = "";
        var receivers = td.html.split('@');
        if(receivers.length > 1){
                $select = "<select style='width:120px;'>";
                for(var i = 0; i < receivers.length; i++){
                	$select += "<option>" + receivers[i] + "</option>";
                }
                $select += "</select>";
        }else{
                $select = td.html;
        }
        return $select;
	}
	},{index:"isUpgrade",fn:function(td){
		if(td.html == "") {return;}
		$font = $('<span class="'+td.html+'" style="cursor:none;"/>');
		return $font;
	}
	}]);
    
    $.unblockUI();
});