$(function(){
    var $formObj = $("#nftListForm");
    var $notificationObjId = $("#notificationObjId");
    var $nameorip = $("#nameorip");
    var $nameoripvalue = $("input[name='nameoripvalue']");
    var $domainId = $("#domainId");
    var $reception = $("#reception");
    var $sendmode = $("#sendmode");
    var $radio = $("input[name='radio']");
    var $sendTime = $("#sendTime");
    var $startTime = $("input[name='startTime']");
    var $endTime = $("input[name='endTime']");
    var $search = $("#search");
    var $export = $("#export");
    var toast = new Toast({position:"CT"});
    $search.click(function(){
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
    	doSubmit($formObj, path+"/notification/notificationlistSearch.action");
    });
    $radio.click(function() {

    });
    $startTime.click(function(){

   		WdatePicker({startDate:getDate(),dateFmt:'yyyy/MM/dd HH:mm:ss'});

    });
    $endTime.click(function(){

  	 	WdatePicker({startDate:getDate(),dateFmt:'yyyy/MM/dd HH:mm:ss'});

    });
    $export.click(function (){
		//if(!confirm("最多能导出最近1000条数据，是否继续？")){
		//	return false;
		//
		var _confirm = new confirm_box({text:"最多能导出最近1000条数据，是否继续？"});
		_confirm.setConfirm_listener(function(){
	    	doSubmit($formObj, path+"/notification/NotificationLogExport.action");
			_confirm.hide();
		});
		_confirm.show();
    })

});

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
