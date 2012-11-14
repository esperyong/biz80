$(function(){
    var $formObj = $("#queryForm");
    var $notificationObjId = $("#notificationObjId");
    var $nameorip = $("#nameorip");
    var $nameoripvalue = $("input[name='nameoripvalue']");
    var $notificationObjId1 = $("#notificationObjId1");
    var $nameorip1 = $("#nameorip1");
    var $nameoripvalue1 = $("input[name='nameoripvalue1']");
    var $domainId = $("#domainId");
    var $notionState = $("notionState");
    var $platform = $("platform");
    var $radio = $("input[name='radio']");
    var $sendTime = $("#sendTime");
    var $startTime = $("input[name='notStartTime']");
    var $endTime = $("input[name='notEndTime']");
    var $radio1 = $("input[name='radio1']");
    var $sendTime1 = $("#sendTime1");
    var $startTime1 = $("input[name='notStartTime1']");
    var $endTime1 = $("input[name='notEndTime1']");
    var $notContent = $("input[name='notContent']");
    var $querenBody = $("input[name='querenBody']");
    var $querenStartTime = $("input[name='querenStartTime']");
    var $querenEndTime = $("input[name='querenEndTime']");
    var $searchDis = $("input[name='searchDis']");
    var $search = $("#search");
    var $export = $("#export");
    var $searchAdvanced = $("#searchAdvanced");
    var $openSearchAd = $("#openAdvancedSearch");
    var $simpleSearch = $("#simpleSearch");
    var $advancedSearch = $("#advancedSearch");
    var $openSearchSi = $("#openSimpleSearch");
    var $level = $("input[name='level']");
    var toast = new Toast({position:"CT"});
    var mc = new MenuContext({x:820,y:55,width:150,plugins:[duojimnue]});

    $search.click(function(){
		if($radio1[1].checked){
			if($startTime1.val().length <= 0){
				toast.addMessage("请选择开始时间。");
				return false;
			}
			if($endTime1.val().length <=0){
				toast.addMessage("请选择结束时间。");
				return false;
			}
			if($startTime1.val() > $endTime1.val()){
				toast.addMessage("开始时间必须大于结束时间。");
				return false;
			}
		}
		$searchDis.val("simpleSearchstr");
		$level.val("");
    	doSubmit($formObj, path+"/notification/historyNotificationSearch.action");
    });
    
    $searchAdvanced.click(function(){
		if($radio[1].checked){
			if($startTime.val().length <= 0){
				toast.addMessage("请选择开始时间。");
				return false;
			}
			if($endTime.val().length <=0){
				toast.addMessage("请选择结束时间。");
				return false;
			}
			if($startTime.val() > $endTime.val()){
				toast.addMessage("开始时间必须大于结束时间。");
				return false;
			}
		}
		$searchDis.val("advancedSearchstr");
		$level.val("");
    	doSubmit($formObj, path+"/notification/historyNotificationSearch.action");
    });
    
    $openSearchAd.click(function(){
    	$searchDis.val("advancedSearchstr");
    	$openSearchSi.show();
    	$('#advancedSearch').show();
		$('#simpleSearch').hide();
    });
    
    $openSearchSi.click(function(){
    	$searchDis.val("simpleSearchstr");
    	$openSearchSi.hide();
    	$('#advancedSearch').hide();
		$('#simpleSearch').show();
    });
    $radio.click(function() {

    });
    
    $startTime1.click(function(){
   		WdatePicker({startDate:getDate(),dateFmt:'yyyy/MM/dd HH:mm:ss'});
    });
    
    $endTime1.click(function(){
  	 	WdatePicker({startDate:getDate(),dateFmt:'yyyy/MM/dd HH:mm:ss'});
    });
    
    $startTime.click(function(){
   		WdatePicker({startDate:getDate(),dateFmt:'yyyy/MM/dd HH:mm:ss'});
    });
    
    $endTime.click(function(){
  	 	WdatePicker({startDate:getDate(),dateFmt:'yyyy/MM/dd HH:mm:ss'});
    });
    
    $querenStartTime.click(function(){
   		WdatePicker({startDate:getDate(),dateFmt:'yyyy/MM/dd HH:mm:ss'});
    });
    
    $querenEndTime.click(function(){
  	 	WdatePicker({startDate:getDate(),dateFmt:'yyyy/MM/dd HH:mm:ss'});
    });
    
    $export.click(function (){
		var _confirm = new confirm_box({text:"最多能导出最近1000条数据，是否继续？"});
		_confirm.setConfirm_listener(function(){
	    	doSubmit($formObj, path+"/notification/historyNotificationExport.action");
			_confirm.hide();
		});
		_confirm.show();
    })
    
    function openMenu(id){
   		var ids=new StringBuilder();
		var allcheckboxs = $("input[name='Ids']:checked");
		if(!haveSelectNotification(allcheckboxs,toast)) {
    		return;
    	}
    	for(var i=0;i<allcheckboxs.length;i++)
		{
            var notid=$(allcheckboxs[i]).attr("value");
            ids.Append(notid)
            if((i+1) != allcheckboxs.length)
            ids.Append(",");
		}
		var strIds=ids.ToString();
		var data = function(){};
		data.userId = userId;
		data.ids = strIds;
        if(id=="affirm" || id=="againinstall"){
        	if(id=="affirm"){
        		data.isConfirm = 'true';
        	}else{
        		data.isConfirm = 'false';
        	}
			$.ajax({
				type:"POST",
				url:path + "/notification/menu/confirm.action",
				data:data,
				success:function(){
					mc.hide();
					//var url = "/notification/historyNotificationlist.action";
					//changeGridMain(url);
					document.location.href = document.location.href;
				}
			});
        }else if(id=="delete"){
			var _confirm = new confirm_box({text:"确定要删除吗？"});
			_confirm.setConfirm_listener(function(){
	        	$.ajax({
					type:"POST",
					url:path + "/notification/deleteNotification.action",
					data:data,
					success:function(){
						mc.hide();
						doSubmit($formObj, path+"/notification/historyNotificationSearch.action");
						_confirm.hide();
					}
				});
				return false;
			});
			_confirm.show();
        }else if(id=="editseverity"){

        }else if(id=="severe"){
			data.levelId = levelIds[0];
			$.ajax({
				type:"POST",
				 url:path+"/notification/alterNotificationLevel.action",
				 data:data,
				 success:function(){
				 	mc.hide();
				 	//var url = "/notification/historyNotificationlist.action";
					//changeGridMain(url);
				 	document.location.href = document.location.href;
				 }
			});
        }else if(id=="critical"){
			data.levelId = levelIds[1];
			$.ajax({
				type:"POST",
				 url:path+"/notification/alterNotificationLevel.action",
				 data:data,
				 success:function(){
				 	mc.hide();
				 	//var url = "/notification/historyNotificationlist.action";
					//changeGridMain(url);
				 	document.location.href = document.location.href;
				 }
			});
        }else if(id=="error"){
			data.levelId = levelIds[2];
			$.ajax({
				type:"POST",
				 url:path+"/notification/alterNotificationLevel.action",
				 data:data,
				 success:function(){
				 	mc.hide();
				 	//var url = "/notification/historyNotificationlist.action";
					//changeGridMain(url);
				 	document.location.href = document.location.href;
				 }
			});
        }else if(id=="warning"){
			data.levelId = levelIds[3];
			$.ajax({
				type:"POST",
				 url:path+"/notification/alterNotificationLevel.action",
				 data:data,
				 success:function(){
				 	mc.hide();
				 	//var url = "/notification/historyNotificationlist.action";
					//changeGridMain(url);
				 	document.location.href = document.location.href;
				 }
			});
        }else if(id=="informational"){
			data.levelId = levelIds[4];
			$.ajax({
				type:"POST",
				 url:path+"/notification/alterNotificationLevel.action",
				 data:data,
				 success:function(){
				 	mc.hide();
				 	//var url = "/notification/historyNotificationlist.action";
					//changeGridMain(url);
				 	document.location.href = document.location.href;
				 }
			});
        }else if(id=="unknown"){
			data.levelId = levelIds[5];
			$.ajax({
				type:"POST",
				 url:path+"/notification/alterNotificationLevel.action",
				 data:data,
				 success:function(){
				 	mc.hide();
				 	//var url = "/notification/historyNotificationlist.action";
					//changeGridMain(url);
				 	document.location.href = document.location.href;
				 }
			});
        }else if(id=="emailorsms"){
			var url = path+"/notification/openFwEmailAndSMS.action?eventDataId="+strIds;
			winOpen({
	            url: url,
	            width: 550,
	            height: 478,
	            name: 'openFwEmailAndSMS'
	         });
			mc.hide();
        }
    }
    $('#batchOperate').bind('click',function(event){
    	 mc.position(event.pageX,event.pageY+10);
    	 var operate = [];
    	 operate.push(
    	 	{text:"确认",id:"affirm",listeners:{click:function(){
			 var id =  $(this).attr('id');
			 openMenu(id);
		 	}}}
    	 );
    	 operate.push(
    	 	{text:"取消确认",id:"againinstall",listeners:{click:function(){
			 var id =  $(this).attr('id');
			 openMenu(id);
		 	}}}
    	 );
    	 
    	var data = function(){};
		data.userId = userId;
		$.ajax({
			type:"POST",
			url:path + "/notification/isShowMenu.action",
			data:data,
			success:function(data){
				if(data.isShowMap.upSeverity){
					operate.push(
			    	 	{text:"修改级别",id:"editseverity",childMenu:{width:120,menus:[[
					     {text:levelnames[0],id:"severe",listeners:{click:function(){
					    	 var id =  $(this).attr('id');
					    	 openMenu(id);
					     }}},{text:levelnames[1],id:"critical",listeners:{click:function(){
					    	 var id =  $(this).attr('id');
					    	 openMenu(id);
					     }}},{text:levelnames[2],id:"error",listeners:{click:function(){
					    	 var id =  $(this).attr('id');
					    	 openMenu(id);
					     }}},{text:levelnames[3],id:"warning",listeners:{click:function(){
					    	 var id =  $(this).attr('id');
					    	 openMenu(id);
					     }}},{text:levelnames[4],id:"informational",listeners:{click:function(){
					    	 var id =  $(this).attr('id');
					    	 openMenu(id);
					     }}},{text:levelnames[5],id:"unknown",listeners:{click:function(){
					    	 var id =  $(this).attr('id');
					    	 openMenu(id);
					     }}}]]}}
			    	 );
				}else{
					operate.push(
			    	 	{text:"修改级别",id:"editseverity",disable:false,disablePrompt:"无此权限，请联络系统管理员。",listeners:{click:function(){}}}
			    	 );
				}
				if(data.isShowMap.deleteNoti){
					operate.push(
			    	 	{text:"删除",id:"delete",listeners:{click:function(){
					    	 var id =  $(this).attr('id');
					    	 openMenu(id);
						}}}
			    	 );
				}else{
					operate.push(
			    	 	{text:"删除",id:"delete",disable:false,disablePrompt:"无此权限，请联络系统管理员。",listeners:{click:function(){}}}
			    	 );
				}
		    	 operate.push(
		    	 	{text:"转发",id:"emailorsms",listeners:{click:function(){
						 var id = $(this).attr('id');
						 openMenu(id);
					}}}
		    	 );
				 mc.addMenuItems([operate]);
			}
		})
 	})
});
function StringBuilder()
{
    this.buffer = new Array();
}
StringBuilder.prototype.Append = function Append(string)
{
    if ((string ==null) || (typeof(string)=='undefined'))
        return;
    if ((typeof(string)=='string') && (string.length == 0))
        return;
    this.buffer.push(string);
}
StringBuilder.prototype.ToString = function ToString()
{
    return this.buffer.join("");
}
function searchCount(levelid){
	var $level = $("input[name='level']");
	var $searchDis = $("input[name='searchDis']");
	if($searchDis.val()=="simpleSearch"){
		var $radio = $("input[name='radio1']");
    	var $sendTime = $("#sendTime1");
    	var $startTime = $("input[name='notStartTime1']");
    	var $endTime = $("input[name='notEndTime1']");
	}else{
		var $radio = $("input[name='radio']");
	    var $sendTime = $("#sendTime");
	    var $startTime = $("input[name='notStartTime']");
	    var $endTime = $("input[name='notEndTime']");
    }
	var $formObj = $("#queryForm");
	$level.val(levelid);
	if($radio[1].checked){
			if($startTime.val().length <= 0){
				toast.addMessage("请选择开始时间。");
				return false;
			}
			if($endTime.val().length <=0){
				toast.addMessage("请选择结束时间。");
				return false;
			}
			if($startTime.val() > $endTime.val()){
				toast.addMessage("开始时间必须大于结束时间。");
				return false;
			}
		}
    	doSubmit($formObj, path+"/notification/historyNotificationSearch.action");
}


function doSubmit(formObj, actionUrl) {
	formObj.attr("action", actionUrl);
	formObj.submit();
}
function getDate(){
	var now = new Date();
	var year = now.getFullYear();
	var month=now.getMonth()+1;
	var day=now.getDate();
    var hour=now.getHours();
    var minute=now.getMinutes();
    var second=now.getSeconds();
    var nowdate=year+"-"+month+"-"+day+" "+hour+":"+minute+":"+second;
    return nowdate;
}
function haveSelectNotification(obj,toast) {
	if(obj.length == 0) {
		toast.addMessage("请至少选择一项。");
		return false;
	}
	return true;
}
function changeGridMain(url){
	var $formObj = $("#queryForm");
	var grid =$("#child_cirgrid");
	var ajaxParam = $formObj.serialize();
	 $.ajax({
		   type: "POST",
		   dataType:'html',
		   url:path+url,
		   data: ajaxParam,
		   success: function(data, textStatus){
		    $(grid).html("");
		    $(grid).append(data);
	   }
	 });
}

