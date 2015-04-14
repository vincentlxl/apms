package com.mp.apms.authority.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mp.apms.authority.bean.Menu;
import com.mp.apms.authority.bean.Role;
import com.mp.apms.authority.bean.User;
import com.mp.apms.authority.service.AuthorService;
import com.mp.apms.authority.util.MenuUtil;
import com.mp.apms.common.CommonConstant;
import com.mp.apms.common.util.Encryption;

@Controller
@RequestMapping("/home")
public class HomeController
{
    private static final Logger LOGGER = Logger.getLogger(HomeController.class);
    
    @Autowired
    private AuthorService authorService;
    
    @RequestMapping("/login.do")
    @ResponseBody
    public Map<String, Object> login(@RequestParam("username") String userName, @RequestParam("password") String password,
        @RequestParam("randomcode") String randomCode, HttpServletRequest request)
    {
        Map<String, Object> map = new HashMap<String, Object>();
        try
        {
            map.put(CommonConstant.RSP_CODE, true);
            HttpSession session = (HttpSession)request.getSession();
            
            // 校验验证码
            if (StringUtils.isEmpty(randomCode) || !randomCode.equals(session.getAttribute("randomCode")))
            {
                LOGGER.error("验证码不正确");
                map.put(CommonConstant.RSP_CODE, false);
                map.put(CommonConstant.RSP_MSG, "验证码不正确");
                return map;
            }
            
            User loginUser = authorService.queryUserInfo(userName);
            
            // 校验密码
            if (!loginUser.getPwd().equals(Encryption.md5(password)))
            {
                LOGGER.error("密码错误");
                map.put(CommonConstant.RSP_CODE, false);
                map.put(CommonConstant.RSP_MSG, "用户名或密码错误");
                return map;
            }
            
            session.setAttribute(CommonConstant.LOGINUSER, loginUser);
        }
        catch (Exception e)
        {
            LOGGER.error(e, e);
            map.put(CommonConstant.RSP_CODE, false);
            map.put(CommonConstant.RSP_MSG, "系统异常");
        }
        
        return map;
    }
    
    @RequestMapping("/main.do")
    public String initMenus(HttpServletRequest request, Model model)
    {
        try
        {
            HttpSession session = (HttpSession)request.getSession();
            User loginUser = (User)session.getAttribute(CommonConstant.LOGINUSER);
            
            // 超级管理员
            if ("1".equals(loginUser.getIsRoot()))
            {
                List<Menu> menus = authorService.queryMenus();
                MenuUtil menuUtil = new MenuUtil(menus);
                model.addAttribute("menuString", menuUtil.buildTree());
                session.setAttribute(CommonConstant.MENU_PERMISSION, "ALL");
            }
            else
            {
                Role role = authorService.queryRoleById(loginUser.getRoleId());
                List<Menu> menus = authorService.queryMenusById(role.getMenus());
                MenuUtil menuUtil = new MenuUtil(menus);
                model.addAttribute("menuString", menuUtil.buildTree());
                session.setAttribute(CommonConstant.MENU_PERMISSION, role.getMenus());
            }
        }
        catch (Exception e)
        {
            LOGGER.error(e, e);
            model.addAttribute(CommonConstant.RSP_MSG, "系统异常:" + e.getMessage());
            return "error";
        }
        
        return "main";
    }
}
