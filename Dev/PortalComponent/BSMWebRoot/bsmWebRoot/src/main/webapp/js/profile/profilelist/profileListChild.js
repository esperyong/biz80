var gp = null;
var page = null;
$(function(){
	var $formObj = $("#profileListForm");
	
	var $dataListDiv = $("#dataListDiv");
	var panelX =$dataListDiv.width()/2;
	var panelY =$dataListDiv.height()/2-100; 
	
	var columnW;
	if(defaultType == "true") {
		columnW = {checkBox:"5",enabled:"7",name:"26",resourceName:"25",resourceNum:"20",alarmNum:"10",operation:"7"};
	}else {
		columnW = {checkBox:"5",enabled:"7",name:"17",domain:"16",resourceName:"16",resourceNum:"19",alarmNum:"13",operation:"7"};
	}
	gp = new GridPanel({id:"tableId",
			columnWidth:columnW,
			unit: "%",
			plugins:[SortPluginIndex],
			sortColumns:[{index:"enabled"},
			             {index:"name",defSorttype:"down"}],
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
	              url: path+"/profile/jsonSort.action?"+ajaxParam,
	              success: function(data, textStatus){
	        			gp.loadGridData(data.dataList);
	        			reloadData();
	              }
	        });
	        }},{gridpanel_DomStruFn:"index_gridpanel_DomStruFn",gridpanel_DomCtrlFn:"index_gridpanel_DomCtrlFn",gridpanel_ComponetFn:"index_gridpanel_ComponetFn"});
		
		gp.rend([{index:"checkBox",fn:function(td){
			if(td.html == "") {return;}
			$font = $('<input type="checkbox" name="profileIds" id="'+td.html+'_checkbox" value="'+td.html+'">');
			$font.bind("click",function(){ 
				forbidCopy();
			});
			return $font;
		}
		},{index:"enabled",fn:function(td){
			if(td.html == "") {return;}
			var array = td.html.split('@');
			$font = $('<span id="'+array[0]+'_state" class="'+array[1]+'" title="'+array[2]+'"/>');
			return $font;
		}
		},{index:"name",fn:function(td){
			if(td.html == "") {return;}
			var array = td.html.split('@');
			$font = $('<font style="cursor:pointer" title="'+array[1]+'">'+array[1]+'</font>');
			$font.bind("click",function(){ 
				openProfileDefPage(array[0]);
			});
			return $font;
		}
		}/*,{index:"domain",fn:function(td){
			if(td.html == "") {return;}
			$font = $('<font title="'+td.html+'">'+td.html+'</font>');
			return $font;
		}
		},{index:"resourceName",fn:function(td){
			if(td.html == "") {return;}
			var array = td.html.split('@');
			$font = $('<font style="cursor:pointer" title="'+array[1]+'">'+array[1]+'</font>');
			$font.bind("click",function(){
				openProfileDefPage(array[0]);
			});
			return $font;
		}
		}*/,{index:"resourceNum",fn:function(td){
			if(td.html == "") {return;}
			var array = td.html.split('@');
			$font = $('<span class="span-width-50px"><font align="right">'+array[1]+'个</font></span><span><span class="gray-btn-l"><span class="btn-r"><span class="btn-m"><a>查看</a></span></span></span></font></span>');
			$font.children(".gray-btn-l").bind("click",function(event){
				var url = path+"/profile/viewResource.action?profileId="+array[0];
				openViewPage(url,panelX,panelY);
			});
			return $font;
		}
		},{index:"alarmNum",fn:function(td){
			if(td.html == "") {return;}
			var array = td.html.split('@');
			var cls;
			if(array[1] == "true"){cls="ico-alert"}else{cls="ico-alert-off"}
			$font = $('<span class="alertflag ico '+cls+'" id="'+array[0]+'" title="点击查看使用的告警规则"></span>');
			$font.bind("click",function(event){
				var url = path+"/profile/viewAlarm.action?profileId="+array[0];
				openViewPage(url,panelX,panelY);
			});
			return $font;
		}
		},{index:"operation",fn:function(td){
			if(td.html == "") {return;}
			$font = $('<span class="ico ico-t-right" id="'+td.html+'"></span>');
			return $font;
		}
		}]);
    
    page = new Pagination({applyId:"page",listeners:{
	    pageClick:function(page){
    		 $("#currentPage").val(page);
			 var ajaxParam = $formObj.serialize();
			 $.ajax({
				   type: "POST",
				   dataType:'json',
				   url: path+"/profile/jsonSort.action",
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
	setMenu();
}
function setAllSelect() {
	var $allSelect = $("#allSelect");
	$allSelect.click(function() {
		if($allSelect.attr("checked")){
			$("#copybtn").removeClass("black-btn-l f-right");
			$("#copybtn").addClass("black-btn-l-off f-right");
		}else{
			$("#copybtn").removeClass("black-btn-l-off f-right");
			$("#copybtn").addClass("black-btn-l f-right");
		}
    	$("input[name='profileIds']").attr("checked",$allSelect.attr("checked"));
    });
}
function setRecordCheckBox() {
	var $allSelect = $("#allSelect");
	$("input[name='profileIds']").click(function() {
	 	   var param = $(this).attr("checked");
	 	   if(param == false) {
	 		   $allSelect.attr("checked", false);
	 	   }
	});
}
function setLeftTreeNum() {
	if(defaultType == "true") {
		if(typeof(changeSystemProfileCount) == 'function') {
			changeSystemProfileCount($('#leftTreeNum').val());
		}
	}else {
		if(typeof(changeUserDefineProfileCount) == 'function') {
			changeUserDefineProfileCount($('#leftTreeNum').val());
		}
	}
}
function setMenu() {
    var $copy = $("#copy");
	var mc = new MenuContext({x:50,y:100,width:80,listeners:{click:function(id){alert(id)}}});
    $(".ico-t-right").bind('click',function(e) {
    	var array = $(this).attr("id").split('@');
    	var icoId = array[0];
    	var type = array[1];
    	var state = $(this).parent().parent().find("td[colId=enabled] :first-child").attr("class");
    	var startButton = {text : "启用",id : "start_bu",listeners : {click : function() {setEditMenu(icoId,"start");}}};
    	var stopButton = {text : "禁用",id : "stop_bu",listeners : {click : function() {setEditMenu(icoId,"stop");}}};
    	var copyButton = {text : "复制",id : "copy_bu",listeners : {click : function() {setEditMenu(icoId,$copy);}}};
    	var deleteButton = {text : "删除",id : "delete_bu",listeners : {click : function() {setEditMenu(icoId,"deletes");}}};
    	/*var exportButton = {ico : "export",text : "导出",id : "export_bu",listeners : {click : function() {setEditMenu(icoId,$export);}}}*/
    	if(state.indexOf("ico-play") >= 0) {
    		startButton = {disable : false, text : "启用",id : "start_bu",listeners : {click : function() {}}};
    	}else {
    		stopButton = {disable : false, text : "禁用",id : "stop_bu",listeners : {click : function() {}}};
    	}
    	if(type=="false"){
    		mc.addMenuItems([[startButton,stopButton, copyButton, deleteButton]]);
    	}else {
    		mc.addMenuItems([[startButton,stopButton, copyButton]]);
    	}
    	mc.position(e.clientX-50,e.clientY-10);
    });
}
function setEditMenu(Id,obj) {
	$("input[name='profileIds']").attr("checked",false);
	setChecked(Id,true);
	if(obj=="start"){
		start();
		setChecked(Id,false);
	}else if(obj=="stop"){
		stop();
		setChecked(Id,false);
	}else if(obj == "deletes"){
		deletes();
	}else {
		obj.click();
		setChecked(Id,false);
	}
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
		width : 600,
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
function forbidCopy(){
	var checked = $("input[name='profileIds']:checked");
	if(checked.length > 1) {
		$("#copybtn").removeClass("black-btn-l f-right");
		$("#copybtn").addClass("black-btn-l-off f-right");
		//$("#copybtn").className='black-btn-l-off';
	}else if(checked.length <= 1){
		$("#copybtn").removeClass("black-btn-l-off f-right");
		$("#copybtn").addClass("black-btn-l f-right");
		//$("#copybtn").className='black-btn-l f-right';
	}
}