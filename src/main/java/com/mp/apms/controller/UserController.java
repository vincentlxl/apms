package com.mp.apms.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mp.apms.bean.Menu;

@Controller
@RequestMapping("/user")
public class UserController
{
    
    @RequestMapping("/query/{id}")
    public String queryUser(@PathVariable("id") String id, Model model)
    {
        //System.out.println("+++++++++++++++++++++++++++" + CommonUtil.getNextVal("int_log_xlpaytranslog.id"));
        Menu m1 = new Menu();
        m1.setId("001");
        m1.setName("权限管理");
        Menu m2 = new Menu();
        m2.setId("00100");
        m2.setName("角色管理");
        m2.setUrl("http://www.baidu.com");
        m2.setParentId("001");
        
        Menu m3 = new Menu();
        m3.setId("002");
        m3.setName("应用管理");
        model.addAttribute("menuString", "<div title=\"应用管理\" selected=\"false\"><a href=\"javascript:void(0);\" src=\"${pageContext.request.contextPath}/rest/app/page\" class=\"cs-navi-tab\">原生应用管理</a></p><a href=\"javascript:void(0);\" src=\"${pageContext.request.contextPath}/rest/web/page\" class=\"cs-navi-tab\">Web应用管理</a></p></div>");
        return "main";
    }
    
    @RequestMapping("/json")
    @ResponseBody
    public Map<String,Object> queryJson()
    {
        Map<String,Object> map = new HashMap<String,Object>();
        map.put("code", true);
        // ����json������@ResponseBody
        return map;
    }
}
