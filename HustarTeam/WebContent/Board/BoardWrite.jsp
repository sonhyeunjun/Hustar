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
    <script defer src="/scripts/ckeditor.js"></script>
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
    <style>
    
    </style>

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
 
  <section class="anime-details spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="section-title">
                        <h5>게시판 글적기</h5>
                    </div>
                    <div class="anime__video__player">
                        <form action="" method="POST">
                            <textarea name="text" id="editor" style="height:500ox"></textarea>
                            <div class="product__pagination1" style="text-align: right; margin-top: 8px;">
                                <button type="button" class="btn btn-light">글쓰기</button>
                            </div>
                            </form>
                        <script src="https://cdn.ckeditor.com/ckeditor5/34.0.0/classic/ckeditor.js"></script>
                        <script>
                        ClassicEditor.create( document.querySelector( '#editor' ), {
                    language: "ko"
                     } );
                        </script>
                        </div> 
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