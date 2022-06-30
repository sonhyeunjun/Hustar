package notice;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class NoticeDAO {
	
	private Connection conn; //커넥션 객체생성
	private PreparedStatement pstmt; // 프리페얼드 스테이트먼트 sql을 실행할수있는객체 쿼리에 인자부여가능
	private ResultSet rs;
	
	public NoticeDAO() {
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
	
	public int noticeWrite(String noticeTitle, String adminID, String noticeContent) {
		String SQL = "INSERT INTO notice VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, noticeTitle);
			pstmt.setString(3, adminID);
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
		String SQL = "SELECT * FROM notice WHERE noticeID < ? AND noticeAvailable = 1 ORDER BY noticeID DESC LIMIT 5";
		ArrayList<Notice> list = new ArrayList<Notice>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getCount() - (pageNumber -1) * 5);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Notice notice = new Notice();
				notice.setNoticeID(rs.getInt(1));
				notice.setNoticeTitle(rs.getString(2));
				notice.setNoticeDate(rs.getString(3));
				notice.setNoticeAvailable(rs.getInt(4));
				notice.setNoticeContent(rs.getString(5));
				notice.setAdminID(rs.getString(6));
				list.add(notice);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list; //디비오류
	}
  //  페이징 처리를 위한 함수
  public boolean nextPage(int pageNumber) {
      String SQL = "SELECT * FROM notice WHERE noticeID < ? AND noticeAvailable = 1"; 
      try {
          PreparedStatement pstmt = conn.prepareStatement(SQL);
          pstmt.setInt(1, getNext() - (pageNumber - 1 ) * 5);
          rs = pstmt.executeQuery();
          if (rs.next())
          {
              return true;
          }
      } catch (Exception e) {
          e.printStackTrace();
      }
      return false; 
  }
  //----------------------------------
  
  //공지사항 수정 메소드
  public int update(int noticeID,String noticeTitle,String noticeContent ) {
	  String sql = "update notice set noticeTitle = ? , noticeContent = ? where noticeId =?";
	  
	  try {
		  PreparedStatement pstmt = conn.prepareStatement(sql);
		  pstmt.setString(1,noticeTitle);
		  pstmt.setString(2,noticeContent);
		  pstmt.setInt(3,noticeID);
	  }catch (Exception e) {
		  e.printStackTrace();
	  }
	  return -1 ; //db오류
  }
  //-------------------------------
  
  //공지사항 삭제 메소드
  public int delete(int noticeID) {
	  
	  String sql = "update set notice noticeAvailable = 0 where noticeID = ?";
	  try {
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, noticeID);
	} catch (Exception e) {
		e.printStackTrace();
	}
	  return -1; //db오류
  }
  //------------------------------
  public int getCount() {
      int count = 0;
      try {
         pstmt = conn.prepareStatement("select count(*) from notice where noticeAvailable = 1");
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
