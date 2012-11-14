<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp"%>
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css"/>
<title>告警详细信息</title>
<script>
path = '${ctx}';
</script>
<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script src="${ctx}/js/jquery.validationEngine.js"></script>
<script src="${ctx}/js/jquery.validationEngine-cn.js"></script>
<script type="text/javascript" src="${ctx}/js/notification/comm.js"></script>
<script src="${ctx}/js/component/cfncc.js"></script>
<script src="${ctx}/js/component/gridPanel/grid.js"></script>
<script src="${ctx}/js/component/gridPanel/indexgrid.js"></script>
<script src="${ctx}/js/component/gridPanel/page.js"></script>
<script src="${ctx}/js/component/combobox/simplebox.js"></script>
</head>
<script type="text/javascript">
$(function() {
	$('#close_button').click(function(){
		window.close();
	})
})
</script>
<body onload="setBodyHeight();">
<page:applyDecorator name="popwindow"  title="告警详细信息">
 <page:param name="width">800px;</page:param>
 <page:param name="topBtn_index_1">1</page:param>
 <page:param name="topBtn_id_1">win-close</page:param>
 <page:param name="topBtn_css_1">win-ico win-close</page:param>
 <page:param name="topBtn_title_1">关闭</page:param>


 <page:param name="content">

<div class="whitebg" style="width:785px;" id="contentDiv">
  <fieldset class="blue-border-nblock">
    <legend>告警信息</legend>
    <ul class="fieldlist-n">
      <li> <span class="field-middle multi-line">告警内容：</span> <span class="" style="width:88%;"><s:property escape="false" value="notContent"/></span> </li>
      <li class="twocolumn left"> <span class="field-middle">级别&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;：</span> <span><s:if test="level=='' || null==level">-</s:if><s:else><s:property value="level"/></s:else></span> </li>
      <li class="twocolumn left"> <span class="field-middle">告警平台</span><span>：</span> <span><s:if test="platform=='' || null==platform">-</s:if><s:else><s:property value="platform"/></s:else></span> </li>
      <li class="clear"> <span class="field-middle">告警时间：</span> <span><s:if test="sendTime=='' || null==sendTime">-</s:if><s:else><s:property value="sendTime"/></s:else></span> </li>
      <s:if test="imageStatus==@com.mocha.bsm.notification.businessmodel.platform.PlatForm@STATUS_CONFIRM_UNATTENTION || imageStatus==@com.mocha.bsm.notification.businessmodel.platform.PlatForm@STATUS_CONFIRM_ATTENTION">
      	<li class="twocolumn left"> <span class="field-middle">确认人&nbsp;&nbsp;&nbsp;&nbsp;：</span> <span><s:if test="querenBody=='' || null==querenBody">-</s:if><s:else><s:property value="querenBody"/></s:else></span> </li>
      	<li class="twocolumn left"> <span class="field-middle">确认时间</span><span>：</span> <span><s:if test="querenTime=='' || null==querenTime">-</s:if><s:else><s:property value="querenTime"/></s:else></span> </li>
      </s:if>
    </ul>
  </fieldset>
  <fieldset class="blue-border-nblock">
    <legend>告警对象</legend>
    <ul class="fieldlist-n">
      <li class="twocolumn left"> <span class="field-middle"><nobr>告警对象名称：</nobr></span> <span><s:if test="notificationObj=='' || null==notificationObj">-</s:if><s:else><DIV STYLE="overflow: hidden; text-overflow:ellipsis;width:260px" title="<s:property value="notificationObj"/>"><NOBR><s:property value="notificationObj"/></NOBR></DIV></s:else></span> </li>
      <li class="twocolumn left"> <span class="field-middle">IP地址</span>&nbsp;&nbsp;&nbsp;&nbsp;<span>：</span><span><s:if test="ip=='' || null==ip">-</s:if><s:else><s:property escape="false" value="ip"/></s:else></span> </li>
      <li class="twocolumn left"> <span class="field-middle"><nobr>告警对象类型：</nobr></span> <span><s:if test="notificationObjType=='' || null==notificationObjType">-</s:if><s:else><s:property value="notificationObjType"/></s:else></span> </li>
      <li class="twocolumn left"> <span class="field-middle">${domainPageName}</span>&nbsp;&nbsp;&nbsp;&nbsp;<span>：</span> <span><s:if test="area=='' || null==area">-</s:if>
      <s:else><span STYLE='width:250px;overflow: hidden; text-overflow:ellipsis;display: inline-block;white-space:nowrap;' title='<s:property value="area"/>'><s:property value="area"/></span></s:else></span> </li>
    </ul>
  </fieldset>
  <s:if test="isDisplayEffect">
  <fieldset class="blue-border-nblock">
    <legend>影响业务服务</legend>
    <page:applyDecorator name="indexcirgrid">
       <page:param name="id">tableId</page:param>
       <page:param name="tableCls">roundedform</page:param>
       <page:param name="linenum">${totalRows}</page:param>
       <page:param name="gridhead">${effectServiceTitle}</page:param>
       <page:param name="gridcontent">${effectServiceData}</page:param>
     </page:applyDecorator>
  </fieldset>
  </s:if>
  
  <s:if test="isDisplayRootCause">
  
  <s:iterator value="rootCauses" id="rootCause" status="s">
  <fieldset class="blue-border-nblock">
    <legend>根本原因${s.index}</legend>
    <div class="root-cause f-relative margin5">
    <s:iterator value="rootCauseTree" id="rootTree" status="s1">
        <s:if test="#s1.first">
            <div class="" style="left: 0; top: 0;">
                <div class="pic for-inline"></div>
                <div class="name for-inline">
                    ${rootTree.name}
                </div>
            </div>
            <s:set var="left" value="105"></s:set>
        </s:if>
        <s:else>
            <div class="arrow " style="margin: 2px 0 0 ${left}px"></div>
            <div class="name" style="margin: 2px 0 0 ${left}px">${rootTree.name}</div>
            <s:set var="left" value="%{#left + 30}"></s:set>
        </s:else>
    </s:iterator>
    <br>
    <hr>
    <br>
        <b>现象：</b><br>
       &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${rootCause.event}<br>
        <b>根本原因：</b><br>
       &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${rootCause.root}<br> 
    </div>
  </fieldset>
  </s:iterator>
  
  </s:if>
