<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html>
<head>
  <%@ include file="/WEB-INF/common/meta.jsp" %>
  <title><s:text name="detail.page.wintitle" /></title>
  <style type="text/css"> 
    span.elli-name{width:130px;text-overflow:ellipsis;white-space:nowrap;overflow:hidden; word-spacing:normal; word-break:normal; display:block;}
    span.elli-profile{width:130px;text-overflow:ellipsis;white-space:nowrap;overflow:hidden; word-spacing:normal; word-break:normal; display:block;}
    .sb-line{float:left;height:21px;line-height:21px;}
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
	<div class="padding8" >
    <ul>
			<li style="width:60px;" class="left">
			  <span class="suojin bold sb-line"><s:text name="detail.typical.total" /></span><span class="sb-line" id="totalCount"><s:property value="result['rowCount']" /></span>
			</li>
			<li style="width:400px;" class="left">
			  <span class="suojin1em bold sb-line"><s:text name="detail.typical.search" /></span>
			  <select id="searchKey" name="searchKey" class="sb-line">
				  <option value="name" <s:if test="'name'==searchKey">selected</s:if>><s:text name="detail.typical.displayname" /></option>
				  <option value="NetworkNodeIPAddress" <s:if test="'NetworkNodeIPAddress'==searchKey">selected</s:if>><s:text name="detail.typical.mailserver" /></option>
			  </select>
			  <input type="text" style="height:20px;line-height:20px;" name="searchVal" id="searchVal" value="<s:property value="searchVal" />" />
			  <span class="ico ico-select" id="searchBtn" title="<s:text name="detail.typical.clicksearch" />"></span>
			</li>
    </ul>
		<table id="detailTab" class="tongji-grid table-width100 grayborder" style="border:1px solic #ccc;margin-top:5px;">
			<tr>
			  <th rowspan="2" style="text-align:center;"><span><s:text name="detail.typical.status" /></span></th>
			  <th rowspan="2" style="text-align:center;"><span><s:text name="detail.typical.displayname" /><!-- <a class="theadbar-ico theadbar-ico-up" href="#"></a><a class="theadbar-ico theadbar-ico-down" href="#"></a> --></span></th>
			  <th rowspan="2" style="text-align:center;"><span><s:text name="detail.typical.mailserver" /></span></th>
			  <th rowspan="2" style="text-align:center;"><span><s:text name="detail.typical.stratgy" /> </span></th>
			  <th rowspan="2" style="text-align:center;"><span><s:text name="detail.typical.smtpserverstatus" /></span></th>
			  <th rowspan="2" style="text-align:center;"><span><s:text name="detail.typical.pop3serverstatus" /></span></th>
			  <th colspan="2" class="rt textalign"><span><s:text name="detail.typical.availstatistics" /></span><span class="ico ico-what" title="<s:text name="avail.statistics.help" />"></span></th>
			  <th rowspan="2" style="text-align:center;"><span><s:text name="detail.typical.coltime" /> </span></th>
			</tr>
      <tr>
        <th class="rb textalign"><span><s:text name="detail.typical.today" /></span></th>
        <th class="rb textalign"><span><s:text name="detail.typical.yesterday" /></span></th>
      </tr>
      <s:iterator value="result.datas" var="dataMap" status="idx">
      <tr class="line" <s:if test="#idx.isEven()">style="background-color:#f2f2f2;"</s:if>>
        <td style="text-align:center;height:21px;"><span class="<s:property value="#dataMap['instanceState']" />" style="cursor:default;"></span></td>
        <td><span class="elli-name" title="<s:property value="#dataMap['instanceName']" default="-" />"><s:property value="#dataMap['instanceName']" default="-" /></span></td>
        <td>
          <s:generator val="#dataMap['MailServerIPAddress']['metricValue']" separator="," var="iplist"></s:generator>
          <s:generator val="#dataMap['MailServerIPAddress']['metricValue']" separator="," var="iplist1"></s:generator>
          <s:iterator value="#iplist" status="st">
            <s:if test="%{#st.last}">
              <s:set name="iplistSize" value="%{#st.count}"></s:set>
            </s:if>
          </s:iterator>
          <s:if test="#iplistSize == 1">
            <s:property value="#dataMap['MailServerIPAddress']['metricValue']" default="-" />
          </s:if>
          <s:elseif test="#iplistSize > 1">
            <select id="ipsel_<s:property value="#dataMap['instanceId']" />">
              <s:iterator value="#iplist1">
                <option><s:property /></option>
              </s:iterator>
            </select>
          </s:elseif>
        </td>
        <td><span class="elli-profile" title="<s:property value="#dataMap['profile'].getName()" default="-" />"><s:property value="#dataMap['profile'].getName()" default="-" /></span></td>
        <td><s:property value="#dataMap['SMTPMailServerAvailability']['metricValue']" default="-" /></td>
        <td><s:property value="#dataMap['POP3MailServerAvailability']['metricValue']" default="-" /></td>
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
			        <td style="height:21px;">&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td>
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
