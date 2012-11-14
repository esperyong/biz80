<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<base target="_self">
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/WEB-INF/common/meta.jsp" %>
<%@ include file="/WEB-INF/common/userinfo.jsp" %>
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/device-ico.css" type="text/css" /> 
<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/validationEngine.jquery.css" type="text/css" media="screen" title="no title" charset="utf-8" />
<link href="${ctx}/css/jquery-ui/jquery.ui.treeview.css" rel="stylesheet" type="text/css" ></link>
<title>资源一览</title>
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
<script src="${ctxJs}/jquery.validationEngine.js" ></script>
<script src="${ctxJs}/jquery.validationEngine-cn.js" ></script>
<script src="${ctxJs}/profile/comm.js" ></script>
<script src="${ctxJs}/component/comm/winopen.js"></script>
<script src="${ctx}/js/component/popwindow/popwin.js"></script>
<script src="${ctx}/js/jquery.blockUI.js" type="text/javascript"></script>
<script src="${ctx}/js/component/combobox/simplebox.js"></script>
<style type="text/css">
.focus{
      border:1px solid #f00;
      background:#fcc;
}
#metricSetting table td{
	vertical-align: middle;
	text-align: center;
}
#metricSetting table th{
	vertical-align: middle;
	text-align: center;
}
</style>
</head>
<body>

          <div id="loading" class="loading" style="display:none;"
       ><div class="loading-l"
                ><div class="loading-r"
                    ><div class="loading-m"
                         ><span class="loading-img">载入中，请稍候...</span 
                    ></div
                 ></div
      ></div
 ></div>
<page:applyDecorator name="popwindow" title="资源一览">
<page:param name="width">600px;</page:param>
<page:param name="topBtn_index_1">1</page:param>
<page:param name="topBtn_id_1">win-close</page:param>
<page:param name="topBtn_css_1">win-ico win-close</page:param>
<page:param name="topBtn_title_1">关闭</page:param>
<page:param name="content">
	<div id="main_div" style="height: 20px" class="roundedform-content02"> 
	
	</div>
<div style="color:black;" id="dataListDiv">
 <form id="submitForm" action="" method="Post"
        ><input type="hidden" name="pointId" id="pointId" value="<s:property value="pointId"/>"
        /><input type="hidden" name="pointLevel" id="pointLevel" value="<s:property value="pointLevel"/>"
        /><input type="hidden" name="monitor" id="monitor" value="<s:property value="monitor"/>"
        /><input type="hidden" name="whichGrid" id="whichGrid" value="<s:property value="whichGrid"/>"
        /><input type="hidden" name="currentUserId" id="currentUserId" value="<s:property value="currentUserId "/>"
        /><input type="hidden" name="sort" id="sort" value="<s:property value="sort "/>"
        /><input type="hidden" name="sortCol" id="sortCol" value="<s:property value="sortCol "/>"
        /><input type="hidden" name="currentPage" id="currentPage" value="<s:property value="currentPage "/>"
        /><input type="hidden" name="whichState" id="whichState" value="<s:property value="whichState "/>"
        /><input type="hidden" name="isAdmin" id="isAdmin" value="<%=isAdmin %>"/>
   </form>
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
      								,{colId:"resIpAddress", text:"IP地址"}
      								,{colId:"resInstanceType", text:"资源类型"}
      								,{colId:"resDomain", text:"所属域"}
      								,{colId:"resTactical", text:"所属策略"}
      								,{colId:"hidId", text:"",hidden:true}
      								,{colId:"hidResourceName", text:"",hidden:true}
									,{colId:"hidResourceId", text:"",hidden:true}
      							]</page:param>
      <page:param name="gridcontent"><s:property value="gridJson" escape="false" /></page:param>
    </page:applyDecorator>
<div id="pagination" style="width:100%"></div>
</div>

