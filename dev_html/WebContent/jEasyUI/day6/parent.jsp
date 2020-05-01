<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="../day5/JEasyUICommon.jsp" %>
<script type="text/javascript" src="../../js/commons.js"></script>
</head>
<body>
<table id="dg" class="easyui-datagrid" title="데이터출력방법 종류">
	<thead>
		<tr><th data-options="field:'name', width:150">이름</th></tr>
	</thead>
	<tbody>
		<tr><td width="150"><% out.print("이성계"); %></td></tr>
	</tbody>
</table>
<table border="1" title="데이터출력방법 종류" style="width:600px;">
	<thead>
		<tr><th>이름</th><th>주소</th></tr>
	</thead>
	<tbody>
		<tr>
		<td width="150"><% out.print("이성계"); %></td>
		<td>주소</td>
		</tr>
	</tbody>
</table>
</body>
</html>