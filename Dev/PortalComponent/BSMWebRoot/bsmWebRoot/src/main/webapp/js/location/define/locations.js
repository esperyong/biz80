var ctx = document.location.pathname.substring(0,document.location.pathname.indexOf("/",1));
var locationId, $locations, $handles, $content=null, $locationsState, $relationContent;
var setCurrentNode;
var specialStrArry = [ "&", ">", "<", "\"", "'" ];
var replaceStrArry = [ "&amp;", "&gt;", "&lt;", "&quot;","&apos;" ];
//对xml中的特殊字符进行转义
function replaceXmlSpecialStr(value){
 if(value){
 	for(var i=0;i<specialStrArry.lengh;){
 		if(value.indexOf(specialStrArry[i])){
 		value=value.replace(specialStrArry[i],replaceStrArry[i]);
 		i=i+1;
 		}
 	}
 }
 return  value;
}


// 显示模态对话框
function showModalWin(sUrl, vArguments, sFeatures){
	return window.showModalDialog(sUrl, vArguments, sFeatures?sFeatures:"help=no;status=no;scroll=no;center=yes")
}
// 创建域
function createDomain(){
	//blockShow();
	var r_value = showModalWin(ctx + "/location/define/location!createDomain.action");
	if(r_value){
		loadLocationNewDomain(loadHandles,r_value);
	}
	//blockHide();
}
// 创建物理位置
function createLocation(locationId){
	
	var r_value = showModalWin(ctx + "/location/define/location!createLocation.action?location.parentId=" + locationId);
	if(r_value){
		loadLocations(loadHandles);
	}
}
//修改物理位置
function updateLocation(locationId){
	
	var r_value = showModalWin(ctx + "/location/define/location!updateLocation.action?location.locationId=" + locationId);
	if(r_value){
		loadLocationNewDomain(loadHandles,locationId);
	}
}
//物理位置导入
function importNoteMap(locationId){
	
	var r_value = showModalWin(ctx + "/location/design/locationExport!toNoteImports.action?locationId=" + locationId);
	if(r_value){
		loadLocationNewDomain(loadHandles,r_value);
	}
}
// 删除物理位置
function delLocation(locationId){
	
	if(window.confirm("执行将删除区域及其子区域。")){
		$.ajax({
			url:		ctx + "/location/define/location!delteLocation.action",
			data:		"location.locationId=" + locationId,
			dataType:	"html",
			cache:		false,
			success:	function(data, textStatus){
				loadLocations(loadHandles);
			}
		});
	}
}
// 得到第一个物理位置ID
function getFirstLocationId(html){
	//var $ls = $(html).find("li[nodeid][class]");
	var $ls = $(html).find("ul[class='treeview'] li");
	return $ls.length>0 ? $ls.get(0).nodeid : null;
}
//加载物理位置定义页面
function loadLocations(callback){
	//var contentfrm = window.frames['locationsState'];
	if(!$locations) $locations = $("#locations");
	$.ajax({
		url:		ctx + "/location/define/location!showLocations.action",
		dataType:	"html",
		cache:		false,
		success:	function(data, textStatus){
			$locations.find("*").unbind();
			$locations.html(data);
			locationId=getFirstLocationId(data);
			// 设置默认选中项
			//if(contentfrm.setCurrentNode){
			//	contentfrm.setCurrentNode(locationId);
			//}
			if(typeof callback == "function"){
				callback();
			}
		}
	});
}
//加载物理位置定义页面
function loadLocationNewDomain(callback,id){
	//var contentfrm = window.frames['locationsState'];
	if(!$locations) $locations = $("#locations");
	$.ajax({
		url:		ctx + "/location/define/location!showLocations.action",
		dataType:	"html",
		cache:		false,
		success:	function(data, textStatus){
			$locations.find("*").unbind();
			$locations.html(data);
			if(id)
			locationId=id;
			// 设置默认选中项
			if(setCurrentNode){
				setCurrentNode(locationId);
			}
			if(typeof callback == "function"){
				callback();
			}
		}
	});
}
//加载物理位置导航页面
function loadHandles(id){
	
	locationId = id?id:locationId;
	if(!$handles) $handles = $("#handles");
		
	if(locationId){
		$.ajax({
			url:		ctx + "/location/define/location!showHandles.action",
			data:		"location.locationId=" + locationId,
			dataType:	"html",
			cache:		false,
			success:	function(data, textStatus){
				$handles.find("*").unbind();
				$handles.html(data);
			}
		});
	} else {
		$handles.find("*").unbind();
		$handles.html("<div  style='font-size:50px;font-weight:700;width:300px;height:300px; margin:230px auto;'>未创建区域</div>");
	}
}
//加载物理位置详细操作页面
function loadContent(loadUrl, param){

	$content = $("#content");
	$.ajax({
		url:		loadUrl,
		data:		"location.locationId=" + locationId + (param?"&"+param:""),
		dataType:	"html",
		cache:		false,
		success:	function(data, textStatus){
			$content.find("*").unbind();
			$content.html(data);
		}
	});
}

//加载物理位置状态一览页面
function loadState(callback){
	var contentfrm = window.frames['locationsState'];
	if(!$locationsState) $locationsState = $("#locationsState");
	$.ajax({
		url:		ctx + "/location/define/location!locationsState.action",
		data:   "location.locationId=" + locationId?locationId:"",
		dataType:	"html",
		cache:		false,
		success:	function(data, textStatus){
			$locationsState.find("*").unbind();
			$locationsState.html(data);
			
			if(!locationId){
				locationId=getFirstLocationId(data);
			}
			// 设置默认选中项
			if(contentfrm.setCurrentNode){
				contentfrm.setCurrentNode(locationId);
			}
			if(typeof callback == "function"){
				callback();
			}
		}
	});
}
//加载物理位置状态一览页面
function loadDomainState(callback,locationId){
	var contentfrm = window.frames['locationsState'];
	//if(!$locationsState) 解决首业portlet 点击无法出现状态树问题
	$locationsState = $("#locationsState");
	$.ajax({
		url:		ctx + "/location/define/location!locationsState.action",
		data:   "location.locationId=" + locationId,
		dataType:	"html",
		cache:		false,
		success:	function(data, textStatus){
			contentfrm.find("*").unbind();
			contentfrm.html(data);
			
			if(!locationId){
				locationId=getFirstLocationId(data);
			}
			// 设置默认选中项
			if(contentfrm.setCurrentNode){
				contentfrm.setCurrentNode(locationId);
			}
			if(typeof callback == "function"){
				callback();
			}
		}
	});
}
// 加载关联内容
function loadRelContent(){

	$relationContent=$("#relationContent");
	$.ajax({
		url:		ctx + "/location/define/location!getLocationById.action",
		data:		"location.locationId=" + locationId,
		dataType:	"json",
		cache:		false,
		success:	function(data, textStatus){
			// 有关联内容，打开关联面(去掉域类型过滤)
			//if(data.relationTypes.join(",").indexOf(data.location.type)!=-1){
			if(data.location!=null){
				$.ajax({
					url:		ctx + "/location/relation/device!relatContent.action",
					data:		"location.locationId="+locationId,
					dataType:	"html",
					cache:		false,
					success: function(data, textStatus){
						$relationContent.html("");
						$relationContent.find("*").unbind();
						$relationContent.html(data);
					}
				});
				
				$relationContent.parent("div").show();
			}else{
				$relationContent.parent("div").hide();
			}
			/*} else {
				$relationContent.parent("div").show();
				//$relationContent.parent("div").hide();
			}*/
		}
	});
}
	
