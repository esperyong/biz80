var panel_disc_info;
var changeArr = new Array();

$(document).ready(function() {
	init();
});
function init(){
	$("#disc_info select").each(function(){
		if(this.id == "IP"){
			SimpleBox.getIPComboBoxInstance({selectId : this.id, name:this.id, validate:'validate[required[IP地址]]'});
		}else{
			SimpleBox.renderToUseWrap([{wrapId:null, selectId:this.id, maxHeight:60}]);
		}
	});
//	SimpleBox.renderAll();
	
	settings = {
		validationEventTriggers : "change"
	}
	$("#form1").validationEngine(settings);

	// var selectIdArray=new Array("domainId", "serverId", "discoveryWay");
	// SimpleBox.renderTo(selectIdArray);
	
	$.validationEngineLanguage.allRules.serverEmpty = {
		"nname" : "serverEmpty",
		"alertText" : "请选择一个DMS。"
	}

	
	// 主机的用户，密码域
	var $hostUserName = $("#UserName");
	var $hostPassword = $("#Password");
	var $account_hash_id = $("#account_hash_id");
	
	//修改界面如果是用预置账户的，不许修改用户名和密码
	if($("#radio_account_true").attr("checked") == true){
		$hostUserName.attr("readOnly", "readonly");
		$hostPassword.attr("readOnly", "readonly");
		$account_hash_id.attr("disabled", false);
	}
	
	$("input[type='password']").each(function(){
		$(this).change(function(){
			var flag = false;
			for(var i=0;i<changeArr.length;i++){
				if(changeArr[i] == this.name){
					flag = true;
				}
			}
			if(!flag){
				changeArr.push(this.name);
			}
		});
	});

	/**
	 * 选择域的Panel组件
	 */
	var panel_disc_domain = new AccordionPanel({
				id : "panel_disc_domain",
				autoInnerHeight:true,
				clickFunction:function(){
					if(!isDiscovering){
						var contentHeight = panel_disc_domain.getContentHeight();
						panel_disc_domain.setContentHeight(contentHeight);
						panel_disc_domain.fold();
						
						if(panel_disc_domain.state == "expend"){
							var foldTopDiv = $("#panel_disc_domain").children()[0];
							var spanObj = $(foldTopDiv).children()[2];
							$(spanObj).remove();
						}else{
							var foldTopDiv = $("#panel_disc_domain").children()[0];
							$(foldTopDiv).append("<span>"+$("#domainId").find("option:selected").text()+"</span>");
						}
					}
				}
			});
	

	/**
	 * 选择dms的Panel组件
	 */
	var panel_disc_server = new AccordionPanel({
				id : "panel_disc_server",
				autoInnerHeight:true,
				clickFunction:function(){
					if(!isDiscovering){
						var contentHeight = panel_disc_server.getContentHeight();
						panel_disc_server.setContentHeight(contentHeight);
						panel_disc_server.fold();
						
						if(panel_disc_server.state == "expend"){
							var foldTopDiv = $("#panel_disc_server").children()[0];
							var spanObj = $(foldTopDiv).children()[2];
							$(spanObj).remove();
						}else{
							var foldTopDiv = $("#panel_disc_server").children()[0];
							$(foldTopDiv).append("<span>"+$("#serverId").find("option:selected").text()+"</span>");
						}
					}
				}
			});

	/**
	 * 资源发现方式的Panel组件
	 */
	var panel_disc_way = new AccordionPanel({
				id : "panel_disc_way",
				autoInnerHeight:true,
				clickFunction:function(){
					if(!isDiscovering){
						var contentHeight = panel_disc_way.getContentHeight();
						panel_disc_way.setContentHeight(contentHeight);
						panel_disc_way.fold();
						
						if(panel_disc_way.state == "expend"){
							var foldTopDiv = $("#panel_disc_way").children()[0];
							var spanObj = $(foldTopDiv).children()[2];
							$(spanObj).remove();
						}else{
							var foldTopDiv = $("#panel_disc_way").children()[0];
							$(foldTopDiv).append("<span>"+$("#discoveryWay").find("option:selected").text()+"</span>");
						}
					}
				}
			});

	/**
	 * 资源发现信息的Panel组件
	 */
	panel_disc_info = new AccordionPanel({
				id : "panel_disc_info",
				autoInnerHeight:true,
				clickFunction:function(){
					if(!isDiscovering){
						var contentHeight = panel_disc_info.getContentHeight();
						panel_disc_info.setContentHeight(contentHeight);
						panel_disc_info.fold();
					}
				}
			});

	/**
	 * 发现结果的Panel组件
	 */
	var panel_disc_result = new AccordionPanel({
				id : "panel_disc_result",
				autoInnerHeight:true,
				clickFunction:function(){
					if(!isDiscovering){
						var contentHeight = panel_disc_result.getContentHeight();
						panel_disc_result.setContentHeight(contentHeight);
						panel_disc_result.fold();
					}
				}
			});

	/**
	 * 发现方式
	 */
	$("#discoveryWay").bind("change", function() {
		var formObj = document.getElementById("form1");
		$("#resourceId").val($("#discoveryWay").val());
		formObj.target = "";
		formObj.action = "resource-discovery.action";
		formObj.submit();
	});

	/**
	 * 使用预置账户-否
	 */
	$("#radio_account_false").bind("click", function() {
				$hostPassword.val("");
				$hostUserName.removeAttr("readOnly");
				$hostPassword.removeAttr("readOnly");
				$account_hash_id.attr("disabled", true);
			});

	/**
	 * 使用预置账户-是
	 */
	$("#radio_account_true").bind("click", function() {
				$hostPassword.val("");
				$hostUserName.attr("readOnly", "readonly");
				$hostPassword.attr("readOnly", "readonly");
				$account_hash_id.attr("disabled", false);
			});

	/**
	 * 点账户的文本框时，弹出预置账户层
	 */
	$hostUserName.bind("click", function() {
		// alert("UserName");
		var domainId = $("#domainId").val();
		var $raidoAccount = $("#form1 input[name='radioAccount']:checked").val();
		// alert($raidoAccount);
		if ($raidoAccount == 'true') {
			var url = "preuser-add-discoveryaccount.action?domainId=" + domainId;
			openViewPage(url, "预置账户");
		}
	});
	
	/**
	 * 发现里绑定域Select的change事件
	 */
	$("#domainId").bind("change",function(){
		//是否绑定域和dms关联
		$hostUserName.val("");
		$hostPassword.val("");
		if($("#dmsRelaDomain").val() == "true"){
			//如果不显示证明是单机版，单机版不做dms和域的关联
			if($("#dmsDiv").css("display") != "none"){
				$.ajax({
					type : "post",
					//dataType : "json",
					url : "domain-rel-dms.action",
					data : "domainId="+$("#domainId").val(),
					success : function(data) {
						$("#serverId").parent().html(data.serverSelect);
						SimpleBox.renderAll();
						$.validationEngineLanguage.allRules.serverEmpty = {
							"nname" : "serverEmpty",
							"alertText" : "请选择一个DMS。"
						}
					}
				});
			}
		}
	});

	/**
	 * 绑定发现按钮
	 */
	$("#sp_discover").bind("click", function() {
		// alert($("#account_hash_id").val() + "," +
		// $("#account_hash_id").attr("disabled"));
		// return;
		
		if (!$.validate($("#form1"), {
					promptPosition : "centerRight"
				})) {
			return;
		}

		initDiscoveryPage();

		startLoading();
		
		parent.setChange();

		panel_disc_domain.collectQuick();
		
		var foldTopDiv = $("#panel_disc_domain").children()[0];
		var spanObj = $(foldTopDiv).children()[2];
		$(spanObj).remove();
		$(foldTopDiv).append("<span>"+$("#domainId").find("option:selected").text()+"</span>");
		
		panel_disc_server.collectQuick();
		var foldTopDiv = $("#panel_disc_server").children()[0];
		var spanObj = $(foldTopDiv).children()[2];
		$(spanObj).remove();
		$(foldTopDiv).append("<span>"+$("#serverId").find("option:selected").text()+"</span>");
		
		panel_disc_way.collectQuick();
		var foldTopDiv = $("#panel_disc_way").children()[0];
		var spanObj = $(foldTopDiv).children()[2];
		$(spanObj).remove();
		$(foldTopDiv).append("<span>"+$("#discoveryWay").find("option:selected").text()+"</span>");
		
		$("#resultFont").html("发现结果：");
		
		panel_disc_info.collectQuick();// expendQuick
		$("#div_disc_result").show();
		$('#compact').countdown({
					since : 0,
					format : 'HMS',
					compact : true,
					description : ''
				});

		var formObj = document.getElementById("form1");
		formObj.target = "iframe_discovery";
		formObj.action = "resource-result.action";
		isDiscovering = true;
		formObj.submit();

	});

	/**
	 * 加入监控
	 */
	$("#sp_monitor").bind("click", function() {
		
		var validateForm = window.frames["iframe_discovery"].validateForm();
		var resourceId = $("#resourceId").val();
		var isNetDevDiscoveryWay = $("#isNetDevDiscoveryWay").val();
		if(!validateForm){
			var confirmConfig = {
				width : 480,
				height : 130
			};
			var confirmObj = new confirm_box(confirmConfig);
			confirmObj.setContentText("资源名称校验失败，是否继续执行？");
			confirmObj.setConfirm_listener(function() {
						
				// 弹出加入监控
				var instanceId = window.frames["iframe_discovery"].$("#instanceId").val();
				$.ajax({
					type : "POST",
					dataType : 'html',
					data : "instanceId="+instanceId,
					url : "validate-isjoinmonitor.action",
					success : function(data) {
						var dataJson = $.parseJSON(data);
						if(!dataJson.value){
							var domainId = $("#domainId").val();
							if(isNetDevDiscoveryWay == "true"){
								resourceId = window.frames["iframe_discovery"].$("#resourceId").val();
							}
							var url = "resource-monitor.action?resourceId=" + resourceId + "&instanceId=" + instanceId + "&domainId="+domainId;
							winOpen({
								url : url,
								width : 400,
								height : 170,
								name : 'resourceMonitor'
							});
						}else{
							var _information  = new information ({text:"当前资源已加入策略。"});
							_information.offset({top:document.body.clientHeight-200,left:'100'});
							_information.show();
						}
					}
				});
				
				confirmObj.hide();
			});
			confirmObj.show();
		}else{
			// 保存属性
			saveInstProp();
	
			// 弹出加入监控
			var instanceId = window.frames["iframe_discovery"].$("#instanceId").val();
			$.ajax({
				type : "POST",
				dataType : 'html',
				data : "instanceId="+instanceId,
				url : "validate-isjoinmonitor.action",
				success : function(data) {
					var dataJson = $.parseJSON(data);
					if(!dataJson.value){
						var domainId = $("#domainId").val();
						if(isNetDevDiscoveryWay == "true"){
							resourceId = window.frames["iframe_discovery"].$("#resourceId").val();
						}
						var url = "resource-monitor.action?resourceId=" + resourceId + "&instanceId=" + instanceId + "&domainId="+domainId;
						winOpen({
							url : url,
							width : 400,
							height : 170,
							name : 'resourceMonitor'
						});
					}else{
						var _information  = new information ({text:"当前资源已加入策略。"});
						_information.offset({top:document.body.clientHeight-200,left:'100'});
						_information.show();
					}
				}
			});
		}
	});

	/**
	 * 继续发现
	 */
	$("#sp_continue").bind("click", function() {
		var validateForm = window.frames["iframe_discovery"].validateForm();
		if(!validateForm){
			
			var confirmConfig = {
				width : 480,
				height : 130
			};
			var confirmObj = new confirm_box(confirmConfig);
			confirmObj.setContentText("资源名称校验失败，是否继续执行？");
			confirmObj.setConfirm_listener(function() {
				confirmObj.hide();
			
				var instanceId = window.frames["iframe_discovery"].$("#instanceId").val();
				
				var formObj = document.getElementById("form1");
				formObj.target = "";
				formObj.action = "resource-discovery.action";
				formObj.submit();
			
				refreshPage(parent.opener,instanceId,"discovery");
				
			});
			confirmObj.show();
		}else{
			//保存属性
			saveInstProp();
			
			var instanceId = window.frames["iframe_discovery"].$("#instanceId").val();
			
			var formObj = document.getElementById("form1");
			formObj.target = "";
			formObj.action = "resource-discovery.action";
			formObj.submit();
		
			refreshPage(parent.opener,instanceId,"discovery");
		}
	});

	/**
	 * 完成并退出
	 */
	$("#sp_finish").bind("click", function() {
		
		var validateForm = window.frames["iframe_discovery"].validateForm();
		if (!validateForm) {
			var confirmConfig = {
				width : 480,
				height : 130
			};
			var confirmObj = new confirm_box(confirmConfig);
			confirmObj.setContentText("资源名称校验失败，是否继续执行？"); // 也可以在使用的时候传入
			confirmObj.setConfirm_listener(function() {
						confirmObj.hide();
						parent.window.close();
					});
			confirmObj.show();

		}else{
			saveInstProp();
			parent.window.close();
		}
	});

	$("#a_disc_help").bind("click", function() {
		var resourceId = $("#resourceId").val();
		window.open("/help-system/helpmsg/" + resourceId, "newwindow", "width=830,height=500,left=50,top=50,scrollbars=yes,resizable=yes");
	});

	/**
	 * 为发现信息中的select绑定onchange事件
	 */
	$("#disc_info select").bind("change", function() {
				var $select = $(this);
				var $selectOp = $select.find("option:selected");
				var ctrlStr = $selectOp.attr("changeattr");
				if (!ctrlStr) {
					return false;
				}
				// option的changeattr属性为#分隔的字符串，
				// #前面的表示需要隐藏的项目，后面表示需要显示的项目
				// 如果该项目为select，并且是需要显示的则触发他的onchange事件
				if (ctrlStr.indexOf("#") != -1) {
					var ctrls = ctrlStr.split("#");
					var hiddenEls = ctrls[0].split(",");
					var displayEls = ctrls[1].split(",");
					for (var i in hiddenEls) {
						var discoveryInfoEl = document.getElementById(hiddenEls[i]);
						if (!discoveryInfoEl)
							continue;
						$discoveryInfoEl = $(discoveryInfoEl);
						$discoveryInfoEl.attr("disabled", true);
						var selectObj = SimpleBox.instanceContent[$discoveryInfoEl.attr("id")];
						if(selectObj){
							selectObj.disable();
						}
						
						// add the verification's class property
						var discInfoClass = $discoveryInfoEl.attr("class");
						if (discInfoClass != null) {
							var validateClass = getValidateClass(discInfoClass, true);
							$discoveryInfoEl.attr("class", validateClass);
						}

						$discoveryInfoEl.parents("LI:first").hide();
						
					}
					var changeEls = new Array();
					for (var i in displayEls) {
						var discoveryInfoEl = document.getElementById(displayEls[i]);
						if (!discoveryInfoEl)
							continue;
						$discoveryInfoEl = $(discoveryInfoEl);
						$discoveryInfoEl.attr("disabled", false);
						var selectObj = SimpleBox.instanceContent[$discoveryInfoEl.attr("id")];
						if(selectObj){
							selectObj.enable();
						}

						// remove the verification's class property
						var discInfoClass = $discoveryInfoEl.attr("class");
						if (discInfoClass != null) {
							var validateClass = getValidateClass(discInfoClass, false);
							$discoveryInfoEl.attr("class", validateClass);
						}

						$discoveryInfoEl.parents("LI:first").show();
						if (discoveryInfoEl.type.indexOf("select") != -1) {
							if (displayEls[i] == $select.attr("id")) {
								continue;
							}
							changeEls.push(displayEls[i]);
						}
						
					}
					var changeSelect = new Array();
					var noDispSel = "";
					for (var i in changeEls) {
						if (noDispSel.indexOf(changeEls[i]) != -1) {
							continue;
						}
						changeSelect.push(changeEls[i]);
						var $op = $("#" + changeEls[i]).find("option:selected");
						var ctrl = $op.attr("changeattr");
						if (!ctrl) {
							continue;
						}
						var items = ctrl.split("#");
						var hiddens = items[0].split(",");
						for (var i in hiddens) {
							var discoveryInfoEl = document.getElementById(hiddens[i]);
							if (!discoveryInfoEl)
								continue;
							if (discoveryInfoEl.type.indexOf("select") != -1) {
								noDispSel += hiddens[i] + "|"
							}
						}
					}

					for (var i in changeSelect) {
						$("#" + changeSelect[i]).change();
					}
				}
				
				if($hostUserName.is(":hidden")){
					$account_hash_id.parents("LI:first").hide();
					$account_hash_id.attr("disabled",true);
				}else{
					$account_hash_id.parents("LI:first").show();
					$account_hash_id.attr("disabled",false);
				}
			});

	// 默认执行一次change事件 start
	var selectsArr = new Array();// 存放不触发change事件的select对象
	$("#disc_info select").each(function() {
				var $select = $(this);
				var id = $select.attr("id");
				for (var p in selectsArr) {
					if (selectsArr[p] == id) {
						return true;
					}
				}

				var $selectOp = $select.find("option:selected");
				var ctrlStr = $selectOp.attr("changeattr");
				if (!ctrlStr) {
					return true;
				}
				if (ctrlStr.indexOf("#") != -1) {
					var ctrls = ctrlStr.split("#");
					var hiddenEls = ctrls[0].split(",");
					var displayEls = ctrls[1].split(",");
					// 隐藏的select不触发change事件
					for (var i in hiddenEls) {
						var discoveryInfoEl = document.getElementById(hiddenEls[i]);
						if (!discoveryInfoEl)
							continue;
						if (discoveryInfoEl.type.indexOf("select") != -1) {
							selectsArr.push(hiddenEls[i]);
						}
					}
				}
				$select.change();
				
			});// 默认执行一次change事件 end
			
	window.setInterval("refreshDiscInfo()",100);
}

