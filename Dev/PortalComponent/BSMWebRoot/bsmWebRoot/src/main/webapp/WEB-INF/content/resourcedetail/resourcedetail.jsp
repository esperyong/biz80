<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Set"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.Map.Entry"%>
<%@ page import="com.mocha.bsm.detail.util.Constants"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<%@ include file="/WEB-INF/common/userinfo.jsp" %>
<html>
<head>
  <%@ include file="/WEB-INF/common/meta.jsp" %>
  <title><s:text name="detail.page.wintitle" />-<s:property value="instance.getName()" /></title>
  <link rel="stylesheet" type="text/css" href="${ctxFlash}/resourcedetail/history/history.css" />
  <script type="text/javascript" src="${ctxFlash}/resourcedetail/history/history.js"></script>
  <script type="text/javascript" src="${ctxFlash}/swfobject.js"></script>
  <style type="text/css">
    .nameelli{width:120px;text-overflow:ellipsis;white-space:nowrap;overflow:hidden; word-spacing:normal; word-break:normal; display:block;}
    .relanameelli{text-overflow:ellipsis;white-space:nowrap;overflow:hidden; word-spacing:normal; word-break:normal; display:block;}
    .instnameelli{width:190px;text-overflow:ellipsis;white-space:nowrap;overflow:hidden; word-spacing:normal; word-break:normal; display:block;text-align:center;}
  </style>
  <link rel="stylesheet" type="text/css" href="${ctxCss}/master.css" />
  <link rel="stylesheet" type="text/css" href="${ctxCss}/public.css" />
  <link rel="stylesheet" type="text/css" href="${ctxCss}/UIComponent.css" />
  <link rel="stylesheet" type="text/css" href="${ctxCss}/jquery-ui/white_treeview.css" />
  <link rel="stylesheet" type="text/css" href="${ctxCss}/business-grid.css" />
  <link rel="stylesheet" type="text/css" href="${ctxCss}/datepicker.css" />
  <script type="text/javascript">
    var navswfVersionStr = "10.0.0";
    var navxiSwfUrlStr = "${ctxFlash}/resourcedetail/playerProductInstall.swf";
    var navflashvars = {};
    navflashvars.dataurl = '${ctx}/detail/resourcedetail!navigationXml.action?instanceId=<s:property value="instanceId" />@@<s:property value="currentNav" />';
    var navparams = {};
    navparams.quality = "high";
    navparams.bgcolor = "#ffffff";
    navparams.wmode = "transparent";
    navparams.allowscriptaccess = "sameDomain";
    navparams.allowfullscreen = "true";
    var navattributes = {};
    navattributes.id = "navigationflash";
    navattributes.name = "navigationflash";
    navattributes.align = "middle";
    swfobject.embedSWF("${ctxFlash}/resourcedetail/navigation.swf", "navigationFlash", 
        "262px", "235px", 
        navswfVersionStr, navxiSwfUrlStr, 
        navflashvars, navparams, navattributes);
    swfobject.createCSS("#navigationFlash", "display:block;text-align:left;");
  </script>
</head>
<body scroll="no">
<div class="loading" id="loading" style="display:none;">
	<div class="loading-l">
		<div class="loading-r">
      <div class="loading-m"><span class="loading-img"><s:text name="page.loading.msg" /></span></div>
	 </div>
  </div>
</div>
<div class="loading" id="refreshEquipLoading" style="display:none;">
  <div class="loading-l">
    <div class="loading-r">
      <div class="loading-m"><span class="loading-img"><s:text name="page.refresh.loading.msg" /></span></div>
   </div>
  </div>
