<%@page import="com.google.gson.Gson"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	com.dept.DeptDao ddao = new com.dept.DeptDao();
	java.util.List<java.util.Map<String,Object>> dlist = null;
	dlist = ddao.deptList();
	Gson g = new Gson();
	String imsi = g.toJson(dlist);
	out.print(imsi);
%>