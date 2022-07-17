<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="notice.NoticeDAO"%>
<%@ page import="notice.Notice"%>
<%@ page import="java.util.*"%>

<%
String userID = null; // 로그인이 된 사람들은 로그인정보를 담을 수 있도록한다
if (session.getAttribute("userID") != null) {
	userID = (String) session.getAttribute("userID");
}
%>
<%
int pageNumber = 1; // 기본페이지 기본적으로 페이지 1부터 시작하므로
if (request.getParameter("pageNumber") != null) {
	pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>Dashboard - SB Admin</title>
<link
	href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css"
	rel="stylesheet" />
<link href="/resource/css/adminstyles.css" rel="stylesheet" />
<script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js"
	crossorigin="anonymous"></script>
<meta charset="UTF-8">
</head>
<body class="sb-nav-fixed">
		<%@ include file="/include/adminHeader.jsp"%>
	
	<%@ include file="/include/adminside.jsp"%>
	
		<div id="layoutSidenav_content">
			<main>
				<div class="container-fluid px-4">
					<h1 class="mt-4">공지사항 등록</h1>
					<ol class="breadcrumb mb-4">
						<li class="breadcrumb-item active">글쓰기 </li>
					</ol>
					
					<div class="card mb-4">
					
						<!-- 게시판 글쓰기 양식 부분 -->
						<div class="container">
							<div class="row">
								<form method="post" action="adminNoticewriteAction.jsp">
									<table class="table table-striped"
										style="text-align: center; border: 1px solid #dddddd">
										<thead>
											<tr>
												<th colspan="2"
													style="background-color: #eeeeee; text-align: center;">게시판
													글쓰기 양식</th>

											</tr>
										</thead>
										<tbody>
											<tr>
												<td><input type="text" class="form-control"
													placeholder="글 제목" name="noticeTitle" maxlength="50"></td>
											</tr>
											<tr>
												<td><textarea class="form-control" placeholder="글 내용"
														name="noticeContent" maxlength="2048" style="height: 350px"></textarea></td>
											</tr>
										</tbody>
									</table>
									<input type="submit" class="btn btn-primary pull-right"
										value="글쓰기">
								</form>
							</div>
							<!-- 게시판 글쓰기 양식 부분 -->
						</div>
					</div>
			</main>
			<footer class="py-4 bg-light mt-auto">
				<div class="container-fluid px-4">
					<div
						class="d-flex align-items-center justify-content-between small">
						<div class="text-muted">Copyright &copy; Your Website 2022</div>
					</div>
				</div>
			</footer>
		</div>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		crossorigin="anonymous"></script>
	<script src="/resource/js/scripts.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"
		crossorigin="anonymous"></script>
	<script src="assets/demo/chart-area-demo.js"></script>
	<script src="assets/demo/chart-bar-demo.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/simple-datatables@latest"
		crossorigin="anonymous"></script>
	<script src="js/datatables-simple-demo.js"></script>
</body>
</html>
