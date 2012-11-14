/**
 * 实时分析有三个主页签，分别是设备，网络接口，应用
 * 三个页签分别取单词的前三个做为表示，设备--Dev;网络接口--Int; 应用--App
 * 设备中的子叶签表示方式同样的取单词的前三个，服务器设备--SerDev;网络设备--NetDev;存储设备--StoDev
 * 网络接口子叶签:服务器接口--SerInt;网络接口--NetInt;存储接口--StoInt
 * flash循环取数据中对于没有数据的节点，将不会再次提交插查询。
 * 例子：realDevFrom--中只保存存在指标值的节点，realSerDevFrom--存在用户所选所有节点(有序)
 */
var INSTANCEMAX=6;//最大可选资源数
var SIGN=",";//统一分隔符
var metricObj=new ChartData();//缓存保存Flash中的数据
var flashObj=new FlashObj(30);//flash对象容器,包含三个页签中的一个,每次切换页签时更换对象
var oldtimevalue=5000;//默认刷新时间段
var stop=0;//停止刷新标志
var isSend=true;//是否发送请求
/**
 * 定义类型页签对象
 * @param category 主页签
 * @param subCategory 子叶签
 * @returns {category}
 */
function category(category,subCategory){
	this.category=category;
	this.subCategory=subCategory;
}
category.prototype={
	setCategory:function(category){
		this.category=category;
	},
	setSubCategory:function(subCategory){
		this.subCategory=subCategory;
	}
};
var DevCategoryObj=new category("Dev","SerDev");//设备
var IntCategoryObj=new category("Int","SerInt");//网络接口
var AppCategoryObj=new category("App","DatApp");//应用
/**
 * 定义一个容器来装载页签对象，在切换主页签时对setCategoryOb进行设置切换不同的页签对象
 * @returns {categorySign}
 */
function categorySign(){
	this.sign="Dev";
	this.categoryObj=DevCategoryObj; 
}
categorySign.prototype={
		setCategoryObj:function(sign){
			if(this.sign==null||this.sign!=sign){				
				this.categoryObj=(new Function("return "+sign+"CategoryObj" ))();
				this.sign=sign;
			}			
		},getCategoryObj:function(){
			return this.categoryObj;
		},getSign:function(){
			return this.sign;
		}
};
var categorySignObj=new categorySign();//标签对象
/**
 * 对当前树的根节点以及资源类型进行缓存
 * @returns {catchTreeInfo}
 */
