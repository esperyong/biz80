<!-- 机房巡检-巡检tab页签-  pollingTabInfo.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<link rel="stylesheet" href="${ctx}/css/UIComponent.css" type="text/css" /> 
<script type="text/javascript" src="${ctx}/js/room/roomPolling/pollingCountTime.js" ></script>
<script type="text/javascript" src="${ctx}/js/component/popwindow/popwin.js" ></script>
<script>var ctx="${ctx}";</script>
<style>
.formhead table thead tr th .theadbar .theadbar-name {
	padding-left: 10px;
}
.formcontent table tbody tr td span {
	padding-left: 10px;
}
</style>
<page:applyDecorator name="tabPanel">  
       <page:param name="id">poolingTab</page:param>
       <page:param name="width"></page:param>
       <page:param name="background">#000000</page:param>
       <page:param name="tabBarWidth"></page:param>
       <page:param name="cls">tab-grounp</page:param>
       <page:param name="current">1</page:param> // 默认显示第几个
       <page:param name="tabHander">[{text:"巡检列表",id:"tab1"},{text:"巡检统计",id:"tab2"}]</page:param>
       <page:param name="content_1">
       <div style="overflow:hidden;top:5px;position:relative;height:30px;" >
   	    <span class="black-btn-l f-right"><span class="btn-r"><span class="btn-m"><a id="startPollingId">开始巡检</a></span></span></span>
       	<span class="black-btn-l f-right"><span class="btn-r"><span class="btn-m"><a id="editPollingModId">编辑巡检模板</a></span></span></span>
		<span style="color: white">巡检时间：从</span><input type="text" id="startTime" name="startTime" /><span style="color: white">到</span><input type="text" id="endTime" name="endTime" /> &nbsp;&nbsp;
   		<span style="color: white">巡检人：</span><input type="text" id="pollingUser" name="pollingUser" /><span  id="pollingTabSearch" class="ico" title="搜索" ></span>
       </div>
       <div id="PollingTabDis">
       <page:applyDecorator name="indexgrid">
	     <page:param name="id">pollingTableId</page:param>
	     <page:param name="width"></page:param>
	     <page:param name="height">580</page:param>
	     
	     <page:param name="linenum">25</page:param>
	     <page:param name="tableCls">grid-black</page:param>
	     <page:param name="gridhead">[{colId:"state",text:"状态"},{colId:"pollingTableName",text:"巡检表名称"},{colId:"pollingPeople",text:"巡检人"},{colId:"lastEditTime",text:"最后一次编辑时间"},{colId:"editPeople",text:"编辑人"},{colId:"operator",text:"操作"}]</page:param>
	     <page:param name="gridcontent"><s:property value="pollingTableData" escape="false" /></page:param>
	   </page:applyDecorator>
	   </div>
       </page:param>
       <page:param name="content_2">
       	<div class="clear" id="dycPoolingSumId">
        <div style="overflow:hidden;top:5px;position:relative;height:30px;" >
			<span class="black-btn-l f-right"><span class="btn-r"><span class="btn-m"><a id="exportId">导出</a></span></span></span>
			<span style="color: white"> 统计时间段：<s:select id="pollingCountTime" list="#{'month':'每月','week':'每周','day':'每天'}"/><span id="yAndMDiv"></span><span style="display:none;" id="weekDiv"></span><span style="display:none;" id="dayDiv"></span></span><span id="pollingCountSearch" class="ico"  title="搜索" ></span>
		</div>
		<div id="PollingCountDis">
        	<s:action name="PollingCount" namespace="/roomDefine" executeResult="true" flush="false">
        	</s:action>
        </div>
       	</div>
       </page:param>
</page:applyDecorator>           

<input type="hidden" name="startTimeVal" id="startTimeVal" value="" />
<input type="hidden" name="endTimeVal" id="endTimeVal" value="" />
 
