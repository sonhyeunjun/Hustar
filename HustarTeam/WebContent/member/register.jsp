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
	<script type="text/javascript" src="/resource/js/login/register.js"></script>

</head>
<body>

	<header>
	<%@ include file="/include/header.jsp"%>
	</header>
		
	
	<!-- 내용  -->
	<section class="normal-breadcrumb set-bg" data-setbg="/resource/img/mvimg01.jpg">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <div class="normal__breadcrumb__text">
                        <h2>Sign Up</h2>
                        <p>Welcome to Hustar</p>
                    </div>
                </div>
            </div>
        </div>
    </section>  


    <section class="signup spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-6" style="margin:auto;" >
                    <div class="login__form">
                        <h3>회원가입</h3>
                        <form name="frm" method="post" action="/member/registerSub.jsp">
                            <div class="input__item">
                                <input type="text" placeholder="이메일 입력" name="userid">
                                <span class="icon_mail"></span>
                            </div>
                            <div class="input__item">
                                <input type="text" placeholder="비밀번호" name="pass">
                                <span class="icon_lock"></span>
                            </div>
                            <div class="input__item">
                                <input type="text" placeholder="이름" name="name">
                                <span class="icon_profile"></span>
                            </div>
                            <div class="input__item">
                                <input type="text" placeholder="생일" name="brithday">
                                <span class="icon_calendar"></span>
                                
                            </div>
                            <div class="input__item">
                                <input type="text" placeholder="Phone number" name="phone">
                                <span class="icon_desktop"></span>
                            </div>
                            <div class="form-group form-check">
                                <input type="checkbox" class="form-check-input" id="exampleCheck1">
                                <label class="form-check-label" for="exampleCheck1">서비스 약관의 모든 내용에 동의합니다.</label>
                            </div>
                            
                            <button type="submit" onclick="fn_submit(); return false;" class="site-btn" >회원가입</button> 
                        </form>
                        <h5>이미 계정이 있습니까? <a href="/member/login.jsp">로그인!</a></h5>
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