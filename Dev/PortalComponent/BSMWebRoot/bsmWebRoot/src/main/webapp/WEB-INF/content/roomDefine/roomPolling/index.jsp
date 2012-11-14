<!-- 机房-机房巡检-首页 index.jsp -->
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<%@ page import="com.opensymphony.xwork2.util.*"%>
<title>Mocha BSM</title>
<link rel="stylesheet" href="${ctx}/css/validationEngine.jquery.css" 
	type="text/css" media="screen" title="no title" charset="utf-8" />
<link rel="stylesheet" href="${ctx}/css/public.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/common.css" type="text/css" />

<link rel="stylesheet" href="${ctx}/css/UIComponent.css" type="text/css" /> 
</head>
<body >
<script type="text/javascript">
	var path = '${ctx}';
</script>
<page:applyDecorator name="headfoot"> 
<page:param name="body">

<script src="${ctx}/js/jquery.validationEngine-cn.js" type="text/javascript"></script>
<script src="${ctx}/js/jquery.validationEngine.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/js/component/cfncc.js"></script>
<script type="text/javascript" src="${ctx}/js/component/gridPanel/indexgrid.js"></script>
<script type="text/javascript" src="${ctx}/js/component/gridPanel/page.js"></script>
<script type="text/javascript" src="${ctx}/js/component/gridPanel/grid.js"></script>
<script type="text/javascript" src="${ctx}/js/component/tabPanel/tab.js"></script>
<script type="text/javascript" src="${ctx}/js/component/panel/panel.js"></script>
<script type="text/javascript" src="${ctx}/js/component/toast/Toast.js"></script>
<script type="text/javascript" src="${ctx}/js/component/comm/winopen.js"></script>
<script type="text/javascript" src="${ctx}/js/component/menu/menu.js"></script>

<script type="text/javascript"
	src="${ctx}/js/component/plugins/jquery.ui.core.js"></script>
<script type="text/javascript"
	src="${ctx}/js/component/plugins/jquery.ui.widget.js"></script>
<script type="text/javascript"
	src="${ctx}/js/component/plugins/jquery.ui.mouse.js"></script>
<script type="text/javascript"
	src="${ctx}/js/component/plugins/jquery.ui.accordion.js"></script>
<script type="text/javascript"
	src="${ctx}/js/component/accordionPanel/j-dynamic-accordion.js"></script>
<script type="text/javascript"
	src="${ctx}/js/component/tabPanel/j-dynamic-tab.js"></script>
<script type="text/javascript" src="${ctx}/js/AnyChart.js"></script>
<script type="text/javascript" src="${ctx}/js/component/date/WdatePicker.js" ></script>
<script type="text/javascript" src="${ctx}/js/component/popwindow/popwin.js" ></script>
	
<script>
if('<s:property value="operatorResult" />' == "success"){
	parent.window.toast.addMessage("删除成功");
	setTimeout(function(){
		parent.window.location.reload();
		},1000);
}
</script>

<div id="totalDivId">

	<div class="ui-layout-west" id="layoutwestId">
	<div id="leftAllId" style="height:97%;overflow:hidden" >
		<div class="left-panel-open" id="leftId">
			<div class="left-panel-l" id="leftpanelId" style="cursor:default">
				<div class="left-panel-r">
					<div class="left-panel-m">
						<span class="left-panel-title">机房巡检</span>
					</div>	
				</div>
			</div>
			<div class="left-panel-content" style="height:100%">
					<div class="add-button1" style="height:80%"><a href="javascript:void(0);"><img src="${ctx}/images/add-button1.gif" id="add-button1" title="新建巡检机房" width="10" height="10" border="0"></a></div>
						<div class="add-button2b" style="height:80%">
						<ul style="padding-left:10px">
						<s:if test="allPollings==null || allPollings.size()==0">
							<div class="add-button2" style="height:80%"><span style="width:90%">请点击 <img src="${ctx}/images/add-button1.gif" width="10" height="10" border="0"> 按钮新建一个巡检机房</span></div>
						</s:if>
						<s:else>
							<s:iterator value="allPollings" id="map">
								 <li style="height:25px">
									 <span name="spanFontName" onclick="doit(this)" id="<s:property value='#map.value.id' />" value="<s:property value='#map.value.id' />" style="cursor: pointer;font-weight:bold">
									 <s:property value="#map.value.name" /> </span>
									 <span class="ico ico-t-right" val="<s:property value='#map.value.id' />">
									 </span>
								 </li>
							</s:iterator>
						</s:else>	
						</ul>
						</div>
			</div>
		</div>
		</div>
	</div>
	
	<div class="ui-layout-center" >
	     <s:if test="allPollings==null || allPollings.size()==0">
	    	<div id="no" style='font-size:45px;font-weight:700;width:300px;height:300px;margin:230px auto;'>无巡检机房</div>
	    </s:if>
		<div id="have" style="display:none" style="height:100%" >
			<div class="clear"  id="dynamicJspId" style="margin:10px"></div>
		</div>
	</div>
	
