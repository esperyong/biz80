<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<base target="_self">
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/WEB-INF/common/meta.jsp"%>
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/device-ico.css" type="text/css" />
<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/validationEngine.jquery.css"
	type="text/css" media="screen" title="no title" charset="utf-8" />
<link href="${ctx}/css/jquery-ui/jquery.ui.treeview.css"
	rel="stylesheet" type="text/css"></link>
<title></title>
<script type="text/javascript">
var path = "${ctx}";
</script>
<script src="${ctxJs}/jquery-1.4.2.min.js"></script>
<script src="${ctxJs}/jquery.blockUI.js"></script>
<script src="${ctx}/js/component/cfncc.js"></script>
<script src="${ctx}/js/component/treeView/tree.js"></script>
<script src="${ctx}/js/component/menu/menu.js"></script>
<script src="${ctx}/js/component/accordionPanel/accordionPanel.js"></script>
<script src="${ctx}/js/component/accordionPanel/accordionAddSubPanel.js"></script>
<script src="${ctx}/js/component/panel/panel.js"></script>
<script src="${ctx}/js/component/toast/Toast.js"></script>
<script src="${ctx}/js/component/slider/slider.js"></script>
<script src="${ctxJs}/jquery.validationEngine.js"></script>
<script src="${ctxJs}/jquery.validationEngine-cn.js"></script>
<script src="${ctxJs}/profile/comm.js"></script>
<script src="${ctxJs}/component/comm/winopen.js"></script>
<script src="${ctx}/js/component/popwindow/popwin.js"></script>
<script src="${ctx}/js/jquery.blockUI.js" type="text/javascript"></script>
<style type="text/css">
.focus {
	border: 1px solid #f00;
	background: #fcc;
}

#metricSetting table td {
	vertical-align: middle;
	text-align: center;
}

#metricSetting table th {
	vertical-align: middle;
	text-align: center;
}
</style>
</head>
<body>
	<page:applyDecorator name="popwindow" title="资源一览">
		<page:param name="width">600px;</page:param>
		<page:param name="topBtn_index_1">1</page:param>
		<page:param name="topBtn_id_1">win-close</page:param>
		<page:param name="topBtn_css_1">win-ico win-close</page:param>
		<page:param name="topBtn_title_1">关闭</page:param>
		<page:param name="content">
		<form id="form" method="post">
		<input type="hidden" id="userid" name="userid" value=""/>
		<input type="hidden" id="showDetailId" name="showDetailId" value=""/>
		<input type="hidden" id="colorType" name="colorType" value=""/>
		<input type="hidden" id="orderType" name="orderType" value=""/>
		<input type="hidden" id="orderStr" name="orderStr" value=""/>
		<input type="hidden" id="currentPage" name="currentPage" value=""/>
		<input type="hidden" id="orderStr" name="orderStr" value=""/>
		</form>
			<div id="main_div" style="height: 20px" class="roundedform-content02">
				<span id="indName">指标名称:</span> </span>&nbsp;&nbsp;&nbsp;&nbsp;指标状态：<input
					type='radio' name='status' value='all' />全部<input type='radio'
					name='status' value='red' /><span class="lamp lamp-lingred"></span><input
					type='radio' name='status' value='yellow' /><span
					class="lamp lamp-lingyellow"></span><input type='radio'
					name='status' value='grey' /><span class="lamp lamp-linggrey"></span>
			</div>
			<div style="color: black;" id="dataListDiv">
				<page:applyDecorator name="indexcirgrid">
					<page:param name="id">tableId</page:param>
					<page:param name="height">390px</page:param>
					<page:param name="width">100%</page:param>
					<page:param name="tableCls">roundedform</page:param>
					<page:param name="lineHeight">26px</page:param>
					<page:param name="linenum">15</page:param>
					<page:param name="gridhead">[	
									 {colId:"resIconId", text:""}
      								,{colId:"resInstanceState", text:""}
      								,{colId:"resInstanceName", text:"显示名称"}
      								,{colId:"resIndicatorValue", text:"当前值"}
      								,{colId:"resIndicatorTime", text:"最近采集时间"}
      								,{colId:"hidResourceId", text:"",hidden:true}
      							]</page:param>
					<page:param name="gridcontent">${displayVO.content}</page:param>
				</page:applyDecorator>
				<div id="pagination" style="width: 100%"></div>
			</div>

		</page:param>
	</page:applyDecorator>

