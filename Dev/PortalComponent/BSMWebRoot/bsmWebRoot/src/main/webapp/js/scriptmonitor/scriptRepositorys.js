var path = document.location.pathname.substring(0,document.location.pathname.indexOf("/",1));
var repositoryActionUrl = path + "/scriptmonitor/repository/scriptRepository";
var scriptActionUrl = path + "/scriptmonitor/repository/scriptTemplate";
var scriptPropfileUrl = path + "/scriptmonitor/repository/scriptPropfile";
var $scriptRepostiory, $content;
var setCurrentNode,currentNodeId;
var toast;

// 显示模态对话框
function showModalWin(sUrl, vArguments, sFeatures){
	/*var requestUrl = sUrl.indexOf("/")==0?sUrl.substr(1):sUrl;
	// IE 浏览器请求的应用名前面必须以“/”开头，火狐浏览器请求的应用名前面不能以“/”开头
	var modalUrl = navigator.appName.indexOf("Microsoft")!=-1 ? "/"+requestUrl : requestUrl;*/
	var width  = window.screen.width/5;
	var height = window.screen.height/5;
	return window.showModalDialog(sUrl.indexOf("/")==0?sUrl:"/"+sUrl,window,sFeatures?sFeatures:"help=no;status=no;scroll=no;dialogLeft="+width+";dialogTop="+height);
}
// 得到脚本库ID 
function getScriptRepositorysId(html){
	var $ls = $(html).attr("nodeid");
	return $ls.length>0 ? $ls : null; 
}
//得到第一个脚本库结点id
function getFirstId(treeId){
	var $ls = $("ul[id='"+treeId+"'] li[nodeid]");
	return $ls.length>1 ? $ls.get(1).nodeid : null;
}
//加载脚本库集合页面  
function loadScriptRepostiorys(nodeId,callback){
	if(!$scriptRepostiory) $scriptRepostiory = $("#scriptRepository");
	$.ajax({
		url:		repositoryActionUrl + "!scriptRepostiorys.action",
		data:		"nodeId=" +(nodeId? nodeId:""),
		dataType:	"html",
		cache:		false,
		success:	function(data, textStatus){
			$scriptRepostiory.find("*").unbind();
			$scriptRepostiory.html(data);

			currentNodeId = nodeId;
			if(setCurrentNode){
				setCurrentNode(nodeId);
			}
		}
	});
}

function clearContent(){
	if(!$content) $content = $("#content");
	$content.find("*").unbind();
	$content.html("");
}

//加载脚本库详细页面
function loadContent(nodeId,searchName,groupId,page,sortColumn,sortDirect,panel,pageObj){	
	$.blockUI({message:$('#loading')});
	if(!$content) $content = $("#content");
	var dataValue="nodeId="+nodeId;
	if(searchName){
		dataValue += "&serchMonitor="+searchName;
	}
	if(groupId){
		dataValue +="&scriptTemplate.groupId="+groupId;
	}
	if(page){
		dataValue +="&page="+page;
	}
	if(sortColumn){
		dataValue +="&sortColumnId="+sortColumn;
	}
	if(sortDirect){
		dataValue +="&order="+sortDirect;
	}
	
	if(nodeId){
		if(panel){
			$.ajax({
				url:		scriptActionUrl +"!showScriptTemplatesOnly.action",
				data:		dataValue,
				dataType:	"json",
				cache:		false,
				success:	function(data, textStatus){
					panel.loadGridData(data.scriptsJSON);
					var pageCount = data.pageCount;
					var pageNumber = data.page;
					pageObj.pageing(pageCount,pageNumber);
					$("#checkAllId").removeAttr("checked");
					//bundleTemplateNameEdit();				
					$.unblockUI();
				}
			});
		}else{
			$.ajax({
			url:		scriptActionUrl +"!showScriptTemplates.action",
			data:		dataValue,
			dataType:	"html",
			cache:		false,
			success:	function(data, textStatus){
				$content.find("*").unbind();
				$content.html(data);
				
				currentNodeId = nodeId;
				$.unblockUI();
				if(setCurrentNode){
					setCurrentNode(nodeId);
				}
			}
		});
		}
	}
}

//创建脚本库
function addScriptRepostiory(){
	var r_value = showModalWin(repositoryActionUrl + "!addScriptRepostiory.action");
	if(r_value){
		loadScriptRepostiorys();
	}
}
//修改脚本库
function editScriptRepostiory(scriptRepostioryId){
	var r_value = showModalWin(repositoryActionUrl + "!editScriptRepostiory.action?scriptRepository.id=" + scriptRepostioryId);
	if(r_value){
		loadScriptRepostiorys(scriptRepostioryId);
	}
}
// 删除脚本库
function delScriptRepostiory(scriptRepostioryId){
	var _confirm = new confirm_box({text:"此操作不可恢复，是否确认删除脚本库及其下面所有脚本？"});
	_confirm.setConfirm_listener(function(){
		$.ajax({
			url:		repositoryActionUrl + "!delScriptRepostiory.action",
			data:		"scriptRepository.id=" + scriptRepostioryId,
			dataType:	"html",
			cache:		false,
			success:	function(data, textStatus){
				loadScriptRepostiorys();
			}
		});
		_confirm.hide();
	});
	_confirm.show();
}

