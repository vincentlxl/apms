<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>睦拍-应用内支付平台后台管理系统-</title>
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
	<h1>睦拍-应用内支付平台后台管理系统</h1>
	<div id="login-window" title='用户登录' class="easyui-window"
		style="width: 500px; height: 280px;" closable="false"
		minimizable="false" maximizable="false" collapsible="false">
		<div style="padding: 20px 20px 50px 80px;">
			<form method="post" id="loginForm" action="/dev/login.do">
				<table>
					<tr>
						<td align="right"><b id="codeId">用户名：</b></td>
						<td><input class="login" name="code" style="width: 150px;"></input></td>
					</tr>
					<tr id="channelTrId" style="display: none;">
						<td align="right"><b>渠道编号：</b></td>
						<td><input class="login" name="channelCode"
							style="width: 150px;"></input></td>
					</tr>
					<tr>
						<td align="right"><b>密&nbsp;&nbsp;&nbsp;码：</b></td>
						<td><input class="login" name="pwd" style="width: 150px;"
							type="password"></input></td>
					</tr>
					<tr>
						<td align="right"><b>角&nbsp;&nbsp;&nbsp;色：</b></td>
						<td><input name="type" value="app" checked="checked"
							type="radio" onClick="change();" />开发者 <input name="type"
							value="channel" type="radio" onClick="change();" />渠道</td>
					</tr>

				</table>
			</form>
		</div>
		<div style="padding: 5px; text-align: center;">
			<input type="button" value="登录" onClick="login();" /> <input
				type="button" value="注册" onClick="" />
		</div>
		<div style="padding: 5px; text-align: center; color: red;">
			为了获得更好的用户体验，建议使用火狐浏览器(<a
				href="http://www.firefox.com.cn/download/#more" target="_blank">下载</a>)
		</div>
	</div>
	<script>
		function change() {
			var ty = $('input:radio[name="type"]:checked').val();
			$("#codeId").html("用户名：");
			$("#channelTrId").attr("style", "display: none;");
			if (ty == 'channel') {
				$("#channelTrId").removeAttr("style");//style="display: none;"
				$("#codeId").html("开发者编号：");
			}
		}
		function login() {
			var formobj = $('#loginForm')[0];
			var ty = $('input:radio[name="type"]:checked').val();
			var url = "/dev/ad/login.do";
			if (ty == 'channel') {
				url = "/dev/devChannel/login.do";
			} else if (ty == 'app') {
				url = "/dev/dev/login.do";
			}
			$
					.ajax({
						type : "POST",
						url : url,
						data : postParamsJsonForm(formobj),
						timeout : 30000,
						async : false,
						cache : false,
						success : function(responseJsonText, textStatus, xhr) {
							try {
								var responseJson = eval("(" + responseJsonText
										+ ")");
								console.log(responseJson);
								if (responseJson.status == "ok") {
									if (ty == 'app') {
										if (responseJson.isNewUser) {
											window.location = '/dev/dev2.0/index.jsp';
										} else {
											window.location = '/dev/dev/main.jsp';
										}
									} else if (ty == 'channel') {
										if (responseJson.isNewUser) {
											window.location = '/dev/devChannel2.0/index.jsp';
										} else {
											window.location = '/dev/devChannel/main.jsp';
										}
									}
								} else {
									$.messager.alert('错误', '用户名或密码错误', 'error');
								}
							} catch (exception) {
								throw exception;
								return;
							}
						}
					});

		}
		function reload(url) {
			var timenow = new Date().getTime();
			document.images['imageCode1'].src = url + "?d=" + timenow;
		}

		change();
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