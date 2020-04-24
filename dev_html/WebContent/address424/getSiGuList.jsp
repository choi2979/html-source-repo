<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List, java.util.Map, java.util.HashMap" %>
<%@ page import="orm.dao.SqlMapCommonDao" %>
<%@ page import="com.google.gson.Gson" %>
<%
	//DB연동 처리
	String zdo = request.getParameter("i_zdo");
	SqlMapCommonDao cDao = new SqlMapCommonDao();
	Map<String,Object> pmap = new HashMap<>();
	pmap.put("i_zdo",zdo);
	List<Map<String,Object>> siguList = null;
	siguList = cDao.getSiguList(pmap);
 
%>
	<select id="i_sigu" style="width:120px">
		<option value="선택">선택</option>
<%
	for(int i=0;i<siguList.size();i++){
		Map<String,Object> rmap = siguList.get(i);
%>
		<option value="<%=rmap.get("SIGU")%>"><%=rmap.get("SIGU")%></option>
<% 
	}
%>
	</select>