//创建脚本分类
function addScriptGroup(scriptRepostioryId,openerObj){
	var r_value = showModalWin(repositoryActionUrl + "!addScriptGroup.action?scriptRepository.id=" + scriptRepostioryId);
	if(r_value){
		if(openerObj) {//脚本添加页面
			openerObj.loadScriptRepostiorys(scriptRepostioryId);//更新父页面的脚本库树
			return r_value;
		}else{
			loadScriptRepostiorys(scriptRepostioryId);
		}
	}
}

//删除脚本分类
function delScriptGroup(nodeId,groupId){
	var _confirm = new confirm_box({text:"此操作不可恢复，是否确认删除该分类及其下面所有脚本？"});
	_confirm.setConfirm_listener(function(){
		$.ajax({
			url:		repositoryActionUrl + "!delScriptGroup.action",
			data:		"scriptGroup.id=" + groupId,
			dataType:	"html",
			cache:		false,
			success:	function(data, textStatus){
				loadScriptRepostiorys(nodeId);
			}
		});
		_confirm.hide();
	});
	_confirm.show();
}
//编辑脚本分类
function editScriptGroup(nodeId,groupId){
	var r_value = showModalWin(repositoryActionUrl + "!editScriptGroup.action?scriptGroup.id=" + groupId);
	if(r_value){
		loadScriptRepostiorys(nodeId);
	}
}
//创建脚本
function addScriptTemplate(repositoryId){
	var r_value = showModalWin(scriptActionUrl + "!addScriptTemplate.action?nodeId=" + currentNodeId+"&scriptTemplate.repositoryId="+repositoryId);
	if(r_value){
		loadContent(currentNodeId);
	}
}
//编辑脚本
function editScriptTemplate(scriptTemplateId){ 
	var r_value = showModalWin(scriptActionUrl + "!editScriptTemplate.action?nodeId=" + currentNodeId+"&scriptTemplate.id=" + scriptTemplateId);
	if(r_value){
		loadContent(currentNodeId);
	}
}
//删除脚本
function delScriptTemplate(scriptTemplateIds){
	if(scriptTemplateIds != ""){
		var _confirm = new confirm_box({text:"你确定要删除吗？"});
		_confirm.setConfirm_listener(function(){
			$.ajax({
				url:		scriptActionUrl + "!delScriptTemplate.action",
				data:		scriptTemplateIds,
				dataType:	"json",
				cache:		false,
				success:	function(data, textStatus){
					if(data.errorMsg){
						if(!toast){
							toast = new Toast({position:"CT"}); 
						}
						toast.addMessage("删除失败。原因："+data.errorMsg);
						setTimeout(function(){},500);
					}
					loadContent(currentNodeId);
				}
			});
			_confirm.hide();
		});
		_confirm.show();
	}else{
		var _information = new information({text:"请选择一条数据"});
		_information.show();
	}
}
//脚本测试
function inputScriptParamter(scriptTemplateId,param){
	return showModalWin(scriptActionUrl + "!inputScriptParamter.action?"+(scriptTemplateId?"scriptTemplate.id="+scriptTemplateId:param));
}

//脚本监控工厂方法
function scriptMonitorFactory(actionType,profileIds){
	if(arguments.length != 2){
		profileIds = $("input[name=\"profileIds\"]:checked").serialize();
	}
	var pageNumber=$("#pageIdHidden").val();
	var sortType=$("#sortIdHidden").val();
    var sortCol=$("#sortColIdHidden").val();
	if(profileIds!=""){
			$.ajax({
				url: scriptPropfileUrl + actionType,
				data: "profileIds="+ profileIds +"&profileList.pageNumber="+ pageNumber +"&profileList.sortType="+ sortType +"&profileList.sortColName="+ sortCol,
				dataType: 'json',
				cache: false,
				success: function(data){
					var responseInfo = data.responseInfo;
        			scriptTemplateIds.loadGridData(responseInfo);
					var pageCount = data.profileList.pageCount;
					var pageNumber = data.profileList.pageNumber;
					page.pageing(pageCount,pageNumber);
					$("#activedCount").html(data.profileList.activedCount);
					$("#checkAllId").removeAttr("checked");
				}
			});
	}else{
		var _information = new information({text:"请选择一条数据"});
		_information.show();
	}
}