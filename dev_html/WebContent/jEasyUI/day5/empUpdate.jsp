<%@page import="com.google.gson.Gson"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="orm.dao.SqlMapEmpDao" %>
<%@ page import="java.util.*" %>
<%
	String empno = request.getParameter("empno");
	int iempno = 0;
	if(request.getParameter("empno")!=null){
		iempno = Integer.parseInt(empno);
	}
	String ename = "";
	ename = request.getParameter("ename");
	
	String job = "";
	job = request.getParameter("job");

	int mgr = 0;
	if(request.getParameter("mgr")!=null){
		mgr = Integer.parseInt(request.getParameter("mgr"));
	}
	String hiredate = "";
	hiredate = request.getParameter("hiredate");
	double sal = 0.0;
	if(request.getParameter("sal")!=null){
		sal = Double.parseDouble(request.getParameter("sal"));
	}
	double comm = 0.0;
	if(request.getParameter("comm")!=null){
		comm = Double.parseDouble(request.getParameter("comm"));
	}
	int deptno = 0;
	if(request.getParameter("deptno")!=null){
		deptno = Integer.parseInt(request.getParameter("deptno"));
	}
	
	SqlMapEmpDao eDao = new SqlMapEmpDao();
	int result = 0;
	Map<String,Object> pMap = new HashMap<>();
	pMap.put("empno",iempno);
	pMap.put("ename",ename);
	pMap.put("job",job);
	pMap.put("hiredate",hiredate);
	pMap.put("sal",sal);
	pMap.put("comm",comm);
	pMap.put("deptno",deptno);
	result = eDao.empUPD(pMap);
	out.print("result: "+result);
	//response.sendRedirect("EmpManagerVer6.jsp");
	if(result == 1){//등록 성공했을 때
		response.sendRedirect("EmpManagerVer8.jsp?mode=update");//페이지 열리기전 db경유함.
	}
	//등록 실패 했을 때
	else{
		response.sendRedirect("empInsertFail.jsp");
	}
%>