<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>chatting02.jsp</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>

	<!-- 
		웹브라우저에 접속한 클라이언트의 세션아이디를 저장한다.
		차후 회원제 웹어플리케이션에서는 회원아이디 혹은 대화명으로 대체하면 된다.
		비교용
		테스트
	 -->
	<input type="text" id="chat_id"
	value="<%=session.getId().substring(0, 10)%>"	 
	style="border:1px dotted red; width:200px;" />
<fieldset style="width:350px; text-align:center;">
	<legend>채팅창</legend>	
	<!-- 대화입력창 -->	
	<input type="text" id="inputMessage" style="width:300px; margin-bottom:5px;"/>
	<br />
	<input type="button" onclick="sendMessage();" value="보내기"/>
	<input type="button" onclick="disconnect();" value="채팅종료"/>	
	<br />
	<!-- 대화출력창 -->
	<textarea id="messageWindow" style="width:300px; height:400px; margin-top:10px;" readonly></textarea>
</fieldset>
	<script>
	//대화가 디스플레이 되는 영역
	var messageWindow = document.getElementById("messageWindow");
	//대화내용을 입력하는 부분
	var inputMessage = document.getElementById('inputMessage');
	//접속자ID를 가져오는 부분(현재는 랜덤하게 생성되는 세션아이디를 사용)
	var chat_id = document.getElementById('chat_id').value;
	//웹소켓 객체를 생성하여 채팅서버에 접속
	var webSocket = 
		new WebSocket('ws://localhost:9999/K07JSPServlet/ChatServer02');
	
	/*
	웹소켓 서버에 연결한 후 메세지전송, 에러발생 등은 모두 이벤트를 통해
	각각의 함수를 호출한다. 이때 각 함수쪽으로 이벤트객체가 매개변수로 전달된다.
	*/
	webSocket.onopen = function (event) {
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
	
	function wsOpen(event) {
		messageWindow.value += "연결성공\n";
		
	}
	
	function wsClose(event) {
		messageWindow.value += "연결끊기성공\n";
		
	}
	
	function wsError(event) {
		alert(event.data);
		
	}
	//민지바보 
	function disconnect() {
		webSocket.close();
	}

		//웹소켓 서버가 메세지를 받은 후 클라이언트chatting02.jsp에게 Echo할때 처리부분.
		function wsMessage(event) {
			//메세지를 | 구분자로 split(분리)한다.
			var message = event.data.split("|");
			//첫번째 부분은 전송한 사람의 아이디
			var sender = message[0];
			//두번째 부분은 채팅내용
			var content = message[1];
			if (content == "") {
				//채팅내용이 없다면 아무일도 하지 않는다.			
			} else {
				//내용이 있는 경우에만 메세지창에 내용을 추가한다.
				messageWindow.value += sender + ":" + content + "\n";

			}
		}
		//클라이언트가 메세지를 입력후 '보내기'버튼을 누를때 호출
		function sendMessage() {
			//대화창에 입력한 내용에 Me를 추가한다.
			messageWindow.value += "나(Me):" + inputMessage.value + "\n";
			/*
			대화내용에 접속자 아이디(세션아이디)를 파이프기호로 연결한 후
			send()를 통해 서버로 전송한다.
			 */
			webSocket.send(chat_id + "|" + inputMessage.value);
			//입력했던 대화내용을 지워준다.
			inputMessage.value = "";
		}
	</script>
</body>
</html>