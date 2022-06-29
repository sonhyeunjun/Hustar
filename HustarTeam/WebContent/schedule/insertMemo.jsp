<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>City List</title>
</head>
<body>
<%
// POST 방식의 한글처리
request.setCharacterEncoding("UTF-8");

// 파라미터 정보 가져오기
String incontents = request.getParameter("incontents");
String iny = request.getParameter("inyear");
String inm = request.getParameter("inmonth");
String ind = request.getParameter("inday");

int inyear = Integer.parseInt(iny);
int inmonth = Integer.parseInt(inm);
int inday = Integer.parseInt(ind);

//데이터베이스를 연결하는 관련 변수를 선언한다
Connection conn = null;
PreparedStatement pstmt = null;
//데이터베이스를 연결하는 관련 정보를 문자열로 선언한다.
String dbDriver = "com.mysql.cj.jdbc.Driver"; //JDBC 드라이버의 클래스 경로
String dbURL = "jdbc:mysql://database1.chfhjyvwugph.ap-northeast-2.rds.amazonaws.com/database1"; //접속하려는 데이터베이스의 정보
String dbID = "root";
String dbPassword = "Thsguswns";
//JDBC 드라이버 클래스를 로드한다.
Class.forName(dbDriver);
//데이터베이스 연결 정보를 이용해서 Connection 인스턴스를 확보한다.
conn = DriverManager.getConnection(dbURL, dbID, dbPassword);

// 3) SQL문 준비
String sql = "INSERT INTO calendarmemo VALUES (?, ?, ?, ?)";

pstmt = conn.prepareStatement(sql);
pstmt.setString(1, incontents);
pstmt.setInt(2, inyear);
pstmt.setInt(3, inmonth);
pstmt.setInt(4, inday);

// 4) 실행
pstmt.executeUpdate();

// JDBC 자원 닫기
pstmt.close();
conn.close();
%>
<script>
alert("저장 성공!");
location.href = 'calendar.jsp';
</script>
</body>
</html>