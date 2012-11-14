var gp = null;
$(function() {
	$formObj = $("#wireListForm");
	$instanceId = $("#instanceId");
	gp = new GridPanel({id:"tableId",
		columnWidth:{checkbox:"5",actionName:"27",command:"20",commandPath:"20",triggerCondition:"28"},
		unit: "%",
		plugins:[SortPluginIndex],
		sortColumns:[{index:"actionName",defSorttype:"down"}],
		sortLisntenr:function($sort){
              var orderType = "desc";
              if($sort.sorttype == "up"){
                      orderType = "asc";
              }
              $("#orderColumn").val($sort.colId);
              $("#orderType").val(orderType);
              var ajaxParam = $formObj.serialize();
        $.ajax({
              type: "POST",
              dataType:'json',
              url: path+"/wireless/actionForPage/wirejsonSort.action",
              data: ajaxParam,
              success: function(data, textStatus){
        		gp.loadGridData(data.forPageVO.dataList);
        		reloadData();
              }
        });
        }},{gridpanel_DomStruFn:"index_gridpanel_DomStruFn",gridpanel_DomCtrlFn:"index_gridpanel_DomCtrlFn",gridpanel_ComponetFn:"index_gridpanel_ComponetFn"});          
	
	gp.rend([{index:"checkbox",fn:function(td){
		if(td.html == "") {return;}
			$font = $('<input type="checkbox" name="actionIds" value="'+td.html+'">');
			return $font;
	}
	},{index:"actionName",fn:function(td){
		if(td.html == "") {return;}
		var array = td.html.split(',');
		var style = (autority == "true")?style='style="cursor:pointer" ':style=' ';
		$font = $('<span '+style+'title="'+array[1]+'">'+array[1]+'</span>');
		if(autority == "true") {
			$font.bind("click",function(){
				openDefPage(array[0], $instanceId.val());
			});
		}
		return $font;
	}
	},{index:"command",fn:function(td){
		if(td.html == "") {return;}
		$font = $('<span title="'+td.html+'">'+td.html+'</span>');
		return $font;
	}
	},{index:"commandPath",fn:function(td){
		if(td.html == "") {return;}
		$font = $('<span title="'+td.html+'">'+td.html+'</span>');
		return $font;
	}
	},{index:"triggerCondition",fn:function(td){
		if(td.html == "") {return;}
		$font = $('<span title="'+td.html+'">'+td.html+'</span>');
		return $font;
	}
	}]);

	var page = new Pagination({applyId:"page",listeners:{
		pageClick:function(page){
		$("#currentPage").val(page);
		var ajaxParam = $formObj.serialize();
		$.ajax({
			type: "POST",
			dataType:'json',
			url: path+"/wireless/actionForPage/wirejsonSort.action",
			data: ajaxParam,
			success: function(data, textStatus){
			if(data.dataList){
				gp.loadGridData(data.dataList);
				reloadData();
			}  
		}
		});
	}
	}});
	page.pageing(pageCount,1);
	reloadData();
});

function reloadData() {
	setAllSelect();
	setRecordCheckBox();
}

function setAllSelect() {
	var $allSelect = $("#allSelect");
	$allSelect.click(function() {
    	$("input[name='actionIds']").attr("checked",$allSelect.attr("checked"));
    });
}
function setRecordCheckBox() {
	var $allSelect = $("#allSelect");
	$("input[name='actionIds']").click(function() {
	 	   var param = $(this).attr("checked");
	 	   if(param == false) {
	 		   $allSelect.attr("checked", false);
	 	   }
	});
}