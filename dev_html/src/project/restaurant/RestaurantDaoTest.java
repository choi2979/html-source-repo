package project.restaurant;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;

class RestaurantDaoTest {
	RestaurantDao rdao = new RestaurantDao();
	@Test
	void testProcRestList() {
		assertEquals(5,rdao.procRestList().size());
	}

}
