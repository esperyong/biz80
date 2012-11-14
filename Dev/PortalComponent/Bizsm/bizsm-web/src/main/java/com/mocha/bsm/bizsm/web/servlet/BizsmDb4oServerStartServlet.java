package com.mocha.bsm.bizsm.web.servlet;

import java.io.IOException;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.ApplicationContext;

import com.mocha.bsm.bizsm.db4otemplate.database.IContextRoot;
import com.mocha.bsm.bizsm.db4otemplate.database.IEmbeddedDb4oServer;

/**
 * Servlet implementation class BizsmDb4oServerStartServlet
 */
public class BizsmDb4oServerStartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BizsmDb4oServerStartServlet() {
        super();
        // TODO Auto-generated constructor stub
    }
    @Override
    public void init(ServletConfig sc){
    	ServletContext servletContext = sc.getServletContext();
    	ApplicationContext ac = org.springframework.web.context.support.WebApplicationContextUtils.getWebApplicationContext(servletContext);
    	IEmbeddedDb4oServer dbserver = (IEmbeddedDb4oServer)ac.getBean("db4oEmbeddedServer");
    	String servletContextPathRealPath = servletContext.getRealPath("/");
    	IContextRoot contextRoot = (IContextRoot)ac.getBean("contextRoot");
    	contextRoot.setContextRoot(servletContextPathRealPath);
    	dbserver.startup();
    }

}
