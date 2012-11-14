/**
 * 缓存
 */
function cache(){
	this.rowID=0;//当前显示行的ID
	this.num=0;//报告内容行数
	this.divID=null;//显示层的ID	
	this.isCreate=true;//标识是否新建报告
	this.period="Daily";//报告周期
	this.reportType="Performance";//报告类型		
}
cache.prototype={
		setRowID:function(id){
			this.rowID=id;
		},
		getRowID:function(){
			return this.rowID;
		},
		setNum:function(num){
			this.num=num;
		},
		getNum:function(){
			return this.num;
		},
		setDivID:function(id){
			this.divID=id;
		},
		getDivID:function(){
			return this.divID;
		},
		setPeriod:function(id){
			this.period=id;
		},
		getPeriod:function(){
			return this.period;
		},		
		setIsCreate:function(flag){
			this.isCreate=flag;
		},
		getIsCreate:function(){
			return this.isCreate;
		},
		setReportType:function(reportType){
			this.reportType=reportType;
		},
		getReportType:function(){
			return this.reportType;
		},
		init:function(){
			this.rowID=0;//当前显示行的ID
			this.num=0;//报告内容行数
			this.divID=null;//显示层的ID	
			this.isNew=false;//标识报告内容行是否新建
			this.isCreate=true;//标识是否新建报告
		}
};
var cacheObj=new cache();
//保存当前用户操作的报告ID 
function cacheReport(){
	this.id;//节点Id
	this.name;//节点名称
	this.node;//节点对象 
	this.showReport="allReport";//调用的方法
	this.root="myreport";
	this.type="Performance";
}
cacheReport.prototype={
	setId:function(id){
		this.id=id;
	},
	getId:function(){
		return this.id;
	},
	setName:function(name){
		this.name=name;
	},
	getName:function(){
		return this.name;
	},
	setNode:function(node){
		this.node=node;
	},
	getNode:function(){
		return this.node;
	},
	setShowReport:function(showReport){
		this.showReport=showReport;
	},
	getShowReport:function(){
		return this.showReport;
	},
	setRoot:function(root){
		this.root=root;
	},
	getRoot:function(){
		return this.root;
	},
	setType:function(type){
		this.type=type;
	},
	getType:function(){
		return this.type;
	}	
};
var cacheReportObj=new cacheReport();

function mapObj(){
	this.elment=new Array();	
}
mapObj.prototype={		
		put:function(_key,_value){
			this.elment.push({key:_key,value:_value});
		},
		get:function(_key){
			try {
				for (i = 0; i < this.elment.length; i++) {
					if (this.elment[i].key == _key) {
						return this.elment[i].value;
					}
				}
			}
			catch (e) {
				return null;
			}
		},		
		remove:function (_key) {
			var bln = false;
			try {
				for (i = 0; i < this.elment.length; i++) {
					if (this.elment[i].key == _key) {
						this.elment.splice(i, 1);
						return true;
					}
				}
			}
			catch (e) {
				bln = false;
			}
			return bln;
		},
		getKeyByIndex:function(index){
			if (_index < 0 || _index >= this.elment.length) {
				return null;
			}
			return this.elment[_index].key;		
		},
		size:function(){
			return this.elment.length;
		},
		isEmpty:function(){
			return (this.elment.length<1);
		},
		clear:function(){
			this.elment=new Array();
		}
};
var metricObj=new mapObj();

metricObj.put("host", "server");
metricObj.put("server", "server");
metricObj.put("WindowsServer", "server");
metricObj.put("LinuxServer", "server");
metricObj.put("AixServer", "server");
metricObj.put("SolariSserver", "server");
metricObj.put("ScoUnixServer", "server");
metricObj.put("HPUXGroup", "server");
metricObj.put("HPOpenVMSGroup", "server");
metricObj.put("NovellNetWareGroup", "server");
metricObj.put("AS400Group", "server");
metricObj.put("ScoOpenServerGroup", "server");
metricObj.put("OtherServer", "server");
metricObj.put("pc", "server");

metricObj.put("networkdevice", "networkdevice");
metricObj.put("router", "networkdevice");
metricObj.put("switch", "networkdevice");
metricObj.put("routerswitch", "networkdevice");
metricObj.put("firewall", "networkdevice");
metricObj.put("wirelessap", "wirelessap");//特例(有自己的属性指标)
metricObj.put("loadbalance", "networkdevice");
metricObj.put("ids", "networkdevice");
metricObj.put("NetsSluice", "networkdevice");
metricObj.put("Othernetworkdevice", "networkdevice");

metricObj.put("storage", "storage");

metricObj.put("link", "link");

metricObj.put("application", "application");
metricObj.put("Database", "application");
metricObj.put("DB2", "application");
metricObj.put("Informix", "application");
metricObj.put("MySQL", "application");
metricObj.put("Oracle", "application");
metricObj.put("PostgreSQL", "application");
metricObj.put("SQLServer", "application");
metricObj.put("Sybase", "application");
metricObj.put("Sybase", "application");