<script type="text/javascript">
var gp;
$(function(){
	var tpmyfirst11 = new TabPanel({id:"poolingTab",
		listeners:{
			/*changeBefore:function(tab){
	        	alert(tab.index+"before");
	        	return true;
	        },*/
	        change:function(tab){
		        targetType = tab.id=="tab2"?"tab2":"tab1";
       		 if(tab.id=="tab1"){
				return;
           	 }
           	 var roomId = $("#roomId").val();
           	    ajaxPoolingTabVisitFun(targetType,roomId);
	        }/*,
	        changeAfter:function(tab){
        		alert(tab.index);
			}*/
    	}}
		); 
	$("#startPollingId").bind("click",startPollingFun);
	$("#editPollingModId").bind("click",editPollingModFun);

	gp = new GridPanel({id:"pollingTableId",
	    unit:"%",
	    columnWidth:{state:10,pollingTableName:21,pollingPeople:12,lastEditTime:15,editPeople:15,operator:25},
	    plugins:[SortPluginIndex],
            sortColumns:[{
    	        index: "state",
    	        defSorttype: "up"
    	    },{
    	        index: "pollingTableName"
    	    },{
    	    	index: "pollingPeople"
            },{
    	    	index: "lastEditTime"
            }],
            sortLisntenr:function($sort){
	    	var sort=$sort.colId;
       	    var sortCol=$sort.sorttype;
    		$("#sortIdHidden").val(sort);
    		$("#sortColIdHidden").val(sortCol);
       	 	var page = $("#pageIdHidden").val();
       	 	if(null == page || "" == page){
           	    page = '<s:property value="curPageCount" />';
           	}
       	 var result = $("form").serialize()+"&curPageCount=" + page  + "&colId=" + sort + "&sortType=" + sortCol;
       	 alert(result);
         var url = "${ctx}/roomDefine/DeviceOverviewVisit!searchOneStateDevice.action";
	            $.ajax({
	                type: "POST",
	                dataType: 'json',
	                data:result,
	             	url:url,
	                success: function(data, textStatus) {
	        			var resourceData = data.resourceData;
	        			gp.loadGridData(resourceData);
	                }
	            });
            },
			contextMenu:function(td){
		    }
        },{gridpanel_DomStruFn:"index_gridpanel_DomStruFn",gridpanel_DomCtrlFn:"index_gridpanel_DomCtrlFn",gridpanel_ComponetFn:"index_gridpanel_ComponetFn"}
        );
	gp.rend([{index:"operator",fn:function(td){
   			if(td.html!="" && td.html!=" ") {
   				var splitStr = td.html.split("##");
   				if(splitStr.length == 2){
   					//提交
   					if(splitStr[0] == "1"){
   						var $span = $('<span style="cursor:pointer" name="stateSpan" value="'+splitStr[1]+'" class="ico ico-look" title="查看" />');
   		   		        $span.bind("click",function(){
   		   		        	viewPollingFun($(this).val());
   		   		        });
   		   		    	return $span;
   					}else{//保存
   						var html = "";
   						html += '<span id="dispalyTab'+splitStr[1]+'" style="cursor:pointer" name="stateSpan" value="'+splitStr[1]+'" class="ico ico-look" title="查看" />';
   						html += '<span id="editTab'+splitStr[1]+'" style="cursor:pointer" name="stateSpan" value="'+splitStr[1]+'" class="ico ico-edit5" title="编辑" />';
   						html += '<span id="delTab'+splitStr[1]+'" style="cursor:pointer" name="stateSpan" value="'+splitStr[1]+'" class="ico ico-delete3" title="删除" />';
   						html += '<span id="submitTab'+splitStr[1]+'" style="cursor:pointer" name="stateSpan" value="'+splitStr[1]+'" class="ico ico-submit" title="提交" />';
   						var $span = $(html);
   		   		    	return $span;
   					}
   				}
   	        }else{
   				return null;
   	        }
   	     	}
		},{index:"pollingTableName",fn:function(td){
				if(td.html!="" && td.html!=" ") {
					var splitStr = td.html.split("##");
					if (splitStr.length>0){
						if(splitStr[1]=="1"){
							var $span = $('<span style="cursor:pointer" name="pollingName" value="'+splitStr[2]+'">'+splitStr[0]+'</span>');
							$span.bind("click",function(){
	   		   		        	viewPollingFun($(this).val());
	   		   		        });
	   		   		    	return $span;
						}else{
							var $span = $('<span style="cursor:pointer" name="pollingName" value="'+splitStr[2]+'">'+splitStr[0]+'</span>');
							$span.bind("click",function(){
								editPollingFun($(this).val())
	   		   		        });
	   		   		    	return $span;
						}
					}
				}
			}
		}
	   ]);
});
/**
 * 查看巡检.
 */
