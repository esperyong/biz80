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
<title>物理位置信息</title>
<style type="text/css">
  span.nameelli{width:180px;text-overflow:ellipsis;white-space:nowrap;overflow:hidden; word-spacing:normal; word-break:normal; display:block;}
</style>
</head>
<body>
<s:set var="typeRoom" value="%{@com.mocha.bsm.location.enums.LocationTypeEnum@LOCATION_ROOM.getKey()}" />
<page:applyDecorator name="popwindow" title="物理位置信息">
  <page:param name="width">340px;</page:param>
  <page:param name="height">280px;</page:param>
  <page:param name="topBtn_index_1">1</page:param>
  <page:param name="topBtn_id_1">win_close</page:param>
  <page:param name="topBtn_css_1">win-ico win-close</page:param>
  <page:param name="topBtn_title_1">关闭</page:param>
  
  <page:param name="content">
    <div style="margin:10px 10px 10px 10px;">
      <table class="business-grid02-grid">
        <tr>
          <td>区域</td>
          <td><s:text name="detail.colon" /></td>
          <td><span class="nameelli" title="<s:property value="locationInfo.region.getName()" default="-" />"><s:property value="locationInfo.region.getName()" default="-" /></span></td>
        </tr>
        <tr class="business-grid02-tr-02">
          <td>地区</td>
          <td><s:text name="detail.colon" /></td>
          <td><span class="nameelli" title="<s:property value="locationInfo.area.getName()" default="-" />"><s:property value="locationInfo.area.getName()" default="-" /></span></td>
        </tr>
        <tr>
          <td>大楼</td>
          <td><s:text name="detail.colon" /></td>
          <td><span class="nameelli" title="<s:property value="locationInfo.building.getName()" default="-" />"><s:property value="locationInfo.building.getName()" default="-" /></span></td>
        </tr>
        <tr class="business-grid02-tr-02">
          <td>楼层</td>
          <td><s:text name="detail.colon" /></td>
          <td><span class="nameelli" title="<s:property value="locationInfo.floor.getName()" default="-" />"><s:property value="locationInfo.floor.getName()" default="-" /></span></td>
        </tr>
        <tr>
          <td>房间</td>
          <td><s:text name="detail.colon" /></td>
          <td><span class="nameelli" title="<s:property value="locationInfo.office.getName()" default="-" />"><s:property value="locationInfo.office.getName()" default="-" /></span></td>
        </tr>
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