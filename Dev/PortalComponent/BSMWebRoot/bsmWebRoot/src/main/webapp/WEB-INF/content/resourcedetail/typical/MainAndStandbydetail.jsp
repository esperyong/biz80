<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html>
<head>
  <%@ include file="/WEB-INF/common/meta.jsp" %>
  <title><s:text name="detail.page.wintitle" /></title>
  <style type="text/css"> 
    span.elli-name{width:110px;text-overflow:ellipsis;white-space:nowrap;overflow:hidden; word-spacing:normal; word-break:normal; display:block;}  
  </style>
  <link rel="stylesheet" type="text/css" href="${ctxCss}/master.css" />
  <link rel="stylesheet" type="text/css" href="${ctxCss}/public.css" />
  <link rel="stylesheet" type="text/css" href="${ctxCss}/UIComponent.css" />
  <link rel="stylesheet" type="text/css" href="${ctxCss}/jquery-ui/treeview.css" />
  <link rel="stylesheet" type="text/css" href="${ctxCss}/tongjifenxi.css" />
</head>

<body>
<div class="loading" id="loading" style="display:none;">
  <div class="loading-l">
    <div class="loading-r">
      <div class="loading-m"><span class="loading-img"><s:text name="page.loading.msg" /></span></div>
   </div>
  </div>
