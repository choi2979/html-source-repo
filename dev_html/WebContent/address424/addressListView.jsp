<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List, java.util.Map" %>
<%@ page import="orm.dao.SqlMapCommonDao" %>
<%
	List<Map<String,Object>> zdoList = null;
	SqlMapCommonDao cDao = new SqlMapCommonDao();
	zdoList = cDao.getZDOList(null);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Ajax실전 연습-[1: ajax, 2: html,html+js,js, 3:myBatis]</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-3.4.1.js"></script>
<style type="text/css">
	table{
		border: 3px solid #CCAAFF;
	}
	td{
		border: 3px solid #CCAAFF;
		text-align: center;
		height: 45px;
	}
</style>
<script type="text/javascript">
	function siguIN(){
		$("#i_sigu").change(function(){
			$("#i_sigu option:selected").each(function(){
				$("#sigu").val($(this).text());//this -> i_sigu
			});
		});
	}
</script>
</head>
<body>
<script type="text/javascript">
	$(document).ready(function(){
		$("#i_zdo").change(function(){
			$("#i_zdo option:selected").each(function(){
				var p_zdo = $(this).text();
				//alert("p_zdo:"+p_zdo);
				$("#zdo").val(p_zdo);
				var param ="zdo="+p_zdo;
				$.ajax({
					method:"post"
					,url:"getSiGuList.jsp?"+param
					,success:function(result){
						$("#d_sigu").html(result);
						siguIN();
					}
				});
			});
		});
	});
</script>
<table width="600" height="60" cellpadding="0" cellspacing="0">
	<tr>
		<td width="60">시도</td>
		<td width="140">
			<select id="i_zdo" style="width:120px">
				<option value="선택">선택</option>
<%
	for(int i=0;i<zdoList.size();i++){
		Map<String,Object> rmap = zdoList.get(i);
%>
				<option value="<%=rmap.get("ZDO")%>"><%=rmap.get("ZDO")%></option>
<% 
	}////////////////for
%>
			</select>
		</td>
		<td width="60">구</td>
		<td width="140">
			<div id="d_sigu" ></div>
		</td>
		<td width="60">동</td>
		<td width="140">
			<div id="d_dong"></div>
		</td>
	</tr>
	<tr>
		<td width="60">시도</td>
		<td width="140">
			<input type="text" id="zdo" name="zdo" size="12"/>
		</td>
		<td width="60">구</td>
		<td width="140">			
			<input type="text" id="sigu" name="sigu" size="12"/>
		</td>
		<td width="60">동</td>
		<td width="140">
			<input type="text" id="dong" name="dong" size="12"/>
		</td>
	</tr>
</table>
</body>
</html>