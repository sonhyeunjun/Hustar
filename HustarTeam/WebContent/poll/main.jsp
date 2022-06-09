<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="description" content="Anime Template">
<meta name="keywords" content="Anime, unica, creative, html">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>Hustar | Template</title>

	<!-- Google Font -->
	<link href="https://fonts.googleapis.com/css2?family=Oswald:wght@300;400;500;600;700&display=swap" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css2?family=Mulish:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">
	<!-- css 파일 -->
	<link rel="stylesheet" href="/resource/css/common.css" type="text/css">

</head>
<body>

	<header>
	<%@ include file="/include/header.jsp"%>
	</header>
		
	
	<!-- 내용  -->
	
        <h3 style="color:white;">[설문조사페이지]</h3>
	<br/>
	<h3>${dto.question}</h3>
	<form action="${path}/survey_servlet/insert.do" method=="post">
		<input type="radio" name="num" value="1" checked> ${dto.ans1} <br/>
		<input type="radio" name="num" value="2" > ${dto.ans2} <br/>
		<input type="radio" name="num" value="3" > ${dto.ans3} <br/>
		<input type="radio" name="num" value="4" > ${dto.ans4} <br/>
		<input type="hidden" name="survey_num" value="${dto.survey_num}" checked>
		<input type="submit" value="투표">
	</form>

	


	<!-- footer 바닥글-->

	<%@ include file="/include/footer.jsp"%>



	<!-- 검색 -->
	<%@ include file="/include/search.jsp"%>



	<script src="/resource/js/jquery-3.3.1.min.js"></script>
	<script src="/resource/js/bootstrap.min.js"></script>
	<script src="/resource/js/player.js"></script>
	<script src="/resource/js/jquery.nice-select.min.js"></script>
	<script src="/resource/js/mixitup.min.js"></script>
	<script src="/resource/js/jquery.slicknav.js"></script>
	<script src="/resource/js/owl.carousel.min.js"></script>
	<script src="/resource/js/main.js"></script>


</body>

</html>