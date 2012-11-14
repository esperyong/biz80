<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html>
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<%@ include file="/WEB-INF/common/userinfo.jsp" %>
<title>计划不在线时间</title>
<style type="text/css">.inputoff{color:#CCCCCC}
.span_dot{width:145px;overflow: hidden; text-overflow:ellipsis;display: inline-block;white-space:nowrap;}
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
<form id="formInst" name="formInst" method="post">
<input type="hidden" name="offlineTimeId" id="offlineTimeId" value="${offlineTimeId}"/>
	  <div class="pop-content" style="overflow:hidden">
			<div class="content-padding">
			  <div id="topDiv">
				<div class="h2">
					<span class="left" style="font-weight:bold;">此时间段内不在线的资源：</span>
					<span class="black-btn-l f-right" id="sp_inst_delete"><span class="btn-r"><span class="btn-m"><a>移出</a></span></span></span>
					<span class="black-btn-l f-right" id="sp_inst_add"><span class="btn-r"><span class="btn-m"><a>添加</a></span></span></span>
			   </div>
			   	<div class="h1">
			   <span  class="title" style="width:92px;overflow: hidden; text-overflow:ellipsis;display: inline-block;white-space:nowrap;float:left;height:21px;line-height:21px;" title="<%=domainPageName%>">所属<%=domainPageName%>：</span><select id="domainId" name="domainId" class="" style="border-bottom: medium none; border-left: medium none; border-top: medium none; border-right: medium none;">
		                     <s:if test="domainMap != null && domainMap.size() > 1">
		                         <option value="">全部</option>
		                       </s:if>
		                          <s:iterator value="domainMap" var="map" status="stat">
                                 <option value="<s:property value=" #map.key " />">
                                         <s:property value="#map.value" />
                                </option>
                                </s:iterator>
                          </select>
			   <s:select id="nameorip" name="nameorip" style="float:left;height:21px;line-height:21px;" list="nameoriplist" listKey="optionValue" listValue="optionDisplay"/>
      		   <s:textfield name="nameoripvalue" style="width:108px;height:20px;line-height:20px;" id="nameoripvalue" maxlength="" size="" value="请输入条件进行搜索" /><span class="ico ico-select" id="searchInst" title="点击进行搜索"></span>
			   </div>
			   </div>
				<div id="panel_disc_info">
						<page:applyDecorator name="indexcirgrid">  
					       <page:param name="id">instTableId</page:param>
					       <page:param name="width">550px</page:param>
					       <page:param name="height">300</page:param>
					       <page:param name="linenum">0</page:param>
					       <page:param name="tableCls">grid-black</page:param>
					       <page:param name="gridhead">[{colId:"allCheck", text:"<input type='checkbox' id='allIds' name='allIds'/>"},{colId:"resourceLevel2",text:"资源类型"},{colId:"name", text:"资源名称"},{colId:"IPAddress",text:"IP地址"},{colId:"instanceId",text:"head4",hidden:true}]</page:param>
					       <page:param name="gridcontent">${instanceJson}</page:param>
					    </page:applyDecorator>
				</div>
			</div>
	  </div>  	
</form>
<script type="text/javascript">
var sort = "<s:property value="sort"/>";
if(!sort || sort=="" || sort==null){
  sort = "up";
}    
var sortCol = "<s:property value="sortCol"/>";    
if(!sortCol){
  sortCol = "name";
}    
var path = "${ctx}";
$(document).ready(function() {
    var $searchText = $("#nameoripvalue");
    $searchText.addClass("inputoff");
    $searchText.bind("focus", function(event) {
         $searchText.removeClass();
         if ($searchText.val() == "请输入条件进行搜索") {
	          $searchText.val("");
         }
    });
    $searchText.bind("blur", function(event) {
         var c = $searchText.val();
         if (c == null || c == '') {
	          $searchText.val("请输入条件进行搜索");
	          $searchText.addClass('inputoff');
         }
    });
    $searchText.bind("keydown", function(event) {
    	var evt = window.event ? window.event : evt;
        if (evt.keyCode == 13) {
        	 $("#nameoripvalue").val($.trim($("#nameoripvalue").val()));
     	  	var val = $("#nameoripvalue").val();
     	  	if( val == '请输入条件进行搜索' ){
     	  		val = "";
     	  	}
     	  	$("#nameoripvalue").val(val);
        var data = $('#formInst').serialize();
   	    var url = "offlinetime-instance.action?"+data;
        openViewPage(url,null);
   }});
	$.blockUI({message:$('#loading')});
	$.unblockUI();
	var $formObj = $("#formInst");
	var toast = new Toast({position:"CT"});
  var sortColumnsArr = [{index:"name",defSorttype:"up"},{index:"IPAddress"}];
  if(sortCol=='name'){
    sortColumnsArr = [{index:"name",defSorttype:sort},{index:"IPAddress"}];
  }else if(sortCol =="IPAddress"){
    sortColumnsArr = [{index:"name"},{index:"IPAddress",defSorttype:sort}];
  }
    var gpInst = new GridPanel({id:"instTableId",
         width:550,
         columnWidth:{allCheck:50,name:180,IPAddress:220,resourceLevel2:100},
         plugins:[SortPluginIndex,TitleContextMenu],
         sortColumns:sortColumnsArr,
         sortLisntenr:function($sort) {
        	 $("#nameoripvalue").val($.trim($("#nameoripvalue").val()));
      	  	var val = $("#nameoripvalue").val();
      	  	if( val == '请输入条件进行搜索' ){
      	  		val = "";
      	  	}
      	  	$("#nameoripvalue").val(val);
                //alert($sort.colId);
                //alert($sort.sorttype);
                var sortColId = $sort.colId;
                var sortType = $sort.sorttype;
                // gpInst.loadGridData('${instanceJson}');
           		//TODO $.post("preuser-list-sort!sortUser.action?colId=" + colId + "&sortType=" + sortType, function(data){
           			//gpInst.loadGridData(data.instanceJson);
             	//});
             	var data = $('#formInst').serialize();
            	var url = "offlinetime-instance.action?"+data+"&sort="+sortType+"&sortCol="+sortColId;
                openViewPage(url,null);;
         },
		 contextMenu:function(td){
		    // alert("=="+td.colId);
		 }
	},{gridpanel_DomStruFn:"index_gridpanel_DomStruFn",gridpanel_DomCtrlFn:"index_gridpanel_DomCtrlFn",gridpanel_ComponetFn:"index_gridpanel_ComponetFn"}
	);
    gpInst.rend([{index:"allCheck",fn:function(td){
       		var instanceId = td.value.instanceId; 
           	$chk = $('<input id="instanceIds" name="instanceIds" type="checkbox" value="' + instanceId + '"/>');
            return $chk;
         }}
         ,{index:"name",fn:function(td){
			if(td.html == "") return;
			$font = $('<font title="'+td.html+'">'+td.html+'</font>');
			return $font;
		 }}
    	  ,{index:"IPAddress",fn:function(td){
				if(td.html == ""){
			    	return null;
		        }
		        if(td.html == "-"){
		            return "-";
		        }
		        var tmp = td.html;
		        var arr = tmp.split(",");
		        var length = arr.length;
		        if( length <= 1 ){
		             return td.html;
		        }
		        var select = '<select name="ipAddress" style="width:117px" id="'+td.rowIndex+'" iconIndex="0"  iconClass="combox_ico_select f-absolute">';
		        for (var i = 0; i < length; i++) {
		            var option = '<option>' + arr[i] + '</option>'
		            select += option;
		         }
		         select += '</select>';
		         $select = $(select);
		         return $select;
    	  }}
    	  
	]);
$("#allIds").click(function() {
		var $Ids = $("input[name='instanceIds']");
		$Ids.attr("checked",$("#allIds").attr("checked"));
 	});

$("input[name='instanceIds']").click(function() {
	   	var param = $(this).attr("checked");
	   	if(param == false) {
		   	$("#allIds").attr("checked", false);
	   	}
})
$("#searchInst").bind("click", function(){
	$("#nameoripvalue").val($.trim($("#nameoripvalue").val()));
  	var val = $("#nameoripvalue").val();
  	if( val == '请输入条件进行搜索' ){
  		val = "";
  	}
  	$("#nameoripvalue").val(val);
	var data = $('#formInst').serialize();
	var url = "offlinetime-instance.action?"+data;
    openViewPage(url,null);

});
$("#sp_inst_delete").bind("click", function() {
	var allcheckboxs = $("input[name='instanceIds']:checked");
	if(!haveSelect(allcheckboxs,toast)) {
		return;
	}
	var ajaxParam = $("#formInst").serialize();
	$.ajax( {
		type : "post",
		url : "offlinetime-instance!deleteInstance.action",
		data : ajaxParam,
		success : function(data, textStatus) {
			toast.addMessage("移除成功。");
			deleteInstances();
		}
	});
});

function deleteInstances() {
	var instanceIds = document.getElementsByName("instanceIds");
	var delIndex = new Array();
	var index = 0;
	for (var i = 0 ; i < instanceIds.length; i++) {
		if (instanceIds[i].checked) {
			delIndex[index] = i + "";
			index++;
		}
	}
	var id = "${offlineTimeId}";
	var count = parseInt(instanceIds.length) - parseInt(index);
	modifiableCount(id,count);
	gpInst.delRow(delIndex);
}
function haveSelect(obj,toast) {
	if(obj.length == 0) {
		toast.addMessage("请至少选择一条记录。");
		return false;
	}
	return true;
}

$("#sp_inst_add").bind("click", function() {
	var ids=new StringBuilder();
	var allcheckboxs = $("input[name='instanceIds']");
	for(var i=0;i<allcheckboxs.length;i++)
	{
        var notid=$(allcheckboxs[i]).attr("value");
        ids.Append(notid)
        if((i+1) != allcheckboxs.length)
        ids.Append(",");
	}
	var instanceRela=ids.ToString();
	//alert(instanceRela);
	var url = "offlinetime-instance!updateInstanceForm.action?offlineTimeId=${offlineTimeId}&instanceRela="+instanceRela;
	winOpen({url:url,width:830,height:670,name:'updateInstance'})
});
function StringBuilder()
{
    this.buffer = new Array();
}
StringBuilder.prototype.Append = function Append(string)
{
    if ((string ==null) || (typeof(string)=='undefined'))
        return;
    if ((typeof(string)=='string') && (string.length == 0))
        return;
    this.buffer.push(string);
}
StringBuilder.prototype.ToString = function ToString()
{
    return this.buffer.join("");
}
SimpleBox.renderAll();
$('.combobox').parent().css('position', '');
});
</script>
</body>
</html>