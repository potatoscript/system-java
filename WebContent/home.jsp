<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" errorPage="error.jsp"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>    
    
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

<sql:setDataSource var="db" driver="org.postgresql.Driver" url="jdbc:postgresql://localhost:5432/potato" user="potato" password="potato" />
<sql:query var="rs" dataSource="${db }">select * from public."Projects"</sql:query>

<c:forEach items="${rs.rows}" var="project">
	<c:out value="${project.title }"></c:out><br>
</c:forEach>
<br>



<c:out value="Hello World" />

<c:import url="https://github.com/potatoscript/system-java#requestdispatcher-calling-servlet-from-servlet"></c:import>

</body>
</html>