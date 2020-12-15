<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    errorPage="ErrorPage.jsp"
    %>
 <%--

 	errorPage 지시어
 		: 해당 페이지에서 에러(예외)가 발생되었을때 예외처리를
 		설정한 페이지에서 하겠다는 선언. 500에러와 같은 페이지를
 		사용자에게 보여주지 않게되므로 사이트에 대한 신뢰도를 높일 수 있다.
  --%>
 <%
 //사용자가 전송한 파라미터를 request객체를 통해 받아온다.
 String strAge = request.getParameter("age");
 //콘솔에 로그로 출력된다.
 System.out.println("strAge="+strAge);
 //웹브라우저에 출력된다. 즉 JS의 document.write()와 같은 역할을 한다.
 out.println("strAge="+strAge);
 
 int ageAfter10=-1;
 String errorStr = "";
 /*
 해당 페이지로 폼값을 전송할때 "나이"부분을 공백상태 혹은
 숫자가 아닌 문자를 입력후 전송하면 해당 코드에서 에러가 발생한다.
 */
 if(strAge !=null){
	 /*
	 Integer.parseInt()는 숫자가 아닌 경우 예외가 발생한다.
	 Integer : wrapper클래스(객체) 언박싱을 하지 않으면 산술 연산이 불가능하지만,
	 	null값을 처리할 수 있다.
	 	null값 처리가 용이하기때문에 SQL과 연동할 경우 처리가 용이하다.
	 	DB에서 자료형이 정수형이지만 null값이 필요한 경우 VO에서 Integer를 사용할 수 있다.
	 	Integer.valueOf(String) = Integer클래스를 리턴하기때문에 산술연산불가.
	 	Integer.parseInt(String) = int형을 리턴하기때문에 산술연산 가능.
	 */
	 ageAfter10 = Integer.parseInt(strAge)+10;
 }
 %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ErrorMain.jsp</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>
	<h2>에러가 발생할 페이지</h2>
	<!-- 
		form 태그의 속성
			name : 해당 폼의 이름을 지정함.
			method : 전송방식. get과 post방식이 있다.
				기술하지 않으면 get이 디폴트가 된다.
			action : 폼값이 전송될 웹서버의 경로. 혹은 URL.
				기술하지 않으면 현재페이지로 폼값이 전송된다.
			onsubmit : 전송 이벤트가 발생될때를 감지하는 이벤트 리스너.
				주로 폼값에 대한 검증을 위해 사용된다.
			enctype : 파일업로드를 위한 속성으로 기술하지 않으면
				파일은 전송할 수 없다. 파일 전송을 위해서는
				multipart/form-data를 지정해야 한다.
	 -->
	<form action="">
		나이를 입력하세요
		<input type="text" name="age" />
		<input type="submit" value="확인"/>
		<br />
		※나이를 입력하지 않거나 숫자 외 문자를 전송하면 에러가 발생됩니다.
	</form>
	<span style="color:red; font-size:2em;">
	   <% if(ageAfter10 != -1 ){ %>
	     	 당신의 10년후 나이는 <%=ageAfter10 %>살 입니다.
	   <% } else { %>
	      <%=errorStr %>
	   <% } %>   
   
   </span>
</body>
</html>