package com.mocha.bsm.bizsm.core.model.state;

import java.util.Calendar;
import java.util.Map;

import org.apache.commons.beanutils.PropertyUtils;

import net.sf.json.JSONObject;

import com.mocha.bsm.bizsm.adapter.bsmres.BSMAvailState;
import com.mocha.bsm.bizsm.adapter.bsmres.BSMCompositeState;
import com.mocha.bsm.bizsm.adapter.bsmres.BSMPerfState;
import com.mocha.bsm.bizsm.adapter.bsmres.IBSMResourceModelAdapter;
import com.mocha.bsm.bizsm.adapter.bsmres.IBatchBSMResourceModelAdapter;
import com.mocha.bsm.bizsm.core.model.BizService;
import com.mocha.bsm.bizsm.core.service.IBizServiceManager;
import com.thoughtworks.xstream.annotations.XStreamAlias;
import com.thoughtworks.xstream.annotations.XStreamConverter;
import com.thoughtworks.xstream.annotations.XStreamOmitField;
import com.thoughtworks.xstream.converters.basic.BooleanConverter;

/**
 * 断言
 * 
 * @author liuyong
 */
@XStreamAlias("Assertion")
public class Assertion {
	
	private Map<String, Object> symbolTable;

	/**
	 * 用来做取值的
	 */
	@XStreamOmitField
	private IBSMResourceModelAdapter bsmAdapter;
	
	private IBizServiceManager bizServiceManager;
	
	@XStreamOmitField
	private int codeId = 0;
	
	private static final int FETCH_RES_STATE = 1;
	private static final int FETCH_CHILDRES_STATE = 2;
	private static final int FETCH_RES_METRIC_STATE = 3;
	private static final int FETCH_CHILDRES_METRIC_STATE = 4;
	private static final int FETCH_BIZSERVICE_STATE = 5;
	
	private void setBSMResourceModelAdapter(IBSMResourceModelAdapter bsmAdapter) {
		this.bsmAdapter = bsmAdapter;
	}
	
	private void setBizServiceManager(IBizServiceManager bizServiceManager) {
		this.bizServiceManager = bizServiceManager;
	}
	
	@XStreamAlias("assertReason")	
	private String assertReason;
	
	@XStreamAlias("hasAssert")
	@XStreamConverter(BooleanConverter.class)
	private boolean hasAssert = false;

	@XStreamAlias("assertResult")
	private AssertResult assertResult;

	@XStreamAlias("srcCode")
	private String srcCode = "";

	@XStreamAlias("expected")
	private Object expected;

	@XStreamAlias("actual")
	private Object actual;
	
	@XStreamOmitField
	private Calendar dataTime;
	
	/**
	 * 编译,取值
	 */
	public void prepareDoAssert(Calendar dataTime,IBSMResourceModelAdapter bsmAdapter,IBizServiceManager bizServiceManager)  throws Exception{
		this.setBSMResourceModelAdapter(bsmAdapter);
		this.setBizServiceManager(bizServiceManager);
		this.dataTime = dataTime;
		this.compile();
		if(this.bsmAdapter instanceof IBatchBSMResourceModelAdapter){
			this.requestBatch((IBatchBSMResourceModelAdapter)this.bsmAdapter);
		}
	}
	
	/**
	 * 执行断言
	 * 要在执行prepare之后
	 * @return
	 */
	public AssertResult doAssert() throws Exception{
		if (hasAssert) {
			return this.assertResult;
		} else {
			this.fetchData(this.dataTime);
			AssertResult result = AssertResult.IGNORE;
			if (this.expected != null && this.actual != null) {
				if (this.expected.equals(this.actual)) {
					result = AssertResult.TRUE;
				} else {
					result = AssertResult.FALSE;
				}
			}
			this.hasAssert = true;
			this.assertResult = result;
			return result;
		}
	}	
	
