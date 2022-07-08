package attendance;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class AttendanceDAO {

	
	private Connection conn; //커넥션 객체생성
	private PreparedStatement pstmt; // 프리페얼드 스테이트먼트 sql을 실행할수있는객체 쿼리에 인자부여가능
	private ResultSet rs;
	
	public AttendanceDAO() {
		try {
			String dbURL = "jdbc:mysql://database1.chfhjyvwugph.ap-northeast-2.rds.amazonaws.com/database1";
			String dbID = "root";
			Class.forName("com.mysql.cj.jdbc.Driver");
			String dbPassword = "Thsguswns";
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	
	
	
}
