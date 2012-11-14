/**
 * 
 */
package com.mocha.bsm.bizsm.core.model;

import com.mocha.bsm.bizsm.annotation.XStreamDisableEscapeXml;
import com.thoughtworks.xstream.annotations.XStreamAlias;

/**
 * @author liuyong
 *
 */
@XStreamAlias("BizTopologyGraph")
@XStreamDisableEscapeXml
public class BizTopologyGraph {
	
	@XStreamAlias("topoId")
	private String topoId;
	
	@XStreamAlias("uri")
	private String uri;
	
	@XStreamAlias("BizService")
	private BizService bizService;
	
	@XStreamAlias("GraphInfo")
	private GraphInfo graphInfo;
	
	public String getTopoId() {
		return topoId;
	}
	public void setTopoId(String topoId) {
		this.uri = "/biztopo/" + topoId;
		this.topoId = topoId;
	}
	public String getUri() {
		return uri;
	}
	public BizService getBizService() {
		return bizService;
	}
	public void setBizService(BizService bizService) {
		this.bizService = bizService;
	}
	public GraphInfo getGraphInfo() {
		return graphInfo;
	}
	public void setGraphInfo(GraphInfo graphInfo) {
		this.graphInfo = graphInfo;
	}
	
	
}