	/**
	 * 执行批处理请求
	 * @param adapter
	 * @throws Exception
	 */
	private void requestBatch(IBatchBSMResourceModelAdapter adapter) throws Exception{
		if(this.codeId == Assertion.FETCH_RES_STATE){
			String resInsId = (String)this.symbolTable.get("resinsid");
			adapter.requestGetResourceState(resInsId, this.dataTime);
		}else if(this.codeId == Assertion.FETCH_CHILDRES_STATE){
			String resInsId = (String)this.symbolTable.get("childresinsid");
			adapter.requestGetResourceState(resInsId, this.dataTime);
		}else if(this.codeId == Assertion.FETCH_RES_METRIC_STATE){
			String resInsId = (String)this.symbolTable.get("resinsid");
			String metricId = (String)this.symbolTable.get("metricid");
			adapter.requestGetMetricState(resInsId, metricId, dataTime);
		}else if(this.codeId == Assertion.FETCH_CHILDRES_METRIC_STATE){
			String resInsId = (String)this.symbolTable.get("childresinsid");
			String metricId = (String)this.symbolTable.get("metricid");
			adapter.requestGetMetricState(resInsId, metricId, dataTime);
		}else if(this.codeId == Assertion.FETCH_BIZSERVICE_STATE){
			//NEED DO NOTHING
		}
	}
	
	/**
	 * 将assert的代码编译
	 * 确定如何获取数据和期望状态
	 * @throws Exception
	 */
	protected void compile() throws Exception{
		if(this.srcCode != null){
			JSONObject jsonObject = JSONObject.fromObject(this.srcCode);
			this.symbolTable = (Map) JSONObject.toBean(jsonObject, Map.class);
			if(this.srcCode.contains("'resinsid':'")
					&&this.srcCode.contains("'compositestate':'")
					&&!this.srcCode.contains("'childresinsid':'")
					&&!this.srcCode.contains("'metricid':'")){//资源状态
				this.codeId = Assertion.FETCH_RES_STATE;
			}else if(this.srcCode.contains("'resinsid':'")
					&&this.srcCode.contains("'compositestate':'")
					&&this.srcCode.contains("'childresinsid':'")
					&&!this.srcCode.contains("'metricid':'")){//子资源状态
				this.codeId = Assertion.FETCH_CHILDRES_STATE;
			}else if(this.srcCode.contains("'resinsid':'")
					&&this.srcCode.contains("'compositestate':'")
					&&this.srcCode.contains("'childresinsid':'")
					&&this.srcCode.contains("'metricid':'")){//子资源指标状态
				this.codeId = Assertion.FETCH_CHILDRES_METRIC_STATE;
			}else if(this.srcCode.contains("'resinsid':'")
					&&this.srcCode.contains("'compositestate':'")
					&&!this.srcCode.contains("'childresinsid':'")
					&&this.srcCode.contains("'metricid':'")){//资源指标状态
				this.codeId = Assertion.FETCH_RES_METRIC_STATE;
			}else if(this.srcCode.contains("'bizserviceid':'") && this.srcCode.contains("'bizservicestate':'")){
				this.codeId = Assertion.FETCH_BIZSERVICE_STATE;
			}else{
				throw new RuntimeException("Assertion's syntax is Error!");
			}
			this.setExpectedState();//设置期望状态
		}else{
			throw new RuntimeException("Assertion srcCode is null!");
		}
	}
	
	/**
	 * 构建获取资源状态的原因
	 * @param resInsId
	 */
	private void makeFetchResStateReason(String resInsId){
		this.assertReason = "";//TODO
	}
	/**
	 * 构建获取资源指标状态的原因
	 * @param resInsId
	 * @param metricId
	 */
	private void makeFetchMetricStateReason(String resInsId,String metricId){
		this.assertReason = "";//TODO
	}
	/**
	 * 构建获取子资源状态的原因
	 * @param resInsId
	 * @param childResInsId
	 */
	private void makeFetchChildResStateReason(String resInsId,String childResInsId){
		this.assertReason = "";//TODO
	}
	/**
	 * 构建获取子资源指标状态的原因
	 * @param resInsId
	 * @param childResInsId
	 * @param metricId
	 */
	private void makeFetchChildMetricStateReason(String resInsId,String childResInsId,String metricId){
		this.assertReason = "";//TODO
	}	
	/**
	 * 构建获取业务服务状态的原因
	 * @param bizServiceId
	 */
	private void makeFetchBizServiceStateReason(String bizServiceId){
		this.assertReason = "";//TODO
	}
	/**
	 * 获取计算所需要的数据
	 * 包括生成数据获取原因
	 * @param dataTime
	 * @throws Exception
	 */
	protected void fetchData(Calendar dataTime) throws Exception{	
		if(this.codeId == Assertion.FETCH_RES_STATE){
			this.fetchResState(dataTime);
		}else if(this.codeId == Assertion.FETCH_CHILDRES_STATE){
			this.fetchChildResState(dataTime);
		}else if(this.codeId == Assertion.FETCH_RES_METRIC_STATE){
			this.fetchResMetricState(dataTime);
		}else if(this.codeId == Assertion.FETCH_CHILDRES_METRIC_STATE){
			this.fetchChildResMetricState(dataTime);
		}else if(this.codeId == Assertion.FETCH_BIZSERVICE_STATE){
			this.fetchBizServiceState(dataTime);
		}
	}
	/**
	 * 在编译之后,即可获得所期望的状态
	 * a.业务服务的状态
	 * b.受控资源的状态
	 * @throws Exception
	 */
	protected void setExpectedState() throws Exception{
		if(this.codeId == Assertion.FETCH_BIZSERVICE_STATE){
			String bizServiceStateStr = (String)this.symbolTable.get("bizservicestate");
			BizServiceState bizServiceState = BizServiceState.valueOf(bizServiceStateStr);
			this.expected = bizServiceState;
		}else{
			Object compStateBean = this.symbolTable.get("compositestate");
			BSMAvailState availState = BSMAvailState.valueOf(PropertyUtils.getProperty( compStateBean, "availState" ).toString());
			BSMPerfState perfState = BSMPerfState.valueOf(PropertyUtils.getProperty( compStateBean, "perfState" ).toString());
			this.expected = new BSMCompositeState();
			((BSMCompositeState)this.expected).setAvailState(availState);
			((BSMCompositeState)this.expected).setPerfState(perfState);				 
		}
	}
	