</div>
<div class="equipment">
  <div class="equipment-top t-right" id="topToolsDiv">
    <%
    Map<String, String> topButtons = (Map<String, String>)request.getAttribute("topButtons"); 
    Set<Entry<String, String>> entrySet = topButtons.entrySet();
    for (Iterator<Entry<String, String>> iterator = entrySet.iterator(); iterator
            .hasNext();) {
      Entry<String, String> entry = iterator.next();
      String key = entry.getKey();
      String value = entry.getValue();
      String i18nKey = com.mocha.bsm.detail.util.I18NUtil.getI18NKey(key);
      String i18nVal = com.mocha.bsm.i18n.I18nUtil.getText(i18nKey);
      if(value!=null && value.indexOf("menuitem")!=-1){
    	  %>
<span class="black-btn-l" key="<%=key%>" params="<%=value%>" <s:if test="!canOperate">disabled style="cursor:default;"</s:if>><span class="btn-r"><span class="btn-m"><a><%=i18nVal%></a><a class="down"></a></span></span></span>
    	  <%
      } else if(value != null && value.indexOf("relaapp") != -1){
    	  %>
<span class="black-btn-l" key="<%=key%>" params="<%=value%>"><span class="btn-r"><span class="btn-m"><a><%=i18nVal%></a><a class="down"></a></span></span></span>
    	  <%
      } else if(value!=null && value.indexOf("relahost")!=-1){
    	  %>
<span class="black-btn-l" key="<%=key%>" params="<%=value%>"><span class="btn-r"><span class="btn-m"><a><%=i18nVal%></a></span></span></span>
    	  <%
      } else if(value!=null && value.indexOf("nonlicensekey")!=-1){
    	  String title = com.mocha.bsm.i18n.I18nUtil.getText(value);
          %>
<span class="black-btn-l" disabled style="cursor:default;" title="<%=title%>" />"><span class="btn-r"><span class="btn-m"><a><%=i18nVal%></a></span></span></span>
          <%
       } else if(value!=null){
    	   %>
<span class="black-btn-l" key="<%=key%>" params="<%=value%>"><span class="btn-r"><span class="btn-m"><a><%=i18nVal%></a></span></span></span>
    	   <%
       }
    }
    %>
  </div>
  <div style="float:left;">
    <div id="navFlash" style="position:absolute;top:0px;left:-1px;">
      <div id="navigationFlash" style="width:262px;height:235px;"></div>
    </div>
    <div id="navigation" style="width:0px;height:0px;display:none;">
      <ul style="color:#FFF;">
        <%
        List<String> navigations = (List<String>)request.getAttribute("navigations");
        Map<String, String> childNavMap = (Map<String, String>)request.getAttribute("childNavMap");
        for(int i=0;i<navigations.size();i++){
        	String id = navigations.get(i);
          String text = com.mocha.bsm.i18n.I18nUtil.getText(id);
          %>
          <li id="<%=id%>"><%=text%></li>
          <%
        }
        if(childNavMap!=null && !childNavMap.isEmpty()){
            Set<Entry<String, String>> entrySet1 = childNavMap.entrySet();
            for (Iterator<Entry<String, String>> iterator = entrySet1.iterator(); iterator
                    .hasNext();) {
              Entry<String, String> entry = iterator.next();
              String key = entry.getKey();
              String value = entry.getValue();
              %>
              <li id="child__<%=key%>"><%=value%></li>
              <%
            }
        }
        %>
      </ul>
    </div>
    <div style="width:220px;height:200px;">&nbsp;</div>
    <div class="pop-filter" style="width:240px;">
      <div class="pop-top-l">
        <div class="pop-top-r">
          <div class="pop-top-m">页面上部修饰</div>
        </div>
      </div>
      <div class="pop-middle-l">
        <div class="pop-middle-r">
          <div class="pop-middle-m">
            <div class="pop-content" style="width:220px;height:310px;" id="popfilterdiv">
              <div class="h2" style="text-align:center;">
                <span class="txt18 vertical-middle bold instnameelli" title="<s:property value="instance.getName()" />"><span id="resState" class="<s:property value="state" />" style="cursor:default;">&nbsp;&nbsp;</span><s:property value="instance.getName()" /></span>
              </div>
              <table style="color:#fff;" class="margin5">     
  <%
  Map<String, String> infoMap = (Map<String, String>)request.getAttribute("infoMap"); 
  Set<Entry<String, String>> entrySet2 = infoMap.entrySet();
  for (Iterator<Entry<String, String>> iterator = entrySet2.iterator(); iterator
          .hasNext();) {
    Entry<String, String> entry = iterator.next();
    String key = entry.getKey();
    String value = entry.getValue();
    if(value==null || "".equals(value)){
    	value = "-";
    }
    String i18nVal = com.mocha.bsm.i18n.I18nUtil.getText(key);
    if("detail.info.ip".equals(key)){ //IP
    		String[] ips = value.split(",");
    		%>
        <tr style="height:26px;">
          <td class="underline-gray vertical-middle bold" style="width:65px;"><nobr><%=i18nVal%></nobr></td>
          <td class="underline-gray vertical-middle bold"><s:text name="detail.colon" /></td>
          <% if(ips.length==1){ %>
            <td class="underline-gray vertical-middle"><%=value%></td>
          <% } else { %>
            <td class="underline-gray vertical-middle">
            <select id="ipselect" style="width:120px;display:none;" iconIndex="0" iconTitle="<s:text name="i18n.manageip" />" iconClass="combox_ico_select f-absolute">
            <% for(int i=0;i<ips.length;i++){ %>
              <option><%=ips[i]%></option>
            <% } %>
            </select>
            </td>
          <% } %>
        </tr>
    		<%
    } else if("detail.info.domain".equals(key)){ // 所属域
    	%>
<tr style="height:26px;"><td class="underline-gray vertical-middle bold" style="width:65px;word-break:break-all;"><%=i18nVal%><%=domainPageName%></td><td class="underline-gray vertical-middle bold"><s:text name="detail.colon" /></td><td class="underline-gray vertical-middle"><span class="nameelli" title="<%=value%>"><%=value%></span></td></tr>
    	<%
    } else if("detail.info.usability".equals(key)){ // 可用性
    	%>
    	<tr style="height:26px;"><td class="underline-gray vertical-middle bold" style="width:65px;"><%=i18nVal%></td><td class="underline-gray vertical-middle bold"><s:text name="detail.colon" /></td><td class="underline-gray vertical-middle"><span class="nameelli" title="<%=value%>"><%=value%>&nbsp;&nbsp;&nbsp;&nbsp;<span id="availPie" class='ico ico-pie' title='<s:text name="detail.msg.availstatistics" />'></span></span></td></tr>
    	<%
    } else {
    	%>
<tr style="height:26px;"><td class="underline-gray vertical-middle bold" style="width:65px;"><nobr><%=i18nVal%></nobr></td><td class="underline-gray vertical-middle bold"><s:text name="detail.colon" /></td><td class="underline-gray vertical-middle"><span class="nameelli" title="<%=value%>"><%=value%></span></td></tr>
    	<%
    }
  } // end for
  %>
              </table>
            </div>
          </div>
        </div>
      </div>
      <div class="pop-bottom-l">
        <div class="pop-bottom-r">
          <div class="pop-bottom-m">页面下部修饰</div>
        </div>
      </div>
    </div>
  </div>
  <div id="content" style="float:left;width:735px;height:100%;">
    <s:if test="currentNav!=null">
      <s:action name="%{currentNav}" namespace="/detail" executeResult="true" flush="false"></s:action>
    </s:if>
  </div>
  <div class="equipment-bottom t-right" id="bottomToolsDiv">
  <%
  Map<String, String> bottomButtons = (Map<String, String>)request.getAttribute("bottomButtons"); 
  Set<Entry<String, String>> entrySet3 = bottomButtons.entrySet();
  for (Iterator<Entry<String, String>> iterator = entrySet3.iterator(); iterator
          .hasNext();) {
    Entry<String, String> entry = iterator.next();
    String key = entry.getKey();
    String value = entry.getValue();
    String i18nKey = com.mocha.bsm.detail.util.I18NUtil.getI18NKey(key);
    String i18nVal = com.mocha.bsm.i18n.I18nUtil.getText(i18nKey);
    if(value!=null && value.indexOf("menuitem")!=-1){
    	%>
<span class="black-btn-l" key="<%=key%>" params="<%=value%>" <s:if test="!canOperate">disabled style="cursor:default;"</s:if>><span class="btn-r"><span class="btn-m"><a><%=i18nVal%></a><a class="down"></a></span></span></span>
    	<%
    }else{
    	%>
<span class="black-btn-l" key="<%=key%>" params="<%=value%>" <s:if test="!canOperate">disabled style="cursor:default;"</s:if>><span class="btn-r"><span class="btn-m"><a><%=i18nVal%></a></span></span></span>
    	<%
    }
  }
  %>
  </div>
