<%@page import="java.util.Currency"%>
<%@page import="java.text.NumberFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- JSTL의 국제화 라이브러리를 사용하기 위한 지시어 선언 -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
	<h2>formatNumber태그</h2>
	<c:set var="money" value="10000"/>
	
	<h3>EL로 출력</h3>
	money : ${money } -> 10000
	
	<!-- groupingUsed의 디폴트값이 true이므로 콤마 출력됨 -->
	<h3>JSTL 국제화 태그로 출력</h3>
	money : <fmt:formatNumber value="${money }"/> -> 10,000
	
	<!-- 콤마를 생략하고 싶을때는 false로 설정 -->
	<h3>JSTL 국제화 태그로 출력-천단위 콤마생략</h3>
	money : <fmt:formatNumber groupingUsed="false" value="${money }"/>
	
	<h3>type="currency"이고 currencySymbol 생략시 - 현재통화단위로 출력됨</h3>
	money : <fmt:formatNumber value="${money }" type="currency"
			currencySymbol="$"/>
	
	<!-- value속성값으로 전달되는 값을 % 단위로 변환해서 출력한다. -->		
	<h3>type="percent"</h3>
	money : <fmt:formatNumber value="0.02" type="percent"/>
	
	<h3>var속성 : 원하는 위치에 출력하고 싶을때</h3>
	<fmt:formatNumber value="${money }" type="currency" var="price"/>
	가격이 <strike>15,000원</strike> ->
		<span style="font-size: 1.5em;">${price }</span>로 내렸어용~
		
	<h2>자바코드 1000단위 콤마 표시하기</h2>
	<%
     String moneyStr=pageContext.getAttribute("money").toString();
     int money=Integer.parseInt(moneyStr);
     /*
     	NumberFormat클래스는 싱글턴패턴으로 제작된 클래스로
     	new연산자를 통해 객체를 생성할 수 없는 대표적인 클래스이다.
     	getInstance()를 통해 이미 생성된 static형태의 객체를
     	반환받아 사용하게 된다.
     */
     NumberFormat nf=NumberFormat.getInstance();

     out.println("<h3>천단위 콤마 찍기전</h3>");
     out.println(money);

     out.println("<h3>천단위 콤마 찍기전</h3>");
     String commaMoney=nf.format(money);
     out.println(commaMoney);
   
     //현지통화 기호얻기
     Currency currency=nf.getCurrency();
     String currencySymbol=currency.getSymbol();
     out.println("<h3>통화기호 추가</h3>");
     out.println(currencySymbol+commaMoney);
    %>
</body>
</html>