<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=03dc0c1d6af4d7990e0d8728ccb7d5af"></script>
</head>
<body>
<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>

<script type="text/javascript">  

function loadPost() {

	//alert(navigator.geolocation)

	if (!!navigator.geolocation) {

		navigator.geolocation.getCurrentPosition(successCallback,errorCallback);  

	}else{

		alert("이 브라우저는 Geolocation를 지원하지 않습니다");

	}

}    



function errorCallback(error){

	alert(error.message);

}    

function successCallback(position) { 

	var lat = position.coords.latitude;

	var lng = position.coords.longitude;

	alert(lat+"---"+lng)

}

</script>
<div class="col-6 col-6" id="attmap">
							<div class="product__item" >
								<!-- 지도 테스트 -->
								<div id="map" style="width: 100%; height: 350px;"></div>
								<form action="attendAction.jsp" method="post">
									<input type="hidden" name="userID" />
									<button id="atend-btn" style="width: 100%; height: 50px;">출석하기</button>
								</form>
								<script src="/resource/js/map.js"></script>
								<!-- 지도 테스트 -->


							</div>
						</div>
</body>
</html>