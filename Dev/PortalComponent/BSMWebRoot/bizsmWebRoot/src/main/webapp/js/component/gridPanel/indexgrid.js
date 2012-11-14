Array.prototype.removeByIndex = function(i){
    if (i < this.length || i >= 0) {
        var ret = this.slice(0, i).concat(this.slice(i + 1));
        this.length = 0;
        this.push.apply(this, ret);
    }
}

/**
 * 定义组件DOM结构
 * $gridpanel      表格最外层DIV
 * $gridhead       表格头Tr  $tr
 * heads           表头列集合{index:i,$head：thJQuery对象，#headtext:表头文字}
 * $gridbodycage   表体外层DIV,用于显示滚动条
 * $gridbody       表体tBody对象
 * rows            表格行集合[{value:value,cells:[{colId:列ID,rowIndex:行索引,index:列索引,$td:$td,html:$td.text()}]}]
 */
 
function index_gridpanel_DomStruFn(conf){
		  var self = this;
		  
		  self.$gridpanel = $("#"+conf.id);
		  var compdiv = self.$gridpanel.children(); 
		  self.$gridhead = $(compdiv[0]).find("tr");//表头最外层  TR
		  
		  /* 
		   * 初始化表头
		   * key:列ID,
		   * value:{colId:列ID,index：索引,$th:单元格jquery对象,$head:Div单元格内部对象，$headtext:单元格内部span对象包含显示的文本}
		   * */
		  self.heads = {};
		  
		  
		  //隐藏列
		  self.hiddenColumn = {};
		  //显示列的个数
		  self.cols = [];  
		  //存放空行
		  var ths = self.$gridhead.children("th");//表头列th
		  for(var i=0,len=ths.length; i<len; i++){
		      var $th = $(ths[i]);
		      var $head = $($th.children("div:first").children("div:first"));
		      var $headtext = $($head.children("span:first"));
		      var colId = $th.attr("colId");  //th上的colId属性。
		      colId = colId ? colId : i;
		      if($th.css("display")=="none"){  //如果是隐藏列,放入隐藏列集合中
		    	  self.hiddenColumn[colId]=true;
		      }else{ //放入显示的列集合中
		    	  self.cols.push(colId);
		      }
		      self.heads[colId] = {colId:colId,index:i,$th:$th,$head:$head,$headtext:$headtext};
		  }
		  
		  //表体外层DIV
		  self.$gridbodycage = $(compdiv[1]);
		  //初始化表体 
		  self.$gridbody = $(self.$gridbodycage.children("table").children("tbody"));
		  
		  
		  self.rowsable = parseInt(self.$gridbody.attr("rowsable"));
		  
		  //表体行集合{value：该行隐藏列值，cells，该行列对象}
		  self.rows = [];
		  self.trHeight=0;
		  
		  
		  
		  
		  
		  var trs = self.$gridbody.children("tr");
		  for(var i=0,len=trs.length; i<len; i++){
			    var cells = [];  //某行单元格集合
			    var $tr = $(trs[i]);
			    var tds = $tr.children("td");
			    
			    var value = {};
			    if(self.trHeight==0){
			    	self.trHeight = $tr.height();
			    } 
			    for(var j=0,jlen=tds.length; j<jlen; j++){
				      var $td = $(tds[j]);
				      var colId = $td.attr("colId");
				      var colValue = $td.attr("value");
				      if(self.hiddenColumn[colId]){  //如果是隐藏列，放入隐藏列值集合中
				    	  value[colId]= $.trim($td.text());
				      }else{
				    	  cells.push({colId:colId,rowIndex:i,index:j,$td:$td,html:$.trim($td.text()),value:colValue});
				      }
			    }
			    self.rows.push({index:i,value:value,cells:cells});
		  }
		  //总行数
		  self.lineCount = self.rows.length;
}






/**
 *定义组件DOM操作，初始化DOM样式
 * 初始化参数：
 * conf.columnWidth  
 * addAttr()    为DOM元素添加属性
 * columnWidth{index:width}
 */
