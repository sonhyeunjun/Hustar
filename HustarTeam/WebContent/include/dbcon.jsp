<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.*"%>
  
<%
String URL = "jdbc:mysql://localhost:8080/HustarTeam?useUnicode=true&characterEncoding=utf8";
String USERNAME = "root";
String PASS = "123123";

/* 접속 드라이브 연결 */
Class.forName("com.mysql.jdbc.Driver"); 

/* 접속 정보 설정 및 적용 */
Connection conn=DriverManager.getConnection(URL,USERNAME,PASS);

/* 접속 인스턴스 생성  */
Statement stmt = conn.createStatement();

request.setCharacterEncoding("utf-8");
%>


