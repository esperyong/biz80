<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<%@ include file="/WEB-INF/common/userinfo.jsp" %>
	        <div name="isSearch" class="for-inline">
		          <span class="txt-white" style="float:left;height:21px;line-height:21px;"><%=domainPageName%></span>
		          <form id="form2">
						  <select id="domain" name="domain" class="" style="float:left;height:21px;line-height:21px;">
		                         <s:if test="domainMap != null && domainMap.size() > 1">
		                         <option value="">全部</option>
		                         </s:if>
                                 <s:iterator value="domainMap" var="map" status="stat">
                                 <option value="<s:property value=" #map.key " />">
                                     <s:property value="#map.value" />
                                </option>
                                </s:iterator>
                          </select
                           ><select id="isMonitor" name="monitor" style="float:left;height:21px;line-height:21px;">
                                <option value="">全部</option>
		                        <option value="monitor">已监控</option>
		                        <option value="noMonitor">未监控</option>
		                  </select
		                  ><select id="searchWhat" name="searchWhat" style="float:left;height:21px;line-height:21px;">
		                        <option value="searchIP">IP地址</option>
		                        <option value="searchName">显示名称</option>
		                  </select
		                  ><input type="hidden" name="pointId" id="pointId" value="<s:property value="pointId "/>"/
                          ><input type="hidden" name="pointLevel" id="pointLevel" value="<s:property value="pointLevel "/>"/
                          ><input type="hidden" name="isAdmin" id="isAdmin" value="<%=isAdmin %>"/
                          ><input type="hidden" name="currentUserId" id="currentUserId" value="<s:property value="currentUserId "/>"/
		                  ><input type="text" id="searchMonitor" name="search" value="请输入条件搜索"  class="inputoff"/><span title="点击进行搜索" id="searchMonitorBut" class="ico"></span
                  ></form>
          </div>
          <div class="clear"></div>
			<page:applyDecorator name="indexcirgrid">  
                     <page:param name="id">standbyResourceTable</page:param>
                     <page:param name="width">100%</page:param>
                     <page:param name="height">540px</page:param>
                     <page:param name="lineHeight">25px</page:param>
                     <page:param name="tableCls">grid-black</page:param>
                     <page:param name="gridhead"><s:property value="titleJson" escape="false" /></page:param>
                     <page:param name="gridcontent"><s:property value="gridJson" escape="false" /></page:param>
            </page:applyDecorator>	   
          <div id="page"></div>
<script type="text/javascript">
	var gridJson = <s:property value="gridJson"  escape="false"/>;
	function coder(str) {   
	       var s = "";   
	       if(str.length == 0)
	           return s;   
	       for(var i=0; i<str.length; i++) {
		       switch (str.substr(i,1)) {
			        case '"':	s += "&#34;";  break;	// 双引号 &quot;
					case '$':	s += "&#36;";  break;
					case '%':	s += "&#37;";  break;
					case '&':	s += "&#38;";  break;	// &符号 &amp;
					case '\'':	s += "&#39;";  break;	// 单引号
					case ',':	s += "&#44;";  break;
					case ':':	s += "&#58;";  break;
					case ';':	s += "&#59;";  break;
					case '<':	s += "&#60;";  break;	// 小于 &lt;
					case '=':	s += "&#61;";  break;
					case '>':	s += "&#62;";  break;	// 大于 &gt;
					case '@':	s += "&#64;";  break;	// @
					case ' ':	s += "&#160;"; break;	// 空格 &nbsp;
					case '©':	s += "&#169;"; break;	// 版权 &copy;
					case '®':	s += "&#174;"; break;	// 注册商标 &reg;
			       default : s += str.substr(i,1); 
		       }
	      }   
	      return s;
		}  
