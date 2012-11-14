<!-- WEB-INF\content\location\define\select-location.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>选择脚本</title>
<link href="${ctxCss}/public.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/UIComponent.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/master.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/validationEngine.jquery.css" rel="stylesheet" type="text/css" media="screen" title="no title" charset="utf-8" />
<script src="${ctxJs}/jquery-1.4.2.min.js" type="text/javascript"></script>
<script src="${ctxJs}/jquery.validationEngine-cn.js" type="text/javascript"></script>
<script src="${ctxJs}/jquery.validationEngine.js" type="text/javascript"></script>
<script src="${ctxJs}/jquery.select.js"></script>
<script src="${ctxJs}/component/cfncc.js"></script>
<script src="${ctxJs}/component/tabPanel/tab.js"></script>
<script src="${ctxJs}/component/gridPanel/grid.js"></script>
<script src="${ctxJs}/component/gridPanel/indexgrid.js"></script>
<script src="${ctxJs}/location/dialogResize.js"></script>
<script src="${ctxJs}/component/popwindow/popwin.js" ></script>
</head>
<body >
<page:applyDecorator name="popwindow"  title="选择脚本">
	
	<page:param name="width">500px</page:param>
	<page:param name="topBtn_index_1">1</page:param>
	<page:param name="topBtn_id_1">closeId</page:param>
	<page:param name="topBtn_css_1">win-ico win-close</page:param>
	
	<page:param name="bottomBtn_index_1">1</page:param>
	<page:param name="bottomBtn_id_1">submit</page:param>
	<page:param name="bottomBtn_text_1">确定</page:param>
	
	<page:param name="bottomBtn_index_2">2</page:param>
	<page:param name="bottomBtn_id_2">cancel</page:param>
	<page:param name="bottomBtn_text_2">取消</page:param>
	
	<page:param name="content">

		<div class="left-n">
		  <div class="bold" style="padding-top:10px;">待选脚本</div>
		  <div>
		      脚本库<span>：</span>
		      <select id="scriptRepository" style="width:150px">
		      		<s:iterator value="scriptRepositoryList"  id="list" status="index">
		      			<s:if test="#list.id == repositoryId">
		      				<option value="<s:property value="#list.id"/>" selected><s:property value="#list.name"/></option>
		      			</s:if>
		      			<s:else>
		      				<option value="<s:property value="#list.id"/>"><s:property value="#list.name"/></option>
		      			</s:else>
		      		</s:iterator>
		      </select>&nbsp;
		      
		      <!--<s:select id="scriptRepository" list="scriptRepositoryList" listKey="id" listValue="name" headerKey="-1" headerValue="请选择" style="width:100px"></s:select>&nbsp;-->
		            
		      脚本分类<span>：</span>
		      <select id="scriptGroup" style="width:150px">
		      		<s:iterator value="scriptGroupList"  id="list" status="index">
		      		<s:if test="#list.id == groupId">
		      				<option value="<s:property value="#list.id"/>" selected><s:property value="#list.name"/></option>
		      			</s:if>
		      			<s:else>
		      				<option value="<s:property value="#list.id"/>"><s:property value="#list.name"/></option>
		      			</s:else>
		      		</s:iterator>
		      </select>
		      <!--<s:select id="scriptGroup" list="{}" headerKey="-1" headerValue="请选择" style="width:100px"></s:select>-->
		  </div>
		  <div class="gray-border">
		  	<page:applyDecorator name="indexcirgrid">  
		     <page:param name="id">options</page:param>
		     <page:param name="width">440px</page:param>
		     <page:param name="height">200px</page:param>
		     <page:param name="tableCls">grid-gray</page:param>
		     <page:param name="gridhead">[{colId:"id", hidden:true},{colId:"remark", text:""},{colId:"name", text:"脚本名称"},{colId:"filePath", text:"脚本路径"}]</page:param>
		     <page:param name="gridcontent">${responseInfo}</page:param>
		    </page:applyDecorator>
		  </div>
		</div>
	</page:param>
</page:applyDecorator>

<script type="text/javascript">
	var scriptId = "";
	var scriptTemplateId = "<s:property value='scriptTemplateId'/>";
	scriptId = scriptTemplateId;
	var clear = "[]";
	$(document).ready(function () {
		
		var options = new GridPanel({id:"options",
			width:470,
			columnWidth:{remark:30,name:100,filePath:310},
			plugins:[SortPluginIndex],
			sortColumns:[{index:"name",sortord:"0",defSorttype:"up"}],
			sortLisntenr:function($sort){
				$.ajax({
					cache: false,
					data: "groupId="+$("#scriptGroup").val()+"&sortType="+$sort.sorttype,
					dataType: "json",
					type: "POST",
					url: "${ctx}/scriptmonitor/repository/scriptMonitor!queryScriptTemplate.action",
					success: function(data){
						var responseInfo = data.responseInfo;
						options.loadGridData(responseInfo);
					}
				});
			}
			},{gridpanel_DomStruFn:"index_gridpanel_DomStruFn",gridpanel_DomCtrlFn:"index_gridpanel_DomCtrlFn",gridpanel_ComponetFn:"index_gridpanel_ComponetFn"});
		
		options.rend([{index:"remark",fn:function(td){
			if(td.value.id == scriptTemplateId){
				return td.value.id==""?"":$('<input type="radio" name="scriptId" checked/>').click(function(){
					scriptId=td.value.id;
				});
			}else{
				return td.value.id==""?"":$('<input type="radio" name="scriptId" />').click(function(){
					scriptId=td.value.id;
				});
			}
		}},{index:"filePath",fn:function(td){
			return td.value.id==""?"":$("<span title='"+td.html+"' >"+td.html+"</span>");
		}}]);

		// 设置左的宽度
		$(".left-n").width(485);
		
		$("#cancel,#closeId").click(function (){
			window.returnValue=scriptId;
			window.close();
		});
		
		$("#submit").click(function (){
			if(!scriptId){
				var _information = new information({text:"请选择一条数据。"});
				_information.show();
				return;
			}
			window.returnValue=scriptId;
			window.close();
		});
		$("#scriptRepository").change(function(){
			var repositoryId = $("#scriptRepository option:selected").val();
			var defaultValue = "<option value='-1'>无数据</option>";
			if(repositoryId!=-1){
				$.ajax({
					cache: false,
					data: "repositoryId="+repositoryId,
					dataType: "json",
					url: "${ctx}/scriptmonitor/repository/scriptMonitor!queryScriptGroup.action",
					success: function(data){
						$("#scriptGroup").clearAll().addOptions(data.scriptGroupList,"id","name");
						scriptGroupFun();
					}
				});
			}else{
				$("#scriptGroup").clearAll().append(defaultValue);
				options.loadGridData(clear);
			}
		});
		
		function scriptGroupFun(){
			var groupId = $("#scriptGroup option:selected").val();
			if(groupId!=-1){
				$.ajax({
					cache: false,
					data: "groupId="+groupId,
					dataType: "json",
					type: "POST",
					url: "${ctx}/scriptmonitor/repository/scriptMonitor!queryScriptTemplate.action",
					success: function(data){
						var responseInfo = data.responseInfo;
						options.loadGridData(responseInfo);
					}
				});
			}else{
				options.loadGridData(clear);
			}
		}
		$("#scriptGroup").change(function(){
			scriptGroupFun();
		});
		scriptGroupFun();
	});
</script>
</body>
</html>