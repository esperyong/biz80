 $(document).ready(function(){
	$parentId = $("input[name=parentProfileId]");
 	$("#form1").validationEngine({
		promptPosition:"centerRight", 
		inlineValidation: true,
		scroll:false,
		success:false,
	    failure : function() { callFailFunction()  } 
	});
 	
 	$.validationEngineLanguage.allRules.duplicateChildProfileName = {
			  "file":path + "/profile/duplicateChildProfileName.action?parentId="+$parentId.val(),
			  "alertTextLoad":"* 正在验证，请等待",
			  "alertText":"* 有重复的策略名称"
	}
 	
    $("input").focus(function (){
                  $(this).addClass("focus");
             }).blur(function (){
                 $(this).removeClass("focus");
         })
  
	$("#logout").click(function(event) {
		logout();
		return false;
		
	});
	$("#closeWindow").click(function() {
		logout();
		
	});
});

	function logout()
    {
      window.opener = null;
      window.open("", "_self");
      window.close();
    }
	/*settings = {
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
    };*/
   $("#submitForm").click(function (){
	  submitForm();
   })

	function submitForm()
    {  
	   settings = {
		promptPosition:"centerRight", 
		inlineValidation: true,
		scroll:false,
		success:false/*,
	    failure : function(msg) { alert( msg.responseText);  }*/ 
	   }
	   if(!$.validate($("#form1"), settings)){return;}
	   if(checkRepeatSubmit()) {return;}
       var ajaxParam = $("#form1").serialize();
       $.ajax({
		   type: "POST",
		   dataType:'text',
		   url: path+"/profile/creatChildResourceAction.action",
		   data: ajaxParam,
		   success: function(data, textStatus){
		  	parentPageRefresh();
		  	submitFlag = false;
	    	logout();
		   },
		   error:function(msg) {
				alert( msg.responseText);
		   }
		});
   
    }
   function parentPageRefresh() {
	if (window.opener != null) {
		window.opener.location.href = window.opener.location.href;
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

 	