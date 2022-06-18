var latitude;
var longitude;

var adminlet = 35.9119174;
var adminlong = 128.811044;
        // 35.9120885004617, 128.8112570975471
        //대가대 수업장소35.912088, 128.811257

navigator.geolocation.getCurrentPosition(function(pos) {
    console.log(pos);
     latitude = pos.coords.latitude;
     longitude = pos.coords.longitude;
    alert("현재 위치는 : " + latitude + ", "+ longitude);
});
//--


//지도생성
var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
var options = { //지도를 생성할 때 필요한 기본 옵션
	center: new kakao.maps.LatLng(adminlet, adminlong), //지도의 중심좌표.
	level: 3 //지도의 레벨(확대, 축소 정도)
};

var map = new kakao.maps.Map(container, options); //지도 생성 및

var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new kakao.maps.LatLng(adminlet, adminlong), // 지도의 중심좌표
        draggable: false, // 지도를 생성할때 지도 이동 및 확대/축소를 막으려면 draggable: false 옵션을 추가하세요
        level: 3 // 지도의 확대 레벨
    };

var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

// 버튼 클릭에 따라 지도 이동 기능을 막거나 풀고 싶은 경우에는 map.setDraggable 함수를 사용합니다
function setDraggable(draggable) {
    // 마우스 드래그로 지도 이동 가능여부를 설정합니다
    map.setDraggable(draggable);    
}


// 지도에 표시할 원을 생성합니다
var circle = new kakao.maps.Circle({
    center : new kakao.maps.LatLng(adminlet, adminlong),  // 원의 중심좌표 입니다 
    radius: 80, // 미터 단위의 원의 반지름입니다 
    strokeWeight: 5, // 선의 두께입니다 
    strokeColor: '#75B8FA', // 선의 색깔입니다
    strokeOpacity: 1, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
   // strokeStyle: 'dashed', // 선의 스타일 입니다
    fillColor: '#CFE7FF', // 채우기 색깔입니다
    fillOpacity: 0.7  // 채우기 불투명도 입니다   
}); 

// 지도에 원을 표시합니다 
circle.setMap(map); 


//마커 생성
// HTML5의 geolocation으로 사용할 수 있는지 확인합니다 

var locPosition ;
if (navigator.geolocation) {
    
    // GeoLocation을 이용해서 접속 위치를 얻어옵니다
    navigator.geolocation.getCurrentPosition(function(position) {
        
        var lat = position.coords.latitude, // 위도
            lon = position.coords.longitude; // 경도
        
        locPosition = new kakao.maps.LatLng(lat, lon), // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
            message = '<div>여기에 계신가요?!</div>'; // 인포윈도우에 표시될 내용입니다
        
        // 마커와 인포윈도우를 표시합니다
        displayMarker(locPosition, message);
            
      });
    
} else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다
    
    locPosition = new kakao.maps.LatLng(latitude, longitude),    
        message = 'geolocation을 사용할수 없어요..'
        
    displayMarker(locPosition, message);
}

// 지도에 마커와 인포윈도우를 표시하는 함수입니다
var isAttendance = false;
function displayMarker(locPosition) {
var imageSrc = 'https://ssl.pstatic.net/static/maps/m/pin_rd.png', // 마커이미지의 주소입니다    
    imageSize = new kakao.maps.Size(25, 25), // 마커이미지의 크기입니다
    imageOption = {offset: new kakao.maps.Point(27, 69)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption)
    // 마커를 생성합니다
    	var marker = new kakao.maps.Marker({  
        map: map, 
        position: locPosition,
        image : markerImage
    }); 
	marker.setMap(map);
    // 지도 중심좌표를 접속위치로 변경합니다
    map.setCenter(locPosition);      
var center = circle.getPosition();
var radius = circle.getRadius();
var line = new kakao.maps.Polyline();
    // 마커의 위치와 원의 중심을 경로로 하는 폴리라인 설정
    var path = [ marker.getPosition(), center ];
    line.setPath(path);
    // 마커와 원의 중심 사이의 거리
    var dist = line.getLength();
    // 이 거리가 원의 반지름보다 작거나 같다면
    if (dist <= radius) {
        // 해당 marker는 원 안에 있는 것
        console.log("원안에있습니다");
        isAttendance = true;
    }else{ console.log("원밖에있습니다")}
}  





