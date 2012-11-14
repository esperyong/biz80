 $(document).ready(function(){
	$.blockUI({message:$('#loading')});
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
    		 type: "GET",
    		 dataType:'json',
    		 url: path+"/profile/leafCategoryAction.action",
    		 data: "ajaxParam="+val,
    		 success: function(data, textStatus){
    		 var jsonstr = (new Function("return "+data.json))();
    		 $level2strategyType.empty();
    		 if(jsonstr){
    			 var resourceModleId = $("#resourceModleId").val();
    			 var arrlength = jsonstr.length;
    			 for(var i=0;i<arrlength;i++){
    				 if(resourceModleId != "" && resourceModleId == jsonstr[i].key) {
    					 $level2strategyType.append("<option value='"+jsonstr[i].key+"' selected>"+jsonstr[i].value+"</option>"); 
    				 }else {
    					 $level2strategyType.append("<option value='"+jsonstr[i].key+"'>"+jsonstr[i].value+"</option>"); 
    				 }
    			 }
    			 $level2strategyType.change();
    		 }
    		 
    	 }
    	 });
    	 return false; })
    	 
     $level2strategyType.bind("change", function(event) { 
		 $.ajax({
			   type: "GET",
			   dataType:'json',
			   url: path+"/profile/groupResourceAction.action",
			   data: "ajaxParam="+$(this).val()+"&strategyType="+$strategyType.val(),
			   success: function(data, textStatus){
			   var jsonstr = (new Function("return "+data.json))();
			   $strategyTypeChild.empty();
			   if(jsonstr){
				   var arrlength = jsonstr.length;
			       for(var i=0;i<arrlength;i++){
			    	   if(jsonstr[i].key == childResource) {
			    		   $strategyTypeChild.append("<option value='"+jsonstr[i].key+"' selected>"+jsonstr[i].value+"</option>"); 
			    	   }else {
			    		   $strategyTypeChild.append("<option value='"+jsonstr[i].key+"'>"+jsonstr[i].value+"</option>"); 
			    	   }
			       }
				   $strategyTypeChild.change();
			   }
			   
			   }
			});
		 return false; })
		 	 
		 $strategyTypeChild.bind("change", function(event) { 
			 $("#ChildStrategyArea").empty();
			 var val = $(this).val();
			 $.ajax({
				   type: "GET",
				   dataType:'json',
				   url: path+"/profile/childResourceAction.action",
				   data: "ajaxParam="+val,
				   success: function(data, textStatus){
	                    var jsonstr = (new Function("return "+data.json))(); 
	                    if(jsonstr){
		                   chunk(jsonstr,addCheckbox,$childStrategyArea,childProfileIdStr);
	                    }
	               }
				  
			});
		 return false; })
		 
		 $strategyType.change();
  
	$("#logout").click(function(event) {
		logout();
		return false;
		
	});
	$("#closeWindow").click(function() {
		logout();
		
	});
	$("#strategyName").blur();
	//var selectIdArray = new Array("copyProfileVO_userDomainId");
	//SimpleBox.renderTo(selectIdArray);
	$.unblockUI();
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
   $("#submitForm").click(function (){
	  submitForm();
   })

	function submitForm()
    {	
	   if(!$.validate( $("#form1") )) {return;}
	   if(checkRepeatSubmit()) {return;}
       var ajaxParam = $("#form1").serialize();
       $.blockUI({message:$('#loading')});
       $.ajax({
		   type: "POST",
		   url: path+"/profile/profileListCopy.action",
		   data: ajaxParam,
		   success: function(data, textStatus){
    	   		parentPageRefresh(data.profileId);
    	   		$.unblockUI();
    	   		submitFlag = false;
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
function addCheckbox(item,context,checkedStr){
	if(item != undefined && item != null) {
		var str = "<div class=\"for-inline\" style=\"width :95px;\"><input type='checkbox' name='checkChildStrategy'" +" value='"+item.key+"' disabled='disabled' "
		if(checkedStr != null && checkedStr.indexOf(item.key) != -1) {
			str += "checked";
		}
		str += "/>"+"<span style=\"*margin-top:4px;\">"+item.value+"</span></div>"; 
		context.append(str);
	}
}
function chunk(array, process,context,checkedStr){
   if(array){var items = array.concat();
   setTimeout(function(){
       var item = items.shift();
       process(item,context,checkedStr);
       if (items.length > 0){
           setTimeout(arguments.callee, 100);
       }
   }, 100);}else{
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
/**
* 是否重复profileName
**/
function isDuplicateProfileName(){
	var profileName = $('#strategyName').val();
	var profileType = "UserDefineProfile";
	var data = new function(){};
	data.name = profileName;
	data.type = profileType;
	data.profileId = '';
	data.isEdit = false;
	var flag = $.ajax({
				  type:'POST',
				  url: path + '/profile/isDuplicateProfileName.action',
				  cache:false,
				  data:data,
				  async: false
				 }).responseText;
	return (flag=='true');
}

var submitFlag = false;
function checkRepeatSubmit() {
	if(submitFlag) {
		var _information = new information({text:"正在提交，请稍候..."});
			_information.show();
		return true;
	}else {
		submitFlag = true;
		return false;
	}
}