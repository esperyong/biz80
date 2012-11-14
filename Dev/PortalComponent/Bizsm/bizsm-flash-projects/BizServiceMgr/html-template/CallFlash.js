var flashContenObj;
function initFlashContentObj(flashId){
	flashContenObj = document.getElementById(flashId);
}

function unChoose(){
	//alert("unChoose");
	flashContenObj.callFlash("unChoose");
}

function choose(type,uri){
	//alert("type:"+type+"&&&"+uri);
	flashContenObj.callFlash("choose",type,uri);
}

function editComplete(type,uri){
	flashContenObj.callFlash("editComplete",type,uri);
}

function deleteComplete(type,uri){
	flashContenObj.callFlash("deleteComplete",type,uri);
}

function saveTopo(webRootPath){
	//alert("saveTopo:"+webRootPath);
	flashContenObj.callFlash("saveTopo", webRootPath);
}

function chooseTopo(uri){
	//alert("chooseTopo:"+uri);
	flashContenObj.callFlash("chooseTopo",uri);
}

function deleteSelectedCmps(){
	flashContenObj.callFlash("deleteSelectedCmps");
}

function refreshTopo(){
	flashContenObj.callFlash("refreshTopo");
}
