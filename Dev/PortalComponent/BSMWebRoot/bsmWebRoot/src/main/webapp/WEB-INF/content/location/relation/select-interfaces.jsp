<!-- WEB-INF\content\location\relation\select-interfaces.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base target="_self">
<%@ include file="/WEB-INF/common/meta.jsp" %>
<%@ include file="/WEB-INF/common/loading.jsp" %>
<title>选择链路</title>
<link href="${ctxCss}/public.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/UIComponent.css" rel="stylesheet" type="text/css">
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css">
<link href="${ctx}/css/validationEngine.jquery.css" rel="stylesheet" type="text/css" media="screen" title="no title" charset="utf-8" />
<script src="${ctx}/js/jquery-1.4.2.min.js" type="text/javascript"></script>
<script src="${ctx}/js/jquery.validationEngine-cn.js" type="text/javascript"></script>
<script src="${ctx}/js/jquery.validationEngine.js" type="text/javascript"></script>
<script src="${ctx}/js/component/cfncc.js"></script>
<script src="${ctx}/js/component/tabPanel/tab.js"></script>
<script src="${ctx}/js/component/gridPanel/grid.js"></script>
<script src="${ctx}/js/component/gridPanel/indexgrid.js"></script>
<script type="text/javascript" src="${ctx}/js/component/gridPanel/page.js"></script>
<script type="text/javascript" src="${ctx}/js/component/menu/menu.js"></script>
<script type="text/javascript" src="${ctx}/js/component/comm/winopen.js"></script>
<script type="text/javascript" src="${ctx}/js/monitor/Util.js"></script>
<!-- 
<script type="text/javascript" src="${ctx}/js/monitor/ResourceUtil.js"></script> -->
<script type="text/javascript" src="${ctx}/js/component/toast/Toast.js"></script>
<script type="text/javascript" src="${ctx}/js/component/popwindow/popwin.js"></script>
<script type="text/javascript" src="${ctx}/js/component/combobox/simplebox.js"></script>
<script src="${ctxJs}/jquery.blockUI.js" type="text/javascript"></script>
<script type="text/javascript">

	var id="";
	var name="";
	var leftIp="";
	var rightIp="";
	var leftName="";
	var rightName="";
	//表单验证
	$(document).ready(function() {
		var toast = new Toast({position:"CT"});
		
		$("#closeId").click(function (){
			window.close();
		});
		
		$("#submit").click(function (){
			if($("input[name=linkId]:checked").length<=0){
				toast.addMessage("请已选资源");
				return;				
			}
			window.returnValue={id:id, name:name,leftIp:leftIp,rightIp:rightIp,leftName:leftName,rightName:rightName};
			window.close();
		});
		
		$("#cancel").click(function(){
			window.close();
		});
		
		resize();
	});
	// 重置页面大小
	function resize(){
		window.dialogHeight=(document.body.scrollHeight+10)+"px";
		window.dialogWidth=(document.body.scrollWidth+10)+"px";
	}
</script>
</head>

<body bgcolor="black">

<page:applyDecorator name="popwindow"  title="选择链路">
	
	<page:param name="width">510px</page:param>
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
		
	<div class="" style="heigth:460px;margin:5px;">			
		<div class="left-n">
		  <div class="bold">待选链路</div>
		  <div style="overflow:hidden;" >
			<form id="searchCondition">
				<select name="searchTypeWait" id="selectId">
					  		<option value="leftIp">源IP</option>
					  		<option value="rightIp">目的IP</option>
					  		<option value="leftName">源接口</option>
					  		<option value="rightName">目的接口</option>
				</select><span>：</span>
				<span>
					  <input type="text" name="inputVal" id="inputVal"/>
				</span>
					  <span class="ico ico-select" id="searchWaitId"></span>
				<input type="hidden" id="sortIdHidden" name="sortIdHidden" value="ip" />
				<input type="hidden" id="sortColIdHidden" name="sortColIdHidden" value="ASC" />
				<input type="hidden" id="pageIdHidden" value="<s:property value='pageData.pageIndex'/>" />
			</form>	
			</div>
		  <div class="gray-border">
		  	<page:applyDecorator name="indexcirgrid">  
		     <page:param name="id">options</page:param>
		     <page:param name="height">400px</page:param>
		     <page:param name="width">485px</page:param>
		     <page:param name="linenum">${pageData.pageSize}</page:param>
		     <page:param name="tableCls">grid-gray</page:param>
		     <page:param name="gridhead">[{colId:"linkName", hidden:true},{colId:"hidleftIp", hidden:true},{colId:"hidleftName", hidden:true},{colId:"hidrightIp", hidden:true},{colId:"hidrightName", hidden:true},{colId:"linkId", text:""},{colId:"leftIp", text:"源IP"},{colId:"leftName", text:"源接口"},{colId:"rightIp", text:"目的IP"},{colId:"rightName", text:"目的接口"}]</page:param>
		     <page:param name="gridcontent">${interfaces }</page:param>
		    </page:applyDecorator>
		    <div id="pageover" style="overflow:hidden;width:100%" ></div>
		  </div>
		</div>
	</div>
	</page:param>
