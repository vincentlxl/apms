package com.mp.apms.common.filter;

import java.io.IOException;
import java.io.UnsupportedEncodingException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.mp.apms.common.CommonConstant;

/**
 * SESSION失效检查的过滤器类。
 * 
 */

public class SessionCheckFilter implements Filter
{
    private static Log logger = LogFactory.getLog(SessionCheckFilter.class);

    private static String charEncoding = null; // 字符集

    /**
     * 初始化方法，设置字符编码
     * 
     * @param FilterConfig config
     * @throws throws ServletException
     * @return void
     */
    public void init(FilterConfig config) throws ServletException
    {

        if (charEncoding == null)
        {
            String encoding = config.getInitParameter("encoding");
            if ((encoding != null) && (!encoding.trim().equals("")))
            {
                charEncoding = encoding;
            }
            else
            {
                charEncoding = "UTF-8";
            }
        }
        if (logger.isInfoEnabled())
        {
            StringBuffer info = new StringBuffer(64);
            info.append("APMS WEB Application, System encoding is ").append(charEncoding);
            printInfo(info.toString());
            info = null;
        }
    }

    /**
     * SESSION失效检查
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
        HttpServletRequest _request = (HttpServletRequest) request;
        setEncoding(_request);
        HttpServletResponse _response = (HttpServletResponse) response;
        HttpSession session = _request.getSession();

        String contextPath = _request.getContextPath();
        StringBuffer requestURL = _request.getRequestURL();

        if (requestURL.indexOf("index.jsp") < 0 && requestURL.indexOf("login.do") < 0)
        {
            if (session == null || session.getAttribute(CommonConstant.LOGINUSER) == null)
            {
                _response.getWriter().print("<script>window.top.location.href='" + contextPath + "/jsp/index.jsp';</script>");
                return;
            }
        }
        filterChain.doFilter(request, response);

    }

    public void destroy()
    {
    }

    /**
     * 设置编码格式
     * 
     */
    private void setEncoding(HttpServletRequest request) throws UnsupportedEncodingException
    {
        String encoding = request.getCharacterEncoding();
        if (!charEncoding.equals(encoding))
        {
            request.setCharacterEncoding(charEncoding);
        }
    }

    /**
     * 在启动WEB应用时显示一些信息
     * 
     */
    private void printInfo(String info)
    {
        int len = info.length() + 6;
        StringBuffer splitChar = new StringBuffer(len);
        for (int i = 0; i < len; i++)
        {
            splitChar.append("*");
        }
        System.out.println(splitChar.toString());
        String appLogo = "              睦拍-应用内支付平台后台管理系统     ";
        System.out.println(appLogo);
        System.out.println(" " + info + " ");
        System.out.println(splitChar.toString());

        splitChar = null;
        appLogo = null;
    }
}