function getValidateClass(s, isDisabled) {
	var mark = "_dis_";
	if (isDisabled) {
		var index = s.indexOf("validate");
		if (index >= 0) {
			s = s.substring(0, index + 1) + mark + s.substring(index + 1, s.length);
		}
	} else {
		var index = s.indexOf("v" + mark + "alidate");
		var markIndex = s.indexOf(mark);
		if (index >= 0) {
			s = s.substring(0, markIndex) + s.substring(markIndex + mark.length, s.length);
		}
	}

	return s;
}

function saveInstProp() {
	var discFrame = window.frames["iframe_discovery"];
	if(!discFrame.validateForm()){
		return;
	}
	var discovery_successed = discFrame.$("#discovery_successed").val();
	if (discovery_successed == "false") {
		return;
	}

	var instanceId = discFrame.$("#instanceId").val();
	var instanceName = discFrame.$("#instanceName").val();
	var categoryGroup = discFrame.$("#categoryGroup").val();

	var data = "instanceId=" + instanceId + "&instanceName=" + instanceName;
	if (categoryGroup != null) {
		data = data + "&categoryGroup=" + categoryGroup;
	}

	// AJAX方式保存资源实例属性
	$.ajax({
		type : "post",
		dataType : 'html',
		url : "resource-finished.action",
		data : discFrame.$("#form_result").serialize(),
		success : function(data, textStatus) {
		},
		error : function() {
		}
	});
};
/**
 * 自动刷新发现信息高度
 */
