if (!window.BSM) {
	window.BSM = {};
}

BSM.Monitorsetting = {};
BSM.Monitorsetting.Template = {};
BSM.Monitorsetting.SoundLightServer = {};
BSM.Monitorsetting.Diagnose = {};
BSM.Monitorsetting.SystemLog = {};

/**
 * 全局设置-左部分结构初始化js
 */
BSM.Monitorsetting.initMonitorsetting = function() {
	var self = this;
	$("a[id='leftid']").click(function() {
		var val = $(this).attr("name");
		self.change(ctx + val, function() {
			if ("/monitorsetting/alermtemplate/index.action?type=EMAIL" == val) {//邮件模板
				BSM.Monitorsetting.initMonitorsetting.updateClass("class_/monitorsetting/alermtemplate/index.action?type=EMAIL");
				BSM.Monitorsetting.Template.initIndex();
			} else if ("/monitorsetting/alermtemplate/index.action?type=SMS" == val) {//短信模板
				BSM.Monitorsetting.initMonitorsetting.updateClass("class_/monitorsetting/alermtemplate/index.action?type=SMS");
				BSM.Monitorsetting.Template.initIndex();
			} else if ("/monitorsetting/alermtemplate/index.action?type=VOICE" == val) {//语音模板
				BSM.Monitorsetting.initMonitorsetting.updateClass("class_/monitorsetting/alermtemplate/index.action?type=VOICE");
				BSM.Monitorsetting.Template.initIndex();
			} else if ("/monitorsetting/alermtemplate/index-sound.action" == val) {//声光模板
				BSM.Monitorsetting.initMonitorsetting.updateClass("class_/monitorsetting/alermtemplate/index-sound.action");
				BSM.Monitorsetting.SoundLightServer.initIndex();
			} else if ("/monitorsetting/diagnose/index.action" == val) {//
				BSM.Monitorsetting.initMonitorsetting.updateClass("class_/monitorsetting/diagnose/index.action");
				BSM.Monitorsetting.Diagnose.initIndex();
			} else if("/monitorsetting/systemlog/index.action" == val){
				BSM.Monitorsetting.initMonitorsetting.updateClass("class_/monitorsetting/systemlog/index.action");
				BSM.Monitorsetting.SystemLog.initIndex();
			} else if("/monitorsetting/configstatus/index.action" == val){
				BSM.Monitorsetting.initMonitorsetting.updateClass("class_/monitorsetting/configstatus/index.action");
			}
		});
	});

	$("#emile-template").click(function() {
		self
				.change(
						ctx
								+ "/monitorsetting/alermtemplate/index-template.action?type=EMAIL",
						function() {
							BSM.Monitorsetting.Template.initIndex();
						});
	});
	$("#sms-template").click(function() {
		self
				.change(
						ctx
								+ "/monitorsetting/alermtemplate/index-template.action?type=SMS",
						function() {
							// Admin.Monitorsetting.EmailServer.initIndex();
							BSM.Monitorsetting.Template.initIndex();
						});
	});
	$("#voice-template").click(function() {
		self
				.change(
						ctx
								+ "/monitorsetting/alermtemplate/index-template.action?type=VOICE",
						function() {
							// Admin.Monitorsetting.SMSServer.initIndex();
							BSM.Monitorsetting.Template.initIndex();
						});
	});
	$("#sound-template").click(function() {
		self.change(ctx + "/monitorsetting/alermtemplate/index-sound.action",
				function() {
					BSM.Monitorsetting.SoundLightServer.initIndex();
				});
	});
};

BSM.Monitorsetting.initMonitorsetting.updateClass = function (id){
	document.getElementById(id).className='bold';
	document.getElementById(document.getElementById("classid").value).className='';
	document.getElementById("classid").value=id;
	
}

/**
 * 全局设置-右部分改变url
 * 
 * @param {}
 *            url
 * @param {}
 *            callback
 */
BSM.Monitorsetting.change = function(url, callback) {
	$.loadPage("globalsettingmainright", url, "POST", "", callback);
};

/**
 * 全局设置-邮件服务器初始化js
 */
