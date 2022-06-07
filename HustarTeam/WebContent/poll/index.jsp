<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="../include/header.jsp"%>
</head>
<body>
<%
	// 페이지 이동
	response.sendRedirect(
			request.getContextPath() + "/survey_servlet/input.do");
%>
</body>
</html>