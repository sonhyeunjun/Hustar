<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="assignment.AsgDAO"%>
<%@ page import="assignment.Asg"%>
<%@ page import="java.util.*"%>


<!DOCTYPE html>
<html lang="ko">

<head>
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

<!-- Css Styles -->
<link rel="stylesheet" href="/resource/css/bootstrap.min.css"
	type="text/css">
<link rel="stylesheet" href="/resource/css/font-awesome.min.css"
	type="text/css">
<link rel="stylesheet" href="/resource/css/elegant-icons.css"
	type="text/css">
<link rel="stylesheet" href="/resource/css/plyr.css" type="text/css">
<link rel="stylesheet" href="/resource/css/nice-select.css"
	type="text/css">
<link rel="stylesheet" href="/resource/css/owl.carousel.min.css"
	type="text/css">
<link rel="stylesheet" href="/resource/css/slicknav.min.css"
	type="text/css">
<link rel="stylesheet" href="/resource/css/style.css" type="text/css">
</head>

<body>


	<!-- Header Section Begin -->
	<header>
		<%@ include file="/include/header.jsp"%>
	</header>
	<%
	int pageNumber = 1; // 기본페이지 기본적으로 페이지 1부터 시작하므로
	if (request.getParameter("pageNumber") != null) {
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	}
	%>



	<div class="breadcrumb-option">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="breadcrumb__links">
						<a href="/"><i class="fa fa-home"></i>Home</a> <a href="#">게시판</a>
						<span>여기는 </span>
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
									<h4>과제제출</h4>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-lg-12 ">
							<div class="product__item">
								<div class="product__item__pic set-bg">
									<table class="table table-striped" style="width: 100%">
										<thead class="table-light">
											<tr>
												<th>번호</th>
												<th>제목</th>
												<th>작성자</th>
												<th>파일명</th>
												<th>작성일</th>
											</tr>
										</thead>
										<tbody class="table-light">
											<%
											AsgDAO asgDAO = new AsgDAO();
											ArrayList<Asg> list = asgDAO.getList(pageNumber);
											for (int i = 0; i < list.size(); i++) 
											{
											%>
											<tr>
												<td><%=list.get(i).getAsgID()%></td>
												<td><%=list.get(i).getAsgTitle()%></td>
												<td><%=list.get(i).getUserID()%></td>
												<td><%=list.get(i).getFileName()%></td>
												<td><%=list.get(i).getAsgDate().substring(0, 11) + list.get(i).getAsgDate().substring(11, 13) + "시"
												+ list.get(i).getAsgDate().substring(14, 16) + "분"%></td>
											</tr>

											<%} %>
										
										</tbody>
									</table>
									
									<div class="product__pagination1" style="text-align: right;">
										<button type="button" class="btn btn-light"
											onclick="location.href='/assignment/asgWrite.jsp'">글쓰기</button>
									</div>
									
									<a href="fileDownload.jsp">파일 다운로드 페이지</a>
									
									<nav aria-label="Page navigation example">
								<ul class="pagination justify-content-center">
									<%
									if (pageNumber == 1) {
									%>
									<li class="page-item disabled"><a class="page-link"
										href="Boardlist.jsp?pageNumber=<%=pageNumber - 1%>">이전</a></li>
									<%
									} else {
									%>
									<li class="page-item"><a class="page-link"
										href="Boardlist.jsp?pageNumber=<%=pageNumber - 1%>">이전</a></li>
									<%
									}
									%>
									<%
									int count = asgDAO.getCount();
									int totalPage = count / 5;
									if (count % 5 != 0) {
										totalPage += 1;
									}

									for (int i = 1; i <= totalPage; i++) {
									%>
									<%
									if (pageNumber == i) {
									%>

									<li class="page-item active"><a class="page-link"
										href="Boardlist.jsp?pageNumber=<%=i%>"><%=i%> </a></li>
									<%
									} else {
									%>
									<li class="page-item"><a class="page-link"
										href="Boardlist.jsp?pageNumber=<%=i%>"><%=i%> </a></li>
									<%
									}
									%>
									<%
									}
									%>


									<%
									if (pageNumber == totalPage) {
									%>
									<li class="page-item disabled"><a class="page-link"
										href="Boardlist.jsp?pageNumber=<%=pageNumber + 1%>">다음</a></li>
									<%
									} else {
									%>
									<li class="page-item "><a class="page-link"
										href="Boardlist.jsp?pageNumber=<%=pageNumber + 1%>">다음</a></li>
									<%
									}
									%>

								</ul>
							</nav>
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