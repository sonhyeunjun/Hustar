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


    <div class="breadcrumb-option">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="breadcrumb__links">
                        <a href="/"><i class="fa fa-home"></i>Home</a>
                        <a href="#">게시판</a>
                        <span>여기는 "<%= %>"</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
  
    <section class="product-page spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="product_page_content">
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="section-title">
                                    <h4>공지사항</h4>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-12 ">
                            <div class="product__item">
                                <div class="product__item__pic set-bg">
                                    <table class="table table-striped" style="width:100%">
                                        <thead class="table-light">
                                            <tr>
                                                <th>번호</th>
                                                <th>제목</th>
                                                <th>작성자</th>
                                                <th>작성일</th>
                                                <th>조회수</th>
                                                <th>첨부 파일</th>
                                            </tr>
                                        </thead>
                                        <tbody class="table-light">
                                            <tr>
                                                 <td><a href="Boarddetail.jsp">Tiger Nixon</a></td>
                                                <td>System Architect</td>
                                                <td>Edinburgh</td>
                                                <td>61</td>
                                                <td>2011-04-25</td>
                                                <td>$320,800</td>
                                            </tr>
                                            <tr>
                                                <td>Garrett Winters</td>
                                                <td>Accountant</td>
                                                <td>Tokyo</td>
                                                <td>63</td>
                                                <td>2011-07-25</td>
                                                <td>$170,750</td>
                                            </tr>
                                            <tr>
                                                <td>Ashton Cox</td>
                                                <td>Junior Technical Author</td>
                                                <td>San Francisco</td>
                                                <td>66</td>
                                                <td>2009-01-12</td>
                                                <td>$86,000</td>
                                            </tr>
                                            <tr>
                                                <td>Cedric Kelly</td>
                                                <td>Senior Javascript Developer</td>
                                                <td>Edinburgh</td>
                                                <td>22</td>
                                                <td>2012-03-29</td>
                                                <td>$433,060</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                     <div class="product__pagination1" style="text-align: right;">
                                        <button type="button" class="btn btn-light">글쓰기</button>
                                    </div>
                                    <div class="product__pagination" style="text-align:center">
                                        <a href="#" >1</a>
                                        <a href="#">2</a>
                                        <a href="#">3</a>
                                        <a href="#">4</a>
                                        <a href="#">5</a>
                                        <a href="#"><i class="fa fa-angle-double-right"></i></a>
                                    </div>
                                </div>
                            </div>
                        </div>    
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
	<!-- Search model end -->


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