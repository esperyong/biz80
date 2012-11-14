$(document).ready(function(){
	$.validationEngineLanguage.allRules.duplicateProfileName = {
			  "file":path + "/profile/duplicateProfileName.action?profileId=&profileType=UserDefineProfile&isEdit=false",
			  "alertTextLoad":"* 正在验证，请等待",
			  "alertText":"* 有重复的策略名称"
	}
	
	$("#form1").validationEngine({
		promptPosition:"centerRight", 
		inlineValidation: true,
		scroll:false,
		success:false,
	    failure : function() { callFailFunction()  } 
	});

	 var $strategyType = $("#strategyType");
     var $level2strategyType = $("#level2strategyType");
     var $strategyTypeChild =  $("#strategyTypeChild");
     var $childStrategyArea = $("#ChildStrategyArea");
     
     $strategyType.bind("change", function(event) { 
    	 var val = $(this).val();
    	 $.ajax({
    		 type: "POST",
    		 dataType:'json',
    		 url: path+"/profile/leafCategoryAction.action",
    		 data: "ajaxParam="+val,
    		 success: function(data, textStatus){
    		 var jsonstr = (new Function("return "+data.json))();
    		 $level2strategyType.empty();
    		 if(data.leafLevel != true){
    			 var arrlength = jsonstr.length;
    			 for(var i=0;i<arrlength;i++){
    				 $level2strategyType.append("<option value='"+jsonstr[i].key+"'>"+jsonstr[i].value+"</option>"); 
    			 }
    			 $level2strategyType.change();
    		 }else {
    			 $level2strategyType.hide();
    			 $strategyTypeChild.empty();
    			 if(jsonstr){
  				   var arrlength = jsonstr.length;
  			       for(var i=0;i<arrlength;i++){
  			    	 $strategyTypeChild.append("<option value='"+jsonstr[i].key+"'>"+jsonstr[i].value+"</option>"); 
  			       }
  			       $strategyTypeChild.change();
  			   	}
    		 }
    		 
    	 }
    	 });
    	 return false; })
    	 
     $level2strategyType.bind("change", function(event) {
		 $.ajax({
			   type: "POST",
			   dataType:'json',
			   url: path+"/profile/groupResourceAction.action",
			   data: "ajaxParam="+$(this).val()+"&strategyType="+$strategyType.val(),
			   success: function(data, textStatus){
			   var jsonstr = (new Function("return "+data.json))();
			   $strategyTypeChild.empty();
			   if(jsonstr){
				   var arrlength = jsonstr.length;
			       for(var i=0;i<arrlength;i++){
			    	   $strategyTypeChild.append("<option value='"+jsonstr[i].key+"'>"+jsonstr[i].value+"</option>");
			       }
			       $strategyTypeChild.change();
			   }
			   
			   }
			});
		 return false; })
		 	 
		 $strategyTypeChild.bind("change", function(event) {
			 $.blockUI({message:$('#loading')});
			 $childStrategyArea.empty();
			 var val = $(this).val();
			 $.ajax({
				   type: "POST",
				   dataType:'json',
				   url: path+"/profile/childResourceAction.action",
				   data: "ajaxParam="+val,
				   success: function(data, textStatus){
			 			if(data!=null){
		                    var jsonstr = (new Function("return "+data.json))();
		                    if(jsonstr){
			                   chunk(jsonstr,addCheckbox,$childStrategyArea);
		                    }
			 			}
			 			$.unblockUI();
				   }
				  
			});
		 return false; })
		 
	$("#strategyType").change();
  
	$("#logout").click(function(event) {
		logout();
		return false;
		
	});
   $("#submitForm").click(function (){
	  submitForm();
   })
	$("#closeWindow").click(function() {
		logout();
		
	});
//	var selectIdArray = new Array("domain");
//	SimpleBox.renderTo(selectIdArray);
});

	function logout()
    {
      window.opener = null;
      window.open("", "_self");
      window.close();
    }
	settings = {
		promptPosition:"centerRight", 
		inlineValidation: true,
		scroll:false,
		success:false,
	    failure : function() { callFailFunction()  } 
	}
 	 $.validate = function(form){
	     $.validationEngine.onSubmitValid = true;
	       if($.validationEngine.submitValidation(form,settings) == false){
	            if($.validationEngine.submitForm(form,settings) == true){
	            	return false;
	            }else{
	            	return true;
	            }
	       }else{
	           settings.failure && settings.failure(); 
	           return false;
	       }
    };

	function submitForm()
    {	
	   $.blockUI({message:$('#loading')});
	   if(!$.validate($("#form1"))) {$.unblockUI();return;}
	   if(checkRepeatSubmit()) {return;}
       var ajaxParam = $("#form1").serialize();
       $.ajax({
		   type: "POST",
		   dataType:'text',
		   url: path+"/profile/submitFormAction.action",
		   data: ajaxParam,
		   success: function(data, textStatus){
    	   		parentPageRefresh(data);
    	   		submitFlag = false;
    	   		$.unblockUI();
		    	logout();
		   },
		   error:function(msg) {
				alert( msg.responseText);
		   }
		});
    }


function addOption(item,context){
	var str = "<option value='"+item.key+"'>"+item.value+"</option>"; 
	context.append(str);
}
function addCheckbox(item,context){
	if(item == undefined){
		return;
	}
	var str = "<div class=\"for-inline\" style=\"width :95px;\"><input type='checkbox' name='checkChildStrategy'" +" value='"+item.key+"'/>"+"<span style=\"*margin-top:4px;\">"+item.value+"</span></div>"; 
	context.append(str);
}
function chunk(array, process,context){
   if(array){var items = array.concat();
   setTimeout(function(){
       var item = items.shift();
       process(item,context);
       if (items.length > 0){
           setTimeout(arguments.callee, 50);
       }
   }, 50);}else{
	   return;
   }
}
function callFailFunction(){
  //alert("in callFailFunction()");
}
function parentPageRefresh(profileId) {
	try{
		opener.userDefineProfileRefresh(profileId);
	 }catch(e) {
	  
	 }
}
var submitFlag = false;
function checkRepeatSubmit() {
	if(submitFlag) {
		alert("正在提交，请稍候...");
		return true;
	}else {
		submitFlag = true;
		return false;
	}
}