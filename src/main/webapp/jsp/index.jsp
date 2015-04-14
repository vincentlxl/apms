<%@ page import="java.util.Random" pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
	Random random = new Random();
	String randomCode = (Math.abs(random.nextInt()) + "0000").substring(0, 4);
	System.out.println("睦拍-应用内支付平台后台管理系统登录，验证码：" + randomCode);
	session.setAttribute("randomCode", randomCode);
	String pageid = Math.abs(random.nextInt()) + "";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<title>睦拍-应用内支付平台后台管理系统</title>
<link type="text/css" rel="styleSheet"
	href="<%=path%>/easyui/themes/default/easyui.css">
<link type="text/css" rel="styleSheet"
	href="<%=path%>/easyui/themes/icon.css">
<link type="text/css" rel="styleSheet" href="<%=path%>/css/login.css">
<script type="text/javascript" src="<%=path%>/easyui/jquery.min.js"></script>
<script type="text/javascript"
	src="<%=path%>/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript"
	src="<%=path%>/easyui/easyui-lang-zh_CN.js"></script>
</head>
<body>
	<h1>睦拍-应用内支付平台后台管理系统<sup>V3.0.0</sup></h1>
	<div id="login-window" title='用户登录' class="easyui-window"
		style="width: 450px; height: 280px;" closable="false"
		minimizable="false" maximizable="false" collapsible="false">
		<div style="padding: 20px 20px 50px 80px;">
			<form method="post" id="loginForm" action="<%=path%>/home/login.do">
				<table>
					<tr>
						<td align="right"><b id="codeId">用户名：</b></td>
						<td><input class="easyui-validatebox" name="username" style="width: 150px;" required="true"></input></td>
					</tr>
					<tr>
						<td align="right"><b>密&nbsp;&nbsp;&nbsp;码：</b></td>
						<td><input class="easyui-validatebox" name="password" style="width: 150px;" required="true"
							type="password"></input></td>
					</tr>
					<tr>
						<td align="right"><b>验证码：</b></td>
						<td><input class="easyui-validatebox" name="randomcode" style="width: 150px;" required="true"><img src="<%=path%>/textBufferedImage?pageId=<%=pageid%>" onclick="refresh('<%=path%>');" /></td>
					</tr>
				</table>
			</form>
		</div>
		<div style="padding: 5px; text-align: center;">
			<input type="button" value="登录" onClick="login();" /> 
			<input type="button" value="个人注册" onClick="" />
			<input type="button" value="企业注册"/>
		</div>
		<!-- <div style="padding: 5px; text-align: center; color: red;">
			为了获得更好的用户体验，建议使用火狐浏览器(<a href="http://www.firefox.com.cn/download/#more" target="_blank">下载</a>)
		</div> -->
	</div>
	<script>
		var url = document.forms[0].action;
		function refresh(path) 
		{
			document.forms[0].action = path;
			document.getElementById("loginForm").submit();
		}
		function login() {
			$('#loginForm').form('submit',{
		         url: url,
		         onSubmit:function(){
		 			return $(this).form('validate');
		 		 },
		         success: function(result){  
		             var result = eval('('+result+')');
		             if (result.success){  
		             	 $.messager.alert('提示', '操作成功');
		             	 window.location='<%=path%>/home/main.do';
		             }
		             else { 
				   		$.messager.alert('提示', result.errorMsg);
		             } 
		         }  
		     });
		}
		$(function() {
			$('.login').bind('keypress', function(event) {
				if (event.keyCode == "13") {
					login();
				}
			});
		});
	</script>
</body>
</html>