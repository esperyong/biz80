<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/WEB-INF/common/meta.jsp" %>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html>
<head>
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />

<link href="${ctx}/css/tongjifenxi.css" rel="stylesheet" type="text/css" />

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
</head>
<body>
               <div class="fold-blue">
               <div class="fold-top bold">第一步：维护机房设施</div></div>
               <div class="margin8">
                 <p class="stage box"><span class="ico ico-tips"></span><span style="line-height:20px">此步为新建机房的基础。</span></p>
                 <p class="stage" style="line-height:20px">机房设施类型决定了在机房定义中能支持监控哪些机房设施。系统默认机房设施类型有机柜、UPS、普通空调、机房环境
中的温度、湿度、门禁、浸水、烟感、市电。如果系统默认类型不满足需要，可在此步增删改机房设施类型并设置默认监
控指标及取值方式。</p>
<p class="stage bold">步骤如下：</p>
<p class="stage"><table class="table-width100" border="0">
  <tr style="height:30px">
    <td width="20px">1、</td>
    <td>点击机房定义左侧导航中<img src="${ctx}/flash/pic/guide/guide-step-01-pic-01.gif" width="179" height="26" vertical-align="middle" />的进入机房监控管理页面。</td>
   
  </tr>
  <tr style="height:30px">
    <td class="top">2、</td>
    <td>点击<img src="${ctx}/flash/pic/guide/guide-step-01-pic-02.gif" width="67" height="22" />添加新的机房设施类型，同时上传代表该类型的图片，以便在绘制机房布局时使用此图片代表
       机房设施。</td>
   
  </tr>
  <tr style="height:30px">
    <td>3、</td>
    <td>点击机房类型名称后面的<img src="${ctx}/flash/pic/guide/guide-step-01-pic-04.gif" width="39" height="17" />展现此机房类型默认的监控指标，可增删改需要监控的指标。</td>
    
  </tr>
</table>
</p>
               </div>
             </div>
            </div>
</body>
</html>