	protected void fetchResState(Calendar dataTime) throws Exception{
		String resInsId = (String)this.symbolTable.get("resinsid");
		this.actual = this.bsmAdapter.getResourceState(resInsId, dataTime);
		this.makeFetchResStateReason(resInsId);		
	}
	
	protected void fetchResMetricState(Calendar dataTime) throws Exception{
		String resInsId = (String)this.symbolTable.get("resinsid");
		String metricId = (String)this.symbolTable.get("metricid");
		this.actual = this.bsmAdapter.getMetricState(resInsId, metricId, dataTime);
		this.makeFetchMetricStateReason(resInsId, metricId);
	}
	
	protected void fetchChildResState(Calendar dataTime) throws Exception{
		String fResInsId = (String)this.symbolTable.get("resinsid");
		String resInsId = (String)this.symbolTable.get("childresinsid");
		this.actual = this.bsmAdapter.getResourceState(resInsId, dataTime);
		this.makeFetchChildResStateReason(fResInsId, resInsId);
	}
	
	protected void fetchChildResMetricState(Calendar dataTime) throws Exception{
		String fResInsId = (String)this.symbolTable.get("resinsid");
		String resInsId = (String)this.symbolTable.get("childresinsid");
		String metricId = (String)this.symbolTable.get("metricid");
		this.actual = this.bsmAdapter.getMetricState(resInsId, metricId, dataTime);
		this.makeFetchChildMetricStateReason(fResInsId,resInsId, metricId);
	}
	
	protected void fetchBizServiceState(Calendar dataTime){
		String serviceId = (String)this.symbolTable.get("bizserviceid");
		BizService service = this.bizServiceManager.getBizServiceById(serviceId);
		this.actual = service.getMonitoredState();
		this.makeFetchBizServiceStateReason(serviceId);
	}
	

	public boolean isHasAssert() {
		return hasAssert;
	}

	public void setHasAssert(boolean hasAssert) {
		this.hasAssert = hasAssert;
	}

	public Object getExpected() {
		return expected;
	}

	public void setExpected(Object expected) {
		this.expected = expected;
	}

	public Object getActual() {
		return actual;
	}

	public void setActual(Object actual) {
		this.actual = actual;
	}

	public void setAssertResult(AssertResult assertResult) {
		this.assertResult = assertResult;
	}

	public AssertResult getAssertResult() {
		return assertResult;
	}

	public String getSrcCode() {
		return srcCode;
	}

	public void setSrcCode(String srcCode) {
		this.srcCode = srcCode;
	}

	public int hashCode() {
		return this.srcCode.hashCode() * 31;
	}
	
	public String getAssertReason() {
		return this.assertReason;
	}

	public boolean equals(Object anObject) {
		if (this == anObject) {
			return true;
		}
		if (anObject instanceof Assertion) {
			Assertion anotherBizService = (Assertion) anObject;
			if (anotherBizService.srcCode != null
					&& anotherBizService.srcCode.equals(this.srcCode)) {
				return true;
			}

		}
		return false;
	}

}
