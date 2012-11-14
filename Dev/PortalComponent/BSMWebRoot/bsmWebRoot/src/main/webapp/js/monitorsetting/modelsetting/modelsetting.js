
/*
 * 打开窗口方法
 * 	url		:	路径
 * 	winName :	窗口名称
 *  pageId	:	提交后刷新的区域
 **/
function openWinFun(url,winName){
	var winOpenObj = {};
	winOpenObj.url= url;
	winOpenObj.name=winName;
	winOpenObj.width = '600';
	winOpenObj.height = '350';
	winOpenObj.scrollable = false;
	winOpenObj.resizeable = false;
	var returnVal = modalinOpen(winOpenObj);
	if(returnVal=="success"){
		loadTable();
	}
	return returnVal;
}

//刷新表数据
function loadTable(){
	$.blockUI({message:$('#loading')});
	$.ajax({
		url:ctx+"/monitorsetting/model/sysoidSetting!findSysOidsByConfidtionJson.action",
		data:$("#searchCondition").serialize(),
		dataType:"json",
		type:"POST",
		success:function(data,state){
			page.pageing(data.pageCount,data.pageNum);
			myGP.loadGridData(data.dispalyJsonDatas);
			$.unblockUI();
		}
	});
}

//全选
function setAllSelectFun(allCheckBoxId,checkBoxName){
	var $allCheckBox = $("#"+allCheckBoxId);
	var $checkBox = $("input[checkBoxName="+checkBoxName+"]");
	$allCheckBox.bind("click",function(){
		$checkBox.each(function(i){
			$(this).attr("checked",$allCheckBox.attr("checked"));
		});
	});
}
function alertAllCheckBoxFun(allCheckBoxId,checkBoxName){
	var $allCheckBox = $("#"+allCheckBoxId);
	var $checkBox = $("input[checkBoxName="+checkBoxName+"]");
	$checkBox.each(function(i){
		$(this).bind("click",function(){
			$allCheckBox.attr("checked",true);
			$checkBox.each(function(i){
				if(!$(this).attr("checked")){
					$allCheckBox.attr("checked",false);
				}
			});
		});
	})
}

function doInformatAlter(){
	var _information = new information({text:"请选择一条数据。"});
	_information.show();
}
