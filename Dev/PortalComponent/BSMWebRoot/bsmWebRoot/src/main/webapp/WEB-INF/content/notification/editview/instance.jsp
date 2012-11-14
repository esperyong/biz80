<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<%--
	告警对象页面.
	weiyi.
 --%>
 <script type="text/javascript">
 var query = {
		 category : '${query.queryCategory}',
		 type : '${query.queryType}',
		 ip : '${query.queryIp}',
		 name : '${query.queryName}',
		 userId:userId,
		 domainIds:domainId
 };
 function getUserId(){
	 return query.userId;
 }
 function getDomainId(){
	 return query.domainIds;
 }
 </script>
 <script type="text/javascript" src="${ctx}/js/component/combobox/simplebox.js"></script>
<div class="monitor" id="contentDIV">
<div class="panel-gray  table-noborder">
	<div class="panel-gray-top toplinegray">
		<span class=panel-gray-title>告警对象</span> 
	</div>
</div>

	<div class="select-lr">
    	<form id="notificationInstanceFilterForm">
    	<input name="query.userId" id="query_userId"  type="hidden"/>
    	<input name="query.domainIds" id="query_domainIds"   type="hidden"/>
			<span id="selectResCat" style="margin-bottom :4px;" class="h3">待选：</span>
			<span><s:select list="#{'IP':'IP地址','name':'资源名称'}" name="query.queryType" id="query_queryType"></s:select>
			<input name="query.queryValue" class="input-single" id="query_queryValue"/>
			<span title="点击进行搜索" class="ico" id="filterIns" ></span>
			</span>
		</form>
		<div class="kuangjia">
		<div >&nbsp;</div>
    	<div class="left">
        	<div class="h2 vertical-middle">
			  <table style="width:100%"><thead><tr><th><input type="checkbox" id="select_left_all">告警对象</th><th>IP地址</th><th>告警对象类型</th></tr></thead></table>
        	</div>
        	<div class="time" id="unselect_ins" style="height:200px;overflow-x: auto ;overflow-y: auto ;">
			 <table style="width:100%"><tbody>
        	<s:iterator value="leftIns" id="inc" status="s">
			  <tr insid="${inc.id}"  moduleId="${inc.moduleId}">
			  	<td class="ellipsis" width="91px;"><nobr><input type="checkbox">${inc.name}</nobr></td>
			  	<td style="width: 100px;" <%--class="ellipsis"--%> >${inc.ip}</td>
			  	<td class="ellipsis"><nobr>${inc.type}</nobr></td>
			  	</tr>
        	</s:iterator>
			  	</tbody></table>
			</div>
		</div>
		</div>
	    <div class="middle" style="margin:0px 8px">
	    	<span class="turn-right" id="instance-turn-right"></span> 
	    	<span class="turn-left" id="instance-turn-left"></span>
	    </div>
		<div class="kuangjia">
		<div ><%--已选告警对象： --%>&nbsp;</div>
	    <div class="right" style="overflow:hidden">
	    	<div class="h2 vertical-middle"> 
				<table style="width:100%"><thead><tr><th><input type="checkbox" id="select_right_all">告警对象</th><th>IP地址</th><th>告警对象类型</th></tr></thead></table>
	        </div>
	        <div class="time" id="selected_ins" style="height:200px;overflow-x: auto ;overflow-y: auto ;">
	        <table style="width:100%"><tbody>
	        <s:iterator value="rightIns" id="inc" status="s">
			  <tr insid="${inc.id}" moduleId="${inc.moduleId}">
			  	<td class="ellipsis" width="91px;"><nobr><input type="checkbox">${inc.name}</nobr></td>
			  	<td style="width: 100px;">${inc.ip}</td>
			  	<td class="ellipsis"><nobr>${inc.type}</nobr></td>
			  	</tr>
        	</s:iterator>
	        </tbody></table>
	        
	        </div>
		</div>
		</div>
	</div>
</div>
<script type="text/javascript" src="${ctxJs}/notification/editview/instance.js"></script>
<script type="text/javascript">
$(function(){
    var instArray = new Array();
    var insids = $("#selected_ins").find("tr[insid]");
    var insLength = insids.length;
    for(var i = 0 ; i < insLength  ;i++){
        var tr = $(insids[i]);
        instArray[i] = tr.attr("insid");
    }
    var l = instArray.length;
    var insids = $("#unselect_ins").find("tr[insid]");
    var insLength = insids.length;
    for(var i = 0 ; i < insLength  ;i++){
        var tr = $(insids[i]);
        instArray[l+i] = tr.attr("insid");
    }
    
    var selectArray = new Array();
    for(var i = 0 ; i < instArray.length  ;i++){
        selectArray[i] = {
        id:instArray[i],//下拉列表的id
        iconIndex:"0",//下拉列表的渲染图片的索引值
        iconClass:"combox_ico_select f-absolute",//下拉列表中的渲染图片样式
        iconTitle:"管理IP"
        };
        //alert(instArray[i]);
    }
        
    SimpleBox.renderTo(selectArray);
    //SimpleBox.renderAll();
    //SimpleBox.renderToUseWrap({selectId:'_resCategorys',wrapId:'selectResCat',maxHeight:'305px',contentId:'objcontent'});
});
</script>
