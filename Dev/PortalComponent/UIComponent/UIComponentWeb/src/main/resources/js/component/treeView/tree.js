/*
 * conf{currentColor:当前选中的颜色，color:节点文本颜色}
 */
function Tree(conf){
	function Node(){
		this.$li =null;
		this.childs = [];
	}
	
	Node.prototype={
		/*
		 * 获得节点文本JQ对象
		 */
		_get$Text:function(){
			var $text = this.$li.children("span[type='text']");
			return $text;
		},
		/*
		 * 获得节点图标Jquery对象
		 */
		_get$Ico:function(){
			var $ico = this.$li.children("span[type='ico']");
			return $ico;
		},
		_get$Tool:function(){
			var $ico = this.$li.children("span[type='tool']");
			return $ico;
		},
		/*
		 * 获得节点折叠按钮JQ对象
		 */		
		_get$Btn:function(){
			var $btn = this.$li.children("div:first");
			return $btn;			
		},
		/*
		 * 获得节点子节点集合JQ对象
		 */		
		_get$Childs:function(){
			var $ul = this.$li.children("ul:last-child");
			return $ul;
		},
		_get$lastChild:function(){
			var $li = this.$li.children("ul:last-child li:last");
			return $li;
		},
		/*
		 * 获得复选框文本对象 
		 */
		_get$Checkbox:function(){
			var $checkbox = this.$li.children("input[type='checkbox']");
			return $checkbox;
		},
		/*
		 * 获得复选框文本对象 
		 */		
		_get$Radiobox:function(){
			var $radio = this.$li.children("input[type='checkbox']");
			return $radio;
		},
		isLast:function(){
			return this.$li[0].className.indexOf("last")!=-1;
		},
		/*
		 * 塞入树节点$li 
		 */
		setNode:function($li){ 
			this.$li = $li;
		 	return this;
		},
		/*
		 * 当前节点是展开状态还是折叠状态
		 */
		state:function(){   
			return this.$li.hasClass("collapsable");
		},
		/*
		 * 该节点是否是叶子节点
		 */
		isLeaf:function(){
			return this._get$Childs()[0]==null;
		},
		/*
		 * 该节点是否显示
		 */
		isNodeDisplay:function(){
			return this.$li.css("display")!="none";
		},
		/*
		 * 该节点是否展开
		 */
		isExpend:function(){
			return this.$li[0].className.indexOf("collapsable")!=-1;
		},
		/*
		 * 隐藏该节点
		 */
		setNodeDispNone:function(){
			this.$li.hide();
			return this;
		},
		/*
		 * 显示该节点
		 */		
		setNodeDisp:function(){
			this.$li.show();
			return this;
		},
		/*
		 * 设置节点文本
		 */
		setText:function(text){
			var $text = this._get$Text();
			$text.html(text);
			return this;
		},
		/*
		 * 获得节点文本
		 */		
		getText:function(){
			var $text = this._get$Text();
			return $text.html();
		},
		/*
		 * 获得节点ID
		 */				
		getId:function(){
			return this.$li.attr("nodeid");
		},
		/*
		 * 设置文本节点样式
		 */				
		setTextStyle:function(styleName,styleVal){
			var $text = this._get$Text();
			$text.css(styleName,styleVal);
			return this;
		},
		/*
		 * 设置节点为当前选中的节点
		 */			
		setCurrentNode:function(){
			if(tree.currentNode){//如果有当前节点
				tempNode.setNode(tree.currentNode).clearCurrentNode();
			}
			var color = conf.currentColor ? conf.currentColor : "#0b4f7a";
			this.setTextStyle("fontWeight", "bolder").setTextStyle("color", color);
			this._get$Text().attr("isCurrent","true");
			tree.currentNode = this.$li;
			return this;
		},
		/*
		 * 清楚该节点为当前选中节点
		 */					
		clearCurrentNode:function(){
			var color = conf.color ? conf.color:"#000";
			this.setTextStyle("fontWeight", "normal").setTextStyle("color", color);
			this._get$Text().removeAttr("isCurrent");
			currentNode = null;
			return this;	
		},
		/*
		 * 判断该节点是否为当前节点
		 */				
		isCurrentNode:function(){
			return this._get$Text().attr("isCurrent")==="true";
		},
	 	/*
	 	 * @listeners折叠按钮操作事件
	 	 * collapseBefore，expendBefore折叠前发生，方法返回false不发生折叠
	 	 * collapseAfter，expendAfter折叠后发生
	 	 */
		fold:function(){
			if(this.state()){//true展开状态，可以折叠
				this.collapse();
			}else{
				this.expend();
			}
			return this;
		},
		/*
		 * 展开节点 expendBefore  expend
		 */
		expend:function(async){
			if(this.state()) return;//如果已经是展开状态，返回，不执行
			if(listeners.expendBefore){//如果展开前有事件，执行返回false，直接返回，不执行展开操作
				var flag = listeners.expendBefore(this);
				if(flag===false) return this; 
			}
			var $child = this._get$Childs();//获得他的子对象集合UL层
			if(!$child[0]){  //如果没有子节点集合，则取节点
				if(url){
					this.asynNode(true);
				}
			}else{
				$child.show();
			}
			
			
			var $btn = this._get$Btn();
			this.$li.removeClass("expandable").addClass("collapsable");
			$btn.removeClass("expandable-hitarea").addClass("collapsable-hitarea");
			if(this.$li.hasClass("lastExpandable")){
				this.$li.removeClass("lastExpandable").addClass("lastCollapsable");
				$btn.removeClass("lastExpandable-hitarea").addClass("lastCollapsable-hitarea");
			}						
			
			if(listeners.expend){//如果展开后有事件
				listeners.expend(this);
			}			
			
			return this;			
		},
		/*
		 * 折叠节点  collapseBefore collapse
		*/
		collapse:function(){
			if(!this.state()) return;//如果已经是折叠状态，返回，不执行
			if(listeners.collapseBefore){//如果展开前有事件，执行返回false，直接返回，不执行展开操作
				var flag = listeners.collapseBefore(this);
				if(flag===false) return this; 
			}			
			
			var $btn = this._get$Btn();
			var $child = this._get$Childs();//获得他的子对象集合UL层
			
			this.$li.removeClass("collapsable").addClass("expandable");
			$btn.removeClass("collapsable-hitarea").addClass("expandable-hitarea");
			if(this.$li.hasClass("lastCollapsable")){
				this.$li.removeClass("lastCollapsable").addClass("lastExpandable");
				$btn.removeClass("lastCollapsable-hitarea").addClass("lastExpandable-hitarea");
			}
			$child.css("display","none");
			if(listeners.collapse){//如果折叠后有事件
				listeners.collapse(this);
			}			
			
			return this;			
		},
		/*
		 * 获得改节点 
		 */
		getPathId:function(){
			var path = [];
			function roundParent(node){
				if(node){
					var id = node.getId();
					if(id && id!="root"){
						path.push(id);
						roundParent(node.parent());
					}
				}
			};
			path.push(this.getId());
			roundParent(this.parent());
			return path.reverse();
		},
		/*
		 * 节点点击事件
		 * @listeners 
		 * clickBefore   nodeClick
		 */
		click:function(){
			if(listeners.clickBefore){
				var flag = listeners.clickBefore(this);
				if(flag === false) return this;
			}
			listeners.nodeClick(this);
			this.setCurrentNode();
		},
		/*
		 * 设置图标
		 * */
		setIco:function(ico){
			var $ico = this._get$Ico();
			$ico.removeClass().addClass(ico);
		},
		getCheckedNode :function(){
			
		},
		/*
		 * 获得所有带复选框的节点 isLeaf:是否是叶子节点
		 * */
		getCheckboxNodes:function(isLeaf){
			var checkboxeds = this._get$Childs().find("input[type='checkbox']");
			//var checkboxeds = checkboxs.filter(":checked");
			var checkedNode = [];
			var node = null;
			for(var i = 0,len = checkboxeds.length; i<len; i++){
				var $checkbox = $(checkboxeds[i]);
				node = new Node();
				if(isLeaf){
					var $ul = $checkbox.siblings("ul");
					if($ul.length==0){
						node.setNode($checkbox.parent());
						checkedNode.push(node);
					}
				}else{
					node.setNode($checkbox.parent());
					checkedNode.push(node);
				}
			}
			return checkedNode;
		},		
		/*
		 * isLeaf 是否只获取选中的叶子节点
		 * */
		getCheckedNodes:function(isLeaf){
			var checkboxs = this._get$Childs().find("input[type='checkbox']");
			var checkboxeds = checkboxs.filter(":checked");
			var checkedNode = [];
			var node = null;
			for(var i = 0,len = checkboxeds.length; i<len; i++){
				var $checkbox = $(checkboxeds[i]);
				node = new Node();
				if(isLeaf){
					var $ul = $checkbox.siblings("ul");
					if($ul.length==0){
						node.setNode($checkbox.parent());
						checkedNode.push(node);
					}
				}else{
					node.setNode($checkbox.parent());
					checkedNode.push(node);
				}
			}
			return checkedNode;
		},		
		
		
		setChecked : function(){
			var $checkbox = this._get$Checkbox();
			if($checkbox[0]){
				$checkbox.attr("checked","true");
				this.checkboxClick();
			}
		},
		clearChecked : function(){
			var $checkbox = this._get$Checkbox();
			if($checkbox[0]){
				$checkbox.removeAttr("checked");
				this.checkboxClick();
			}			
		},
		checkslibnext : function(){
			
		},
		/*
		 * 获得该节点是否被选中 
		 */
		isChecked : function(){
			var $checkbox = this._get$Checkbox();
			return $checkbox[0].checked;
		},
		/*
		 * 复选框点击事件
		 * @checkboxClick 
		 * */
		checkboxClick : function(){
			this._roundDownChecked();
			this._roundUpChecked();
		},
		_roundUpChecked : function(){   //向上检查
			function roundchecked($li){
				//console.info("up");
				var checkbox = $li.children("input[type='checkbox']")[0];
				if(!checkbox) return;
				var checked = checkbox.checked;
				var slibingLis = $li.siblings("li");
				var slibingCheckbox = slibingLis.children("input[type='checkbox']");
				var checkeds = slibingCheckbox.filter(":checked");
				var $parentli = $li.parent().parent();
				var parentCheck = $parentli.children("input[type='checkbox']");
				if(checkeds.length==0 && !checked){
					parentCheck.removeAttr("checked");
				}else if(slibingCheckbox.length===checkeds.length && checked){
					parentCheck.attr("checked","true").css("filter","");
				}else{
					parentCheck.attr("checked","true").css("filter","gray");
				}
				roundchecked($parentli);
			}
			roundchecked(this.$li);
		},
		_roundDownChecked : function(){//向下检查
			
			function roundchecked($li){
			//	console.info("down");
				var checkbox = $li.children("input[type='checkbox']")[0];
				if(!checkbox) return;
				var checked = checkbox.checked;
				var checkboxs = $li.find("input[type='checkbox']");
				if(checked){
					checkboxs.attr("checked","true");
				}else{
					checkboxs.removeAttr("checked");
				}
			}
			roundchecked(this.$li);
		},
		/*
		 * 添加子节点集合 
		 */
		addChilds:function(childsHtml){
			var id = this.getId();
			this.$li.append(childsHtml);
			setTimeout(function(){
				tree.bindFoldBtn("#"+conf.id+" li[nodeid='"+id+"'] ul");
			},10);
			setTimeout(function(){
				tree.bindNodeClick("#"+conf.id+" li[nodeid='"+id+"'] ul", listeners);
			},50);
			setTimeout(function(){
				tree.bindCheckbox("#"+conf.id+" li[nodeid='"+id+"'] ul", listeners);
			},100);
			setTimeout(function(){
				tree.bindToolclick("#"+conf.id+" li[nodeid='"+id+"'] ul", listeners);
			},500);
		},
		bindEvent:function(node){
			setTimeout(function(){
				tree.bindFoldBtn(node._get$Btn());
			},10);
			setTimeout(function(){
				tree.bindNodeClick(node._get$Text(), listeners);
			},50);
			setTimeout(function(){
				tree.bindCheckbox(node._get$Checkbox(), listeners);
				tree.bindCheckbox(node._get$Radiobox(), listeners);
			},100);
			setTimeout(function(){
				tree.bindToolclick(node._get$Tool(), listeners);
			},500);			
		},
		/**
		 * js方式添加节点
		 */
		appendChild:function(nodeConf){
			var $ul = null;
			nodeConf.isLast = true;//新添加的这个默认是最后一个节点
			var thisIsLeaf = this.isLeaf();//新添加节点的父节点是一个叶子节点
			var $btn = this._get$Btn();//获得当前节点的折叠按钮
			
			var lastChildNode = this.getLastChild();
			if(lastChildNode){ //调整最后一个
				lastChildNode.setNotLast(lastChildNode.isLeaf());
			}
			
			if(thisIsLeaf){ 
				if($btn[0]){
					this.setNotLeaf(this.isLast()); //将折叠按钮设置
					tree.bindFoldBtn($btn);
				}
				$ul = $("<ul></ul>");
				this.$li.append($ul);
			}
			if($btn[0]){ //用于判断现有树是否支持折叠按钮
				nodeConf.isBtn=true;
			}
			
			$ul = this._get$Childs();
			var nodeStr = TreePlugins.createNode(nodeConf);
			$ul.append(nodeStr);
			var newnode  = tree.getNodeById(nodeConf.nodeId);
			this.bindEvent(newnode);
			return newnode;
		},
		delNode:function(){
			this.$li.find("*").unbind();
			
			
			var curLast = this.isLast();
			var prevnode = this.getPrevNode();
			var nextnode = this.getNextNode();
			if(curLast && prevnode){
				prevnode.setLast(prevnode.isLeaf(),prevnode.isExpend());
			}
			if(!prevnode && !nextnode){
				this.parent().setLeaf(this.parent().isLast());
			}
			
			
			var div = document.createElement("div");
			div.appendChild(this.$li[0]);
			div.innerHTML="";
			div=null;
			
			
			
		},
		/**
		 * 设置节点不是叶子
		 */
		setNotLeaf:function(isLast){
			if(isLast){
				this.$li.removeClass().addClass("collapsable lastCollapsable");
				this._get$Btn().removeClass().addClass("hitarea collapsable-hitarea lastCollapsable-hitarea");
			}else{
				this.$li.removeClass().addClass("collapsable");
				this._get$Btn().removeClass().addClass("hitarea collapsable-hitarea");				
			}
		},
		setLeaf:function(isLast){
			if(isLast){
				this.$li.removeClass().addClass("last");
				this._get$Btn().removeClass().addClass("last");
			}else{
				this.$li.removeClass();
				this._get$Btn().removeClass();				
			}			
			var div = document.createElement("div");
			div.appendChild(this.$li.children("ul")[0]);
			div.innerHTML="";
			div = null;
		},
		setNotLast:function(isLeaf){
			if(isLeaf){
				this.$li.removeClass();
				this._get$Btn().removeClass()
			}else{
				this.$li.removeClass().addClass("collapsable");
				this._get$Btn().removeClass().addClass("hitarea collapsable-hitarea");				
			}			
		},
		setLast:function(isLeaf,isExpend){
			if(isLeaf){
				this.$li.removeClass().addClass("last");
				this._get$Btn().removeClass().addClass("last");
			}else{
				var liCls = "collapsable lastCollapsable";
				var btnCls = "hitarea collapsable-hitarea lastCollapsable-hitarea";
				if(!isExpend){
					liCls = "expandable lastExpandable";
					btnCls = "hitarea expandable-hitarea lastExpandable-hitarea";
				}
				this.$li.removeClass().addClass(liCls);
				this._get$Btn().removeClass().addClass(btnCls);				
			}						
		},
		/*
		 * 动态获取树节点
		 * @async 是否异步,默认true, false不是异步
		 */
		asynNode:function(async){
			var id = this.getId();
			var self = this;
			$.ajax({
				type: "POST",
				url: url,
				dataType: "html",
				data: tree.param+id,
				async:async==null?true:false,
				success:function(msg){
					self.addChilds(msg);
				}
			});
		},
		/*
		 * 获得父节点 
		 */
		parent:function(){
			var $li = this.$li.parent().parent();
			if($li[0]){
				tempNode.setNode($li);
				return tempNode;
			}else{
				return null;
			}
		},
		children:function(){
			var lis = this._get$Childs().children("li");
			var nodes = [];
			var node = null;
			for(var i=0,len = lis.length;i<len;i++){
				node = new Node();
				node.setNode($(lis[i]));
				nodes.push(node);
			}
			return nodes;
		},
		/*
		 * 该节点子节点个数 
		 */
		childCount:function(){
			var lis = this._get$Childs().children("li");
			return lis.length;
		},
		/*
		 * 获得第一个子结点
		 */
		getFirstChild:function(){
			var $li = this._get$Childs().children("li:first-child");
			if($li[0]){
				var node = new Node();
				node.setNode($li);
				return node;
			}else{
				return null;
			}
		},
		getPrevNode:function(){
			var $li = this.$li.prev();
			if($li[0]){
				var node = new Node();
				node.setNode($li);
				return node;			
			}else{
				return null;
			}
				
		},
		getNextNode:function(){
			var $li = this.$li.next();
			if($li[0]){
				var node = new Node();
				node.setNode($li);
				return node;			
			}else{
				return null;
			}
		},
		/*
		 * 获得最后一个子结点
		 */
		getLastChild:function(){
			var $li = this._get$Childs().children("li:last-child");
			if($li[0]){
				var node = new Node();
				node.setNode($li);
				return node;
			}else{
				return null;
			}			
		},
		/*
		 * 获得子节点指定索引的
		 */		
		getIndexChild:function(index){
			var $li = this._get$Childs().children("li:eq("+index+")");
			if($li[0]){
				var node = new Node();
				node.setNode($li);
				return node;
			}else{
				return null;
			}						
		},
		getValue:function(key){
			return this.$li.attr(key);
		}
	};
	
	
	var $tree= this.$tree= $("#"+conf.id);//树最外层对象
	this.id = conf.id;
	this.root = $tree.children("li").children("ul");  //根节点
	var url = conf.url;  //异步请求节点的URL
	var param = this.param = conf.param; //异步请求的参数
	this.node = new Node();
	var tempNode =this.tempNode= new Node();
	this.currentNode = null;  //当前选中节点$li
	var lis = this.root.find("li");
	var tree = this;//tree对象的引用
	var listeners = conf.listeners == null? {}:conf.listeners; 
	
	if(conf.plugins){
		for(var i=0;i<conf.plugins.length;i++){
			var plugin = TreePlugins[conf.plugins[i]];
			if(plugin){
				plugin.call(this,conf);
			}
		}
	}
	
	var self = this;
	
	setTimeout(function(){
		self.bindFoldBtn("#"+conf.id);
	},10);
	setTimeout(function(){
		self.bindNodeClick("#"+conf.id, listeners);
	},50);
	setTimeout(function(){
		self.bindCheckbox("#"+conf.id, listeners);
	},100);
	setTimeout(function(){
		self.bindToolclick("#"+conf.id, listeners);
	},500);
};

