var tree;
var win = new confirm_box({title:'提示',text:'是否确认执行此操作？',cancle_listener:function(){win.hide();}});
var info  = new information();
var toast = new Toast({position:"CT"});
$(document).ready(function() {
	$.blockUI({message:$('#loading')});
	$.unblockUI();
	$("#sp_info").bind("click", function() {
		load("agent_right", "/pureportal/systemcomponent/agent-info.action");
	});
	$("#openMenu").bind("click", function(event){
		addMenu("0", event)
	})
	function load(id, url,callback) {
		$.loadPage(id, url, "POST", '', callback);
	}
	tree = new Tree( {
		id : "agentTree",
		listeners : {
			nodeClick : function(node) {
				load("agent_right", "/pureportal/systemcomponent/agent-info.action?agentId=" + node.getId());
			},
			toolClick : function(node, event) {
				var parentId = node.getValue("id");
				addMenu(parentId, event)
				}
		}
	});		
	var optMenu = new MenuContext( {
		x : 0,
		y : 0
	}, {
		menuContext_DomStruFn : "ico_menuContext_DomStruFn"
	});
	function addMenu(parentId, event){
		var adds = [];
		adds.push({
			ico:"find",
			text : "发现",
			id : "create",
			listeners : {
				click : function() {
					if(tree.getNodeById(parentId)._get$Ico().attr("class")!="lamp lamp-gray"){
						var createURL = "/pureportal/systemcomponent/agent-create.action";
						if (parentId != null) {
							createURL = createURL + "?parentId=" + parentId;
						}
						load("agent_right", createURL);
					}else{
						toast.addMessage("通信中断。");
					}
					optMenu.hide();
				}
			}
		});
		if(""!=parentId && "0"!=parentId){
			adds.push({
				ico: "delete",
				text : "删除",
				id : "reset",
				listeners : {
					click : function() {
				if(tree.getNodeById(parentId).isLeaf()){
					$.ajax({
					   type: "POST",
					   url: "/pureportal/system-component/agent-main-whetherDelete!whetherDelete.action",
					   data: "agentId=" + parentId,
					   dataType: "json",
					   success: function(msg){
							//alert(msg.identifier);
							if(msg.identifier=="true"){
								win.setContentText("此操作不可恢复，是否确认执行此操作？");
								win.show();
								win.setConfirm_listener(function(){
									win.hide();
									$.ajax({
										type: "POST",
									   	url: "/pureportal/systemcomponent/agent-main-delete!delete.action",
									   	data: "agentId=" + parentId,
									   	dataType: "text",
									   	success: function(msg){
											document.location.href = document.location.href;
											toast.addMessage("删除成功。");
									   	}
									});
								});
							}else{
								optMenu.hide();
								info.setContentText("该Agent已被使用，不允许删除。");
								info.show();
							}
					   	}
					})
				}else{
					toast.addMessage("该Agent存在下级Agent，不允许删除。");
				}
					
				}
				}
			});
			adds.push({
				ico: "apply",
				text : "重启",
				id : "restart",
				listeners : {
					click : function() {
					win.setContentText("是否确认执行此操作？");
					win.setConfirm_listener(function(){
						win.hide();
					$.ajax({
						   type: "POST",
						   url: "/pureportal/systemcomponent/agent-main-restart!restart.action",
						   data: "agentId=" + parentId,
						   dataType: "text",
						   success: function(msg){
								document.location.href = document.location.href;	
						   }
						});
					});
					win.show();
					}
				}
			})
		}
		optMenu.addMenuItems([adds]);
		//alert(event.pageX);
		//alert(event.pageY);
		optMenu.position(event.pageX, event.pageY);

	}
});
function treeTrim(){
	$('#agentTree li').css('word-wrap','normal');
	$("#agentTree span[type='text']").each(
	function() {
		var text = $(this).text();
	    $(this).empty();
	    $(this).append("<span title='" + text + "'>" + text + "</span>");
	});
};
treeTrim();