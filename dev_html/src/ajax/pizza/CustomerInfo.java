package ajax.pizza;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

public class CustomerInfo {

	public static void main(String[] args) {
		List<Map<String,Object>> cusList = new ArrayList<>();
		Map<String,Object> rMap = new HashMap<>();
		rMap.put("mem_name", "이순신");
		rMap.put("mem_addr", "서울시 마포구 공덕동");
		rMap.put("mem_tel", "0255559999");
		cusList.add(rMap);
		rMap = new HashMap<String, Object>();
		rMap.put("mem_name", "김유신");
		rMap.put("mem_addr", "서울시 금천구 가산동");
		rMap.put("mem_tel", "0244488889");
		cusList.add(rMap);
		rMap = new HashMap<String, Object>();
		rMap.put("mem_name", "하하");
		rMap.put("mem_addr", "서울시 금천구 독산동");
		rMap.put("mem_tel", "0244411113");
		cusList.add(rMap);
		Gson g = new GsonBuilder().setPrettyPrinting().create();
		String json = g.toJson(cusList);
		System.out.println(json);

	}

}
