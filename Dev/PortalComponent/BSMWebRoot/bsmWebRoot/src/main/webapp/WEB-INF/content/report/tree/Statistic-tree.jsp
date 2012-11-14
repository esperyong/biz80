<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
${treeHtml}
<div id="reportWaitLoad"></div>
<script type="text/javascript">
var resGroupOp = new MenuContext({x:20,y:100,width:115,listeners:{click:function(id){}}},{menuContext_DomStruFn:"ico_menuContext_DomStruFn"});
var shareOp = new MenuContext({x:20,y:150,width:100,listeners:{click:function(id){}}},{menuContext_DomStruFn:"ico_menuContext_DomStruFn"});
var reportTree = new Tree({
	id:"${treeId}",
	plugins:["singleExpend"],
	listeners: {
		nodeClick:function(node) {
			var id="";
			var type="";			
			if(node.isLeaf()){				
				if(node.parent().parent().getId()=="myreport"){
					id=node.getId();
					type=node.parent().getId();
					myReport(id,type,"myReport");
					cacheReportObj.setRoot("myreport");
				}else if(node.parent().parent().getId()=="sharereport"){
					id=node.getId();
					type=node.parent().getId();
					allReport(id,type,"sharaReport");
					cacheReportObj.setRoot("sharaReport");
				}else{				
					if(node.parent().getId()=="myreport"){						
						type=node.getId();						
						allReport(id,type,"myReport");
					}else{
						type=node.getId();
						allReport(id,type,"sharaReport");
					}
					cacheReportObj.setRoot("sharaReport");
				}
			}else{
				if(node.parent().getId()=="root"){	
					if(node.getId()=="myreport"){
						allReport(id,type,"myReport");
						cacheReportObj.setRoot("myreport");
					}else{
						allReport(id,type,"sharaReport");
						cacheReportObj.setRoot("sharaReport");
					}			
				}else{	
					type=node.getId();
					if(node.parent().getId()=="myreport"){												
						allReport(id,type,"myReport");
						cacheReportObj.setRoot("myreport");
					}else{						
						allReport(id,type,"sharaReport");
						cacheReportObj.setRoot("sharaReport");
					}
				}							
			}					
  		},
  	    toolClick:function(node){
  	    	if(node.parent().getId()!="BusinessServices"){
  	    		if(node.parent().parent().getId()=="myreport"){
  	  	    	  resGroupOp.position(event.x,event.y);
  	  			  resGroupOp.addMenuItems
  	  			  ([[
  	  			       {ico:"report",text:"立即生成报告",id:"createReport",listeners:{
  	  					click:function(){  	
  	  						resGroupOp.hide();
  	  						$.blockUI({message:$('#loading')});
  	  						var url="${ctx}/report/statistic/statisticManage!generateReport.action";
  	  						var param="reportID="+node.getId()+"&userId="+userId;
  	  						$("#reportWaitLoad").load(url,param,function(){
  	  							allReport(node.getId(),"","myReport");
  	  							$.unblockUI();});
  	  						
  	  					  }
  	  					}},
  	  					{ico:"mail",text:"邮件订阅",id:"mail",listeners:{
  	  						click:function(){	
  	  							resGroupOp.hide();
  	  							cacheReportObj.setNode(node);
  	  							subscribeReport(node.getId(),node.getText()); 								
  	  						  }
  	  					}},
  	  					{ico:"edit",text:"编辑",id:"edit",listeners:{
  		  						click:function(){
  		  							resGroupOp.hide(); 							
  		  							popWindow("${ctx}/report/statistic/statisticManage!loadAddReport.action?userId="+userId+"&reportID="+node.getId(),980, 580);							
  		  						}
  		  				}},					
  	  				    {ico:"delete",text:"删除",id:"del",listeners:{
  	  					click:function(){
  	  						resGroupOp.hide();
  	  						popCon.setContentText("是否删除当前报告，以及所有报告实例？"); //也可以在使用的
  	  						popCon.show();
  	  						popCon.setConfirm_listener(function(){
  	  							popCon.hide();
  	  							var result=submitFrom("${ctx}/report/statistic/statisticOper!deleteCustomReport.action","reportID="+node.getId());
  	  	  						 if(result){
  	  	  							refresh();
  	  	  							allReport("","","myreport");
  	  	  						 }  
  	  						});						 						
  	  					}
  	  				}}]]);
  	  	    	}else{ 	   
  	    			     if(node._get$Ico().attr("class")=="ico-16 ico-16-mailpaper"){
  	    			    	 shareOp.position(event.x+5,event.y+50);
  	 		  	    		 shareOp.addMenuItems
  	 		    			  ([[ 
  	    			    	 	{ico:"mail",text:"邮件订阅",id:"subscribeShareMail",listeners:{
  	     						click:function(){	
  	     							shareOp.hide();
  	     							subscribeSharedReport(userId,node.getId(),true);	
  	     							node.setIco("ico-16 ico-16-allmail");
  	     						  }
  	    			    	 	}}]]); 
  	    			     }else{
  	    			    	 shareOp.position(event.x+5,event.y+50);
  	 		  	    		shareOp.addMenuItems
  	 		    			  ([[ 
  		    			    	 {ico:"mail_del",text:"取消订阅",id:"noSubscribeShareMail",listeners:{
  		     						click:function(){
  		     							shareOp.hide(); 							
  		     							subscribeSharedReport(userId,node.getId(),false);	
  		     							node.setIco("ico-16 ico-16-mailpaper");
  		     						}
  		     					}}]]);    			    	 
  	    			     }    					    				 
  	  	    	}
  	    	}else{
  	    		if(node.parent().parent().getId()=="myreport"){
  	  	    	  resGroupOp.position(event.x,event.y);
  	  			  resGroupOp.addMenuItems
  	  			  ([[
  	  			       {ico:"report",text:"立即生成报告",id:"createReport",listeners:{
  	  					click:function(){  	
  	  						resGroupOp.hide();
  	  						$.blockUI({message:$('#loading')});
  	  						var url="${ctx}/report/statistic/statisticManage!generateReport.action";
  	  						var param="reportID="+node.getId()+"&userId="+userId;
  	  						$("#reportWaitLoad").load(url,param,function(){
  	  							allReport(node.getId(),"","myReport");
  	  							$.unblockUI();});
  	  						
  	  					  }
  	  					}},
  	  					{ico:"mail",text:"邮件订阅",id:"mail",listeners:{
  	  						click:function(){	
  	  							resGroupOp.hide();
  	  							cacheReportObj.setNode(node);
  	  							subscribeReport(node.getId(),node.getText()); 								
  	  						  }
  	  					}},					
  	  				    {ico:"delete",text:"删除",id:"del",listeners:{
  	  					click:function(){
  	  						resGroupOp.hide();
  	  						popCon.setContentText("是否删除当前报告，以及所有报告实例？"); //也可以在使用的
  	  						popCon.show();
  	  						popCon.setConfirm_listener(function(){
  	  							popCon.hide();
  	  							var result=submitFrom("${ctx}/report/statistic/statisticOper!deleteCustomReport.action","reportID="+node.getId());
  	  	  						 if(result){
  	  	  							refresh();
  	  	  							allReport("","","myreport");
  	  	  						 }  
  	  						});						 						
  	  					}
  	  				}}]]);
  	  	    	}else{ 	   
  	    			     if(node._get$Ico().attr("class")=="ico-16 ico-16-mailpaper"){
  	    			    	 shareOp.position(event.x+5,event.y+50);
  	 		  	    		 shareOp.addMenuItems
  	 		    			  ([[ 
  	    			    	 	{ico:"mail",text:"邮件订阅",id:"subscribeShareMail",listeners:{
  	     						click:function(){	
  	     							shareOp.hide();
  	     							subscribeSharedReport(userId,node.getId(),true);	
  	     							node.setIco("ico-16 ico-16-allmail");
  	     						  }
  	    			    	 	}}]]); 
  	    			     }else{
  	    			    	 shareOp.position(event.x+5,event.y+50);
  	 		  	    		shareOp.addMenuItems
  	 		    			  ([[ 
  		    			    	 {ico:"mail_del",text:"取消订阅",id:"noSubscribeShareMail",listeners:{
  		     						click:function(){
  		     							shareOp.hide(); 							
  		     							subscribeSharedReport(userId,node.getId(),false);	
  		     							node.setIco("ico-16 ico-16-mailpaper");
  		     						}
  		     					}}]]);    			    	 
  	    			     }    					    				 
  	  	    	}
  	    	}  	    			  
	  }
 	}
});
//订阅共享报告
function subscribeSharedReport(userId,id,isSubscribe){
	var param="userId="+userId+"&reportID="+id+"&isSubscribe="+isSubscribe;
	submitFrom("${ctx}/report/statistic/statisticManage!subscribeSharedReport.action",param);
}
</script>
