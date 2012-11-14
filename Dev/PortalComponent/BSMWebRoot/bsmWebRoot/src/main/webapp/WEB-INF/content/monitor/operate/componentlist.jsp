<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html>
<head>
	<%@ include file="/WEB-INF/common/meta.jsp" %>
	<style type="text/css">
		.span.elli{width:95%;text-overflow:ellipsis;white-space:nowrap;overflow:hidden;word-spacing:normal; word-break:normal;display:block;}
</style>
<script type="text/javascript" src="${ctxJs}/monitor/componentlist.js"></script>
<script type="text/javascript">
        var items={};//存放每种组件相应的gridpanel，page，accordionpanel对象,key为组件资源组ID
		var path = "${ctx}";
		var config = {};
		config.width = 555;
		config.columnWidth = {AllowMonitor:20,text:84,name:173,description:173,ImpactParameter:105};
		config.render = [{index : "name",
		            fn : function(td) {
		              $name = $('<span style="cursor:pointer" instid="'+td.value.hidId+'" resid="'+td.value.hidResourceId+'" name="'+td.html+'" title="'+td.html+'" description="'+td.value.hidDescription+'" impactFactor="'+td.value.hidImpactParameter+'" rowIndex="'+td.rowIndex+'">'+td.html+'</span>');
		              $name.bind("click",clickBinding);
		              return $name;
		            }
		          },{index : "description",
		            fn : function(td) {
		              $description = $('<span style="cursor:default" instid="'+td.value.hidId+'" resid="'+td.value.hidResourceId+'" name="'+td.html+'" title="'+td.html+'" description="'+td.value.hidDescription+'" impactFactor="'+td.value.hidImpactParameter+'" rowIndex="'+td.rowIndex+'">'+td.html+'</span>');
		              return $description;
		            }
		          }];
	  // 分页组件对应的url
		var url = path + "/monitor/maintainSetting!singlcomponent.action?instanceId="+$("#instanceId").val();
		// 点击名称弹出编辑页面
		var clickBinding = function(event){
		  $a = $(this);
		  var instId = $a.attr("instid");
		  var resId = $a.attr("resid");
		  var description = $a.attr("description");
		  if( description && description == "-" ){
			  description = "";
		  }
		  var impactFactor = $a.attr("impactFactor");
		  var name = $a.attr("name");
		  $("#editFrom input[name='instanceId']").val(instId) ;
	      $("#editFrom input[name='description']").val(description);
	      $("#editFrom input[name='impactFactor']").val(impactFactor);
	      $("#editFrom input[name='instanceName']").val(name);
		  var rowIndex = $a.attr("rowIndex");
		  var offset = $a.offset();
		  var editUrl = path+"/monitor/maintainSetting!editcomponent.action?"+$("#editFrom").serialize();
		  editPanel = new winPanel({
		        id:"editPanleId",
		        title:"编辑组件",
		        isautoclose:true,
		        isDrag:true,
		        isFloat:true,
		        cls:"pop-div",
		        x:offset.left,
		        y:offset.top,
		        tools:[{
		          text:"确定",
		          click:function(){
		          	//alert($("#editComponentForm").serialize());
		            //提交编辑，修改grid内容
		            if(!$.validate($("#editComponentForm"))) {return;}
		            if(!items){
		             return;
		            }
		            var item = items[resId];
		            $.ajax({
 	                      type: "POST",
 	                      dataType: 'json',
 	                      url: path+"/monitor/maintainSetting!savecomponent.action?"+$("#editComponentForm").serialize(),
 	                          success: function(data, textStatus) {
		            	       var gp = item.gridPanel;
				               modifyValue = {};
				               modifyValue.name = $("#editname").val();
				               modifyValue.title = $("#editname").val();
				               modifyValue.description = $("#editdesc").val();
				               modifyValue.ImpactParameter = $("#editimpactFactor").val();
				               modifyRow(gp,rowIndex,modifyValue);
				               editPanel.close("close");
 	                      }
 	                });
		           
		          }},{
		          text:"取消",
		          click:function(){
		            editPanel.close("close");
		           }}],
		        listeners:{
		          closeAfter:function(){
		            panel = null;
		            $(".formError").click();
		          },
		          loadAfter:function(){
		          }
		        },
		         url:editUrl
		     },{
		    winpanel_DomStruFn:"pop_winpanel_DomStruFn"
		  });
		  editPanel.setPosition(offset.left+10,offset.top+10);
		};
		// 修改组件信息
		function modifyRow(gp,rowIndex,modifyValue){
			gp.getRowByIndex(rowIndex).value.hidDescription = modifyValue.description; //隐藏域修改方式
			gp.getRowByIndex(rowIndex).value.hidImpactParameter = modifyValue.ImpactParameter; //隐藏域修改方式
		  for(var p in modifyValue){
		    //gp.refreshCell(rowIndex,"profile",""); 非隐藏域修改方式
		    gp.refreshCell(rowIndex,p,modifyValue[p]);
		  }
		}
	</script>
