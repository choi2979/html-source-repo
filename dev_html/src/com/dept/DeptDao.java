package com.dept;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.util.DBConnectionMgr;

public class DeptDao {
	DBConnectionMgr 	dbMgr 	= null;
	Connection 			con 	= null;
	PreparedStatement 	pstmt 	= null;
	ResultSet 			rs 		= null;
	public List<Map<String, Object>> deptList(){
		dbMgr = DBConnectionMgr.getInstance();
		List<Map<String, Object>> dlist = null;
		StringBuilder sql = new StringBuilder();
		try {
			sql.append("SELECT deptno, dname, loc FROM dept");
			con = dbMgr.getConnection();
			pstmt = con.prepareStatement(sql.toString());
			rs = pstmt.executeQuery();
			//parsing-DBMS 실행계획-옵티마이저-Open..Fetch..Close
			//세개 컬럼은 Map에 담고 여러개의 로우는 List담기
			dlist = new ArrayList<Map<String,Object>>();
			Map<String, Object> rMap = null;
			while(rs.next()) {
				rMap = new HashMap<>();
				rMap.put("deptno", rs.getInt("deptno"));
				rMap.put("dname", rs.getString("dname"));
				rMap.put("loc", rs.getString("loc"));
				dlist.add(rMap);//컬럼 3개가, 로우 한개가
			}
			System.out.println(dlist.size());
		} catch (SQLException se) {
			System.out.println("[[query]]"+sql.toString());
		} catch (Exception e) {
			System.out.println("[[Excption]]"+e.toString());
		}
		finally {
			dbMgr.freeConnection(con, pstmt, rs);
		}
		return dlist;
	}
	
	public List<DeptVO> deptVOList(){
		dbMgr = DBConnectionMgr.getInstance();
		List<DeptVO> dlist = null;
		StringBuilder sql = new StringBuilder();
		try {
			sql.append("SELECT deptno, dname, loc FROM dept");
			con = dbMgr.getConnection();
			pstmt = con.prepareStatement(sql.toString());
			rs = pstmt.executeQuery();
			//parsing-DBMS 실행계획-옵티마이저-Open..Fetch..Close
			//세개 컬럼은 Map에 담고 여러개의 로우는 List담기
			dlist = new ArrayList<>();
			DeptVO dVO = null;
			while(rs.next()) {
				dVO = new DeptVO();
				dVO.setDeptno(rs.getInt("deptno"));
				dVO.setDname(rs.getString("dname"));
				dVO.setLoc(rs.getString("loc"));
				dlist.add(dVO);//컬럼 3개가, 로우 한개가
			}
			System.out.println(dlist.size());
			sql.append("SELECT deptno, dname, loc FROM dept");
		} catch (SQLException se) {
			System.out.println("[[query]]"+sql.toString());
		} catch (Exception e) {
			System.out.println("[[Excption]]"+e.toString());
		}
		finally {
			dbMgr.freeConnection(con, pstmt, rs);
		}
		return dlist;
	}
}