metricObj.put("DirectoryServer", "application");
metricObj.put("IBMDirectoryServer", "application");
metricObj.put("SunJESDirectoryServer", "application");

metricObj.put("J2EEAppServer", "application");
metricObj.put("ClusterApplication", "application");
metricObj.put("ApusicAS", "application");
metricObj.put("JbossAS", "application");
metricObj.put("OracleAS", "application");
metricObj.put("Resin", "application");
metricObj.put("SunJESAS", "application");
metricObj.put("SunONEAS", "application");
metricObj.put("Tomcat", "application");
metricObj.put("Weblogic", "application");
metricObj.put("WebSphereAS", "application");
metricObj.put("WebSpherePortalServer", "application");

metricObj.put("LotusDomino", "application");
metricObj.put("mailserver", "application");
metricObj.put("MSExchangeMail", "application");
metricObj.put("LotusDominoMail", "application");
metricObj.put("Mail", "application");

metricObj.put("Middleware", "application");
metricObj.put("Tuxedo", "application");
metricObj.put("WebSphereMQ", "application");
metricObj.put("CICS", "application");
metricObj.put("TongLINKQ", "application");

metricObj.put("WebServer", "application");
metricObj.put("ApacheHTTPServer", "application");
metricObj.put("InternetInformationServices", "application");
metricObj.put("AvayaCM", "application");

metricObj.put("StandardGroup", "application");
metricObj.put("HAGroup", "application");
metricObj.put("Avaya", "application");
metricObj.put("General", "application");
metricObj.put("Ping", "application");
metricObj.put("URL", "application");
metricObj.put("TraceRoute", "application");
metricObj.put("Port", "application");
metricObj.put("DNS", "application");
metricObj.put("FTP", "application");
metricObj.put("NTP", "application");
metricObj.put("StandardApp", "application");

metricObj.put("PingGroup", "application");

function loadchildResSelect(resKey,$html){
	var resVal=metricObj.get(resKey);
	$html.html("");
	$html.append("<option value=''>请选择</option>");
	if(resVal == "host" || resVal == "server"){
		$html.append("<option value='FileSystem'>分区</option>");
		$html.append("<option value='NetworkInterface'>网络接口</option>");
	}else if(resVal == "networkdevice" || resVal == "wirelessap" 
		|| resVal == "ids" || resVal == "NetsSluice" || resVal == "storage" || resVal == "pc"){
		$html.append("<option value='NetworkInterface'>网络接口</option>");
	}else if(resVal == "router" || resVal == "switch" 
		|| resVal == "routerswitch" || resVal == "firewall" || resVal == "loadbalance"){
		$html.append("<option value='CPU'>CPU</option>");
		$html.append("<option value='NetworkInterface'>网络接口</option>");
	}
}
/**
 * 加载资源类型
 * @param val 资源类型
 * @param $html 添加的下拉框组件
 */
function reLoadResourceTree(){
	var $html=$("#resoureTypeSelect_"+cacheObj.getRowID());
	initRes($html);
	$("#returnType_"+cacheObj.getRowID()).val("choice_resource");		
	$("#isReloadCom_"+cacheObj.getRowID()).val("false");
	$("#searchValue_"+cacheObj.getRowID()).val("");
	$("#instances_"+cacheObj.getRowID()).val("");	
	$("#instancesParent_"+cacheObj.getRowID()).val("");	
	$("#compositor_"+cacheObj.getRowID()).val("COMPOSITOR_DISPLAYNAME");
	$("#order_"+cacheObj.getRowID()).val("ASC");
	$("#pageSize_"+cacheObj.getRowID()).val("10");
	$("#pageNumber_"+cacheObj.getRowID()).val("1");
	$("#isReloadMetric_"+cacheObj.getRowID()).val("true");//模型组件的更改标识指标的更改	
	loadInstance();
}
/**
 * 获取模型
 * @param val 资源类型
 * @param $html 添加的下拉框组件
 */
function loadSelect(val,$html){
	$html.html("");
	$html.append("<option value='"+val+"'>全部</option>");
	var domainId=$("#domainId_"+cacheObj.getRowID()).val();
	if(!objValue.isNotEmpty(domainId)){
		domainId="";	
	}
	if(objValue.isNotEmpty(val)){
		$.ajax({
			type: 	"POST",
			url:	path+"/report/statistic/statisticOper!getModelByResourceType.action?userId="+userId+"&domainId="+domainId+"&resourceCategory="+val,
			dataType:	"json",
			cache:		false,
			dataFilter: function(data, type){
				var json = eval("("+data+")");
				for(var i=0;i<json.length;i++){
					for(var key in json[i]){
						$html.append("<option value='"+key+"'>"+json[i][key]+"</option>");
					}
				}
			}
		});
	}	
}
/**
 * 加载组件
 * @param val资源类型OR模型
 * @param $html 添加的下拉框组件 
 */
