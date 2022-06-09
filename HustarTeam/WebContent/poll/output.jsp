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
	<h2>설문조사 결과</h2>
	<table class="table">
		<tr>
			<th>문항</th>
			<th>응답수</th>
			<th>응답비율</th>
		</tr>
		<c:forEach var="dto" items="${list}">
			<tr>
				<td>${dto.num}</td>
				<td>${dto.sum_num}</td>
				<td>${dto.rate}%</td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>