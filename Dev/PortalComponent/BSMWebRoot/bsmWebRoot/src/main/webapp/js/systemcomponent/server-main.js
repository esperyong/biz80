var tree;
win = new confirm_box({title:'提示',text:'是否确认执行此操作？',cancle_listener:function(){win.hide();}});
var info  = new information({width:"420",height:"130"});
$(document).ready(		
	function() {
		var serverAllMenu = {
			"resource.start" : {
				id : "resource.start",
				text : "启动",
				url : "/pureportal/systemcomponent/server-main!start.action"
			},"resource.stop" : {
				id : "resource.stop",
				text : "停止",
				url : "/pureportal/systemcomponent/server-main!stop.action"
			},"resource.add.dch" : {
				id : "resource.add.dch",
				text : "添加DCH",
				url : "/pureportal/systemcomponent/server-create.action"
			},"resource.add.proxydch" : {
				id : "resource.add.proxydch",
				text : "添加DCH",
				url : "/pureportal/systemcomponent/server-create.action"
			},"resource.add.dms" : {
				id : "resource.add.dms",
				text : "添加DMS",
				url : "/pureportal/systemcomponent/server-create.action"
			},"resource.remove" : {
				id : "resource.remove",
				text : "删除",
				url : "/pureportal/systemcomponent/server-main!remove.action"
			}
			
		}

		// alert(serverAllMenu["resource.add.proxydch"].id);
		var optMenu = new MenuContext( {
			x : 0,
			y : 0,
			listeners:{
				click:function(id){
					handleMenu(id);
				}
			}
		}, {
			menuContext_DomStruFn : "ico_menuContext_DomStruFn"
		});

		var serverId = "";
		var parentId = "";
		var agentId = "";
		var resourceType = "";
		tree = new Tree( {
			id : "serverTree",
			listeners : {
				nodeClick : function(node) {
					load("server_right", "/pureportal/systemcomponent/server-info.action?serverId="
							+ node.getId());
				},
				toolClick : function(node, event) {
					serverId = node.getId();
					parentId = node.getValue("parentId");
					agentId = node.getValue("agentId");
					resourceType = node.getValue("resourceType");
					// 根据菜单字符列表(resource.start,resource.stop,resource.add.dch)生产菜单对象
					var menuStr = node.getValue("menu");
					var menus = menuStr.split(",");
					var menuItems = new Array(menus.length);
					for (var i = 0; i < menus.length; i++) {
						var serverMenu = serverAllMenu[menus[i]];
						var icostr = "addui";
						if("resource.start"==serverMenu.id){
							icostr = "apply";
						}else if("resource.stop"==serverMenu.id){
							icostr = "verboten";
						}else if("resource.remove"==serverMenu.id){
							icostr = "delete";
						}
						var item = [{
								ico : icostr,
								text : serverMenu.text,
								id : serverMenu.id
							}];
						menuItems[i] = item;
					}
										
					optMenu.addMenuItems(menuItems);
					
					optMenu.position(event.pageX, event.pageY);
				}
			}
		});
		
		$("#sp_create").bind(
				"click",
				function(event) {
					optMenu.addMenuItems( [ [ {
						ico: "addui",
						text : "添加CMS",
						id : "start",
						listeners : {
							click : function() {
								load("server_right",
										"/pureportal/systemcomponent/server-create.action?resourceTypeId="
											+ RESOURCE_TYPE_ID_CMS+ "&resourceTypeName=" + RESOURCE_TYPE_NAME_CMS);
							}
						}
					} ] ]);
					optMenu.position(event.pageX, event.pageY);
				});

		$("#sp_info").bind("click", function() {
			load("server_right", "/pureportal/systemcomponent/server-info.action");
		});

		function load(id, url) {
			$.loadPage(id, url, "POST", '', null);
		}
		
		function handleMenu(id) {
			if (id == "resource.start") {
				//alert(tree.getNodeById(serverId)._get$Ico().attr("class"));
				if(tree.getNodeById(serverId)._get$Ico().attr("class")!="lamp lamp-green-ncursor"){
					$.blockUI({message:$('#loading')});
					$.ajax({
						type: "POST",
						url: "/pureportal/system-component/server-main-start!start.action",
						data: {"serverId": serverId},
						dataType: "json",
						success: function(data){ 
						   $.unblockUI();
						   optMenu.hide();
						   //alert(serverId);
						  // alert($("#serverId").val());
						   if(data.identifier=="true"){
							   if(serverId==$("#serverId").val()){
								   //if($("#status").attr("class") != data.statusCss){
								   		//$("#status").removeClass();
								   		//$("#status").addClass(data.statusCss);
								   		//$('#stopStr').show();
								   		//$('#startStr').hide();
								   load("server_right","/pureportal/systemcomponent/server-info.action?serverId=" + serverId);
								   //}
							   }
						   tree.getNodeById(serverId)._get$Ico().removeClass();
						   tree.getNodeById(serverId)._get$Ico().addClass(data.statusCss);
						   }else{
							   toast.addMessage("服务器启动失败。");
						   }
					   }
					});
				}else{
					toast.addMessage("服务器已启动。");
				}
			} else if (id == "resource.stop") {
				///alert(tree.getNodeById(serverId)._get$Ico().attr("class"));
				if(tree.getNodeById(serverId)._get$Ico().attr("class")!="lamp lamp-red-ncursor"){
					win.setContentText("是否确认执行此操作？");
					win.setConfirm_listener(function(){
						win.hide();
						$.blockUI({message:$('#loading')});
						$.ajax({
							type: "POST",
							url: "/pureportal/system-component/server-main-stop!stop.action",
							data: {"serverId": serverId},
							dataType: "json",
							success: function(data){ 
								$.unblockUI();
								optMenu.hide();
								//alert(serverId);
								//alert($("#serverId").val());
								if(data.identifier=="true"){
									if(serverId==$("#serverId").val()){
									   //if($("#status").attr("class") != data.statusCss){
										   //$("#status").removeClass();
										   //$("#status").addClass(data.statusCss);
										  // $('#startStr').show();
										   //$('#stopStr').hide();
									  // }
										load("server_right","/pureportal/systemcomponent/server-info.action?serverId=" + serverId);
									}
									tree.getNodeById(serverId)._get$Ico().removeClass();
									tree.getNodeById(serverId)._get$Ico().addClass(data.statusCss);
								}else{
									toast.addMessage("服务器停止失败。");
								}
						   }
						});
					});
					win.show();
					
				}else{
					toast.addMessage("服务器已停止。");
				}
			} else if (id == "resource.add.dch") {
				load("server_right", "/pureportal/systemcomponent/server-create.action?parentId=" 
						+ parentId + "&resourceTypeId=" + RESOURCE_TYPE_ID_DCH 
						+ "&resourceTypeName=" + RESOURCE_TYPE_NAME_DCH + "&parentAgentId=" + agentId);
				optMenu.hide();
			} else if (id == "resource.add.proxydch") {
				load("server_right", "/pureportal/systemcomponent/server-create.action?parentId=" 
						+ parentId + "&resourceTypeId=" + RESOURCE_TYPE_ID_DCH
						+ "&resourceTypeName=" + RESOURCE_TYPE_NAME_DCH + "&parentAgentId=" + agentId);
				optMenu.hide();
			} else if (id == "resource.add.dms") {
				load("server_right", "/pureportal/systemcomponent/server-create.action?parentId="
						+ parentId + "&resourceTypeId=" + RESOURCE_TYPE_ID_DMS
						+ "&resourceTypeName=" + RESOURCE_TYPE_NAME_DMS + "&parentAgentId=" + agentId);
				optMenu.hide();
			} else if (id == "resource.remove") {
				//alert(resourceType);
				//alert(tree.getNodeById(serverId).isLeaf());
				if(tree.getNodeById(serverId).isLeaf()){
					win.setContentText("此操作不可恢复，是否确认执行此操作？");
					if(resourceType=='5'){//判断是否是dms
						$.ajax({
							   type: "POST",
							   url: "/pureportal/system-component/server-main-whetherDelete!whetherDelete.action",
							   data: "serverId=" + serverId,
							   dataType: "json",
							   success: function(msg){
									//alert(msg.identifier);
									if(msg.identifier=="true"){
										win.show();
										win.setConfirm_listener(function(){
											win.hide();
											$.ajax({
											   type: "POST",
											   url: "/pureportal/systemcomponent/server-main-delete!delete.action",
											   data: "serverId=" + serverId,
											   dataType: "text",
											   success: function(msg){
													//alert(msg);
													load("div_syscomp_right","/pureportal/systemcomponent/server-main.action");
													toast.addMessage("删除成功。");
											   },
												error:function(e){
												   //alert(e.responseText);
										        }
											});
										});
									}else{
										optMenu.hide();
										info.setContentText("此DMS上有资源，不允许删除。");
										info.setSubTipText("*请先将此DMS上的资源迁移到其它DMS上，然后再进行删除。"); 
										info.show();
									}
							   }
							})
					}else{
						win.show();
						win.setConfirm_listener(function(){
							win.hide();
							$.ajax({
								   type: "POST",
								   url: "/pureportal/systemcomponent/server-main-delete!delete.action",
								   data: "serverId=" + serverId,
								   dataType: "text",
								   success: function(msg){
										load("div_syscomp_right","/pureportal/systemcomponent/server-main.action");
										toast.addMessage("删除成功。");
								   },
									error:function(e){
									   //alert(e.responseText);
							        }
								})
						});
					}
				}else{
					toast.addMessage("组件已被使用，不允许删除。");
				}
			}
			
			
		}
	});
	function treeTrim(){
		$('#serverTree li').css('word-wrap','normal');
		$("#serverTree span[type='text']").each(
		function() {
			var text = $(this).text();
			$(this).empty();
			$(this).append("<span title='" + text + "'>" + text + "</span>");
	    });
	};
	treeTrim();