Tree.prototype={
	/*
	 * 绑定折叠按钮事件
	 */		
	bindFoldBtn:function(path){
		var self = this;
		if($.isString(path)){
			var btns = $(path+" li div.hitarea");
		}else{
			var btns = path;
		}
		btns.bind("click",function(){
			var $btn = $(this);
			self.node.setNode($btn.parent());
			self.node.fold();
		});		
	},
	/*
	 * 绑定节点点击事件
	 */
	bindNodeClick:function(path,listeners){
		if(listeners.nodeClick){
			var self = this;
			if($.isString(path)){
				var texts = $(path+" span[type='text'][clickable='true']");
			}else{
				var texts = path;
			}
			
			texts.bind("click",function(){
				$text = $(this);
				self.clearCurrentNode();
				self.node.setNode($text.parent());
				self.node.click(listeners);
			});
		}
	},
	/*
	 * 绑定复选框事件
	 */
	bindCheckbox:function(path,listeners){  //checkboxClickBefore checkboxClick  checkboxClickAfter
		if($.isString(path)){
			var checkboxs = $(path+" input[type='checkbox']");
		}else{
			var checkboxs = path;
		}
	
		var self = this;
		var _setcheckboxbefor=true;
		if(listeners.checkboxClickBefore){
			checkboxs.bind("mousedown",function(){
				$checkbox = $(this);
				self.node.setNode($checkbox.parent());
				_setcheckboxbefor = listeners.checkboxClickBefore(self.node);
			});
		}
			
		checkboxs.bind("click",function(){
			if(_setcheckboxbefor){
				$checkbox = $(this);
				self.node.setNode($checkbox.parent());
				var flag = 	self.node.checkboxClick();
				if(flag===false) return flag;
				if(listeners.checkboxClick){
					flag = listeners.checkboxClick(self.node);
					if(flag===false) return flag;
				}
			}
		});
	},
	bindToolclick:function(path,listeners){
		if(listeners.toolClick){
			if($.isString(path)){
				var tools = $(path+" span[type='tool']");
			}else{
				var tools = path;
			}
			var self = this;
			tools.bind("click",function(event){
				var $tool = $(this);
				self.node.setNode($tool.parent());
				listeners.toolClick(self.node,event);
			});
		}
	},
	getCurrentNode:function(){
		if(!this.currentNode){
			var $text = this.root.find("span[type='text'][isCurrent='true']");
			if($text[0]){
				this.currentNode = $text.parent();
			}
		}
		if(this.currentNode!=null){
			
			this.node.setNode(this.currentNode);
			return this.node;
		}else{
			return null;
		}
	},
	setCurrentNode:function(nodeId){  //设置树当前选中节点
		this.clearCurrentNode();
		var node = this.getNodeById(nodeId);
		node.setCurrentNode();
		return this;
	},
	clearCurrentNode:function(){  //清除当前选定
		var currentnode = this.getCurrentNode();
		if(currentnode) currentnode.clearCurrentNode();
		return this;
	},
	getNodeById:function(nodeId){  //根据ID所有节点
		var $li = this.root.find("li[nodeid='"+nodeId+"']");
		this.node.setNode($li);
		return this.node;
	},
	updateNodeTextById:function(nodeId,text){
		var node = this.getNodeById(nodeId);
		return node.setText(text);
	},
	getRadioCheckedNode:function(){
		var $radio = this.root.find("input[type='radio']:checked");
		if($radio[0]){
			var $li = $radio.parent();
			this.node.setNode($li);
			return this.node;
		}else{
			return null;
		}
	},
	searchNode:function(nodeId){
		var node = this.getNodeById(nodeId);
		this.$tree.parent().scrollTop(0);
		this.$tree.parent().scrollTop(node.$li.position().top);
	},
	locationNode:function(nodepath){
		for(var i=0,len = nodepath.length-1;i<len;i++){
			var node = this.getNodeById(nodepath[i]);
			node.expend(false);
		}
		this.searchNode(nodepath[nodepath.length-1]);
	},
	getCheckedCount:function(){
		var checkboxs = $("#"+this.id+" input[type='checkbox']");
		var checkboxeds = checkboxs.filter(":checked");
		return checkboxeds.length;
	},
	/*
	 *指定id节点复选框取消
	 */
	clearCheckedByNodeid:function(nodeId){
		var node = this.getNodeById(nodeId);
		if(node){
			node.clearChecked();
		}
	},
	/*
	 * 指定id节点复选框取消
	 */	
	setCheckedByNodeid:function(nodeId){
		var node = this.getNodeById(nodeId);
		if(node){
			node.setChecked();
		}
	},
	setParam:function(param){
		this.param = param;
	},
	getRoot:function(){
		var $li = this.$tree.children("li");
		this.node.setNode($li);
		return this.node;
	}
	
	
	
};

