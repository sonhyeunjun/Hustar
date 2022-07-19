<%@ page import="asg.AsgDAO" %>
<%@ page import="java.io.File" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		String directory = application.getRealPath("/uploadFile");
		// String directory = 	"C:/JSP/upload/";
		int maxSize = 1024 * 1024 * 100;
		String encoding = "UTF-8";
		
		
		MultipartRequest multipartRequest = new MultipartRequest(request, directory, maxSize, encoding, new DefaultFileRenamePolicy());
		
		String fileName = multipartRequest.getOriginalFileName("file");
		String fileRealName = multipartRequest.getFilesystemName("file");
		
		// 해당 확장자 이외의 파일은 업로드 할 수 없다
		if(!fileName.endsWith(".doc") && !fileName.endsWith(".hwp") && !fileName.endsWith(".pdf") && !fileName.endsWith(".xls") && !fileName.endsWith(".jpg") && !fileName.endsWith(".txt")){
			File file = new File(directory + fileName);
			file.delete();
			out.write("업로드 할 수 없는 확장자입니다.");
		} else{
			new AsgDAO().upload(directory, fileRealName);
			out.write("파일명 : " + fileName + "<br>");
			out.write("실제 파일명 : " + fileName + "<br>");
		}
	%>
</body>
</html>