<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/include/dbcon.jsp"%>
<%@ page import="java.util.Calendar"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%

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
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Hustar Calendar</title>
<link rel="stylesheet" type="text/css" href="/resource/css/calendar/calendar.css">
<script type="text/javascript">
	// 선택한 연/달로 이동
	function change() {
		var f = document.frm;
		f.action = "calendar.jsp";
		f.submit();
	}
</script>

</head>


<body>

	<div class="calendar">
		<div class="title">
			<form name="frm" method="post">
				<select name="year" class="selectField" onchange="change()">
					<%
					for (int i = year - 5; i <= year + 5; i++) {
					%>
					<option value="<%=i%>" <%=year == i ? "selected='selected'" : ""%>><%=i%>년
					</option>
					<%
					}
					%>
				</select> <select name="month" class="selectField" onchange="change()">
					<%
					for (int i = 1; i <= 12; i++) {
					%>
					<option value="<%=i%>" <%=month == i ? "selected='selected'" : ""%>><%=i%>월
					</option>
					<%
					}
					%>
				</select>
			</form>
		</div>
		</div>
		<table>
			<thead>
				<tr>
					<td>일</td>
					<td>월</td>
					<td>화</td>
					<td>수</td>
					<td>목</td>
					<td>금</td>
					<td>토</td>
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

		<div class="footer">
			<a href="calendar.jsp">오늘날짜로</a>
		</div>

	</div>

	<div>
		<%-- <%
		int inyear = 0;
		int inmonth = 0;
		int inday = 0;
		String incontents = null;
		String sql = "INSERT INTO calendarmemo VALUES (?, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(sql);
			/* ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
			String incontents = rs.getString("cmContents");
			int inyear = rs.getInt("cmYear");
			int inmonth = rs.getInt("cmMonth");
			int inday = rs.getInt("cmDay");
			} */
			pstmt.setString(1, incontents);
			pstmt.setInt(2, inyear);
			pstmt.setInt(3, inmonth);
			pstmt.setInt(4, inday);

			int suc = pstmt.executeUpdate();
			out.print(suc);
		} catch (Exception e) {
			// TODO: handle exception
		}
		%> --%>
		<form action="insertMemo.jsp" method="post">
			<div class="memo">

				<select name="inyear">
					<%
					for (int i = year - 5; i <= year + 5; i++) {
					%>
					<option value="<%=i%>" <%=year == i ? "selected='selected'" : ""%>><%=i%>년
					</option>
					<%
					}
					%>
				</select> <select name="inmonth">
					<%
					for (int i = 1; i <= 12; i++) {
					%>
					<option value="<%=i%>" <%=month == i ? "selected='selected'" : ""%>><%=i%>월
					</option>
					<%
					}
					%>
				</select> <select name="inday">
					<%
					for (int i = 1; i <= lastDay; i++) {
					%>
					<option value="<%=i%>" <%=td == i ? "selected='selected'" : ""%>><%=i%>일
					</option>
					<%
					}
					%>
				</select><br /> <br /> <label>메모</label> <input type="text"
					name="incontents" /><br /> <br />
				<button type="submit">저장</button>
			</div>
		</form>
	</div>


</body>
</html>