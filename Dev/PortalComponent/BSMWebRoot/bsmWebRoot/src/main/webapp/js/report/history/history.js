/** 视图 **/
var setCurrentNode;
var historyContentActionUrl = path + "/report/history/historyContentAction";
var historyActionUrl = path + "/report/history/historyAction";
var treeActionUrl = path + "/report/history/leftTree";
var $history, $content;

// 显示模态对话框
function showModalWin(sUrl, vArguments, sFeatures){
	return window.showModalDialog(sUrl, vArguments, sFeatures?sFeatures:"dialogHeight=420px;dialogWidth=700px;help=no;status=no;scroll=no;center=yes");
} 

// 得到树结点ID 
function getScriptRepositorysId(html){
	var $ls = $(html).attr("nodeid");
	return $ls.length>0 ? $ls : null; 
}

//得到第一个树结点ID 
function getFirstId(){
	var $ls = $("ul[class='treeview']").find("li[nodeid]");
	return $ls.length>0 ? $ls.get(0).nodeid : null;
}

//加载详细页面
function loadContent(nodeId){
	$content = $("#content");
	if(nodeId){
		$.loadPage("content", historyContentActionUrl +"!displayContent.action", "POST", "analysisView.id=" + nodeId, function(){
			if(setCurrentNode){
				setCurrentNode(nodeId);
			}
			contentInit();
			contentDataInit();
		});
//		$.ajax({
//			url:		historyContentActionUrl +"!displayContent.action",
//			data:		"analysisView.id=" + nodeId,
//			dataType:	"html",
//			cache:		false,
//			success:	function(data, textStatus){
//				$content.find("*").unbind();
//				$content.html(data);
//				if(setCurrentNode){
//					setCurrentNode(nodeId);
//				}
//				contentInit();
//			}
//		});
	}
}

function contentInit(){
	$("#search").click(function(){
		var radioVal;
		$("input[name='time']").each(function(i){
			if($(this).attr("checked")==true){
				radioVal = $(this).val();
			}
		});
		if(radioVal=="0"){
			alertTime($("[name='segTime']").val(),$("#startTimeTxt"),$("#endTimeTxt"));
		}else{
			$("#startTimeTxt").html($("input[name='startTime']").val());
			$("#endTimeTxt").html($("input[name='endTime']").val());
		}
		//$("#contentFlash").attr("src",path+"/report/history/historyContentAction!displayFlash.action?"+$("#addForm").serialize());
		$.loadPage("dataTable", path+"/report/history/historyContentAction!displayDatas.action", "POST", $("#addForm").serialize(), function(){
			contentDataInit();
		});
	});
	
	//时间组件
	$("input[name='startTime']").click(function(){
		WdatePicker({startDate:getDate(),dateFmt:'yyyy/MM/dd HH:mm:ss'});
	});
	$("input[name='endTime']").click(function(){
		WdatePicker({startDate:getDate(),dateFmt:'yyyy/MM/dd HH:mm:ss'});
	});
}