function viewPollingFun(id) {
 var winOpenObj = {};
 var src = "${ctx}/roomDefine/EditPollingVisit.action?id="+id+"&operateState=0";
 winOpenObj.height = '700';
 winOpenObj.width = '820';
 winOpenObj.name = 'editPolling';
 winOpenObj.url = src;
 winOpenObj.scrollable = true;
 winOpen(winOpenObj);
}
/**
 * 编辑巡检.
 */
function editPollingFun(id) {
 var winOpenObj = {};
 var src = "${ctx}/roomDefine/EditPollingVisit.action?id="+id+"&operateState=1";
 winOpenObj.height = '700';
 winOpenObj.width = '820';
 winOpenObj.name = 'editPolling';
 winOpenObj.url = src;
 winOpenObj.scrollable = true;
 winOpen(winOpenObj);
}
/**
 * 删除巡检记录
 */
function delPollingRecordFun(id){
	$.ajax({
		url		:	"${ctx}/roomDefine/DeletePollingRecord.action",
		data	:	"id="+id,
		dataType:	"html",
		cache:		false,
		complete :	function(data, textStatus){
			roomClkPollingTabFun();
		}
	});
}
function setSubmitStateFun(id){
	$.ajax({
		url		:	"${ctx}/roomDefine/EditPollingVisit!setSubmitState.action",
		data	:	"id="+id,
		dataType:	"html",
		cache:		false,
		complete :	function(data, textStatus){
			roomClkPollingTabFun();
		}
	});
}

function ajaxPoolingTabVisitFun(targetType,roomId) {
	return ;
	$.ajax({
		type: "post",
		dataType:'html', //接受数据格式 
		cache:false,
		data:"targetType=" + targetType + "&roomId=" + roomId, 
		url: "${ctx}/roomDefine/ChangeTabPageVisit.action",
		//url: "${ctx}/roomDefine/ResMetricVisit.action",
		beforeSend: function(XMLHttpRequest){
		//ShowLoading();
		},
		success: function(data, textStatus){
			//alert($("#treeTabPageId")[0]);
			if(targetType=="tab2"){
				$("#dycPoolingSumId").find("*").unbind();
				$("#dycPoolingSumId").html("");
				$("#dycPoolingSumId").append(data);
			}
		},
		complete: function(XMLHttpRequest, textStatus){
		//HideLoading();
		},
		error: function(){
		//请求出错处理
			alert("error");
		}
		});
}
/**
 * 开始巡检.
 */
function startPollingFun() {
	var winOpenObj = {};
	var src = "${ctx}/roomDefine/StartPollingVisit.action?pollingIndexId="+'<s:property value="pollingIndexId" />';
	winOpenObj.height = '700';
	winOpenObj.width = '820';
	winOpenObj.name = 'startPollingName';
	winOpenObj.url = src;
	winOpenObj.scrollable = true;
	winOpen(winOpenObj);
}
/**
 * 编辑巡检模板.
 */
