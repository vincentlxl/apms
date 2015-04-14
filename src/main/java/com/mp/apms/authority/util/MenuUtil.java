package com.mp.apms.authority.util;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import com.mp.apms.authority.bean.Menu;

public class MenuUtil
{
    private StringBuffer html = new StringBuffer();
    
    private List<Menu> nodes;
    
    public MenuUtil(List<Menu> nodes)
    {
        this.nodes = nodes;
    }
    
    public String buildTree()
    {
        for (Menu Menu : nodes)
        {
            if (Menu.getParentId() == null)
            {
                html.append("\r\n<div title='" + Menu.getName() + "' selected='false'>");
                build(Menu);
                html.append("</div>");
            }
        }
        return html.toString();
    }
    
    private void build(Menu Menu)
    {
        List<Menu> children = getChildren(Menu);
        if (!children.isEmpty())
        {
            for (Menu child : children)
            {
                html.append("\r\n<a href='javascript:void(0);' src='${pageContext.request.contextPath}/" + child.getUrl() + "?menuId="
                    + child.getId() + "' class='cs-navi-tab'>" + child.getName() + "</a></p>");
            }
        }
    }
    
    private List<Menu> getChildren(Menu Menu)
    {
        List<Menu> children = new ArrayList<Menu>();
        String id = Menu.getId();
        for (Menu child : nodes)
        {
            if (id.equals(child.getParentId()))
            {
                children.add(child);
            }
        }
        Collections.sort(children);
        return children;
    }
}
