	var Sliber = function(){
			  var toast = new Toast({position:"CT"});
   			var green = {
    			  createExam:function(height,unit){
    			     this.$ico = $(example.ico());
    			     this.$text = $(example.text("正常"));
    			     this.$all = $(example.all("green"));
    			     this.$all.append(this.$ico).append(this.$text);
    			     this.$mark = $('<span class="cue-green"></span>').css("height","100%");
    			  }
    			}
    			
   			var yellow = {
    			  createExam:function(height,val,unit,top){
						if(unit!=="%"){
  							height=66;
  						}    			  	  
		             this.$input = $(example.input(val)).hide();
		             this.$span = $(example.span(val)).show();
		             this.$ico = $(example.ico());
		             this.$text = $(example.text("警告"));			    
    			       this.$all = $(example.all("yellow"));
    			       this.$all.append(this.$ico).append(this.$text).append(this.$input).append(this.$span);
    			       this.$btn = $('<span class="cue-ico cue-ico-yellow"></span>');
    			       this.$mark = $('<span class="cue-yellow"></span>').append(this.$btn).css("height",height+"%");
    			       	var isPercent = false;

      				   	if(unit==="%"){
      				   		isPercent = true;
    			       	   this.bindMove();
    			       }
					   
                 		this.$span.bind("click",{self:this,ismove:true},example.spanclick);
                 		this.$input.bind("blur",{self:this,isPercent:isPercent},example.blurInput).bind("keyup",{self:this,ismove:true,isPercent:isPercent},example.checkInput);
    			  },
				bindMove:function(){
    					var self = this;
              this.$btn.bind("mousedown",{self:self,ismove:true},down);
              function down(event){
                example.spanclick(event);
                self.lastY = event.pageY;
    						bindMove();
    						return false;
    					};
    					function bindMove(event){
    						$("body").bind("mousemove",{self:self,ismove:true},mouseMove).bind("mouseup",{self:self,ismove:true},clearMove);
    						self.$btn.bind("mousemove",{self:self,ismove:true},mouseMove).bind("mouseup",{self:self,ismove:true},clearMove);;
    						self.$mark.bind("mousemove",{self:self,ismove:true},mouseMove).bind("mouseup",{self:self,ismove:true},clearMove);;
    					}
    					
    					function mouseMove(event){
    						clearMove();
    						var step = self.lastY -event.pageY;
    						self.lastY = event.pageY;
    						var height = self.$mark.height();
    						var val = ((149-height)/149*100);
    						val = val.toFixed(2);
    						var redVal = parseInt(red.$input.val());
							//alert(height+":::"+step );
    						if( height-step >=  150 || val >= redVal){
							//alert(1);
    							return;
    						}
    						var newHeight = height-step;
    						if(val<0){
    							val=0.01;
    							newHeight=149;
    						}
    						
    						if(val >=redVal || newHeight < red.$mark.height()){
                  val = redVal+0.01;
                  newHeight = 149-(redVal/100*149)+1;
                }
    						self.$mark.height(newHeight);
    						self.$input.val(val);
    						this.interval = setTimeout(bindMove,1);
    					}
    					function clearMove(event){
      						$("body").unbind("mousemove",mouseMove).unbind("mouseup",clearMove);
      						self.$btn.unbind("mousemove",mouseMove).unbind("mouseup",clearMove);
      						self.$mark.unbind("mousemove",mouseMove).unbind("mouseup",clearMove);
      						if(event){
                    			example.blurInput(event);
                  			}
    					}
					
				}
    			}
    			
   			var red = {
  				createExam: function(height, val, unit, top){
  						if(unit!=="%"){
  							height=33;
  						}
      					var self = this;
      					this.$input = $(example.input(val)).hide();
      					this.$span = $(example.span(val)).text(val).show();
      					this.$ico = $(example.ico());
      					this.$btn = $('<span class="cue-ico cue-ico-red"></span>');
      					this.$text = $(example.text("严重"));
      					this.$all = $(example.all("red"));
      					this.$all.append(this.$ico).append(this.$text).append(this.$input).append(this.$span);
      					this.$mark = $('<span class="cue-red"></span>').append(this.$btn).css("height", height + "%");
      				   	var isPercent = false;

      				   	if(unit==="%"){
      				   		isPercent = true;
    			       	   this.bindMove();
    			       }
      					this.$span.bind("click",{self:this,ismove:true},example.spanclick);
      					
      					this.$input.bind("blur",{self:this,isPercent:isPercent},example.blurInput).bind("keyup",{self:this,ismove:true,isPercent:isPercent},example.checkInput);
  				},
  				bindMove:function(){
    					var self = this;
    					this.$btn.bind("mousedown",{self:self,ismove:true},down);
    					function down(event){
        					  example.spanclick(event);
        						bindMove();
        						self.lastY = event.pageY;
        						return false;
    					};
    					
    					function bindMove(event){
    						self.flag = true;
    						$("body").bind("mousemove",{self:self,ismove:true},mouseMove).bind("mouseup",{self:self,ismove:true},clearMove);
    						self.$btn.bind("mousemove",{self:self,ismove:true},mouseMove).bind("mouseup",{self:self,ismove:true},clearMove);
    						self.$mark.bind("mousemove",{self:self,ismove:true},mouseMove).bind("mouseup",{self:self,ismove:true},clearMove);
    					}
    					
    					function mouseMove(event){
    						if(!self.flag) return;
    						var step = self.lastY -event.pageY;
    						self.lastY = event.pageY;
    						var height = self.$mark.height();
    						var val = ((152-height)/149*100);
    						val = val.toFixed(2);
    						var yellowVal = parseInt(yellow.$input.val());
    						if(val <=yellowVal && step < 0){
    							return;
    						}
    						var newHeight = height-step;
    						
    						if(val <=yellowVal || newHeight > yellow.$mark.height()){
    							val = yellowVal+0.01;
    							newHeight = 149-(yellowVal/100*149)-3;
    						}
    						if(val>100){
    						  val = 100;
    						}
    						
    						self.$input.val(val);
    						self.$mark.height(newHeight);
    					}
    					function clearMove(event){
      						self.flag = false;
      						clearTimeout(this.interval);
      						$("body").unbind("mousemove",mouseMove).unbind("mouseup",clearMove);
      						self.$btn.unbind("mousemove",mouseMove).unbind("mouseup",clearMove);
      						self.$mark.unbind("mousemove",mouseMove).unbind("mouseup",clearMove);
      						if(event){
      						  example.blurInput(event);
      						}
    					}
    					
    				}
			}

				
   			var example = {
    			   all:function(color){
    			     return  '<div class="cue-data-note cue-data-note-'+color+'">';
    			   }
    			   ,ico:function(){
    			     return '<span class="cue-data-note-ico"></span>'; 
  			     }
    			   ,input:function(val){
    			     return '<input type="text" value="'+val+'" style="height:15px;"/>';
    			   }
    			   ,text:function(val){
    			     return '<span>'+val+'</span>'; 
    			   }
    			   ,span:function(val){
    			     return '<span class="cue-data-now" style="cursor:pointer;">'+val+'</span>';
    			   }
    			   ,unit:function(val){
    			     return ' <span class="cue-data-units">'+val+'</span>';
    			   }
    			   ,checkInput:function(event){
    				   
    			      if(event.keyCode==13){
		                  example.blurInput(event);
		              }else{
	                    var self = event.data.self;
	                    var val = self.$input.val();
	                    var isPercent = event.data.isPercent;
	                    if(val==""){
	                    	return false;
	                    }
	                    
	                    if(isNaN(val)){
	                       self.$input.val("");
	                       return false;
	                    }else{
	                    	if(isPercent){
	                    		if(parseInt(val)>100 || parseInt(val)<0){
	                    			self.$input.val(val.substring(0,val.length-1));
	                    			return false;
	                    		}
								var t  = (val+'').split('.');
								if(t[1]&&t[1].length>2){
									self.$input.val(val.substring(0,val.length-1));
								toast.addMessage("保留两位小数");
								Sliber.error = true;
									return false;
								}
	                    	}
	                    } 
                    return true;   
                }
    			   }
    			   ,blurInput:function(event){
    			     
    			     var self = event.data.self;
    			     var ismove = event.data.ismove;
    			     var isPercent = event.data.isPercent;
    			     var val = self.$input.val();
    			     
    			     var otherVal = "";
    			      if(val==""){
    			    	  toast.addMessage("阈值不允许为空。");
     			         Sliber.error = true;
     			         return;
	                   }
    			     var t  = (val+'').split('.');
    			     var thisval = parseFloat(val);
					if(t[1]&&t[1].length>2){
						toast.addMessage("保留两位小数。");
						Sliber.error = true;
        			    return;
					}
    			     if(self==red){
        			       otherVal = parseFloat(yellow.$input.val());
        			       if(otherVal >= thisval){
        			         toast.addMessage("不符合逻辑。");
        			         Sliber.error = true;
        			         return;
        			       }else{
                       Sliber.error = false;
                     }
    			     }else if(self==yellow){
      			       otherVal = parseFloat(red.$input.val());
	                   if(otherVal <= thisval){
	                     toast.addMessage("黄色阈值不符合逻辑。");
	                     Sliber.error = true;
	                     return;
	                   }else{
	                     Sliber.error = false;
	                   }    			       
    			     }else{    			       
    			       Sliber.error = false;
    			     }
    			     self.$input.val(thisval);
    			     self.$input.hide()[0].blur();
		               self.$span.text(thisval).show();
		               if(!ismove && isPercent){
		                  self.$mark.css("height",parseInt(101-thisval)+"%");
		               }
    			   }
    			   ,spanclick:function(event){
    			     var self = event.data.self;
               self.$input.val(self.$span.text()).show();
               self.$input[0].focus();
               self.$span.hide();    			     
    			   }
    			}
			     var $sliber = null;      
           return {
               show:function(yVal,rVal,unit){
                      this.error = false;
			   		          var tempR = rVal/100*150;
                       var tempY = (yVal)/100*150;
                       var redH = (100-rVal)/100*150;
					             var yellowH = tempR-tempY;
                       var greenH = tempY;
                       var rTop = 145-tempR;
                       var yTop = 145-tempY;
                       this.destory();
                       $sliber = $('<div class="cue"></div>');
                       var $ruler = $('<div class="ruler"></div>');
                       green.createExam();
                       yellow.createExam(101-yVal,yVal,unit,yTop);
                       red.createExam(101-rVal,rVal,unit,rTop);
                       var $content = $('<div class="cue-content"></div>');
					   var units=$('<div class="cue-data-note cue-data-note-units">单位：'+unit+'</div>');
                       $content.append(red.$mark).append(yellow.$mark).append(green.$mark).append(units)
					   .append(red.$all).append(yellow.$all).append(green.$all);
                       if(unit==="%"){
                       		$sliber.append($ruler);
                       }
                       
                       $sliber.append($content);
                      if(unit!=="%") $ruler.hide();
               },
               getValue:function(){
                 return {red:red.$input.val(),yellow:yellow.$input.val()};
               },
               
               destory:function(){
                 if($sliber){
                   $sliber.find("*").unbind();
                   $sliber.html("");
                   $sliber[0].parentNode.removeChild($sliber[0]);
                   $sliber = null;
                 }
               },
               getJQueryObj:function(unit){
			   var div = $('<div></div>');
			   if(unit==='%'){
					div.append('<span style="text-align:center;"><span class="ico ico-note-blue"></span>请拖拽箭头或点击文本设置阈值</span>');
               }else{
					div.append('<span style="text-align:center;"><span class="ico ico-note-blue"></span>请点击文本设置阈值</span>');
			   }
			   return div.append($sliber);
               }
           }; 
			}();
			
			var SliberPanel = {
					  create:function(red,yellow,unit,callback,x,y){
						 var self = this;
		  			     if(this.isHave){
		  			       return;
		  			     }
					       Sliber.show(yellow,red,unit);
		             function bodyClick(event){
		                 if(Sliber.error===true){
		                   return;
		                 }
		                 	 var pos = panel.getPosition();
		                 	 var x = pos.left+panel.getWidth();
		                 	 var y  = pos.top+panel.getHeight();
		                 	 //alert("pageX="+event.pageX+" pageY="+event.pageY+"  x="+x+"  y="+y+"  left="+pos.left+"  top="+pos.top );
		                 	 if(event.pageX>=pos.left && event.pageX<=x && event.pageY >=pos.top && event.pageY <=y){
		                 	 	return;
		                 	 }
		                   var value = Sliber.getValue();
		                   callback(value);
		                   Sliber.destory();
		                   $("body").unbind("click",bodyClick);                    
		                   
		                   panel.close();
		                   self.isHave = false;
		               //  event.stopPropagation();
		              }			    
		              
		                panel = new winPanel({
		                            html:Sliber.getJQueryObj(unit),
		                            width:300,
		                            isDrag:false,
		                            x:x,
		                            y:y
		                  },{
		                    winpanel_DomStruFn:"blackLayer_winpanel_DomStruFn"
		                  });   		
		                this.isHave = true;
		                setTimeout(function(){
		                	$("body").bind("click",bodyClick);
		                	
		                },1000);
					  }
				}