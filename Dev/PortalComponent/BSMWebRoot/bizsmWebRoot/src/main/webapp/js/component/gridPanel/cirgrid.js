/**
 * 圆角Grid
 * *定义组件DOM结构
 * $gridpanel      表格最外层DIV
 * $gridhead       表格头Tr
 * heads           表头列集合{index:i,$head：thJQuery对象，#headtext:表头文字}
 * $gridbodycage   表体外层DIV,用于显示滚动条
 * $gridbody       表体tBody对象
 * rows            表格行集合[[{index:列索引,$td:$td,value:单元格的只,html:单元格显示的文字或HTML}]]
 * 
 * addHead()       添加表头列
 * */

function circular_gridpanel_DomStruFn(conf){
	var temp = this;
	temp.$gridpanel= $("#"+conf.id);
	temp.$gridhead = $(temp.$gridpanel.children("div:eq(0)").children("div:eq(0)").children("div:eq(0)").children("table").children("thead").children("tr:first"));//表头最外层
	  //初始化表头
	  temp.heads = [];//{}
	  var ths = temp.$gridhead.children("th");//表头列s
	  for(var i=0;i<ths.length;i++){
	      var $th = $(ths[i]);
	      var $head = $($th.children("div:first").children("div:first"));
	      var $headtext = $($head.children("span:first"));
	      temp.heads.push({index:i,$th:$th,$head:$head,$headtext:$headtext});
	  }
	//表体外层DIV
	temp.$gridbodycage = $(temp.$gridpanel.children("div:eq(1)"));
	  //初始化表体 
	  temp.$gridbody = $(temp.$gridbodycage.children("table").children("tbody"));
	  //表体行
	  temp.rows = [];
	  var trs = temp.$gridbody.children("tr");
	  for(var i=0;i<trs.length;i++){
	    var row = [];
	    var tds = $(trs[i]).children("td");
	    for(var j=0;j<tds.length;j++){
	      var $td = $(tds[j]);
	      row.push({index:j,$td:$td,value:$td.attr("value"),html:$td.text()});
	    }
	    temp.rows.push(row);
	  }
	  
	  
	  
	  /**
	   * 添加表头列
	   */
	  temp.addHead = function(conf){
	    var $th = $('<th></th>');
	    var $div = $("<div></div>");
	    if(conf.text){
	      var $text = $("<span></span>")
	    }
	    $th.append($div);
	    temp.addAttr($th,conf.attrs);
	    temp.heads.push({$thead:$th});
	    temp.$gridhead.append($th);    
	  };
	  //删除表头列
	  temp.delHead = function(index,len){
	    alert(index+"   len="+len)
	    var $delcols = temp.heads.splice(index,len);
	    alert($delcols.length);
	    for(var i=0;i<$delcols.length;i++){
	        var $dc = $delcols[i];
	        $dc.$thead.unbind();
	        $dc.$thead.find("*").unbind();
	        temp.$gridhead[0].removeChild($dc.$thead[0]); 
	    }
	  };
	  /**
	   * 添加单元格
	   */
	  temp.addCell = function(index,tdconf){
	    var $td =  $('<td><span>'+tdconf.text+'</span></td>');
	    temp.setWidth($td,conf.columnWidth[index]);
	  };
	  
	  /**
	   * 添加行
	   */
	  temp.addRow = function(tdConf){
	     var $tr = $('<tr></tr>');
	     var row = [];
	     for(var j=0; j < tdConf.length;j++){
	         var td = tdConf[j];             
	         var $td =  $('<td><span>'+td.text+'</span></td>');
	         temp.setWidth($td,conf.columnWidth[j]);
	         $tr.append($td);
	         row.push({index:j,$td:$td,value:td.value,html:td.text});
	     }
	     temp.rows.push(row);
	     return $tr;    
	  }
}

CFNC.registDomStruFn("circular_gridpanel_DomStruFn",circular_gridpanel_DomStruFn);
