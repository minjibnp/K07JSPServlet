<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>
	<!-- 
	out태그
		: 영역에 저장된 변수를 출력할때 사용한다.
	 -->
	<h2>out 태그</h2>
	<c:set var="htmlStr">
		<h3>h3 태그로 감싼 문자열</h3>
	</c:set>
	
	<!-- 
	기본값이거나 true일때는 HTML이 해석되지 않고 태그까지 그대로
	출력된다. JS의 innerText()와 동일하다.
	 -->
	<h3>escapeXml=true(기본값)일때</h3>
	<c:out value="${htmlStr }" escapeXml="true"/>
	<br />
	\${htmlStr } : ${htmlStr }
	
	<!-- 
	false일때는 HTML이 해석되어져서 화면에 출력된다.
	JS의 innerHTML()과 동일하다.
	 -->
	<h3>escapeXml=false일때</h3>
	<c:out value="${htmlStr }" escapeXml="false"/>
	<br />
	\${htmlStr } : ${htmlStr }
	
	<!-- 
	-out태그에 value속성의 값이 null일때는 default속성에
	지정된 값이 출력된다.
	-단, 값이 빈문자열("")인 경우는 값이 있는것으로 간주되어
	default속성에 지정한 값이 출력되지 않는다.
	 -->
	<h3>default속성</h3>
	
	<h4>값이 빈 문자열 : 값이 있는 경우에 해당</h4>
	출력 : <c:out value="" default="값이 빈 문자열"/>
	
	<h4>값이 null인 경우: 값이 없는 경우에 해당</h4>
	출력 : <c:out value="${null }" default="값이 null인 경우"/>
	
	<!-- 
	-파라미터로 전달되는 nowPage가 없는 경우에는 1로 표현되고,
	있는 경우에는 해당 파라미터값을 가져와서 페이지에 적용한다.+
	 -->
	<h3>페이지 링크에 응용하기</h3>
	<c:url value="/08Board1/BoardList.jsp?nowPage="/>
	<c:out value="${null }" default="1"/>
	<hr />
	<!-- 주의]한줄로 붙여서 작성할 것. 줄바꿈하면 공백이 들어간다. -->
	<a href="<c:url value="/08Board1/BoardList.jsp?nowPage=" /><c:out
	value="${param.nowPage }" default="1"/>">
		회원제게시판 리스트 바로가기</a>
	
</body>
</html>