package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public UserDAO() {
		try {
	         String dbURL = "jdbc:mysql://database1.chfhjyvwugph.ap-northeast-2.rds.amazonaws.com/database1";
	         String dbID = "root";
	         String dbPassword = "Thsguswns";
	         Class.forName("com.mysql.cj.jdbc.Driver");
	         conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
	      } catch(Exception e) {
	         e.printStackTrace();
	      } 
	}
	
	public int login(String userID, String userPassword) {
		String SQL = "SELECT userPassword FROM user WHERE userID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword)) {
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
	
	public int join(User user) {
		String SQL = "INSERT INTO user VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserGender());
			pstmt.setString(5, user.getUserBirth());
			pstmt.setString(6, user.getUserUniversity());
			pstmt.setString(7, user.getUserMajor());
			pstmt.setString(8, user.getUserPhone());
			pstmt.setString(9, user.getUserEmail());
			pstmt.setString(10, user.getUserAddress());
			pstmt.setInt(11, user.getUserAdmin());
			return pstmt.executeUpdate();
		} catch (Exception e) {
			// TODO: handle exception
		}
		return -1;
	}
}