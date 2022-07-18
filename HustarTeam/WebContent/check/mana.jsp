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
<script src="/resource/js/qrcode/jsQR.js"></script>
<script src="/resource/js/qrcode/attendance.js" charset="UTF-8"></script>

<title>Hustar | Template</title>

	<!-- Google Font -->
	<link href="https://fonts.googleapis.com/css2?family=Oswald:wght@300;400;500;600;700&display=swap" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css2?family=Mulish:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">
	<!-- css 파일 -->
	<link rel="stylesheet" href="/resource/css/common.css" type="text/css">
	<link rel="stylesheet" href="src/styles.css" />

</head>



<body>
	

	<header>
	<%@ include file="/include/header.jsp"%>
	</header>
		
	
	<!-- 내용1  -->
	
	
       <h3 style="color:white;" >[출결확인]</h3>
      <main>

	<div id="test">

		

		<div id="output">

			<div id="outputMessage" style="color:white">

				QR코드를 카메라에 노출시켜 주세요

			</div>

    		<div id="outputLayer" hidden>

    			<span id="outputData"></span>

    		</div>

		</div>

	</div>

	<div>&nbsp;</div>

	<div>

		

		<div id="frame">

			<div id="loadingMessage">

				🎥 비디오 스트림에 액세스 할 수 없습니다<br/>웹캠이 활성화되어 있는지 확인하십시오

			</div>

			<canvas id="canvas"></canvas>

		</div>

	</div>

</main>

</body>

</html>

<script type="text/javascript">	

	document.addEventListener("DOMContentLoaded", function() {

		

		var video = document.createElement("video");		

		var canvasElement = document.getElementById("canvas");

		var canvas = canvasElement.getContext("2d");

		var loadingMessage = document.getElementById("loadingMessage");

		var outputContainer = document.getElementById("output");

		var outputMessage = document.getElementById("outputMessage");

		var outputData = document.getElementById("outputData");

		

		function drawLine(begin, end, color) {

			

			canvas.beginPath();

			canvas.moveTo(begin.x, begin.y);

			canvas.lineTo(end.x, end.y);

			canvas.lineWidth = 4;

			canvas.strokeStyle = color;

			canvas.stroke();

                }

	    

	        // 카메라 사용시

		navigator.mediaDevices.getUserMedia({ video: { facingMode: "environment" } }).then(function(stream) {

			

      		        video.srcObject = stream;

      		        video.setAttribute("playsinline", true);      // iOS 사용시 전체 화면을 사용하지 않음을 전달

         		video.play();

      		        requestAnimationFrame(tick);

		});



		function tick() {

			

			loadingMessage.innerText = "⌛ 스캔 기능을 활성화 중입니다."

			

			if(video.readyState === video.HAVE_ENOUGH_DATA) {

				

        		      loadingMessage.hidden = true;

        		      canvasElement.hidden = false;

        		      outputContainer.hidden = false;

        		

        		      // 읽어들이는 비디오 화면의 크기

        		      canvasElement.height = video.videoHeight;

        	 	      canvasElement.width = video.videoWidth;

        		

        		      canvas.drawImage(video, 0, 0, canvasElement.width, canvasElement.height);

        		      var imageData = canvas.getImageData(0, 0, canvasElement.width, canvasElement.height);



        		      var code = jsQR(imageData.data, imageData.width, imageData.height, {



                                    inversionAttempts : "dontInvert",

        		      });

        		

                              // QR코드 인식에 성공한 경우

                              if(code) {

        			    

                                     // 인식한 QR코드의 영역을 감싸는 사용자에게 보여지는 테두리 생성

                                    drawLine(code.location.topLeftCorner, code.location.topRightCorner, "#FF0000");

                                    drawLine(code.location.topRightCorner, code.location.bottomRightCorner, "#FF0000");

                                    drawLine(code.location.bottomRightCorner, code.location.bottomLeftCorner, "#FF0000");

                                    drawLine(code.location.bottomLeftCorner, code.location.topLeftCorner, "#FF0000");



                                    outputMessage.hidden = true;

                                    outputData.parentElement.hidden = false;

          			

                                    // QR코드 메시지 출력

                                    outputData.innerHTML = code.data;

          			

                                    // return을 써서 함수를 빠져나가면 QR코드 프로그램이 종료된다.

                                    // return;

                              }

        		

                              // QR코드 인식에 실패한 경우 

                              else {



                                    outputMessage.hidden = false;

                                    outputData.parentElement.hidden = true;

                              }

                      }

      		

      		      requestAnimationFrame(tick);

		}

	});

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