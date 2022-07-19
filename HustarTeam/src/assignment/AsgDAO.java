package assignment;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class AsgDAO {

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	public AsgDAO() {
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

	public int upload(String fileName, String fileRealName) {
		String SQL = "INSERT INTO assignment VALUES (?, ?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(6, fileName);
			pstmt.setString(7, fileRealName);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("파일 업로드 실패");
		}
		return -1;
	}

	public String getDate() { // 현재서버의 시간을 가져오는 클래스
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
		return ""; // 디비오류
	}

	public int getNext() {
		String SQL = "SELECT asgID FROM assignment ORDER BY asgID DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1;// 첫번째 게시물인경우
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 디비오류
	}

	public int asgWrite(String asgTitle, String userID, String asgContent, String fileName, String fileRealName) {
		String SQL = "INSERT INTO assignment VALUES (?, ?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, userID);
			pstmt.setString(3, asgTitle);
			pstmt.setString(4, getDate());
			pstmt.setString(5, asgContent);
			pstmt.setString(6, fileName);// 파일 넣을때
			pstmt.setString(7, fileRealName);// 파일 실제이름

			return pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 디비오류
	}

	public ArrayList<Asg> getList(int pageNumber) {
		String SQL = "SELECT * FROM assignment WHERE asgID < ? ORDER BY asgID DESC LIMIT 5";
		ArrayList<Asg> list = new ArrayList<Asg>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 5);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Asg assignment = new Asg();
				assignment.setAsgID(rs.getInt(1));
				assignment.setUserID(rs.getString(2));
				assignment.setAsgTitle(rs.getString(3));
				assignment.setAsgDate(rs.getString(4));
				assignment.setAsgContent(rs.getString(5));
				assignment.setFileName(rs.getString(6));
				assignment.setFileRealName(rs.getString(7));
				list.add(assignment);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list; // 디비오류
	}

	// 페이징 처리를 위한 함수
	public boolean nextPage(int pageNumber) {
		String SQL = "SELECT * FROM assignment WHERE asgID < ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 5);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	// ----------------------------------

	// 공지사항 수정 메소드
	public int update(int asgID, String asgTitle, String asgContent) {
		String sql = "update assignment set asgTitle = ? ,asgContent = ? where asgID = ?";

		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,asgTitle);
			pstmt.setString(2,asgContent);
			pstmt.setInt(3, asgID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // db오류
	}
	// -------------------------------

	// 공지사항 삭제 메소드
	public int delete(int asgID) {

		String sql = "update assignment where asgID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, asgID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // db오류
	}
	// ------------------------------

	// 공지글 가져오기
	public Asg getAssignment(int asgID) {
		String SQL = "SELECT * FROM assignment WHERE asgID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, asgID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				Asg assignment = new Asg();
				assignment.setAsgID(rs.getInt(1));
				assignment.setUserID(rs.getString(2));
				assignment.setAsgTitle(rs.getString(3));
				assignment.setAsgDate(rs.getString(4));
				assignment.setAsgContent(rs.getString(5));
				assignment.setFileName(rs.getString(6));
				assignment.setFileRealName(rs.getString(7));

				return assignment;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	// -------------------------------

	// 공지글 쓰기
	public int write(String asgTitle, String userID, String asgContent, String fileName, String fileRealName) {
		String SQL = "INSERT INTO assignment VALUES (?,?,?,?,?,?,?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, userID);
			pstmt.setString(3, asgTitle);
			pstmt.setString(4, getDate());
			pstmt.setString(5, asgContent);
			pstmt.setString(6, fileName);
			pstmt.setString(7, fileRealName);
			// 파일부분 미구현
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류

	}
	
	public int getCount() {
	      int count = 0;
	      try {
	         pstmt = conn.prepareStatement("select count(*) from notice");
	         rs = pstmt.executeQuery();
	         if(rs.next()) {
	            count = rs.getInt(1);
	         }
	      }catch(Exception ex) {
	         System.out.println(ex);
	      }
	      return count;
	   }
}
