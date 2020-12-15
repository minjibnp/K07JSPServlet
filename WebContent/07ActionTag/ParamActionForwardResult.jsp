<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ParamActionForwardResult.jsp</title>
</head>
<body>
	<h2>나는 포워드된 페이지다</h2>
	
	<h3>파라미터로 전달된 데이터</h3>
	<ol>
		<li>query : <%=request.getParameter("query") %></li>
		<li>name : <%=request.getParameter("name") %></li>
		<li>id : <%=request.getParameter("id") %></li>
	</ol>	
	<!--  
	MemberDTO객체에 오버라이딩 처리한 toString()메소드를 통해서
	객체의 속성(멤버변수)이 출력된다. 
	-->
	<h3>영역에 저장되어 전달된 객체</h3>
	<%=request.getAttribute("member") %>	
</body>
</html>