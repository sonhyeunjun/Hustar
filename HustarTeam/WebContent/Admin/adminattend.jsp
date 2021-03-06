<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="attendance.AttendanceDAO"%>
<%@ page import="attendance.Attendance"%>
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
				<h1 class="mt-4">출석 관리</h1>
				<ol class="breadcrumb mb-4">
					<li class="breadcrumb-item"><a href="adminMain.jsp">메인</a></li>
					<li class="breadcrumb-item active">출석</li>
				</ol>
				<div class="card mb-4">
					<div class="card-header">
						<i class="fas fa-table me-1"></i> 출석
					</div>
					<div class="card-body">
						<table class="table">
							<thead class="thead-dark">
								<tr>
									<th>번호</th>
									<th>이름</th>
									<th>출석</th>
									<th>퇴근</th>
									<th>출석/결석</th>
								</tr>
							</thead>
							<tbody class="table-light">
								<%
								AttendanceDAO attendanceDAO = new AttendanceDAO();
								ArrayList<Attendance> list = attendanceDAO.getList(pageNumber);
								for (int i = 0; i < list.size(); i++) {
								%>
								<tr>
									<td><%=list.get(i).getSeq()%>
									<td><%=list.get(i).getUserid()%></td>

									<td><%=list.get(i).getIn().substring(0, 11) + list.get(i).getIn().substring(11, 13) + "시"
		+ list.get(i).getIn() + "분"%></td>
									<td><%=list.get(i).getOut().substring(0, 11) + list.get(i).getOut().substring(11, 13) + "시"
		+ list.get(i).getOut()+ "분"%></td>
									
									<td>
									
									<% 
									int att = Integer.parseInt(list.get(i).getAtt());
									if(att == 1 ){
										out.print("출석");
									}
									else{
										out.print("결석");
									}
										%></td>
									
									
								</tr>

								<%
								}
								%>

							</tbody>
						</table>
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



