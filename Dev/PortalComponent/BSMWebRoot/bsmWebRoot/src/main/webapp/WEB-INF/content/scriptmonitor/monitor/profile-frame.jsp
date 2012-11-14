<%--  
 *************************************************************************
 * @source  : profile-frame.JSP
--%>
<!-- WEB-INF\content\scriptmonitor\repository\script-repository.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<%@ page import="com.mocha.bsm.script.monitor.vo.ProfilePagedQuery" %>
<div id="loading" class="loading for-inline" style="display:none;">
	<span class="vertical-middle loading-img for-inline"></span><span class="suojin1em">正在执行，请稍候...</span> 
</div>
<div class="tab-content-searchlist">
	<s:form id="formId">
    <span id="refreshSptMonitor"	class="black-btn-l f-right"><span class="btn-r"><span class="btn-m"><a >刷新</a></span></span></span>
    <span id="cancelSptMonitor"		class="black-btn-l f-right"><span class="btn-r"><span class="btn-m"><a >取消监控</a></span></span></span>
    <span id="startSptMonitor"		class="black-btn-l f-right"><span class="btn-r"><span class="btn-m"><a >开启监控</a></span></span></span>
    <span id="delSptMonitor"		class="black-btn-l f-right"><span class="btn-r"><span class="btn-m"><a >删除监控</a></span></span></span>
    <span id="addSptMonitor"		class="black-btn-l f-right"><span class="btn-r"><span class="btn-m"><a >添加监控</a></span></span></span>
    </s:form>
 <div name="isSearch">   
    <span class="txt-white">监控脚本总数：<span id="activedCount">${profileList.activedCount}</span></span>    
    <select id="searchProp" name="searchProp">
         <option value="<%=ProfilePagedQuery.NAME_PROP%>">脚本名称</option>
         <option value="<%=ProfilePagedQuery.IP_PROP%>">执行脚本IP</option>
    </select>
    <input type="text" id="searchValue" name="searchValue" value=""><span id="searchButton" class="ico"></span>
</div>
</div>
	
	<input type="hidden" id="sortIdHidden" name="sortIdHidden" value="" />
   	<input type="hidden" id="sortColIdHidden" name="sortColIdHidden" value="" />
	<input type="hidden" id="pageIdHidden" name="pageIdHidden" value="1" />
   	
    <page:applyDecorator name="indexcirgrid">  
          <page:param name="id">tableMonitor</page:param>
          <page:param name="width">100%</page:param>
          <page:param name="height">100%</page:param>
          <page:param name="tableCls">grid-black</page:param>
          <page:param name="lineHeight">23px</page:param>
          <page:param name="gridhead">
          [{colId:"id", hidden:true},
           {colId:"actived", hidden:true},
           {colId:"domainId", text:"<input type='checkbox' name='checkAll' id='checkAllId' style='cursor:pointer'/>"},
           {colId:"activedImg", text:""},           
           {colId:"state", text:"状态"},
           {colId:"name", text:"脚本名称"},
           {colId:"serverIp", text:"脚本服务器IP"},           
           {colId:"frequency", text:"执行频度"},
           {colId:"latelyTime", text:"最近采集时间"},
           {colId:"report", text:"报表"},
           {colId:"event", text:"事件一览"},
           {colId:"execute", text:"执行"},
           {colId:"oper", text:"操作"}]</page:param>
       	  <page:param name="gridcontent">${datas}</page:param>
    </page:applyDecorator>	 
     
	<div id="pageScript"></div>
	
