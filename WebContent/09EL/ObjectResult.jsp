<%@page import="model.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	<h2>EL의 param 내장객체로 파라미터 읽기</h2>
	
	<h3>자바코드로 영역 및 파라미터 읽기</h3>
	
	<h4>영역에 저장된 값</h4>
	<%
	/*
	Java코드를 통해 영역에 저장된 속성을 가져올때는 이래와 같이한다.
	1.getAttribute() 으로 속성을 가져온다.
	2.형변환한다.
	3.getter()로 저장된 값을 출력한다.
	*/
	MemberDTO member = (MemberDTO)request.getAttribute("dtoObj");
	%>
	<ul>
		<li>
			MemberDTO 객체 : <%=String.format("아이디:%s,"+"비번:%s,이름:%s",
					member.getId(),
					member.getPass(),
					member.getName()) %>
		</li>
		<!-- String과 같은 자바의 기본객체는 형변환없이 출력할 수 있다. -->
		<li>
			String 객체 : <%=request.getAttribute("strObj") %>
		</li>
		<li>
			Integer 객체 : <%=request.getAttribute("integerObj") %>
		</li>
	</ul>
	
	<h4>파라미터로 전달된 값 읽기</h4>
	<%
	/*
		파라미터로 전달되는 값은 항상 String이므로 산술연산을
		위해서는 숫자로 변환이 필요하다.
	*/
	int fNum = Integer.parseInt(request.getParameter("firstNum"));
	int sNum = Integer.parseInt(request.getParameter("secondNum"));
	%>
	두 파라미터의 합 : <%=fNum+sNum %> <!-- 연산의결과 500출력됨 -->
	
	<!-- 
		속성명이 유일하다면 xxxScope 내장객체없이 읽어올 수 있고
		형변환이 필요없고, 숫자로 변경하지 않아도 산술연산이 가능하다.
		getter() 호출없이 멤버변수의 이름으로 저장된 값을 바로 읽어올 수 있다.
		따라서, java코드를 사용할 때보다 EL을 사용하면 훨씬 간편해진다.
	 -->
	<h3>EL로 영역과 파라미터로 전달된 값 읽기</h3>
	<h4>영역에 저장된 값</h4>
	<ul>
		<li>MemberDTO객체 : <br/>
			아이디 : ${dtoObj.id },
			비번 : ${dtoObj.pass },
			이름 : ${dtoObj.name },
		</li>
		<li>String 객체 : ${requestScope.strObj }</li>
		<li>Integer 객체 : ${integerObj }</li>
	</ul>
	
	<!-- 
		EL의 param내장객체를 통해 파라미터를 읽을때
			1.param.폼이름
			2.param['폼이름']
			3.param["폼이름"]
		세가지 모두 표현 가능함.
	 -->
	<h4>파라미터로 전달된 값의 합</h4>
	<ul>
		<li>${param.firstNum+ param['secondNum'] }</li>
		<!-- 
			윗부분은 산술연산이 되어 500이 출력됨.
			아래는 200, 300이라는 별도의 값이 출력된다.
		 -->
		<li>${param.firstNum}+ ${param['secondNum'] }</li>
	</ul>
</body>
</html>