</page:applyDecorator>

</body>
</html>
<script type="text/javascript">
	var gp;
	var toast  = null;
	var pageCount = '<s:property value="pageCount" />';
	//表单验证
	$(document).ready(function() {

		//toast = new Toast({position:"CT"});
		gp = new GridPanel({id:"options",
			width:435,
			columnWidth:{linkId:35,leftIp:100,leftName:100,rightIp:100,rightName:100},
			plugins:[SortPluginIndex],
			sortColumns:[],
			sortLisntenr:function($sort){
				$.blockUI({message:$('#loading')});
				//var resId = "${resId}";
				var locationId = "${location.locationId}";
					var sort=$sort.colId;
		       	    var sortCol=$sort.sorttype;
					if(sortCol=="up"){
						sortCol="ASC";
					}else{
						sortCol="DESC";
					}
		       	 	$("#sortIdHidden").val(sort);
		    		$("#sortColIdHidden").val(sortCol);
		    		var page = $("#pageIdHidden").val();
		       	 	if(null == page || "" == page){
		           	    page = '<s:property value="pageData.pageIndex" />';
		           	}
				
		       	 var result = $("#searchCondition").serialize()+"&pageData.pageIndex=" + page  + "&orderProperty=" + sort + "&orderType=" + sortCol;
		       	 
		         var url = "${ctx}/location/relation/resource!selectInterfacesJson.action";
			            $.ajax({
			                type: "POST",
			                dataType: 'json',
			                data:result,
			             	url:url,
			                success: function(data, textStatus) {
			        			grid.loadGridData(data.interfaces);
								SimpleBox.renderAll();
			        			$('.combobox').parent().css('position', ''); 
			        			$.unblockUI();
			                }
			            });
			           
			} 
			},{gridpanel_DomStruFn:"index_gridpanel_DomStruFn",gridpanel_DomCtrlFn:"index_gridpanel_DomCtrlFn",gridpanel_ComponetFn:"index_gridpanel_ComponetFn"});
		gp.rend([{index:"leftIp",fn:function(td){
				td.value.hidleftIp=td.html;	
	    	return td.html==""?"":"<span title='"+td.html+"' style='width:100%;'>"+td.html+"</span>";

		}},{index:"leftName",fn:function(td){
				td.value.hidleftName=td.html;	
	    	return td.html==""?"":"<span title='"+td.html+"' style='width:100%;'>"+td.html+"</span>";

		}},{index:"rightIp",fn:function(td){
				td.value.hidrightIp=td.html;	
	    	return td.html==""?"":"<span title='"+td.html+"' style='width:100%;'>"+td.html+"</span>";

		}},{index:"rightName",fn:function(td){
				td.value.hidrightName=td.html;	
	    	return td.html==""?"":"<span title='"+td.html+"' style='width:100%;'>"+td.html+"</span>";

		}},{index:"linkId",fn:function(td){
			return td.html==""?"":$('<input type="radio" name="linkId">').click(function(){
				id=td.html;
				name=td.value.linkName;
				leftIp=td.value.hidleftIp;
				rightIp=td.value.hidrightIp;
				leftName=td.value.hidleftName;
				rightName=td.value.hidrightName;
			});
		}}]);
		// 设置左的宽度
		$(".left-n").width(485);
		
		//$("input[name='linkId']").

		$("#searchWaitId").click(function(){
			$.blockUI({message:$('#loading')});
			var result = $("#searchCondition").serialize();
			var url = "${ctx}/location/relation/resource!selectInterfacesJson.action";
		            $.ajax({
		                type: "POST",
		                dataType: 'json',
		                data:result,
		             	url:url,
		                success: function(data, textStatus) {
							gp.loadGridData(data.interfaces);
							page.pageing(data.pageCount,1);
							SimpleBox.renderAll();
							$('.combobox').parent().css('position', ''); 
							$.unblockUI();
		                }
		            });
			});
		
		
	});


	var page = new Pagination({
	    applyId: "pageover",
	    listeners: {
	    pageClick: function(page) {
		if(page == ""){
    		return;
    		}
		$.blockUI({message:$('#loading')});
		$("#pageIdHidden").val(page);
	    var sort=$("#sortIdHidden").val();
	    var sortCol=$("#sortColIdHidden").val();
	    var result = $("#searchCondition").serialize()+"&pageData.pageIndex=" + page  + "&orderProperty=" + sort + "&orderType=" + sortCol;
	    var url = "${ctx}/location/relation/resource!selectInterfacesJson.action";
	            $.ajax({
	                type: "POST",
	                dataType: 'json',
	        		data:result, 
	        		url: url,
	                success: function(data, textStatus) {
	    				gp.loadGridData(data.interfaces);
	    				SimpleBox.renderAll();
						$('.combobox').parent().css('position', ''); 
						$.unblockUI();
	              },error:function(e){
	              	alert(e.responseText);
	              	}
	            });
	        }
	    }
	});
	page.pageing(pageCount,1);
	SimpleBox.renderAll();
		$('.combobox').parent().css('position', ''); 
</script>