</page:param>
</page:applyDecorator>
</body>
<script src="${ctx}/js/component/gridPanel/grid.js"></script>
<script src="${ctx}/js/component/gridPanel/indexgrid.js"></script>
<script src="${ctx}/js/component/gridPanel/page.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	var arr = new Array();
	var gp = new GridPanel({id:"tableId",
		unit:"px",
		columnWidth:{resIconId:"15",resInstanceState:"15",resInstanceName:"100",resIpAddress:"122",resInstanceType:"100",resDomain:"95",resTactical:"100"},
		plugins:[SortPluginIndex],
		sortColumns:[{index:"resInstanceName",defSorttype:"down"},{index:"resIpAddress"}],
		sortLisntenr:function($sort){
			var orderType = "desc";
			if($sort.sorttype == "up"){
				orderType = "asc";
			}
			$("#sortCol").attr("value",$sort.colId);
			$("#sort").attr("value",orderType);
			var ajaxParam = $("#submitForm").serialize();
	      	  $.ajax({
	      		type: "POST",
	      		dataType:'json',
	      		url: path + "/monitor/monitorAjaxList!monitorGrid.action",
	      		data: ajaxParam,
	      		success: function(data, textStatus){
	      			gp.loadGridData(data.gridJson);
	      		}
	      	  });
		}},{gridpanel_DomStruFn:"index_gridpanel_DomStruFn",gridpanel_DomCtrlFn:"index_gridpanel_DomCtrlFn",gridpanel_ComponetFn:"index_gridpanel_ComponetFn"});
	
	gp.rend([{index:"resIconId",fn:function(td){
	    		if(td.html){
	    			var $spanIcon ;
	    			$spanIcon = $("<span title=\""+td.value.hidResourceName+"\" class=\"device-ico RID_"+td.value.hidResourceId+"\"/>");
	    			return $spanIcon;}	
	    	}},
			{index:"resInstanceState",fn:function(td){
			if(td.html){
				var $spanState ;
				$spanState = $("<span class=\""+td.html+"\"/>");
				$spanState.bind("click",function() {
				winOpen({
				url:path+"/monitor/resourceStateDetail.action?instanceId=" + td.value.hidId,width:640,height:555,name:'stateDetail'});
                  });
				}
				return $spanState;	
			}},    
	    {index:"resIpAddress",fn:function(td){
		if(td.html){
			var ips = td.html.split(",");
			var $r ;
			var selectId = "ips_"+td.value.hidId;
			if(ips.length > 1 ){
				$r = $("<select id=\""+selectId+"\" ></select>");
				for(var index=0; index < ips.length ; index++){
					$r.append("<option value=\"" + ips[index] + "\" >" + ips[index] + "</option>");
				}
				var arry = {"id":selectId,"iconIndex":"0","iconClass":"ico ico-right for-inline f-absolute","iconTitle":"管理IP"}
				arr.push(arry);
			}else{
				$r = $("<span title=\""+ips[0]+"\">"+ips[0]+"</span>");
			}
			return $r;}	
	}},{index:"resTactical",fn:function(td){
		var arr = td.html.split(",");
		if(td.html){
			if ("SystemProfile" == arr[0]) {
                $font = $('<span class="ico ico-default" id="' + arr[0] + '" profileId="' + arr[1] + '"instanceId="' + td.value.hidId + '"rowIndex="' + td.rowIndex + '"title="' + "系统默认策略" + '"></span>"');
                return $font;
            }
            if ("UserDefineProfile" == arr[0]) {
                $font = $('<span class="ico ico-user-defined" id="' + arr[0] + '" profileId="' + arr[1]  + '"instanceId="' + td.value.hidId + '"rowIndex="' + td.rowIndex + '"title="' + "用户自定义策略" + '"></span>"');
                return $font;
            }
            if ("CustomizeProfile" == arr[0]) {
                $font = $('<span class="ico ico-individuation" id="' + arr[0] + '" profileId="' + arr[1] + '"instanceId="' + td.value.hidId + '"rowIndex="' + td.rowIndex + '"title="' + "个性化监控设置" + '"></span>"');
                return $font;
            }
            }	
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
	var page = new Pagination({applyId:"pagination",listeners:{
        pageClick:function(page){
		$.blockUI({message: $('#loading')});
		  $("#currentPage").attr("value",page);
          var ajaxParam = $("#submitForm").serialize();
      	  $.ajax({
      		type: "POST",
      		dataType:'json',
      		url: path + "/monitor/monitorAjaxList!monitorGrid.action",
      		data: ajaxParam,
      		success: function(data, textStatus){
			$.unblockUI();
      			gp.loadGridData(data.gridJson);
				SimpleBox.renderTo(arr);
      		},error:function(){$.unblockUI();}
      	  });
        }
      }});
    page.pageing("<s:property value="pageCount"/>",1);
    if("<s:property value="view_type"/>"=="metricstate"){
    	$("#main_div").html("资源状态：<input type='radio' name='status' value=''/>全部<input type='radio' name='status' value='green'/><span class='lamp lamp-green' style='margin-left: 0px;'/></span><input type='radio' name='status' value='greenred'/><span class='lamp lamp-greenred' style='margin-left: 0px;'></span><input type='radio' name='status' value='greenyellow'/><span class='lamp lamp-greenyel' style='margin-left: 0px;'></span><input type='radio' name='status' value='greengray'/><span class='lamp lamp-greenwhite' style='margin-left: 0px;'></span><input type='radio' name='status' value='red'/><span class='lamp lamp-red' style='margin-left: 0px;'></span><input type='radio' name='status' value='gray'/><span class='lamp lamp-gray' style='margin-left: 0px;'></span>");
    }else{
    	$("#main_div").html("资源状态：<input type='radio' name='status' value='-1'/>全部<input type='radio' name='status' value='0'/><span class='lamp lamp-white' style='margin-left: 0px;'/></span><input type='radio' name='status' value='1'/><span class='lamp lamp-whitegray' style='margin-left: 0px;'>");
    }
  	initRadio();
  	$(":radio").change(function(){
	$.blockUI({message: $('#loading')});
  		var status = $("input[name='status'][checked]").val(); 
  		$("#whichState").attr("value",status);
  		var ajaxParam = $("#submitForm").serialize();
    	  $.ajax({
    		type: "POST",
    		dataType:'json',
    		url: path + "/monitor/monitorAjaxList!monitorGrid.action",
    		data: ajaxParam,
    		success: function(data, textStatus){
			 $.unblockUI();
    			gp.loadGridData(data.gridJson);
				SimpleBox.renderTo(arr);
    		},error:function(){$.unblockUI();}
    	  });
    })
//SimpleBox.renderAll();
	SimpleBox.renderTo(arr)
});
function initRadio(){
	var radios = $(":radio");
	for(var i=0;i<radios.length;i++) //循环
	{
	 if(radios[i].value=="${whichState}") //比较值
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