BSM.Monitorsetting.Template.initIndex = function() {
			BSM.Monitorsetting.initValidationEngine("templateformname");
			$("#domainName").change(function() {
				//alert();
				var self = this;
				BSM.Monitorsetting.Template.selectDomain();
			});
			
			$("#allsave").click(function() {
//				var domainId = $("#domainName").attr("value");
//				alert(domainId);
				$.ajax({
				type: "POST", 
				dataType:'html',
				data:$("#templateformname").serialize(),
				url:ctx+"/monitorsetting/alermtemplate/template-all.action",
				success: function(data){
//						try{
//							var templateId=window.document.getElementById("moduleId").value+'_'+window.document.getElementById("eventClass").value+'_'+window.document.getElementById("alermMethod").value;
//							window.location.href=ctx+"/monitorsetting/alermtemplate/template-list.action?templateId="+templateId+"&domainId="+window.document.getElementById("domainId").value;
//						}catch(e){
//						}
						$.ajax({
							type: "POST", 
							dataType:'html',
							data:$("#templateformname").serialize(),
							url:ctx+"/monitorsetting/alermtemplate/index-template.action",
							success: function(data){
								$("#tabmanageId").html('');
								$("#tabmanageId").html(data);
								BSM.Monitorsetting.Template.pageEditBindClick();
							}
						});
					}
				});
			});
			BSM.Monitorsetting.Template.pageEditBindClick();

};

BSM.Monitorsetting.Template.pageEditBindClick = function(){
	$("div[name='pageEdit']").click(function() {
		var val = $(this).attr("id");
		//alert(val);
		//alert($("#domainId").attr("value"));
		var obj = {
			height : 220,
			width : 640,
			name : "",
			url : ctx
					+ "/monitorsetting/alermtemplate/template-list.action?templateId="
					+ val+"&domainId="+$("#domainId").attr("value")
		};
		winOpen(obj);
	});
}



/**
 * 全局设置-声光服务器切换域
 */
BSM.Monitorsetting.Template.selectDomain = function() {
	var self = this;
	if($("#domainName").attr("value")=='ALL'){
		document.getElementById('templateall').style.display='none';
	}else{
		document.getElementById('templateall').style.display='block';
	}
	$.loadPage("tabmanageId",
			ctx + "/monitorsetting/alermtemplate/index-template.action?domainId="
					+ $("#domainName").attr("value")+"&type="+$("#type").attr("value"), "POST", "", function() {
							$("div[name='pageEdit']").click(function() {
							var val = $(this).attr("id");
							//alert(val);
							//alert($("#domainId").attr("value"));
							var obj = {
								height : 330,
								width : 700,
								name : "",
								url : ctx
										+ "/monitorsetting/alermtemplate/template-list.action?templateId="
										+ val+"&domainId="+$("#domainId").attr("value")
							};
							winOpen(obj);
						});
			});
};

/**
 * 全局设置-声光服务器初始化js
 */
BSM.Monitorsetting.SoundLightServer.initIndex = function() {

	$("#domainName").change(function() {
		//alert();
				var self = this;
				BSM.Monitorsetting.SoundLightServer.selectSound();
			})
	BSM.Monitorsetting.initValidationEngine("soundlightserverformname");

	$("#soundsave").click(function() {
		$.blockUI({message:$('#loading')});
		$.ajax({
					type : "POST",
					dataType : "html",
					data : $("#soundlightserverformname").serialize(),
					url : ctx
							+ "/monitorsetting/alermtemplate/sound-save.action",
					success : function(data) {
						$.unblockUI();
					}
				});
	});

};

/**
 * 全局设置-声光服务器切换域
 */
BSM.Monitorsetting.SoundLightServer.selectSound = function() {
	var self = this;
	$.loadPage("tabmanageId",
			ctx + "/monitorsetting/alermtemplate/sound-list.action?domainId="
					+ $("#domainName").attr("value"), "POST", "", function() {
				// self.initIndex();
			});
};

/**
 * 诊断工具界面初始化JS
 */
BSM.Monitorsetting.Diagnose.initIndex = function() {
	var self = this;
	this.diagTabPanel = new TabPanel({
		id : "diagnosemytab",
		listeners : {
			change : function(tab) {
				if (tab.index == 1) {
					self.diagTabPanel.loadContent(1, {
								url : ctx
										+ "/monitorsetting/diagnose/self-index.action",
								type : "GET",
								callback : function() {
									self.initSelfIndex();
								}
							});
				}
				if (tab.index == 2) {
					self.diagTabPanel.loadContent(1, {
						url : ctx
								+ "/monitorsetting/diagnose/component-index.action",
						type : "GET",
						callback : function() {
							self.initComponentIndex();
						}
					});
				}
				if (tab.index == 3) {
					self.diagTabPanel.loadContent(1, {
						url : ctx
								+ "/monitorsetting/diagnose/resource-index.action",
						type : "GET",
						callback : function() {
							self.initResourceIndex();
						}
					});
				}
			}
		}
	});
	self.initSelfIndex();
};

