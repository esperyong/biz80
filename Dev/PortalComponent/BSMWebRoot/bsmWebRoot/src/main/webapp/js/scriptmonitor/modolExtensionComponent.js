/**
 * GridPanel
 * */
var widthVal = 770;
var widthJson = {resourceId:5,resourceName:18,resourceType:12,resourceDes:30,updateTime:17,operate:8,toRelease:10};
var sortCloumnsJson = [{index:"resourceName",defSorttype:"up"},{index:"resourceType"},{index:"updateTime"}];
var myGP=null;
/*var mc = new MenuContext({x:0,y:0,width:100,
	listeners:{click:function(id){alert(id)}}},
	{menuContext_DomStruFn:"ico_menuContext_DomStruFn"});*/
var menu = new MenuContext({
    x: 20,
    y: 100,
    width: 120,
    plugins:[duojimnue],
    listeners: {
        click: function(id) {
            //alert(id)
        }
    }
});
$(function(){
	myGP = new GridPanel({
		id:gridTabId,
		columnWidth:widthJson,
		unit:"%",
		plugins:[SortPluginIndex],
		sortColumns:sortCloumnsJson,
		sortLisntenr:function($sort){
			var sort="";
		    var sortCol=$sort.sorttype;
		    if(sort==="resourceName"){
		    	$("#sortIdHidden").val("1");
		    }else if(sort==="resourceType"){
		    	$("#sortIdHidden").val("2");
		    }else if(sort==="updateTime"){
		    	$("#sortIdHidden").val("5");
		    }else{  /*else if(sort==="ipList"){$("#sortIdHidden").val("6");}*/
		    	$("#sortIdHidden").val("1");
		    }
			$("#sortColIdHidden").val(sortCol);
			loadTable();
		}
		},
		{	gridpanel_DomStruFn:"index_gridpanel_DomStruFn",
			gridpanel_DomCtrlFn:"index_gridpanel_DomCtrlFn",
			gridpanel_ComponetFn:"index_gridpanel_ComponetFn"
		});
		
		var renderGrid=[];
		
		renderGrid.push({index:"resourceId",fn:function(td){
			var $html = "";
			if(td.html!=""){
				$html = $("<input type='checkbox' name='resourceIdBox' checkBoxName='resourceIdBox"+gridTabId+"' onclick='alertAllCheckBoxFun(\"allCheckBox"+gridTabId+"\",\"resourceIdBox"+gridTabId+"\")' id='resourceId' style='cursor:pointer' value='"+td.html+"' />");
			}else{
				$html = "&nbsp;";
			}
			return $html; 
		}});
		
		renderGrid.push({index:"resourceName",fn:function(td){
			var $html = "";
			if(td.html!=""){
				if(td.value.toReleaseIco=="false"||!td.value.toReleaseIco){
					$html = $("<span class='ico ico-stop'/><span style='cursor:pointer' title='"+td.html+"' value='"+td.value.hiddenResId+"'>"+td.html+"</span>");
				}else{
					$html = $("<span class='ico ico-play'/><span style='cursor:pointer' title='"+td.html+"' value='"+td.value.hiddenResId+"'>"+td.html+"</span>");
				}
				$html.bind("click",function(){
					openWinFun(ctx+"/scriptmonitor/repository/editModel.action?resourceId="+td.value.hiddenResId,"editModel");
				});
			}else{
				$html = "&nbsp;";
			}
		return $html;
		}});
		renderGrid.push({index:"resourceType",fn:function(td){
			var $html = "";
			if(td.html!=""){
				$html = $("<span title='"+td.html+"' >"+td.html+"</span>");
			}else{
				$html = "&nbsp;";
			}
		return $html;
		}});
		renderGrid.push({index:"resourceDes",fn:function(td){
			var $html = "";
			if(td.html!=""){
				$html = $("<span title='"+td.html+"' >"+td.html+"</span>");
			}else{
				$html = "&nbsp;";
			}
		return $html;
		}});
		renderGrid.push({index:"updateTime",fn:function(td){
			var $html = "";
			if(td.html!=""){
				$html = $("<span title='"+td.html+"' >"+td.html+"</span>");
			}else{
				$html = "&nbsp;";
			}
		return $html;
		}});
		/*
		renderGrid.push({index:"ipList",fn:function(td){
			var ips = td.html;
			var html = "";
			if(ips.indexOf(",") >= 0){
				var ipArray = ips.split(",");
				html += "<select name='forIp'>";
				for(var ip in ipArray){
					html += "<option>"+ip+"</option>";
				}
				html += "</select>";
			}else{
				html = "<span name='forIp'>"+ips+"</span>"
			}
			return $(html);
		}});
		*/
		renderGrid.push({index:"operate",fn:function(td){
			td.align="center";
			var $html = "";
			if(td.html!=""){
				$html = $('<span style="cursor:pointer;" name="operate" value="'+td.value.hiddenResId+'" class="ico ico-t-right" title="操作">&nbsp;</span>');
				$html.bind("click",function(){
					menu.position(event.x+130,event.y+50);
					menu.addMenuItems([[{text:"添加指标",id:"addMetric",listeners:{
							click:function(){
								openWinFun(ctx+"/scriptmonitor/repository/addMetric.action?resourceId="+$html.val(),"addMetric");
							}
					}},{text:"添加组件",id:"addCompent",listeners:{
						click:function(){
							openWinFun(ctx+"/scriptmonitor/repository/addComponent.action?resourceId="+$html.val(),"addCompent");
						}
				}}]]);
				}); 
			}
			return $html;
		}});
		
		renderGrid.push({index:"toRelease",fn:function(td){
			var $html = "";
			if(td.html!=""){
				if(td.value.toReleaseIco=="false"||!td.value.toReleaseIco){
					$html = $('<span name="operate" class="gray-btn-l" title="发布"><span class="btn-r"><span class="btn-m"><a>发布</a></span></span></span>');
					$html.bind("click",function(){
						publishModelFun(td.value.hiddenResId);
					});
				}else{
					$html = "&nbsp;";
				}
			}
			return $html;
		}});		
		myGP.rend(renderGrid);
});
