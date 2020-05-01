package orm.dao;

import java.io.Reader;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.apache.log4j.Logger;

public class SqlMapCommonDao {
	Logger logger = Logger.getLogger(SqlMapCommonDao.class);
	SqlSessionFactory sqlMapper = null;
	/*********************************************************************
	 * 주소 검색 - 도 정보 조회하기
	 * @param pmap
	 * @return List<Map<String, Object>>
	 * 업무설명:  
	 * 작성자: 최승종
	 * 2020년 04월 24일
	 **********************************************************************/
	public List<Map<String, Object>> getZDOList(Map<String,Object> pmap) {
		logger.info("getZDOList 호출 성공");
		List<Map<String, Object>> zdoList = null;
		String resource = "orm/mybatis/Configuration.xml";
		try {
			Reader reader = Resources.getResourceAsReader(resource);
			sqlMapper = new SqlSessionFactoryBuilder().build(reader);
			//sql문을 요청하기 위한 SqlSession객체 생성하기
			SqlSession sqlSes = sqlMapper.openSession();
			zdoList = sqlSes.selectList("getZDOList",pmap);
			System.out.println("조회한 로우 수: "+zdoList.size());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return zdoList;
	}
	/*********************************************************************
	 * 주소 검색 - 구에 대한 정보 조회하기
	 * @param pmap
	 * @return List<Map<String, Object>>
	 * 업무설명:  
	 * 작성자: 최승종
	 * 2020년 04월 24일
	 **********************************************************************/
	public List<Map<String, Object>> getSiGuList(Map<String,Object> pmap) {
		logger.info("getSiGuList 호출 성공"+pmap.get("zdo"));
		List<Map<String, Object>> siguList = null;
		String resource = "orm/mybatis/Configuration.xml";
		try {
			Reader reader = Resources.getResourceAsReader(resource);
			sqlMapper = new SqlSessionFactoryBuilder().build(reader);
			//sql문을 요청하기 위한 SqlSession객체 생성하기
			SqlSession sqlSes = sqlMapper.openSession();
			siguList = sqlSes.selectList("getSiGuList",pmap);
			System.out.println("조회한 로우 수: "+siguList.size());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return siguList;
	}
	/*********************************************************************
	 * 주소 검색 - 동에 대한 정보 조회하기
	 * @param pmap
	 * @return List<Map<String, Object>>
	 * 업무설명:  
	 * 작성자: 최승종
	 * 2020년 04월 24일
	 **********************************************************************/
	public List<Map<String, Object>> getDongList(Map<String,Object> pmap) {
		logger.info("getZDOList 호출 성공");
		List<Map<String, Object>> dongList = null;
		return dongList;
	}
	/*********************************************************************
	 * 주소 검색 - 우편번호 조회하기
	 * @param pmap pmap.get("dong")
	 * @return List<Map<String, Object>>
	 * 업무설명: 동이름을 입력하면 조건 검색을 통하여 구간검색 처리하기
	 * 작성자: 최승종
	 * 2020년 04월 27일
	 **********************************************************************/
	public List<Map<String, Object>> getZipcode(Map<String,Object> pmap) {
		logger.info("getZipcode 호출 성공 "+pmap.get("dong"));
		List<Map<String, Object>> zipcode = null;
		String resource = "orm/mybatis/Configuration.xml";
		try {
			Reader reader = Resources.getResourceAsReader(resource);
			sqlMapper = new SqlSessionFactoryBuilder().build(reader);
			//sql문을 요청하기 위한 SqlSession객체 생성하기
			SqlSession sqlSes = sqlMapper.openSession();
			zipcode = sqlSes.selectList("getZipcode",pmap);
			System.out.println("조회한 로우 수: "+zipcode.size());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return zipcode;
	}
}
