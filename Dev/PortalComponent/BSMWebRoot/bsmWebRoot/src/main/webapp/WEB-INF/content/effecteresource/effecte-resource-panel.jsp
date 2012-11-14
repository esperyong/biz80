<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- 
	@page : 时间告警压缩弹出页.jsp 
	@auther : weiyi@rd.mochasoft.com.cn
--%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
影响资源  
<page:applyDecorator name="indexcirgrid">
      <page:param name="id">panel_table${effecteResRela.rootDevice}</page:param>
      <page:param name="height">300px</page:param>
      <page:param name="tableCls"></page:param>
      <page:param name="gridhead">[{colId:"resInstanceName", text:"显示名称"},{colId:"resIpAddress", text:"设备IP"},{colId:"resInstanceCategory", text:"资源类型"},{colId:"maintainer", text:"维护人"}]</page:param>
      <page:param name="gridcontent">${displayVO.content}</page:param>
</page:applyDecorator>
<script type="text/javascript">
var panel_table = new GridPanel({id:"panel_table"+"${effecteResRela.rootDevice}",
	columnWidth:{resInstanceName:"25",resIpAddress:"25",resInstanceCategory:"25",maintainer:"25"},
	unit: "%"
	},
    {gridpanel_DomStruFn:"index_gridpanel_DomStruFn"
        ,gridpanel_DomCtrlFn:"index_gridpanel_DomCtrlFn"
        ,gridpanel_ComponetFn:"index_gridpanel_ComponetFn"}
   );
	panel_table.rend([{index:"resInstanceName",fn:function(td){
			if(td.html){
			var str = td.html.split(",");
			return str[0];}
		}},
	{index:"resIpAddress",fn:function(td){
		if(td.html){
			var ips = td.html.split(",");
			var $r ;
			if(ips.length > 1 ){
				$r = $("<select id='P_select_"+td.rowIndex+"'></select>");
				for(var index=0; index < ips.length ; index++){
					$r.append("<option value=\"" + ips[index] + "\" >" + ips[index] + "</option>");
				}
			}else{
				$r = $("<span title=\""+ips[0]+"\">"+ips[0]+"</span>");
			}
			return $r;}	
	}}
	]);
	SimpleBox.renderAll();
</script>