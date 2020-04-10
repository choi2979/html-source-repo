package project.restaurant;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.JDBCType;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.util.DBConnectionMgr;

import oracle.jdbc.OracleCallableStatement;//오라클 회사가 지원함.
import oracle.jdbc.OracleTypes;

public class RestaurantDao {
	DBConnectionMgr 	dbMgr 	= DBConnectionMgr.getInstance();
	Connection 			con 	= null;
	PreparedStatement 	pstmt 	= null;
	ResultSet			rs 		= null;
	CallableStatement	cstmt	= null;
	//
	OracleCallableStatement ocstmt = null;
	//프로시저를 활용하여 로그인 처리하기
	/***************************************************************************
	 * @param mem_id :사용자가 입력한 아이디
	 * @param mem_pw :사용자가 입력한 비번
	 * @return : proc_login2020(u_id IN varchar2, u_pw IN varchar2, msg OUT varchar2)
	 *************************************************************************/
	public String login(String mem_id, String mem_pw) {
		String msg = null;
		int result = 0;
		try {
			con = dbMgr.getConnection();
			cstmt = con.prepareCall("{ call proc_login2020(?,?,?) }");
			cstmt.setString(1, mem_id);
			cstmt.setString(2, mem_pw);
			cstmt.registerOutParameter(3, OracleTypes.VARCHAR);//OUT속성 일때만
			//cstmt.execute();//boolean
			result = cstmt.executeUpdate();//int
			msg = cstmt.getString(3);
			System.out.println("result: "+result+", msg:"+msg);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return msg;
	}
	public List<Map<String, Object>> procRestList(){
		List<Map<String,Object>> rList = null;
		try {
			//오라클사가 배포하는 드라이버 클래스를 스캔함.
			con = dbMgr.getConnection();//물리적으로 떨어져 있는 서버에 연결통로 확보
			//DML을 요청할 땐 PreparedStatement
			//프로시저를 요청할땐 Callable"Statement
			cstmt = con.prepareCall("{ call proc_restaurant(?)}");
			//프로시저의 OUT속송을 지정함.
			cstmt.registerOutParameter(1, OracleTypes.CURSOR);
			cstmt.execute();//오라클에 살고 있는 옵티마이저에게 처리해주세요.
			ocstmt = (OracleCallableStatement)cstmt;
			rs = ocstmt.getCursor(1);
			rList = new ArrayList<>();
			Map<String,Object> rMap = null;
			while(rs.next()) {
				rMap = new HashMap<>();
				rMap.put("res_num", rs.getInt("res_num"));
				rMap.put("res_name", rs.getString("res_name"));
				rMap.put("res_tell", rs.getString("res_tell"));
				rMap.put("res_addr", rs.getString("res_addr"));
				rMap.put("res_hate", rs.getInt("res_hate"));
				rMap.put("res_like", rs.getInt("res_like"));
				rMap.put("res_photo", rs.getString("res_photo"));
				rMap.put("res_info", rs.getString("res_info"));
				rMap.put("res_time", rs.getString("res_time"));
				rMap.put("lat", rs.getDouble("lat"));
				rMap.put("lng", rs.getDouble("lng"));
				rList.add(rMap);
			}
			System.out.println(rList.size());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return rList;
	}
	public List<Map<String, Object>> restList(){
		List<Map<String,Object>> rList = null;
		StringBuilder sql = new StringBuilder();
		sql.append("SELECT res_num, res_name, res_tell, res_addr, res_hate");
		sql.append(" ,res_like, res_photo, res_info, res_time, lat, lng FROM restaurant");
		try {
			con = dbMgr.getConnection();
			pstmt = con.prepareStatement(sql.toString());
			rs = pstmt.executeQuery();
			rList = new ArrayList<>();
			Map<String,Object> rMap = null;
			while(rs.next()) {
				rMap = new HashMap<>();
				rMap.put("res_num", rs.getInt("res_num"));
				rMap.put("res_name", rs.getString("res_name"));
				rMap.put("res_tell", rs.getString("res_tell"));
				rMap.put("res_addr", rs.getString("res_addr"));
				rMap.put("res_hate", rs.getInt("res_hate"));
				rMap.put("res_like", rs.getInt("res_like"));
				rMap.put("res_photo", rs.getString("res_photo"));
				rMap.put("res_info", rs.getString("res_info"));
				rMap.put("res_time", rs.getString("res_time"));
				rMap.put("lat", rs.getDouble("lat"));
				rMap.put("lng", rs.getDouble("lng"));
				rList.add(rMap);
			}
			System.out.println(rList.size());
		} catch (SQLException se) {
			System.out.println("[[Query]]:"+sql.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return rList;
	}
	public List<Map<String, Object>> mapRestList(){
		List<Map<String,Object>> mrList = null;
		StringBuilder sql = new StringBuilder();
		sql.append("SELECT res_name, res_photo, lat, lng FROM restaurant");
		try {
			con = dbMgr.getConnection();
			pstmt = con.prepareStatement(sql.toString());
			rs = pstmt.executeQuery();
			mrList = new ArrayList<>();
			Map<String,Object> rMap = null;
			while(rs.next()) {
				rMap = new HashMap<>();
				rMap.put("res_name", rs.getString("res_name"));
				rMap.put("res_photo", rs.getString("res_photo"));
				rMap.put("lat", rs.getDouble("lat"));
				rMap.put("lng", rs.getDouble("lng"));
				mrList.add(rMap);
			}
			System.out.println(mrList.size());
		} catch (SQLException se) {
			System.out.println("[[Query]]:"+sql.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mrList;
	}
	
	public int restINS(Map<String, Object> pMap) {
		int result = 0;
		StringBuilder sql = new StringBuilder();
		sql.append("INSERT INTO restaurant(res_num, res_name, res_tell, res_addr, res_hate, res_like, res_photo, res_info ");
		sql.append("	    ,res_time, lat, lng)                                                                          ");
		sql.append("	VALUES(seq_restaurant_num.nextval,?,?,?,0,0,?,?,?,?,?)                                                    ");
		try {
			con = dbMgr.getConnection();
			pstmt = con.prepareStatement(sql.toString());
			int i = 0;
			pstmt.setString(++i, pMap.get("res_name").toString());
			pstmt.setString(++i, pMap.get("res_tell").toString());
			pstmt.setString(++i, pMap.get("res_addr").toString());
			pstmt.setString(++i, pMap.get("res_photo").toString());
			pstmt.setString(++i, pMap.get("res_info").toString());
			pstmt.setString(++i, pMap.get("res_time").toString());
			pstmt.setDouble(++i, Double.parseDouble(pMap.get("lat").toString()));
			pstmt.setDouble(++i, Double.parseDouble(pMap.get("lng").toString()));
			result = pstmt.executeUpdate();
			System.out.println("result: "+result);
		} catch (SQLException se) {
			System.out.println("[[Query]]:"+sql.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	public static void main(String args[]) {
		RestaurantDao rdao = new RestaurantDao();
		//rdao.procRestList();
		String msg = rdao.login("test", "123");
		System.out.println("msg:"+msg);
	}
}