</body>
<script src="${ctx}/js/component/gridPanel/grid.js"></script>
<script src="${ctx}/js/component/gridPanel/indexgrid.js"></script>
<script src="${ctx}/js/component/gridPanel/page.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	var gp = new GridPanel({id:"tableId",
		unit:"px",
		columnWidth:{resIconId:"15",resInstanceState:"15",resInstanceName:"200",resIndicatorValue:"200",resIndicatorTime:"170"},
		plugins:[SortPluginIndex],
		sortColumns:[{index:"resInstanceName",defSorttype:"up"},
		{index:"resIndicatorValue"},
		{index:"resIndicatorTime"}],
		sortLisntenr:function($sort){
			var orderType = "desc";
			if($sort.sorttype == "up"){
				orderType = "asc";
			}
			$("#orderType").val(orderType);
			$("#orderStr").val($sort.colId);
			//alert($sort.colId);
			//$("input[name='eventQuery.orderBy']","#hiddenForm_active").attr("value",$sort.colId);
			//$("input[name='eventQuery.orderType']","#hiddenForm_active").attr("value",orderType);
			var ajaxParam = $("#form").serialize();
	      	  $.ajax({
	      		type: "POST",
	      		dataType:'json',
	      		url: "${ctx}/portlet/indicator!viewDetailIndicatorForSort.action",
	      		data: ajaxParam,
	      		success: function(data, textStatus){
	      			gp.loadGridData(data.displayVO.content);
	      		}
	      	  });
		}},{gridpanel_DomStruFn:"index_gridpanel_DomStruFn",gridpanel_DomCtrlFn:"index_gridpanel_DomCtrlFn",gridpanel_ComponetFn:"index_gridpanel_ComponetFn"});
	gp.rend([{index:"resIconId",fn:function(td){
		if(td.html){
			var $spanIcon ;
			$spanIcon = $("<span title=\""+td.value.resInstanceName+"\" class=\"device-ico RID_"+td.value.hidResourceId+"\"/>");
			return $spanIcon;
		}	
	}},{index:"resInstanceState",fn:function(td){
	if(td.html){
		var $spanState ;
		$spanState = $("<span class=\""+td.html+"\"/>");
		$spanState.bind("click",function() {
		winOpen({
		url:path+"/monitor/resourceStateDetail.action?instanceId=" + td.value.hidResourceId,width:640,height:555,name:'stateDetail'});
          });
		}
		return $spanState;	
	}},{index:"resInstanceName",fn:function(td){
	if(td.html){
		var name = coder(td.html);
		var $span ;
		$span = $('<span style="cursor:pointer" title="'+name+'">' + name + '</span>');
		$span.bind("click",function() {
		winOpen({url:'/pureportal/detail/resourcedetail.action?instanceId=' + td.value.hidId,width:980,height:600,scrollable:false,name:'resdetail_'+td.value.hidId});
          });
		}
		return $span;	
	}}]);

	function openEventDetailInfo(Id) {
		var src="${ctx}/event/eventDetailInfo!activeDetailInfo.action?eventDetailInfoVO.eventId="+Id;
		var width=720;
		var height=340;
		window.open(src,'eventDetailInfo','height='+height+',width='+width+',scrollbars=yes');
	}
	
	function openResourceDetailInfo(url) {
		var width=1000;
		var height=650;
		window.open(url,'resourceDetailInfo','height='+height+',width='+width+',scrollbars=yes');
	}

	var page = new Pagination({applyId:"pagination",listeners:{
        pageClick:function(page){
        $("#currentPage").val(page);
          var ajaxParam = $("#hiddenForm_active").serialize();
      	  $.ajax({
      		type: "POST",
      		dataType:'json',
      		url: "${ctx}/portlet/indicator!viewDetailIndicatorForSort.action",
      		data: ajaxParam,
      		success: function(data, textStatus){
      			gp.loadGridData(data.displayVO.content);
      		}
      	  });
        }
      }});
    page.pageing(${displayVO.totalPage},15);
    
  	init();
  	$(":radio").change(function(){
  		$this = $(this);
  		$("#colorType").val($this.val());
  		$("#orderType").val("asc");
  		$("#orderStr").val("resInstanceName");
  		var ajaxParam = $("#form").serialize();
    	  $.ajax({
    		type: "POST",
    		dataType:'json',
    		url: "${ctx}/portlet/indicator!viewDetailIndicatorForSort.action",
    		data: ajaxParam,
    		success: function(data, textStatus){
    			gp.loadGridData(data.displayVO.content);
    		}
    		,error:function(data, textStatus){
    			alert("error");
    		}
    		
    	  });
    })
});
function init(){
	$("#indName").append("${indName}");
	$("#userid").val("${userid}");
	$("#showDetailId").val("${showDetailId}");
	$("#colorType").val("${colorType}");
	var radios = $(":radio");
	for(var i=0;i<radios.length;i++) //循环
	{
	 if(radios[i].value=="${colorType}") //比较值
	{ 
	 radios[i].checked=true; //修改选中状态
	break; //停止循环
	}
}
}
coder = function(str) {
	 var s = "";
	 if (str.length == 0)
	  return s;
	 for (var i = 0; i < str.length; i++) {
	  switch (str.substr(i, 1)) {
	   case '"' :
	    s += "&#34;";
	    break; // 双引号 &quot;
	   case '$' :
	    s += "&#36;";
	    break;
	   case '%' :
	    s += "&#37;";
	    break;
	   case '&' :
	    s += "&#38;";
	    break; // &符号 &amp;
	   case '\'' :
	    s += "&#39;";
	    break; // 单引号
	   case ',' :
	    s += "&#44;";
	    break;
	   case ':' :
	    s += "&#58;";
	    break;
	   case ';' :
	    s += "&#59;";
	    break;
	   case '<' :
	    s += "&#60;";
	    break; // 小于 &lt;
	   case '=' :
	    s += "&#61;";
	    break;
	   case '>' :
	    s += "&#62;";
	    break; // 大于 &gt;
	   case '@' :
	    s += "&#64;";
	    break; // @
	   case ' ' :
	    s += "&#160;";
	    break; // 空格 &nbsp;
	   case '?' :
	    s += "&#169;";
	    break; // 版权 &copy;
	   case '?' :
	    s += "&#174;";
	    break; // 注册商标 &reg;
	   default :
	    s += str.substr(i, 1);
	  }
	 }
	 return s;
	};
</script>