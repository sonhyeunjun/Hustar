package attendance;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import cal.Cal;

public class AttendanceDAO {
	public static String getClientIp(HttpServletRequest req) {

		String[] header_IPs = { "HTTP_CLIENT_IP", "HTTP_X_FORWARDED_FOR", "HTTP_X_FORWARDED",
				"HTTP_X_CLUSTER_CLIENT_IP", "HTTP_FORWARDED_FOR", "HTTP_FORWARDED", "X-Forwarded-For",
				"Proxy-Client-IP", "WL-Proxy-Client-IP" };

		for (String header : header_IPs) {
			String ip = req.getHeader(header);

			if (ip != null && !"unknown".equalsIgnoreCase(ip) && ip.length() != 0) {
				System.out.print(ip);
				return ip;
			}
		}
		return req.getRemoteAddr();
	}

	private Connection conn; // 커넥션 객체생성
	private PreparedStatement pstmt; // 프리페얼드 스테이트먼트 sql을 실행할수있는객체 쿼리에 인자부여가능
	private ResultSet rs;

	public AttendanceDAO() {
		try {
			String dbURL = "jdbc:mysql://database1.chfhjyvwugph.ap-northeast-2.rds.amazonaws.com/database1";
			String dbID = "root";
			Class.forName("com.mysql.cj.jdbc.Driver");
			String dbPassword = "Thsguswns";
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	// 현재서버의 시간을 가져오는 클래스
	public String getDate() {
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
	// --------------------

	// 출석버튼 클릭시 db에 출석시간을 넣는 출석 클래스
	public int in_class(String userid) {
		
		String SQL = "INSERT INTO Attendance(userid,date,intime,outtime) VALUES (?,CURDATE(),NOW(),now())";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			
			pstmt.setString(1, userid);
			return pstmt.executeUpdate();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return -1; 
	}
	// ---------------------------------------

	// 퇴실버튼 클릭시 db에 퇴실시간을 넣는 퇴실 클래스
	public int out_class(String userid) {
		
		String SQL = "UPDATE Attendance SET outtime = NOW() WHERE userid = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userid);
			
			return pstmt.executeUpdate();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
		
	}
	// --------------------------------------

	// 출석 시간과 퇴실시간 을 이용하여 출석 지각 조퇴 결석을 결정하는 클래스
	public int att_decision(String userid) {
		String SQL ="UPDATE Attendance SET att = 1 where TIMEStampDIFF(minute,intime,outtime) > 480 AND userid = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,userid);
			
			return pstmt.executeUpdate();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	// --------------------------------------------------------
	//
	public int getNext() { 
		String SQL = "SELECT seq FROM Attendance ORDER BY seq DESC";
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
	public ArrayList<Attendance> getList(int pageNumber){
		String SQL = "SELECT * FROM Attendance WHERE seq < ?  ORDER BY seq DESC LIMIT 5";
		ArrayList<Attendance> list = new ArrayList<Attendance>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber -1) * 5);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Attendance attendance = new Attendance();
				attendance.setSeq(rs.getInt(1));
				attendance.setUserid(rs.getString(2));
				attendance.setDate(rs.getString(3));
				attendance.setIn(rs.getString(4));
				attendance.setOut(rs.getString(5));
				attendance.setAtt(rs.getString(6));
		
				list.add(attendance);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list; //디비오류
	}
}