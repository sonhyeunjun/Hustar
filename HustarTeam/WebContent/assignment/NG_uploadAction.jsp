<%@ page import="asg.AsgDAO" %>
<%@ page import="java.io.File" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>파일 업로드 액션</title>
</head>
<body>
	<%
	String directory = application.getRealPath("/upload/");
	int maxSize = 1024*1024*10;
	String encoding = "UTF-8";
	
	MultipartRequest multipartRequest = new MultipartRequest(
			request, directory, maxSize, encoding, new DefaultFileRenamePolicy());
	String fileName = multipartRequest.getOriginalFileName("file");
	String fileRealName = multipartRequest.getFilesystemName("file");
	
	new AsgDAO().upload(fileName, fileRealName);
	out.write("파일명: " + fileName + "<br>");
	out.write("실제 파일명: " + fileRealName + "<br>");
	%>
</body>
</html>