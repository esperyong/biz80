var gp = null;
$(function(){
	var index = 0;
	var $formObj = $("#alarmListForm");
	var $dataListDiv = $("#dataListDiv");
	
	var panelX =$dataListDiv.width()/2-50;
	var panelY =$dataListDiv.height()/2-120;
	gp = new GridPanel({id:"tableId",
		columnWidth:{checkBox:"7",ruleName:"20",domain:"15",sendMethod:"15",receivers:"15",profileNum:"20",operation:"8"},
		unit: "%",
		plugins:[SortPluginIndex],
		sortColumns:[{index:"ruleName",defSorttype:"down"}],
		sortLisntenr:function($sort){
              var orderType = "desc";
              if($sort.sorttype == "up"){
                      orderType = "asc";
              }
              $("#orderBy").val($sort.colId);
              $("#orderType").val(orderType);
              var ajaxParam = $formObj.serialize();
        $.ajax({
              type: "POST",
              dataType:'json',
              url: path+"/profile/alarm/jsonSort.action",
              data: ajaxParam,
              success: function(data, textStatus){
        		gp.loadGridData(data.dataList);
        		reloadData();
              }
        });
        }},{gridpanel_DomStruFn:"index_gridpanel_DomStruFn",gridpanel_DomCtrlFn:"index_gridpanel_DomCtrlFn",gridpanel_ComponetFn:"index_gridpanel_ComponetFn"});          
	
	gp.rend([{index:"checkBox",fn:function(td){
		if(td.html == "") {return;}
		if(defaultRuleId == td.html) {
			$font = $('<input type="checkbox" name="defaultRuleId" disabled>');
			return $font;
		}else {
			$font = $('<input type="checkbox" name="alarmRuleId" id="'+td.html+'_checkbox" value="'+td.html+'">');
			return $font;
		}
	}
	},{index:"ruleName",fn:function(td){
		if(td.html == "") {return;}
		var array = td.html.split('@');
		$font = $('<font style="cursor:pointer" title="'+array[0]+'">'+array[0]+'</font>');
		$font.bind("click",function(){
			openEditAlarmDefPage(array[1]);
		});
		return $font;
	}
	},{index:"domain",fn:function(td){
		if(td.html == "") {return;}
		$font = $('<font title="'+td.html+'">'+td.html+'</font>');
		return $font;
	}
	},{index:"sendMethod",fn:function(td){
		var $select = "";
        var ipArr = td.html.split('@');
        if(ipArr.length > 1){
                $select = "<select id=send"+(index++)+" style='width:80px;' class='senMethodCss'>";
                for(var i = 0; i < ipArr.length; i++){
                	$select += "<option>" + ipArr[i] + "</option>";
                }
                $select += "</select>";
        }else{
                $select = td.html;
        }
        return $select;
	}
	},{index:"receivers",fn:function(td){
		var $select = "";
        var ipArr = td.html.split('@');
        if(ipArr.length > 1){
                $select = "<select id=receive"+(index++)+" style='width:100px;' class='receiversCss'>";
                for(var i = 0; i < ipArr.length; i++){
                	$select += "<option>" + ipArr[i] + "</option>";
                }
                $select += "</select>";
        }else{
                $select = td.html;
        }
        return $select;
	}
	},{index:"profileNum",fn:function(td){
		if(td.html == "") {return;}
		var array = td.html.split('@');
		$font = $('<span class="span-width-50px"><font align="right">'+array[0]+'个</font></span><span><span class="gray-btn-l"><span class="btn-r"><span class="btn-m"><a>查看</a></span></span></span></font></span>');
		$font.children(".gray-btn-l").bind("click",function(event){
        	var url = path+"/profile/alarm/viewProfile.action?ruleId="+array[1];
        	openViewPage(url,panelX,panelY);
        });
		return $font;
	}
	},{index:"operation",fn:function(td){
		if(td.html == "") {return;}
		if(defaultRuleId != td.html) {
			$font = $('<span class="ico ico-t-right" id="'+td.html+'"></span>');
			return $font;
		}			
	  }
    }]);
	
	var page = new Pagination({applyId:"page",listeners:{
		pageClick:function(page){
		$("#currentPage").val(page);
		var ajaxParam = $formObj.serialize();
		$.ajax({
			type: "POST",
			dataType:'json',
			url: path+"/profile/alarm/jsonSort.action",
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
	setLeftTreeNum();
	setAllSelect();
	setRecordCheckBox();
	embellishRecordSelect();
	setMenu();
}

function embellishRecordSelect() {
	var array = [];
    $(".senMethodCss").each(function (index, domEle) {
    	array.push(domEle.id);
    });
    $(".receiversCss").each(function (index, domEle) {
    	array.push(domEle.id);
    });
    SimpleBox.renderTo(array);
}
function setAllSelect() {
	var $allSelect = $("#allSelect");
	$allSelect.click(function() {
    	$("input[name='alarmRuleId']").attr("checked",$allSelect.attr("checked"));
    });
}
function setRecordCheckBox() {
	var $allSelect = $("#allSelect");
	$("input[name='alarmRuleId']").click(function() {
	 	   var param = $(this).attr("checked");
	 	   if(param == false) {
	 		   $allSelect.attr("checked", false);
	 	   }
	});
}
function setLeftTreeNum() {
	if(typeof(alarmCount) == 'function') {
		alarmCount($('#leftTreeNum').val());
	}
}
function setMenu() {
	var $delete = $("#delete");
	var mc = new MenuContext({x:20,y:100,width:80,listeners:{click:function(id){alert(id)}}});
    $(".ico-t-right").bind('click',function(e) {
    	var icoId = $(this).attr("id");
    	mc.addMenuItems( 
    	   [ 
	    	   [ {text : "删除",id : "delete_bu",listeners : {click : function() {setEditMenu(icoId,$delete);}}},
	    	     {text : "编辑",id : "edit_bu",listeners : {click : function() {openEditAlarmDefPage(icoId);}}}
	    	   ] 
    	   ]);
    	mc.position(e.clientX-30,e.clientY-10);
    });
}
function setEditMenu(Id, obj) {
	setChecked(Id,true);
	obj.click();
}
function setChecked(Id,flag) {
	$("#"+Id+"_checkbox").attr("checked",flag);
}
function openViewPage(url,panelX,panelY) {
	if(panel != null) {
		panel.close("close");
	}
	panel = new winPanel( {
		url : url,
		width : 550,
		x:panelX,
		y:panelY,
		isautoclose: true,
		closeAction: "close",
		listeners : {
			closeAfter : function() {
				panel = null;
			},
			loadAfter : function() {
			}
		}
	}, {
		winpanel_DomStruFn : "blackLayer_winpanel_DomStruFn"
	}); 
}