</div>
<s:form theme="simple" id="formDeleteRoomID" action="" name="DeleteRoomInfoForm" method="post" namespace="/roomDefine">
<input type="hidden" id="pollingIndexId" name="pollingIndexId" value="<s:property value='firstPollingId'/>" />
</s:form>
<iframe name="submitIframe" id="submitIframeId" frameborder="0" scrolling="no" height="0" width="0" src=""></iframe>
 </page:param>
</page:applyDecorator>
</body>
</html>
<script type="text/javascript">
$(function(){
	// this layout could be created with NO OPTIONS - but showing some here just as a sample...
	// myLayout = $('body').layout(); -- syntax with No Options

	myLayout = $('#totalDivId').layout({

	//	enable showOverflow on west-pane so popups will overlap north pane
		west__showOverflowOnHover: false
	//	reference only - these options are NOT required because are already the 'default'
	,	closable:				true	// pane can open & close
	,	resizable:				true	// when open, pane can be resized 
	,	slidable:				true	// when closed, pane can 'slide' open over other panes - closes on mouse-out

	//	some resizing/toggling settings
	,	north__slidable:		false	// OVERRIDE the pane-default of 'slidable=true'
	,	north__togglerLength_closed: '100%'	// toggle-button is full-width of resizer-bar
	,   north__closable:        false
	,	north__spacing_closed:	0		// big resizer-bar when open (zero height)
	,   north__spacing_open:0
	,	south__resizable:		false	// OVERRIDE the pane-default of 'resizable=true'
			// no resizer-bar when open (zero height)
	,	south__spacing_closed:	8		// big resizer-bar when open (zero height)
	,   south__spacing_open:8
	,   south__togglerLength_open:10
	,   south__togglerLength_closed:10
	//	some pane-size settings
	,   west__size:				235
	,	west__minSize:			100
	,   west__spacing_open:8
	,   west__spacing_closed:8
	,   west__togglerLength_open:36
	,   west__togglerLength_closed:36
	,	east__size:				300
	,	east__minSize:			200
	,	east__maxSize:			Math.floor(screen.availWidth / 2) // 1/2 screen width
	});
	
});
var toast;
$(document).ready(function() {
	$("#leftAllId").css("marginTop","12px");
	$("#leftAllId").css("marginBottom","0px");
	$("#leftAllId").css("marginLeft","12px");
	$("#leftAllId").css("marginRight","12px");
	$("#leftAllId").css("overflow","hidden");
	$("#layoutwestId").css("overflow","hidden");
	$(".add-button1").height(20);
	$("#add-button1").click(function(){
		var winOpenObj = {};
		var src = "${ctx}/roomDefine/AddPollingRoomVisit.action";
		winOpenObj.height = '140';
		winOpenObj.width = '400';
		winOpenObj.name = 'addPollingRoom';
		winOpenObj.url = src;
		winOpenObj.scrollable = false;
		winOpen(winOpenObj);
	});

	$("#layoutwestId")[0].style.height="100%";
	$("#leftId").width(216).css("height","100%");
var xVal=20;
var yVal=100;
	var menu = new MenuContext({
        // x: event.clientX/2+40,
        //y: event.clientY/2+50,
        x: xVal,
        y: yVal,
        width: 150,
        listeners: {
            click: function(id) {
                //alert(id)
            }
        }
    });
   
	//菜单.
	$("#totalDivId .ico-t-right").bind("click",function(e){
		xVal=event.clientX/2+40;
		yVal=event.clientY/2+80;
		
		var resGroupOp = new MenuContext({x:xVal,y:yVal,width:150,listeners:{click:function(id){alert(id)}}},{menuContext_DomStruFn:"ico_menuContext_DomStruFn"});
		var tmpval = $(this).attr("val");
		resGroupOp.position(xVal,yVal);
		
		  resGroupOp.addMenuItems
		  ([[
				{ico:"edit",text:"编辑",id:"edit_bu",listeners:{
					click:function(){
						resGroupOp.hide();	
						var winOpenObj = {};
						var src = "${ctx}/roomDefine/AddPollingRoomVisit!editVisit.action?pollingId="+tmpval;
						winOpenObj.height = '140';
						winOpenObj.width = '400';
						winOpenObj.name = 'editPollingRoom';
						winOpenObj.url = src;
						winOpenObj.scrollable = false;
						winOpen(winOpenObj);    					
					}
				}},
			    {ico:"delete",text:"删除",id:"del_bu",listeners:{
				click:function(){
					var _confirm = new confirm_box({text:"是否确认执行此操作？"});
					 _confirm.setConfirm_listener(function(){
						 $("#pollingIndexId").val(tmpval);
							$("#formDeleteRoomID").attr("action","${ctx}/roomDefine/DeletePollingIndex.action");
							$("#formDeleteRoomID").attr("target","submitIframe");
							$("#formDeleteRoomID").submit(); 
							_confirm.hide();
					 });
					 _confirm.show();
						//resGroupOp.hide();				
					}
				}}]]);
	});
	
    /*
	//菜单.
	$("#totalDivId .ico-t-right").bind("click",function(e){
		xVal=event.clientX/2+40;
		yVal=event.clientY/2+50;
		var tmpval = $(this).attr("val");
		var equipmentArray = [[{
	        text: "编辑",
	        id: "edit_bu",
	        listeners: {
	            click: function() {
				var winOpenObj = {};
				var src = "${ctx}/roomDefine/AddPollingRoomVisit!editVisit.action?pollingId="+tmpval;
				winOpenObj.height = '300';
				winOpenObj.width = '400';
				winOpenObj.name = 'editPollingRoom';
				winOpenObj.url = src;
				winOpenObj.scrollable = false;
				winOpen(winOpenObj);          	
	            }
	        }
	    },{
	        text: "删除",
	        id: "del_bu",
	        listeners: {
	            click: function() {
					$("#pollingIndexId").val(tmpval);
					$("#formDeleteRoomID").attr("action","${ctx}/roomDefine/DeletePollingIndex.action");
					$("#formDeleteRoomID").attr("target","submitIframe");
					$("#formDeleteRoomID").submit(); 
					menu.hide();
	            }
	        }
	    }]];
		menu.addMenuItems(equipmentArray);
		menu.position(xVal, yVal);
	});
*/
	toast = new Toast({position:"CT"}); 
	
});

