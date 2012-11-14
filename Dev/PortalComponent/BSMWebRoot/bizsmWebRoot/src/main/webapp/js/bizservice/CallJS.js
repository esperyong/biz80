
/**
* description: flash保存业务服务拓扑结束后回调js函数
* module: 业务服务定义
* param String uri
* param String serviceId
*/
function saveTopoComplete(uri, serviceId){
	//调用业务服务定义主框架页面定义的js函数.
	f_updateBizServiceList();

	//保存服务定义拓扑之后,重新展开右面服务选择区
	f_expanseSlab("slab-1");
}
/**
* description: flash加载业务服务拓扑结束后回调js函数
* module: 业务服务定义
* param String uri
* param String serviceId
*/
function loadTopoDataComplete(uri, serviceId){
	//调用业务服务定义主框架页面定义的js函数.
	f_readRightPullBox(serviceId);
}
/**
* description: flash初始化业务服务拓扑结束后回调js函数
* module: 业务服务定义
*/
function initTopoFlashComplete(){
	//调用业务服务定义主框架页面定义的js函数.
	f_loadBizDefineTopo();
	f_createToolBar();
}

/**
* description: 双击业务服务一览幕墙上某一业务服务时回调js函数
* module: 业务服务管理-->业务服务一览
* param String serviceId
*/
function forwardToBizService(serviceId){
	//调用业务服务一览页面定义的js函数.
	f_forwardToBizServiceDeep(serviceId);
}


function openImageList(menuType, nodeType){
// window.open("?menuType="+menuType + "&nodeType=" + nodeType);
	var childWin =  window.open('../../../bizsm/bizservice/ui/bizimg-select?menuType='+menuType+'&nodeType='+nodeType+'&iconFlag=false', 'ImageSelect', 'height=400, width=590, top=150, left=300, toolbar=no, menubar=no, scrollbars=yes, resizable=no,location=no, status=no');
	childWin.focus();
}
function openAllResource(menuType){
	var childWin = window.open('../../../bizsm/bizservice/ui/bizresourcetreeview-select?menuType='+menuType+'&fromFlash=true', 'ImageSelect', 'height=400, width=590, top=150, left=300, toolbar=no, menubar=no, scrollbars=yes, resizable=no,location=no, status=no');
	childWin.focus();
}
function openSubResource(menuType, resourceId, resourceName){
	var childWin = window.open('../../../bizsm/bizservice/ui/bizsubresourcetreeview-select?menuType='+menuType+'&fromFlash=true&resourceId='+resourceId+"&resourceName="+resourceName, 'ImageSelect', 'height=400, width=480, top=150, left=300, toolbar=no, menubar=no, scrollbars=yes, resizable=no,location=no, status=no');
	childWin.focus();
}
/**
*  toolBoxEnable:
*   {
*		deleteSelectedCmps:false,		   //删除元素按钮
*       refreshTopo:true,		   //刷新
*       saveTopo:true,              //保存
*       setTopoActaulSize:true,     //实际大小
*              setTopoJustSize:true,       //自适应大小
*              setFontSize:true,           //字体大小
*              setFontColor:true,          //字体颜色
*              setFontWeight:true,         //字体是否加粗
*              setBorderVisible:false,     //显示边框
*              setLineColor:true,          //线条颜色
*              setLineSize:true,           //线条大小
*              setLineStyle:true,          //线条样式
*              createCustomShape:true,     //插入文本
*              redo:false,                 //撤销
*              undo:false,                 //恢复
*              setFill:false,              //填充自定义图像
*   }
*/
function callToolBoxEnable(toolBoxEnable){
	f_setToolEnable(toolBoxEnable);
}
/**
* 显示某个业务服务
* @param String bizServiceId (业务服务ID)
*
*/
function displayBizService(bizServiceId){
	f_expanseBizService(bizServiceId)
}
/**
* description: 弹出详细信息页面
* module: 业务服务定义
* param String url
* param String instanceId
*/
function openDetailPage(url,instanceId){
	 if(!idUtil){
		idUtil = new IDToOpenWinName();
	 }
	  var name = "name" + idUtil.getShortId(instanceId);
	//width:980,height:600,scrollable:false,name:'resdetail_'+instanceId
	 var height = 600; //screen.height;
	 var width = 980;//screen.width;
	 //var avWidth = document.body.offsetWidth;
	 //var avHeight = document.body.offsetHeight;

	 //var left = (avWidth - width)/2;
	 //var top = (avHeight - height)/2;
	 var widSize = screen.width;
	 var settings = "Height="+height+",Width="+width+",location=no,toolbar=no,status=no,menubar=no,resizable=no,copyhistory=no,scrollbars=yes";
	 var child = window.open(url, instanceId, settings);
	 child.focus();
}

