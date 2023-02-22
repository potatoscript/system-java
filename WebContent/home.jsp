<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" errorPage="error.jsp"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<%
  // int x = 9/0;
%>


<c:forEach items="${students}" var="s">
	${s.name}<br>
</c:forEach>
<br>


<br>

<c:out value="Hello World" />

<c:import url="https://github.com/potatoscript/system-java#requestdispatcher-calling-servlet-from-servlet"></c:import>

</body>
</html>