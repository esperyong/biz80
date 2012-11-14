<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html>
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<%@ include file="/WEB-INF/common/userinfo.jsp" %>
<title>计划不在线时间</title>
<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/common.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js" ></script>
<script type="text/javascript" src="${ctx}/js/component/cfncc.js" ></script>
<script type="text/javascript" src="${ctx}/js/component/gridPanel/grid.js"></script>
<script type="text/javascript" src="${ctx}/js/component/gridPanel/indexgrid.js"></script>
<script type="text/javascript" src="${ctx}/js/component/panel/panel.js"></script>
<script type="text/javascript" src="${ctx}/js/component/popwindow/popwin.js"></script> 
<script type="text/javascript" src="${ctx}/js/component/comm/winopen.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery.blockUI.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/js/component/combobox/simplebox.js"></script>
<script src="${ctx}/js/component/toast/Toast.js"></script>
<style type="text/css">.inputoff{color:#CCCCCC}</style>
<script type="text/javascript">
var path = "${ctx}";
$(document).ready(function() {
	var toast = new Toast({position:"CT"});
	//alert('${offlineTimeJson}');
    var gpOffTime = new GridPanel({id:"offTimeTableId",
         width:670,
         columnWidth:{allCheck:50,offlineTimeName:200,offInterval:200,instanceNumber:200},
         plugins:[SortPluginIndex,TitleContextMenu],
         sortColumns:[{index:"offlineTimeName",defSorttype:"up"},{index:"instanceNumber"}],
         sortLisntenr:function($sort) {
                var colId = $sort.colId;
                var sortType = $sort.sorttype;
                $.ajax({
                    type: "POST",
                    dataType: 'json',
                    url: path+"/monitor/offlinetimejsonSort.action?orderType="+sortType+"&colId="+colId,
                    success: function(data, textStatus) {
                		gpOffTime.loadGridData(data.offlineTimeJson);
                    },
  	              error:function(e){
    	              	alert(e.responseText);
    	              }
                });
         },
		 contextMenu:function(td){
		 }
	},{gridpanel_DomStruFn:"index_gridpanel_DomStruFn",gridpanel_DomCtrlFn:"index_gridpanel_DomCtrlFn",gridpanel_ComponetFn:"index_gridpanel_ComponetFn"}
	);
    gpOffTime.rend([{index:"allCheck",fn:function(td){
       		var offlineTimeId = td.value.offlineTimeId; 
            $chk = $('<input id="offlineTimeIds" name="offlineTimeIds" type="checkbox" value="' + offlineTimeId + '"/>');
            return $chk;
         }}
    	 ,{index:"offlineTimeName",fn:function(td){
			if(td.html == "") return;
			var offlineTimeId = td.value.offlineTimeId;
			var offlineTimeName  = td.html;
			$font = $('<font STYLE="width:190px;overflow: hidden; text-overflow:ellipsis;display: inline-block;white-space:nowrap;cursor:pointer" title="'+offlineTimeName+'">'+offlineTimeName+'</font>');
			$font.bind("click",function(){
				var url = "offlinetime!findOfflineTime.action?offlineTimeId="+offlineTimeId;
				 winOpen({url:url,width:600,height:400,name:'addOffTime'})
			});
			return $font;
		}}
         , {index:"instanceNumber",fn:function(td){
        	 if (td.html != "0") {
        		$count = $('<span id='+td.value.offlineTimeId+'><font align="right">'+td.html+'个</font></span><span><span class="gray-btn-l"><span class="btn-r"><span class="btn-m"><a>查看/编辑</a></span></span></span></span>');  
        	 } else {
        		$count = $('<span id='+td.value.offlineTimeId+'><font align="right">'+td.html+'个</font></span><span><span class="gray-btn-l"><span class="btn-r"><span class="btn-m"><a>查看/编辑</a></span></span></span></span>');
        	 }
			   $count.children().bind("click",function(){
				    var url = "offlinetime-instance.action?offlineTimeId=" + td.value.offlineTimeId;
				   openViewPage(url,null);
			   });
			   return $count;
			  
         }}
	]);
    
$("#sp_offlinetime_delete").bind("click", function() {
  var allcheckboxs = $("input[name='offlineTimeIds']:checked");
  if(!haveSelect(allcheckboxs,toast)) {
    return;
  }
  var _confirm = new confirm_box({text:"是否确认删除？"});
  _confirm.setConfirm_listener(function(){
    var ajaxParam = $("#form1").serialize();
    $.ajax( {
      type : "post",
      url : "offlinetime!deleteOffTime.action",
      data : ajaxParam,
      success : function(data, textStatus) {
        deleteOffTimes();
      }
    });
    _confirm.hide();
  });
  _confirm.show();


});
	$("#allId").click(function() {
		var $Ids = $("input[name='offlineTimeIds']");
		$Ids.attr("checked",$("#allId").attr("checked"));
 	});

$("input[name='offlineTimeIds']").click(function() {
	   		var param = $(this).attr("checked");
	   		if(param == false) {
		   		$("#allId").attr("checked", false);
	   		}
	})
function deleteOffTimes() {
	var offlineTimeIds = document.getElementsByName("offlineTimeIds");
	var delIndex = new Array();
	var index = 0;
	for (var i = 0 ; i < offlineTimeIds.length; i++) {
		if (offlineTimeIds[i].checked) {
			delIndex[index] = i + "";
			index++;
		}
	}
	gpOffTime.delRow(delIndex);
	if(null == offlineTimeIds || offlineTimeIds.length<=0){
		document.location.href = document.location.href;
	}
}
	$("#sp_offlinetime_add").bind("click", function() {
		var url = "offlinetime!addOffTimeForm.action";
		 winOpen({url:url,width:600,height:400,name:'addOffTime'})
	});

	$("#closeId").bind("click", function() {
		window.close();
	});
	
});
var panel;
function openViewPage(url,title) {
if(panel){panel.close("close");}
	 panel = new winPanel( {
         	url:url,
             width:550,
             x:100,
  			  y:150,
			 isautoclose: true,
             tools:[{text:"",
           	  	 click:function(){
                     window.open("preuser-add.action", "null", "width=600,height=240");
                   }}
               ],
             listeners:{
               closeAfter:function(){
	    panel = null;
	              },
	              loadAfter:function(){
	              }
	              }
	          }, {
	        	  winpanel_DomStruFn: "blackLayer_winpanel_DomStruFn"
	        	  
	          }
	          ); 
	};
function modifiableCount(id,count){
	var textSpan = document.getElementById(id);
    textSpan.innerHTML='<span id='+id+'><font align="right">'+count+'个</font></span>';	
}
function haveSelect(obj,toast) {
	if(obj.length == 0) {
		//toast.addMessage("请至少选择一条记录。");
    var _information  = new information ({text:"请至少选择一项。"});
    _information.show();
		return false;
	}
	return true;
}
</script>
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
<form id="form1" name="form1" method="post">
<page:applyDecorator name="popwindow"  title="计划不在线时间">
  <page:param name="width">700px</page:param>
  <page:param name="topBtn_index_1">1</page:param>
  <page:param name="topBtn_id_1">closeId</page:param>
  <page:param name="topBtn_css_1">win-ico win-close</page:param>
  <page:param name="topBtn_title_1">关闭</page:param>
  <page:param name="content">
	  <div class="pop-content ">
			<div class="content-padding">
				<div class="h2"><span class="left"><span class="ico ico-tips"/></span>说明：在不在线时间段内，资源只产生事件，不产生告警。</span> 
					<span id="sp_offlinetime_delete" class="ico ico-delete right" title="删除"></span>
					<span id="sp_offlinetime_add" class="r-ico r-ico-add" title="添加"></span>
				</div>
				<div id="panel_disc_info">
					<page:applyDecorator name="indexgrid">  
				       <page:param name="id">offTimeTableId</page:param>
				       <page:param name="width">600px</page:param>
				       <page:param name="height">525px</page:param>
				       <page:param name="linenum">0</page:param>
				       <page:param name="tableCls">grid-gray</page:param>
				       <page:param name="gridhead">[{colId:"allCheck", text:"<input type='checkbox' id='allId' name='allId'/>"},{colId:"offlineTimeName", text:"名称"},{colId:"offInterval",text:"时间段列表"},{colId:"instanceNumber",text:"此时间段内不在线的资源"},{colId:"offlineTimeId",text:"head4",hidden:true}]</page:param>
				       <page:param name="gridcontent">${offlineTimeJson}</page:param>
				    </page:applyDecorator>
				</div>
			</div>
	  </div>  
	<!-- 
	<div class="pop-bottom-l">
		<div class="pop-bottom-r">
			<div class="pop-bottom-m">
			   <span class="win-button" id="sp_cancel"><span class="win-button-border"><a>取消</a></span></span>
			   <span class="win-button" id="sp_ok"><span class="win-button-border"><a>确定 </a></span></span>
			</div>
		</div>
	</div>
	 -->
  </page:param>
</page:applyDecorator>
</form>
</body>
</html>