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
	<script src="/resource/js/jquery-3.3.1.min.js"></script>
	<script src="/resource/js/bootstrap.min.js"></script>
	<script src="/resource/js/player.js"></script>
	<script src="/resource/js/jquery.nice-select.min.js"></script>
	<script src="/resource/js/mixitup.min.js"></script>
	<script src="/resource/js/jquery.slicknav.js"></script>
	<script src="/resource/js/owl.carousel.min.js"></script>
	<script src="/resource/js/main.js"></script>
</head>
<body>
	

	<header>
	<%@ include file="/include/header.jsp"%>
	</header>
		
	
	<!-- 내용1  -->
	
        <div class="container">
            <div class="row">
            	<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
            		<thead>
            			<tr>
            				<th style="background-color: #ffffff; text-align: center;">번호</th>
            				<th style="background-color: #ffffff; text-align: center;">제목</th>
            				<th style="background-color: #ffffff; text-align: center;">작성자</th>
            				<th style="background-color: #ffffff; text-align: center;">작성일</th>
            			</tr>
            		</thead>
            		<tbody style="color : white;">
            			<tr>
            				<td>1</td>
            				<td>첫번째게시물</td>
            				<td>홍길동</td>
            				<td>2022-06-09</td>
            			</tr>
            		</tbody>
            	</table>
            	<a href="noticeWrite.jsp" class="btn btn-primary pull-right">글쓰기</a>
            </div>
        </div>        

	


	<!-- footer 바닥글-->

	<%@ include file="/include/footer.jsp"%>



	<!-- 검색 -->
	<%@ include file="/include/search.jsp"%>



	


</body>

</html>