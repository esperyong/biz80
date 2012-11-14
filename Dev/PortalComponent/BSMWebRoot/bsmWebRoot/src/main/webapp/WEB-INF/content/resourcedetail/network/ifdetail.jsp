<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html> 
  <head>
    <title></title>         
    <%@ include file="/WEB-INF/common/meta.jsp" %>
    <style type="text/css">
      span.sptitle{width:85px;display:inline-block; }
      .linameelli{width:260px;text-overflow:ellipsis;white-space:nowrap;overflow:hidden; word-spacing:normal; word-break:normal;}
    </style>
  </head>
  <body>
    <div id="ifdetaildiv" style="width:300px;padding:5px 20px 5px 20px;">
      <ul>
        <li><span class="sptitle bold"><s:text name="detail.interface.index" /></span><s:text name="detail.colon" /><s:property value="ifDetail.ifIndex" default="-" /></li>
        <li class="linameelli" title="<s:property value="ifDetail.ifName" default="-" />"><span class="sptitle bold"><s:text name="detail.interface.name" /></span><s:text name="detail.colon" /><s:property value="ifDetail.ifName" default="-" /></li>
        <li><span class="sptitle bold"><s:text name="detail.interface.type" /></span><s:text name="detail.colon" /><s:property value="ifDetail.ifType" default="-" /></li>
        <li><span class="sptitle bold"><s:text name="detail.interface.macaddress" /></span><s:text name="detail.colon" /><s:property value="ifDetail.ifMac" default="-" /></li>
        <li><span class="sptitle bold"><s:text name="detail.interface.bandwidth" /></span><s:text name="detail.colon" /><s:property value="ifDetail.ifBandwidth" default="-" /></li>
        <s:if test="ifDetail.isMonitored()">
        <li><hr/></li>
        <li><span class="sptitle bold"><s:text name="detail.interface.globalstatus" /></span><s:text name="detail.colon" /><span class="<s:property value="ifDetail.globalStatus" />" style="cursor:default;"></span></li>
        <li><span class="sptitle bold"><s:text name="detail.interface.adminstatus" /></span><s:text name="detail.colon" /><s:if test="ifDetail.adminStatus.isMonitored() == false"><span class="ico ico-stop" style="cursor:default;" title="未监控"></span></s:if><s:else><span class="<s:property value="ifDetail.adminStatus.getState()" />" style="cursor:default;"></span></s:else></li>
        <li><span class="sptitle bold"><s:text name="detail.interface.operastatus" /></span><s:text name="detail.colon" /><s:if test="ifDetail.operaStatus.isMonitored() == false"><span class="ico ico-stop" style="cursor:default;" title="未监控"></span></s:if><s:else><span class="<s:property value="ifDetail.operaStatus.getState()" />" style="cursor:default;"></span></s:else></li>
        <li><hr/></li>
        <li><span class="sptitle bold"><s:text name="detail.interface.bandwidthUtil" /></span><s:text name="detail.colon" /><s:if test="ifDetail.bandwidthUtil.isMonitored() == false"><span class="ico ico-stop" style="cursor:default;" title="未监控"></span></s:if><s:else><span style='color:<s:property value="ifDetail.bandwidthUtil.getValueColor()" />;'><s:property value="ifDetail.bandwidthUtil.getCurrentValue()" default="-" /></span></s:else></li>
        <li><span class="sptitle bold"><s:text name="detail.interface.receiveRate" /></span><s:text name="detail.colon" /><s:if test="ifDetail.receiveRate.isMonitored() == false"><span class="ico ico-stop" style="cursor:default;" title="未监控"></span></s:if><s:else><span style='color:<s:property value="ifDetail.receiveRate.getValueColor()" />;'><s:property value="ifDetail.receiveRate.getCurrentValue()" default="-" /></span></s:else></li>
        <li><span class="sptitle bold"><s:text name="detail.interface.sendRate" /></span><s:text name="detail.colon" /><s:if test="ifDetail.sendRate.isMonitored() == false"><span class="ico ico-stop" style="cursor:default;" title="未监控"></span></s:if><s:else><span style='color:<s:property value="ifDetail.sendRate.getValueColor()" />;'><s:property value="ifDetail.sendRate.getCurrentValue()" default="-" /></span></s:else></li>
        <li><span class="sptitle bold"><s:text name="detail.interface.receiveUtil" /></span><s:text name="detail.colon" /><s:if test="ifDetail.receiveUtil.isMonitored() == false"><span class="ico ico-stop" style="cursor:default;" title="未监控"></span></s:if><s:else><span style='color:<s:property value="ifDetail.receiveUtil.getValueColor()" />;'><s:property value="ifDetail.receiveUtil.getCurrentValue()" default="-" /></span></s:else></li>
        <li><span class="sptitle bold"><s:text name="detail.interface.sendUtil" /></span><s:text name="detail.colon" /><s:if test="ifDetail.sendUtil.isMonitored() == false"><span class="ico ico-stop" style="cursor:default;" title="未监控"></span></s:if><s:else><span style='color:<s:property value="ifDetail.sendUtil.getValueColor()" />;'><s:property value="ifDetail.sendUtil.getCurrentValue()" default="-" /></span></s:else></li>
        <li><span class="sptitle bold"><s:text name="detail.interface.dropRate" /></span><s:text name="detail.colon" /><s:if test="ifDetail.dropRate.isMonitored() == false"><span class="ico ico-stop" style="cursor:default;" title="未监控"></span></s:if><s:else><span style='color:<s:property value="ifDetail.dropRate.getValueColor()" />;'><s:property value="ifDetail.dropRate.getCurrentValue()" default="-" /></span></s:else>
        </li>
        <li><span class="sptitle bold"><s:text name="detail.interface.arpRate" /></span><s:text name="detail.colon" /><s:if test="ifDetail.arpRate.isMonitored() == false"><span class="ico ico-stop" style="cursor:default;" title="未监控"></span></s:if><s:else><span style='color:<s:property value="ifDetail.arpRate.getValueColor()" />;'><s:property value="ifDetail.arpRate.getCurrentValue()" default="-" /></span></s:else>
        </li>
        <li><span class="sptitle bold"><s:text name="detail.interface.unicastRate" /></span><s:text name="detail.colon" /><s:if test="ifDetail.unicastRate.isMonitored() == false"><span class="ico ico-stop" style="cursor:default;" title="未监控"></span></s:if><s:else><span style='color:<s:property value="ifDetail.unicastRate.getValueColor()" />;'><s:property value="ifDetail.unicastRate.getCurrentValue()" default="-" /></span></s:else>
        </li>
        <li><span class="sptitle bold"><s:text name="detail.interface.broadcastRate" /></span><s:text name="detail.colon" /><s:if test="ifDetail.broadcastRate.isMonitored() == false"><span class="ico ico-stop" style="cursor:default;" title="未监控"></span></s:if><s:else><span style='color:<s:property value="ifDetail.broadcastRate.getValueColor()" />;'><s:property value="ifDetail.broadcastRate.getCurrentValue()" default="-" /></span></s:else>
        </li>
        </s:if>
      </ul>
    </div>
   </body>
</html>