function refreshDiscInfo(){
	if(panel_disc_info != null){
		panel_disc_info.clearHeight();
	}
}

var percentInterval;
function startLoading() {
	// loading image
	$("#imgLoading").attr("src", contextPath + "/images/loading.gif");
	// discovery percent
	$("#spLoading").text("0%");
	var percent = 1;
	percentInterval = self.setInterval(function() {
				if (percent <= 99) {
					increasePercent(percent++);
				}
			}, 1000)
}

function increasePercent(percent) {
	$("#spLoading").text(percent + "%");
}

function stopLoading() {
	$("#imgLoading").attr("src", contextPath + "/images/loading-end.gif");
	if (percentInterval != null) {
		window.clearInterval(percentInterval);
	}
	$("#spLoading").text("100%");
}

function initDiscoveryPage() {
	$("#iframe_discovery").hide();
	$("#sp_disc_result").removeClass();
	$("#sp_finish").hide();
	$("#sp_continue").hide();
	$("#sp_monitor").hide();
}

var panel;
function openViewPage(url, title) {
	if (panel) {
		panel.close("close");
		panel = null;
	}
	// alert($("#page_mark").val());
	var horizontal = 100;
	var vertical = 70;
	if ($("#page_mark").val() == "resource-discovery") {
		horizontal = 200;
		vertical = 170;
	}

	var preuserURL = "/pureportal/discovery/preuser-add.action?domainId="+$("#domainId").val();

	panel = new winPanel({
		title : title,
		url : url,
		width : 320,
		cls : "pop-div",
		x : horizontal,
		y : vertical,
		tools : [{
					text : "新建预置账户",
					click : function() {
						winOpen({
									url : preuserURL,
									width : 450,
									height : 240,
									scrollable : false,
									name : 'preuseradd'
								});
					}
				}, {
					text : "确定",
					click : function() {
						// 选择预置账户，填充到发现页面中
						var $hashIdCheck = $("#tab_account :radio[name='hashId']:checked");
						var $accountId = $hashIdCheck.attr("accountId");
						var $accountPassword = $hashIdCheck
								.attr("accountPassword");
						// alert("accountId=" + $accountId + ",accountPassword="
						// + $accountPassword );

						var $radioAccount = $("#account_hash_id");
						$radioAccount.val($hashIdCheck.val());

						$("#UserName").val($accountId);
						$("#Password").val($accountPassword);

						panel.close("close");
					}
				}, {
					text : "取消",
					click : function() {
						panel.close("close");
					}
				}],
		listeners : {
			closeAfter : function() {
				panel = null;
			},
			loadAfter : function() {
				window.focus();
			}
		}
	}, {
		winpanel_DomStruFn : "pop_winpanel_DomStruFn"
	}

	);
};

/**
 * 发现里DMS的Select组件校验
 * @return {Boolean}
 */
function serverEmpty(){
	if($("#serverId").val() == ""){
		return true;
	}else{
		return false;
	}
}

/**
 * 刷新页面
 * @param {} instanceId
 */
function refreshPage(obj,instanceId,module){
	try{
		if(obj){
			obj.refreshPage(instanceId.split(","),module);
		}
	}catch(e){}
}
