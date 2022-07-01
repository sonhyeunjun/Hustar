<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="notice.NoticeDAO"%>
<%@ page import="notice.Notice"%>
<%@ page import="java.util.*"%>
<%
	int pageNumber = 1; // 기본페이지 기본적으로 페이지 1부터 시작하므로
	if (request.getParameter("pageNumber") != null) {
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	}
	%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="description" content="Anime Template">
<meta name="keywor ds" content="Anime, unica, creative, html">
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


	<!-- 내용11  -->

	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<div class="product__page__content">
					<div class="row">
						<div class="col-12">
							<div class="product__item">
								<!-- 달력 테스트 -->
								<div id="map" style="width: 100%; height: 350px;"></div>
								<button id="atend-btn" style="width: 100%; height: 50px;">출석하기</button>
								<script type="text/javascript"
									src="//dapi.kakao.com/v2/maps/sdk.js?appkey=03dc0c1d6af4d7990e0d8728ccb7d5af">
								</script>
								<script src="/resource/js/map.js"></script>								
									


								<!-- 달력 테스트 -->
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
								<!-- 공지사항 간단히 보기 -->
																	<table class="table table-striped" style="width: 100%">
										<thead class="table-light">
											<tr>
												<th>번호</th>
												<th>제목</th>
												<th>작성자</th>
												<th>작성일</th>
											</tr>
										</thead>
										<tbody class="table-light">
											<%
											NoticeDAO noticeDAO = new NoticeDAO();
											ArrayList<Notice> list = noticeDAO.getList(pageNumber);
											for (int i = 0; i < 5; i++) 
											{
											%>
											<tr>
												<td><%=list.get(i).getNoticeID()%></td>
												<td><%=list.get(i).getNoticeTitle()%></td>
												<td><%=list.get(i).getAdminID()%></td>
												<td><%=list.get(i).getNoticeDate().substring(0, 11) + list.get(i).getNoticeDate().substring(11, 13) + "시"
												+ list.get(i).getNoticeDate().substring(14, 16) + "분"%></td>
											</tr>

											<%} %>
										
										</tbody>
									</table>
								<!-- 공지사항 간단히 보기 -->
							</div>
						</div>
						<div class="col-6 col-6">
							<div class="product__item">
								<div class="product__item__pic set-bg"
									data-setbg="/resource/img/sample.jpg"></div>
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


</body>

</html>