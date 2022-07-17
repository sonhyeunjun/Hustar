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
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>관리자 페이지</title>
<link
	href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css"
	rel="stylesheet" />
<link href="/resource/css/adminstyles.css" rel="stylesheet" />
<script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js"
	crossorigin="anonymous"></script>
</head>
<body class="sb-nav-fixed">

		<%@ include file="/include/adminHeader.jsp"%>
	
	<%@ include file="/include/adminside.jsp"%>
		<div id="layoutSidenav_content">
			<main>
				<div class="container-fluid px-4">
					<h1 class="mt-4">공지사항</h1>
					<ol class="breadcrumb mb-4">
						<li class="breadcrumb-item"><a href="adminMain.jsp">메인</a></li>
						<li class="breadcrumb-item active">공지사항</li>
					</ol>
					<div class="card mb-4">
						<div class="card-header">
							<i class="fas fa-table me-1"></i> 공지사항
						</div>
						<div class="card-body">
							<table class="table">
								<thead class="thead-dark">
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
									for (int i = 0; i < list.size(); i++) {
									%>
									<tr>
										<td><%=list.get(i).getNoticeID()%></td>
										<td><a
											href="adminNoticeDetail.jsp?noticeID=<%=list.get(i).getNoticeID()%>"><%=list.get(i).getNoticeTitle()%></a></td>
										<td><%=list.get(i).getAdminID()%></td>
										<td><%=list.get(i).getNoticeDate().substring(0, 11) + list.get(i).getNoticeDate().substring(11, 13) + "시"
		+ list.get(i).getNoticeDate().substring(14, 16) + "분"%>
											<a type="button" class="btn btn-secondary" href="adminNoticeUpdate.jsp?noticeID=<%=list.get(i).getNoticeID()%>">수정</a>
											<a type="button" class="btn btn-secondary" href="adminNoticeDeleteAction.jsp?noticeID=<%=list.get(i).getNoticeID()%>">삭제</a></td>
									</tr>

									<%
									}
									%>

								</tbody>
							</table>
						<!-- 페이징 처리 -->
						<nav aria-label="Page navigation example">
						<div style="text-align: right;"><a type="button" class="btn btn-light"  href="adminNoticeWrite.jsp">글쓰기</a></div>
								<ul class="pagination justify-content-center">
									<%
									if (pageNumber == 1) {
									%>
									<li class="page-item disabled"><a class="page-link"
										href="adminNotice.jsp?pageNumber=<%=pageNumber - 1%>">이전</a></li>
									<%
									} else {
									%>
									<li class="page-item"><a class="page-link"
										href="adminNotice.jsp?pageNumber=<%=pageNumber - 1%>">이전</a></li>
									<%
									}
									%>
									<%
									int count = noticeDAO.getCount();
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
										href="adminNotice.jsp?pageNumber=<%=i%>"><%=i%> </a></li>
									<%
									} else {
									%>
									<li class="page-item"><a class="page-link"
										href="adminNotice.jsp?pageNumber=<%=i%>"><%=i%> </a></li>
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
										href="adminNotice.jsp?pageNumber=<%=pageNumber + 1%>">다음</a></li>
									<%
									} else {
									%>
									<li class="page-item "><a class="page-link"
										href="adminNotice.jsp?pageNumber=<%=pageNumber + 1%>">다음</a></li>
									<%
									}
									%>
									
								</ul>
								
								
							</nav>
						
						
						
						<!-- 페이징 처리 -->
						</div>
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

</body>
</html>



