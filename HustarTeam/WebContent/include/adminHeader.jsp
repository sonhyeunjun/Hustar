<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- 상단 바 부분 -->
  <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <!-- Navbar Brand-->
            <a class="navbar-brand ps-3" href="/Admin/adminMain.jsp">관리자 페이지</a>
            <!-- Sidebar Toggle-->
            <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle" href="#!"><i class="fas fa-bars"></i></button>
            <!-- Navbar Search-->
            <form class="d-none d-md-inline-block form-inline ms-auto me-0 me-md-3 my-2 my-md-0">
                <div class="input-group">
               
                   
              </div>
            </form>
            <!-- Navbar-->
            <ul class="navbar-nav ms-auto ms-md-0 me-3 me-lg-4">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false"><i class="fas fa-user fa-fw"></i></a>
                    <%
                    
                    %>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                        <li><a class="dropdown-item" href="#!">환경설정</a></li>
                        <li><a class="dropdown-item" href="#!">활동 로그</a></li>
                        <li><hr class="dropdown-divider" /></li>
                        <!-- 로그인 세션 해야됨 -->
                        <li><a class="dropdown-item" href="adminLogout.jsp">로그아웃</a></li>
                    </ul>
                    
                </li>
            </ul>
        </nav>
<!-- 상단 바 부분 -->
</body>
</html>

<%
				//세션
					String SESSION_ID = (String) session.getAttribute("SessionUserID");
				//로그인하지 않았기
					if( SESSION_ID  == null){
				%>
				<div class="col-lg-2">
					<div class="header__right">
						<!-- 검색하기 -->
						 <a href="https://www.youtube.com/channel/UCDnykcJVR0hIrG98YvF8lKg " target='_blank'><span class="social_youtube"></span></a>
                        <a href="/member/login.jsp"><span class="icon_profile"></span></a>	

					</div>
				</div>
				<%
					}else{
				%>
					<div class="col-lg-2">
					<div class="header__right">
						<!-- 검색하기 -->
						<a href="/member/logout.jsp"><span class="icon_lock-open"></span></a>
                        <a href="/member/registerModify.jsp"><%=SESSION_ID %>님<span class="icon_profile"></span></a>	
                        
					</div>
				</div>
				<% 	
					}
				%>