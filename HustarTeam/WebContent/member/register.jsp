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


<<<<<<< HEAD
    <section class="signup spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-6" style="margin:auto;" >
                    <div class="login__form">
                        <h3>회원가입</h3>
                        <form name="f+++rm" method="post" action="/member/registerAction.jsp">
                       		<div class="input__item">
                                <input type="text" placeholder="아이디" name="userID">
                                <span class="icon_mail"></span>
                            </div>
                            <div class="input__item">
                                <input type="password" placeholder="비밀번호" name="userPassword">
                                <span class="icon_lock"></span>
                            </div>
                            <div class="input__item">
                                <input type="text" placeholder="이름" name="userName">
                                <span class="icon_profile"></span>
                            </div>
                            <div class="input__item">
                                <input type="text" placeholder="이름" name="userName">
                                <span class="icon_profile"></span>
                            </div>
                           	<div style="color:white;">
                                남자<input type="radio" name="userGender" autocomplete="off" value="남자" checked>
								여자<input type="radio" name="userGender" autocomplete="off" value="여자" checked>
                            </div>
                            <div class="input__item">

                                <input type="date" data-placeholder="생년월일" name="userBirth">
                                <span class="icon_calendar"></span>
                            </div>
                            <div class="input__item">
                                <input type="text" placeholder="대학교" name="userUniversity">
                                <span class="icon_profile"></span>
                            </div>
                            <div class="input__item">
                                <input type="text" placeholder="전공" name="userMajor">
                                <span class="icon_profile"></span>
                            </div>
                            <div class="input__item">
                                <input type="text" placeholder="전화번호" name="userPhone">
                                <span class="icon_desktop"></span>
                            </div>
                            <div class="input__item">
                                <input type="email" placeholder="이메일" name="userEmail">
                                <span class="icon_mail"></span>
                            </div>
                            <div class="input__item">
                                <input type="text" placeholder="주소" name="userAddress">
                                <span class="icon_desktop"></span>
                            </div>
                            <div class="form-group form-check">
                                <input type="checkbox" class="form-check-input" id="exampleCheck1">
                                <label class="form-check-label" for="exampleCheck1" style="color:white;">서비스 약관의 모든 내용에 동의합니다.</label>
                            </div>
                            
                            <button type="submit" onclick="fn_submit(); return false;" class="site-btn" >회원가입</button> 
                        </form>
                        <h5>이미 계정이 있습니까? <a href="/member/login.jsp">로그인!</a></h5>
=======

    <section class="h-90 bg-black">
        <div class="container py-9 h-100">
          <div class="row d-flex justify-content-center align-items-center h-100">
            <div class="col">
              <div class="card card-registration my-4">
                <div class="row">
                  <div class="col-md-12">
                    <div class="card-body p-md-5 text-black">
                      <h3 class="mb-5 text-uppercase">회원가입</h3>
      
                      <div class="row">
                        <div class="col-md-6 mb-4">
                          <div class="form-outline">
                            <input type="text" id="form3Example1m" class="form-control form-control-lg" name="userID" />
                            <label class="form-label" for="form3Example1m">아이디</label>
                          </div>
                        </div>
                        <div class="col-md-6 mb-4">
                          <div class="form-outline">
                            <input type="text" id="form3Example1n" class="form-control form-control-lg" name="userName" />
                            <label class="form-label" for="form3Example1n">이름</label>
                          </div>
                        </div>
                      </div>
      
                      <div class="row">
                        <div class="col-md-6 mb-4">
                          <div class="form-outline">
                            <input type="password" id="form3Example1m1" class="form-control form-control-lg" name="userPassword"/>
                            <label class="form-label" for="form3Example1m1">비밀번호</label>
                          </div>
                        </div>
                        <div class="col-md-6 mb-4">
                          <div class="form-outline">
                            <input type="text" id="form3Example1n1" class="form-control form-control-lg" name="userPhone" />
                            <label class="form-label" for="form3Example1n1">전화번호</label>
                          </div>
                        </div>
                      </div>
      
                      <div class="form-outline mb-4">
                        <input type="text" id="form3Example8" class="form-control form-control-lg " name="userAddress" />
                        <label class="form-label" for="form3Example8">주소</label>
                      </div>
      
                      <div class="d-md-flex justify-content-start align-items-center mb-4 py-2">
      
                        <h6 class="mb-0 me-4">성별: </h6>
      
                        <div class="form-check form-check-inline mb-0 me-4">
                          <input class="form-check-input" type="radio" name="userGender" id="femaleGender"
                            value="woman" />
                          <label class="form-check-label" for="femaleGender">여자</label>
                        </div>
      
                        <div class="form-check form-check-inline mb-0 me-4">
                          <input class="form-check-input" type="radio" name="userGender" id="maleGender"
                            value="man" />
                          <label class="form-check-label" for="maleGender">남자</label>
                        </div>
                        </div>
      
                      
                      <div class="row">
                      

>>>>>>> branch 'master' of https://github.com/sonhyeunjun/Hustar.git
                    </div>

                      <div class="form-outline mb-4">
                        <input type="date" id="form3Example9" class="form-control form-control-lg" name="userBirth" />
                        <label class="form-label" for="form3Example9">생년월일</label>
                        
                      </div>
      
                      <div class="form-outline mb-4">
                        <input type="text" id="form3Example90" class="form-control form-control-lg" name="userUniversity" />
                        <label class="form-label" for="form3Example90">대학교</label>
                      </div>
      
                      <div class="form-outline mb-4">
                        <input type="text" id="form3Example99" class="form-control form-control-lg" name="userMajor" />
                        <label class="form-label" for="form3Example99">전공</label>
                      </div>
      
                      <div class="form-outline mb-4">
                        <input type="email" id="form3Example97" class="form-control form-control-lg" name="userEmail" />
                        <label class="form-label" for="form3Example97">이메일</label>
                      </div>
      
                      <div class="d-flex justify-content-end pt-3">
                        <div class="form-group form-check">
                          <input type="checkbox" class="form-check-input" id="exampleCheck1">
                          <label class="form-check-label" for="exampleCheck1">서비스 약관의 모든 내용에 동의합니다.</label>
                      </div>
                      <button type="submit" onclick="fn_submit(); return false;" class="site-btn" >회원가입</button>
                      </div>
      
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>
      
	<!-- footer 1바닥글-->
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