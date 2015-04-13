package com.mp.apms.system.menu.util;


import java.util.ArrayList;
import java.util.List;

import com.mp.apms.bean.Menu;

public class MenuUtil {
    private StringBuffer html = new StringBuffer();
    private List<Menu> nodes;
    
    public MenuUtil(List<Menu> nodes){
        this.nodes = nodes;
    }
    
    public String buildTree(){
        html.append("<ul>");
        for (Menu Menu : nodes) {
            String id = Menu.getId();
            if (Menu.getParentId() == null) {
                html.append("\r\n<li id='" + id + "'>" + Menu.getName()+ "</li>");
                build(Menu);
            }
        }
        html.append("\r\n</ul>");
        return html.toString();
    }
    
    private void build(Menu Menu){
        List<Menu> children = getChildren(Menu);
        if (!children.isEmpty()) {
            html.append("\r\n<ul>");
            for (Menu child : children) {
                String id = child.getId();
                html.append("\r\n<li id='" + id + "'>" + child.getName()+ "</li>");
                build(child);
            }
            html.append("\r\n</ul>");
        } 
    }
    
    private List<Menu> getChildren(Menu Menu){
        List<Menu> children = new ArrayList<Menu>();
        String id = Menu.getId();
        for (Menu child : nodes) {
            if (id.equals(child.getParentId())) {
                children.add(child);
            }
        }
        return children;
    }
}
