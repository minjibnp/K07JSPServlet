<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%--
	include지시어 : 공통으로 사용할 jsp파일을 생성한 후
			현재문서에 포함시킬때 사용한다. 각각의 jsp파일 상단에는
			반드시 page지시어가 삽입되어야 한다.
			단, 하나의 jsp파일에서는 page지시어가 중복선언되면 안된다.
--%>
<%@ include file = "IncludePage.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<!-- CSS코드는 양이 많으므로 외부파일로 선언하여 현재문서에 링크시킨다. -->
<link rel="stylesheet" href="./css/div_layout.css" />
</head>
<body>
	<div class="Allwrap">
		<div class="header">
			<!-- GNB(Global Navigation Bar)영역 / 전체공통메뉴 -->
			<%@ include file="../common/Top.jsp"%>
		</div>
		<div class="body">
			<div class="left_menu">
				<!-- LNB영역(Local Navigation Bar) /지역메뉴-->
				<%@ include file="../common/Left.jsp"%>
			</div>
			<div class="contents">
			<!-- Contents영역 -->
			<%--
			해당 변수는 외부파일에 선언하여 본 문서에 include처리되었다.
			include는 문서자체를 포함시키는 개념이므로 에러가 발생하지 않는다.
			 --%>
			<h2>오늘의 날짜: <%=todayStr%></h2>
			<br /><br />
			[스포츠서울 박효실기자] 구독자 281만명의 먹방 유튜버 쯔양이 복귀를 알렸다. 지난 8월 여러 유명 유튜버들을 직격한 일명 '뒷광고' 논란으로 은퇴를 선언한지 석달여 만이다.
			논란 당시 쯔양은 자신이 게재한 몇몇 유튜브 영상에 협찬 표기를 하지 않은 것과 관련해 악플이 쏟아지자 "어떤 오해라도 생기면 도저히 걷잡을 수 없이 커져만 가는 악플이 두렵고 힘들었다"라며 "유튜브 방송을 끝마치도록 하겠다"면서 방송 은퇴를 선언했다.

			하지만 지난달 23일부터 은퇴 선언 전에 촬영한 영상이라며 '욕지도' 관련 영상을 10개나 올려 복귀 수순을 밟고 있는 것 아니냐는 이야기가 나온바 있다.


			<br /><br />
			</div>
		</div>
		<div class="copyright">
		<!-- Copyright -->
			<%@ include file="../common/Copyright.jsp"%>
		
		</div>
	</div>
</body>
</html>