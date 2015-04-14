package com.mp.apms.common.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mp.apms.common.CommonConstant;

/**
 * 鉴权过滤器类。
 * 
 */

public class AuthorizationFilter implements Filter
{
    /**
     * 初始化方法
     * 
     * @param FilterConfig config
     * @throws throws ServletException
     * @return void
     */
    public void init(FilterConfig config)
        throws ServletException
    {
        
    }
    
    /**
     * 鉴权方法,只对已登录的用户实行鉴权
     * 
     * @param ServletRequest request
     * @param ServletResponse response
     * @param FilterChain filterChain
     * @throws ServletException,IOException
     * @return void
     */
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain filterChain)
        throws IOException, ServletException
    {
        HttpServletRequest _request = (HttpServletRequest)request;
        _request.setCharacterEncoding("UTF-8");
        HttpServletResponse _response = (HttpServletResponse)response;
        HttpSession session = _request.getSession();
        String contextPath = _request.getContextPath();
        StringBuffer urlString = _request.getRequestURL();
        
        // 命令客户端跳转之代码
        String forward = "<script>window.top.location.href='" + contextPath + "/home/main.do';</script>";
        int index = urlString.lastIndexOf(contextPath);
        String string = urlString.substring(index, urlString.length());// 截取CONTEXTPATH以及其后面的URL
        
        if (session != null && session.getAttribute(CommonConstant.LOGINUSER) != null && isRequired(string, contextPath))
        {
            String menuid = _request.getParameter(CommonConstant.MENUID);
            String permission = (String)session.getAttribute(CommonConstant.MENU_PERMISSION);
            if (menuid == null || "".equals(menuid) || permission.indexOf(menuid) < 0)
            {
                _response.getWriter().print(forward);
                return;
            }
        }
        filterChain.doFilter(request, response);
    }
    
    /**
     * 过滤无需鉴权的URL
     * 
     * @param string contextPath以及contextPath后的URL
     * @param contextPath 工程上下文
     * @return
     */
    public Boolean isRequired(String string, String contextPath)
    {
        if (string.equals(contextPath) || string.equals(contextPath + "/") || string.indexOf("index.jsp") >= 0 || string.indexOf("login.do") >= 0
            || string.indexOf("main.do") >= 0)
        {
            return false;
        }
        return true;
    }
    
    public void destroy()
    {
    }
}