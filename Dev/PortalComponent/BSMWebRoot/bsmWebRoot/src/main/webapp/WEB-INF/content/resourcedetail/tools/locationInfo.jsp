<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.mocha.sys.util.time.DateFormatUtils"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/WEB-INF/common/meta.jsp"%>
<link rel="stylesheet" type="text/css" href="${ctxCss}/master.css" />
<link rel="stylesheet" type="text/css" href="${ctxCss}/public.css" />
<link rel="stylesheet" type="text/css" href="${ctxCss}/UIComponent.css" />
<link rel="stylesheet" type="text/css" href="${ctxCss}/business-grid.css" />
<title><s:text name="detail.locationinfo" /></title>
<style type="text/css">
  span.nameelli{width:180px;text-overflow:ellipsis;white-space:nowrap;overflow:hidden; word-spacing:normal; word-break:normal; display:block;}
</style>
</head>
<body>
<s:set var="typeRoom" value="%{@com.mocha.bsm.location.enums.LocationTypeEnum@LOCATION_ROOM.getKey()}" />
<page:applyDecorator name="popwindow">
  <page:param name="title"><s:text name="detail.locationinfo" /></page:param>
  <page:param name="width">340px;</page:param>
  <page:param name="height">280px;</page:param>
  <page:param name="topBtn_index_1">1</page:param>
  <page:param name="topBtn_id_1">win_close</page:param>
  <page:param name="topBtn_css_1">win-ico win-close</page:param>
  <page:param name="topBtn_title_1"><s:text name="i18n.close" /></page:param>
  
  <page:param name="content">
    <div style="margin:10px 10px 10px 10px;">
      <table class="business-grid02-grid">
        <tr class="business-grid02-tr-02">
          <td width="80px"><s:text name="detail.typical.displayname" /></td>
          <td width="10px"><s:text name="detail.colon" /></td>
          <td style="text-align:left;"><span class="nameelli" title="<s:property value="resourceInstance.getName()" default="-" />"><s:property value="resourceInstance.getName()" default="-" /></span></td>
        </tr>
        <tr>
          <td><s:text name="detail.locationInfo.region" /></td>
          <td><s:text name="detail.colon" /></td>
          <td><span class="nameelli" title="<s:property value="locationInfo.region.getName()" default="-" />"><s:property value="locationInfo.region.getName()" default="-" /></span></td>
        </tr>
        <tr class="business-grid02-tr-02">
          <td><s:text name="detail.locationInfo.area" /></td>
          <td><s:text name="detail.colon" /></td>
          <td><span class="nameelli" title="<s:property value="locationInfo.area.getName()" default="-" />"><s:property value="locationInfo.area.getName()" default="-" /></span></td>
        </tr>
        <tr>
          <td><s:text name="detail.locationInfo.building" /></td>
          <td><s:text name="detail.colon" /></td>
          <td><span class="nameelli" title="<s:property value="locationInfo.building.getName()" default="-" />"><s:property value="locationInfo.building.getName()" default="-" /></span></td>
        </tr>
        <tr class="business-grid02-tr-02">
          <td><s:text name="detail.locationInfo.floor" /></td>
          <td><s:text name="detail.colon" /></td>
          <td><span class="nameelli" title="<s:property value="locationInfo.floor.getName()" default="-" />"><s:property value="locationInfo.floor.getName()" default="-" /></span></td>
        </tr>
        <s:if test="locationInfo.office.getType().equals(#typeRoom)">
        <tr>
          <td><s:text name="detail.locationInfo.machineroom" /></td>
          <td><s:text name="detail.colon" /></td>
          <td><span class="nameelli" title="<s:property value="locationInfo.office.getName()" default="-" />"><s:property value="locationInfo.office.getName()" default="-" /></span></td>
        </tr>
        <tr class="business-grid02-tr-02">
          <td><s:text name="detail.locationInfo.jigui" /></td>
          <td><s:text name="detail.colon" /></td>
          <td><span class="nameelli" title="<s:property value="locationInfo.jigui" default="-" />"><s:property value="locationInfo.jigui" default="-" /></span></td>
        </tr>
        <tr>
          <td><s:text name="detail.locationInfo.jikuang" /></td>
          <td><s:text name="detail.colon" /></td>
          <td><span class="nameelli" title="<s:property value="locationInfo.jikuang" default="-" />"><s:property value="locationInfo.jikuang" default="-" /></span></td>
        </tr>
        </s:if>
        <s:else>
        <tr>
          <td><s:text name="detail.locationInfo.room" /></td>
          <td><s:text name="detail.colon" /></td>
          <td><span class="nameelli" title="<s:property value="locationInfo.office.getName()" default="-" />"><s:property value="locationInfo.office.getName()" default="-" /></span></td>
        </tr>
        <tr class="business-grid02-tr-02">
          <td><s:text name="detail.locationInfo.wallnumber" /></td>
          <td><s:text name="detail.colon" /></td>
          <td><span class="nameelli" title="<s:property value="locationInfo.wallnumber" default="-" />"><s:property value="locationInfo.wallnumber" default="-" /></span></td>
        </tr>
        <tr>
          <td><s:text name="detail.locationInfo.worknumber" /></td>
          <td><s:text name="detail.colon" /></td>
          <td><span class="nameelli" title="<s:property value="locationInfo.worknumber" default="-" />"><s:property value="locationInfo.worknumber" default="-" /></span></td>
        </tr>
        <tr class="business-grid02-tr-02">
          <td><s:text name="detail.locationInfo.equipAdmin" /></td>
          <td><s:text name="detail.colon" /></td>
          <td><span class="nameelli" title="<s:property value="locationInfo.equipAdmin" default="-" />"><s:property value="locationInfo.equipAdmin" default="-" /></span></td>
        </tr>
        <tr>
          <td><s:text name="detail.locationInfo.equipDept" /></td>
          <td><s:text name="detail.colon" /></td>
          <td><span class="nameelli" title="<s:property value="locationInfo.equipDept" default="-" />"><s:property value="locationInfo.equipDept" default="-" /></span></td>
        </tr>
        </s:else>
      </table>
    </div>
  </page:param>

</page:applyDecorator>
<script type="text/javascript" src="${ctxJs}/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="${ctxJs}/component/cfncc.js"></script>
<script type="text/javascript" src="${ctxJs}/component/comm/winopen.js"></script> 
<script type="text/javascript" src="${ctxJs}/component/popwindow/popwin.js"></script>
<script>
  $(function(){
    $('#close_button,#win_close').click(function(){
      window.close();
    });
  });
</script>
</body>
</html>