</div>
</page:param>
</page:applyDecorator>
</body>
<script type="text/javascript">
function setBodyHeight(){
    var pageObj = document.getElementById("contentDiv");
    var pHeight = pageObj.offsetHeight + 92;
    window.resizeTo(810, pHeight);
    window.moveTo((screen.width - 810)/2, (screen.height - pHeight)/2); 
}


var columnW = {servicename:"30",user:"20",desc:"50"};
var gp = new GridPanel(
    {id:"tableId",unit:"%",columnWidth:columnW,sortColumns:[],plugins:[SortPluginIndex]},
	{gridpanel_DomStruFn:"index_gridpanel_DomStruFn",gridpanel_DomCtrlFn:"index_gridpanel_DomCtrlFn",gridpanel_ComponetFn:"index_gridpanel_ComponetFn"});

    gp.rend([
            {
                index:"servicename",fn:function(td){
                    if(td.html == "") return;
                    var array = td.html.split(',');
                    //$font = $('<font style="height: 21px;text-align: center;" title="'+td.html+'">'+td.html+'</font>');
                    $font = $('<span title="'+array[2]+'" class="ellipsis" style="cursor:pointer;"><nobr>'+array[2]+'</nobr></span>');
                    $font.bind("click",function(){
                        var url = array[3];
                        window.open(url,'businessService','height=650,width=1000,scrollbars=yes');
                    });
                    return $font;
                }
            },
            {
                index:"user",fn:function(td){
                    if(td.html == "") return;
                    $font = $('<font style="height: 21px;text-align: center;" title="'+td.html+'">'+td.html+'</font>');
                    return $font;
                }
            },
            {
                index:"desc",fn:function(td){
                    if(td.html == "") return;
                    $font = $('<font style="height: 21px;text-align: center;" title="'+td.html+'">'+td.html+'</font>');
                    return $font;
                }
            }
	]);
    
    /*var $currentPage = $("input[name='currentPage']");
    var page = new Pagination({applyId:"page",listeners:{
        pageClick:function(page){
        $currentPage.val(page);
        var ajaxParam = $formObj.serialize();
            $.ajax({
                type: "POST",
                dataType:'json',
                url: path+"/notification/jsonSort.action",
                data: ajaxParam,
                success:function(data){
                if(data.dataList){
                    gp.loadGridData(data.dataList);
                }
                },
                error:function(e){
                    //alert(e.responseText);
                }
            });
        }
    }});
    page.pageing(pageCount,1);*/
    
$(function(){
    //$("#ipAddress").style="width:153px";
    /*SimpleBox.renderTo([{
    id:"ipAddress",//下拉列表的id
    iconIndex:"0",//下拉列表的渲染图片的索引值
    iconClass:"combox_ico_select f-absolute",//下拉列表中的渲染图片样式
    iconTitle:"管理IP"//下拉列表的渲染图片上的提示
    }]);*/
    
//SimpleBox.renderToUseWrap({selectId:'_resCategorys',wrapId:'selectResCat',maxHeight:'305px',contentId:'objcontent'});
    //SimpleBox.renderToUseWrap({selectId:'ipAddress',wrapId:'ipAddress_render',maxHeight:'80px',contentId:'ipAddress_render'});
    SimpleBox.renderToUseWrap([{iconIndex:"0",iconClass:"combox_ico_select f-absolute",iconTitle:"管理IP",wrapId:null, selectId:'ipAddress', maxHeight:40}]);
    
    
});
</script>
</html>
