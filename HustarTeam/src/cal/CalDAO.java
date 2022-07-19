package cal;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class CalDAO {
	
	private Connection conn; //커넥션 객체생성
	private PreparedStatement pstmt; // 프리페얼드 스테이트먼트 sql을 실행할수있는객체 쿼리에 인자부여가능
	private ResultSet rs;
	
	public CalDAO() {
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

	
	public int getNext() { 
		String SQL = "SELECT calID FROM calendarmemo ORDER BY calID DESC";
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
	
	public ArrayList<Cal> getList(int pageNumber){
		String SQL = "SELECT * FROM calendarmemo WHERE cmContents < ?  ORDER BY cmContents DESC LIMIT 5";
		ArrayList<Cal> list = new ArrayList<Cal>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber -1) * 5);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Cal cal = new Cal();
				cal.setCalID(rs.getInt(1));
				cal.setCmContents(rs.getString(2));
				cal.setCmYear(rs.getInt(3));
				cal.setCmMonth(rs.getInt(4));
				cal.setCmDay(rs.getInt(5));
				list.add(cal);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list; //디비오류
	}
  //  페이징 처리를 위한 함수
  public boolean nextPage(int pageNumber) {
      String SQL = "SELECT * FROM calendarmemo WHERE cmContents < ?"; 
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
  public int update(String cmContents,int cmYear,int cmMonth,int cmDay ) {
	  String sql = "update calendarmemo set cmContents = ? ,cmYear = ?,cmMonth = ?,cmDay = ?";
	  
	  try {
		  PreparedStatement pstmt = conn.prepareStatement(sql);
		  pstmt.setString(1,cmContents);
		  pstmt.setInt(2,cmYear);
		  pstmt.setInt(3,cmMonth);
		  pstmt.setInt(3,cmDay);
		  return pstmt.executeUpdate();
	  }catch (Exception e) {
		  e.printStackTrace();
	  }
	  return -1 ; //db오류
  }
  //-------------------------------
  

  //공지글 쓰기
  public int write(String cmContents,int cmYear,int cmMonth,int cmDay ) {
      String SQL = "INSERT INTO calendarmemo VALUES (?,?,?,?)";
      try {
          PreparedStatement pstmt = conn.prepareStatement(SQL);
          pstmt.setInt(1, getNext());
          pstmt.setString(2, cmContents);
          pstmt.setInt(3, cmYear);
          pstmt.setInt(4,cmMonth );
          pstmt.setInt(5, cmDay);
      
          //파일부분 미구현
          return pstmt.executeUpdate();
      } catch (Exception e) {
          e.printStackTrace();
      }
      return -1; // 데이터베이스 오류
      
  }
  //-----------------------------------

  public int getCount() {
      int count = 0;
      try {
         pstmt = conn.prepareStatement("select count(*) from calendarmemo");
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
