package project.restaurant;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.util.DBConnectionMgr;

public class RestaurantDao {
	DBConnectionMgr 	dbMgr 	= DBConnectionMgr.getInstance();
	Connection 			con 	= null;
	PreparedStatement 	pstmt 	= null;
	ResultSet			rs 		= null;
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
}