function index_gridpanel_DomCtrlFn(conf){
      var self = this;
    
      var unit = conf.unit ? conf.unit : "px";
	  /*
	   * 组件方法
	   * **/
	  self.addHeads = function(conf){
		  var ths = null;
		  for(var i=0,len = conf.length;i<len ;i++){
			  var c = conf[i];
			  var $span = $('<span>'+c.text+'</span>');
			  var $th = $("<th></th>");
			  var $div =$('<div class="theadbar"></div>').append($('<div class="theadbar-name"></div>').append($span));
			  if(c.hidden==true){
				  $th.hide();
				  self.hiddenColumn[c.colId] = true;
			  }
			  c.colId = c.colId ? c.colId : i;
			  self.heads[c.colId] = {colId:c.colId,index:self.cols.length,$th:$th,$head:$div,$headtext:$span};
			  $th.append($div.append($span));   //单个新生成的列，没有加入DOM
			  self.cols.push(c.colId);
			  if(ths==null){  //如果是第一个
				  ths = $th;
			  }else{  //
				  ths.after($th);
			  }
		  }
		  self.$gridhead.append(ths);
	  };      
      
      
	  /*
	   * 添加行conf类型数组
	   * 
	   * */
	  self.addRows = function(conf,index){
		 var $tr = $('<tr></tr>');
		 var obj= self.addCells(conf,index,$tr);
		 self.rows.push({value:obj.value,cells:obj.cells});
		 return $tr;
	  };   
    
	  //添加空行
	  self.addNnllRows = function(linesCount,cellsCount){
		  for(var i=0;i<linesCount;i++){
			  var $li = $("<tr></tr>").height(self.trHeight);
			  for(var j=0;j<cellsCount;j++){
				  
				  $li.append("<td>&nbsp;</td>");
			  }
			  self.$gridbody.append($li);
		  }
	  };
	  
	  /*
	   * 添加单元格（列）
	   * conf:json对象集合对象，rowId行号，$row行对象，value隐藏列值
	   * return cells [{}]列集合
	   * **/
	  self.addCells = function(conf,rowId,$row){
		  var tds = null;
		  var cells = []; //单元格集合
		  var value = {};
		  var i=0;
		  for(var i=0,len = self.cols.length;i<len;i++){
			  var colId = self.cols[i];
			  var cellVal = conf[colId];  //新单元格值
			  var $span = $('<span>'+cellVal+'</span>');
			  var $td = $("<td></td>").append($span);
			  var tdObj = null;
			  
				  var obj = {colId:colId,rowIndex:rowId,index:i,$td:$td,html:cellVal};
				  cells.push(obj);
				  // self.rendTo(obj);//将该单元格渲染
			  $row.append($td);
		  }
		  
		  
		  
		  //循环显示列ID
		  for(var colId in self.hiddenColumn){
			  value[colId]= conf[colId];
		  }
		  
		  
		  return {cells:cells,value:value};
	  };
    
	    self.overLine = function(){
	    	self.$gridbody.children("tr").bind("mouseover",function(){
	    		$(this).addClass("blue");
	    	}).bind("mouseout",function(){
	    		$(this).removeClass("blue");
	    	});
	    };  
    
    
    /**
     * 设定表格宽度
     * width:num
     */
    self.setTableWidth = function(width){
    	self.$gridpanel.css("width",width+unit);
    };
    
    /**
     * 设定表格列宽度
     * width:num
     */
    self.setColumWidth = function(columnWidth){
        columnWidth = columnWidth ? columnWidth : conf.columnWidth;
        for(var key in columnWidth){
        	if(self.heads[key]){
        		self.heads[key].$th.css("width",columnWidth[key]+unit);
        	}
            for(var i=0,ilen = self.rows.length; i<ilen; i++){
            	var cells = self.rows[i].cells;
            	for(var j=0,jlen = cells.length; j<jlen; j++){
            		var cell = cells[j];
            		if(cell.index==key || cell.colId==key){
            			cell.$td.css("width",columnWidth[key]+unit);
            		}
            	}
            }     
        }
    };
    
    self.addScrollColumn = function(width){
    	var $scrollTh = $("<th></th>");
    	$scrollTh.css("width",width+"px");
    	self.scrollTh = $scrollTh;
    	self.$gridhead.append($scrollTh);
    };
    
    self.delScrollColumn = function(){
    	if(self.scrollTh){
    		self.$gridhead.remove(self.$gridhead);
    		self.$gridhead = null;
    	}
    };
    
    //斑马线
    self.banma = function(){
    	
    	self.$gridbody.children("tr:even").addClass("white");
    	self.$gridbody.children("tr:odd").addClass("gray"); 
    };
    
    //列控制显示隐藏showIds[]:需要显示列ID数组,hideIds：需要隐藏列ID数组
    self.colControl = function(showIds,hideIds){
    	if(hideIds){
    		for(var i=0,len=hideIds.length;i<len;i++){
    			self.$gridhead.children("th[colId='"+hideIds[i]+"']").hide();
    			self.$gridbody.children("td[colId='"+hideIds[i]+"']").hide();
    		}
    	}
    	if(showIds){
    		for(var i=0,len = showIds.length;i<len;i++){
    			self.$gridhead.children("th[colId='"+showIds[i]+"']").show();
    			self.$gridbody.children("td[colId='"+showIds[i]+"']").show();
    		}
    	}
    };
    
    self.setTableWidth(conf.width);
    self.setColumWidth();
    self.overLine();
}



