<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/dbcon.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>City List</title>
</head>
<body>
<%

// 파라미터 정보 가져오기
String incontents = request.getParameter("incontents");
String iny = request.getParameter("inyear");
String inm = request.getParameter("inmonth");
String ind = request.getParameter("inday");

int inyear = Integer.parseInt(iny);
int inmonth = Integer.parseInt(inm);
int inday = Integer.parseInt(ind);

// SQL문 준비
String sql = "INSERT INTO calendarmemo VALUES (?, ?, ?, ?)";

pstmt = conn.prepareStatement(sql);
pstmt.setString(1, incontents);
pstmt.setInt(2, inyear);
pstmt.setInt(3, inmonth);
pstmt.setInt(4, inday);

// 실행
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