function ajaxIndexFun(roomId,isJigui,url) {
	//alert("ajaxIndexFun:roomId:::"+roomId);
	$.ajax({
		type: "post",
		dataType:'html', //接受数据格式 
		cache:false,
		data:"roomId="+roomId+"&isJigui="+isJigui, 
		url: url,
		beforeSend: function(XMLHttpRequest){
		//ShowLoading();
		},
		success: function(data, textStatus){
			//alert($("#dynamicJspId")[0]);
			$("#dynamicJspId").find("*").unbind();
			$("#dynamicJspId").html("");
			$("#dynamicJspId").append(data);
			//alert(data);
		//var listJson = $parseJSON(data.devValues);
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
var cur;
function doit(obj) {
    if(cur == obj) return false;
    if(cur!=null) cur.style.fontWeight = "normal";
    var spanArr = $("span[name='spanFontName']");
    for(i=0;i<spanArr.length;i++) {
    	spanArr[i].style.fontWeight="normal";
    }
    obj.style.fontWeight = "bold";
    cur = obj;
    $("#have").show("slow");
    $("#no").hide("slow");
    $("#pollingIndexId").val(obj.value);
    roomClkPollingTabFun();
}

function roomClkPollingTabFun(){
	var pollingIndexId = $('#pollingIndexId').val();
	if(pollingIndexId != null && pollingIndexId!=""){
	$("#have").show("slow");
	$("#no").hide("slow");
	var spanArr = $("span[name='spanFontName']");
    for(i=0;i<spanArr.length;i++) {
        if(spanArr[i].value==pollingIndexId){
    		spanArr[i].style.fontWeight="bold";
        }else{
        	spanArr[i].style.fontWeight="normal";
        }
    }
	}
	ajaxIndexFun(pollingIndexId,"${ctx}/roomDefine/PollingTabVisit.action");
}
function ajaxIndexFun(pollingIndexId,url) {
	$.ajax({
		type: "post",
		dataType:'html', //接受数据格式 
		cache:false,
		data:"pollingIndexId="+pollingIndexId, 
		url: url,
		beforeSend: function(XMLHttpRequest){
		//ShowLoading();
		},
		success: function(data, textStatus){
			//alert($("#dynamicJspId")[0]);
			$("#dynamicJspId").find("*").unbind();
			$("#dynamicJspId").html("");
			$("#dynamicJspId").append(data);
			//alert(data);
		//var listJson = $parseJSON(data.devValues);
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
roomClkPollingTabFun();



</script>