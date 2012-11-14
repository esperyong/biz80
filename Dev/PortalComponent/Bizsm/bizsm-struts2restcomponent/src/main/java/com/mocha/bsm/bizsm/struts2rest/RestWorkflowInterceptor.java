
package com.mocha.bsm.bizsm.struts2rest;

import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.ValidationAware;
import com.opensymphony.xwork2.inject.Inject;
import com.opensymphony.xwork2.interceptor.MethodFilterInterceptor;
import com.opensymphony.xwork2.util.logging.Logger;
import com.opensymphony.xwork2.util.logging.LoggerFactory;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.dispatcher.mapper.ActionMapping;
import static javax.servlet.http.HttpServletResponse.SC_BAD_REQUEST;

/**
 * <!-- START SNIPPET: description -->
 *
 * An interceptor that makes sure there are not validation errors before allowing the interceptor chain to continue.
 * <b>This interceptor does not perform any validation</b>.
 * 
 * <p>Copied from the {@link com.opensymphony.xwork2.interceptor.DefaultWorkflowInterceptor}, this interceptor adds support for error handling of Restful
 * operations.  For example, if an validation error is discovered, a map of errors is created and processed to be
 * returned, using the appropriate content handler for rendering the body.</p>
 *
 * <p/>This interceptor does nothing if the name of the method being invoked is specified in the <b>excludeMethods</b>
 * parameter. <b>excludeMethods</b> accepts a comma-delimited list of method names. For example, requests to
 * <b>foo!input.action</b> and <b>foo!back.action</b> will be skipped by this interceptor if you set the
 * <b>excludeMethods</b> parameter to "input, back".
 *
 * <b>Note:</b> As this method extends off MethodFilterInterceptor, it is capable of
 * deciding if it is applicable only to selective methods in the action class. This is done by adding param tags
 * for the interceptor element, naming either a list of excluded method names and/or a list of included method
 * names, whereby includeMethods overrides excludedMethods. A single * sign is interpreted as wildcard matching
 * all methods for both parameters.
 * See {@link MethodFilterInterceptor} for more info.
 *
 * <!-- END SNIPPET: description -->
 *
 * <p/> <u>Interceptor parameters:</u>
 *
 * <!-- START SNIPPET: parameters -->
 *
 * <ul>
 *
 * <li>inputResultName - Default to "input". Determine the result name to be returned when
 * an action / field error is found.</li>
 *
 * </ul>
 *
 * <!-- END SNIPPET: parameters -->
 *
 * <p/> <u>Extending the interceptor:</u>
 *
 * <p/>
 *
 * <!-- START SNIPPET: extending -->
 *
 * There are no known extension points for this interceptor.
 *
 * <!-- END SNIPPET: extending -->
 *
 * <p/> <u>Example code:</u>
 *
 * <pre>
 * <!-- START SNIPPET: example -->
 * 
 * &lt;action name="someAction" class="com.examples.SomeAction"&gt;
 *     &lt;interceptor-ref name="params"/&gt;
 *     &lt;interceptor-ref name="validation"/&gt;
 *     &lt;interceptor-ref name="workflow"/&gt;
 *     &lt;result name="success"&gt;good_result.ftl&lt;/result&gt;
 * &lt;/action&gt;
 * 
 * &lt;-- In this case myMethod as well as mySecondMethod of the action class
 *        will not pass through the workflow process --&gt;
 * &lt;action name="someAction" class="com.examples.SomeAction"&gt;
 *     &lt;interceptor-ref name="params"/&gt;
 *     &lt;interceptor-ref name="validation"/&gt;
 *     &lt;interceptor-ref name="workflow"&gt;
 *         &lt;param name="excludeMethods"&gt;myMethod,mySecondMethod&lt;/param&gt;
 *     &lt;/interceptor-ref name="workflow"&gt;
 *     &lt;result name="success"&gt;good_result.ftl&lt;/result&gt;
 * &lt;/action&gt;
 *
 * &lt;-- In this case, the result named "error" will be used when
 *        an action / field error is found --&gt;
 * &lt;-- The Interceptor will only be applied for myWorkflowMethod method of action
 *        classes, since this is the only included method while any others are excluded --&gt;
 * &lt;action name="someAction" class="com.examples.SomeAction"&gt;
 *     &lt;interceptor-ref name="params"/&gt;
 *     &lt;interceptor-ref name="validation"/&gt;
 *     &lt;interceptor-ref name="workflow"&gt;
 *        &lt;param name="inputResultName"&gt;error&lt;/param&gt;
*         &lt;param name="excludeMethods"&gt;*&lt;/param&gt;
*         &lt;param name="includeMethods"&gt;myWorkflowMethod&lt;/param&gt;
 *     &lt;/interceptor-ref&gt;
 *     &lt;result name="success"&gt;good_result.ftl&lt;/result&gt;
 * &lt;/action&gt;
 *
 * <!-- END SNIPPET: example -->
 * </pre>
 *
 * @author Jason Carreira
 * @author Rainer Hermanns
 * @author <a href='mailto:the_mindstorm[at]evolva[dot]ro'>Alexandru Popescu</a>
 * @author Philip Luppens
 * @author tm_jee
 */
public class RestWorkflowInterceptor extends MethodFilterInterceptor {
	
	private static final long serialVersionUID = 7563014655616490865L;

	private static final Logger LOG = LoggerFactory.getLogger(RestWorkflowInterceptor.class);
	
	private String inputResultName = Action.INPUT;
	
	private IContentTypeHandlerManager manager;

    private String postMethodNameToResources = "createSubResource";
    private String createNewSubMethodName = "createNewSub";
    
