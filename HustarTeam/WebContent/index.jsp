<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=03dc0c1d6af4d7990e0d8728ccb7d5af"></script>
<meta charset="UTF-8">
<meta name="description" content="Anime Template">
<meta name="keywords" content="Anime, unica, creative, html">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>Hustar | Template</title>

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


	<header>
		<%@ include file="/include/header.jsp"%>
	</header>

	
	<!-- 내용1  -->
	
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="product__page__content">
                        <div class="row">
                            <div class="col-12">
                                <div class="product__item">
                                    <div class="product__item__pic set-bg" data-setbg="/resource/img/Ca.jpg">
                                        <!-- <div class="ep">18 / 18</div>
                                        <div class="comment"><i class="fa fa-comments"></i> 11</div>
                                        <div class="view"><i class="fa fa-eye"></i> 9141</div> -->
                                    </div>
                                    <div class="product__item__text">
                                        <!-- <ul>
                                            <li>Active</li>
                                            <li>Movie</li>
                                        </ul>
                                        <h5><a href="#">Sen to Chihiro no Kamikakushi</a></h5> -->
                                    </div>
                                </div>
                            </div>
                            <div class="col-6 col-6">
                                <div class="product__item">
                                    <div class="product__item__pic set-bg" data-setbg="/resource/img/Ca.jpg">
                                    </div>
                                </div>
                            </div>
                            <div class="col-6 col-6">
                                <div class="product__item">
                                    <div class="product__item__pic set-bg" data-setbg="/resource/img/Ca.jpg">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>  
        </div>        



	<!-- 내용1 1 -->

	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<div class="product__page__content">
					<div class="product__page__title">
						<div class="row"></div>
					</div>
					<div class="row">
						<div class="col-12">
							<div class="product__item">
								<div class="product__item__pic set-bg"
									data-setbg="/resource/img/Ca.jpg"></div>
								<div class="product__item__text"></div>
							</div>
						</div>
						<div class="col-6 col-6">
						<div id="map" style="width:500px;height:400px;"></div>
						
						</div>
					</div>
					<div class="col-6 col-6">
						<div class="product__item">
							<div class="product__item__pic set-bg"
								data-setbg="/resource/img/Ca.jpg"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	</div>




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
	<script src="/resource/js/map.js"></script>
	


</body>

</html>