<%@page import="java.util.*"%>
<%@page import="java.lang.Exception"%>
<%@page import="com.mocha.bsm.admin.client.IPageClientMgr"%>
<%@page import="com.mocha.bsm.admin.client.PageMemberPojo"%>
<%@page import="com.mocha.bsm.admin.client.PagePojo"%>
<%@page import="com.mocha.bsm.admin.client.PageBean"%>
<%@page import="com.mocha.bsm.admin.client.IUserClientMgr"%>
<%@page import="com.mocha.bsm.service.proxy.ServiceProxy"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<%

  String current = request.getParameter("current");
  String currentHref = "";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css">
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css">
<decorator:head />
<script src="${ctx}/js/jquery-1.4.2.min.js"></script>
<title>Mocha BSM</title>
<%@ include file="/WEB-INF/common/userinfo.jsp" %>
<%
List<PageBean> pagebeans  =null;
try{
  IPageClientMgr pageClientMgr= (IPageClientMgr) ServiceProxy.getService(IPageClientMgr.class);
  if(isSystemAdmin||isAdmin){
     pagebeans = pageClientMgr.getPagesByProductName(PagePojo.S_IS_BSM);
  }else{
     pagebeans = pageClientMgr.getPagesByUserId( userId, PageMemberPojo.S_IS_ROLE, PagePojo.S_IS_BSM);
  }
   //userId 是从userinfo.jsp里拿到的  IUserClientMgr.DEFAULT_USER是默认用户
  
}catch(Exception e){
  out.print(e);
}
%>
  <script src="${ctx}/js/jquery.layout-1.2.0.js"></script>
  <script src="${ctx}/js/index.js"></script>
 <decorator:getProperty property="head"/>
</head>
<body style="background-color:black;" >
<!-- manually attach allowOverflow method to pane --> 
<div class="ui-layout-north" style="min-width: 1003px; height: 100%">
  <div id="header">
    <div id="topNav">
      <ul>
        <%if(isSystemAdmin||isAdmin||isConfigMgrRole){%>
        <li id="mochaadmin" href="/mochaadmin/index.action"><a href="javascript:void(0)">系统管理</a></li>
        <li id="found" href="${ctx}/discovery/discovery-main.action"><a href="javascript:void(0)">发现</a></li>
        <%}%>
        <li id="userinfo" href="/mochaadmin/organization/user/user-content.action"><a href="javascript:void(0)">用户信息</a></li>
                <%--<li><a href="javascript:void(0)">使用向导</a></li>--%>
                <li id="licenseview" href="${ctx}/licenseview/view.action"><a href="javascript:void(0)">软件许可</a></li>
                <li  class="last" id="logout"><a href="javascript:void(0)">退出</a></li>
      </ul>
    </div>
    <div ><img src="${adminCtx}/upload/imageslogo/logo.png"/></div>
  </div>
</div>  
<!-- allowOverflow auto-attached by option: west__showOverflowOnHover = true <div class="ui-layout-west">1</div> -->
<div id="layoutCenterDiv" class="ui-layout-center" style="overflow:auto;">
  <div style="min-width: 1003px; height: 100%">
    <decorator:body /> 
    <decorator:getProperty property="body" />
  </div>
