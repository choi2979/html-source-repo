<%@page import="com.google.gson.Gson"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="orm.dao.SqlMapEmpDao" %>
<%@ page import="java.util.*" %>
<%
	String empnoArr = request.getParameter("empno");//7899,9013,9011
	String empnos[] = null;
	if(empnoArr!=null){
		empnos = empnoArr.split(",");
	}
	SqlMapEmpDao eDao = new SqlMapEmpDao();
	int result = 0;
	result = eDao.empDEL(empnos);
	out.print("result: "+result);
	//response.sendRedirect("EmpManagerVer6.jsp");
	if(result > 0){//등록 성공했을 때
		response.sendRedirect("EmpManagerVer8.jsp?mode=update");//페이지 열리기전 db경유함.
	}
	//등록 실패 했을 때
	else{
		response.sendRedirect("empInsertFail.jsp");
	}
%>