$(function(){
	var self = this;
	var pointId = '<s:property value="pointId"/>';
	var pointLevel = '<s:property value="pointLevel"/>'	
		$("#standbyResourceTable input[name='checkAll']").bind("click",function(event) {
		    if ($(this).attr("checked") == true) { // 全选
		        $("#standbyResourceTable input[name='checkOneNoMonitor']").each(function() {
		            $(this).attr("checked", true);
		           // alert($(this).val());
		            paramMap.put($(this).val(),$(this));
		        });
		    } else { // 取消全选
		        $("#standbyResourceTable input[name='checkOneNoMonitor']").each(function() {
		            $(this).attr("checked", false);
		        });
		        paramMap.remove($(this).val(),$(this));
		    }
		});
	var $searchText = $("#searchMonitor");
	$searchText.bind("focus", function(event) {
	    $searchText.removeClass();
	    if ($searchText.val() == "请输入条件搜索") {
		     $searchText.val("");
	    }
	});
	$searchText.bind("blur", function(event) {
	    var c = $searchText.val();
	    if (c == null || c == '') {
		      $searchText.val("请输入条件搜索");
		      $searchText.addClass('inputoff');
	    }
	});
	$searchText.bind("keydown", function(event) {
	     var evt = window.event ? window.event : evt;
	     if (evt.keyCode == 13) {
	        var val = $.trim($("#searchMonitor").val());
	        if( val == '请输入条件搜索' ){
	    		val = "";
	    	}
	        $("#searchMonitor").val(val);
	    	$.blockUI({message:$('#loading')});
	        var param = $("#form2").serialize();
	        $.ajax({
	            type: "POST",
	            dataType: 'json',
	            url: path + "/monitor/resourceGroup!resourceAjaxList.action?" + param ,
	            success: function(data, textStatus) {
	                self.gp.loadGridData(data.gridJson);
	                self.page.pageing(data.pageCount,1);
	                SimpleBox.renderAll();
	                $.unblockUI();
	            }
	        });
	     }
	});
     var sortColId = "";
     var sortType = "";
     this.gp = new GridPanel({
    	    id: "standbyResourceTable",
    	    columnWidth: <s:property value="widthJson" escape="false" />,
    	    unit:"%",
            plugins: [SortPluginIndex],
	        sortColumns:[{index:"name",defSorttype:"up"},{index:"IPAddress"}],
            sortLisntenr: function($sort) {
    	    	$.blockUI({message:$('#loading')});
    	    	 var val = $.trim($("#searchMonitor").val());
    	         if( val == '请输入条件搜索' ){
    	  		    val = "";
    	  	    }
    	 	    $("#searchMonitor").val(val);
    	    	var param = $("#form2").serialize();
	       	    sortColId = $sort.colId;
	       	    sortType = $sort.sorttype;
	    	        $.ajax({
	    	            type: "POST",
	    	            dataType: 'json',
	    	            url: path+"/monitor/resourceGroup!resourceAjaxList.action?"+param+"&currentPage="+self.page.current+"&sort="+sortType+"&sortCol="+sortColId,
	    	            success: function(data, textStatus) {
	    	        	         self.gp.loadGridData(data.gridJson);
	    	        	         SimpleBox.renderAll('main-right');
	    	        	         $.unblockUI();
	    	            }
	    	        });
	    	    }
    	},
    	{
    	    gridpanel_DomStruFn: "index_gridpanel_DomStruFn",
    	    gridpanel_DomCtrlFn: "index_gridpanel_DomCtrlFn",
    	    gridpanel_ComponetFn: "index_gridpanel_ComponetFn"
    	});
     self.gp.rend([{
    	    index: "id",
    	    fn: function(td) {
    	        if (td.html != "") {
    	        	if(paramMap && paramMap.get(td.value.hidId) != null && paramMap.get(td.value.hidId) != ""){
    	        		$checkbox = $('<input type="checkbox" style="cursor:pointer" checked=true name="checkOneNoMonitor" value="' + td.value.hidId + '" rowIndex="' + td.rowIndex + '"/>');
            	    } else{
    	                $checkbox = $('<input type="checkbox" style="cursor:pointer" name="checkOneNoMonitor" value="' + td.value.hidId + '" rowIndex="' + td.rowIndex + '"/>');
    	            }
    	            $checkbox.bind("click",function() {
        	            if($(this).attr("checked") == true){
        	            	paramMap.put($(this).val(),$(this));
                	    }else{
                	    	paramMap.remove($(this).val(),$(this));
                        }
    	            });
    	            return $checkbox;
    	        } else {
    	            return null;
    	        }
    	    }
    	},
    	{
    	    index: "name",
    	    fn: function(td) {
    	    	var name = "";
    	    	name = td.html;
    	    	if(!name || name == ""){
                     name = td.value.hidDiscoveryIp;    	    	
    	    	}
    	        if (name && name != "") {
    	             $span = $('<span title="'+coder(name)+'">' + name + '</span>');
    	             return $span;
    	        } else {
    	             return null;
    	        }
    	    }
    	},
    	{
    	    index: "IPAddress",
    	    fn: function(td) {
    	        if (td.html != "") {
    	            var tmp = td.html;
    	            var arr = tmp.split(",");
    	            var length = arr.length;
    	            if( length <= 1 ){
    	                return '<span>'+td.html+'</span>';
    	            }
    	            var select = '<select name="ipAddress" iconIndex="0" iconTitle="管理IP" iconClass="ico ico-right for-inline f-absolute" style="width:110px" id="'+td.value.hidId+'">';
    	            for (var i = 0; i < length; i++) {
    	                var option = '<option>' + arr[i] + '</option>'
    	                select += option;
    	            }
    	            select += '</select>';
    	            $select = $(select);

    	            $select.bind("click",
    	            function() {
    	});
    	            return $select;
    	        } else {
    	            return null;
    	        }
    	    }
    	}]);
 this.page = new Pagination({applyId:"page",listeners:{pageClick:function(page){
	    var val = $.trim($("#searchMonitor").val());
        if( val == '请输入条件搜索' ){
 		    val = "";
 	    }
	    $("#searchMonitor").val(val);
	    var param = $("#form2").serialize();
	    $.blockUI({message:$('#loading')});
			 $.ajax({
				   type: "POST",
				   dataType:'json',
				   url: path+"/monitor/resourceGroup!resourceAjaxList.action?"+param+"&currentPage="+page + "&sort="+sortType+"&sortCol="+sortColId,
				   success: function(data, textStatus){
					   self.gp.loadGridData(data.gridJson);
					   if($("#standbyResourceTable input[name='checkOneNoMonitor']:checked").length ==  $("#standbyResourceTable input[name='checkOneNoMonitor']").length) {
						   $("#standbyResourceTable input[name='checkAll']").attr("checked", true);
					   }else{
						   $("#standbyResourceTable input[name='checkAll']").attr("checked", false);
					    }
					   SimpleBox.renderAll('main-right');
					   $.unblockUI();
				   }
				});
	    }
	  }});
	   self.page.pageing("<s:property value="pageCount"/>",1);
	      $("#searchMonitorBut").bind("click", function(event) {
	      	var val = $.trim($("#searchMonitor").val());
	    	if( val == '请输入条件搜索' ){
	   		    val = "";
	   	    }
	        $("#searchMonitor").val(val);
	    	$.blockUI({message:$('#loading')});
	        var param = $("#form2").serialize();
	    	var val = $("#searchMonitor").val();
	        $.ajax({
	            type: "POST",
	            dataType: 'json',
	            url: path + "/monitor/resourceGroup!resourceAjaxList.action?" + param ,
	            success: function(data, textStatus) {
	                self.gp.loadGridData(data.gridJson);
	                self.page.pageing(data.pageCount,1);
	                SimpleBox.renderAll();
	                $.unblockUI();
	            }
	        });
	    });
	 SimpleBox.renderAll('main-right');
});
</script>