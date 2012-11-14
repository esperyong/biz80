var baselineTimeArray = {
	/**
	 * type
	 * 
	 * **/
	daliyBaseLine : "daliy_fieldset",
	weekliyBaseLine : "weekly_fieldset",
	exactTimeBaseLine : "exactTime_fieldset",
	/**
	 * obj:{
	 * 	startTime:"",
	 *  endTime:"",
	 *  type:"",
	 *  day:"",
	 * 	index:""
	 * }
	 * */
	timeArray : [],

	putTimeArray : function(newtime){
		if(this.validateTime(newtime)){
			if(this.getArrayIndexByTimeIndex(newtime.index) >= 0){
				this.updateArrayByIndex(newtime);
			}else{
				this.timeArray.push(newtime);
			}
			return true;
		}else{
			return false;
		}
	},
	validateTime : function(newtime){
		
		var timeArray = baselineTimeArray.getArray();
		// showArray();
		var timeArrayLength = timeArray.length;
		var result_flag = true;
		if(newtime.startTime < newtime.endTime){
			for(var i = 0; i < timeArrayLength; i += 1){
				var __isValidate = true;
				if(timeArray[i] === undefined){
					__isValidate = false;
					//alert(":4");
				}
				if(timeArray[i] && timeArray[i].index === newtime.index){
					__isValidate = false;
					//alert(":5");
				}
				
				//alert("正在验证第"+index+"行元素,newtime.type=" + newtime.type+",timeArray["+i+"].type="+timeArray[i].type);
				if(timeArray[i] && newtime.type !== timeArray[i].type){
					__isValidate = false;
					//alert(":2");
				}
				if(timeArray[i] && newtime.day 
						&& timeArray[i].day !== newtime.day){
					__isValidate = false;
					//alert(":3");
				}
				
				if(__isValidate){
					//alert("result_flag::::"+result_flag+"i="+i+"timeArray["+i+"].startTime=="+timeArray[i].startTime);
					result_flag = result_flag && 
					((newtime.startTime <= timeArray[i].startTime)
							&& (newtime.endTime <= timeArray[i].startTime))
							|| ((newtime.startTime >= timeArray[i].endTime)
									&& (newtime.endTime >= timeArray[i].endTime));
					if(!result_flag){
						break;
					}
				}
				
			}
			
		}else{
			result_flag = false;
		}
		return result_flag;
	},initializeArrays : function(){
		baselineTimeArray.initArray(baselineTimeArray.daliyBaseLine);
		baselineTimeArray.initArray(baselineTimeArray.weekliyBaseLine);
		baselineTimeArray.initArray(baselineTimeArray.exactTimeBaseLine);
	},initArray : function(fieldsetId){
		var timeArray = baselineTimeArray.getArray();
		var fieldset = $("#"+fieldsetId);
		
		fieldset.find("li[name=baseLineItem]").each(function(i,e){
			var dataTd = $($(e).find("td")[1]);
			var timeObj = {};
			timeObj.type = fieldsetId;
			timeObj.startTime = dataTd.find("[id$=_fromDay]").val()?dataTd.find("[id$=_fromDay]").val():""+dataTd.find("[id$=_fromTime]").val();
			timeObj.endTime = dataTd.find("[id$=_toDay]").val()?dataTd.find("[id$=_toDay]").val():""+dataTd.find("[id$=_toTime]").val();
			timeObj.day = dataTd.find("[name$=periodId]").val();
			timeObj.index =  dataTd.attr("index");
			baselineTimeArray.putTimeArray(timeObj,fieldsetId);
		});
	},getArray : function(){
			return   baselineTimeArray.timeArray;
	},updateArrayByIndex : function(newtime){
		this.getArray()[this.getArrayIndexByTimeIndex(newtime.index)] = newtime;
	},deleteTimeByIndex : function(index){
		this.getArray()[this.getArrayIndexByTimeIndex(index)] = undefined;
	},getArrayIndexByTimeIndex : function(index){
		var timeArray = baselineTimeArray.getArray();
		var result = -1 ;
		for(var i = 0 ;i < timeArray.length;i+=1){
			if(timeArray[i] && (timeArray[i].index === index)){
				return i;
			}
		}
		return result;
	}
};
function printobj(timeObj){
	var r = "";
	if(!timeObj){
		r+="{},";
	}
	for (var j in timeObj){
		r += "{id:" + j+ ",value:"+timeObj[j]+"},";
	}
	return "  "+r;
}
function showArray(){
	var showDiv = $("#showDiv");
	var result = "";
	if(showDiv.length==0){
		showDiv = $("<div></div>");
		var length = baselineTimeArray.getArray().length ;
		if(length==0){
			showDiv.html("[]");
		}else{
			result+="[";
			for(var i = 0 ; i < length ; i++ ){
				//alert(baselineTimeArray.daliyTimeArray[i].startTime);
				result += printobj(baselineTimeArray.getArray()[i]);
			}
			result+="]";
		}
//		alert(result);
		//showDiv.html(result);
		//$("body").attr("style","overflow:scroll");
		//$("body").append(showDiv);
	}
}