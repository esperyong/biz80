<div name="cue_min" class="cue-min f-relative" <s:if test="!#metric.critical">disabled</s:if>>
					<s:if test='#unit.equals("%")'>
			  			<div class="limit" style="display:block;"></div>
			  			<div class="cue-content">
			  				<span class="cue-min-red" style="height:<s:property value="100-#redHeight" />%">
								<span class="cue-min-note cue-min-note-red"><s:property value="#redHeight" />%</span></span>
							<span class="cue-min-yellow" style="height:<s:property value="100-#yeHeight" />%">
								<span class="cue-min-note cue-min-note-yellow"><s:property value="#yeHeight" />%</span></span>
							<span class="cue-min-green"></span>
			  			</div>
			  			<div class="limit" style="display:block;"></div>
		  			</s:if><s:else>
		  			<div class="limit limit-red" style="display:block;"></div>
		  			<div class="cue-content">
		  				<span class="cue-min-red" style="height:30%">
							<span class="cue-min-note cue-min-note-red"><s:property value="#redHeight" /><s:property value="#unit"/></span></span>
						<span class="cue-min-yellow" style="height:60%">
							<span class="cue-min-note cue-min-note-yellow"><s:property value="#yeHeight" /><s:property value="#unit"/></span></span>
						<span class="cue-min-green"></span>
		  			</div>
		  			</s:else>
	  			  </div>