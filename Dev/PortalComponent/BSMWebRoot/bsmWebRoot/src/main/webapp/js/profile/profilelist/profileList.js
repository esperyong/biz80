$(function(){
    var $formObj = $("#profileListForm");
    var $doMainId = $("#domainId");
    var $profileType = $("#profileType");
    var $profileState = $("#profileState");
    var $add = $("#add");
    var $copy = $("#copy");
    var $batchOperate = $("#batchOperate");
    var $import = $("#import");
    menu = new MenuContext({x : 0,y : 0,width:100,plugins:[duojimnue]});
    win = new confirm_box({title:'提示',text:'此操作不可恢复，是否确认执行此操作？',cancle_listener:function(){win.hide();}});
    $add.click(function(){
    	openProfileDefPage(null);
    });
    $batchOperate.click(function(event){
    	if(!haveSelectProfile($("input[name='profileIds']:checked"))) {
    		return;
    	}
    	showMenu(event);
    });
    $copy.click(function(){
    	var checked = $("input[name='profileIds']:checked");
    	if(!haveSelectProfile(checked)) {
    		return;
    	}
    	if(checked.length > 1) {
    		//$("input[type='checkbox']").attr("checked",false);
    		return;
    	}
    	var Id = $("input[name='profileIds']:checked").val();
    	var winOpenObj = {};
    	winOpenObj.height = '330';
		winOpenObj.width = '548';
		winOpenObj.name = 'profileCopy';
		winOpenObj.url = path+"/profile/copyProfileQuery.action?profileIds="+Id;
		winOpenObj.scrollable = true;
		winOpen(winOpenObj);
    });
    
    $doMainId.change(function() {
    	changeGrid("/profile/jsonSort.action");
    });
    $profileType.change(function() {
    	changeGrid("/profile/jsonSort.action");
    });
    $profileState.change(function() {
    	changeGrid("/profile/jsonSort.action");
    });
    $import.click(function(){
    	var winOpenObj = {};
		winOpenObj.width = '500';
		winOpenObj.height = '400';
		winOpenObj.name = 'importProfile';
		winOpenObj.url = path+"/profile/goToImportPage.action";
		winOpenObj.scrollable = true;
		winOpen(winOpenObj);
    });
    function embellishConditionSelect() {
    	var array = [];
    	array.push($doMainId.attr("id"));
    	array.push($profileType.attr("id"));
    	array.push($profileState.attr("id"));
    	SimpleBox.renderTo(array);
    }
    embellishConditionSelect();
});
function showMenu(event){
	var $formObj = $("#profileListForm");
	 menu.position(event.pageX,event.pageY);
	 var operate = [];
	 operate.push({
		 text:"启用",
		 id:"start",
		 listeners:{
		 	click:function(){
		 		start();
		 		menu.hide();
       	}}
	 	},
	  {
	 	text:"禁用",
	 	id:"stop",
	 	width:150,
	 	listeners:{
	 		click:function(){
	 			stop();
	 			menu.hide();
         	}}
      	},
	  {
       text:"导出",
   	id:"export",
   	childMenu:{
   	width:150,
   	menus:[[
   	     {
   	    	 text:"Excel",
   	    	 id:"xls_bu",
   	    	 listeners:{
   	    	 	click:function(){
   	    			doSubmit($formObj, path+"/profile/profileXlsExport.action");
   	    			menu.hide();
   	    		}
   	     	}
   	     }
   	    ,{
   	    	text:"序列化",
   	    	id:"serial_bu",
   	    	listeners:{
   	    		click:function(){
   	    			doSubmit($formObj, path+"/profile/profileSerialExport.action");
   	    			menu.hide();
   	    		}
   	    	}
   	    }]]}
	    }
	  );
	 //if(defaultType == "false"){
		 operate.push({
			 text:"删除",
			 id:"delete",
			 listeners:{
			 	click:function(){
			 		deletes();
			 		menu.hide();
	       		}}
		 	});
	 //}
	 menu.addMenuItems([operate]);
}
function start(){
	var ajaxParam = $("#profileListForm").serialize();
		$.ajax({
			type: "POST",
			dataType:'json',
			url: path+"/profile/profileListStart.action",
			data: ajaxParam,
			success: function(data, textStatus){
				setStartStopState(data);
			},
			error: function(data, textStatus) {   
			}
		});
}
function stop(){
	var ajaxParam = $("#profileListForm").serialize();
		$.ajax({
			type: "POST",
			dataType:'json',
			url: path+"/profile/profileListStop.action",
			data: ajaxParam,
			success: function(data, textStatus){
				setStartStopState(data);
			},
			error: function(data, textStatus) {  
			}
		});
}
function deletes(){
	if(!haveSelectProfile($("input[name='profileIds']:checked"))) {
			return;
	}
	if(haveStartProfile($("input[name='profileIds']:checked"))) {
		return;
	}
	win.setConfirm_listener(function(){
		win.hide();
		var $formObj = $("#profileListForm");
		var grid =$("#child_cirgrid"); 
		var ajaxParam = $formObj.serialize();
		 $.ajax({
			   type: "POST",
			   dataType:'json',
			   url:path+"/profile/profileListDelete.action",
			   data: ajaxParam,
			   success: function(data, textStatus){
			 		userDefineProfileRefresh(null,$("span[class=pitchUp]").parent().attr("id"));	
		   	   }
		 });
	});	
	win.show();
}

