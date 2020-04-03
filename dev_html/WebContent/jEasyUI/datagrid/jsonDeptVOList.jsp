<%@page import="com.google.gson.Gson"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	com.dept.DeptDao ddao = new com.dept.DeptDao();
	java.util.List<com.dept.DeptVO> dlist = null;
	dlist = ddao.deptVOList();
	Gson g = new Gson();
	String imsi = g.toJson(dlist);
	out.print(imsi);
%>