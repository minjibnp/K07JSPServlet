<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>chatting04.jsp</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="css/default.css"/>
<script type="text/javascript">
var messageWindow;
var inputMessage;
var chat_id;
var webSocket;
window.onload = function(){
	
	//대화가 디스플레이되는 영역
	messageWindow = document.getElementById("chat-container");
	//대화영역의 스크롤바를 항상 아래로 내려준다
	messageWindow.scrollTop = messageWindow.scrollHeight;
	
	inputMessage = document.getElementById("inputMessage");
	chat_id = document.getElementById("chat_id").value;
	
	webSocket = new WebSocket('ws://localhost:9999/K07JSPServlet/ChatServer02');
	webSocket.onopen = function(event){
		wsOpen(event);
	};
	
	webSocket.onmessage = function (event) {
		wsMessage(event);
		
	};
	
	webSocket.onclose = function (event) {
		wsClose(event);
		
	};
	
	webSocket.onerror = function (event) {
		wsError(event);
		
	};
}

	function wsOpen(event) {
		messageWindow.value += "연결성공\n";
		
	}
	
	function wsMessage(event) {
		var message = event.data.split("|");
		var sender = message[0];
		var content = message[1];
		var msg;
		if (content == "") {
			//채팅내용이 없다면 아무일도 하지 않는다.			
		} 
		else {
			//보낸 메세지 앞에 / 가있으면 귓속말이므로
			if(content[0]=="/" && content.match("/")){
				//해당 아이디(닉네임)에게만 디스플레이한다
				if( content.match(("/"+chat_id))){
					//귓속말 명령어를 한글로 대체한 후 ...
					var temp = content.replace(("/"+chat_id),"[귓속말]");
					//메세지에 UI를 적용하는 부분
					msg=makeBalloon(sender,temp);
					messageWindow.innerHTML += msg;
					//대화영역의 스크롤바를 항상 아래로 내려준다
					messageWindow.scrollTop = messageWindow.scrollHeight;
				}
			}
			else{
				msg=makeBalloon(sender,content);
				messageWindow.innerHTML += msg;
				//대화영역의 스크롤바를 항상 아래로 내려준다
				messageWindow.scrollTop = messageWindow.scrollHeight;				
			}
		}
	}
	//상대방이 보낸 메세지를 출력하기 위한 부분
	function makeBalloon(id, cont){
		var msg = '';
		msg +='<div class="chat chat-left">';
		msg +='		<!--프로필 이미지-->';
		msg +='		<span class="profile profile-img-b"></span>';
		msg +='		<div class="chat-box">';
		msg +='			<p style="font-weight:bold; font-size:1.1em; margin-bottom:5px;">'+id+'</p>';
		msg +='			<p class="bubble">'+cont+'</p>';
	    msg +='         <span class="bubble-tail"></span>';
	    msg +='      </div>';
	    msg +='</div>';
	   return msg;
	   
		}
		function wsClose(event) {
		   messageWindow.value += "연결끊기성공\n";
		}

		function wsError(event) {
		   alert(event.data);
		}

		function sendMessage() {
		   //웹소켓 서버로 대화내용을 전송한다.
		   webSocket.send(chat_id+'|'+inputMessage.value);
			//내가보낸 내용에 UI를 적용한다
		   var msg='';
		   msg +='<div class="chat chat-right">';         
		   msg +='      <!-- 프로필 이미지 -->';         
		   msg +='      <span class="profile profile-img-a"></span>';
		   msg +='      <div class="chat-box">';
		   msg +='         <p class="bubble-me">'+inputMessage.value+'</p>';
		   msg +='         <span class="bubble-tail"></span>';
		   msg +='      </div>';
		   msg +='</div>';

		   messageWindow.innerHTML += msg;
		   inputMessage.value = "";
			//대화영역의 스크롤바를 항상 아래로 내려준다
		   messageWindow.scrollTop=messageWindow.scrollHeight;
		}
		/*
		키보드를 눌렀다가 땠을때 호출되며, 눌려진 키보드의
		키코드가 13일때, 즉 엔터키일때 아래 함수를 즉시 호출한다.
		*/
		function enterkey(){
		   if(window.event.keyCode==13){
		      sendMessage();
		   }
		}
</script>
</head>
<body>
<div id="chat-wrapper">
	<header id="chat-header">
		<h1>채팅창 - KOSMO1강의실</h1>
	</header>		
	<input type="hid-den" id="chat_id" value="${param.chat_id }" style="border:1px dotted red;" />
	<div id="chat-container" class="chat-area" style="height:500px;overflow:auto;">
		<!-- 왼쪽 채팅 : 상대방 -->
<!-- 		<div class="chat chat-left">			 -->
<!-- 			<span class="profile profile-img-b"></span> -->
<!-- 			<div class="chat-box"> -->
<!-- 				<p style="font-weight:bold;font-size:1.1em;margin-bottom:5px;">미르</p> -->
<!-- 				<p class="bubble">낙자<br/>뭐해?</p> -->
<!-- 				<span class="bubble-tail"></span> -->
<!-- 			</div> -->
<!-- 		</div> -->
		<!-- 오른쪽 채팅 : 나-->
<!-- 		<div class="chat chat-right">			 -->
<!-- 			<span class="profile profile-img-a"></span> -->
<!-- 			<div class="chat-box">				 -->
<!-- 				<p class="bubble-me">그냥 쉬고있는 중ㅋ</p> -->
<!-- 				<span class="bubble-tail"></span> -->
<!-- 			</div> -->
<!-- 		</div>	 -->
	</div>
	<footer id="chat-footer">		
		<p class="text-area">
			<!-- 메세지 입력창 -->
			<input type="text" id="inputMessage" onkeyup="enterkey();"
				style="width:450px; height:60px; font-size:1.5em; border:0px;" />
			<button type="button" onclick="sendMessage();">보내기</button>
		</p>
	</footer>
</div>
</body>

	
</html>