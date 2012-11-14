package com.mocha.biz.ui.data
{
	import com.mocha.biz.ui.component.node.CommonNode;
	import com.mocha.peony.core.canvas.GraphCanvas;
	import com.mocha.peony.core.component.IComponent;
	import com.mocha.peony.core.component.IDockable;
	import com.mocha.peony.core.component.edge.Edge;
	import com.mocha.peony.core.component.edge.IPathRouter;
	import com.mocha.peony.core.component.edge.SimpleOrthogonalRouter;
	import com.mocha.peony.core.component.node.Node;
	import com.mocha.peony.core.manager.ComponentManager;
	import com.mocha.peony.ext.utils.XMLSerializer;
	import com.mocha.peony.ext.utils.XMLdeSerializer;
	
	import flash.geom.Point;

	/**
	 * TODO：com.mocha.biz.ui.data.GraphCanvasProxy
	 * 
	 * @author chendg
	 * @version 1.0
	 * @created 2010-9-30  下午10:01:51
	 */
	public class GraphCanvasProxy
	{
		private var canvas:GraphCanvas;
		private var componentManager:ComponentManager;
		
		private var serializer:XMLSerializer;
		private var deSerializer:XMLdeSerializer;
		public function GraphCanvasProxy(canvas:GraphCanvas)
		{
			this.canvas = canvas;
			componentManager = this.canvas.componentManager;
			serializer = new XMLSerializer(this.canvas);
			deSerializer = new XMLdeSerializer(this.canvas);
		}
		
		public function getComponentByRelatonId(relId:String):IComponent
		{
			var comp:IComponent;
			var comps:Vector.<IComponent> = this.getAllComponents();
			var node:CommonNode;
			for each(var comps1:IComponent in comps){
				if(comps1 is CommonNode){
					node = comps1 as CommonNode;
					if(node.relationId && node.relationId == relId){
						comp = comps1;
						break;
					}
				}
			}
			return comp;
		}
		
		public function getComponentByUID(uid:String):IComponent
		{
			var comp:IComponent;
			var comps:Vector.<IComponent> = this.getAllComponents();
			var node:CommonNode;
			for each(var comps1:IComponent in comps){
				if(comps1.uid == uid){
					comp = comps1;
					break;
				}
			}
			return comp;
		}
		
		public function getSelectedComps():Array
		{
			var selectedComps:Array = [];
			
			var selectedCompUIDs:Array = this.canvas.selectedComponents;
			var comps:Vector.<IComponent> = this.getAllComponents();
			for each(var comp:IComponent in comps){
				if(selectedCompUIDs.indexOf(comp.uid) >= 0){
					selectedComps.push(comp);
				}
				
			}
			return selectedComps;
		}
		
		public function getAllComponents():Vector.<IComponent>
		{
			return this.componentManager.components;
		}
		
		public function deleteCompanent(components:Vector.<IComponent>):void
		{
			//得做集合拷贝  否则会漏删除元素
			var componetsCopy:Vector.<IComponent>;
			if(components){
				componetsCopy = components.concat();
			}
			
			var edges:Vector.<Edge>;
			for each(var comp:IComponent in componetsCopy){
				if(comp is Node){
					edges = this.findAllEdges(comp as Node);
					for each(var edge:Edge in edges){
						this.canvas.undockEdgeSource(edge.uid);
						this.canvas.undockEdgeTarget(edge.uid);
						this.canvas.deselectComponent(edge.uid);
						this.canvas.removeComponent(edge.uid);
					}
				}
				if(comp is Edge){
					this.canvas.undockEdgeSource(comp.uid);
					this.canvas.undockEdgeTarget(comp.uid);
				}
				this.canvas.deselectComponent(comp.uid);
				this.canvas.removeComponent(comp.uid);
			}
		}
		
		public function removeAllComponents():void
		{
			this.canvas.clearAll();
		}
		
		public function addLines(dest:IComponent):void
		{
			var comps:Array = getSelectedComps();
			if(comps.length == 0){
				return;
			}
			
			var router:IPathRouter = new SimpleOrthogonalRouter({});
			var points:Vector.<Point>;
			var edgeId:String;
			var edge:Edge;
			for each(var comp:IDockable in comps){
				if(comp is CommonNode){
					points = router.route(comp.referencePoint,(dest as IDockable).referencePoint);
					edgeId = this.canvas.addEdgeByTwoPoints(comp.referencePoint,(dest as IDockable).referencePoint,router);
					edge = this.getComponentByUID(edgeId) as Edge;
					edge.lineColor = 0xf9f9f9;
					edge.lineWeight = 2;
					this.canvas.dockEdgeSource(edgeId,comp.uid);
					this.canvas.dockEdgeTarget(edgeId,dest.uid);
//					this.canvas.addComponent(lineClassName,"",Vector.<PropertyValue>([new PropertyValue("points",points),
//					new PropertyValue("showWireFrame",false)]));
				}
			}
		}
		
		public function importData(xml:XML):void
		{
			deSerializer.deserialize(xml);
		}
		
		public function exportData():XML
		{
			return serializer.serialize();
		}
		
		private function findAllEdges(node:Node):Vector.<Edge>
		{
			var allEdges:Vector.<Edge> = new Vector.<Edge>();
			allEdges = allEdges.concat(node.incoming);
			allEdges = allEdges.concat(node.outgoing);
			return allEdges;
		}
	}
}