function editPollingModFun() {
	//alert('<s:property value="pollingIndexId" />');
	var winOpenObj = {};
	var src = "${ctx}/roomDefine/EditPollingModuleVisit.action?pollingIndexId="+'<s:property value="pollingIndexId" />';
	winOpenObj.height = '700';
	winOpenObj.width = '820';
	winOpenObj.name = 'pollingModName';
	winOpenObj.url = src;
	winOpenObj.scrollable = true;
	winOpen(winOpenObj);
}
var startTimeVal;var endTimeVal;
$("#pollingCountSearch").bind("click",function(){
	var myDate = new Date();
	if($("#pollingCountTime").val() == "month"){
		var year = $("#pollingTimeYear").val();
		var month = $("#pollingTimeMonth").val();
		startTimeVal = year+"-"+month+"-1 00:00:00";
		endTimeVal = myDate.getFullYear()+"-"+(myDate.getMonth()+1)+"-"+myDate.getDate()+" "+myDate.getHours()+":"+myDate.getMinutes()+":"+myDate.getSeconds();
	}else if($("#pollingCountTime").val() == "week"){
		var weekTime = $("#pollingTime").val().split("@@");
		startTimeVal = weekTime[0];
		endTimeVal = weekTime[1];
	}else if($("#pollingCountTime").val() == "day"){
		startTimeVal = $("input[name='pollingStartTime']").val()+" 00:00:00";
		endTimeVal = $("input[name='pollingStartTime']").val()+" 23:59:59";
	}
	$("#startTimeVal").val(startTimeVal);
	$("#endTimeVal").val(endTimeVal);
	//alert(startTimeVal +"		"+endTimeVal);
	$.ajax({
		url : path+"/roomDefine/PollingCount.action",
		data : "pollingIndexId="+'<s:property value="pollingIndexId" />'+"&startTimeVal="+startTimeVal+"&endTimeVal="+endTimeVal,
		dataType:"html",
		cache:	false,
		success:	function(data, textStatus){
			$("#PollingCountDis").find("*").unbind();
			$("#PollingCountDis").html("");
			$("#PollingCountDis").html(data);
		}
	});
});

$("#pollingTabSearch").bind("click",function(){
	var $content = $("#PollingTabDis");
	var user = encodeURI($("#pollingUser").val());
	user = encodeURI(user);
	$.ajax({
		url : path+"/roomDefine/PollingTabVisit!searchPollingRecordByCondition.action",
		data: "pollingIndexId="+'<s:property value="pollingIndexId" />'+"&pollingUser="+user+"&startTime="+$("#startTime").val()+"&endTime="+$("#endTime").val(),
		dataType:"json",
		cache:	false,
		success:	function(data, textStatus){
		self.gp.loadGridData(data.pollingTableData);
		}
	});
});
$("span[id *=dispalyTab]").bind("click",function(){
    viewPollingFun($(this).val());
});
$("span[id *=editTab]").bind("click",function(){
	editPollingFun($(this).val());
});
$("span[id *=delTab]").bind("click",function(){

	var delThis = $(this).val();
	
	var _confirm = new confirm_box({text:"是否确认执行此操作？"});
	 _confirm.setContentText("是否确认执行此操作？");
	 _confirm.setConfirm_listener(function(){
		 delPollingRecordFun(delThis);
			_confirm.hide();
	 });
	 _confirm.show();
   
});
$("span[id *=submitTab]").bind("click",function(){
    setSubmitStateFun($(this).val());
});
$("#startTime").bind("click",function(){
	WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'});
});
$("#endTime").bind("click",function(){
	WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'});
});
$("#pollingTimeYear").bind("change",function(){
	var year = $("#pollingTimeYear").val();
	var month = $("#pollingTimeMonth").val();
	getWeekTime(year,month);
});
$("#pollingTimeMonth").bind("change",function(){
	var year = $("#pollingTimeYear").val();
	var month = $("#pollingTimeMonth").val();
	getWeekTime(year,month);
});

$('#exportId').click(function() {
	var pollingIndexId = '<s:property value="pollingIndexId" />';
	var startTime = $('#startTimeVal').val();
	var endTime = $('#endTimeVal').val();
	var dateType = $("#pollingCountTime").val();
	window.open("${ctx}/roomDefine/ExportPolling!exportPollingSummary.action?pollingIndexId="+pollingIndexId+"&startTimeVal="+startTime+"&endTimeVal="+endTime+"&dateType="+dateType,"_blank","width=400,height=250");
});
</script>
