<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"> 
	<head>
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
			<%-- <div title="应用管理" selected="false">
				<a href="javascript:void(0);" src="${pageContext.request.contextPath}/rest/app/page" class="cs-navi-tab">原生应用管理</a></p>
				<a href="javascript:void(0);" src="${pageContext.request.contextPath}/rest/web/page" class="cs-navi-tab">Web应用管理</a></p>
				<a href="javascript:void(0);" src="${pageContext.request.contextPath}/rest/appservice/page" class="cs-navi-tab">服务号管理</a></p>
				<a href="javascript:void(0);" src="${pageContext.request.contextPath}/rest/version/page" class="cs-navi-tab">历史版本</a></p>
				<a href="javascript:void(0);" src="${pageContext.request.contextPath}/rest/appType/page" class="cs-navi-tab">业务类型管理</a></p>
				<a href="javascript:void(0);" src="${pageContext.request.contextPath}/rest/scene/page" class="cs-navi-tab">场景管理</a></p>
				<a href="javascript:void(0);" src="${pageContext.request.contextPath}/rest/waitertemplate/page" class="cs-navi-tab">模板管理</a></p>
		   </div>
			<div title="原生应用接入管理" selected="false">
				<a href="javascript:void(0);" src="${pageContext.request.contextPath}/rest/console/app/mobile/page?flowState=0" class="cs-navi-tab">待审核原生应用管理</a></p>
				<a href="javascript:void(0);" src="${pageContext.request.contextPath}/rest/console/app/mobile/page?flowState=1" class="cs-navi-tab">审核已通过原生应用管理</a></p>
				<a href="javascript:void(0);" src="${pageContext.request.contextPath}/rest/console/app/mobile/page?flowState=2" class="cs-navi-tab">审核未通过原生应用管理</a></p>
			</div>
			<div title="开发者管理中心" selected="false">
				<a href="javascript:void(0);" src="${pageContext.request.contextPath}/rest/developer/page" class="cs-navi-tab">开发者注册管理</a></p>
			</div>
			<div title="策略管理" selected="false">
				<a href="javascript:void(0);" src="${pageContext.request.contextPath}/rest/appRule/page" class="cs-navi-tab">应用策略管理</a></p>
				<a href="javascript:void(0);" src="${pageContext.request.contextPath}/jsp/handheld/strategy/loginStrategylist.jsp" class="cs-navi-tab">登陆策略管理</a></p>
				<a href="javascript:void(0);" src="${pageContext.request.contextPath}/jsp/handheld/strategy/loginStrategyAuthlist.jsp" class="cs-navi-tab">鉴权服务管理</a></p>
				<!-- <a href="javascript:void(0);" src="${pageContext.request.contextPath}/rest/appAuth/page" class="cs-navi-tab">应用鉴权服务</a></p> -->
				<a href="javascript:void(0);" src="${pageContext.request.contextPath}/rest/userinfo/page" class="cs-navi-tab">用户信息服务</a></p>
				<a href="javascript:void(0);" src="${pageContext.request.contextPath}/rest/appAuthed/page" class="cs-navi-tab">已授权应用列表服务</a></p>
			</div>
			<div title="API授权" selected="false">
				<a href="javascript:void(0);" src="${pageContext.request.contextPath}/jsp/handheld/apiempower/apiempower.jsp" class="cs-navi-tab">API授权</a></p>
				<a href="javascript:void(0);" src="${pageContext.request.contextPath}/jsp/handheld/apiempower/apiempowerlog.jsp" class="cs-navi-tab">API历史记录</a></p>
			</div>
			<div title="讨论组管理" selected="false">
				<a href="javascript:void(0);" src="${pageContext.request.contextPath}/rest/discussgroup/page" class="cs-navi-tab">讨论组管理</a></p>
				<a href="javascript:void(0);" src="${pageContext.request.contextPath}/rest/discusstopic/page" class="cs-navi-tab">讨论组主题管理</a></p>
			</div>
			<div title="查询统计" selected="false">
				<a href="javascript:void(0);" src="${pageContext.request.contextPath}/rest/useLog/pageuselog" class="cs-navi-tab">使用统计</a></p>
				<a href="javascript:void(0);" src="${pageContext.request.contextPath}/rest/downloadLog/pagedown" class="cs-navi-tab">下载统计</a></p>
				<a href="javascript:void(0);" src="${pageContext.request.contextPath}/rest/useLog/pagequerySta" class="cs-navi-tab">查询统计</a></p>
				<a href="javascript:void(0);" src="${pageContext.request.contextPath}/rest/inlog/page" class="cs-navi-tab">登录统计</a></p>
				<a href="javascript:void(0);" src="${pageContext.request.contextPath}/rest/usernum/page" class="cs-navi-tab">在线用户数</a></p>
			</div>
			<div title="日志管理" selected="false">
				<a href="javascript:void(0);" src="${pageContext.request.contextPath}/rest/inlog/pagemsg" class="cs-navi-tab">登录日志</a></p>
				<a href="javascript:void(0);" src="${pageContext.request.contextPath}/rest/useLog/page" class="cs-navi-tab">使用日志</a></p>
				<a href="javascript:void(0);" src="${pageContext.request.contextPath}/rest/downloadLog/page" class="cs-navi-tab">下载日志</a></p>
				<a href="javascript:void(0);" src="${pageContext.request.contextPath}/jsp/handheld/log/errorLoglist.jsp" class="cs-navi-tab">错误日志</a></p>
			</div>
			<div title="公告管理" selected="false">
				<a href="javascript:void(0);" src="${pageContext.request.contextPath}/rest/announcementList/page" class="cs-navi-tab">公告管理</a></p>
			</div>
			<div title="横幅管理" selected="false">
				<a href="javascript:void(0);" src="${pageContext.request.contextPath}/rest/platformpage/page" class="cs-navi-tab">平台宣传页管理</a></p>
			</div>
			<div title="版本更新" selected="false">
				<a href="javascript:void(0);" src="${pageContext.request.contextPath}/jsp/handheld/updateplatform/updateplatform.jsp" class="cs-navi-tab">版本更新</a></p>
			</div>
			<div title="建议管理" selected="false">
				<a href="javascript:void(0);" src="${pageContext.request.contextPath}/rest/addvice/page" class="cs-navi-tab">建议管理</a></p>
			</div>
			<div title="厂商管理" selected="false">
				<a href="javascript:void(0);" src="${pageContext.request.contextPath}/rest/appstore/page" class="cs-navi-tab">厂商管理</a></p>
			</div> --%>
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