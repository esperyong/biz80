function Tree(conf){
	var $tree = $("#"+conf.id);
	var $li = $tree.children("li");
	this.nodes = {};
	this.currentNodeId = "";
	this.listeners = conf.listeners;
	this.root = new TreeNode({$li:$li,id:"root",listeners:conf.listeners},null,this);
};

Tree.prototype={
	setCurrent:function(id){//设置当前选中样式
		this.clearCurrent();
		this.nodes[id].setTextStyle("fontWeight","bolder");
		this.nodes[id].setTextStyle("color","#0b4f7a");
		this.currentNodeId = id;
	},
	clearCurrent:function(){//清除当前选中样式
		if(this.nodes[this.currentNodeId]){
			this.nodes[this.currentNodeId].setTextStyle("fontWeight","normal");
			this.nodes[this.currentNodeId].setTextStyle("color","#000");
		}
	},		
	filterByText:function(text){
		for(var key in this.nodes){
			var node = this.nodes[key];
			if(node.isLeaf()&&node.getText().indexOf(text)!=-1){
				node.setNodeDisp();
			}else if(node.isLeaf()){
				node.setNodeDispNone();
			}
		}
	},
	appendNode:function(nodes){
		this.root.appendNode(nodes,this.listeners);
		this.clearBtnCls();
	},
	delNodeById:function(nodeIds){
		var nodes = [];
		for(var i=0,len = nodeIds.length;i<len;i++){
			var nodeid = nodeIds[i];
			nodes.push(this.getNodeById(nodeid));
		}
		this.delNode(nodes);
	},
	getNodeById:function(nodeid){
		var searchNode = null;
		function round(nodes){
			if(!nodes) return
			var len = nodes.length;
			if(len>0){
				for(var i=0;i<len;i++){
					var node = nodes[i];
					if(node.getId()==nodeid){
						searchNode = node;
						return true;
					}
					round(node.childs);
				}
			}
		}
		round(this.root.childs);
		return searchNode;
	},
	delNode:function(nodes){
		var self = this;
		function parentDeleteChild(node){			
			if(node.getId()=="root") return;
			var parentNode =  node.parentNode;			
			node.$li.remove();
			node.$li = null;
			self.nodes[node.getId()]=undefined;
			var newchilds = [];
			if(!parentNode) return;
			var len = parentNode.childs.length
			for(var j=0;j<len;j++){
				if(parentNode.childs[j].getId()!=node.getId()){
					newchilds.push(parentNode.childs[j]);
				}
			};
			parentNode.childs=newchilds;			
		}
		
		function del(nodes){
			for(var i=0,len=nodes.lenght;i<len;i++){
				var node = nodes[i];
				parentDeleteChild(node);
				checkParentHasChild(node);
			}
		}
		function checkParentHasChild(node){
			if(node.parentNode){
				if(node.parentNode.isLeaf()){
					parentDeleteChild(node.parentNode);
					checkParentHasChild(node.parentNode);
				}
			}
		}
		del(nodes);
		this.clearBtnCls();
	},
	getCheckNode:function(isleaf){
		var checks = [];
		this.root.getCheckedNode(checks,false);
		return checks;
	},
	getLeafNodes:function(){
		var leafs = [];
		this.root.getLeafNodes(leafs);
		return leafs;
	},
	clearBtnCls:function(){
		var expendable = "expandable";
		var collapsable ="collapsable";
		var lastExpendable = "lastE"+expendable.substring(1);
		var lastCollapsable = "lastC"+collapsable.substring(1);
		var last ="last";
		var hitarea ="hitarea";
		function clear(nodes){
			
			for(var i=0,len=nodes.length;i<len;i++){
				var node = nodes[i];				
				node.$li.removeClass();
				node.$btn.removeClass();
				if(i+1==len && !node.isLeaf()){  //同级最后一个节点，并且不是叶子节点
					if(node.state){
						node.$li.addClass(collapsable+" "+lastCollapsable);
						node.$btn.addClass(hitarea+" "+collapsable+" "+lastCollapsable+"-"+hitarea);
					}else{
						node.$li.addClass(expendable+" "+lastExpendable);
						node.$btn.addClass(hitarea+" "+expendable+" "+lastExpendable+"-"+hitarea);						
					}
				}else if(i+1==len && node.isLeaf()){  //同级最后一个节点，并且是叶子节点
					node.$li.addClass(last);
				}else if(i+1<len && !node.isLeaf()){ //同级不是最后一个节点，并且不是叶子节点
				
					if(node.state){
						node.$li.addClass(collapsable);
						node.$btn.addClass(hitarea+" "+collapsable+"-"+hitarea);
					}else{
						node.$li.addClass(expendable);
						node.$btn.addClass(hitarea+" "+expendable+"-"+hitarea);						
					}					
				}
				clear(node.childs);
			}
		}
		
		clear(this.root.childs);
	}
};


