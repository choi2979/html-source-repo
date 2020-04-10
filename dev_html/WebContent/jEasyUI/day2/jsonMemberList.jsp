<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="easyui.member.MemberDAO, java.util.List, java.util.Map" %>
<%@ page import="com.google.gson.Gson" %>
<%
	MemberDAO mdao = new MemberDAO();
	List<Map<String, Object>> mList = null;
	mList = mdao.memberList();
	Gson g = new Gson();
	String imsi = g.toJson(mList);
	out.print(imsi);
%>