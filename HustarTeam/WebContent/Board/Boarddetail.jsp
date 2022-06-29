<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zxx">

<head>
    <meta charset="UTF-8">
    <meta name="description" content="Anime Template">
    <meta name="keywords" content="Anime, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Hustar | Template</title>

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Oswald:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Mulish:wght@300;400;500;600;700;800;900&display=swap"
    rel="stylesheet">

    <!-- Css Styles -->
    <link rel="stylesheet" href="/resource/css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="/resource/css/font-awesome.min.css" type="text/css">
    <link rel="stylesheet" href="/resource/css/elegant-icons.css" type="text/css">
    <link rel="stylesheet" href="/resource/css/plyr.css" type="text/css">
    <link rel="stylesheet" href="/resource/css/nice-select.css" type="text/css">
    <link rel="stylesheet" href="/resource/css/owl.carousel.min.css" type="text/css">
    <link rel="stylesheet" href="/resource/css/slicknav.min.css" type="text/css">
    <link rel="stylesheet" href="/resource/css/style.css" type="text/css">
</head>

<body>
    

<!-- Header Section Begin -->
<header>
	<%@ include file="/include/header.jsp"%>
	</header>
    <!-- Header End -->

     <div class="breadcrumb-option">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="breadcrumb__links">
                        <a href="#"><i class="fa fa-home"></i>Home</a>
                        <a href="#">게시판</a>
                        <a href="#">공지</a>
                        <span>공지사항</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Breadcrumb End -->

    <!-- Anime Section Begin -->
    <section class="anime-details spad">
        <div class="container">
            <div class="anime__details__content">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="anime__details__text">
                            <div class="anime__details__title">
                                <h3>오늘은 시작이다</h3>
                                <span>제목/작성자</span>
                            </div>
                            <div class="anime__details__rating">
                                <div class="rating">
                                    <a href="#"><i class="fa fa-star"></i></a>
                                    <a href="#"><i class="fa fa-star"></i></a>
                                </div>
                                <span>1.029 views</span>
                            </div>
                            <p>짧은 세 문장을 나열한 a보다 하나의 긴 문장으로 연결한 b가 훨씬 정돈되어 있을 뿐만 아니라 더 쉽게 이해된다. a는 각 문장이 끝날 때마다 다음에 어떤 내용이 이어질지 예측을 해야 하지만, b는 그러한 여지를 주지 않는다. 글을 쓰는 사람이 글에 담을 내용에 대해 훨씬 깊이 이해하고 있으며, 그것을 치밀하게 글로 풀어내기 때문이다.</p>
                       
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-12 ">
                        <div class="review">
                            <div class="section-title">
                                <h5>댓글</h5>
                            </div>
                            <div class="anime__review__item">
                                <div class="anime__review__item__pic">
                                    <img src="img/anime/review-1.jpg" alt="">
                                </div>
                                <div class="anime__review__item__text">
                                    <h6>Chris Curry </h6>
                                    <p>방가방가</p>
                                </div>
                            </div>
                            <div class="anime__review__item">
                                <div class="anime__review__item__pic">
                                    <img src="img/anime/review-2.jpg" alt="">
                                </div>
                                <div class="anime__review__item__text">
                                    <h6>Lewis Mann</h6>
                                    <p>방가방가</p>
                                </div>
                            </div>
                            <div class="anime__review__item">
                                <div class="anime__review__item__pic">
                                    <img src="img/anime/review-3.jpg" alt="">
                                </div>
                                <div class="anime__review__item__text">
                                    <h6>Louis Tyler</h6>
                                    <p>방가방가</p>
                                </div>
                            </div>
                            <div class="anime__review__item">
                                <div class="anime__review__item__pic">
                                    <img src="img/anime/review-4.jpg" alt="">
                                </div>
                                <div class="anime__review__item__text">
                                    <h6>Chris Curry</h6>
                                    <p>방가방가</p>
                                </div>
                            </div>
                           
                        </div>
                        <div class="anime__details__form">
                            <div class="section-title">
                                <h5>댓글달기</h5>
                            </div>
                            <form action="#">
                                <textarea placeholder="Your Comment"></textarea>
                                <button type="submit"><i class="fa fa-location-arrow"></i> Review</button>
                            </form>
                        </div>
                    </div>
                    
                </div>
            </div>
        </section>

	<!-- footer 바닥글-->
	<%@ include file="/include/footer.jsp"%>


	<!-- 검색 -->
	<%@ include file="/include/search.jsp"%>

<!-- Js Plugins -->
<script src="js/jquery-3.3.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/player.js"></script>
<script src="js/jquery.nice-select.min.js"></script>
<script src="js/mixitup.min.js"></script>
<script src="js/jquery.slicknav.js"></script>
<script src="js/owl.carousel.min.js"></script>
<script src="js/main.js"></script>

</body>

</html>