<script>
var canEdit = ${canEdit};
	$(document).ready(function(){
		var $addSptMonitor =  $("#addSptMonitor");
		var $delSptMonitor = $("#delSptMonitor");
		var $startSptMonitor = $("#startSptMonitor");
		var $cancelSptMonitor = $("#cancelSptMonitor");
		isVisible($addSptMonitor,$delSptMonitor,$startSptMonitor,$cancelSptMonitor);
		//添加监控
		$addSptMonitor.click(function(){
//			openProfileWinFun("${ctx}/scriptmonitor/repository/scriptPropfile!add.action?flag=add","addPropfile");
			returnValue=showModalWin("${ctx}/scriptmonitor/repository/scriptPropfile!add.action?flag=add");
			if(returnValue=="true"){
				$.loadPage($content,"${ctx}/scriptmonitor/repository/scriptPropfile!showProfiles.action",null,"",null);
			}
		});
		//删除监控
		$delSptMonitor.click(function(){
			var hasMonitoredProfile = false;
			$("input[name=\"profileIds\"]:checked").each(function(i){
				if($(this).attr("actived") == "1"){
					hasMonitoredProfile = true;
				}
			});
			if(hasMonitoredProfile){
				var _information = new information({text:"脚本已被监控，不允许删除。"});
				_information.setConfirm_listener(function(){
					cleanBoxCheckedFun();
					_information.hide();
				});
				_information.show();
			}else{
				var _confirm = new confirm_box({text:"是否删除监控？"});
				_confirm.setConfirm_listener(function(){
					scriptMonitorFactory("!deleteMonitor.action");
					_confirm.hide();
				});
				_confirm.show();
			}
		});
		//开启监控
		$startSptMonitor.click(function(){
			scriptMonitorFactory("!startMonitor.action");
		});
		//取消监控
		$cancelSptMonitor.click(function(){
			scriptMonitorFactory("!cancelMonitor.action");
		});
		
		$.unblockUI();
	});
	
	function cleanBoxCheckedFun(){
		$("[name='profileIds']").removeAttr("checked");
		$("#checkAllId").removeAttr("checked");
	}
	function isVisible(){
		for(i=0;i<arguments.length;i++){
			var object = arguments[i];
			if(!canEdit){
				object.hide().attr("disabled","true");
			}else{
				object.show().removeAttr("disabled");
			}
		}
	}
	//刷新
	$("#refreshSptMonitor").click(function(){
		$.blockUI({message:$('#loading')});
		$.loadPage($content,"${ctx}/scriptmonitor/repository/scriptPropfile!showProfiles.action",null,"",null);
		$.unblockUI();
	});
	//查询
	$("#searchButton").click(function(){
		var pageNumber = 1;
		var url = "${ctx}/scriptmonitor/repository/scriptPropfile!handleConditionQuery.action";
		var searchValue = $("#searchValue").val();
		var searchProp = $("#searchProp").val();
		$.ajax({
            type: "POST",
            dataType: "json",
            data:"profileList.pageNumber=" + pageNumber + "&profileList.searchProperty=" + searchProp + "&profileList.searchValue=" + searchValue, 
            url:url,
            success: function(data){
            	var responseInfo = data.responseInfo;
            	var pageCount = data.profileList.pageCount;
    			scriptTemplateIds.loadGridData(responseInfo);
    			page.pageing(pageCount,1);
            }
        });
	});
	$("#checkAllId").click(function() {
			if($(this).attr("checked")) {
				$("[name='profileIds']").attr("checked",'true');//全选
			}else {
				$("[name='profileIds']").removeAttr("checked");//取消全选
			}
	  });
	
	var $scriptTemplateIds = $("input[name=\"scriptTemplateIds\"]");
	$("#checkAllId").click(function(){
		$scriptTemplateIds.attr("checked",this.checked);
	});
	$scriptTemplateIds.click(function(){
		$("#checkAllId").attr("checked",$scriptTemplateIds.length==$("input[name=\"scriptTemplateIds\"]:checked").length);
	});
    
	var scriptTemplateIds = new GridPanel({id:"tableMonitor",
		unit:"%",
		columnWidth:{
		domainId:5,
		activedImg:3,
		state:7,
		name:12,
		serverIp:14,
		frequency:12,
		latelyTime:15,
		report:7,
		event:11,
		execute:7,
		oper:8},
		plugins:[SortPluginIndex],
		sortColumns:[{index:"name",sortord:"0",defSorttype:"up"},{index:"serverIp",sortord:"1"},{index:"frequency",sortord:"2"},{index:"latelyTime",sortord:"3"}],
		sortLisntenr:function($sort){
			var sortCol=$sort.colId;
   	    	var sortType=$sort.sorttype;
			var pageNumber=$("#pageIdHidden").val();
			$("#sortIdHidden").val(sortType);
		 	$("#sortColIdHidden").val(sortCol);
			var url="${ctx}/scriptmonitor/repository/scriptPropfile!handlePageQuery.action";
			$.ajax({
                type: "POST",
                dataType: 'json',
                data:"profileList.pageNumber="+ pageNumber +"&profileList.sortType=" + sortType + "&profileList.sortColName=" + sortCol, 
                url:url,
                success: function(data, textStatus) {
                	var responseInfo = data.responseInfo;
        			scriptTemplateIds.loadGridData(responseInfo);
                }
            });
			
		}},
		{gridpanel_DomStruFn:"index_gridpanel_DomStruFn",gridpanel_DomCtrlFn:"index_gridpanel_DomCtrlFn",gridpanel_ComponetFn:"index_gridpanel_ComponetFn"});
	scriptTemplateIds.rend([{index:"domainId",fn:function(td){		
		if(td.value.id==""){
			$font=null;
		}else{
			$font = $('<input type="checkbox" name="profileIds" actived="'+td.value.actived+'" value="'+td.value.id+'">');
		}
		return $font;
	}},
	{index:"activedImg",fn:function(td){
		if(td.value.id==""){
			$font=null;
		}else{
			if(td.value.actived==1){
				$font = $("<span class=\"ico ico-play\" id=\"actived\" title=\"已开启监控\"></span>");
			}else if(td.value.actived==-1){
				$font = $("<span class=\"ico ico-stop\" id=\"actived\" title=\"未开启监控\"></span>");
			}
		}
		return $font;
	}},
	{index:"state",fn:function(td){
		if(td.value.id==""){
			$font=null;
		}else{
			if(td.value.actived==1){
				if(td.html=="GREEN_STATE"){
					$font = $("<span class=\"lamp lamp-green\" title=\"\"></span>");
				}else if(td.html=="RED_STATE"){
					$font = $("<span class=\"lamp lamp-red\" title=\"\"></span>");
				}else if(td.html=="GRAY_STATE"){
					$font = $("<span class=\"lamp lamp-gray\" title=\"\"></span>");
				}
			}else{
				$font = "";
			}
		}		
		return $font;
	}},
	{index:"report",fn:function(td){
		if(td.value.id==""){
			$font=null;
		}else{
			$font = $("<span class=\"ico ico-percent\" onclick=\"previewReport('"+td.value.id+"')\" title=\"点击查看报表\"></span>");
		}
		return $font;
	}},
	{index:"event",fn:function(td){
		if(td.value.id==""){
			$font=null;
		}else{
			$font = $("<span class=\"ico ico-percent\" onclick=\"previewEvent('"+td.value.id+"')\" title=\"点击查看事件一览\"></span>");
		}
		return $font;
	}},
	{index:"execute",fn:function(td){		
		if(td.value.id==""){
			$font=null;
		}else{
			$font = $("<span class=\"gray-btn-l\"><span class=\"btn-r\"><span class=\"btn-m\" id=\"execute\"><a>执行</a></span></span></span>");
			$font.bind("click",function(event){
				showModalWin("${ctx}/scriptmonitor/repository/scriptPropfile!executeScript.action?scriptProfile.profileId="+td.value.id);
			});
		}
		return $font;
	}},
	{index:"oper",fn:function(td){
		if(td.value.id==""){
			$font=null;
		}{
			$font = $("<span class=\"ico ico-t-right\"></span>");
			$font.bind("click",function(event){
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
				if(canEdit){
					if(td.value.actived==1){
						menu.addMenuItems([[
						  	{text:"取消监控",id:"cancel",listeners:{
		  						click:function(){
		  							scriptMonitorFactory("!cancelMonitor.action",td.value.id);
		  					}
		  					}},
		  					{text:"监控设置",id:"edit",listeners:{
			  					click:function(){
			  						showModalWin("${ctx}/scriptmonitor/repository/scriptPropfile!edit.action?scriptProfile.profileId="+td.value.id);
			  					}
			  				}}
						]]);
					}else if(td.value.actived==-1){
						menu.addMenuItems([[
										  	{text:"开启监控",id:"cancel",listeners:{
						  						click:function(){
						  							scriptMonitorFactory("!startMonitor.action",td.value.id);
						  					}
						  					}},
						  					{text:"监控设置",id:"edit",listeners:{
							  					click:function(){
							  						returnValue = showModalWin("${ctx}/scriptmonitor/repository/scriptPropfile!edit.action?scriptProfile.profileId="+td.value.id);
							  						if(returnValue=="true"){
							  							$.loadPage($content,"${ctx}/scriptmonitor/repository/scriptPropfile!showProfiles.action",null,"",null);
							  						}
							  					}
							  				}}
										]]);
					}
				}else{
					menu.addMenuItems([[
					  				{text:"监控设置",id:"edit",listeners:{
					  					click:function(){
					  						returnValue = showModalWin("${ctx}/scriptmonitor/repository/scriptPropfile!edit.action?scriptProfile.profileId="+td.value.id);
					  						if(returnValue=="true"){
					  							$.loadPage($content,"${ctx}/scriptmonitor/repository/scriptPropfile!showProfiles.action",null,"",null);
					  						}
					  					}
					  				}}
					  				]]);
				}
				menu.position(event.pageX,event.pageY);
			});
		}
		return $font;
	}}
	]);
	
	//分页 功能
	var pageCount = '<s:property value="profileList.pageCount" />';
	var page = new Pagination({
		applyId:"pageScript",
		listeners:{
		pageClick:function(page){
			var sortType=$("#sortIdHidden").val();
		    var sortCol=$("#sortColIdHidden").val();
			$("#pageIdHidden").val(page);
		    var url="${ctx}/scriptmonitor/repository/scriptPropfile!handlePageQuery.action";
		    $.ajax({
                type: "POST",
                dataType: 'json',
                data:"profileList.pageNumber="+ page +"&profileList.sortType=" + sortType + "&profileList.sortColName=" + sortCol, 
                url:url,
                //请求成功后的回调函数,date:返回的json串,testStatus:状态码
                success: function(data, textStatus) {
                	var responseInfo = data.responseInfo;
        			scriptTemplateIds.loadGridData(responseInfo);
                }
            });
		}
	}});
	page.pageing(pageCount,1);
	function openProfileWinFun(url,winName,fullScreen){
		var winOpenObj = {};
		winOpenObj.url= url;
		winOpenObj.name=winName;
		winOpenObj.width = '1000';
		winOpenObj.height = '650';
		winOpenObj.scrollable = false;
		winOpenObj.resizeable = false;
		modalinOpen(winOpenObj);
	}
	   function previewReport(profileId){
		   openProfileWinFun("${ctx}/scriptmonitor/repository/profileReport.action?profileId="+profileId,"showReport",true);
	   }
	   function previewEvent(profileId){
		   openProfileWinFun("${ctx}/scriptmonitor/repository/profileEvent.action?profileId="+profileId,"showEvent");
	   }
</script>