<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!-- 
	author:liuhw
	description:默认规则
	uri:{domainContextPath}/bizsm/bizservice/ui/bizservicemanager
 -->
<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Untitled Document</title>
<link href="<%=request.getContextPath()%>/css/master.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/css/portal.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/css/portal02.css" rel="stylesheet" type="text/css" />
</head>
<body  class="pop-window">
<form name="defaultForm">
<div class="pop" style="width:420px">
  <div class="pop-top-l">
    <div class="pop-top-r">
      <div class="pop-top-m"> <a id="close" class="win-ico win-close"></a> <span class="pop-top-title">系统默认规则</span> </div>
    </div>
  </div>
  <div class="pop-m">
    <div class="pop-content">
      <div class="set-panel02-content-white">
        <div class="clear"></div>
        <div class="sub-panel-open">
          <div class="sub-panel-top"><span class="light-ico light-ico-red"></span> <span class="sub-panel-title">严重</span></div>
          <div class="sub-panel-content">
            <table id="errorTable" border="0" cellpadding="0" cellspacing="0" class="table">
              <tr>
                <td>任意一个关联业务服务状态为<span class="light-ico light-ico-red" title="严重"></span>，或者任意一个关联资源状态为<span class="light-ico light-ico-red" title="不可用"></td>
              </tr>
              
            </table>
          </div>
        </div>
		<div class="sub-panel-open">
          <div class="sub-panel-top"><span class="light-ico light-ico-yellow"></span> <span class="sub-panel-title">警告</span></div>
          <div class="sub-panel-content">
            <table id="alarmTable" border="0" cellpadding="0" cellspacing="0" class="table">
              <tr>
                <td>任意一个关联业务服务状态为<span class="light-ico light-ico-yellow" title="警告"></span>，或者任意一个关联资源状态为<span class="lightshine-ico lightshine-ico-greenred"  title="资源可用，资源或其组件性能严重超标或某些组件不可用"></span>
<span class="lightshine-ico lightshine-ico-greenyellow" title="资源可用，资源或其组件性能轻微超标"></span>
<span class="lightshine-ico lightshine-ico-greengray" title="资源可用，资源或其组件性能未知"></span></td>
              </tr>
             
            </table>
          </div>
        </div>
        <div class="sub-panel-open">
          <div class="sub-panel-top"><span class="light-ico light-ico-gray"></span> 
          <span class="sub-panel-title">未知</span>
          </div>
           <div class="sub-panel-content">
         	<table id="unknown" border="0" cellpadding="0" cellspacing="0" class="table">
              <tr>
                <td>所有关联业务服务和资源状态为<span class="light-ico light-ico-gray" title="未知"></span>。</td>
               
              </tr>
            </table>
          </div>
        </div>
        <div class="sub-panel-open">
          <div class="sub-panel-top"><span class="light-ico light-ico-green"></span> 
          <span class="sub-panel-title">正常</span>
          </div>
           <div class="sub-panel-content">
         	<table id="normal" border="0" cellpadding="0" cellspacing="0" class="table">
              <tr>
                <td>当不符合严重、警告、未知时服务状态为<span class="light-ico light-ico-green" title="正常"></span>。</td>
              </tr>
              <tr height="50"><td>注：判断优先级为 致命 -> 告警 -> 未知 -> 正常</td></tr>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
</form>
</body>
</html>