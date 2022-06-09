<%@page import="java.io.PrintWriter"%>
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
	<script type="text/javascript" src="/resource/js/login/login.js"></script>

</head>
<body>
<<<<<<< HEAD
=======

>>>>>>> branch 'master' of https://github.com/sonhyeunjun/Hustar.git

	<header>
	<%@ include file="/include/header.jsp"%>
	</header>
		
	
	<!-- 내용  -->
	<section class="normal-breadcrumb set-bg" data-setbg="/resource/img/mvimg01.jpg">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <div class="normal__breadcrumb__text">
                        <h2>Login</h2>
                        <p>Welcome to Hustar</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="login spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-6">
                    <div class="login__form">
                        <h3>로그인</h3>
                        <form name="frm" method="post" action="/member/loginAction.jsp">
                            <div class="input__item">
                                <input type="text" placeholder="Email address" name="userID">
                                <span class="icon_mail"></span>
                            </div>
                            <div class="input__item">
                                <input type="text" placeholder="Password" name="userPassword">
                                <span class="icon_lock"></span>
                            </div>
                            <button type="submit" class="site-btn" onclick="fn_submit(); return false;">로그인 하기</button>
                        </form>
                        <a href="#" class="forget_pass">비밀번호 찾기</a>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="login__register">
                        <h3>아이디가 없으세요?</h3>
                        <a href="/member/register.jsp" class="primary-btn">회원가입</a>
                    </div>
                </div>
            </div>
         
        </div>
    </section>


	<!-- footer 바닥글-->
	<%@ include file="/include/footer.jsp"%>


	<!-- 검색 -->
	<%@ include file="/include/search.jsp"%>
	<!-- Search model end -->


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