function loadComSelect(val,$html){
	$html.html("");
	$html.append("<option value=''>请选择</option>");
	$.ajax({
		type: 	"POST",
		url:	path + "/report/statistic/statisticOper!loadComSelect.action?resourceCategory="+val+"&reportType="+cacheObj.getReportType(),
		dataType:	"json",
		cache:		false,
		dataFilter: function(data, type){
			var json = (new Function("return " + data))();
			for(var i=0;i<json.length;i++){
				for(var key in json[i]){
					$html.append("<option value='"+key+"'>"+json[i][key]+"</option>");
				}
			}
		}
	});
}
/**
 * 弹出模态窗口
 * @param url 地址
 * @param awidth 宽
 * @param aheight 高
 */
function popWindow(url,awidth,aheight){   
	var params="help:no;scroll:no;resizable:no;status:0;dialogWidth:"+awidth+"px;dialogHeight:"+aheight+"px;center:yes"	
	showModalDialog(url,window,params); 	
} 
/**
 * 关闭窗口
 */
function closeWindow(){
	window.close(); 
}
/**
 * 弹出层
 * @param id 
 */
function showDiv(id){
	 $("#"+id).css("visibility","visible");	  
}
/**
 * 关闭弹出层
 */
function closeDiv(){
	$("#"+cacheObj.getDivID()).css("visibility","hidden");
	$("#myby").remove();
}
/**
 * 获得字符串实际长度,中文2,英文1,STR 要获得长度的字符串
 */
var str = {};
str.getLength = function(str) {
	var realLength = 0, len = str.length, charCode = -1;
	for (var i = 0; i < len; i++) {
		charCode = str.charCodeAt(i);
		if (charCode >= 0 && charCode <= 128) realLength += 1;
		else realLength += 2;
	}
	return realLength;
};
/**
 * 判断是否为空
 */
var objValue={};
objValue.isNotEmpty=function(val){
	var result=true;
	if(val==undefined||val==null||val=="null"||val==""){
		result=false;		
	}
	return result;
}
//弹出时间框 
function timeBox(id){
	WdatePicker({
	    startDate:getDate(null),
	    dateFmt:'yyyy/MM/dd HH:mm:ss',
	    el:id,
	    onclearing:function(){
	     return 0;
	    },
	    onpicked:function(){
	     var d = new Date(this.value);
	     return d.getTime();
	    }
	   });
}
/**
 * 获取当前时间
 */
function getDate(s) {
	var now;
	if (s != null) {
		now = s;
	} else {
		now = new Date();
	}
	var year = now.getFullYear();
	var month = now.getMonth() + 1;
	var day = now.getDate();
	var hour = now.getHours();
	var minute = now.getMinutes();
	var second = now.getSeconds();
	var nowdate = year + "/" + month + "/" + day + " " + hour + ":"+ minute + ":" + second;
	return nowdate;
}
//加载页面
function loadPage(url,div){
	var result=false;
	$.ajax({
		type: "POST",
		dataType:'html',
		url:url,
		success: function(data, textStatus){
			$("#"+div).html(""); 
			$("#"+div).html(data);
			result=true;
		},
		async:false
	});
	return result;
}
//提交表单
function submitFrom(url,ajaxParam){	
	var result=false;
	$.ajax({
		   type: "POST",
		   dataType:'String',
		   url: url,
		   data: ajaxParam,
		   success: function(data, textStatus){	
			   result=true;	   
		   },
			async:false
	 });
	return result
}
//根据给定字符串和分割符返回数组
function getArrayBySign(str){
	if(objValue.isNotEmpty(str)){
		return str.split(";");
	}
	else{
		return null;
	}
}
//数组删除值
function deleteArrayValue(array,value){
	for(var i=0;i<array.length;i++){
		if(array[i]==value){
			array[i]="";
			return true;
		}
	}
	return false;
}
//返回数组值
function getArrayValue(array,sign){
	var result=[];
	for(var i=0;i<array.length;i++){		
		result.push(array[i]);
		if(i!=array.length-1){
			result.push(sign);
		}		
	}
	return result.join("");
}
//指定数组元素删除
Array.prototype.indexSubOf = function(val) {
	for (var i = 0; i < this.length; i++) {		
		if (this[i] == val) return i;
	}
	return -1;
}
Array.prototype.removeSub = function remove(val) {
	var index = this.indexSubOf(val);
	if (index > -1) {
		this.splice(index, 1);
	}
}
Array.prototype.indexOf = function(val) {
	for (var i = 0; i < this.length; i++) {
		if (this[i] == val) return i;
	}
	return -1;
}
Array.prototype.remove = function remove(val) {
	var index = this.indexOf(val);
	if (index > -1) {
		this.splice(index, 1);
	}
}