function TreeNode(conf,parentNode,tree){
	var self = this;
	var listeners = this.listeners = conf.listeners ? conf.listeners : {};
	this.$li = conf.$li;
	this.id = conf.id;
	this.state = conf.state;
	this.$btn = conf.$btn;
	this.$text = conf.$text;
	this.$ico = conf.$text;
	this.$tool = conf.$tool;
	this.$img = conf.$img;
	
	if(conf.$checkbox && conf.$checkbox[0]){
		this.$checkbox= conf.$checkbox;
	}
	
	if(conf.$radio && conf.$radio[0]){
		this.$radio = conf.$radio;
	}
	
	
	//this.$checkbox = conf.$checkbox;
	//this.$radio = conf.$radio;
	this.parentNode = parentNode;
	this.childs = [];
	this.$ul = this.$li.children("ul");
	this.treeNodes = tree.nodes;
	if(this.treeNodes){
		this.treeNodes[""+conf.id]=this;
	}
	
	
	if(this.$ul){
		this.initChild(this.$ul.children("li"),tree,conf.listeners);
	}
	if(this.$btn){
		this.$btn.bind("click",{handler:this},this.toggleExpend);
	}
	
	if(this.$checkbox){
		this.$checkbox.bind("click",{handler:this,callback:listeners},this.bindCheckBox);
	}
	if(this.$text){
		if(this.$text.css("fontWeight")=="bolder"){
			tree.currentNodeId=conf.id;
		}
		this.$text.bind("click",{handler:this,tree:tree,callback:listeners},this.nodeClick);
	}
	if(this.$tool){
		this.$tool.bind("click",{handler:this,callback:listeners},this.toolClick);
	}	
};

