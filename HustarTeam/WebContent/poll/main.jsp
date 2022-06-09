<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="description" content="Anime Template">
<meta name="keywords" content="Anime, unica, creative, html">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>Hustar | Template</title>

	<!-- Google Font -->
	<link href="https://fonts.googleapis.com/css2?family=Oswald:wght@300;400;500;600;700&display=swap" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css2?family=Mulish:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">
	<!-- css 파일 -->
	<link rel="stylesheet" href="/resource/css/common.css" type="text/css">

</head>
<body>

	<header>
	<%@ include file="/include/header.jsp"%>
	</header>
		
	
	<!-- 내용  -->
	
        <h3 style="color:white;">[설문조사]</h3>
	<br />
		
		<span style="color: #005766;">"원하시는 질문"</span>과 
		<span style="color: #99004C;">"항목"</span> <br/>
		그리고 <span style="color: #99004C;">"시간"</span> <br/>을 선택해주세요</h3>
		<hr width="600" />
	<form name="frm" method="post" action="pollInsertProc.jsp">
		<!-- 투표처리기능 pollInsertProc.jsp-->
			<table border="1" width="1000" hight="700" style="color:white;">
				<tr>
					<td style= "background-color:#005766; color: #FFFFFF; 
					font-size:18; text-align: center;"><b>질문</b></td>
					<td colspan="2"><input name="question" size="54"></td>
				</tr>
				<tr>
					<td style= "background-color: #99004C; color: #FFFFFF;
					font-size:18; text-align: center; "rowspan="30" >
					<b>항목</b></td>
					<%
						for (int i = 1; i <= 4; i++) {
							out.println("<td>" + (i * 2 - 1)
									+ ": <input name='item'></td>");
							out.println("<td>" + (i * 2)
									+ ": <input name='item'></td>");
							out.println("</tr>");
							if (i == 9) {
								out.println("");
							} else {
								out.println("<tr>");
							}
						}//for end
					%>
				<tr>
					<td style="text-align: center;">투표 시작일</td>
					<td colspan="2"><select name="sdateY">
							<option value="2019">2019
							<option value="2020">2020
					</select>년 <select name="sdateM">
							<%
								for (int i = 1; i <= 12; i++) {
									out.println("<option value='" + i + "'>" + i);
								}
							%>
					</select>월 <select name="sdateD">
							<%
								for (int i = 1; i <= 31; i++) {
									out.println("<option value='" + i + "'>" + i);
								}
							%>
					</select>일</td>
				</tr>
				<tr>
					<td style="text-align: center;">투표 마감일</td>
					<td colspan=2><select name="edateY">
							<option value="2019">2019
							<option value="2020">2020
					</select>년 <select name="edateM">
							<%
								for (int i = 1; i <= 12; i++) {
									out.println("<option value='" + i + "'>" + i);
								}
							%>
					</select>월 <select name="edateD">
							<%
								for (int i = 1; i <= 31; i++) {
									out.println("<option value='" + i + "'>" + i);
								}
							%>
					</select>일</td>
				</tr>
				<tr>
					<td style="text-align: center;">복수투표</td>
					<td colspan=2>
						<input type="radio" name="type" value="1" checked>네 
						<input type="radio" name="type" value="0">아니요
					</td>
				</tr>
				<tr>
					<td colspan=3>
						<input type="button" value="작성하기" onclick="send()"> 
						<input type="reset" value="다시쓰기"> 
						<input type="button" value="리스트" 
                         onClick="javascript:location.href='pollList.jsp'">
					</td>
				</tr>
			</table>
			<input type="hidden" name="sdate">
			<input type="hidden" name="edate">
		</form>
	


	<!-- footer 바닥글-->

	<%@ include file="/include/footer.jsp"%>



	<!-- 검색 -->
	<%@ include file="/include/search.jsp"%>



	<script src="/resource/js/jquery-3.3.1.min.js"></script>
	<script src="/resource/js/bootstrap.min.js"></script>
	<script src="/resource/js/player.js"></script>
	<script src="/resource/js/jquery.nice-select.min.js"></script>
	<script src="/resource/js/mixitup.min.js"></script>
	<script src="/resource/js/jquery.slicknav.js"></script>
	<script src="/resource/js/owl.carousel.min.js"></script>
	<script src="/resource/js/main.js"></script>


</body>

</html>