<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/WEB-INF/common/meta.jsp"%>
<meta name="decorator" content="headfoot" /> 
<title>Mocha BSM</title>
<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css" ></link>
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css"></link>
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css"></link>
<link href="${ctx}/css/button-module.css" rel="stylesheet" type="text/css"></link>
<link type="text/css" href="${ctx}/css/validationEngine.jquery.css" rel="stylesheet" media="screen" title="no title" charset="utf-8" />
</head>
<body>
<page:applyDecorator name="headfoot">
<script src="${ctx}/js/jquery.validationEngine.js"></script>
<script src="${ctx}/js/jquery.validationEngine-cn.js"></script>
<script src="${ctx}/js/component/cfncc.js"></script>
<script src="${ctx}/js/component/gridPanel/grid.js"></script>
<script src="${ctx}/js/component/gridPanel/indexgrid.js"></script>
<script src="${ctx}/js/component/gridPanel/page.js"></script>
<script src="${ctx}/js/component/tabPanel/tab.js"></script>
<script src="${ctx}/js/component/panel/panel.js"></script>
<script src="${ctx}/js/component/toast/Toast.js"></script>
<script src="${ctxJs}/jquery.blockUI.js"></script>
<script type="text/javascript" src="${ctx}/js/component/date/WdatePicker.js"></script>
<script type="text/javascript" src="${ctx}/js/component/popwindow/popwin.js"></script>
<script type="text/javascript" src="${ctx}/js/component/combobox/simplebox.js"></script>
<page:param name="body">
<%@ include file="/WEB-INF/common/loading.jsp"%>
<page:applyDecorator name="tabPanel">
	<page:param name="id">eventTable</page:param>
	<page:param name="width"></page:param>
	<page:param name="tabBarWidth"></page:param>
	<page:param name="cls">tab-grounp</page:param>
	<page:param name="current">1</page:param>
	<page:param name="tabHander">[{text:"未确认事件",id:"activeEvent"},{text:"历史事件",id:"historyEvent"}]</page:param>
	<page:param name="otherButton">
	<%-- <div class="tab-r-menu right">
	<div class="tab-r-menu-r" style="background-color: gray;" id="rightMenu">
	<span class="ico ico-set" id="platformSet">
	</span>
	<span class="title txt-black">设置</span> 
	<span class="ico ico-arrow-zk">
	</span>
	</div>
	</div> --%>
	<div class="tab-r-menu right" >
	<div class="tab-r-menu-r" style="background-color: gray;" id="rightMenu">
	<SPAN class="ico ico-arrow-zd" id="min" style="display:none;"></SPAN>
	<div id="big">
	<span class="ico ico-set"></span><span class="title txt-black" id='platformSet' style="cursor: pointer;">第三方集成</span>
	<span class="ico ico-arrow-zk" id="in"></span>
	</div>
	</div>
	</div>
	</page:param>
	<page:param name="content">
		<s:action name="eventManage!activeEventQuery" namespace="/event" executeResult="true" ignoreContextParams="true" />
	</page:param>
</page:applyDecorator>
</page:param>
</page:applyDecorator>
</body>
<script type="text/javascript">
$.blockUI({message:$('#loading')});
var panal, min, big;
$(document).ready(function(){
	var tp = new TabPanel({id:"eventTable",
		listeners:{
	        change:function(tab){
                $.blockUI({message:$('#loading')});
	        	var url="";
	        	if(tab.id=="activeEvent"){
	        		url = "eventManage!activeEventQuery.action";
	        	}else if(tab.id=="historyEvent"){
	        		url = "eventManage!historyEventQuery.action";
	        	}
	        	tp.loadContent(1,{url:"${ctx}/event/"+url});
                $.unblockUI();
	        }
    	}}
	);

	$("#platformSet").bind("click", function(){
		openPlatFormSet();
	});
	$(".ico-set").bind("click", function(){
		openPlatFormSet();
	});

	panal = $('#rightMenu');
	min = $('#min');
	big = panal.find('#big');
	$('#in').click(function(){
		turnOFF();
	});
});

function openPlatFormSet() {
	var src="${ctx}/event/platFormSet!openPlatFormSet.action";
	var width=720;
	var height=550;
	window.open(src,'platFormSet','height='+height+',width='+width+',scrollbars=yes');
}

function turnON(){
	panal.width(panal.width()).animate({width:'110px'},null,null,function(){
		big.show();
		min.hide();
		panal.find('#in').click(function(){
			turnOFF();
		});
		min.unbind();
	});
}

function turnOFF(){
	panal.width(panal.width());
	big.hide();
	panal.animate({width:'15px'}).append(min.show());
	min.click(function(){
		turnON();
	});
	$('#in').unbind();
}
</script>
</html>