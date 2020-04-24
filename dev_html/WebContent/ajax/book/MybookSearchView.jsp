<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>도서검색[자동완성+초성검사]</title>
<link rel="stylesheet" type="text/css" href="https://www.jeasyui.com/easyui/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="https://www.jeasyui.com/easyui/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="https://www.jeasyui.com/easyui/themes/color.css">
    <link rel="stylesheet" type="text/css" href="https://www.jeasyui.com/easyui/demo/demo.css">
    <!-- 순서: jquery api > easyui api > cookie -->
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="https://www.jeasyui.com/easyui/jquery.easyui.min.js"></script>
    <style type="text/css">
    	#d_search {
    		width: 300px;
    		height: 200px;
    		border: 1px solid black;
    		position: absolute;
    	}
    </style>
</head>
<body>
	<script type="text/javascript">
		$(document).ready(function (){
			$("#book_title").textbox({
				iconCls: 'icon-search'
				,handler: function(e){
					$(e.data.target).textbox('setValue', 'Something added!');
					}
			});
			$("#d_search").datagrid({
				columns:[[
					{field:'BOOK_NO', title:'번호', width:100}
					,{field:'BOOK_TITLE', title:'제목', width:300}
					,{field:'BOOK_IMG', title:'이미지', width:100}
					,{field:'BOOK_AUTHOR', title:'저자', width:100}
					,{field:'BOOK_PUBLISH', title:'출판사', width:100}
					,{field:'BOOK_DATE', title:'출판날짜', width:100}
					,{field:'BOOK_PRICE', title:'가격', width:100}
				]]
			});
		});
	</script>
	<input id="book_title">
	<div id="d_search"></div>
</body>
</html>