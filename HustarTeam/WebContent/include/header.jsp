<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- Google Font -->
<link
	href="https://fonts.googleapis.com/css2?family=Oswald:wght@300;400;500;600;700&display=swap"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Mulish:wght@300;400;500;600;700;800;900&display=swap"
	rel="stylesheet">
<!-- css 파일 -->
<link rel="stylesheet" href="/resource/css/common.css" type="text/css">

</head>
<body>
	<%
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	%>
	<!-- 화면 Loader 띄우기
	<div id="preloder">
		<div class="loader"></div>
	</div>
 -->
	<!-- header -->
	<header class="header">
		<div class="container">
			<div class="row">
				<div class="col-lg-2">
					<div class="header__logo">
						<a href="/"> <img src="/resource/img/logo_w.png" alt=""
							width="100">
						</a>
					</div>
				</div>
				<div class="col-lg-8">
					<div class="header__nav">
						<nav class="header__menu mobile-menu">
							<ul>
								<li class="active"><a href="/Board/BoardWrite.jsp">공지사항</a></li>
								<li><a href="/poll/main.jsp">설문조사</a></li>
								<li><a href="/Howework/HWrite.jsp">과제제출</a></li>
								<li><a href="#">출결확인</a></li>
							</ul>
						</nav>
					</div>
				</div>
				
				<%
					if(userID == null){
				%>
				<div class="col-lg-2">
					<div class="header__right">
						<!-- 검색하기 -->
						<a href="#" class="search-switch"><span class="icon_search"></span></a>
                        <a href="/member/login.jsp">로그인<span class="icon_profile"></span></a>	
                        <a href="/member/register.jsp">회원가입<span></span></a>	
					</div>
				</div>
				<%
					}else{
				%>
					<div class="col-lg-2">
					<div class="header__right">
						<!-- 검색하기 -->
						<a href="/member/login.jsp" class="icon_lock-open"><span></span></a>
                        <a href="./member/mypage.jsp">사람님<span class="icon_profile"></span></a>
					</div>
				</div>
				<% 	
					}
				%>
			</div>
			<!-- 반응형 nav -->
			<div id="mobile-menu-wrap"></div>
		</div>

		</header>

</body>
</html>