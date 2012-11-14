<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@taglib prefix="decorator"
	uri="http://www.opensymphony.com/sitemesh/decorator"%>
<decorator:usePage id="tools" />
<%
	
	String available = tools.getProperty("available");
	String width = tools.getProperty("width"); 
	String isExpend = tools.getProperty("isExpend");
	String btnstring = tools.getProperty("btns");//[[{id:按钮ID,oncls:样式,offcls:样式,available:是否可用，title:悬浮提示},]]
	String footContent = tools.getProperty("content") != null ? (String)tools.getProperty("content") :"";
	
	//是否按钮可以使用
	String btnCls = "";
	if("false".equals(available)){
		btnCls = "footer-gray";//工具栏不可用
	}else if("true".equals(available)){//工具栏可用
		if("true".equals(isExpend)){//默认展开
			btnCls = "";
		}else if("false".equals(isExpend)){
			btnCls = "footer-notool";
		}		
	}

%>
<div id="footer" class="<%=btnCls %>">
 <!-- 底部工具栏 -->
  <div title="点击可展开或关闭工具栏" class="foot-state" id="tool-btn" style="cursor: pointer;"></div>
  <div id="foot-tool-group" style="opacity: 10;">
		<div id="foot-tool-fillet">
			<div id="foot-tool" style="width:<%=width%>" class="left">
	  	<%
	  		if(btnstring != null){
	  			JSONArray btns = JSONArray.fromObject(btnstring);
	  			for(int i=0,ilen = btns.size(); i<ilen; i++){
	  				Object o = btns.get(i);
	  	%>
	  		<ul>
	  	<%
	  				if(o != null){
	  					JSONArray btn = JSONArray.fromObject(o);
	  					for(int j=0,jlen=btn.size(); j<jlen; j++){
		  					JSONObject job = JSONObject.fromObject(btn.get(j));
		  					String cls = "";
		  					String onCls = (String)job.get("oncls");
		  					String offCls = (String)job.get("offcls");
		  					String disableCls = (String)job.get("disablecls");
		  					String able = (String)job.get("available");
		  					if("on".equals(able)){
		  						cls = onCls;
		  					}else if("false".equals(able)){
		  						cls = disableCls;
		  					}else if("off".equals(able)){
		  						cls = offCls;
		  					}
	  					
	  	%>
	  			<li class="<%=cls%>" id="<%=job.get("id") %>" oncls="<%=onCls %>" offcls="<%=offCls %>" disablecls="<%=disableCls %>" able="<%=able %>">
	  				<a href="javascript:void(0);" title="<%=job.get("title") %>"></a>
	  			</li>
	  	<%				
	  					}
	  				}
	  	 %>
	  		</ul>
	  	<%
	  			}
	  		}
	  	 %>
			</div>
		</div>
	</div>
   <div id="foot-stat">
		<%=footContent %>
   </div>
</div>
<script type="text/javascript">
	
	Footools = function(){
		var tools = {};//按钮集合
		var $footer = $("#footer");
		
		var $toolGroup = $("#foot-tool-group");
		var $toolGroups = $("#foot-tool");
		var lis = $footer.find("li");
		var width = "<%=width%>";
		for(var i=0,len= lis.length; i<len; i++){
			var $li = $(lis[i]);
			tools[$li.attr("id")]=$li;
		}
		
		
		return {
			init:function(conf){
				var self = this;
				lis.bind("click",function(){
					var $li = $(this);
					
					if(conf && conf.listeners && !self.isBtnDisable($li.attr("id"))){ //绑定了事件，并且当前按钮是可用状态
						if(conf.listeners.beforeClick){
							if(!conf.listeners.beforeClick($li.attr("id"))){
								return;
							}
						}
						if(conf.listeners.click){
							conf.listeners.click($li.attr("id"));
						}
						if(self.isBtnDisable($li.attr("id"))){
							self.btnDisable($li.attr("id"));
						}else{
							if(self.isBtnOn($li.attr("id"))){
								self.btnOn($li.attr("id"));
							}else{
								self.btnOff($li.attr("id"));
							}
						}
						if(conf.listeners.afterClick){
							conf.listeners.afterClick($li.attr("id"));
						}
					}
				});
				$("#tool-btn").bind("click",function(){
					if(self.isOff()){//如果不可用直接返回
						return;
					}
					if(self.isClose()){
						self.expend();
					}else{
						self.close();
					}
				});
				if(self.isOff()){
					self.off();
				}
			},
			setWidth:function(width){
				$("#foot-stat").width(width);
			},
			off:function(){
				$footer.hide();
			},
			isOff:function(){
				return $footer.hasClass("footer-gray");
			},
			expend:function(){
				$footer.show();
				$footer.removeClass("footer-notool").removeClass("footer-gray");
				$toolGroup.fadeIn("fast");
				$toolGroups.animate( { width:width},{duration: 100 }).fadeIn("normal");
			},
			close:function(){
				$footer.show();
				$footer.removeClass("footer-gray").addClass("footer-notool");
				$toolGroup.fadeOut("fast");
				$toolGroups.animate( { width:"0px"},{duration: 100 }).fadeOut("slow");
			},
			isClose:function(){
				return $footer.hasClass("footer-notool");
			},
			isBtnOn:function(id){
				if(tools[id]){
					var able = tools[id].attr("able");
					if(able == "on"){
						return true;
					}
				}
			},
			isBtnDisable:function(id){
				if(tools[id]){
					var able = tools[id].attr("able");
					if(able == "false"){
						return true;
					}
				}
			},
			btnOn:function(id){
				var $li = tools[id];
				if($li){
					$li.removeClass($li.attr("disablecls"));
					var oncls = $li.attr("oncls");
					if(oncls != "null"){
						$li.removeClass($li.attr("offcls")).addClass(oncls);
						$li.attr("able","on");
					}
				}
			},
			btnOff:function(id){
				var $li = tools[id];
				if($li){
					$li.removeClass($li.attr("disablecls"));
					var offcls = $li.attr("offcls");
					if(offcls != "null"){
						$li.removeClass($li.attr("oncls")).addClass(offcls);
						$li.attr("able","off");
					}
				}			
			},
			btnDisable:function(id){
				var $li = tools[id];
				if($li){
					$li.removeClass($li.attr("oncls")).removeClass($li.attr("offcls"))
					var disablecls = $li.attr("disablecls");
					if(disablecls != "null"){
						$li.addClass(disablecls);
						$li.attr("able","false");
					}				
				}	
			}
		};
	}();
	
	
	
</script>