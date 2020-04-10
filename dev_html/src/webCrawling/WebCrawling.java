package webCrawling;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

public class WebCrawling {
	void methodA() {
		try {
			//크롤링할 URL입력받기
			URL url = new URL("http://localhost:8000/day4/deptList2.jsp");
			InputStreamReader isr = new InputStreamReader(url.openStream());
			BufferedReader br = new BufferedReader(isr);//효율이 좋아짐
			String tags = null;
			StringBuilder sb = new StringBuilder();
			while((tags = br.readLine())!=null) {
				sb.append(tags);
			}
			br.close();
			//크롤링 시작 - 키(타이틀)
			List<String> titleList = new ArrayList<String>();
			String strs[] = sb.toString().split("<th>");//split-문자열을 분할
			for(int i=0;i<strs.length;i++) {
				System.out.println("strs["+i+"]==>"+strs[i]);
			}
			String strs2[] = null;
			for(int i=0;i<strs.length;i++) {
				strs2 = strs[i].split("</th>");
				titleList.add(strs2[0]);
			}
			for(String title:titleList) {
				System.out.println(title);
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
	}
	public static void main(String[] args) {
		WebCrawling wc = new WebCrawling();
		wc.methodA();

	}

}