function contentDataInit(){
	if(returnType == "Malfunction"){
		$("#dataTable1").hide();
		$("#dataTable2").show();
		
		if (islink=="1")
		{
			$("#dataTable2title1").text("源IP-源接口");
			$("#dataTable2title2").text("目的IP-目的接口");
		}
	}else{
		$("#dataTable1").show();
		$("#dataTable2").hide();
		if (islink=="1")
		{
			$("#dataTable1title1").text("源IP-源接口");
			$("#dataTable1title2").text("目的IP-目的接口");
		}
	}
	if(anyChartStr != ""){
		$("#title").text(getSelectedText($("#metricId")));
		$("#tableTitle1").text(getSelectedText($("#metricId")));
		$("#tableTitle2").text(getSelectedText($("#metricId")));
		
			$("#tableTitle1danwei").text("("+util+")");
			$("#tableTitle2danwei").text("("+util+")");
			$("#danwei1").text("("+util+")");
		//$("#tableTitle2").text(getSelectedText($("#metricId")));
		
		$("table tr td span.ico-t-right").click(function(event){
			var flagValue=$("input[name='time']:checked").val();
			var timeName="";
			if(flagValue=="0"){
				timeName=$("#selectSegTime option:selected").text();
			}else{
				timeName=$("#historyStartTime").val()+" ~ "+$("#historyEndTime").val();
			}
			var param = $(this).attr("instance");
			var param1 = $(this).attr("metricId");
			var startTime = $(this).attr("startTimeLong");
			var endTime = $(this).attr("endTimeLong");
			var title = $("#title").text();
			var operateMenu = new MenuContext({x : 0,y : 0,width:120});
			var metricId = $("#metricId").val();
			var menuArray;
			var url = "/netfocus/modules/link/linkdetail2.jsp?instanceid=" + param;
			if(isHaveRealtimeAnalysis){
				menuArray = [[{
				       text: "详细信息",
				       id: "info",
				       listeners: {
				    	   click:function(){
				    	   	if (islink=="1")
				    	   	{
           						 window.open(url,'linkdetail2','height=580,width=1000,scrollbars=yes');
				    	   	}
				    	   	else
				    	   	{
				    	   		window.open(path+"/detail/resourcedetail.action?instanceId="+param,'详细信息画面', 'height=730,width=1200,top=10,left=10,toolbar=no,menubar=no,scrollbars=yes, resizable=yes,location=no, status=no,resizable=no');
				    	   	}
				    		   
				    	   }
				       }
				},{
				       text: "实时监控",
				       id: "monitor",
				       listeners: {
				    	   click:function(){				    		  
				    		   window.open(path+"/report/history/historyOperateAction!getmonitorFlash.action?instanceId="+param+"&metricId="+metricId+"&title="+title+""+"&unit="+util,'实时监控', 'height=395,width=630,top=10,left=10,toolbar=no,menubar=no,scrollbars=yes, resizable=yes,location=no, status=no,resizable=no');
				    	   }
				       }
				},{
				       text: "相关事件",
				       id: "event",
				       listeners: {
				    	   click:function(){
				    		   //alert("instanceId="+param+" &metricId="+param1+" &startTime="+startTime+" &endTime="+endTime);
				    		   window.open(path+"/report/history/historyOperateAction!getHistoryEvent.action?instanceId="+param+"&metricId="+param1+"&startTime="+startTime+"&endTime="+endTime+"&timeName="+timeName+"&title="+title,'相关事件', 'height=385,width=730,top=10,left=10,toolbar=no,menubar=no,scrollbars=yes, resizable=yes,location=no, status=no,resizable=no');
				    	   }
				       }
				}]];
			}else{
				menuArray = [[{
				       text: "详细信息",
				       id: "info",
				       listeners: {
				    	   click:function(){
				    	   	if (islink=="1")
				    	   	{
           						 window.open(url,'linkdetail2','height=580,width=1000,scrollbars=yes');
				    	   	}
				    	   	else
				    	   	{
				    	   		window.open(path+"/detail/resourcedetail.action?instanceId="+param,'详细信息画面', 'height=730,width=1200,top=10,left=10,toolbar=no,menubar=no,scrollbars=yes, resizable=yes,location=no, status=no,resizable=no');
				    	   	}
				    	   }
				       }
				},{
				       text: "相关事件",
				       id: "event",
				       listeners: {
				    	   click:function(){
				    		   window.open(path+"/report/history/historyOperateAction!getHistoryEvent.action?instanceId="+param+"&metricId="+param1+"&startTime="+startTime+"&endTime="+endTime+"&timeName="+timeName+"&title="+title,'相关事件', 'height=385,width=730,top=10,left=10,toolbar=no,menubar=no,scrollbars=yes, resizable=yes,location=no, status=no,resizable=no');
				    	   }
				       }
				}]];
			
			}
			operateMenu.position(event.pageX, event.pageY);
			operateMenu.addMenuItems(menuArray);
			
		});
	}
	else
	{
		if (jQuery("#metricId").length>0)
		{
			$("#title").text(getSelectedText($("#metricId")));
			$("#tableTitle1").text(getSelectedText($("#metricId")));
			$("#tableTitle2").text(getSelectedText($("#metricId")));
			
			$("#tableTitle1danwei").text(util);
			$("#tableTitle2danwei").text(util);
			$("#danwei1").text(util);
		}
		
	}
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

//加载历史分析左侧树
function loadHistory(nodeid,analysisType){
	if(!$history) $history = $("#"+analysisType+"Div");
	$.ajax({
		url:		treeActionUrl+"!getTreeByType.action",
		data:		"analysisType=" + analysisType,
		dataType:	"html",
		cache:		false,
		success:	function(data, textStatus){
			$history.find("*").unbind();
			$history.html(data);
		}
	});
}

//定制视图
//viewType:视图类型(TOP10分析、故障分析、对比分析、趋势分析)
function bindView(viewType){
//	var conf = {
//		name:"historyview",
//		resizeable:true,
//		scrollable:false,
//		height:420,
//		width:700,
//		url : historyActionUrl + "!bindView.action?analysisView.type="+viewType
//	};
//	winOpen(conf);
	//Tools.prototype.openWin(historyActionUrl + "!bindView.action?analysisView.type=" + viewType, 'historyviewnew', 700, 420, true);
 	var returnVal = showModalWin(historyActionUrl + "!bindView.action?analysisView.type="+viewType);
	if(returnVal != null){
		$.loadPage(returnVal+"Div", path+"/report/history/leftTree!getTreeByType.action", "POST", "analysisType="+returnVal, function(){
			initTree();
			setFirstNode();
		});
	}
}

//编辑视图
function editView(viewId){
	//Tools.prototype.openWin(historyActionUrl + "!bindView.action?analysisView.id=" + viewId, 'historyviewedit', 700, 420, true);
 	var returnVal = showModalWin(historyActionUrl + "!bindView.action?analysisView.id=" + viewId);
	if(returnVal != null){
		$.loadPage(returnVal+"Div", path+"/report/history/leftTree!getTreeByType.action", "POST", "analysisType="+returnVal, function(){
			initTree();
			setFirstNode();
		});
	}
}

//删除视图
function delView(viewId,viewType){
	var _confirm = new confirm_box({text:"此操作不可恢复，确定要删除吗？"});
	_confirm.setConfirm_listener(function(){
		$.ajax({
			url:		historyActionUrl + "!delView.action",
			data:		"analysisView.id=" + viewId,
			dataType:	"html",
			cache:		false,
			success:	function(data, textStatus){
				
			$.loadPage(viewType+"Div", path+"/report/history/leftTree!getTreeByType.action", "POST", "analysisType="+viewType, function(){
				initTree();
				setFirstNode();
				});
			}
		});
		_confirm.hide();
	});
	_confirm.show();
}

//添加视图
//$close：是否关闭
function addView(url,$close){
	$.ajax({
		type : "POST",
		url:		url,
		dataType:	"json",
		data:		$("#addForm").serialize(),
		cache:		false,
		dataFilter: function(data, type){
			var json = eval("("+data+")");
			window.returnValue=json[0]["viewType"];
			if($close){
				self.close();
			}
		}
	});
}


//得到时间文本显示
function alertTime(segTime,$startTxt,$endTxt){
	$.ajax({
		type:		"POST",
		url	:		historyContentActionUrl + "!getTimeInfo.action?segTime="+segTime,
		dataType:	"json",
		cache:		false,
		dataFilter:	function(data,type){
			var dataObj = $.parseJSON(data);
			var json = eval("("+data+")");
			$startTxt.html("");$endTxt.html("");
			$startTxt.html(dataObj.startTime);
			$endTxt.html(dataObj.endTime);
		}
	});
}

function change(url,data,divId){
	 $.ajax({
		   type: "POST",
		   url:path+url,
		   dataType:'html',
		   data:data,
		   success: function(data, textStatus){
		    $(divId).html("");
		    $(divId).html(data);
	   }
	});
}

function getSelectedText($html){
	var $index = $html.get(0).selectedIndex;
	var $text = $html.get(0).options[$index].text;
	return $text;
}

/**
 *  例：
var map = new Map();    
map.put("re","redhacker");    
map.put("re","douguoqiang");    
map.put("gq","dougq");    
alert("map的大小为：" + map.size())    
alert("key为re的map中存储的对象为：" + map.get("re"));    
map.remove("re");    
alert("移除key为re的对象后，获取key为re的map中存储的对象为：" + map.get("re"));    
alert("map移除一个元素后的大小为：" + map.size());    
alert("map是否是一个空map:" + map.isEmpty());   
 */
function Map() {
	var struct = function(key, value) {
		this.key = key;
		this.value = value;
	}

	var put = function(key, value) {
		for (var i = 0; i < this.arr.length; i++) {
			if (this.arr[i].key === key) {
				this.arr[i].value = value;
				return;
			}
		}
		this.arr[this.arr.length] = new struct(key, value);
	}

	var get = function(key) {
		for (var i = 0; i < this.arr.length; i++) {
			if (this.arr[i].key === key) {
				return this.arr[i].value;
			}
		}
		return null;
	}

	var remove = function(key) {
		var v;
		for (var i = 0; i < this.arr.length; i++) {
			v = this.arr.pop();
			if (v.key === key) {
				continue;
			}
			this.arr.unshift(v);
		}
	}

	var size = function() {
		return this.arr.length;
	}

	var isEmpty = function() {
		return this.arr.length <= 0;
	}

	this.arr = new Array();
	this.get = get;
	this.put = put;
	this.remove = remove;
	this.size = size;
	this.isEmpty = isEmpty;
}    