/**
 * 组件功能定义
 * checkOverFlow()          判断组件是否需要显示滚动条，更改标题列位置
 * rend()                   单元格内部渲染
 * loadGridData()           加载表格数据
 */
function index_gridpanel_ComponetFn(conf){
  var self = this;
  //检测表格是否出现滚动条
  self.checkOverFlow = function(){
      var gbcage = self.$gridbodycage[0];//获得dom
      var clientHeight = parseInt(gbcage.clientHeight);
      var scrollHeight = parseInt(gbcage.scrollHeight);    
      if(clientHeight < scrollHeight){  //容器高度小于实际高度
              var offsetWidth  = parseInt(gbcage.offsetWidth); 
              var borderLeftWidth  = parseInt(gbcage.style.borderLeftWidth); 
              var borderRightWidth  = parseInt(gbcage.style.borderRightWidth); 
              var clientWidth  = parseInt(gbcage.clientWidth);
              offsetWidth = isNaN(offsetWidth) ? 0 :offsetWidth;
              borderLeftWidth = isNaN(borderLeftWidth) ? 0 :borderLeftWidth;
              borderRightWidth = isNaN(borderRightWidth) ? 0 :borderRightWidth;
              clientWidth = isNaN(clientWidth) ? 0 :clientWidth;
              var scroll =  offsetWidth-borderLeftWidth-borderRightWidth-clientWidth;
              self.addScrollColumn(scroll);
      }else{
              self.delScrollColumn();
      }
  };
  
  self.rendConf = {};//保存渲染函数
  /**
   * 单元格内部渲染
   * rendConf  {index:列索引或列ID，fn:渲染函数（$td）}
   */
  self.rend = function(rendConf,start){
	  if(rendConf && $.isArray(rendConf)){
		  for(var i=0,len=rendConf.length; i<len; i++){
			  var rc = rendConf[i];
			  self.rendConf[rc.index] = rc.fn;
		  }
	  }
	  var j = 0;
	  if(start){
		  j = start;
	  }
	  for(var jlen = self.rows.length; j<jlen; j++){//循环所有行
		  var row = self.rows[j];
		  var cells = row.cells;
		  for(var k=0,klen=cells.length; k<klen; k++){//循环列
			  var cell = cells[k];
			  var index = cell.index;
			  var colId = cell.colId;
			  //先按索引去渲染函数，如果没有按列ID索引
			  var fn = self.rendConf[index] ? self.rendConf[index] : self.rendConf[colId];
			  if(fn){
				  cell.value = self.rows[cell.rowIndex].value;
				  var $dom = fn(cell);
				  cell.$td.find("*").unbind().empty();
		          cell.$td.append($dom);				  
			  }
		  }
	  }
	  
	  
	  
  };
  
  self.rendTo = function(cell){
	  var fn = self.rendConf[cell.index] ? self.rendConf[cell.index] : self.rendConf[cell.colId];
	  if(fn){
		  var $dom = fn(cell);
		  cell.$td.find("*").unbind();
		  cell.$td.html("");
		  cell.$td.append($dom);
	  }else{
		  return false;
	  }
  };
  
  
  /**
   *根据行号获得某行 
   *rowIndex :num
   * */
  self.getRowByIndex = function(rowIndex){
	  return self.rows[rowIndex]; 
  };
  
  /**
   * 表格加载数据
   * [[{value:,text:}]]
   */
  self.loadGridData = function(data){
       var jsondata = (new Function("return " + data))();
       self.rows= [];
       var $row = null;
       self.$gridbody.find("*").unbind();
       self.$gridbody.empty();
       var trs = null;
      for(var i=0,len=jsondata.length;i<len;i++){
          var jd = jsondata[i];
          var $tr = self.addRows(jd,i);
          self.$gridbody.append($tr);
      }
      if(len<self.lineCount){
    	  self.addNnllRows(self.lineCount-len,self.cols.length);
      }
      self.setColumWidth();
      self.checkOverFlow();
      self.rend();
      self.banma();
      self.overLine();
  };
  
  self.addGridDate= function(data){
	  var rowcount = self.rows.length;
	  for(var i=0,len=data.length;i<len;i++){
		  var jd = data[i];
		  
		  if(self.rowsable<rowcount){
			 
			  self.refreshRow(self.rowsable,jd);
		  }else{
			  var $tr = self.addRows(jd,i);
			  self.$gridbody.append($tr);
		  }
		  self.rowsable+=1;
      }	  
	  self.setColumWidth();
	  self.checkOverFlow();
	  self.rend(null,rowcount);
	  self.banma();
	  self.overLine();	  
  };
  
  self.refreshRow = function(rowIndex,obj){
	  for(var colId in obj){
		  self.refreshCell(rowIndex,colId,obj[colId]);
	  }
  }
  
  self.delRow = function(rowIndexs){
	  var trs = [];
	  for(var i=0;i<rowIndexs.length;i++){
		  var rowIndex = rowIndexs[i];
		  trs.push(self.$gridbody.children("tr:eq("+rowIndex+")"));
		  self.rows[rowIndex] = null;
		  self.rows.removeByIndex(rowIndex);
	  }
	  for(var j=0;j<trs.length;j++){
		  trs[j].remove();
	  }
	  $tr = null;
  }
  
  self.refreshCell = function(rowIndex,colId,text){
	  var row = self.rows[rowIndex];
	  if(row){
//		  {colId:colId,rowIndex:i,index:j,$td:$td,html:$td.text(),value:colValue}
		  var cells = row.cells;
		  for(var i=0,len = cells.length;i<len;i++){
			  var cell = cells[i];
			  if(cell.colId == colId){
				  cell.$td.html(text);
				  cell.html = text;
				  self.rendTo(cell);
			  }
		  }
	  }
  };
  
  self.checkOverFlow();
}

