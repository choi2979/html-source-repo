package easyui.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.util.DBConnectionMgr;
/*
 * DML(기본) - 프로시저 - MyBatis[ORM솔루션-30%이상 줄어듬]
 */
public class MemberDAO {
	//회원목록 조회 실습1 - SELECT문
	DBConnectionMgr dbMgr = DBConnectionMgr.getInstance();
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	public List<Map<String, Object>> memberList(){
		List<Map<String, Object>> mList = null;
		StringBuilder sql = new StringBuilder();
		sql.append("SELECT mem_no, mem_id, mem_pw, mem_name, zipcode, mem_addr, mem_email FROM member_t ");
		try {
			con = dbMgr.getConnection();
			pstmt = con.prepareStatement(sql.toString());
			rs = pstmt.executeQuery();
			mList = new ArrayList<>();
			Map<String, Object> mMap = null;
			while(rs.next()) {
				mMap = new HashMap<>();
				mMap.put("mem_no", rs.getInt("mem_no"));
				mMap.put("mem_id", rs.getString("mem_id"));
				mMap.put("mem_pw", rs.getString("mem_pw"));
				mMap.put("mem_name", rs.getString("mem_name"));
				mMap.put("zipcode", rs.getString("zipcode"));
				mMap.put("mem_addr", rs.getString("mem_addr"));
				mMap.put("mem_email", rs.getString("mem_email"));
				mList.add(mMap);
			}
			
		} catch (SQLException se) {
			System.out.println("[[Query]]:"+sql.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return mList;
	}
	public int memberInsert() {
		int result = 0;
		StringBuilder sql = new StringBuilder();
		sql.append("INSERT INTO member_t(mem_no, mem_id, mem_pw, mem_name, zipcode, mem_addr, mem_email) ");
		sql.append("    VALUES(?,?,?,?,?,?,?) ");
		try {
			con = dbMgr.getConnection();
			pstmt = con.prepareStatement(sql.toString());
			int i = 0;
			pstmt.setInt(++i, 5);
			pstmt.setString(++i, "gg");
			pstmt.setString(++i, "123");
			pstmt.setString(++i, "21538");
			pstmt.setString(++i, "이황");
			pstmt.setString(++i, "인천시 남동구");
			pstmt.setString(++i, "gg@google.com");
			result = pstmt.executeUpdate();
		} catch (SQLException se) {
			System.out.println("[[Query]]:"+sql.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	public int memberUpdate() {
		int result = 0;
		StringBuilder sql = new StringBuilder();
		sql.append("UPDATE member_t SET mem_name =?, zipcode =? WHERE mem_no = ?");
		try {
			con = dbMgr.getConnection();
			pstmt = con.prepareStatement(sql.toString());
			int i = 0;
			pstmt.setString(++i, "gugu");
			pstmt.setString(++i, "21567");
			pstmt.setInt(++i, 5);
			result = pstmt.executeUpdate();
		} catch (SQLException se) {
			System.out.println("[[Query]]:"+sql.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	public int memberDelete() {
		int result = 0;
		StringBuilder sql = new StringBuilder();
		sql.append("DELETE FROM member_t WHERE mem_no = ?");
		try {
			con = dbMgr.getConnection();
			pstmt = con.prepareStatement(sql.toString());
			int i = 0;
			pstmt.setInt(++i, 4);
			result = pstmt.executeUpdate();
		} catch (SQLException se) {
			System.out.println("[[Query]]:"+sql.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	//회원목록 조회 실습2 - 프로시저
	
	
	public static void main(String[] args) {
		MemberDAO mdao = new MemberDAO();
		List<Map<String, Object>> mList = null;
		mList = mdao.memberList();
		if(mList != null) {
			System.out.println("mList.size() ===> "+mList.size());
		}
		
		int result3 = mdao.memberDelete();
		if(result3 == 1) {
			System.out.println("성공");
		}
		else {
			System.out.println("실패");
		}

	}

}
