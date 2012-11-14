
/**选择资源下拉框**/
function initResSelect($html){
	$html.html("");
	$html.append("<option value='host'>主机</option>");
	$html.append("<option value='server'>|-服务器</option>");
	$html.append("<option value='pc'>|-PC</option>");
	$html.append("<option value='networkdevice'>网络设备</option>");
	$html.append("<option value='router'>|-路由器</option>");
	$html.append("<option value='switch'>|-二层交换机</option>");
	$html.append("<option value='routerswitch'>|-三层交换机</option>");
	$html.append("<option value='firewall'>|-防火墙</option>");
	$html.append("<option value='wirelessap'>|-无线AP</option>");
	$html.append("<option value='loadbalance'>|-负载均衡</option>");
	$html.append("<option value='ids'>|-IDS</option>");
	$html.append("<option value='NetsSluice'>|-网闸</option>");
	$html.append("<option value='OtherNetworkdevice'>|-其他</option>");
	$html.append("<option value='storage'>存储设备</option>");
	$html.append("<option value='link'>链路</option>");
	$html.append("<option value='application'>应用</option>");
}
//function loadchildResSelect(resVal,$html){
//	$html.html("");
//	$html.append("<option value=''></option>");
//	if(resVal == "host" || resVal == "server"){
//		$html.append("<option value='FileSystem'>分区</option>");
//		$html.append("<option value='NetworkInterface'>网络接口</option>");
//	}else if(resVal == "networkdevice" || resVal == "wirelessap" 
//		|| resVal == "ids" || resVal == "NetsSluice" || resVal == "storage" || resVal == "pc"){
//		$html.append("<option value='NetworkInterface'>网络接口</option>");
//	}else if(resVal == "router" || resVal == "switch" 
//		|| resVal == "routerswitch" || resVal == "firewall" || resVal == "loadbalance"){
//		$html.append("<option value='CPU'>CPU</option>");
//		$html.append("<option value='NetworkInterface'>网络接口</option>");
//	}
//}
function loadSelect(val,$html){
	//$html.html("");
	//$html.append("<option value='"+val+"'>全部</option>");
	
	var viewtype=$("#analysisView_type").val();
	$.ajax({
		type: 	"POST",
		url:	path + "/report/history/historyAction!loadResSelect.action?resType="+val+"&analysisView.type=" + viewtype,
		dataType:	"json",
		cache:		false,
		dataFilter: function(data, type){
			$html.parent().html(data);
			$("#resSecondSelect").bind("change",function(){
				changeSelect();
			});
			changeSelect();
			//var json = eval("("+data+")");
			//for(var i=0;i<json.length;i++){
			//	for(var key in json[i]){
//					$html.append("<option value='"+key+"'>"+json[i][key]+"</option>");
//				}
//			}
		}
	});
}
function getResourceCategoryTopId(val){
	$.ajax({
		type: 	"POST",
		url:	path + "/report/history/historyAction!getTopId.action?resourceCategoryId="+val,
		dataType:	"json",
		cache:		false,
		dataFilter: function(data, type){
			if (data!="")
			{
				//alert("rerutndata="+data)
				//alert("resourceCategoryTopId="+$("#resourceCategoryTopId").val())
				if (data!=$("#resourceCategoryTopId").val())
				{
				 var array = map.arr;
				 var ids ="";
				 for(var i=0;i<array.length;i++){
				 	ids=ids+array[i].key+",";
				  }
					if (ids!="")
					{
						_confirm1.setConfirm_listener(function(){
						var idaa=ids.split(",");
				 		for(var k=0;k<idaa.length;k++){
				 		map.remove(idaa[k]);
				   		}
				   		_confirm1.hide();
				   		loadchildResSelect($("#resSelect").val(),$("#childResSelect"))
						loadSelect($("#resSelect").val(),$("#resSecondSelect"));
						
					});
						_confirm1.setCancle_listener(function(){
					    	$("#resSelect").val($("#resourceCategoryTopId").val());
					   		_confirm1.hide();
					 	});
					_confirm1.show();
					}
					else
					{
						//if (!loadchildResSelect($("#resSelect").val(),$("#childResSelect")))
						//{   
							loadchildResSelect($("#resSelect").val(),$("#childResSelect"))
							loadSelect($("#resSelect").val(),$("#resSecondSelect"));
						//}
					}
					$("input[name=resourceCategoryTopId]").val(data);
				}
				else
				{
					loadchildResSelect($("#resSelect").val(),$("#childResSelect"))
					loadSelect($("#resSelect").val(),$("#resSecondSelect"));
				}
			}
		}
	});
}
function loadchildResSelect(val,$html){
	$.ajax({
		type: 	"POST",
		url:	path + "/report/history/historyAction!loadchildResSelect.action?resType="+val,
		dataType:	"json",
		cache:		false,
		dataFilter: function(data, type){
			if (data!="")
			{
				if (data=="0")
				{
					$html.parent().parent().hide();
					$html.parent().attr("disabled","disabled");
					}
				else
				{
					$html.parent().parent().show();
					$html.parent().attr("disabled","");
					}
			}
			$("#childResSelect").bind("change",function(){
				setSelectReset();
			});
		}
	});
}
function loadComSelect(val,$html){
	$html.html("");
	$html.append("<option value=''></option>");
	$.ajax({
		type: 	"POST",
		url:	path + "/report/history/historyAction!loadComSelect.action?resType="+val,
		dataType:	"json",
		cache:		false,
		dataFilter: function(data, type){
			var json = eval("("+data+")");
			for(var i=0;i<json.length;i++){
				for(var key in json[i]){
					$html.append("<option value='"+key+"'>"+json[i][key]+"</option>");
				}
			}
		}
	});
}
//判断视图是否重名
function isSameName()
{
	var viewtype=$("#analysisView_type").val();
	var viewname=$("#analysisViewName").val();
	var viewid=$("#analysisView_id").val();
	$.ajax({
		type: 	"POST",
		url:	path + "/report/history/historyAction!isSameName.action?analysisView.type="+viewtype+"&analysisView.name="+viewname+"&analysisView.id="+viewid,
		dataType:	"json",
		cache:		false,
		dataFilter: function(data, type){
			if (data!="" && data=="true")
			{
				addView(path+"/report/history/historyAction!addResView.action",true);
			}
			else
			{
				toast.addMessage("视图重名,请重新命名!");
				return false;
			}
		}
	});
}
/**选择资源左移右移**/
var $rightButton = $("#button-turn-right");
var $leftButton = $("#button-turn-left");
var unselectTree = new Tree({id:"unselectResTree"});
var selectedTree = new Tree({id:"selectedResTree"});
var ids = [];
$rightButton.click(function(){
	moveNodes(unselectTree,selectedTree);
});
$leftButton.click(function(){
	moveNodes(selectedTree,unselectTree);
});
function moveNodes(fromTree,toTree){
	 var rootNode = fromTree.getNodeById('selectAll');
	 var nodes = rootNode.getCheckedNodes(true);
	 $.each(nodes,function(i,e){
	   var toTreeHead = toTree.getNodeById('selectAll');
	   var ids = e.getPathId();
	   $.each(ids,function(count){
		   var node = toTree.getNodeById(ids[count]);
		   if(node.getId()){
		   }else{
			   var parentNode = toTree.getNodeById(ids[count-1]);
			   parentNode.appendChild({
				    nodeId:ids[count],
				    text:fromTree.getNodeById(ids[count]).getText(),
				    isCheckBox:true,
				    isClick:false,
				    isLeaf:true
			   });
		   }
	   });
	   e.delNode();
	 });
	 rootNode.clearChecked();
	};

function getResIds(){
	var ids = [];
	var array = map.arr;
	for(var i=0;i<array.length;i++){
		ids.push(array[i].key);
	}
	return ids;
}
var objValue={};
objValue.isNotEmpty=function(val){
	var result=true;
	if(val==undefined||val==null||val=="null"||val==""){
		result=false;		
	}
	return result;
}
/**选择组件**/
var unselectChildResTree = new Tree({id:"unselectChildResTree"});
unselectChildResTree.getNodeById('selectAll')._get$Childs().find("input[type='checkbox']").bind("click",function(){
});
