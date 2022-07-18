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
<script type="text/javascript" src="/resource/js/jquery.min.js"></script>
<script type="text/javascript" src="/resource/js/qrcode/qrcode.js"></script>
<script type="text/javascript" src="/resource/js/qrcode/jsQR.js"></script>
<script type="text/javascript" src="/resource/js/qrcode/index.js"></script>


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
		
	
	<!-- 내용1  -->
	
          <h3 style="color:white;" >[출결신호]</h3>
        
        <div id="qrcode"></div>
    
    <script type="text/javascript">
    // qr코드 생성
    var qrcode = new QRCode(document.getElementById("qrcode"), {
    	//가로, 세로 높이 조절
    	text:"127.0.0.1",
    	width : 512,
    	height : 512,
    	
    	colorDark : "#000000",
        colorLight : "#ffffff",
        correctLevel : QRCode.CorrectLevel.H
    });
    
    
 // input:text에 들어있는 value를 qr코드로 바꿈
    function makeCode () {		
    	var elText = document.getElementById("text");
    	
    	if (!elText.value) {
    		alert("Input a text");
    		elText.focus();
    		return;
    	}
    	
    	alert(elText.value);
    	qrcode.makeCode(elText.value);
    }
   
   // 위에 만든 function 실행 
   function button1_click(){
    makeCode();
   }
   
   function resize(obj){
	   obj.style.height = "1px";
	   obj.style.height = (12 + obj.scrollHeight) + "px";
   }
   


   
    
    
    
    
    

	</script>
	
	

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