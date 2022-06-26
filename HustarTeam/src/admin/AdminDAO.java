package admin;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class AdminDAO {

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	public AdminDAO() {
		try {
			String dbURL = "jdbc:mysql://database1.chfhjyvwugph.ap-northeast-2.rds.amazonaws.com/database1";
			String dbID = "root";
			String dbPassword = "Thsguswns";
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	//---------------------------------------------
	public int login(String admin_id, String admin_pw) {
		String SQL = "SELECT admin_pw FROM admin WHERE admin_id = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, admin_id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(admin_pw)) {
					System.out.println("로그인 성공!!");
					return 1;
				} else {
					System.out.println("로그인 실패");
					return 0;
				}
			}
			System.out.println("아이디 없음");
			return -1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("데이터베이스 오류");
		return -2;
	}
	//------------------------------------------

}
