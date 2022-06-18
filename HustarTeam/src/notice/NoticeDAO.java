package notice;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class NoticeDAO {
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public NoticeDAO() {
		try {
			String dbURL = "jdbc:mariadb://localhost:3306/BBS";
			String dbID = "root";
			String dbPassword = "root";
			Class.forName("org.mariadb.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public String getDate() { //현재서버의 시간을 가져오는 클래스
		String SQL = "SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ""; //디비오류
	}

	
	public int getNext() { //현재서버의 시간을 가져오는 클래스
		String SQL = "SELECT noticeID FROM notice ORDER BY noticeID DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1;//첫번째 게시물인경우
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //디비오류
	}
	
	public int noticeWrite(String noticeTitle, String userID, String noticeContent) {
		String SQL = "INSERT INTO NOTICE VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, noticeTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, noticeContent);
			pstmt.setInt(6, 1);
			pstmt.setString(7, " ");//파일 너을때
			pstmt.setInt(8, 0);
			pstmt.setString(9, " ");//파일 실제이름
		
			return pstmt.executeUpdate();
		
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //디비오류
	}
	
	public ArrayList<Notice> getList(int pageNumber){
		String SQL = "SELECT * FROM NOTICE WHERE noticeID < ? AND noticeAvailable = 1 ORDER BY noticeID DESC LIMIT 10";
		ArrayList<Notice> list = new ArrayList<Notice>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber -1) * 10);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Notice notice = new Notice();
				notice.setNoticeID(rs.getInt(1));
				notice.setNoticeTitle(rs.getString(2));
				notice.setCreateDate(rs.getString(3));
				notice.setNoticeAvailable(rs.getInt(4));
				notice.setNoticeContent(rs.getString(5));
				notice.setUserID(rs.getString(6));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list; //디비오류
	}
}