</div> 
<form name="searchFrm" id="searchFrm">
<div class="pop">
  <div class="pop-top-l">
    <div class="pop-top-r">
      <div class="pop-top-m">
        <a class="win-ico win-close" id="close_button" title="<s:text name="btn.close" />"></a>
        <span class="pop-top-title"><s:text name="detail.page.wintitle" /></span>
      </div>
    </div>
  </div>
  <div class="pop-m">
    <div class="pop-content">
    
  <!-- content start -->
	<div class="padding8">
    <ul>
			<li style="width:60px;" class="left">
			  <span class="suojin bold"><s:text name="detail.typical.total" /></span><span class="" id="totalCount"><s:property value="result['rowCount']" /></span>
			</li>
			<li style="width:400px;" class="left">
			  <span class="suojin1em bold"><s:text name="detail.typical.maindevicename" /><s:text name="i18n.colon" /></span><input type="text" name="searchVal" id="searchVal" value="<s:property value="searchVal" />" /><input type="hidden" value="name" />
			  <span class="ico ico-select" id="searchBtn" title="<s:text name="detail.typical.clicksearch" />"></span>
			</li>
    </ul>
		<table id="detailTab" class="tongji-grid table-width100 grayborder" style="border:1px solic #ccc;margin-top:5px;">
			<tr>
			  <th rowspan="2" style="text-align:center;"><span><s:text name="detail.typical.status" /></span></th>
			  <th rowspan="2" style="text-align:center;"><span><s:text name="detail.typical.maindevicename" /><!-- <a class="theadbar-ico theadbar-ico-up" href="#"></a><a class="theadbar-ico theadbar-ico-down" href="#"></a> --></span></th>
			  <th rowspan="2" style="text-align:center;"><span><s:text name="detail.typical.maindevice" /></span></th>
			  <th rowspan="2" style="text-align:center;"><span><s:text name="detail.typical.standbydevice" /> </span></th>
			  <th rowspan="2" style="text-align:center;"><span><s:text name="alarm" /></span></th>
			  <th colspan="2" class="rt textalign"><span><s:text name="detail.typical.availstatistics" /></span><span class="ico ico-what" title="<s:text name="avail.statistics.help" />"></span></th>
			  <th rowspan="2" style="text-align:center;"><span><s:text name="detail.typical.coltime" /> </span></th>
			</tr>
      <tr>
        <th class="rb textalign"><span><s:text name="detail.typical.today" /></span></th>
        <th class="rb textalign"><span><s:text name="detail.typical.yesterday" /></span></th>
      </tr>
      <s:iterator value="result.datas" var="dataMap" status="idx">
      <tr class="line" <s:if test="#idx.isEven()">style="background-color:#f2f2f2;"</s:if>>
        <td style="text-align:center;height:21px;">
          <span class="<s:property value="#dataMap['instanceState']" />" name="instanceState" instanceId="<s:property value="#dataMap['instanceId']" />"></span>
        </td>
        <td><span class="elli-name" title="<s:property value="#dataMap['instanceName']" default="-" />"><s:property value="#dataMap['instanceName']" default="-" /></span></td>
        <td title="<s:property value="#dataMap['MainName']['metricValue']" default="-" />">
          <s:iterator value="#dataMap['childList']" var="childMap" status="idx">
            <s:if test="#dataMap['MainId']['metricValue'] == #childMap['NodeId']['metricValue']">
              <span class="<s:property value="#childMap['childState']" />" name="childState" childId="<s:property value="#childMap['childId']" />"></span>
            </s:if>
          </s:iterator>
          <s:property value="#dataMap['MainName']['metricValue']" default="-" />
        </td>
        <td title="<s:property value="#dataMap['StandbyName']['metricValue']" default="-" />">
          <s:iterator value="#dataMap['childList']" var="childMap" status="idx">
            <s:if test="#dataMap['StandbyId']['metricValue'] == #childMap['NodeId']['metricValue']">
              <span class="<s:property value="#childMap['childState']" />" name="childState" childId="<s:property value="#childMap['childName']" />"></span>
            </s:if>
          </s:iterator>
          <s:property value="#dataMap['StandbyName']['metricValue']" default="-" />
        </td>
        <td>
          <s:if test="#dataMap['alarmCount'] > 0"><span class="ico" title="<s:text name="detail.typical.alarm24" />" name="alarm24" instanceId="<s:property value="#dataMap['instanceId']" />"></span></s:if>
          <s:else><span class="ico" title="<s:text name="detail.typical.alarmnoconfirm24" />" style="cursor:pointer;"></span></s:else>
          (<s:property value="#dataMap['alarmCount']" />)
        </td>
        <td name="avail" instanceId="<s:property value="#dataMap['instanceId']" />" style="cursor:pointer;"><s:property value="#dataMap['today']" /></td>
        <td name="avail" instanceId="<s:property value="#dataMap['instanceId']" />" style="cursor:pointer;"><s:property value="#dataMap['yesterday']" /></td>
        <td><s:property value="#dataMap['collecttime']" default="-" /></td>
      </tr>
      </s:iterator>
      <s:set var="P_SIZE" value="%{@com.mocha.bsm.detail.business.TypicalDetailMgr@PAGE_SIZE}" />
      <s:if test="result.datas.size()>0 && result.datas.size() < #P_SIZE">
        <s:bean name="org.apache.struts2.util.Counter" id="counter">
          <s:param name="first" value="result.datas.size()" />
          <s:param name="last" value="#P_SIZE - 1" />
          <s:iterator>
            <tr class="line" <s:if test="current%2==0">style="background-color:#f2f2f2;"</s:if>>
              <td style="height:21px;">&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td>
            </tr>
          </s:iterator>
        </s:bean>
      </s:if>
		</table>
    <s:if test="result.datas==null || result.datas.size()<=0">
    <div class="grid-gray" style="height:450px;">
      <div class="formcontent" style="height:450px;">
        <table style="height:450px;width:100%;">
          <tbody>
            <tr>
             <td class="nodata vertical-middle" style="text-align:center;">
               <span class="nodata-l">
                  <span class="nodata-r">
                    <span class="nodata-m"> <span class="icon"><s:text name="i18n.nodata" /></span> </span>
                  </span>
                </span>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
    </s:if>
		<div id="pageid"></div><!-- 分页组件 -->
	</div>
	<input type="hidden" name="instanceId" id="instanceId" value="<s:property value="instanceId" />" />
	<input type="hidden" name="actionPrefix" id="actionPrefix" value="<s:property value="actionPrefix" />" />
  <input type="hidden" name="resourceId" id="resourceId" value="<s:property value="resourceId" />" />
  <!-- content end -->
  <div class="pop-bottom-l">
    <div class="pop-bottom-r">
      <div class="pop-bottom-m">
         &nbsp;
      </div>
    </div>
  </div>
</div>
</div>
</div>
</form>
<script type="text/javascript">
  var ctxpath = "${ctx}";
  var actionUrl = "${ctx}/detail/${actionPrefix}TypicalDetail.action";
  var pageCount = ${pageCount};
  var currentPage = ${currentPage};
</script>
<script type="text/javascript" src="${ctxJs}/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="${ctxJs}/component/cfncc.js"></script>
<script type="text/javascript" src="${ctxJs}/jquery.blockUI.js"></script>
<script type="text/javascript" src="${ctxJs}/<s:text name="js.i18n.file" />"></script>
<script type="text/javascript" src="${ctxJs}/component/gridPanel/page.js"></script>
<script type="text/javascript" src="${ctxJs}/component/combobox/simplebox.js"></script>
<script type="text/javascript" src="${ctxJs}/component/comm/winopen.js"></script>
<script type="text/javascript" src="${ctxJs}/component/comm/winopen.js"></script>
<script type="text/javascript" src="${ctxJs}/resourcedetail/typicaldetail.js"></script>
</body>
</html>
