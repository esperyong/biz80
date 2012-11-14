<%--
	modules/itpm/strategy/move_handler.jsp
	author: wangtao@mochasoft.com.cn
	Description: 工单触发策略 - 选择处理人
--%>
<%@page import="com.mocha.bsm.admin.client.DomainPojo"%>
<%@ page language="java" contentType="text/html;charset=UTF-8" errorPage="/modules/common/error.jsp"%>
<jsp:directive.page import="com.mocha.dev.ReqRes"/>
<jsp:directive.page import="java.util.List"/>
<jsp:directive.page import="java.util.ArrayList"/>
<jsp:directive.page import="java.util.Arrays"/>
<jsp:directive.page import="com.mocha.bsm.itom.view.UserDomainManage"/>
<jsp:directive.page import="com.mocha.bsm.itom.vo.UserVO"/>
<%@ include file="/modules/common/security.jsp"%>
<%
   ReqRes rr = new ReqRes(request, response);
   rr.encoding("UTF-8").nocache().security();

   String left_handler = rr.param("left_sel_person",null);
   String right_handler = rr.param("right_sel_person",null);
   List lefts = new ArrayList();
   List rights = new ArrayList();

   if(!rr.empty(left_handler)) {
   		lefts = Arrays.asList(left_handler.split(","));
   }
   if(!rr.empty(right_handler)) {
   		rights = Arrays.asList(right_handler.split(","));
   }

   DomainPojo[] userdomain = UserDomainManage.getInstance().getUserDomainByDomainId(userDomainId);
   List list = UserDomainManage.getInstance().getUserList(userdomain);
   List left_person = new ArrayList();
   List right_person = new ArrayList();

   if(!list.isEmpty()) {
   		for(int i=0; i< list.size(); i++) {
   			UserVO vo = (UserVO)list.get(i);
   			if(lefts.contains(vo.getUserId())){
   				left_person.add(vo);
   			} else if(rights.contains(vo.getUserId())) {
   				right_person.add(vo);
   			}
   		}
   }


%>
<script language="javascript">
//alert('<%=left_handler%>');
//alert('<%=right_handler %>');
var left_html = "";
var right_html = "";
var common_html_start = "<table width=\"215\" cellpadding=\"0\" cellspacing=\"0\">";
var common_html_end = "</table>";

//左列表
<%	if(!rr.empty(left_person)) {
		for(int i=0; i< left_person.size(); i++) {
			UserVO vo = (UserVO)left_person.get(i);
%>
	  left_html +="<tr>";
	  left_html +="<td width=\"11%\" align=\"left\"><input type=\"checkbox\" name=\"left_handler\" value=\"<%=vo.getUserId() %>\"></td>";
	  left_html +="<td width=\"52%\" align=\"left\"><%=vo.getUserName()%></td>";
	  left_html +="<td width=\"41%\" align=\"left\"><%=vo.getUserId()%></td>";
	  left_html +="</tr>";

<%		}
	}else {
%>
	  left_html +="<tr>";
	  left_html +="<td height=\"23\" align=\"left\">&nbsp;</td>";
	  left_html +="<td align=\"left\" bgcolor=\"#FFFFFF\">&nbsp;</td>";
	  left_html +="<td align=\"left\">&nbsp;</td>";
	  left_html +="</tr>";
<%
	}
%>

//右列表
<%	if(!rr.empty(right_person)) {
		for(int i=0; i< right_person.size(); i++) {
			UserVO vo = (UserVO)right_person.get(i);
%>
	  right_html +="<tr>";
	  right_html +="<td width=\"12%\" align=\"left\"><input type=\"checkbox\" name=\"right_handler\" value=\"<%=vo.getUserId() %>\"></td>";
	  right_html +="<td width=\"53%\" align=\"left\"><%=vo.getUserName()%></td>";
	  right_html +="<td width=\"35%\" align=\"left\"><%=vo.getUserId()%></td>";
	  right_html +="</tr>";
<%		}
	}else {
%>
	  right_html +="<tr>";
	  right_html +="<td height=\"23\" align=\"left\">&nbsp;</td>";
	  right_html +="<td align=\"left\" bgcolor=\"#FFFFFF\">&nbsp;</td>";
	  right_html +="<td align=\"left\">&nbsp;</td>";
	  right_html +="</tr>";
<%
	}
%>
parent.document.getElementById("left_person").innerHTML = common_html_start + left_html + common_html_end;
parent.document.getElementById("right_person").innerHTML = common_html_start + right_html + common_html_end;
parent.document.formname.left_all.checked = false;
parent.document.formname.right_all.checked = false;
</script>
</HTML>