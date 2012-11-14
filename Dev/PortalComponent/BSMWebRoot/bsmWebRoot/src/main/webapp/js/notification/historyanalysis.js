var userId,vId,piId;

function refreshFlashHistory(uid, viewId, parentInstanceId) {
	userId=uid;
	vId=viewId;
	piId = parentInstanceId;
}

function getUserId(){
	return userId;
}
function getViewId(){
	return vId;
}
function getParentInstanceId(){
	return piId;
}

// 打开详细页面 TODO flash 传值有问题 现在还是传的notificationId 要改成eventDataId
function openDetailPage(eventDataId){
	var url = path+'/notification/opencontentInfo.action';
	if(eventDataId != undefined && eventDataId != null ){
		url = url + '?eventDataId=' + eventDataId;
		 winOpen({
            url: url,
            width: 800,
            height: 333,
            name: 'openDetailPage'
         });
	}
}