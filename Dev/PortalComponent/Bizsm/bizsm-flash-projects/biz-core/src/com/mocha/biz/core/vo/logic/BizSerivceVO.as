package com.mocha.biz.core.vo.logic
	{
	import com.mocha.biz.core.common.NodeType;
	import com.mocha.biz.core.constant.StateConstant;
	import com.mocha.common.vo.BaseVO;
	
	import mx.collections.ArrayCollection;
	import mx.collections.ArrayList;
	import mx.logging.ILogger;
	import mx.logging.Log;
	
	/**
	 * @author chendg
	 * @version 1.0
	 * @created 14-����-2010 9:44:22
	 */
	public class BizSerivceVO extends BaseVO
	{
		private static var log:ILogger = Log.getLogger("com.mocha.biz.core.vo.logic.BizSerivceVO");
		[ArrayElementType("String")]
	    public var belongDomainIds: Array;
	    public var bizId: String;
		
		[ArrayElementType("com.mocha.biz.core.vo.logic.BizUser")]
	    public var bizUsers: Array;
		
		[ArrayElementType("com.mocha.biz.core.vo.logic.BizSerivceVO")]
	    public var childBizServices: Array;
	    public var data: XML;
		
		[ArrayElementType("com.mocha.biz.core.vo.logic.MonitableResource")]
	    public var monitableResources: Array;
	    public var name: String;
	    public var refGraphId: String;
	    public var reflectFactor: String;
		
		[ArrayElementType("com.mocha.biz.core.vo.logic.ResponsiblePerson")]
	    public var responsiblePerson: Array;
		
		[XMLAttInspectable]
	    public var uri: String;
		
		[XMLAttInspectable]
		public var monitered:Boolean = false;
		
		[XMLAttInspectable]
		public var monitoredState:String = StateConstant.UNKNOWN;
		
		override public function get aliasName():String
		{
			return "BizService";
		}
		
		public function addBizSerivces(resouces:Object):void
		{
			if(!this.childBizServices){
				this.childBizServices = [];
			}
			if(resouces is BizSerivceVO){
				this.addBizSerivece(resouces);
			} else if(resouces is Array || resouces is ArrayCollection || resouces is ArrayList){
				for each(var tempBiz:BizSerivceVO in this.childBizServices){
					if(tempBiz){
						this.addBizSerivece(tempBiz);
					}
				}
			}
		}
		
		public function removeBizServices(resouces:Object):void
		{
			if(!resouces){
				return;
			}
			if(resouces is BizSerivceVO || resouces is String){
				this.removeBizService(resouces);
			} else if(resouces is Array || resouces is ArrayCollection || resouces is ArrayList){
				for each(var tempBiz:Object in this.childBizServices){
					if(tempBiz){
						this.removeBizService(tempBiz);
					}
				}
			}
		}
		
		public function addBizUsers(resouces:Object):void
		{
			if(!this.bizUsers){
				this.bizUsers = [];
			}
			if(resouces is BizUser){
				this.addBizUser(resouces);
			} else if(resouces is Array || resouces is ArrayCollection || resouces is ArrayList){
				for each(var tempBiz:BizUser in this.bizUsers){
					if(tempBiz){
						this.addBizUser(tempBiz);
					}
				}
			}
		}
		
		public function removeBizUsers(resouces:Object):void
		{
			if(resouces is BizUser || resouces is String){
				this.removeBizUser(resouces);
			} else if(resouces is Array || resouces is ArrayCollection || resouces is ArrayList){
				for each(var tempBiz:Object in this.childBizServices){
					if(tempBiz){
						this.removeBizUser(tempBiz);
					}
				}
			}
		}
		
		public function addMonitorResources(resouces:Object):void
		{
			if(!this.monitableResources){
				this.monitableResources = [];
			}
			if(resouces is MonitableResource){
				this.addMonitorResource(resouces);
			} else if(resouces is Array || resouces is ArrayCollection || resouces is ArrayList){
				for each(var tempBiz:MonitableResource in this.monitableResources){
					if(tempBiz){
						this.addMonitorResource(tempBiz);
					}
				}
			}
		}
		
		public function removeMonitorResources(resouces:Object):void
		{
			if(resouces is MonitableResource || resouces is String){
				this.removeMonitorResource(resouces);
			} else if(resouces is Array || resouces is ArrayCollection || resouces is ArrayList){
				for each(var tempBiz:Object in this.monitableResources){
					if(tempBiz){
						this.removeMonitorResource(tempBiz);
					}
				}
			}
		}
		
		private function addBizSerivece(resouce:Object):void
		{
			this.childBizServices.push(resouce);
		}
		
		private function removeBizService(resouce:Object):void
		{
			var id:String = getChildId(resouce);
			for(var index:Object in this.childBizServices){
				if(getChildId(this.childBizServices[index]) == id){
					this.childBizServices.splice(index,1);
					break;
				}
			}
		}
		
		private function addBizUser(resouce:Object):void
		{
			this.bizUsers.push(resouce);
		}
		
		private function removeBizUser(resouce:Object):void
		{
			var id:String = getChildId(resouce);
			for(var index:Object in this.bizUsers){
				if(getChildId(this.bizUsers[index]) == id){
					delete this.bizUsers.splice(index,1);
					break;
				}
			}
		}
		
		private function addMonitorResource(resouce:Object):void
		{
			this.monitableResources.push(resouce);
		}
		
		private function removeMonitorResource(resouce:Object):void
		{
			var id:String = getChildId(resouce);
			for(var index:Object in this.monitableResources){
				if(getChildId(this.monitableResources[index]) == id){
					delete this.monitableResources.splice(index,1);
					break;
				}
			}
		}
		
		public function isChildBizServiceExist(bizService:Object):Boolean
		{
			if(!this.childBizServices){
				return false;
			}
			var id:String = this.getChildId(bizService);
			for each(var child:BizSerivceVO in this.childBizServices){
				if(child.uri == id){
					return true;
				}
			}
			return false;
		}
		
		public function isBizUserExist(bizuser:Object):Boolean
		{
			if(!this.bizUsers){
				return false;
			}
			var id:String = this.getChildId(bizuser);
			for each(var child:BizUser in this.bizUsers){
				if(child.uri == id){
					return true;
				}
			}
			return false;
		}
		
		public function isResouceExist(resouce:Object):Boolean
		{
			if(!this.monitableResources){
				return false;
			}
			var id:String = this.getChildId(resouce);
			for each(var child:MonitableResource in this.monitableResources){
				if(child.uri == id){
					return true;
				}
			}
			return false;
		}
		
		public function getChildId(resouce:Object):String
		{
			var id:String;
			if(resouce is String){
				id = String(resouce);
			} else if(resouce is BizSerivceVO){
				id = (resouce as BizSerivceVO).uri;
			} else if(resouce is BizUser){
				id = (resouce as BizUser).uri;
			} else if(resouce is MonitableResource){
				id = (resouce as MonitableResource).uri;
			} else {
				log.warn("input[resouce={0}] is invalid!", resouce);
			}
			return id;
		}
		
		public function getChildByUri(uri:String,type:String):Object
		{
			var child:Object;
			if(type == NodeType.BIZSERVICE){
				for each(var childSerivce:BizSerivceVO in this.childBizServices){
					if(childSerivce.uri == uri){
						child = childSerivce;
						break;
					}
				}
			} else if(type == NodeType.BIZUSER){
				for each(var childBizUser:BizUser in this.bizUsers){
					if(childBizUser.uri == uri){
						child = childBizUser;
						break;
					}
				}
			}  else if(type == NodeType.RESOURCE){
				for each(var childResource:MonitableResource in this.monitableResources){
					if(childResource.uri == uri){
						child = childResource;
						break;
					}
				}
			} else {
				log.warn("getChildByUri(uri={0},type={1}) type is invalid!",uri,type);
			}
			return child;
		}
		
		public function updateChild(childObj:Object):void
		{
			var type:String;
			var uri:String;
			if(!childObj){
				return;
			}
			if(childObj is BizSerivceVO){
				type = NodeType.BIZSERVICE;
			} else if(childObj is BizUser){
				type = NodeType.BIZUSER;
 			} else if(childObj is MonitableResource){
				type = NodeType.RESOURCE;
			}
			var index:Number = 0;
			if(type == NodeType.BIZSERVICE){
				for(index; index<this.childBizServices.length;index++){
					var childSerivce:BizSerivceVO = this.childBizServices[index];
					if(childSerivce.uri == uri){
						this.childBizServices[index] = childObj;
						break;
					}
				}
			} else if(type == NodeType.BIZUSER){
				for(index; index<this.bizUsers.length;index++){
					var childBizUser:BizUser = this.bizUsers[index];
					if(childBizUser.uri == uri){
						this.bizUsers[index] = childObj;
						break;
					}
				}
			}  else if(type == NodeType.RESOURCE){
				for(index; index<this.monitableResources.length;index++){
					var childResource:MonitableResource = this.monitableResources[index];
					if(childResource.uri == uri){
						this.monitableResources[index] = childObj;
						break;
					}
				}
			} else {
				log.warn("getChildByUri(uri={0},type={1}) type is invalid!",uri,type);
			}
		}
		
	
	}//end BizSerivceVO
}