/**
 * 诊断工具-自检，初始化JS
 */
BSM.Monitorsetting.Diagnose.initSelfIndex = function() {
	$("#selfmakereportbutton").click(function() {
		$.blockUI({message:$('#loading')});
		$.loadPage("selfreport", ctx
						+ "/monitorsetting/diagnose/self-report.action",
				"POST", "", function() {
					$.unblockUI();
				});
	});
};

/**
 * 诊断工具-组件诊断，初始化JS
 */
BSM.Monitorsetting.Diagnose.initComponentIndex = function() {
	$("#componentdiagnosebutton").click(function() {
		if($("#componentServerId option:selected").length == 0){
			$("#componentServerId option").attr("selected", "true");
		}
		$.blockUI({message:$('#loading')});
		$.loadPage("componentreport", ctx
						+ "/monitorsetting/diagnose/component-report.action",
				"POST", $("#componentdiagnoseformname").serialize(),
				function() {
					$.unblockUI();
//					$("#componentexportbutton").parent().parent().parent().css(
//							"display", "block");
				});
	});

	$("#componentexportbutton").click(function() {
		var $formname = $("#componentdiagnoseformname");
		$formname.attr("target","DownloadFrame");
		$formname.attr("action",ctx	+ "/monitorsetting/diagnose/component-export.action");
		$formname.attr("method","post");
		$formname.submit();
	});
};

/**
 * 诊断工具-资源诊断，初始化JS
 */
BSM.Monitorsetting.Diagnose.initResourceIndex = function() {
	var self = this;
	BSM.Monitorsetting.initValidationEngine("resourcediagnoseformname");
	$.validationEngineLanguage.allRules.checkIp = {
		"nname" : "checkIp",
		"alertText" : "IP地址无效。"
	}
	$.validationEngineLanguage.allRules.checkPort = {
		"nname" : "checkPort",
		"alertText" : "端口无效。"
	}
	$("#jsdiagnoseresourceadd").click(function() {
		var $ipAddress = $("#ipAddress");
		var $port = $("#port");
		var $resourceServerId = $("#resourceServerId");
		$ipAddress.attr("class","validate[required[IP],funcCall[checkIp]]");
		$port.attr("class","validate[required[端口],funcCall[checkPort]]");
		$resourceServerId.attr("class","validate[required[DMS]]");
		if (!$.validate($("#resourcediagnoseformname"))) {
			return false;
		}
		$ipAddress.attr("class","");
		$port.attr("class","");
		$resourceServerId.attr("class","");
		var ops = [];
		var serverName = $resourceServerId.find("option:selected").text();
		var ipSelectObj = document.getElementById("ipSelect");
		var options = ipSelectObj.options;
		if(options.length != 0){
			var toast = new Toast({position : "CT"});
			for (var i = 0; i < options.length; i++) {
				var optionsText = options[i].text;
				var ip = optionsText.split(":")[0];
				var portAndServer = optionsText.split(":")[1];
				var port = portAndServer.substring(0,portAndServer.indexOf("("));
				var dmsName = portAndServer.substring(portAndServer.indexOf("(")+1,portAndServer.indexOf(")"));
				if($port.val() == port && $ipAddress.val() == ip && serverName == dmsName){
					// TODO 重复提示，暂不需要
				}
			}
		}
		if ($resourceServerId.attr("type") == "hidden") {
			serverName = $("#serverName").html();
		}
		ops.push("<option value='" + $ipAddress.val() + ":" + $port.val()
				+ "'>" + $ipAddress.val() + ":" + $port.val() + "("
				+ serverName + ")</option>");
		$("#ipSelect").append(ops.join(""));
	});
	$("#jsdiagnoseresourcedelete").click(function() {
		var ipSelect = document.getElementById("ipSelect");
//		var toast = new Toast({position : "CT"});
		var _information  = new information ({text:"请至少选择一项。"});
				if (ipSelect.length != 0) {
					if(ipSelect.selectedIndex >= 0){
						var length = ipSelect.options.length - 1;    
						for(var i = length; i >= 0; i--){    
							if(ipSelect[i].selected == true){    
								ipSelect.options[i] = null;    
							}    
						}
					}else{
						_information.show();
					}
				}else{
					_information.show();
				}
			});
	$("#resourcediagnosebutton").click(function() {
		var ipSelect = document.getElementById("ipSelect");
//		var toast = new Toast({position : "CT"});
		var _information  = new information ({text:"请至少选择一项。"});
		if (ipSelect.length == 0) {
			_information.show();
			return;
		}
		if(ipSelect.selectedIndex < 0){
			$("#ipSelect option").attr("selected", "true");
		}
		$.blockUI({message:$('#loading')});
		$.loadPage("resourcereport", ctx
						+ "/monitorsetting/diagnose/resource-report.action",
				"POST", $("#resourcediagnoseformname").serialize(), function() {
					$.unblockUI();
					self.initResourceReport();
				});
	});
};