</div>
<input type="hidden" name="instanceId" id="instanceId" value="<s:property value="instanceId" />" />
<input type="hidden" name="resourceId" id="resourceId" value="<s:property value="resourceId" />" />
<input type="hidden" name="discoveryIp" id="discoveryIp" value="<s:property value="discoveryIp" />" />
<script type="text/javascript">
  var ctxpath = "${ctx}";
  var ACTION_RESULT_NONEXIST = "<%=Constants.ACTION_RESULT_NONEXIST%>";
  var ACTION_RESULT_NONMONITOR = "<%=Constants.ACTION_RESULT_NONMONITOR%>";
  var ACTION_RESULT_NONPERMISSION = "<%=Constants.ACTION_RESULT_NONPERMISSION%>";
  var currentNavigation = "${currentNav}";
  var canOperate = "${canOperate}";
  function clickFlashNavigation(id){
    if(window.$){
      $("#" + id).click();
    }
  }
</script>
<script type="text/javascript" src="${ctxJs}/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="${ctxJs}/component/cfncc.js"></script>
<script type="text/javascript" src="${ctxJs}/component/menu/menu.js"></script>
<script type="text/javascript" src="${ctxJs}/component/comm/winopen.js"></script>
<script type="text/javascript" src="${ctxJs}/component/popwindow/popwin.js"></script>
<script type="text/javascript" src="${ctxJs}/<s:text name="js.i18n.file" />"></script>
<script type="text/javascript" src="${ctxJs}/jquery.blockUI.js"></script>
<script type="text/javascript" src="${ctxJs}/component/gridPanel/page.js"></script>
<script type="text/javascript" src="${ctxJs}/component/panel/panel.js"></script>
<script type="text/javascript" src="${ctxJs}/component/date/WdatePicker.js"></script>
<script type="text/javascript" src="${ctxJs}/component/toast/Toast.js"></script>
<script type="text/javascript" src="${ctxJs}/component/combobox/simplebox.js"></script>
<script type="text/javascript" src="${ctxJs}/resourcedetail/resourcedetail.js"></script>
</body>
</html>