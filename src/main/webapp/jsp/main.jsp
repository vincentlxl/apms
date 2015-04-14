<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"> 
	<head>
		<meta charset="UTF-8">
		<title>后台管理系统</title>
		<jsp:include flush="true" page="/jsp/common/script_include_easyui.jsp"></jsp:include>
		<link href="${pageContext.request.contextPath}/css/main.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
	function addTab(title, url){
		if ($('#tabs').tabs('exists', title)){
			$('#tabs').tabs('select', title);//选中并刷新
			var currTab = $('#tabs').tabs('getSelected');
			var url = $(currTab.panel('options').content).attr('src');
			if(url != undefined && currTab.panel('options').title != '主页') {
				$('#tabs').tabs('update',{
					tab:currTab,
					options:{
						content:createFrame(url)
					}
				})
			}
		} else {
			var content = createFrame(url);
			$('#tabs').tabs('add',{
				title:title,
				content:content,
				closable:true
			});
		}
		tabClose();
	}
	
	function closeSelectedTab(){
		var title = $('#tabs').tabs('getSelected').panel('options').title;
		$('#tabs').tabs('close',title);
	}
	
	function createFrame(url) {
		var s = '<iframe scrolling="auto" frameborder="0"  src="'+url+'" style="width:100%;height:100%;"></iframe>';
		return s;
	}
			
	function tabClose() {
		/*双击关闭TAB选项卡*/
		$(".tabs-inner").dblclick(function(){
			var subtitle = $(this).children(".tabs-closable").text();
			$('#tabs').tabs('close',subtitle);
		})
		/*为选项卡绑定右键*/
		$(".tabs-inner").bind('contextmenu',function(e){
			$('#mm').menu('show', {
				left: e.pageX,
				top: e.pageY
			});
	
			var subtitle =$(this).children(".tabs-closable").text();
	
			$('#mm').data("currtab",subtitle);
			$('#tabs').tabs('select',subtitle);
			return false;
		});
	}		
	//绑定右键菜单事件
	function tabCloseEven() {
		//刷新
		$('#mm-tabupdate').click(function(){
			var currTab = $('#tabs').tabs('getSelected');
			var url = $(currTab.panel('options').content).attr('src');
			if(url != undefined && currTab.panel('options').title != '主页') {
				$('#tabs').tabs('update',{
					tab:currTab,
					options:{
						content:createFrame(url)
					}
				})
			}
		})
		//关闭当前
		$('#mm-tabclose').click(function(){
			var currtab_title = $('#mm').data("currtab");
			$('#tabs').tabs('close',currtab_title);
		})
		//全部关闭
		$('#mm-tabcloseall').click(function(){
			$('.tabs-inner span').each(function(i,n){
				var t = $(n).text();
				if(t != '主页') {
					$('#tabs').tabs('close',t);
				}
			});
		});
		//关闭除当前之外的TAB
		$('#mm-tabcloseother').click(function(){
			var prevall = $('.tabs-selected').prevAll();
			var nextall = $('.tabs-selected').nextAll();		
			if(prevall.length>0){
				prevall.each(function(i,n){
					var t=$('a:eq(0) span',$(n)).text();
					if(t != '主页') {
						$('#tabs').tabs('close',t);
					}
				});
			}
			if(nextall.length>0) {
				nextall.each(function(i,n){
					var t=$('a:eq(0) span',$(n)).text();
					if(t != '主页') {
						$('#tabs').tabs('close',t);
					}
				});
			}
			return false;
		});
		//关闭当前右侧的TAB
		$('#mm-tabcloseright').click(function(){
			var nextall = $('.tabs-selected').nextAll();
			if(nextall.length==0){
				return false;
			}
			nextall.each(function(i,n){
				var t=$('a:eq(0) span',$(n)).text();
				$('#tabs').tabs('close',t);
			});
			return false;
		});
		//关闭当前左侧的TAB
		$('#mm-tabcloseleft').click(function(){
			var prevall = $('.tabs-selected').prevAll();
			if(prevall.length==0){
				return false;
			}
			prevall.each(function(i,n){
				var t=$('a:eq(0) span',$(n)).text();
				$('#tabs').tabs('close',t);
			});
			return false;
		});
	
		//退出
		$("#mm-exit").click(function(){
			$('#mm').menu('hide');
		})
	}
	
	$(function() {
		tabCloseEven();
		$('.cs-navi-tab').click(function() {
			var $this = $(this);
			var href = $this.attr('src');
			var title = $this.text();
			addTab(title, href);
		});
	});
	
	//退出系统
    function closeSys(){
		$.messager.confirm('退出系统','确认退出系统!',function(r){
			if (r){
				 document.location = "${pageContext.request.contextPath}/rest/login/out";
			}
		});
    }
	
    function developDoc(){
    	window.open('${pageContext.request.contextPath}/wiki/Introduction.jsp','_blank');
    }
	</script>
</head>
<body class="easyui-layout my-layout">
	<div region="north" border="true" class="cs-north">
		<div class="cs-north-bg">
			<div class="cs-north-logo">
				<span title="注销" onclick="closeSys()" style="cursor:pointer">注销</span>
			</div>
			<span title="密码修改" onclick="developDoc()" style="background:transparent;cursor:pointer">密码修改</span>
		</div>
	</div>
	<div region="west" border="true" split="true" title="导航窗口" class="cs-west color-rest">
		<div class="easyui-accordion" border="false">
			${menuString}
		</div>
	</div>
	<div id="mainPanle" region="center" border="true" border="false">
		 <div id="tabs" class="easyui-tabs"  fit="true" border="false" >
                <div title="主页" >
                	<iframe scrolling="yes" frameborder="0"  src="${pageContext.request.contextPath}/rest/useLog/pagequerySta" style="width:100%;height:100%;"></iframe>
				</div>
        </div>
	</div>

	<div region="south" border="false" class="cs-south" style="color:#fff;">睦拍信息科技有限公司</div>
	
	<div id="mm" class="easyui-menu cs-tab-menu">
		<div id="mm-tabupdate">刷新</div>
		<div class="menu-sep"></div>
		<div id="mm-tabclose">关闭</div>
		<div id="mm-tabcloseother">关闭其他</div>
		<div id="mm-tabcloseall">关闭全部</div>
	</div>
</body>
</html>