/**
 * 诊断工具-资源诊断报告，初始化JS
 */
BSM.Monitorsetting.Diagnose.initResourceReport = function() {
	var conf = {
		gridPanelId : "decoratorGridpanel",
		columnWidth : {
			"dmsName" : 15,
			"ipAddress" : 12,
			"port" : 7,
			"os" : 30,
			"response" : 10,
			"method" : 15,
			"detail" : 10
		},
		render : [{
			index : "detail",
			fn : function(td) {
				if (td.value.isHasDetailHidden == "true") {
					$font = $("<div title='详细报告' class='ico ico-usedaction'/>");
					$font.bind("click", function(e) {
						var obj = {
							height : 630,
							width : 700,
							scrollable : true,
							name : "",
							url : ctx
									+ "/monitorsetting/diagnose/resource-detail.action?ip="
									+ td.value.ipHidden + "&osType="
									+ td.value.osTypeHidden + "&serverId="
									+ td.value.serverIdHidden + "&port="
									+ td.value.portHidden
						};
						winOpen(obj);
					});
				} else {
					$font = $("<div>&nbsp;</div>");
				}
				return $font;
			}
		}]
	};
	BSM.Monitorsetting.initGridPanel(conf);
};

/**
 * 诊断工具-资源诊断详细，初始化JS
 */
BSM.Monitorsetting.Diagnose.initResourceDetail = function() {
	var snmpConf = {
		gridPanelId : "snmpGridPanel",
		columnWidth : {
			"mibName" : 25,
			"oid" : 25,
			"mibNode" : 25,
			"value" : 25
		},
		render : []
	}
	BSM.Monitorsetting.initGridPanel(snmpConf);
	var mramConf = {
		gridPanelId : "mramGridPanel",
		columnWidth : {
			"pluginName" : 34,
			"version" : 33,
			"value" : 33
		},
		render : []
	}
	BSM.Monitorsetting.initGridPanel(mramConf);
	var wmiConf = {
		gridPanelId : "wmiGridPanel",
		columnWidth : {
			"nameSpace" : 34,
			"className" : 33,
			"value" : 33
		},
		render : []
	}
	BSM.Monitorsetting.initGridPanel(wmiConf);
}

BSM.Monitorsetting.SystemLog.initIndex = function(){
	var self = this;
	var conf = {
		gridPanelId : "systemlogGridPanel",
		columnWidth : {
			"zipName" : 34,
			"zipTime" : 33,
			"zipPath" : 33
		},
		render : [{
			index : "zipPath",
			fn : function(td) {
				var $font = $("<div>&nbsp;</div>");
				if(td.html != ""){
					$font = $("<div class='ico ico-save' title='下载'/><div class='ico ico-delete2' title='删除'/>");
					$font.eq(0).click(function(){
						self.initDownload(td.html);
					});
					$font.eq(1).click(function(){
						self.initDelete(td.html);
					});
				}
				return $font;
			}
		}]
	};
	$("#systemlogsummary").click(function(){
		$.blockUI({message:$('#loading')});
		$.ajax({
			type : "POST",
			dataType : "html",
			url : ctx + "/monitorsetting/systemlog/summary-log.action",
			success : function(data) {
				self.gridPanel.loadGridData($.parseJSON(data).systemLog);
				$.unblockUI();
			}
		});
	});
	this.gridPanel = BSM.Monitorsetting.initGridPanel(conf);
};

BSM.Monitorsetting.SystemLog.initDelete = function(value){
	var self = this;
	$("#zipPath").val(value);
	$.ajax({
		type : "POST",
		dataType : "html",
		url : ctx + "/monitorsetting/systemlog/log-delete.action",
		data:$("#systemlogformname").serialize(),
		success : function(data) {
			self.gridPanel.loadGridData($.parseJSON(data).systemLog);
		}
	});
}