var TreePlugins = {
	singleExpend:function(conf){
		var listeners = conf.listeners == null ? {} : conf.listeners;
		var self = this;
		var fn = listeners.expend;
		listeners.expend = function(node){
			if(fn)	fn(node);
			var silblinguls = node.$li.siblings("li").children("ul:visible");
			if(silblinguls[0]){
				self.node.setNode(silblinguls.parent());
				self.node.collapse();
			}
		};
	},
	/*
	 * 选中一定数量复选框后，将其他复选框disabled,如果低于则恢复
	 */
	disableCheckbox:function(conf){
		var selectcount = conf.selectcount;
		var listeners = conf.listeners == null ? {} : conf.listeners;
		var self = this;
		var fn = listeners.checkboxClick;
		listeners.checkboxClick = function(node){
			var checkbox = node.$li.children("input[type='checkbox']");
			if(checkbox.hasClass("disabled")){
				return false;
			}
			var checkboxs = $("#"+conf.id+" input[type='checkbox']");
			var checkboxeds = checkboxs.filter(":checked");
			
			var s = new Date();
			if(checkbox[0].checked){
				if(checkboxeds.length>=selectcount){
					checkboxs.not(":checked").addClass("disabled");
				}else{
				}
			}else{
				checkboxs.not(":checked").removeClass("disabled");
			}
			if(fn)	fn(node);
		};
	},
	/*
	 * 创建一个树节点
	 */
	createNode:function(conf){
		var isLast = conf.isLast,isLeaf = conf.isLeaf,isExpend = conf.isExpend;
		var cls = "";
		if(isLast && isExpend && !isLeaf){ 
			cls = "collapsable lastCollapsable";  
		}else if(isLast && !isExpend && !isLeaf){ 
			cls = "expandable lastExpandable";
		}else if(!isLast && !isExpend && !isLeaf){  //如果不是最后一个，并且是关闭的，不是叶子节点expandable
			cls = "expandable";
		}else if(!isLast && isExpend && !isLeaf){ //如果不是最后一个，并且是展开的，不是叶子节点collapsable
			cls = "collapsable";
		}else if(isLast && isLeaf){  //如果是最后一个，并且是叶子节点
			cls = "last";
		}
		var li = '<li class="'+cls+'" nodeid="'+conf.nodeId+'" ';
		if(conf.attrs){
			for(var attr in attrs){
				li += attr+""+attrs[attr]+" ";
			}
		}
		li+=">";
		if(conf.isBtn){
			li += this.createButton(isLast,isLeaf,isExpend);
		}
		if(conf.icoCls){
			li += this.createIco(conf.icoCls);
		}
		
		if(conf.isCheckBox === true){
			li += this.createInput("checkbox",conf.inputAttrs);
		}
		if(conf.isRadio === true){
			li += this.createInput("radio",conf.inputAttrs);
		}
		
		li += this.createText(conf.isClick,conf.text);

		if(conf.toolCls){
			li += this.createTool(conf.toolCls);
		}
		li+="</li>";
		return li;
	},
	createTool:function(toolCls){
		return '<span class="'+toolCls+'" type="tool"></span>';
	},
	createIco:function(icoCls){
		return '<span class="'+toolCls+'" type="ico"></span>';
	},
	createText:function(isClick,textVal){
		var pointer = isClick ? 'cursor: pointer;' :'';
		return '<span style="'+pointer+' font-weight: normal;" type="text" clickable="'+isClick+'">'+textVal+'</span>';
	},
	createButton:function(isLast,isLeaf,isExpend){
		var cls = "";
		if(isLast && isExpend && !isLeaf){
			cls = "hitarea collapsable-hitarea lastCollapsable-hitarea";
		}else if(isLast && !isExpend && !isLeaf){
			cls = "hitarea expandable-hitarea lastExpandable-hitarea";
		}else if(!isLast && !isExpend && !isLeaf){
			cls="hitarea expandable-hitarea";
		}else if(!isLast && isExpend && !isLeaf){
			cls="hitarea  collapsable-hitarea";
		}else{
			cls="last";
		}
		return '<div class="'+cls+'"></div>';
	},
	createInput:function(type,attrs){
		var input =  '<input type="'+type+'" ';
		if(attrs){
			for(var i=0;i<attrs.length;i++){
				input += attr+"="+attrs[attr]+" ";
			}
		}
		input += "/>";
		return input;
	}
};


