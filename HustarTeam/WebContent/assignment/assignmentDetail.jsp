<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="assignment.AsgDAO"%>
<%@ page import="assignment.Asg"%>
<%@ page import="java.util.*"%>

<%
int pageNumber = 1; // 기본페이지 기본적으로 페이지 1부터 시작하므로
if (request.getParameter("pageNumber") != null) {
	pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
}

int asgID = 0;
if (request.getParameter("asgID") != null) {
	asgID = Integer.parseInt(request.getParameter("asgID"));
}

if (asgID == 0) {
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alret('유효하지 않은 글 입니다!.')");
	script.println("</script>");
}

Asg asg = new AsgDAO().getAssignment(asgID);
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
<title>과제제출 상세보기</title>
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
				<h1 class="mt-4">과제 관리</h1>
				<ol class="breadcrumb mb-4">
					<li class="breadcrumb-item"><a href="/Admin/adminMain.jsp">메인</a></li>
					<li class="breadcrumb-item active">과제</li>
				</ol>
				<div class="card mb-4">
					<div class="card-header">
						<i class="fas fa-table me-1"></i> 과제제출
					</div>
					<div class="card-body">
					<form method="post" action="assignmentUpdate.jsp?asgID=<%=asgID%>">
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
									<td colspan="2"><%=asg.getAsgTitle() %></td>
								</tr>
								<tr>
									<td>작성자 :</td>
									<td colspan="2"><%=asg.getUserID()%></td>
								</tr>
								<tr>
									<td>작성일자 :</td>
									<td colspan="2"><%=asg.getAsgDate()%></td>
								</tr>
								<tr>
									<td>내용</td>
									<td colspan="2" style="min-height: 200px; text-align: left;"><%=asg.getAsgContent()%></td>
								</tr>
								<tr>
									<td>파일</td>
									<td colspan="2" style="min-height: 200px; text-align: left;"><%=asg.getFileRealName()%></td>
								</tr>
							
							</tbody>
						</table>
						<div class="product__pagination1"
							style="text-align: right; margin-top: 8px;">
							<input type="submit" class="btn btn-primary pull-right" value="글수정">
							<button type="button" class="btn btn-outline-dark" onclick="history.back();">취소</button>
						</div>
						</form>
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
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		crossorigin="anonymous"></script>
	<script src="/resource/js/scripts.js"></script>

</body>
</html>



