<%--
	modules/itpm/strategy/resource/resource/select_resourcetype.jsp
	author: wangtao@mochasoft.com.cn
	Description: 工单触发策略 - 资源查询-资源类型选择
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" errorPage="/modules/common/error.jsp"%>
<jsp:directive.page import="com.mocha.dev.ReqRes"/>
<jsp:directive.page import="java.util.List"/>
<jsp:directive.page import="com.mocha.bsm.itom.mgr.plugin.ResourceQueryMgr"/>
<jsp:directive.page import="com.mocha.bsm.itom.vo.CategoryVO"/>
<jsp:directive.page import="com.mocha.bsm.itom.vo.ResourceVO"/>
<jsp:directive.page import="com.mocha.bsm.itom.common.ResourceGroupIconConfig"/>
<jsp:directive.page import="com.mocha.bsm.itom.common.IConsts"/>
<%@ include file="/modules/common/security.jsp"%>
<%
   ReqRes rr = new ReqRes(request, response);
   rr.encoding("UTF-8").nocache().security();

   String categoryidstr = rr.param("categoryidstr", null);
   String[] categoryArr = null;
   if(!rr.empty(categoryidstr)){
		categoryArr =  categoryidstr.split(",");
   }

   List resource_type_list = null;
   if(!rr.empty(categoryArr)){
	   resource_type_list = ResourceQueryMgr.getInstance().query_restype_list(categoryArr);
   }

%>
<HTML>
<HEAD>
<TITLE>Mocha BSM</TITLE>
<link href="<%=cssRootPath %>/common.css" rel="stylesheet" type="text/css">
<script src="<%=jsRootPath %>/MTree.js"></script>
<script language="javascript">
//通用日志策略树
	var tree1 = new MTree("<%=imgRootPath%>/treeImages");  //新建一个树的实例
	tree1.setTreeName("tree1");  //为树命名，此处的参数应该与树的实例的名字一样
	tree1.setAutoReload();//是否动态生成.
	tree1.addNode(new MTreeNode("root","0",null,null,"","<img src='<%=imgRootPath%>/folder_picture.gif'><span style='cursor:hand;' onclick=setSelect('all','all',this);>全部</span>",""));

	<% if(!rr.empty(resource_type_list)){

			for(int i=0; i<resource_type_list.size(); i++){
				CategoryVO vo = (CategoryVO)resource_type_list.get(i);
	%>
				tree1.addNode(new MTreeNode("<%=vo.getId() %>","root",null,null,"","<img src='<%=imgRootPath%>/<%=ResourceGroupIconConfig.get(vo.getId()+IConsts.ICO_SUFFIX) %>'><span style='cursor:hand;' onclick=setSelect('<%=vo.getId()%>','category',this);><%=vo.getName() %></span>",""));
	<%			List t_childs=vo.getResourcelist();
				if(t_childs!=null&&t_childs.size()>0) {
					for(int j = 0; j < t_childs.size(); j++){
						CategoryVO t_child = (CategoryVO)t_childs.get(j);
	%>
				tree1.addNode(new MTreeNode("<%=t_child.getId() %>","<%=vo.getId()%>",null,null,"","<span style='cursor:hand;' onclick=setSelect('<%=t_child.getId()%>','category',this);><%=t_child.getName()%></span>",""));
	<%          List t_leafs=t_child.getResourcelist();
					if(t_leafs!=null&&t_leafs.size()>0){
						for(int k = 0; k < t_leafs.size(); k++){
							CategoryVO t_leaf = (CategoryVO)t_leafs.get(k);
    %>
   				tree1.addNode(new MTreeNode("<%=t_leaf.getId() %>","<%=t_child.getId()%>",null,null,"","<span style='cursor:hand;' onclick=setSelect('<%=t_leaf.getId()%>','category',this);><%=t_leaf.getName()%></span>",""));
    <%				} // k
	                } //if
	              } // j
				}//if 
	  } //i
	}%>

	var treehtml3=tree1.getTreeHtmlAutoLoad();
</script>
</HEAD>
<BODY>
<div id="menu_id1" align="left">
     <script>
		//将对象结构转为html，写到网页中
		document.write(treehtml3);
		//tree1.expandAll();
     </script>
</div>
<!-- 提交到IFRAME-->
</BODY>
<script language="javascript">
function setSelect(id, type, e) {
	var newObj = new Option(e.innerHTML);
	var obj = parent.document.formname.categorytype;
	obj.remove(0);
	obj.add(newObj);
	parent.changeType(id, type, e.innerHTML);
}
</script>
</HTML>