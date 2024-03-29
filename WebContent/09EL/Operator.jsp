<%@page import="java.util.Vector"%>
<%@page import="java.util.Collection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
	<h2>EL의 연산자들</h2>
	
	<h3>EL에서의 null연산</h3>
	<%
	/*
	Java에서는 null과 연산을 수횅할 수 없다.
	하지만 EL에서는 null을 0으로 간주하여 계산한다.
	*/
	//int a = null+10; //<-null과의 연산이므로 에러발생됨
	%>
	
	\${null+10 } : ${null+10 } <br /><!-- 결과:10 -->
	<!-- 
		최초 실행시에는 파라미터가 없으므로 0으로 간주되어 계산된다.
		만약
			해당페이지?myNumber=20    => 결과 30 출력
			해당페이지?myNumber=      => 0으로 간주되어 10 출력
			해당페이지?myNumber=Three => 문자는 숫자로 변경할 수 없어 에러발생됨
	 -->
	\${param.myNumber+10 } : ${param.myNumber+10 } <br />
	<br />
	
	<!-- 
		null값과 비교연산에서는 false를 반환한다.
		산술연산에서는 0으로 간주하고 연산을 진행하지만
		비교연산은 null과의 비교자체가 불가능하기 때문이다.
	 -->
	\${param.myNum>10 } : ${param.myNum>10 } <br />
	\${param.myNum<10 } : ${param.myNum<10 } <br />
	<br />
	
	<h3>JSTL로 EL에서 사용할 변수선언</h3>
	
	<%
	/*
	EL에서는 JSP에서 선언한 변수는 직접 사용할 수 없다. 
	값이 출력되지 않고 null로 인식하게 된다. 
	JSP에서 변수를 EL에서 사용할 수 없는 이유는 EL은 
	4가지 영역에 저장된 속성들만 사용하기 때문이다. JSTL도 동일한 특성을 가지고있다.
	*/
	
	String varScriptLet = "스크립트렛 안에서 변수선언";
	%>
	<!-- null로 인식되어 결과는 100이 출력된다. -->
	\${varScriptLet+100 } : ${varScriptLet+100 } <br />
	
	<!-- 
	JSP에서 선언한 변수를 EL에서 사용해야 할 경우에는 JSTL의
	set태그를 이용해서 변수를 선언한다. JSP에서 선언후 바로
	사용하려면 영역에 저장해야 한다.
	 -->
	<c:set var="elVar" value="<%=varScriptLet %>"/>
	\${elVar } : ${elVar }
	
	<!-- ###################### -->
	
	<h3>EL변수에 값 할당</h3>
	<c:set var="fnum" value="9"/>
	<c:set var="snum" value="5"/>
	\${fnum=99 } : ${fnum=99 }
	
	   <!-- 
      EL에서는 정수와 정수를 연산하더라도 실수의 결과가
     	 나올수있다. 즉 자동형변환되어 출력된다.
      	나눗셈을 위한 /연산자대신 div, 나머지를 구하는 %대신 mod를 사용할 수 있다.
    -->
	
	<h3>EL의 산술연산자</h3>
	<ul>
		<li>\${fnum+snum } : ${fnum+snum}</li>
		<li>\${fnum/snum } : ${fnum/snum }</li>
		<li>\${fnum div snum } : ${fnum div snum }</li>
		
		<li>\${fnum % snum} : ${fnum % snum}</li>
		<li>\${fnum mod snum } : ${fnum mod snum }</li>
		
		      <!-- 
         EL에서는 + 연산자는 덧셈의 용도로만 사용된다.
       	  문자열을 연결하기 위한 용도로는 사용할수 없다.
         	아래 문장중 "100"은 자동으로 숫자로 변경된후 연산된다.
         	나머지는 NumberFormatException이 발생된다.
       -->
		
		<li>\${"100"+100 } : ${fnum>snum }</li>
		<li>\${"Hello~"+"EL~" } : \${"Hello!"+"EL~" }</li>
		<li>\${"일"+2 } : \${"일"+2 }</li> 
	</ul>
	
	  <!-- 
      EL에서는 비교연산자를 이용한 비교시 변수의 값을 모두 문자열로
    	  인식하여 String 클래스의 compareTo()와 같은 방식으로 비교한다.
      	즉, 첫번째 문자부터 하나씩 비교해나간다.
      	단, 실제 숫자의 비교시에는 일반적인 숫자비교가 이루어진다.
    -->
	
	<h3>EL의 비교연산자</h3>
	<c:set var="fnum" value="100"/>
	<c:set var="snum" value="90"/>
	
	
  <ul>
      <!-- 
         fnum과 snum은 영역에 저장된 데이터이므로 Object형으로
         저장된다. 따라서 비교시 객체상태에서 비교가 이루어지게된다.
         100과 90은 실제 숫자의 비교가 이루어진다.
       -->
      <li>\${fnum > snum } : ${fnum > snum }</li><!-- 결과 : false -->
      <li>\${100 > 90 } : ${100 > 90 }</li><!-- 결과 : true -->
      
      <!-- 
         Java에서는 문자열을 비교할때 equals()로 비교하지만
         EL에서는 ==의 형태로 비교한다.
       -->
      <li>\${"JAVA"=='JAVA' } : ${"JAVA"=='JAVA' }</li><!-- 결과 : true -->
      <li>\${"Java"=='JAVA' } : ${"Java"=='JAVA' }</li><!-- 결과 : false -->
   </ul>
   
   
   <!-- 
      > : gt(Greater Then)
      >= : ge(Greater then Equal)
      < : lt(Less Then)
      <= : le(Less then Equal)
      == : eq(EQual)
      != : ne(Not Equal)
      && : And
      || : Or
    -->
   <h3>EL의 논리연산자</h3>
   <ul>
      <li>\${5>=5 && 10!=10 } :
            ${5 ge 5 and 10 ne 10 }</li><!-- 참&&거짓 =>거짓 -->
      <li>\${5>6 || 10<100 } :
            ${5 gt 6 or 10 lt 100 }</li><!-- 거짓||참 =>참 -->
   </ul>
   
   <h3>EL의 삼항연산자</h3>
   \${10 gt 9 ? "참이닷" : "거짓이닷" }
      : ${10 gt 9 ? "참이닷" : "거짓이닷" }
      
   
   <!-- 
   null이거나 ""(빈문자열)일때
      혹은 배열인 경우 길이가 0일때
      혹은 컬렉션인 경우 size가 0일때
   true를 반환하는 연산자.
    -->
   <h3>EL의 empty 연산자 : null일때 true를 반환하는 연산자</h3>
   <%
      String nullStr = null;
      String emptyStr = "";
      Integer[] lengthZero = new Integer[0];
      Collection sizeZero = new Vector();
   %>
   
   <c:set var="elnullStr" value="<%=nullStr %>" />
   <c:set var="elemptyStr" value="<%=emptyStr %>" />
   <c:set var="ellengthZero" value="<%=lengthZero %>" />
   <c:set var="elsizeZero" value="<%=sizeZero %>" />
   
   <ul>
      <li>\${empty elnullStr } : ${empty elnullStr } </li>
      <li>\${not empty elnullStr } : ${not empty elnullStr } </li>
      <li>${empty ellengthZero ?
            "배열크기가0임" : "배열크기가0이아님" }</li>
      <li>${not empty elsizeZero ? 
            "컬렉션에 저장된 객체있음" :
            "컬렉션에 저장된 객체없음" }</li>
   </ul>
    
</body>
</html>