</head>
<body>
<div style="height:390px;overflow-x:hidden;overflow-y:auto;position:relative;">
<form id="editFrom">
	<input type="hidden" name="instanceId"/>
	<input type="hidden" name="instanceName"/>
	<input type="hidden" name="impactFactor"/>
	<input type="hidden" name="description"/>
</form>
<s:if test="componentList == null || componentList.size() == 0">
   <div class="grid-black" style="height:350px;">
	  <div class="formcontent" style="height:350px;">
	    <table style="height:350px;width:100%;">
	      <tbody>
	        <tr>
	         <td class="nodata vertical-middle" style="text-align:center;">
	           <span class="nodata-l">
	              <span class="nodata-r">
	                <span class="nodata-m"> <span class="icon">当前无数据</span> </span>
	              </span>
	            </span>
            </td>
          </tr>
	      </tbody>
	    </table>
	  </div>
	</div>
</s:if>
<s:else>
<s:iterator value="componentList" var="compMap" status="status">
	<page:applyDecorator name="accordionAddSubPanel">
		<page:param name="id">panelid_<s:property value="#status.index" /></page:param>
		<page:param name="title"><s:property value="#compMap.childResourceName" />(<s:property value="#compMap.totalCount" />)</page:param>
		<page:param name="width">570px</page:param>
		<page:param name="display"><s:if test="#status.first"></s:if><s:else>collect</s:else></page:param>
		<page:param name="cls">fold-blue</page:param>
		<page:param name="content">
		<!-- content start -->
		  <div style="color:black;">
		    <page:applyDecorator name="indexcirgrid">
		       <s:property value="#compMap.gridhead" escape="false" />
		       <page:param name="id">gridid_<s:property value="#status.index" /></page:param>
		       <page:param name="width">555</page:param>
		       <page:param name="linenum">0</page:param>
		       <page:param name="tableCls">roundedform</page:param>
		       <page:param name="gridhead"><s:property value="#compMap.gridhead" escape="false" /></page:param>
		       <page:param name="gridcontent"><s:property value="#compMap.gridcontent" escape="false" /></page:param>
		     </page:applyDecorator>
		     <div id="pageid_<s:property value="#status.index" />"></div>
		  </div>
		<!-- content end -->
		</page:param>
	</page:applyDecorator>
    <script type="text/javascript">
    var tableResourceId = "<s:property value="#compMap.childResourceId" />";
    var gp_<s:property value="#status.index" /> = createGridPanel("gridid_<s:property value="#status.index" />",config);
    var page_<s:property value="#status.index" /> = createPagination("pageid_<s:property value="#status.index" />",url+"&childResourceId="+tableResourceId,"<s:property value="#compMap.pageCount" />",gp_<s:property value="#status.index" />);
    var panel_<s:property value="#status.index" /> = createAccordionPanel("panelid_<s:property value="#status.index" />");
      //bindCheckAll(checkBoxAllId,tableResourceId);
    items["<s:property value="#compMap.childResourceId" />"] = {
    	    gridPanel : gp_<s:property value="#status.index" />,
          pagination : page_<s:property value="#status.index" />,
          accordionPanel : panel_<s:property value="#status.index" />
    };
    </script>
</s:iterator>
</s:else>
</div>

</body>
    <script type="text/javascript">
     $("input[name='checkAll']").bind("click", function(event) {  
    	 var resourceId = $(this).attr("resourceId_checkAll");
		 if ($(this).attr("checked") == true) { // 全选
			    $("input[resourceId='"+resourceId+"']:enabled").each(function() {
			    	var $self = $(this);
			        $self.attr("checked", true);
			        var checkValue = $self.attr("checked").toString();
			        var instanceId = $(this).attr("instanceId");
			        if( checkValue != $(this).attr("allowMonitor") ){
			        	childMap.put(instanceId,checkValue);
				    }else{
				    	childMap.remove(instanceId,checkValue);
				    }
			   });
	     } else { // 取消全选
	    	 $("input[resourceId='"+resourceId+"']:enabled").each(function() {
	    	 	    var $self = $(this);
			        $self.attr("checked", false);
			        var checkValue = $self.attr("checked").toString();
			        var instanceId = $(this).attr("instanceId");
			        if( checkValue!= $(this).attr("allowMonitor") ){
			        	childMap.put(instanceId,checkValue);
				    }else{
				    	childMap.remove(instanceId,checkValue);
				    }
			   });
	     }
	});
     $("input[name='checkChild']").bind("click", function(event) {
     	 var $self = $(this);
     	 var resourceId = $self.attr("resourceId");
     	 if ($self.attr("checked") == false) {
     	      $("input[resourceId_checkAll='"+resourceId+"']").attr("checked", false);
     	 }
     	 var checkValue = $self.attr("checked").toString();
     	 var instanceId = $self.attr("instanceId");
    	 if( checkValue != $self.attr("allowMonitor") ){
	        childMap.put(instanceId,checkValue);
		 }else{
		    childMap.remove(instanceId,checkValue);
		 }
     });
     </script>
</html>