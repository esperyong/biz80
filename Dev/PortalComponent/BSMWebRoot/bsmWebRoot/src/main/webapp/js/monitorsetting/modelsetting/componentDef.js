/**
 * GridPanel
 * */
var widthVal = 770;
var widthJson = {idHidden:5,reource:18,sysoid:12,type:20,os:17,vender:10,model:18};
var sortCloumnsJson = [{index:"sysoid",defSorttype:"up"},{index:"reource"},{index:"os"}];
var myGP=null;

$(function(){
	myGP = new GridPanel({
		id:"modelSettingGrid",
		columnWidth:widthJson,
		unit:"%",
		plugins:[SortPluginIndex],
		sortColumns:sortCloumnsJson,
		sortLisntenr:function($sort){
			var $sortColId = $("input[name=sortColId]");
			var $sortType = $("input[name=sortColType]");
			$sortColId.val($sort.colId);
			$sortType.val($sort.sorttype);
			loadTable();
            
		}},
		{	gridpanel_DomStruFn:"index_gridpanel_DomStruFn",
			gridpanel_DomCtrlFn:"index_gridpanel_DomCtrlFn",
			gridpanel_ComponetFn:"index_gridpanel_ComponetFn"
		});
		
		var renderGrid=[];
		
		renderGrid.push({index:"idHidden",fn:function(td){
			var $html = "";
			if(td.html!=""){
				$html = $("<input type='checkbox' name='oids' checkBoxName='sysoidBox' onclick='alertAllCheckBoxFun(\"allCheckBox\",\"sysoidBox\");' style='cursor:pointer' value='"+td.html+"' />");
			}
			return $html; 
		}});
		myGP.rend(renderGrid);
});
