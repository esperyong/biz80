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
/**
* 业务分析分析图标
* 业务服务分析模块
*
*/
function analysisChart(chartURI, chartTitle){
	flashContenObj.callFlash("refreshChart", chartURI, chartTitle);
}


//设置字体大小，size：数字
function setFontSize(size){
flashContenObj.callFlash("setFontSize",size);
}
//设置字体颜色 color：0xff0000
function setFontColor(color){
flashContenObj.callFlash("setFontColor",color);
}
//设置字体是否加粗 style：bold/normal
function setFontWeight(style){
flashContenObj.callFlash("setFontWeight",style);
}
//设置文本是否有边框 borderVisible:true/false
function setBorderVisible(borderVisible){
flashContenObj.callFlash("setBorderVisible",borderVisible);
}
//设置线条颜色 color：0xff0000
function setLineColor(color){
flashContenObj.callFlash("setLineColor",color);
}
//设置线条大小 size:数字,需要js将磅数转换为像数
function setLineSize(size){
flashContenObj.callFlash("setLineSize",size);
}
//选择线条类型
//solid:实线
//dotted:点线
//l_dashed:长线段
//s_dashed:短线段
function setLineStyle(type){
flashContenObj.callFlash("setLineStyle",type);
}
//正常尺寸
function setTopoJustSize(){
flashContenObj.callFlash("setTopoJustSize");
}
//自适应窗口
function setTopoActaulSize(){
flashContenObj.callFlash("setTopoActaulSize");
}
//创建图形
//type: "circle"\"rect";\"elipse";\"rRect";\"arrow";\"polyLine";\"text";
//text:插入文本默认值：Sample Text
function createCustomShape(type,text){
flashContenObj.callFlash("createCustomShape",type,text);
}
//恢复
function redo(){
flashContenObj.callFlash("redo");
}
//撤销
function undo(){
flashContenObj.callFlash("undo");
}
//填充color：0xff0000
function setFill(color)
{
	flashContenObj.callFlash("setFill",color);
}

//缩小
function zoomIn(){
	flashContenObj.callFlash("zoomIn");
}
//放大
function zoomOut(){
	flashContenObj.callFlash("zoomOut");
}

//移动
function move(flag){
	flashContenObj.callFlash("move", flag);
}


//右键菜单(选择资源)
function callFlashRefreshResource(menuType, instanceId, instanceName){
	flashContenObj.callFlash("callFlashRefreshResource", menuType, instanceId, instanceName);
}

//创建图形
//type: "flow:流程"\"area:区域";map:地图;\"bgd：背景"
//uri：图片uri
//text:插入文本默认值：Sample Text
function createCustomPicture(type, uri, text){
	flashContenObj.callFlash("createCustomPicture", type, uri, text);
}
//判断是否需要保存当前拓扑
function callSaveTopoFlag(){
	return flashContenObj.callFlash("isCallSaveTopo");
}

 /**
  * 设置线条箭头样式。
  * type：
  *    none  无
  *    source 左
  *    dest   右
  *    double双向
  *
  */
function setLineArrow(type){
	flashContenObj.callFlash("setLineArrow",type);
}

function refreshInsanceMonitorState(instanceId,monitored){
	flashContenObj.callFlash("refreshInsanceMonitorState",instanceId,monitored);
}