BSM.Monitorsetting.SystemLog.initDownload = function(value){
	$("#zipPath").val(value);
	var $formname = $("#systemlogformname");
	$formname.attr("method","post");
	$formname.attr("action",ctx + "/monitorsetting/systemlog/log-download.action");
	$formname.attr("target","systemlogdownloadframe");
	$formname.submit();
}

/**
 * 诊断工具-表格组件，初始化JS
 */
BSM.Monitorsetting.initGridPanel = function(conf) {
	var gridPanel = new GridPanel({
				id : conf.gridPanelId,
				unit : "%",
				columnWidth : conf.columnWidth
			}, {
				gridpanel_DomStruFn : "index_gridpanel_DomStruFn",
				gridpanel_DomCtrlFn : "index_gridpanel_DomCtrlFn",
				gridpanel_ComponetFn : "index_gridpanel_ComponetFn"
			});
	gridPanel.rend(conf.render);
	return gridPanel;
};

/**
 * 校验IP
 * @return {}
 */
checkIp = function() {
	return BSM.Monitorsetting.checkIP("ipAddress");
};
/**
 * 校验端口
 * @return {}
 */
checkPort = function() {
	return BSM.Monitorsetting.checkPort("port");
};

/**
 * 创建GridPanel对象
 * 
 * @param {}
 *            id 创建的GridPanel ID
 * @return {} config 构建GridPanel对象的参数，render：渲染数组，columnWidth：列宽
 */
BSM.Monitorsetting.createGridPanel = function(id, config) {
	var gp = new GridPanel({
				id : id,
				unit : "%",
				columnWidth : config.columnWidth
			}, {
				gridpanel_DomStruFn : "index_gridpanel_DomStruFn",
				gridpanel_DomCtrlFn : "index_gridpanel_DomCtrlFn",
				gridpanel_ComponetFn : "index_gridpanel_ComponetFn"
			});
	if(config.render){
		gp.rend(config.render);
	}
	return gp;
}
/**
 * 创建AccordionPanel对象
 * 
 * @param {}
 *            id AccordionPanel ID
 * @return {} AccordionPanel Object
 */
BSM.Monitorsetting.createAccordionPanel = function(id) {
	var accordionPanel = new AccordionPanel({
				id : id
			}, {
				DomStruFn : "addsub_accordionpanel_DomStruFn",
				DomCtrlFn : "addsub_accordionpanel_DomCtrlFn"
			});
	return accordionPanel;
}

/**
 * 弹出层初始化JS
 * @param {} conf
 */
BSM.Monitorsetting.Div = function(conf){
	var div = new winPanel({
		type: "POST",
		url : conf.url,
		param : conf.param,
		width : conf.width,
		x : conf.x,
		isautoclose:true,
		y : conf.y
	},{
        winpanel_DomStruFn:"blackLayer_winpanel_DomStruFn"
    });
};

/**
 * form表单校验初始化JS
 * @param {} formId
 */
BSM.Monitorsetting.initValidationEngine = function(formId) {
	$("#" + formId).validationEngine();
	settings = {
		promptPosition : "centerRight",
		validationEventTriggers : "keyup blur change",
		inlineValidation : true,
		scroll : false,
		success : false
	}
	$.validate = function(form) {
		$.validationEngine.onSubmitValid = true;
		if ($.validationEngine.submitValidation(form, settings) == false) {
			if ($.validationEngine.submitForm(form, settings) == true) {
				return false;
			} else {
				return true;
			}
		} else {
			settings.failure && settings.failure();
			return false;
		}
	};
};

BSM.Monitorsetting.checkIP = function(inputTextId) {
	var re = /^(\d+)\.(\d+)\.(\d+)\.(\d+)$/g // 匹配IP地址的正则表达式
	var re1 = /^(\d+)\.(\d+)\.(\d+)\.(\*)$/g // 匹配IP地址的正则表达式
	if (re.test($("#" + inputTextId).val())
			&& (RegExp.$1 < 256 && RegExp.$2 < 256 && RegExp.$3 < 256 && RegExp.$4 < 255)) {
		return false;
	}
	if (re1.test($("#" + inputTextId).val())
			&& (RegExp.$1 < 256 && RegExp.$2 < 256 && RegExp.$3 < 256 && RegExp.$4 == '*')) {
		return false;
	}
	return true;
};
BSM.Monitorsetting.checkPort = function(inputTextId) {
	var str = $("#" + inputTextId).val();
	if (!isNaN(str) && str < 65536) {
		return false;
	} else {
		return true;
	}
}