</div>
<div class="ui-layout-south" style="min-width: 1003px;overflow:hidden;">
  <div class="menuToolBar-div">
    <div id="menubar" class="menubar">
        <div id="menubar_lbtn" class="btn-l-on"><a></a></div>
        <div class="main-menubar" id="main_menubar" style="position:relative;">
        <div class="main-content" id="toolbar_content" style="position:absolute;">
  
    <ul id="menuToolBar" class="menuToolBar">
        <%
        String [] currentids = null;
        String firId = "";
        String secId = "";
          if(current!=null){
            currentids = current.split("\\.");
            if(currentids!=null){
              firId =  currentids[0];
              if(currentids.length>=2){
                secId = currentids[1];
              }
            }
          }
          
          PageBean pagebean = null;
          if(null != pagebeans){
          for(int i=0,len=pagebeans.size();i<len;i++){
            pagebean = (PageBean)pagebeans.get(i);
            String pagebeanid = pagebean.getPageId();
            if(!com.mocha.bsm.homepage.config.LicenseConfig.hasLicense(pagebean.getLicense())){
              continue;
            }
            
            String pageHref = pagebean.getPath()==null?"":pagebean.getPath();
            String pageName = pagebean.getPageName();
            String headfoot = pagebean.getHeadfoot();
            boolean pageIsSys =pagebean.getIsSys() == 1 ? true : false;
            String pageImageName = pageIsSys ? "/pureportal/images/ico/"+pagebean.getImagePath() :"/mochaadmin/"+pagebean.getImagePath(); 
            List<PageBean> childlist = pagebean.getChildList();
            String width="";
            String style="";
            String currentt = "";
            String isclick = !pageHref.equals("") ? "isclick=\"true\"" : "";
            String notExpend = "";
            boolean isSingle= false;//是否有二级节点

            if(childlist == null || childlist.size()==0){
              isSingle = true;
            }

            String _isBlank = pagebean.getTabWay();
            String _blankStr = "";
            if(_isBlank != null && PagePojo.S_ISPOPUP.equals(_isBlank)){
              _blankStr = "target=\"_blank\"";
            }
            if(pagebeanid.equals(firId)){  //改一级节点是当前显示的节点
               currentt = "current=\"true\""; 
               if(isSingle || "".equals(secId)){
                if("".equals(_blankStr) && pageHref.indexOf("pureportal")==-1){
                  pageHref = "/pureportal/index_out.jsp?current="+pagebeanid;               
                }else{
                  pageHref = pageHref+"?current="+pagebeanid;
                }
                currentHref = pageHref;
                if(!"1".equals(headfoot) && pagebeanid.equals(firId)){
                    // pureportal项目外的连接
                    currentHref = pagebean.getPath();
                }
               }else{
                 width="style=\"width:450px\"";
                 style="style=\"display: block; margin-left: 0px;\"";
               }
            }
            
            if(!"1".equals(headfoot)){
                // 第三方url
                pageHref = "/pureportal/index_out.jsp?current="+pagebeanid; 
              }
              // 弹出页面
              if(_isBlank != null && PagePojo.S_ISPOPUP.equals(_isBlank)){
                pageHref = pagebean.getPath();
                if(isSingle && pagebeanid.equals(firId)){
                if(currentHref.indexOf("?")!=-1){
                  currentHref = currentHref + "&ispopup=true";
                }else{
                  currentHref = currentHref + "?ispopup=true";
                }
                }
              }
            
            if(isSingle){
               notExpend="notExpend=\"true\"";
            }
        %>
          <li id="<%=pagebeanid %>" <%=width %> <%=currentt %> <%=_blankStr %> <%=notExpend %> <%=isclick %> url="<%=pageHref%>">
            <div <%=(!currentt.equals("") && isSingle)?"class=\"menuon\"":"class=\"menu\"" %>>
              <span class="img"><img src="<%=pageImageName %>" width="45" height="31"></span>
              <span class="txt"><%=pageName %></span>
            </div>
        <%
            if(!isSingle){ //如果有2级菜单
        %>
            <ul class="sub_option_menu" <%=style %>>
        <%
              for(int j=0,lens = childlist.size();j<lens;j++){
                PageBean secPagebean =(PageBean)childlist.get(j); 
                if(    secPagebean.getLicense()!=null 
                  && !com.mocha.bsm.homepage.config.LicenseConfig.hasLicense(secPagebean.getLicense()))
                {
                  continue;
                }
                String secPagebeanid = secPagebean.getPageId();
                
                String secPageHref = secPagebean.getPath();
                String secPageName = secPagebean.getPageName();
                boolean secPageIsSys =secPagebean.getIsSys() == 1 ? true : false;
                String isBlank = secPagebean.getTabWay();
                String blankStr = "";
                if(isBlank != null && PagePojo.S_ISPOPUP.equals(isBlank)){
                  blankStr = "target=\"_blank\"";
                }
                //String secPageImageName = secPageIsSys ? "/pureportal/images/ico/"+secPagebean.getImagePath() :"/mochaadmin/"+secPagebean.getImagePath(); 
                String cls = "";
                if(secPagebeanid.equals(secId)){
                  cls="on";
                  currentHref = secPageHref;
                }
                if("".equals(blankStr) && secPageHref.indexOf("pureportal")==-1){
                    secPageHref = "/pureportal/index_out.jsp?current="+pagebeanid+"."+secPagebeanid;                
                }else{
                  secPageHref = secPageHref+"?current="+pagebeanid+"."+secPagebeanid;
                }
        %>
              <li><a  class="<%=cls %>" href="<%=secPageHref %>" id="<%=secPagebeanid %>" <%=blankStr%> ><%=secPageName%></a></li>
        <%        
              }
        %>
            </ul>
          </li>
        <%
            }
          }
        }
        %>
    </ul>
  
  
      </div>
    </div>
    
    <div id="menubar_rbtn" class="btn-r-on"><a></a></div>
  
