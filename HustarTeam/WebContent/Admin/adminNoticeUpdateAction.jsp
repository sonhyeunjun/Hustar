<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="notice.NoticeDAO" %>
<%@ page import="notice.Notice" %>
<%@ page import="java.io.PrintWriter" %> <!-- 자바스크립트 문장사용 -->
<% request.setCharacterEncoding("UTF-8"); %> <!-- 건너오는 모든 파일을 UTF-8로 -->


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
            script.println("alert('로그인을 하세요')");
            script.println("location.href = 'login.jsp'");
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
        
        else {
        if(request.getParameter("noticeTitle")== null || request.getParameter("noticeContent")== null) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('입력이 안된 사항이 있습니다.')");
            script.println("history.back()");
            script.println("</script>");
        } else {
            NoticeDAO noticeDAO = new NoticeDAO();
            int result = noticeDAO.update(noticeID, request.getParameter("noticeTitle"), request.getParameter("noticeContent"));
            
                if(result == -1){ // 글쓰기에 실패했을 경우
                    PrintWriter script = response.getWriter(); //하나의 스크립트 문장을 넣을 수 있도록.
                    script.println("<script>");
                    script.println("alert('글수정에 실패했습니다.')");
                    script.println("history.back()");
                    script.println("</script>");
                   // System.out.print(result);
                   // System.out.print(noticeID);
                   // System.out.print(request.getParameter("noticeTitle"));
                   // System.out.print(request.getParameter("noticeContent"));
                }
                else { // 글쓰기에 성공했을 경우
                    PrintWriter script = response.getWriter();
                    script.println("<script>");
                    script.println("location.href= 'adminNotice.jsp'");
                    script.println("</script>");
                    }
            }
        }
    %>
</body>
</html>