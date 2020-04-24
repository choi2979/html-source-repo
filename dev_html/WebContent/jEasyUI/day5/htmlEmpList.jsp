<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="orm.dao.SqlMapEmpDao" %>
<%@ page import="java.util.*" %>
<%
	SqlMapEmpDao edao = new SqlMapEmpDao();
	List<Map<String,Object>> elist = edao.empList(null);
%>
<table>
<%
//조회 결과가 없을 때
	if(elist==null){
		
%>
	<tr>
		<td>조회결과가 없습니다.</td>
	</tr>
<% 
//조회 결과가 있을 때	
	} else{
		for(int i=0; i<elist.size();i++){
			Map<String,Object> rmap = elist.get(i);
%>	
	<tr>
		<td><%out.print(rmap.get("ENAME")); %></td>
	</tr>
<%
		}////////////for
	}//////////end of else
%>
</table>