function catchTreeInfo(){
	this.rootNodeId="server";
	this.treeId="realSerDevTree";
}
catchTreeInfo.prototype={
	setRootNodeId:function(id){
		this.rootNodeId=id;
	},getRootNodeId:function(){
		return this.rootNodeId;
	},setTreeId:function(id){
		this.treeId=id;
	},getTreeId:function(){
		return this.treeId;
	}
}
var treeInfo=new catchTreeInfo();
function setTreeNode(node){//左侧树单击事件	
	var category=categorySignObj.getCategoryObj().category;
	var subCategory=categorySignObj.getCategoryObj().subCategory;	
	var selectNodeArray=getSelectNode(subCategory);//获得所有用户选中的节点	
	var count=getArrayLength(selectNodeArray);
	var selectID=node.getId();
	var index;		
	if(node.isChecked()){
		if(count<INSTANCEMAX){
			saveInstance(subCategory,selectID);//保存所有用户选中的节点
			saveExitInstance(category,selectID);//只保存存在指标值的节点		
			isExitMetricValue(category,selectID);//判断资源是否存在指标值
			var selectNodeArray=getSelectNode(subCategory);//获得所有用户选中的节点		
			index=getArrayIndex(selectNodeArray,selectID);//获得索引		
			if(getArrayLength(selectNodeArray)==1){		//首次选中节点											
				isShowRightDiv(category,subCategory);//显示右侧数据DIV	
				setTitleAndUnit(category,subCategory);//设这Flash标题和单位
				showFlash(category);//显示Flash
			}
		}else{
			node.clearChecked();
			return false;
		}			
	}else{		
		index=cleanNodeAndCutline(category,subCategory,selectID);
		deleteCutlineInfo(category,index);//删除图例显示名称和无指标图例下标
	}				
	openRefresh(category);	
	return true;		
}
function cleanNodeAndCutline(category,subCategory,selectID){//清空节点和图例,并返回取消的索引
	var selectNodeArray=getSelectNode(subCategory);
	index=getArrayIndex(selectNodeArray,selectID);//删除前获得索引
	deleteInstance(subCategory,selectID);//删除取消的节点在所有选中的节点中
	deleteExitInstance(category,selectID);//删除取消的节点在存在指标值的节点中
	selectNodeArray=getSelectNode(category);//获得存在指标值的节点
	if(isEmptyArray(selectNodeArray)){			
		metricObj.cleanData();
		isShowRightDiv(category,subCategory);	
		stopRefresh();					
	}
	return index;
}
function flow(category,subCategory,flag){//页签事件流程,flag=true标示主页签，false标示子叶签		
	stopRefresh();//停止刷新	
	metricObj.cleanData();//清空缓存	
	if(!flag){
		setExitInstance(category,subCategory);
		cleanCutline(category);	
		reSetNodeAndCutline(category,subCategory);	
	}
	if(isShowRightDiv(category,subCategory)){					
		transact(category,subCategory);						
	}	
}
function transact(category,subCategory){//执行设置标题,单位,指标,刷新,图例		
	showMetricAndRefresh(category,subCategory);
	setTitleAndUnit(category,subCategory);	
	showFlash(category);	
	openRefresh(category);	
}
function saveMetricType(category,obj){//保存选中的指标
	metricObj.cleanData();
	var subCategory=categorySignObj.getCategoryObj().subCategory;
	$("#real"+subCategory+"MetricType").val(obj.value);	
	$("#real"+category+"MetricType").val(obj.value);	
	var selectNodes=getSelectNode(subCategory);
	$("#real"+category+"SelectNode").val(selectNodes);
	$("#real"+subCategory+"CutlineNull").val("");
	isExitMetricValue(category,getArrayValue(selectNodes,SIGN));//判断是否存在指标
	if(category=="Int"){
		var MetricIntID=obj.id;
		var index=MetricIntID.substring(MetricIntID.length-1);
		var metricIndex=$("#realMetricInt").val();			
		metricTypeTextValue[metricIndex]=index;
		metricTypeValue[metricIndex]=index;
	}
	setTitleAndUnit(category,subCategory);	
	showFlash(category);	
}
function setTitleAndUnit(category,subCategory){	//flash单位和标题赋值	
	var title,unitIndex,unit;
	if(category!="Int"){
		var metricType=$("#real"+subCategory+"MetricType").val();
		title=$("#real"+metricType+category+"Text").html();
		unitIndex=$("#real"+metricType+category+"Unit").val();	
	}else{
		var metricIndex=$("#realMetricInt").val();			
		title=$("#realMetricTypeIntText_"+metricTypeValue[metricIndex]).html();
		unitIndex=$("#realMetricTypeIntUnit_"+metricTypeValue[metricIndex]).val();	
	}
	unit=CHART_UNIT[unitIndex];
	title=title+"("+unit+")";
	metricObj.setTitle(title);
	metricObj.setUnit(unit);
	setTitle("real"+category+"FlashTitle",title);
}
function showMetricAndRefresh(category,subcategory){//获取并显示当前的指标和刷新时间
	var metricType=$("#real"+subcategory+"MetricType").val();
	var refreshTime=$("#real"+subcategory+"RefreshTime").val();
	if(category!="Int"){
		$("#real"+metricType+category).attr("checked",true);		
	}
	else{
		setSelectAndMetric(subcategory);
	}	
	$("#real"+category+"Refresh").val(refreshTime);	
}
function deleteInstance(subCategory,selectID){//删除选中的资源
	var selectNodeArray=getSelectNode(subCategory);	
	if(deleteArrayValue(selectNodeArray,selectID)){	
		$("#real"+subCategory+"SelectNode").val(getArrayValue(selectNodeArray,SIGN));
	}
}
function saveInstance(subCategory,selectID){//保存选中的所有资源
	var selectNodeArray=getSelectNode(subCategory);		
	var index=getArrayIndex(selectNodeArray,selectID);		
	if(index==-1){//不能有重复值
		setArrayValue(selectNodeArray,selectID);			
		$("#real"+subCategory+"SelectNode").val(getArrayValue(selectNodeArray,SIGN));		
	}	
}
function deleteExitInstance(category,selectID){	//删除资源
	var selectNodeArray=getSelectNode(category);
	if(deleteArrayValue(selectNodeArray,selectID)){
		$("#real"+category+"SelectNode").val(getArrayValue(selectNodeArray,SIGN));		
		metricObj.deleteSeriesData(selectID);
	}
}
function saveExitInstance(category,selectID){//保存有指标的资源
	var selectNodeArray=getSelectNode(category);
	var index=getArrayIndex(selectNodeArray,selectID);
	if(index==-1){//不能有重复值
		setArrayValue(selectNodeArray,selectID);					
		$("#real"+category+"SelectNode").val(getArrayValue(selectNodeArray,SIGN));//存在指标
	}	
}
function setExitInstance(category,subCategory){	//把当前选中的资源赋值给real"+category+"SelectNode中
	$("#real"+category+"SelectNode").val("");//清空保存的资源ID
	var indexs=$("#real"+subCategory+"CutlineNull").val();//取出没有指标的资源下标	
	var selectNodeArray=getSelectNode(subCategory);	
	if(objValue.isNotEmpty(indexs)){
		var indexArray=getArrayBySign(indexs);
		for(var i=0;i<indexArray.lenght;i++){
			selectNodeArray[i]="";
		}
	}
	$("#real"+category+"SelectNode").val(getArrayValue(selectNodeArray,SIGN));
}
function parseXml(data,selectID,category){//解析数据
	var subCategory=categorySignObj.getCategoryObj().subCategory;
	var instanceNodes=getNodeObj(data,'metric/instance');
	if(instanceNodes!=null&&instanceNodes.length!=0){		
		if(instanceNodes.length==1){//只有点击单个节点时触发			
			var showInfo=getCutlineText(category,instanceNodes[0],true);
			var selectNodeArray=getSelectNode(subCategory);
			var index=getArrayIndex(selectNodeArray,selectID);
			showCutline(category,index,showInfo,selectID);
			data=data.replace(/&/g, "&amp;").replace(/"/g, "&quot;").replace(/</g, "&lt;").replace(/>/g, "&gt;");			
			var cutlineNameArray=getCutlineName(subCategory);	
			cutlineNameArray[index]=data;
			saveCutlineName(category,cutlineNameArray);
		}
		for(var i=0;i<instanceNodes.length;i++){
			var instanceNode=instanceNodes[i];	
			var instanceID=getNodeValue(instanceNode,"id");	
			var instanceValue=getNodeValue(instanceNode,"value");			
			setCutlineShow(instanceID,instanceValue,category);
		}	
	}else{			
		var selectIDArray=getArrayBySign(selectID);//selectID.split(SIGN)
		for(var i=0;i<selectIDArray.length;i++){
			if(selectIDArray[i]!=""&&selectIDArray[i]!=null){
				setCutlineShow(selectIDArray[i],"false",category);
			}			
		}
	}
}
function getCutlineText(category,node,flag){//图例显示的文本,flag，true标识是显示图例,false标识显示鼠标悬浮
	var name=getNodeValue(node,"name");
	var ip=getNodeValue(node,"ip");
	var type=getNodeValue(node,"type");
	var netInterface=getNodeValue(node,"netinterface");
	var showHtml=[];
	if(flag){	
		if(category!="Int"){
			showHtml.push(name+" - "+ip+"("+type+")");			
		}else{
			showHtml.push(name+" - "+netInterface+"("+type+")");
		}
	}else{
		showHtml.push("<ul><li>资源名称: "+name+"</li>");
		showHtml.push("<li>IP地址: "+ip+"</li>");
		if(category=="Int"){		
			showHtml.push("<li>接口名称: "+netInterface+"</li>");
		}
		showHtml.push("<li>类型: "+type+"</li>");
	}	
	return showHtml.join("");
}
function setCutlineShow(instanceID,instanceValue,category){//设置图例显示
	var subCategory=categorySignObj.getCategoryObj().subCategory;
	var selectNodeArray=getSelectNode(subCategory);
	var index=getArrayIndex(selectNodeArray,instanceID);	
	if(index!=-1){
		var isExitMetric=$("#real"+category+"CutlineR_"+index).val();
		if(isExitMetric!=instanceValue){
			if(instanceValue=="true"){
				setCutlineYuan(category,index);
			}else{
				setCutlineNull(category,index);
			}
		}
		if(instanceValue=="false"){			
			setCutlineNull(category,index);//设置图例无指标样式
			deleteExitInstance(category,instanceID);//删除指定资源ID
			var indexNull=$("#real"+subCategory+"CutlineNull").val();
			if(indexNull!=null&&indexNull!=""){
				$("#real"+subCategory+"CutlineNull").val(indexNull+SIGN+index);			
			}else{
				$("#real"+subCategory+"CutlineNull").val(index);
			}	
		}
	}
}
function getSelectNode(subCategory){//获得节点值
	var selectNode=$("#real"+subCategory+"SelectNode").val();
	if(objValue.isNotEmpty(selectNode)){
		return getArrayBySign(selectNode);		
	}
	else{		
		return  getArrayBySign(getStringByMax());
	}	
}
function cleanCutline(category){//清除图例
	$("#real"+category+"Ul li").each(function(i){
		$("#real"+category+"Cutline_"+i).css("display","none");
		$("#real"+category+"CutlineText_"+i).html("");		
	});	
}
function showCutline(category,index,nodeText,selectID){//展示图例名称
	$("#real"+category+"Cutline_"+index).css("display","block");	
	$("#real"+category+"CutlineL_"+index).val(selectID);	
	setCutlineYuan(category,index);	
	$("#real"+category+"CutlineText_"+index).html(nodeText);
}
function reSetNodeAndCutline(category,subCategory){	//切换回页签时把节点和图例回复原值
	var seletNodeArray=getSelectNode(subCategory);	
	if(!isEmptyArray(seletNodeArray)){		
		var cutlineNameArray=getCutlineName(subCategory);
		var cutlineNullArray=getCutlineNull(subCategory);
		for(var i=0;i<seletNodeArray.length;i++){
			if(objValue.isNotEmpty(seletNodeArray[i])){
				var index=i;
				var instanceNodes=getNodeObj(cutlineNameArray[index],'metric/instance');
				if(instanceNodes!=null){
					var showInfo=getCutlineText(category,instanceNodes[0],true);
					showCutline(category,index,showInfo,seletNodeArray[index]);	
				}			
			}
		}
		if(cutlineNullArray){
			for(var i=0;i<cutlineNullArray.length;i++){
				if(objValue.isNotEmpty(cutlineNullArray[i])){
					setCutlineNull(category,cutlineNullArray[i]);
					seletNodeArray[cutlineNullArray[i]]="";
				}								
			}
		}			
		$("#real"+category+"SelectNode").val(seletNodeArray);
	}	
}
function getCutlineNull(subCategory){//获得无值图例
	var cutlineNull=$("#real"+subCategory+"CutlineNull").val();
	if(objValue.isNotEmpty(cutlineNull)){return getArrayBySign(cutlineNull);}//cutlineNull.split(SIGN);
	else{return null;}
}
function getCutlineName(subCategory){//获得图例显示的名称	
	var cutlineName=$("#real"+subCategory+"CutlineName").val();	
	if(cutlineName!=null&&cutlineName!=""){return getArrayBySign(cutlineName);}//cutlineName.split(SIGN);
	return null;
}
function saveCutlineName(category,cutlineNameArray){//保存图例显示的名称
	var subCategory=categorySignObj.getCategoryObj().subCategory;
	cutlineName=getArrayValue(cutlineNameArray,SIGN);
	$("#real"+subCategory+"CutlineName").val(cutlineName);
}
function deleteCutlineInfo(category,index){//删除图例显示名称和无指标图例下标	
	$("#real"+category+"Cutline_"+index).css("display","none");	
	var subCategory=categorySignObj.getCategoryObj().subCategory;
	deleteInstance(subCategory,selectID);//删除节点
	deleteExitInstance(category,selectID);
	var cutlineNameArray=getCutlineName(subCategory);
	cutlineNameArray[index]="";//删除图例保存的文本
	saveCutlineName(category,cutlineNameArray);	//保存删除后的图例显示
	var selectID=$("#real"+category+"CutlineL_"+index).val();
	var isExitMetric=$("#real"+category+"CutlineR_"+index).val();
	if(isExitMetric=="false"){
		var indexNull=$("#real"+subCategory+"CutlineNull").val();
		if(objValue.isNotEmpty(indexNull)){
			var indexNullArray=getArrayBySign(indexNull);//indexNull.split(SIGN);
			deleteArrayValue(indexNullArray,index);
			var indexNull=getArrayValue(indexNullArray,SIGN);
			$("#real"+subCategory+"CutlineNull").val(indexNull);
		}
	}
}
function openRefresh(category){//开启刷新		
	var newtimevalue=$("#real"+category+"Refresh").val();
	if(oldtimevalue!=newtimevalue){
		if(stop==0){stop=self.setInterval("refresh(\""+category+"\")",newtimevalue);
		}else{			
			self.clearInterval(stop);//关闭
			stop=self.setInterval("refresh(\""+category+"\")",newtimevalue);
		}
		oldtimevalue=newtimevalue;
	}else if(oldtimevalue==newtimevalue){		
		if(stop==0){stop=self.setInterval("refresh(\""+category+"\")",oldtimevalue);}
		else{refresh(category);}		
	}	
}
function isShowRightDiv(category,subCategory){//显示右侧Div	
	if(category=="Dev"&&subCategory=="NetDev"){		
		$("#realNetDevMetric").css("display","block");		
	}else if(category=="Dev"&&subCategory!="NetDev"){
		$("#realNetDevMetric").css("display","none");		
	}		
	var selectNodeArray=getSelectNode(subCategory);		
	if(!isEmptyArray(selectNodeArray)){
		$("#real"+category+"DataNull").css("display","none");
		$("#real"+category+"RigTop").css("display","block");	
		return true;
	}else{
		$("#real"+category+"RigTop").css("display","none");
		$("#real"+category+"DataNull").css("display","block");	
		return false;
	}
}
function getArrayLength(array){//获取数组的长度
	var length=0;
	for(var i=0;i<array.length;i++){
		if(array[i]!=""){length++;}
	}
	return length;
}
function getArrayIndex(array,value){//得到指定值在数组中的下标
	for(var i=0;i<array.length;i++){
		if(array[i]==value){return i;}
	}
	return -1;
}
function setArrayValue(array,value){//数组赋值
	var array=array;
	for(var i=0;i<array.length;i++){		
		if(array[i]==""){array[i]=value;break;}
	}
}
function deleteArrayValue(array,value){//数组删除值
	for(var i=0;i<array.length;i++){
		if(array[i]==value){
			array[i]="";
			return true;
		}
	}
	return false;
}
function isEmptyArray(array){//数组为空判断
	for(var i=0;i<array.length;i++){		
		if(array[i]!=undefined&&array[i]!=""){return false;}
	}
	return true;
}
function getArrayValue(array,sign){//返回数组值
	var result=[];
	for(var i=0;i<array.length;i++){		
		result.push(array[i]);
		if(i!=array.length-1){result.push(sign);}		
	}
	return result.join("");
}
function setCutlineLight(category,index){//图例高亮
	$("#real"+category+"CutlineText_"+index).removeClass();
	$("#real"+category+"CutlineText_"+index).addClass("on-txt");	
	$("#real"+category+"CutlineColor_"+index).css("background-color",CHART_COLOR[index]);
	$("#real"+category+"CutlineA_"+index).addClass("ico ico-tongjiclose");	
	$("#real"+category+"CutlineC_"+index).removeClass();
	$("#real"+category+"CutlineC_"+index).addClass("content");		
	$("#real"+category+"CutlineM_"+index).removeClass();
	$("#real"+category+"CutlineM_"+index).addClass("li-on-m");	
	$("#real"+category+"CutlineR_"+index).removeClass();
	$("#real"+category+"CutlineR_"+index).addClass("li-on-r");	
	$("#real"+category+"CutlineL_"+index).removeClass();
	$("#real"+category+"CutlineL_"+index).addClass("li-on-l");		
}
function setCutlineYuan(category,index){//图例正常显示
	$("#real"+category+"CutlineText_"+index).removeClass();
	$("#real"+category+"CutlineText_"+index).addClass("txt");
	$("#real"+category+"CutlineColor_"+index).css("background-color",CHART_COLOR[index]);
	$("#real"+category+"CutlineR_"+index).val("true");
	$("#real"+category+"CutlineA_"+index).removeClass();
	$("#real"+category+"CutlineC_"+index).removeClass();
	$("#real"+category+"CutlineM_"+index).removeClass();
	$("#real"+category+"CutlineM_"+index).addClass("li-m");	
	$("#real"+category+"CutlineR_"+index).removeClass();
	$("#real"+category+"CutlineR_"+index).addClass("li-r");		
	$("#real"+category+"CutlineL_"+index).removeClass();
	$("#real"+category+"CutlineL_"+index).addClass("li-l");								
}
function setCutlineNull(category,index){//图例无指标显示	
	$("#real"+category+"CutlineText_"+index).removeClass();
	$("#real"+category+"CutlineText_"+index).addClass("txt");
	$("#real"+category+"CutlineC_"+index).removeClass();
	$("#real"+category+"CutlineA_"+index).removeClass();
	$("#real"+category+"CutlineM_"+index).removeClass();
	$("#real"+category+"CutlineM_"+index).addClass("li-line-m");
	$("#real"+category+"CutlineR_"+index).removeClass();
	$("#real"+category+"CutlineR_"+index).addClass("li-line-r");
	$("#real"+category+"CutlineL_"+index).removeClass();
	$("#real"+category+"CutlineL_"+index).addClass("li-line-l");
	$("#real"+category+"CutlineR_"+index).val("false");												
}
function showMouseoverInfo(category,index){//返回图例鼠标悬浮显示文字
	var subCategory=categorySignObj.getCategoryObj().subCategory;
	var flag=$("#real"+category+"CutlineR_"+index).val();   
	var instanceinfoArray=getCutlineName(subCategory);
	var instanceinfo=instanceinfoArray[index];
	var instanceNodes=getNodeObj(instanceinfo,'metric/instance');	
	if(instanceNodes!=null){
		var showHtml=[];
		showHtml.push(getCutlineText(category,instanceNodes[0],false));
	    if(flag!="true"){showHtml.push("<li>说明: 无此指标</li>");}
	    showHtml.push("</ul>");
		return showHtml.join("");
	}
	return null;
}
function cleanInput(obj){//清空查询框
	var selectvalue=$("#"+obj.id).val();
	if(selectvalue=="输入IP地址或资源名称"){$("#"+obj.id).val("");}
	if(selectvalue=="输入IP地址、资源名称或接口名称"){$("#"+obj.id).val("");}
}
function showFlash(category){//在每次切换页签和指标时，设置Falsh快速显示	
	var endTime ;
	var startTime;
	var title=metricObj.title;
	if(metricObj.endTime!=null){
		startTime=metricObj.startTime;
		endTime=metricObj.endTime;
	}
	flashObj.getFlashObj(category).setData(getFlashXml(startTime,endTime,title));
}
function getStringByMax(){//根据最大可选资源返回字符串
	var result=[];
	for(var i=1;i<INSTANCEMAX;i++){result.push(SIGN);}
	return result.join("");
}
function getArrayBySign(str){//根据给定字符串和分割符返回数组
	if(objValue.isNotEmpty(str)){return str.split(SIGN);}
	else{return null;}
}
function loadPage(url,div){//加载页面
	$.ajax({
		type: "POST",
		dataType:'html',
		url:url,
		success: function(data, textStatus){
			$("#"+div).html(""); 
			$("#"+div).html(data);
		},
		async:false
	});
}
function isExitMetricValue(category,selectID){//请求资源指标是否存在
	var metricType=$("#real"+category+"MetricType").val();
	var ajaxparame="metricType="+metricType+"&selectNodes="+selectID;
	if(category=="Int"){ajaxparame+="&netInterFaceFlag="+category;}
	$.ajax({
			type: "POST",
			dataType:'String',
			url: path+"/report/real/realManage!isExitMetric.action",
			data:ajaxparame,
			success: function(data, textStatus){		
				parseXml(data,selectID,category);			
			}});
}
function refresh(category){//刷新 			
	var selectNodeArray=getSelectNode(category);	
	if(!isEmptyArray(selectNodeArray)){	
		var category=category;
		var subCategory=categorySignObj.getCategoryObj().subCategory;
		var instanceIDs=$("#real"+subCategory+"SelectNode").val();	
		var ajaxparame=$("#real"+category+"From").serialize();
		ajaxparame=ajaxparame+"&interval="+REALINTERVAL;
		var url=path+"/report/real/realManage!fectchData.action";
		getFlashData(category,url,ajaxparame,instanceIDs);//获取Flash值					
	}		
}
function selectNode(obj){//模糊查询  
	$.blockUI({message:$('#loading')});	    
	var param="userId="+userId;
	if(categorySignObj.getSign()=="Int"){param+="&childResourceType="+$("#networdInterValue").val();}
	var key=$("#"+obj.id+"Input").val();
	var type=$("#"+obj.id+"Select").val();
	if(type=="ip"){	param+="&queryIp="+key;		
	}else if(type=="name"){param+="&queryResourceName="+key;
	}else{param+="&queryNetName="+key;}
	var rootNodeId=$("#"+obj.id+"Root").val();			
	param+="&rootNodeId="+rootNodeId+"&treeId="+treeInfo.getTreeId();	
	var url=path+"/report/tree/realTreeAction.action";		
	$("#"+obj.id+"TreeDiv").load(url,param,function(){$.unblockUI();});	
}
function devMouseover(obj){
	var index=obj.id.split("_")[1];
    setCutlineLight(devCategory,index);
    var showHtml=showMouseoverInfo(devCategory,index);
    if(devPanel != null){
		devPanel.close("close");			
		devPanel = null;		
	}
	devPanel = new winPanel({
		html:showHtml, 	
		width:300,
		x:$(obj).offset().left,
		y:$(obj).offset().top,
		isautoclose:false, 
		listeners:{
			closeAfter:function(){	
				devPanel=null;
			}},
		isDrag:false
		},{
		winpanel_DomStruFn:"blackLayer_winpanel_DomStruFn" 
		}); 
	devPanel.setX($(obj).offset().left);
	devPanel.setY($(obj).offset().top-devPanel.getHeight());
}
function devMouserout(obj){
	var index=obj.id.split("_")[1];
	var flag=$("#realDevCutlineR_"+index).val();
	if(flag!="false"){
		setCutlineYuan(devCategory,index);
	}else{
		setCutlineNull(devCategory,index);
	}
	if(devPanel != null){
		devPanel.close("close");			
		devPanel = null;		
	}
}
function devClose(obj){
	var closeFlag=false;
	var index=obj.id.split("_")[1];
	var nodeText=$("#realDevCutlineText_"+index).html();
	var selectID=$("#realDevCutlineL_"+index).val();
	var subCategory=categorySignObj.getCategoryObj().subCategory;
	var treeID="real"+subCategory+"Tree";
	var treeObj=(new Function("return "+treeID ))();
	var nodeObj=treeObj.getNodeById(selectID);
	nodeObj.clearChecked();
	cleanNodeAndCutline(devCategory,subCategory,selectID);
	deleteCutlineInfo(devCategory,index);
	if(devPanel != null){
		devPanel.close("close");			
		devPanel = null;		
	}	
	openRefresh(devCategory);
}