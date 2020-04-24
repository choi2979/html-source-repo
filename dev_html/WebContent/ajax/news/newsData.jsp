<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%!
//디클러레이션 - 전역변수이다.
//싱글톤으로 관리(서블릿-newsData_jsp.java=>HttpServlet- 이 객체는 계속 유지됨-새로고침을 당해도.)
	int x = 1;//전역변수
	public String newsList(String news[]){
		//자바성능튜닝팀 지적사항 - 삼성SDS - 지방공개 정보시스템
		StringBuilder sb = new StringBuilder();
		sb.append("<table width='500px' border='1'>");
		sb.append("<tr><td>"+news[0]+" > "+news[1]+"</td></tr>");
		sb.append("</table>");
		return sb.toString();
	}
%>
<%
//스크립틀릿- 메소드 선언 불가
	String news1[] = {"정총리 사회적 거리두기 완화, 세심한 방역조치 뒷받침돼야","김승두"};
	String news2[] = {"초등 1∼3학년 오늘 온라인개학…초중고 540만명 원격수업 시대","이효석"};
	String news3[] = {"유재석, 저소득층 여학생 생리대 지원 5천만원 기부","송은경"};
	String news4[] = {"친서 받았다는 트럼프·안 보냈다는 북한…누구 말이 맞나","백나리"};
	String news5[] = {"코로나19 어제 13명 증가·총 1만674명…서울 신규확진 0명","최인영"};
	//화며에내보내 질 코드 담기
	String datas = "";
	switch(x){
	case 1:
		datas= newsList(news1);
		x++;
		break;
	case 2:
		datas= newsList(news2);
		x++;
		break;
	case 3:
		datas= newsList(news3);
		x++;
		break;
	case 4:
		datas= newsList(news4);
		x++;
		break;
	case 5:
		datas= newsList(news5);
		x=1;
		break;
	}
	out.clear();
	out.print(datas);
%>