/**
* description: 弹出业务服务信息页面
* module: 业务服务定义
* param String url
*/
function openBizDetailPage(url,bizId){	
	 
	 if(!idUtil){
		idUtil = new IDToOpenWinName();
	 }
	 var name = "name" + idUtil.getShortId(bizId);
	 var height = screen.availHeight;
	 var width = screen.availWidth;
	
	 var widSize = screen.width;
	 var settings = "Height="+height+",Width="+width+",location=no,toolbar=no,status=no,menubar=no,resizable=no,copyhistory=no,scrollbars=no";
	 var child = window.open(url, name, settings);
	 child.focus();
}

var idUtil;
/**
* description: 将id作为弹出窗口名称时  id不能太长，这个对象主要是将长id转化为唯一的短id.
* module: 业务服务定义
*
*/
function IDToOpenWinName(){
		var idMap = {};
		this.getShortId = function(longId){
			var count = 0;
			var isFound = false;
			for(var tempId in idMap)
			{
				count++;
				if(isFound){
					continue;
				}
				if(longId == tempId){
					isFound = true;
				}
			}

			if(isFound){
				return idMap[longId];
			}
			idMap[longId] = ++count;
			return count+""
		}
	}

function fl_showLoading(){
	//显示加载状态条
		$.blockUI({message:$('#loading')});
}
function fl_disLoading(){
		$.unblockUI();// 屏蔽loading
}

//wangzhenyu 业务定义 拓扑图 资源加入监控
function doMoniter(instanceId){
	if(confirm("是否加入监控？")){
		var url = "${ctx}/bsmresource/"+instanceId;
		$.ajax({
			type: 'PUT',
			url: url,
			error: function (request) {
				alert("可能存在超时等异常。");
			},
			success: function(msg){
				alert("加入监控");
			}
		});
	}
}

//wangzhenyu 业务定义 拓扑图 资源取消监控
function doMoniter(instanceId){
	if(confirm("是否取消监控？")){
		var url = "${ctx}/bsmresource/"+instanceId;
		$.ajax({
			type: 'DELETE',
			url: url,
			error: function (request) {
				alert("可能存在超时等异常。");
			},
			success: function(msg){
				alert("取消监控");
			}
		});
	}
}

//wangzhenyu 业务定义 拓扑图 资源加入监控
function doMoniter(instanceId){
	if(confirm("是否加入监控？")){
		var url = "/bizsmweb/bsmresource/"+instanceId;
		$.ajax({
			type: 'PUT',
			url: url,
			error: function (request) {
				alert("可能存在超时等异常。");
			},
			success: function(msg){
				refreshInsanceMonitorState(instanceId,true);
				alert("操作成功");
			}
		});
	}
}

//wangzhenyu 业务定义 拓扑图 资源取消监控
function cancelMoniter(instanceId){
	if(confirm("是否取消监控？")){
		var url = "/bizsmweb/bsmresource/"+instanceId;
		$.ajax({
			type: 'DELETE',
			url: url,
			error: function (request) {
				alert("可能存在超时等异常。");
			},
			success: function(msg){
				refreshInsanceMonitorState(instanceId,false);
				alert("操作成功");
			}
		});
	}
}
