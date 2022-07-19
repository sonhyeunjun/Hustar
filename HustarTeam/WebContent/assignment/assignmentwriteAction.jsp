<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="asg.AsgDAO"%>
<!-- 자바스크립트 문장사용 -->
<%
request.setCharacterEncoding("UTF-8");
%>
<!-- 건너오는 모든 파일을 UTF-8로 -->
<jsp:useBean id="asg" class="asg.Asg" scope="page" />
<jsp:setProperty name="asg" property="asgTitle" />
<jsp:setProperty name="asg" property="asgContent" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
    String admin_id = null;
    // 로그인 된 사람은 글쓰기를 할수 없다.//
    if(session.getAttribute("admin_id") != null )
    {
    	admin_id = (String) session.getAttribute("admin_id");
    }
    if(admin_id == null)
    {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인 을 하세요.')");
		script.println("location.href ='/Admin/adminlogin.jsp'");
		script.println("</script>");
	} else {
		if (asg.getAsgTitle() == null || asg.getAsgContent() == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else {
			AsgDAO asgDAO = new AsgDAO();
			int result = asgDAO.asgWrite(asg.getAsgTitle(), admin_id, asg.getAsgContent(),asg.getFilename(),asg.getFileRealName());
			if (result == -1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('글쓰기에 실패했습니다')");
		script.println("history.back()");
		script.println("</script>");
			} else {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href='/Admin/adminhome.jsp'");
		script.println("</script>");
			}
		}

	}
	%>
</body>
</html>