    private String postMethodNameToResource = "appendData";
    private String appendDataInputMethodName = "appendDataInput";
    
    private String putMethodName = "createOrUpdate";    
    private String createOrUpdateInputMethodName = "createOrUpdateInput";
    
    private String putStructureMethodName = "createOrUpdateStructure";    
    private String createOrUpdateStructureInputMethodName = "createOrUpdateStructureInput";
    
    private int validationFailureStatusCode = SC_BAD_REQUEST;

    @Inject(required=false,value="struts.mapper.postMethodNameToResources")
    public void setPostMethodNameToResources(String postMethodNameToResources) {
        this.postMethodNameToResources = postMethodNameToResources;
    }
    @Inject(required=false,value="struts.mapper.appendDataInputMethodName")
    public void setAppendDataInputMethodName(String appendDataInputMethodName) {
        this.appendDataInputMethodName = appendDataInputMethodName;
    }
    
    @Inject(required=false,value="struts.mapper.postMethodNameToResource")
    public void setPostMethodNameToResource(String postMethodNameToResource) {
        this.postMethodNameToResource = postMethodNameToResource;
    }    

    @Inject(required=false,value="struts.mapper.createOrUpdateInputMethodName")
    public void setCreateOrUpdateInputMethodName(String createOrUpdateInputMethodName) {
        this.createOrUpdateInputMethodName = createOrUpdateInputMethodName;
    }

    @Inject(required=false,value="struts.mapper.createNewSubMethodName")
    public void setCreateNewSubMethodName(String createNewSubMethodName) {
        this.createNewSubMethodName = createNewSubMethodName;
    }

    @Inject(required=false,value="struts.mapper.putMethodName")
    public void setPutMethodName(String putMethodName) {
        this.putMethodName = putMethodName;
    }
    
    @Inject(required=false,value="struts.mapper.putMethodName")
    public void setPutStructureMethodName(String putStructureMethodName) {
        this.putStructureMethodName = putStructureMethodName;
    }
    
    @Inject(required=false,value="struts.mapper.putMethodName")
    public void setCreateOrUpdateStructureInputMethodName(String createOrUpdateStructureInputMethodName) {
        this.createOrUpdateStructureInputMethodName = createOrUpdateStructureInputMethodName;
    }    
    
    @Inject(required=false,value="struts.rest.validationFailureStatusCode")
    public void setValidationFailureStatusCode(String code) {
        this.validationFailureStatusCode = Integer.parseInt(code);
    }

    @Inject
	public void setContentTypeHandlerManager(IContentTypeHandlerManager mgr) {
	    this.manager = mgr;
	}
	
	/**
	 * Set the <code>inputResultName</code> (result name to be returned when 
	 * a action / field error is found registered). Default to {@link Action#INPUT}
	 * 
	 * @param inputResultName what result name to use when there was validation error(s).
	 */
	public void setInputResultName(String inputResultName) {
		this.inputResultName = inputResultName;
	}
	
	/**
	 * Intercept {@link ActionInvocation} and processes the errors using the {@link com.mocha.bsm.bizsm.struts2rest.handler.IContentHandler}
	 * appropriate for the request.  
	 * 
	 * @return String result name
	 */
    protected String doIntercept(ActionInvocation invocation) throws Exception {
        Object action = invocation.getAction();

        if (action instanceof ValidationAware) {
            ValidationAware validationAwareAction = (ValidationAware) action;

            if (validationAwareAction.hasErrors()) {
            	if (LOG.isDebugEnabled()) {
            		LOG.debug("Errors on action "+validationAwareAction+", returning result name 'input'");
            	}
            	ActionMapping mapping = (ActionMapping) ActionContext.getContext().get(ServletActionContext.ACTION_MAPPING);
            	String method = inputResultName;
                if (postMethodNameToResources.equals(mapping.getMethod())) {
                   method = createNewSubMethodName;
                } else if (postMethodNameToResource.equals(mapping.getMethod())) {
                   method = appendDataInputMethodName;
                }else if (putMethodName.equals(mapping.getMethod())) {
                   method = createOrUpdateInputMethodName;
                }else if (putStructureMethodName.equals(mapping.getMethod())) {
                   method = createOrUpdateStructureInputMethodName;
                }
                
            	HttpHeaders info = new DefaultHttpHeaders()
            	    .disableCaching()
            	    .renderResult(method)
            	    .withStatus(validationFailureStatusCode);
            	//ValidateError include XStream Annotation so can generate clean meanful Error Message
            	
//            	<ValidateErrors>
//            	  <FieldErrors>
//            	    <FieldError>
//            	      <FieldId>name</FieldId>
//            	      <ErrorInfo>长度小于0!</ErrorInfo>
//            	      <ErrorInfo>名称已经有人用过了!</ErrorInfo>
//            	    </FieldError>
//            	    <FieldError>
//            	      <FieldId>description</FieldId>
//            	      <ErrorInfo>长度小于1000!</ErrorInfo>
//            	      <ErrorInfo>不能包括出错字符!</ErrorInfo>
//            	    </FieldError>
//            	  </FieldErrors>
//            	  <ActionErrorInfo>Action 1出错了!</ActionErrorInfo>
//            	  <ActionErrorInfo>Action 2出错了!</ActionErrorInfo>
//            	</ValidateErrors>

            	ValidateErrors errors = new ValidateErrors(validationAwareAction.getActionErrors(),validationAwareAction.getFieldErrors());
            	
            	return manager.handleResult(invocation.getProxy().getConfig(), info, errors);
            }
        }

        return invocation.invoke();
    }

}
