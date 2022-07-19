<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="assignment.Asg" %>
<%@ page import="assignment.AsgDAO" %>
<%@ page import="java.io.File" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="java.io.PrintWriter" %> <!-- 자바스크립트 문장사용 -->
<% request.setCharacterEncoding("UTF-8"); %> <!-- 건너오는 모든 파일을 UTF-8로 -->	
<jsp:useBean id="asg" class="assignment.Asg" scope="page"/>
<jsp:setProperty name="asg" property="asgTitle" />
<jsp:setProperty name="asg" property="asgContent" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
        String userID = null;
        // 로그인 된 사람은 글쓰기를 할수 없다.//
        if(session.getAttribute("userID") != null )
        {
        	userID = (String) session.getAttribute("userID");
        }
        
        AsgDAO asgDAO = new AsgDAO();
        
        String directory = application.getRealPath("/uploadFile");
		// String directory = 	"C:/JSP/upload/";
		int maxSize = 1024 * 1024 * 100;
		String encoding = "UTF-8";
		
		MultipartRequest multipartRequest = new MultipartRequest(request, directory, maxSize, encoding, new DefaultFileRenamePolicy());
		
		// enctype="multipart/form-data"으로 데이터를 받아와버려 null이 된 값을 새로 처리
		String asgTitle = multipartRequest.getParameter("asgTitle");
		String asgContent = multipartRequest.getParameter("asgContent");
		// 정상이 된 값을 새로 저장
		asg.setAsgTitle(asgTitle);
		asg.setAsgContent(asgContent);
		
		String fileName = multipartRequest.getOriginalFileName("asgFile");
		String fileRealName = multipartRequest.getFilesystemName("asgFile");
		
		// 정상이 된 값을 새로 저장
		asg.setFileName(fileName);
		asg.setFileRealName(fileRealName);
		
		// 해당 확장자 이외의 파일은 업로드 할 수 없다
		if(!fileName.endsWith(".doc") && !fileName.endsWith(".hwp") && !fileName.endsWith(".pdf") && !fileName.endsWith(".xls") && !fileName.endsWith(".jpg") && !fileName.endsWith(".txt")){
			File file = new File(directory + fileName);
			file.delete();
			out.write("업로드 할 수 없는 확장자입니다.");
		} else{
			
			out.write("파일명 : " + fileName + "<br>");
			out.write("실제 파일명 : " + fileRealName + "<br>");
		}
        
        if(userID == null)
        {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('로그인을 하세요')");
            script.println("location.href = '/member/login.jsp'");
            script.println("</script>");
        } else {
        if(asg.getAsgTitle() == null || asg.getAsgContent() == null) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('입력이 안된 사항이 있습니다.')");
            script.println("history.back()");
            script.println("</script>");
        } else {
            int result = asgDAO.write(asg.getAsgTitle(), userID, asg.getAsgContent(), asg.getFileName(), asg.getFileRealName());
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
                    script.println("location.href= 'asgList.jsp'");
                    script.println("</script>");
                    }
            }
        }
    %>
</body>
</html>