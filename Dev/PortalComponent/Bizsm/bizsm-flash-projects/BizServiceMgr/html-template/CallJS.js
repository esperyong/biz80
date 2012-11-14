
function saveTopoComplete(uri, serviceId){
	f_updateLeftPanel();
}

function loadTopoDataComplete(uri, serviceId){
	f_readRightPullBox(serviceId);
}
function initTopoFlashComplete(){
	f_readLeftPanel();
	f_createToolBar();
}