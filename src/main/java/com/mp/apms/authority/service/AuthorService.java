package com.mp.apms.authority.service;

import java.util.List;

import com.mp.apms.authority.bean.Menu;
import com.mp.apms.authority.bean.Role;
import com.mp.apms.authority.bean.User;


public interface AuthorService
{
    User queryUserInfo(String loginName);
    
    Role queryRoleById(String id);
    
    List<Menu> queryMenusById(String ids);
    
    List<Menu> queryMenus();
}