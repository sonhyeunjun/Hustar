<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="attendance.AttendanceDAO"%>
<%@ page import="attendance.Attendance"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="notice.NoticeDAO"%>
<%@ page import="notice.Notice"%>
<%@ page import="assignment.AsgDAO"%>
<%@ page import="assignment.Asg"%>
<%@ page import="cal.CalDAO"%>
<%@ page import="cal.Cal"%>
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
<title>관리자페이지</title>
<link
	href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css"
	rel="stylesheet" />
<link href="/resource/css/adminstyles.css" rel="stylesheet" />
<script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js"
	crossorigin="anonymous"></script>
<meta charset="UTF-8">
</head>
<body class="sb-nav-fixed">

	<!-- 상단 네비바  -->
	<%@ include file="/include/adminHeader.jsp"%>


	<%@ include file="/include/adminside.jsp"%>

	<div id="layoutSidenav_content">
		<main>
			<div class="container-fluid px-4">
				<h1 class="mt-4">관리자 페이지</h1>
				<ol class="breadcrumb mb-4">
					<li class="breadcrumb-item active">메인</li>
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
		+ list.get(i).getNoticeDate().substring(14, 16) + "분"%></td>
								</tr>

								<%
								}
								%>

							</tbody>
						</table>
						<div class="card text-center opacity-75">
							<a href="adminNotice.jsp" class="btn btn-light text-center">더
								보기</a>
						</div>

					</div>
				</div>
				<div class="card mb-4">
					<div class="card-header">
						<i class="fas fa-chart-bar me-1"></i> 출석부
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
								ArrayList<Attendance> list3 = attendanceDAO.getList(pageNumber);
								for (int i = 0; i < list3.size(); i++) {
								%>
								<tr>
									<td><%=list3.get(i).getSeq()%>
									<td><%=list3.get(i).getUserid()%></td>

									<td><%=list3.get(i).getIn().substring(0, 11) + list3.get(i).getIn().substring(11, 13) + "시"
		+ list3.get(i).getIn().substring(14, 16) + "분"%></td>
									<td><%=list3.get(i).getOut().substring(0, 11) + list3.get(i).getOut().substring(11, 13) + "시"
		+ list3.get(i).getOut().substring(14, 16) + "분"%></td>
									
									<td>
									
									<% 
									int att = Integer.parseInt(list3.get(i).getAtt());
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
						<div class="card text-center opacity-75">
							<a href="adminattend.jsp" class="btn btn-light text-center">더
								보기</a>
						</div>
					</div>
				</div>
				<div class="card mb-4">
					<div class="card-header">
						<i class="fas fa-chart-bar me-1"></i> 일정관리
					</div>
					<div class="card-body">
						<table class="table">
							<thead class="thead-dark">
								<tr>
									<th>번호</th>
									<th>날짜</th>
									<th>수업 명</th>
								</tr>
							</thead>
							<tbody class="table-light">
								<%
								CalDAO calDAO = new CalDAO();
								ArrayList<Cal> list2 = calDAO.getList(pageNumber);
								for (int i = 0; i < list2.size(); i++) {
								%>
								<tr>
									<td><%=list2.get(i).getCalID()%></td>
									<td><%=list2.get(i).getCmYear() + "년" + list2.get(i).getCmMonth() + "월" + list2.get(i).getCmDay() + "일"%></td>
									<td><%=list2.get(i).getCmContents() %></td>

								</tr>

								<%
								}
								%>

							</tbody>
						</table>
						<div class="card text-center opacity-75">
							<a href="admincal.jsp" class="btn btn-light text-center">더
								보기</a>
						</div>
					</div>
				</div>
				<div class="card mb-4">
					<div class="card-header">
						<i class="fas fa-chart-bar me-1"></i> 과제제출
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
								AsgDAO asgDAO = new AsgDAO();
								ArrayList<Asg> list1 = asgDAO.getList(pageNumber);
								for (int i = 0; i < list1.size(); i++) {
								%>
								<tr>
									<td><%=list1.get(i).getAsgID()%></td>
									<td><%=list1.get(i).getAsgTitle()%></td>
									<td><%=list1.get(i).getAsgContent()%></td>
									<td><%=list1.get(i).getAsgDate().substring(0, 11) + list1.get(i).getAsgDate().substring(11, 13) + "시"
		+ list1.get(i).getAsgDate().substring(14, 16) + "분"%></td>
								</tr>

								<%
								}
								%>

							</tbody>
						</table>
						<div class="card text-center opacity-75">
							<a href="adminhome.jsp" class="btn btn-light text-center">더
								보기</a>
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

	<!-- js include -->
	<%@ include file="/include/adminJS.jsp"%>
</body>
</html>
