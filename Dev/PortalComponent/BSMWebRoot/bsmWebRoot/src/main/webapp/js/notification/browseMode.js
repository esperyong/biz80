function BrowseMode(){

  var viewId = null;
  var timeId = null;
  var userId = null;
  var viewName = null;
  var isHomePage = null;
  /*
  *viewid:${viewId},
    timeid:${timeId},
      userId:${userId},
        viewName:${viewName}
  */
  this.init = function(conf){
      this.viewId = conf.viewId;
      this.timeId = conf.timeId;
      this.userId = conf.userId;
      this.viewName = conf.viewName;
      this.isHomePage = conf.isHomePage;
  }
  
  this.getViewId = function(){
  	return this.viewId;
  }
  this.getTimeId = function(){
  	return this.timeId;
  }
  this.getUserId = function(){
  	return this.userId;
  }
  this.getViewName = function(){
  	return this.viewName;
  }
  
  this.getIsHomePage = function(){
  	return this.isHomePage;
  }
  
  this.closeViewPage = function(){
	window.opener = null;
	window.open("", "_self");
	window.close();
  }

  this.openEditPage = function(){
  		var url = path + '/notification/viewEditor.action?viewId=' + this.viewId;
  		winOpen({
        url: url,
        width: 700,
        height: 512,
        name: 'openViewEdit'
     });
  }

  
  this.thisMovie=function(movieName){
         if (navigator.appName.indexOf("Microsoft") != -1) {
             return window[movieName];
         } else {
             return document[movieName];
         }
  }
  
  this.openDetailPage=function(eventDataId){
  	var url = path+'/notification/opencontentInfo.action';
  	if(eventDataId != undefined && eventDataId != null ){
  		url = url + '?eventDataId=' + eventDataId;
  		winOpen({
            url: url,
            width: 800,
            height: 333,
            name: 'openDetailPage'
         });
  	}
  }
  
	this.openResourceDetail = function(parentInstanceId){
		if(parentInstanceId != undefined && parentInstanceId != null ){
			var url = path+"/detail/resourcedetail.action?instanceId="+parentInstanceId;
			window.open(url,'resourcedetail','height=650,width=1000,scrollbars=yes');
		}
	}
	this.openLinkDetail = function(parentInstanceId){
		if(parentInstanceId != undefined && parentInstanceId != null ){
			var url = "/netfocus/modules/link/linkdetail2.jsp?instanceid=" + parentInstanceId;
			window.open(url,'resourcedetail','height=650,width=1000,scrollbars=yes');
		}
	}
	this.openNTADetail = function(parentInstanceId,eventOccurTime,instanceName,platForm,content,level){
		if(parentInstanceId != undefined && parentInstanceId != null ){
			var levelName;
			if(level=="event.serverity.5"){
		    	levelName="致命";
		    }else if(level=="event.serverity.4"){
		    	levelName="严重";
		    }else if(level=="event.serverity.3"){
		    	levelName="次要";
		    }else if(level=="event.serverity.2"){
		    	levelName="警告";
		    }else if(level=="event.serverity.1"){
		    	levelName="信息";
		    }else if(level=="event.serverity.0"){
		    	levelName="未知";
		    }
			//var url = "/nta/modules/alert/alert_mg/flash.jsp?probeId=" + parentInstanceId + "&time=" + eventOccurTime;
			var url = "/nta/modules/alert/alert_mg/alarm_detail.jsp?probeId="+parentInstanceId+"&occurTime="+eventOccurTime+"&content="+encodeURIComponent(content)+"&platform="+encodeURIComponent(platForm)+"&objectName="+encodeURIComponent(instanceName)+"&level="+encodeURIComponent(levelName);
			window.open(url,'resourcedetail','height=650,width=1000,scrollbars=yes');
		}
	}
	
  
  this.addSleep = function(){
  	this.thisMovie('AlertListViewMode').addSleep();
  }

  this.addActivate = function(){
  	this.thisMovie('AlertListViewMode').addActivate();
  }
}

function editTab(viewName,viewId){
	browseMode.thisMovie('AlertListViewMode').rePageName(viewName);
}
function refreshFlash(userId, viewId, timeId){

}

getTimeId = function(){
	return this.timeId;
}

getUserId = function(){
	return this.userId;
}

function init(){
	
}

