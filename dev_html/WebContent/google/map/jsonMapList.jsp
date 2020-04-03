<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="project.restaurant.RestaurantDao" %>
<%@ page import="java.util.*, com.google.gson.Gson" %>
<%
	RestaurantDao rDao = new RestaurantDao();
	List<Map<String,Object>> mrList = rDao.mapRestList();
	Gson g = new Gson();
	String imsi = g.toJson(mrList);
	out.print(imsi);
%>