<%@page import="javax.servlet.http.Cookie"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="notice.NoticeDAO"%>
<%@ page import="attendance.AttendanceDAO"%>
<%@ page import="notice.Notice"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.InetAddress"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%
request.setCharacterEncoding("UTF-8");
%>

<%
int pageNumber = 1; // 기본페이지 기본적으로 페이지 1부터 시작하므로
if (request.getParameter("pageNumber") != null) {
	pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
}
%>
<%
request.setCharacterEncoding("UTF-8");

Calendar cal = Calendar.getInstance(); // 인스턴스한 Calendar 객체 생성, 모두와 공유하는 객체

// 시스템 오늘날짜
int ty = cal.get(Calendar.YEAR);
int tm = cal.get(Calendar.MONTH) + 1; // Calendar 클래스는 월이 0~11로 정의되어서 +1
int td = cal.get(Calendar.DATE);

int year = cal.get(Calendar.YEAR);
int month = cal.get(Calendar.MONTH) + 1;

// 파라미터 받기
String sy = request.getParameter("year"); // year 값 받아오기
String sm = request.getParameter("month"); // month 값 받아오기

if (sy != null) { // 넘어온 파라미터가 있으면
	year = Integer.parseInt(sy); // String으로 받아온 year 값을 int로 변환
}
if (sm != null) {
	month = Integer.parseInt(sm); // String으로 받아온 month 값을 int로 변환
}

cal.set(year, month - 1, 1); // 현재 년, 현재 월, 1일로 설정
year = cal.get(Calendar.YEAR);
month = cal.get(Calendar.MONTH) + 1;