TreeNode.prototype= {
	initChild :function(lis,tree,listeners){
		for(var i=0,len=lis.length;i<len;i++){
			
			var $li = $(lis[i]);
			
			var treenode = new TreeNode({
				$li:$li,
				id:$li.attr("id"),
				state:$li.hasClass("collapsable"),//如果有该样式，true表示当前是展开状态，false否则为闭合状态,
				$btn:$li.children("div.hitarea"),
				$text:$li.children("span[type='text']"),
				$ico:$li.children("span[type='ico']"),
				$tool:$li.children("span[type='tool']"),
				$img:$li.children("img"),
				$checkbox:$li.children("input[type='checkbox']"),
				$radio:$li.children("input[type='radio']"),
				listeners:listeners
			},this,tree);
			
			$li.removeAttr("id");
			this.childs.push(treenode);
		}		
	},
	expend:function(){
		if(this.$ul){
			this.$li.addClass("collapsable");
			this.$li.removeClass("expandable");
			this.$btn.addClass("collapsable-hitarea");
			this.$btn.removeClass("expandable-hitarea");
			if(this.$li.hasClass("lastExpandable")){
				this.$li.addClass("lastCollapsable");
				this.$li.removeClass("lastExpandable");
				this.$btn.addClass("lastCollapsable-hitarea");
				this.$btn.removeClass("lastExpandable-hitarea");
			}			
			this.$ul.show();
			this.state = true;
		}
	},
	collapse:function(){
		if(this.$ul){
			this.$li.removeClass("collapsable");
			this.$li.addClass("expandable");
			this.$btn.removeClass("collapsable-hitarea");
			this.$btn.addClass("expandable-hitarea");
			if(this.$li.hasClass("lastCollapsable")){
				this.$li.removeClass("lastCollapsable");
				this.$li.addClass("lastExpandable");
				this.$btn.removeClass("lastCollapsable-hitarea");
				this.$btn.addClass("lastExpandable-hitarea");
			}
			this.$ul.hide();
			this.state = false;
		}
		
	},
	isLeaf:function(){
		return this.childs.length==0;
	},
	isNodeDisplay:function(){//true表示显示
		return this.$li.css("display")!="none";
	},
	setNodeDispNone:function(){
		return this.$li.hide();
	},
	setNodeDisp:function(){
		return this.$li.show();
	},
	setTextStyle:function(css,val){
		this.$text.css(css,val);
	},
	setText:function(text){
		this.$text.html(text);
	},
	getText:function(){
		return this.$text.html();
	},
	getId:function(){
		return this.id;
	},
	filterByText:function(text){
		
	},
	getCheckedNode:function(isleaf){
		var checks = [];
		function filter(node){
			var ischeck = node.isChecked();

			if(ischeck){
				if(node.isLeaf() && isleaf){
					checks.push(node);
				}else if(!isleaf){
					checks.push(node)
				}
			}
			for(var i=0,len=node.childs.length;i<len;i++){
				var n = node.childs[i];
				filter(n);
			}
		}
		var ischeck = this.isChecked();
		if(ischeck){
			if(this.isLeaf() && isleaf){
				checks.push(node);
			}else if(!isleaf){
				checks.push(node)
			}
		}
		
			for(var i=0;i<this.childs.length;i++){
				filter(this.childs[i]);
			}
		return checks;
	},
	setChecked:function(position){
		if(!this.$checkbox) return;
		this.$checkbox.attr("checked", true); 
		if(position==="down" || position=="two"){
			if(this.childs && this.childs.length>0){
				for(var i=0;i<this.childs.length;i++){
					this.childs[i].setChecked("two");
				}
			}
		}
		if(position!=="two"){  //为了防止复选框回流父节点，造成死循环
			var flag = this.checkslibnext();
			this.parentNode.setChecked("up");
			if(this.parentNode && this.parentNode.$checkbox){
				if(flag==="cha"){
					this.parentNode.$checkbox.css("filter","gray");
				}else if(flag===true){
					this.parentNode.$checkbox.css("filter","");
				}
			}
		}
	},
	clearChecked:function(position){
		if(!this.$checkbox) return;
		if(position==="down" || position==="two"){
			this.$checkbox.attr("checked", false);
			if(this.childs && this.childs.length>0){
				for(var i=0,len = this.childs.length;i<len;i++){
					this.childs[i].clearChecked("two");
				}
			}
		}		
		if(position!=="two"){  //为了防止复选框回流父节点，造成死循环
			var flag = this.checkslibnext();
			if(this.parentNode && this.parentNode.$checkbox){
				if(flag==="cha"){
					this.parentNode.$checkbox.attr("checked", true);
					this.parentNode.$checkbox.css("filter","gray");
				}else if(flag===false){
					this.parentNode.$checkbox.attr("checked", false);
					this.parentNode.$checkbox.css("filter","");
				}
			}
			this.parentNode.clearChecked("up");
		}		
	},
	checkslibnext:function(){
		if(!this.parentNode) return;
		var childs = this.parentNode.childs;
		var nochecked=0,checked = 0;
		for(var i=0,len = childs.length;i<len;i++){
			if(childs[i].isChecked()){
				checked++;
			}else{
				nochecked++;
			}
		}
		if(nochecked==childs.length){
			return false;
		}else if(checked==childs.length){
			return true;
		}else{
			return "cha";
		}			 
	},
	isChecked:function(){  //判断复选框是否选中
		if(this.$checkbox){
			return this.$checkbox.attr("checked")==true;
		}else if(this.$radio){
			return this.$radio.attr("checked")==true;
		}else{
			return;
		}
	},
	toggleExpend:function(event){ //折叠按钮
		if(event.data.handler.state){
			event.data.handler.collapse();
		}else{
			event.data.handler.expend();
		}		
	},
	bindCheckBox:function(event){   //绑定复选框
		var handler = event.data.handler;
		var callback = event.data.callback;
		if(handler.isChecked()){
			handler.setChecked(handler.isLeaf()?"up":"down");
		}else{
			handler.clearChecked(handler.isLeaf()?"up":"down");
		}
		
		if(callback && callback.checkedAfter){
			
			callback.checkedAfter(handler,event);
		}
	},
	nodeClick:function(event){//绑定节点点击
		var handler = event.data.handler;
		var callback = event.data.callback;	
		var tree = event.data.tree;
		if(callback && callback.nodeClick && handler.$text.css("cursor")=="pointer"){
			tree.setCurrent(handler.getId());
			callback.nodeClick(handler,event);
			
		}
	},
	toolClick:function(event){//节点后面的按钮
		var handler = event.data.handler;
		var callback = event.data.callback;	
		if(callback && callback.toolClick){
			callback.toolClick(handler,event);
		}				
	},
	addNode:function(node){
		this.$ul.append(node.$li);
		this.treeNodes[""+node.getId()]=node;
		this.childs.push(node);
	},
	appendNode:function(nodes,listeners){		
		var self = this;
		function appendnode(node){
			if(node.getId()=="root") return;		
			//获取新添加节点的父节点在目标树中是否又相同的节点
			var parentNode = self.treeNodes[node.parentNode.getId()];  		
			if(parentNode){  //目标树存在要添加节点的父节点
				if(parentNode.$btn){
					
					parentNode.expend();
				}
				var newnode = node.cloneNode(listeners);
				newnode.treeNodes = self.treeNodes;
				parentNode.addNode(newnode);
				newnode.parentNode = parentNode;
				return newnode;
			}else{
				var cnode = node.cloneNode(listeners);
				
				cnode.treeNodes =self.treeNodes;
				
				var newnode = appendnode(node.parentNode);
				newnode.addNode(cnode);
				cnode.parentNode = newnode;
				return cnode;
			}
		}
		
		for(var i=0;i<nodes.length;i++){
			var node = nodes[i];
			appendnode(node);
		}
	},
	getLeafNodes:function(leafs){
		
		function round(nodes){
			for(var i=0,len = nodes.length;i<len;i++){
				var node = nodes[i];
				if(node.isLeaf()){
					leafs.push(node);
				}else{
					round(node.childs);
				}
			}
		}
		
		round(this.childs);
	},
	cloneNode:function(listeners){
		var $li = this.$li.clone();
		$li.html("");
		var state = $li.hasClass("collapsable");
		var $btn,$ico,$text,$tool,$checkbox,$radio,$ul,$img;
		if(this.$btn) $btn = this.$btn.clone();
		if(this.$ico) $ico = this.$ico.clone();
		$text = this.$text.clone();
		if(this.$tool) $tool = this.$tool.clone();
		if(this.$checkbox) $checkbox = this.$checkbox.clone();
		$checkbox.attr("checked","true");
		if(this.$radio) $radio = this.$radio.clone();
		if(this.$img) $img = this.$img.clone();
		if(!this.isLeaf()){
			$ul = $("<ul></ul>");
		}		
		$li.append($btn).append($checkbox).append($radio).append($img).append($ico).append($tool).append($ul);;
		
		var clonenode = new TreeNode({id:this.getId(),$li:$li,state:state,$btn:$btn,$text:$text,$ico:$ico,$tool:$tool,$checkbox:$checkbox,$radio:$radio,$img:$img,listeners:listeners});
		
		return clonenode;
		
	},getValue:function(key){
		return this.$li.attr(key);
	}
	
};	
			
	
		
