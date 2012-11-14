/**
 * 
 */
package com.mocha.bsm.bizsm.core.model.state;

import java.util.List;
import com.mocha.bsm.bizsm.adapter.bsmres.BSMAvailState;
import com.mocha.bsm.bizsm.adapter.bsmres.BSMCompositeState;
import com.mocha.bsm.bizsm.adapter.bsmres.BSMPerfState;
import com.mocha.bsm.bizsm.core.model.BizService;
import com.mocha.bsm.bizsm.core.model.MonitableResource;

/**
 * 系统默认状态计算规则
 * @author liuyong
 *
 */
public class SystemDefaultStateCal{

	/**
	 * @see com.mocha.bsm.bizsm.core.model.state.IBizServiceStateCal#calculateState(com.mocha.bsm.bizsm.core.model.BizService)
	 */
	public static BizServiceState calculateState(BizService service) {
		
		List<BizService> childServices = service.getChildBizServices();
		
		List<MonitableResource> mresources = service.getMonitableResources();
		
		for (BizService childService:childServices) {
			if(childService.getMonitoredState().equals(BizServiceState.SERIOUS)){
				return BizServiceState.SERIOUS;
			}else if(childService.getMonitoredState().equals(BizServiceState.WARNING)){
				return BizServiceState.WARNING;
			}
		}
		
		for(MonitableResource mresource:mresources){
			if(mresource.getMoniterState().getAvailState().equals(BSMAvailState.UNAVAILABLE)){
				return BizServiceState.SERIOUS;
			}else if(mresource.getMoniterState().equals(new BSMCompositeState(BSMAvailState.AVAILABLE,BSMPerfState.PERFSERIOUS))||
					mresource.getMoniterState().equals(new BSMCompositeState(BSMAvailState.AVAILABLE,BSMPerfState.PERFMINOR))||
					mresource.getMoniterState().equals(new BSMCompositeState(BSMAvailState.AVAILABLE,BSMPerfState.PERFUNKNOWN))
			){
				return BizServiceState.WARNING;
			}
		}
		
		return BizServiceState.NORMAL;
	}

}