int week = cal.get(Calendar.DAY_OF_WEEK); // 1(일)~7(토), 매 월 1일의 요일을 표시
%>
<%
//데이터베이스를 연결하는 관련 변수를 선언한다
Connection conn = null;
PreparedStatement pstmt = null;
//데이터베이스를 연결하는 관련 정보를 문자열로 선언한다.
String dbDriver = "com.mysql.cj.jdbc.Driver"; //JDBC 드라이버의 클래스 경로
String dbURL = "jdbc:mysql://database1.chfhjyvwugph.ap-northeast-2.rds.amazonaws.com/database1"; //접속하려는 데이터베이스의 정보
String dbID = "root";
String dbPassword = "Thsguswns";
//JDBC 드라이버 클래스를 로드한다.
Class.forName(dbDriver);
//데이터베이스 연결 정보를 이용해서 Connection 인스턴스를 확보한다.
conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
if (conn == null) {
	out.println("Calendar 데이터베이스 연결 실패");
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="description" content="Anime Template">
<meta name="keywor ds" content="Anime, unica, creative, html">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">

<title>메인페이지</title>
<!-- Google Font -->
<link
	href="https://fonts.googleapis.com/css2?family=Oswald:wght@300;400;500;600;700&display=swap"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Mulish:wght@300;400;500;600;700;800;900&display=swap"
	rel="stylesheet">
<!-- css 파일 -->
<link rel="stylesheet" href="/resource/css/common.css" type="text/css">


<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=03dc0c1d6af4d7990e0d8728ccb7d5af"></script>
<%
String id = (String) session.getAttribute("userID");
String name = "";
String value = "";
String cookie = request.getHeader("Cookie");
if(cookie != null){
Cookie[] cookies = request.getCookies() ;
	
	for(int i=0; i < cookies.length; i++){
		if(cookies[i].getName().equals("att")){
		
		name = cookies[i].getName();// 저장된 쿠키 이름을 가져온다
		value = cookies[i].getValue() ;// 쿠키값을 가져온다
		}
	System.out.println(name);
	System.out.println(value);		
	}
	
}
%>

</head>
<body>


	<header>
		<%@ include file="/include/header.jsp"%>
	</header>
	


	<!-- 내용11  -->

	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<div class="product__page__content">
					<div class="row">
						<div class="col-12" id="calendar">
							<div class="calendaronly">
								<!-- 달력 테스트 -->
								<div>
									<table>
										<thead>
											<tr class="days">
												<td>Sunday</td>
												<td>Monday</td>
												<td>Tuesday</td>
												<td>Wednesday</td>
												<td>Thursday</td>
												<td>Friday</td>
												<td>Saturday</td>
											</tr>
										</thead>
										<tbody>
											<%
											// 1일 앞 달
											Calendar preCal = (Calendar) cal.clone();
											preCal.add(Calendar.DATE, -(week - 1)); // week-1 = 첫째 주에서 앞 달의 범위
											int preDate = preCal.get(Calendar.DATE); // -(week-1) = 첫째 주에서 앞 달의 범위만큼 역으로 계산

											out.print("<tr>");
											// 1일 앞 부분
											for (int i = 1; i < week; i++) {
												out.print("<td class='gray'>" + (preDate++) + "</td>");
											}

											// 1일부터 말일까지 출력
											int lastDay = cal.getActualMaximum(Calendar.DATE); // 현재 달의 최대 날짜
											String cls;
											for (int i = 1; i <= lastDay; i++) {
												cls = year == ty && month == tm && i == td ? "today" : ""; // 시스템 시간과 날짜가 같으면 cls = today가 된다
												out.print("<td class='" + cls + "'>" + i + "<br><table><tr><td id='note'>"); // class="today"의 스타일 적용

												//메모(일정) 추가 부분
												int memoyear, memomonth, memoday;
												try {
													// select 문장을 문자열 형태로 구성한다.
													String sql = "SELECT cmYear, cmMonth, cmDay, cmContents FROM calendarmemo";
													pstmt = conn.prepareStatement(sql);
													// select 를 수행하면 데이터 정보가 ResultSet 클래스의 인스턴스로 리턴
													ResultSet rs = pstmt.executeQuery();
													while (rs.next()) { // 마지막 데이터까지 반복함.
												//날짜가 같으면 데이터 출력
												memoyear = rs.getInt("cmYear");
												memomonth = rs.getInt("cmMonth");
												memoday = rs.getInt("cmDay");
												if (year == memoyear && month + 1 == memomonth + 1 && i == memoday) {
													out.println(rs.getString("cmContents") + "<br/>");
												}
													}
													rs.close();
												} catch (Exception e) {
													System.out.println(e);
												}
												;

												out.print("</td></tr></table></td>");
												if (lastDay != i && (++week) % 7 == 1) {
													out.print("</tr><tr>");
												}
											}

											// 마지막 주 마지막 일자 다음 처리
											int n = 1;
											for (int i = (week - 1) % 7; i < 6; i++) {
												out.print("<td class='gray'>" + (n++) + "</td>");
											}
											out.print("</tr>");
											%>
										</tbody>
									</table>
								</div>
								<!-- 달력 테스트 -->




								<div class="product__item__text"></div>
							</div>
						</div>
						<div class="col-6 col-6" id="notice">
							<div class="product__item">
								<!-- 공지사항 간단히 보기 -->

								<table class="table table-striped" style="width: 100%">
									<thead class="table-light">
										<div class="table-top">
										공지사항
										</div>
										<tr>
											<th></th>
											<th>제목</th>
											<th>작성자</th>
											<th>작성일</th>
										</tr>
									</thead>
									<tbody class="table-light">
										<%
										NoticeDAO noticeDAO = new NoticeDAO();
										ArrayList<Notice> list = noticeDAO.getList(pageNumber);

										if (list.size() >= 5) {
											for (int i = 0; i < 5; i++) {
										%>
										<tr>
											<td><%=list.get(i).getNoticeID()%></td>
											<td><%=list.get(i).getNoticeTitle()%></td>
											<td><%=list.get(i).getAdminID()%></td>
											<td><%=list.get(i).getNoticeDate().substring(0, 11) + list.get(i).getNoticeDate().substring(11, 13) + "시"
		+ list.get(i).getNoticeDate().substring(14, 16) + "분"%></td>
										</tr>

										<%
										}
										} else {
										for (int i = 0; i < list.size(); i++) {
										%>

										<tr>
											<td><%=list.get(i).getNoticeID()%></td>
											<td><%=list.get(i).getNoticeTitle()%></td>
											<td><%=list.get(i).getAdminID()%></td>
											<td><%=list.get(i).getNoticeDate().substring(0, 11) + list.get(i).getNoticeDate().substring(11, 13) + "시"
		+ list.get(i).getNoticeDate().substring(14, 16) + "분"%></td>
										</tr>

										<%
										}
										}
										%>

									</tbody>
								</table>
								<!-- 공지사항 간단히 보기 -->
							</div>
						</div>
						<div class="col-6 col-6" id="attmap">
							<div class="product__item">
								<!-- 지도 테스트 -->
								<div id="map" style="width: 100%; height: 350px;"></div>
								<form action="Attend/attendAction.jsp" method="get">
									<input type="hidden" name="userID" />
									<%
									if (id == null) {
									%>
									<button id="atend-btn" style="width: 100%; height: 50px;"
										name="state" disabled="false" onclick="btn_click">로그인
										후 이용 가능합니다</button>
									<%
									} else {
									%>
									<%
									System.out.print("값 확인용 : "+value);
									if(value.equals("att_succes")){
									%>
									<button id="atend-btn" style="width: 100%; height: 50px;" name="state" value="out" >퇴실하기</button>
									<%	
									}else if(value.equals("att_before")){
									%>
									<button id="atend-btn" style="width: 100%; height: 50px;" name="state" value="in" >출석하기</button>
									<%
									}}
									%>
								</form>
								<script src="/resource/js/map.js"></script>
								<!-- 지도 테스트 -->


							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>




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