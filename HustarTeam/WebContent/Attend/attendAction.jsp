<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="attendance.AttendanceDAO"%>
<%@ page import="java.io.PrintWriter"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page"></jsp:useBean>
<jsp:setProperty name="user" property="userID" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<script>
		
	</script>
	<%
	String state = request.getParameter("state");
	String userID = null;
		AttendanceDAO attendanceDAO = new AttendanceDAO();
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	if (userID == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인후 이용가능합니다')");
		script.println("location.href='../index.jsp'");
		script.println("</script>");
	} else {
		if(state.equals("n")){ // 출석할때 
			
        int result = attendanceDAO.in_class(userID);
        if(result  == 1 ){
        	PrintWriter script = response.getWriter();
    		script.println("<script>");
    		script.println("alert('출석 완료')");
    		script.println("location.href='../index.jsp'");
    		script.println("</script>");
        }else{
        	
           int result2 = attendanceDAO.out_class(userID);
            if(result  == 1 ){
            	PrintWriter script = response.getWriter();
        		script.println("<script>");
        		script.println("alert('퇴실 완료')");
        		script.println("location.href='../index.jsp'");
        		script.println("</script>");
        }
			
		}
        
       
	}}
	%>
	<%
	/*로직 :
		-원안에 있으면 버튼활성화 
		-버튼 클릭시 로그인 되어있는지 확인후
		-로그인상태면 출석 기능 
		-아니면 메시지를 뜨위고, 이전 화면으로 (아니면 로그인화면)
	*/
	%>
</body>
</html>