function openProfileDefPage(Id) {
	var winOpenObj = {};
	
	if(Id != null) {
		$.ajax({
		   type: "post",
		   dataType:'json',
		   url:path+"/profile/queryProfileExist.action?basicInfo.profileId="+Id,
		   success: function(data, textStatus){
		 		if(data.success != null && data.success == true) {
		 			winOpenObj.height = '630';
		 			winOpenObj.width = '970';
		 			winOpenObj.name = 'editProfileDef';
		 			winOpenObj.url = path+"/profile/userDefineProfile/queryProfile.action?basicInfo.profileId="+Id;
		 			winOpenObj.scrollable = true;
		 			winOpen(winOpenObj);
		 		}else {
		 			var _information = new information({text:"策略已被删除。"});
					_information.show();
					userDefineProfileRefresh();
					return false;
		 		}
		   }
		 });
	}else {
		winOpenObj.height = '330';
		winOpenObj.width = '548';
		winOpenObj.name = 'addProfileDef';
		winOpenObj.url = path+"/profile/addstrategy.action";
		winOpenObj.scrollable = true;
		winOpen(winOpenObj);
	}
}
function doSubmit(formObj, actionUrl) {
	formObj.attr("action", actionUrl);
	formObj.submit();
}
function haveSelectProfile(obj) {
	if(obj.length == 0) {
		var _information = new information({text:"请至少选择一项。"});
		_information.show();
		return false;
	}
	return true;
}
function haveStartProfile(obj) {
	var flag = false;
	obj.each(function(){
		var clsName = $("#"+$(this).val()+"_state").attr("class");
		var num = clsName.indexOf("ico-play");
		 if(num != -1) {
			 flag = true;
		 }
	});
	if(flag) {
		var _information = new information({text:"不允许删除开启监控的策略。"});
		_information.show();
	}
	return flag;
}
function setStartStopState(data) {
	var jsonstr = (new Function("return "+data.dataList))();
	if(jsonstr){
	   var arrlength = jsonstr.length;
       for(var i=0;i<arrlength;i++){
    	   var array = jsonstr[i].value.split(",");
    	   $("#"+jsonstr[i].key+"_state").removeClass().addClass(array[0]);
    	   $("#"+jsonstr[i].key+"_state").attr("title",array[1]);
       }
       $("input[type='checkbox']").attr("checked",false);
	}
}

function changeGrid(url){
	var $formObj = $("#profileListForm");
	var grid =$("#child_cirgrid"); 
	var ajaxParam = $formObj.serialize();
	 $.ajax({
		   type: "POST",
		   dataType:'json',
		   url:path+url,
		   data: ajaxParam,
		   success: function(data, textStatus){
		 	if(gp != null) {
		        page.pageing(data.pageCount,1);
		    	gp.loadGridData(data.dataList);
		    	reloadData();
		    }
	   }
	 });
}