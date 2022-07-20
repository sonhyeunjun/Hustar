<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.*"%>
  
<%
PreparedStatement pstmt = null;
String dbDriver = "com.mysql.cj.jdbc.Driver"; //JDBC 드라이버의 클래스 경로
String dbURL = "jdbc:mysql://database1.chfhjyvwugph.ap-northeast-2.rds.amazonaws.com/database1";
String dbID = "root";
String dbPassword = "Thsguswns";

/* 접속 드라이브 연결 */
Class.forName(dbDriver);

/* 접속 정보 설정 및 적용 */
Connection conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
if (conn == null) {
	out.println("Calendar 데이터베이스 연결 실패");
}

/* 접속 인스턴스 생성  */
Statement stmt = conn.createStatement();
/* pstmt = conn.prepareStatement(); */

request.setCharacterEncoding("utf-8");
%>


