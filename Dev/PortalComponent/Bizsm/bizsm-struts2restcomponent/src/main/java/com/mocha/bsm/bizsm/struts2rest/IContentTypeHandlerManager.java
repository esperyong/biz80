package com.mocha.bsm.bizsm.struts2rest;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mocha.bsm.bizsm.struts2rest.handler.IContentHandler;
import com.opensymphony.xwork2.config.entities.ActionConfig;

import java.io.IOException;

/**
 * Manages content type handlers
 */
public interface IContentTypeHandlerManager {
    String STRUTS_REST_HANDLER_OVERRIDE_PREFIX = "struts.rest.handlerOverride.";

    /**
     * Gets the handler for the request by looking at the request content type and extension
     * @param req The request
     * @return The appropriate handler
     */
    IContentHandler getHandlerForRequest(HttpServletRequest req);

    /**
     * Gets the handler for the response by looking at the extension of the request
     * @param req The request
     * @return The appropriate handler
     */
    IContentHandler getHandlerForResponse(HttpServletRequest req, HttpServletResponse res);

    /**
     * Handles the result using handlers to generate content type-specific content
     *
     * @param actionConfig The action config for the current request
     * @param methodResult The object returned from the action method
     * @param target The object to return, usually the action object
     * @return The new result code to process
     * @throws IOException If unable to write to the response
     */
    String handleResult(ActionConfig actionConfig, Object methodResult, Object target)
            throws IOException;
}
