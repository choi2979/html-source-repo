package orm.dao;

import java.io.Reader;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.apache.log4j.Logger;

public class SqlBookDao {
	Logger logger = Logger.getLogger(SqlBookDao.class);//어디에다가 해줄까?
	SqlSessionFactory sqlMapper = null;
	String resource = "orm/mybatis/Configuration.xml";
	/********************************************************************
	 * 도서정보 조회하기 구현
	 * @param pMap - 사용자가 자동완성 textbox에 입력한 도서제목 정보
	 * @return - 사용자가 입력한 도서정보를 선분조건(Like패턴)으로 검색하여 결과 반환
	 */
	public List<Map<String,Object>> bookList(Map<String,Object> pMap){
		logger.info("book_title: "+pMap.get("book_title")+", choMode: "+pMap.get("choMode"));
		//23번에서 선언만 되어 있다. 따라서 검색 결과가 존재하지 않을 경우 NullpointerException의
		//원인이 될 수도 있다.
		//가급적이면 에러를 피해 갈 수 있도록 코딩을 전개한다.
		logger.info("bookList 호출성공");
		List<Map<String,Object>> blist = new ArrayList<>();
		try {
			Reader reader = Resources.getResourceAsReader(resource);
			sqlMapper = new SqlSessionFactoryBuilder().build(reader);
			SqlSession sqlSes = sqlMapper.openSession();
			blist = sqlSes.selectList("bookList",pMap);
			logger.info("blist.size() ===>"+blist.size());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return blist;
	}
	public static void main(String[] args) {
		SqlBookDao bDao = new SqlBookDao();
		bDao.bookList(null);
	}
}
