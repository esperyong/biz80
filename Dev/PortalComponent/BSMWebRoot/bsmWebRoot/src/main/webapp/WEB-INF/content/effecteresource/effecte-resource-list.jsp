<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- 
	@page : 时间告警压缩列表页.jsp 
	@auther : weiyi@rd.mochasoft.com.cn
--%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>

<div style="color:black;" id="dataListDiv">
   <page:applyDecorator name="indexcirgrid">
      <page:param name="id">tableId</page:param>
      <page:param name="height">560px</page:param>
      <page:param name="width">98%</page:param>
      <page:param name="tableCls">roundedform</page:param>
      <page:param name="lineHeight">26px</page:param>
      <page:param name="gridhead">[	 {colId:"resInstanceId", text:"<input type=\"checkbox\">"}
      								,{colId:"resIpAddress", text:"根源设备IP "}
      								,{colId:"resInstanceName", text:"根源设备名称"}
      								,{colId:"resInstanceCategory", text:"设备类型"}
      								,{colId:"effecteInstance", text:"影响资源查看"}
      							]</page:param>
      <page:param name="gridcontent">${displayVO.content}</page:param>
    </page:applyDecorator>
<div id="page"></div>
</div>
	
	
	
<script type="text/javascript">
var pageCount = Number('${pageCount}');
var effecteResPanel = undefined ;
var columnW;
columnW = {resInstanceId:"5",resIpAddress:"20",resInstanceName:"35",resInstanceCategory:"20",effecteInstance:"20"};
var gp = new GridPanel({id:"tableId",
	columnWidth:columnW,
	unit: "%",
	sortLisntenr:function($sort){
    }},
    {gridpanel_DomStruFn:"index_gridpanel_DomStruFn",gridpanel_DomCtrlFn:"index_gridpanel_DomCtrlFn",gridpanel_ComponetFn:"index_gridpanel_ComponetFn"});
gp.rend([{index:"resInstanceId",fn:function(td){
		if(td.html){
		var $r = $("<input type=\"checkbox\" value="+td.html+" />");
		return $r;}
}},
{index:"resIpAddress",fn:function(td){
	if(td.html){
		var ips = td.html.split(",");
		var $r ;
		if(ips.length > 1 ){
			$r = $("<select id='select_"+td.rowIndex+"'></select>");
			for(var index=0; index < ips.length ; index++){
				$r.append("<option value=\"" + ips[index] + "\" >" + ips[index] + "</option>");
			}
		}else{
			$r = $("<span title=\""+ips[0]+"\">"+ips[0]+"</span>");
		}
		return $r;}	
}},
{index:"resInstanceName",fn:function(td){
	if(td.html){
		var str = td.html.split(",");
		var name=str[0];
		var id=str[1];
		//alert("isSystemAdmin="+isSystemAdmin+"isAdmin"+isAdmin);
		var $r = $("<span title='"+name+"' style=\"cursor:"+ ( isSystemAdmin===true ? "pointer" : "default") + ";\">"+name+"</span>");
		if(openEditEffecteRelaWindow){
				if(isSystemAdmin===true){
						$r.click(function(){
								openEditEffecteRelaWindow(id,false);
						});
				}
		}
		return $r;}	
}},
{index:"effecteInstance",fn:function(td){
	if(td.html){
		var $r = $("<span class=\"gray-btn-l\" ><span class=\"btn-r\"><span class=\"btn-m\"><a>查看</a></span></span></span>");
		$r.click(function(event){
			if(effecteResPanel){
				effecteResPanel.close();
				effecteResPanel = undefined;
			}
			var url  = path+"/effecteresource/effecteRes!effecteDevices.action?queryVO.isAffectDevice=true&effecteResRela.rootDevice="+td.html;
			
			effecteResPanel = new winPanel({url:url
				,x: getPanelX()
				,y:event.pageY
				,width:600
				,isautoclose: true
				,closeAction: "close"
				, listeners:{ closeAfter:function(){
						//alert("afterClose");
			 			effecteResPanel = null; 
						}
					, loadAfter:function(){ 
//						alert("loadAfter"); 
						} 
					} }
				,{winpanel_DomStruFn:"blackLayer_winpanel_DomStruFn" }); 
		})
		return $r;}	
}}]);
var page = new Pagination({applyId:"page",listeners:{
    pageClick:function(page){
		 $("#currentPage").val(page);
		 var ajaxParam = $("#effecteRelaForm").serialize();
		 $.ajax({
			   type: "POST",
			   dataType:'json',
			   url: path+"/effecteresource/effecteRes!allRootDevicesPage.action",
			   data: ajaxParam,
			   success: function(data, textStatus){
				 	if(data.displayVO&&data.displayVO.content){
				 		gp.loadGridData(data.displayVO.content);
					}  
			   }
		 });
    }
}});
page.pageing(pageCount,1);
$(".roundedform-top").find("input","[colId=resInstanceId]").click(function(){
	$(".roundedform-content").find("input","[colId=resInstanceId]").attr("checked",$(this).attr("checked"));
});
$(".roundedform-content").find("input","[colId=resInstanceId]").click(function(){
	if(!$(this).attr("checked")){
		$(".roundedform-top").find("input","[colId=resInstanceId]").attr("checked",$(this).attr("checked"));
	}
});
SimpleBox.renderAll("effecteresource-main-right");
function getPanelX(){
	var pageWidth = $(document).width();
	return (pageWidth - 600)/2;
}

</script>