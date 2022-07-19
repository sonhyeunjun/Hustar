<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="notice.NoticeDAO" %>
<%@ page import="java.io.PrintWriter" %> <!-- 자바스크립트 문장사용 -->
<% request.setCharacterEncoding("UTF-8"); %> <!-- 건너오는 모든 파일을 UTF-8로 -->
<jsp:useBean id="notice" class="notice.Notice" scope="page"/>
<jsp:setProperty name="notice" property="noticeTitle" />
<jsp:setProperty name="notice" property="noticeContent" />
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
            script.println("location.href = 'adminlogin.jsp'");
            script.println("</script>");
        } else {
        if(notice.getNoticeTitle() == null || notice.getNoticeContent() == null) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('입력이 안된 사항이 있습니다.')");
            script.println("history.back()");
            script.println("</script>");
        } else {
            NoticeDAO noticeDAO = new NoticeDAO();
            int result = noticeDAO.write(notice.getNoticeTitle(), admin_id, notice.getNoticeContent());
                if(result == -1){ // 글쓰기에 실패했을 경우
                    PrintWriter script = response.getWriter(); //하나의 스크립트 문장을 넣을 수 있도록.
                    script.println("<script>");
                    script.println("alert('글쓰기에 실패했습니다.')");
                    script.println("history.back()");
                    script.println("</script>");
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