/*
 * 排序插件
 * conf{sortColumns:[{index:列索引或列ID,sortord:string排序类别,defSorttype:bool默认排序列方式}]排序列集合,sortLisntenr:fn排序回调函数}
 */
function SortPluginIndex(conf){
  var self = this;
  var scs =  conf.sortColumns;
  var $sorts = {};
  self.currentSort = null;  //当前排序的按钮
  
  for(var i=0;i<conf.sortColumns.length;i++){
    var sc = scs[i];
    var headObj = self.heads[sc.index];
    var $upa = $('<a  href="javascript:void(0)" style="display:none" title="升序" class="theadbar-ico theadbar-ico-up"></a>')
        .attr("colId",headObj.colId).attr("sorttype","up").bind("click",bindSortEvent);
    var $downa = $('<a  href="javascript:void(0)" style="display:none" title="降序" class="theadbar-ico theadbar-ico-down"></a>')
        .attr("colId",headObj.colId).attr("sorttype","down").bind("click",bindSortEvent);
    
    if(sc.defSorttype==="up"){
      self.currentSort=$upa;
      $upa.css("display","block");
    }else if(sc.defSorttype==="down"){
      self.currentSort=$downa;
      $downa.css("display","block");
    }    
    
    headObj.$head.append($upa).append($downa).parent().bind({"mouseover":bindMouseOver,"mouseout":bindMouseOut});
  }
  
  
  
  
  //绑定排序事件
  function bindSortEvent(){
    var $a =$(this);
    self.currentSort.css("display","none");
    self.currentSort=$a;
    self.currentSort.css("display","block");
    conf.sortLisntenr({colId:$a.attr("colId"),sorttype:$a.attr("sorttype")});
  }
  
  //绑定表头列鼠标悬浮显示排序按钮
  function bindMouseOver(){
    $(this).css("cursor","pointer").find("a").css("display","block");
  }
  function bindMouseOut(){
    var sortAs = $(this).find("a");
    for(var i=0;i<sortAs.length;i++){
      var $sortA = $(sortAs[i]);
      if(self.currentSort[0]!=$sortA[0]){
        $sortA.css("display","none");
      }
    }
  }
}


function TitleContextMenu(conf){
	var self = this;
	function contextMenu(event){
		var head = event.data.head;
		conf.contextMenu(head);
	}
	if(conf.contextMenu){
		for(var colId in self.heads){
			var head = self.heads[colId];
			head.$th.bind("click",{head:head},contextMenu);
		}
	}
}

CFNC.registDomStruFn("index_gridpanel_DomStruFn",index_gridpanel_DomStruFn);
CFNC.registDomCtrlFn("index_gridpanel_DomCtrlFn",index_gridpanel_DomCtrlFn);
CFNC.registComponetFn("index_gridpanel_ComponetFn",index_gridpanel_ComponetFn);