</div>
  </div>
</div>
 

 
<script>
var currentHref = "<%=currentHref%>";
var isStandAlone = <%=com.mocha.bsm.system.SystemContext.isStandAlone()%>;
</script>
<script src="${ctx}/js/component/cfncc.js"></script>
<script src="${ctx}/js/component/comm/winopen.js"></script>
<script src="${ctx}/js/component/popwindow/popwin.js"></script>
<script type="text/javascript">
  var info = new information({text:'请先初始化系统，在‘系统管理->系统部署’中发现Agent并注册系统服务CMS/DCH/DMS。'});
  $("#found").click(function(){
    var url = $(this).attr("href");
    if(isStandAlone) {
      var height = window.screen.availHeight-35;
      var width = 918;
      winOpen({
          url:url,
          width:width,
          height:height,
          name:"found",
          scrollable:true
        });
    } else {
      $.ajax({
        type:"GET",
        dataType:'json',
        url:"${ctx}/resourcemanage/resManage!dmsList.action",
        data:"pageQueryVO.domainId=",
        success:function(data, textStatus){
          var dmsList = (new Function("return "+data.dmsJson))();
          if(dmsList.length > 0) {
            var height = window.screen.availHeight-35;
            var width = 918;
            winOpen({
                url:url,
                width:width,
                height:height,
                name:"found",
                scrollable:true
              });
          } else {
            info.show();
          }
        }
      });
    }
    
    //window.open(,"found","height="+ height + ",width="+width+",left="+left+",top="+top+",scrollbars=yes,resizable=yes");

    });
  $("#userinfo").click(function(){
    var height = 330;
    var width = 660;

    winOpen({
        url:$(this).attr("href"),
        width:width,
        height:height,
        name:"userinfo",
        scrollable:true
      });
    //window.open(,"found","height="+ height + ",width="+width+",left="+left+",top="+top+",scrollbars=yes,resizable=yes");

    });
  $("#mochaadmin").click(function(){
    
    //window.open($(this).attr("href") ,"mochaadmin","height="+ height + ",width="+width+",left="+left+",top="+top+",scrollbars=yes,resizable=yes");
    window.location="/pureportal/index_out.jsp?current=admincontrol";
        }
        );  
  $("#licenseview").click(function(){
    winOpen({
      url:$(this).attr("href"),
      width:605,
      height:615,
      name:"licenseview",
      scrollable:false
    });
    
        }
        );  
  var quit_confirm = new confirm_box({text:"是否确认退出系统？"});

  quit_confirm.setClose_listener(function(){
    if($("#layoutCenterDiv").get(0)){
      $("#layoutCenterDiv").get(0).style.display="block";
    }
    quit_confirm.hide();
  });
   
  quit_confirm.setCancle_listener(function(){
   if($("#layoutCenterDiv").get(0)){
     $("#layoutCenterDiv").get(0).style.display="block";
   }
   quit_confirm.hide();
  });
  
  quit_confirm.setConfirm_listener(function(){
    window.location = "${ctx}/homepage/logout.action";
  });
  $("#logout").click(
      function(){
        if($("#layoutCenterDiv").get(0)){
          $("#layoutCenterDiv").get(0).style.display="none";
        }
        quit_confirm.show();
  });
</script>
</body>
</html>
