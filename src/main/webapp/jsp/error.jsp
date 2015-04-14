<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>后台管理系统</title>
	<jsp:include flush="true" page="/jsp/common/script_include_easyui.jsp"></jsp:include>
</head>
<body>
	<div id="w" class="easyui-window" title="系统异常" data-options="iconCls:'icon-save',minimizable:false,maximizable:false,collapsible:false" style="width:500px;height:200px;padding:10px;">
		<b>${errorMsg}</b>
	</div>
</body>
</html>