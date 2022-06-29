<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="admin.AdminDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
request.setCharacterEncoding("UTF-8");
%>

<jsp:useBean id="admin" class="admin.Admin" scope="page"></jsp:useBean>
<jsp:setProperty name="admin" property="admin_id" />
<jsp:setProperty name="admin" property="admin_pw" />


<head>
<meta http-equiv="Content-Type" content="text/html; c harset=UTF-8">
<title>JSP BBS</title>
</head>
<body>


	<%
	
	
	String admin_id = null;
	if (session.getAttribute("admin_id") != null) {
		admin_id = (String) session.getAttribute("admin_id");
	}
	if (admin_id != null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 로그인이 되어있습니다.')");
		script.println("location.href = 'main.jsp'");
		script.println("</script>");
	}
	
	
	
	AdminDAO adminDAO = new AdminDAO();
	int result = adminDAO.login(admin.getAdmin_id(), admin.getAdmin_pw());
	if (result == 1) {
		//디비아이디 비번관 입력한것이 같으면 로그인하고 세션 부여
		session.setAttribute("admin_id", admin.getAdmin_id());
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'adminMain.jsp'");
		script.println("</script>");
	} else if (result == 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('비밀번호가 틀립니다.')");
		script.println("history.back()"); // 이전 페이지로 사용자를 보냄
		script.println("</script>");
	} else if (result == -1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('존재하지 않는 아이디입니다.')");
		script.println("history.back()"); // 이전 페이지로 사용자를 보냄
		script.println("</script>");
	} else if (result == -2) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('DB 오류가 발생했습니다.')");
		script.println("history.back()"); // 이전 페이지로 사용자를 보냄
		script.println("</script>");
	}
	%>

</body>
</html>