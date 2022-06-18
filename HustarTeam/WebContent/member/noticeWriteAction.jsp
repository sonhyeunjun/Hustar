<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="notice.NoticeDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="notice" class="notice.Notice" scope="page" />
<jsp:setProperty name="notice" property="noticeTitle" />
<jsp:setProperty name="notice" property="noticeContent" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	if(userID == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인 을 하세요.')");
		script.println("location.href ='login.jsp'");
		script.println("</script>");
	} else {
		if(notice.getNoticeTitle() == null || notice.getNoticeContent() ==null ){			
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else{
			NoticeDAO noticeDAO = new NoticeDAO();
			int result = noticeDAO.noticeWrite(notice.getNoticeTitle(), userID, notice.getNoticeContent());
			if(result == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글쓰기에 실패했습니다')");
				script.println("history.back()");
				script.println("</script>");
			}
			else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href='notice.jsp'");
				script.println("</script>");
			}
		}
		
	}
		
	%>
</body>
</html>