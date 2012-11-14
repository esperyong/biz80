$(function(){
	$.blockUI({message:$('#loading')});
    var gpw = new GridPanel({id:"viewResource_div",
        					columnWidth:{instanceName:"25",resourceName:"20",ipAddress:"35",userName:"20"},
        					unit: "%",
    						plugins:[SortPluginIndex],
    						sortColumns:[{index:"instanceName",defSorttype:"down"},
    						             {index:"ipAddress"},
    						             {index:"userName"}],
    						sortLisntenr:function($sort){
    				              var orderType = "desc";
    				              if($sort.sorttype == "up"){
    				                   orderType = "asc";
    				              }
    				              var ajaxParam = "profileId="+$("#vr_id").val()+"&orderBy="+$sort.colId+"&orderType="+orderType;
    				        $.ajax({
    				              type: "POST",
    				              dataType:'json',
    				              url: path+"/profile/sortViewResource.action?"+ajaxParam,
    				              success: function(data, textStatus){
    				        			gpw.loadGridData(data.dataList);
    				              }
    				        });
    				        }},{gridpanel_DomStruFn:"index_gridpanel_DomStruFn",gridpanel_DomCtrlFn:"index_gridpanel_DomCtrlFn",gridpanel_ComponetFn:"index_gridpanel_ComponetFn"});
    
    gpw.rend([{index:"instanceName",fn:function(td){
    	if(td.html == "") {return;}
		$font = $("<span title='"+td.html+"'>"+td.html+"</span>");
		return $font;
	}
	},{index:"resourceName",fn:function(td){
		if(td.html == "") {return;}
		$font = $('<span title="'+td.html+'">'+td.html+'</span>');
		return $font;
	}
	},{index:"ipAddress",fn:function(td){
		var $select = "";
        var ipArr = td.html.split('@');
        if(ipArr.length > 1){
                $select = "<select id=ip"+td.rowIndex+" style='width:120px;' iconIndex='0' iconTitle='管理IP' iconClass='combox_ico_select f-absolute'>";
                for(var i = 0; i < ipArr.length; i++){
                	$select += "<option>" + ipArr[i] + "</option>";
                }
                $select += "</select>";
        }else{
                $select = td.html;
        }
        return $select;
	}
	},{index:"userName",fn:function(td){
		if(td.html == "") {return;}
		$font = $('<span title="'+td.html+'">'+td.html+'</span>');
		return $font;
	}
	}]);
    $.unblockUI();
    
    SimpleBox.renderAll();
    $('.combobox').parent().css('position', ''); 
    
});