<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" />
<jsp:setProperty name="user" property="userName" />
<jsp:setProperty name="user" property="userGender" />
<jsp:setProperty name="user" property="userBirth" />
<jsp:setProperty name="user" property="userUniversity" />
<jsp:setProperty name="user" property="userMobile" />
<jsp:setProperty name="user" property="userEmail" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP 게시판 웹 사이트</title>
</head>
<body> 
	<%
		System.out.print(user.getUserID());
		System.out.print(user.getUserPassword());
		System.out.print(user.getUserName());
		System.out.print(user.getUserGender());
		System.out.print(user.getUserBirth());
		System.out.print(user.getUserUniversity());
		System.out.print(user.getUserEmail());
		System.out.print(user.getUserMobile());
		if(user.getUserID() == null || user.getUserPassword() == null || user.getUserName() == null || user.getUserGender() == null || user.getUserBirth() == null || user.getUserUniversity() == null || user.getUserMobile() == null || user.getUserEmail() == null ){			
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else{
			UserDAO userDAO = new UserDAO();
			int result = userDAO.join(user);
			if(result == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('이미 존재하는 아이디입니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
			else {
				PrintWriter script = response.getWriter();
				session.setAttribute("userID", user.getUserID());
				script.println("<script>");
				script.println("alert('회원가입이 완료되었습니다.')");
				script.println("location.href='../index.jsp'");
				script.println("</script>");
			}
		}
	%>
</body>
</html>