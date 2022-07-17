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

int noticeID = 0;
if (request.getParameter("noticeID") != null) {
	noticeID = Integer.parseInt(request.getParameter("noticeID"));
}

if (noticeID == 0) {
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alret('유효하지 않은 글 입니다!.')");
	script.println("</script>");
}

Notice notice = new NoticeDAO().getNotice(noticeID);
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
<title>공지사항 상세내용 보기</title>
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
				<h1 class="mt-4">공지사항 상세</h1>
				<ol class="breadcrumb mb-4">
					<li class="breadcrumb-item active"></li>
				</ol>

				<!--  공지사항 상세-->
				<div class="container">
					<div class="row">
						<table class="table table-striped"
							style="text-align: center; border: 1px solid #dddddd">
							<thead>
								<tr>
									<th colspan="3"
										style="background-color: #eeeeee; text-align: center;">공지사항
										상세내용</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td style="width: 20%;">글제목 :</td>
									<td colspan="2"><%=notice.getNoticeTitle()%></td>
								</tr>
								<tr>
									<td>작성자 :</td>
									<td colspan="2"><%=notice.getAdminID()%></td>
								</tr>
								<tr>
									<td>작성일자 :</td>
									<td colspan="2"><%=notice.getNoticeDate()%></td>
								</tr>
								<tr>
									<td>내용</td>
									<td colspan="2" style="min-height: 200px; text-align: left;"><%=notice.getNoticeContent()%></td>
								</tr>
								<tr>
									<td>조회수</td>
									<td colspan="2" style="min-height: 200px; text-align: left;"><%=notice.getNoticeViews()%></td>
								</tr>
							</tbody>
						</table>
						<div class="product__pagination1"
							style="text-align: right; margin-top: 8px;">
							<button type="button" class="btn btn-outline-dark">수정</button>
							<button type="button" class="btn btn-outline-dark">취소</button>
						</div>
					</div>
				</div>
			</div>
		</main>
	
		<footer class="py-4 bg-light mt-auto">
			<div class="container-fluid px-4">
				<div class="d-flex align-items-center justify-content-between small">
					<div class="text-muted">Copyright &copy; Your Website 2022</div>
				
				</div>
			</div>
		</footer>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		crossorigin="anonymous"></script>
	<script src="js/scripts.js"></script>
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
