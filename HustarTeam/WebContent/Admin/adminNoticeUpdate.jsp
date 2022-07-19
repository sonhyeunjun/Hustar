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

<%
    String admin_id = null; // 로그인이 된 사람들은 로그인정보를 담을 수 있도록한다
    if (session.getAttribute("admin_id") != null)
    {
    	admin_id = (String)session.getAttribute("admin_id");
    }
    if (admin_id == null)
    {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('로그인을 하세요')");
        script.println("location.href = 'adminlogin.jsp'");
        script.println("</script>");
    }
    
    int noticeID = 0;
    if (request.getParameter("noticeID") != null)
    {
    	noticeID = Integer.parseInt(request.getParameter("noticeID"));
    }
    if (noticeID == 0)
    {
    	
    	System.out.print("유효하지않은 아이디");
    	System.out.print(noticeID);
    	System.out.print(request.getParameter("noticeID"));
    	
    	System.out.print("유효하지않은 아이디");
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('유효하지 않은 글입니다')");
        script.println("location.href = 'adminNotice.jsp'");
        script.println("</script>");
    }

       Notice notice = new NoticeDAO().getNotice(noticeID);
    if (!admin_id.equals(notice.getAdminID()))
    {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('권한이 없습니다')");
        script.println("location.href = 'bbs.jsp'");
        script.println("</script>");
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
<title>게시물 수정</title>
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
					<h1 class="mt-4">대시보드</h1>
					<ol class="breadcrumb mb-4">
						<li class="breadcrumb-item active">대시보드</li>
					</ol>
				
					<div class="card mb-4">
						<div class="card-header">
							<i class="fas fa-table me-1"></i> 공지사항 수정하기
						</div>
						<!--  공지사항 수정 양식 -->
						<div class="container">
							<div class="row">
								<form method="post" action="adminNoticeUpdateAction.jsp?noticeID=<%=noticeID%>">
									<table class="table table-striped"
										style="text-align: center; border: 1px solid #dddddd">
										<thead>
											<tr>
												<th colspan="2"
													style="background-color: #eeeeee; text-align: center;">게시판
													글 수정 양식</th>

											</tr>
										</thead>
										<tbody>
											<tr>
												<td><input type="text" class="form-control"
													placeholder="글 제목" name="noticeTitle" maxlength="50" 
													value="<%=notice.getNoticeTitle()%>"></td>
											</tr>
											<tr>
												<td><textarea class="form-control" placeholder="글 내용"
														name="noticeContent" maxlength="2048" style="height: 350px"><%=notice.getNoticeContent()%></textarea></td>
											</tr>
										</tbody>
									</table>
									<input type="submit" class="btn btn-primary pull-right" value="글수정">
								</form>
							</div>
						</div>
						<!-- 공지사항 수정 양식 -->
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
