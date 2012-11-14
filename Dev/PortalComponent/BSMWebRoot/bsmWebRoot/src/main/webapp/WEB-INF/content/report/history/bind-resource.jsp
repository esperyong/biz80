<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<input type="hidden" id="orderField" name="analysisView.compositor" value="<s:property value="@com.mocha.bsm.report.vo.AnalysisVO@S_COMPOSITOR_DISPLAYNAME" />">
<input type="hidden" id="orderType" name="analysisView.order" value='<s:property value="@com.mocha.bsm.report.vo.AnalysisVO@ASC" />'>
<input type="hidden" id="pageSize" name="analysisView.pageSize" value="15">
<input type="hidden" id="pageIndex" name="analysisView.pageNumber" value="1">
<div  style="width:98%;margin:0 auto;">
<page:applyDecorator name="indexgrid">  
   <page:param name="id">resourceinstancegrid</page:param>
   <page:param name="height">380px</page:param>
   <page:param name="tableCls">grid-blue</page:param>
   <page:param name="gridhead">${head}</page:param>
   <page:param name="gridcontent">${body}</page:param>
   <page:param name="linenum">15</page:param>
   <page:param name="lineHeight">20px</page:param>
</page:applyDecorator>
</div>
<div id="page" style="width:100%"/>
<script language="javascript">
var config = {
	columnWidth:${column},
	render:[{
   		index:"allCheckId",
   		fn:function(td){
   			var $font;
   			if(td.html != ""){
   				if(map.get(td.html) != null){
   					if($("#isAllSelect").val() != "true"){
   						$font = $("<input type='checkbox' checked name='analysisView.resources' value='" + td.html + "'>");
					}else{
						$font = $("<input type='checkbox' name='analysisView.resources' value='" + td.html + "'>");
					}
   				}else{
   					$font = $("<input type='checkbox' name='analysisView.resources' value='" + td.html + "'>");
   					if('${analysisView.type}' == '<s:property value="@com.mocha.bsm.report.type.AnalysisType@Comparison" />'){
   						if (map.size()>=6)
   						{
   							$font = $("<input type='checkbox' name='analysisView.resources' value='" + td.html + "' disabled>");
   						}
   				     }
   				}
   				
				$font.bind("click", function() {
					bindAllChoose("checkall", "analysisView.resources");
					if($("#isAllSelect").val() == "true"){
						if($(this).attr("checked")){
							map.remove(td.html);
						}else{
							map.put(td.html,"");
						}
					}else{
						if($(this).attr("checked")){
							map.put(td.html,"");
						}else{
							map.remove(td.html);
						}
					}
					if('${analysisView.type}' == '<s:property value="@com.mocha.bsm.report.type.AnalysisType@Comparison" />'){
					 $("input[name='analysisView.resources']").each(function(){
						  //alert(map.size())
						if (map.size()<6)
						{
						   if ($(this).attr("disabled")==true)
						     { $(this).attr("disabled",""); }
						}
						else
						{
							if(map.get($(this).val()) == null)
							{$(this).attr("disabled","disabled");}
						}
					  });
						
					}
				});
			}
            return $font;
         }
   	}]
};
function createGridPanel() {
	$("#checkall").click(function() {
		allChoose("checkall", "analysisView.resources");
	});
	//alert($("#analysisView_type").val())
	var isShowCheckAll=true;
	if ($("#analysisView_type").val()=='<s:property value="@com.mocha.bsm.report.type.AnalysisType@Comparison" />')
	{
		isShowCheckAll=false;
	}
	
	var page = new Pagination({
		applyId : "page",
		showAll : isShowCheckAll,
		showAllCallback : function(data){
			map = new Map();
			$("#isAllSelect").val(data);
			setChecked($("#isAllSelect").val());
		},
		listeners : {
			pageClick : function(pageIndex) {
				$("#pageIndex").val(pageIndex);
				$.blockUI({message:$('#loading')});
				$.ajax({
					type : "POST",
					dataType : 'json',
					data : $("#addForm").serialize(),
					url : "${ctx}/report/history/historyAction!ajaxGridTable.action",
					success : function(data) {
						gp.loadGridData(data.body);
						
						setChecked($("#isAllSelect").val());
						
						bindAllChoose("checkall", "analysisView.resources");
						
						$.unblockUI();
					}
				});
			}
		}
	});
	var gp = new GridPanel({
				id : "resourceinstancegrid",
				unit : "%",
				columnWidth : config.columnWidth,
				plugins : [SortPluginIndex],
				sortColumns : ${sortColumn},
				sortLisntenr : function($sort) {
					$("#orderField").val($sort.colId);
					if ($sort.sorttype == "up") {
						$("#orderType").val('<s:property value="@com.mocha.bsm.report.vo.AnalysisVO@ASC" />');
					} else {
						$("#orderType").val('<s:property value="@com.mocha.bsm.report.vo.AnalysisVO@DESC" />');
					}
					$.blockUI({message:$('#loading')});
					$.ajax({
						type : "POST",
						dataType : 'json',
						data : $("#addForm").serialize(),
						url : "${ctx}/report/history/historyAction!ajaxGridTable.action",
						success : function(data) {
							gp.loadGridData(data.body);
							
							page.pageing(${pageCount}, $("#pageIndex").val());
							//page.pageing(data.pageCount, 1,eval($("#isAllSelect").val()));
							
							setChecked($("#isAllSelect").val());						
							
							$.unblockUI();
						}
					});
				}
			}, {
				gridpanel_DomStruFn : "index_gridpanel_DomStruFn",
				gridpanel_DomCtrlFn : "index_gridpanel_DomCtrlFn",
				gridpanel_ComponetFn : "index_gridpanel_ComponetFn"
			});
	if(config.render){
		gp.rend(config.render);
	}
	
	//page.pageing(${pageCount}, 1);
	page.pageing(${pageCount}, 1, eval($("#isAllSelect").val()));
	
	setChecked($("#isAllSelect").val());
	
	bindAllChoose("checkall", "analysisView.resources");
	ifComparison();
}

function setChecked(isAllSelect){
	if(isAllSelect == "true"){
		$("#checkall").attr("checked",true);
		$("input[name='analysisView.resources']").each(function(){
			if(map.get($(this).val()) != null){
				$(this).attr("checked",false);
				$("#checkall").attr("checked",false);
			}else{
				$(this).attr("checked",true);
			}
		});
	}else{
		$("#checkall").attr("checked",false);
		$("input[name='analysisView.resources']").each(function(){
			if(map.get($(this).val()) != null){
				$(this).attr("checked",true);
			}else{
				$(this).attr("checked",false);
			}
		});
	}
}
function ifComparison(){
if('${analysisView.type}' == '<s:property value="@com.mocha.bsm.report.type.AnalysisType@Comparison" />'){
			$("#checkall").hide(); //去掉全选按钮
			$("#max6").show(); //显示最多选择6个
			$("input[name='analysisView.resources']").each(function(){
			//alert(map.size())
						if (map.size()>=6)
						{
							if(map.get($(this).val()) == null)
							{$(this).attr("disabled","disabled");
						    }
						}
						else
						{ 
						     if ($(this).attr("disabled")==true)
						     { $(this).attr("disabled",""); }
						 }
						
					  });
	}
}
</script>