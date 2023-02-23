# Java Servlet & JSP チュートリアル

- Web ベースのアプリケーションを開発するために、Java サーブレットを使用される
- Java API のすべてにアクセスすることができます

## 目次

- [概要](#概要)
  - [開発環境設置](#開発環境設置)
  - [基本的なアプリケーション](#基本的なアプリケーション)
  - [RequestDispatcher Calling a Seervlet from Servlet](#RequestDispatcher-Calling-Servlet-from-Servlet)
  - [ServletConfig & ServletContext](#ServletConfig-&-ServletContext)
  - [Servlet Annotation](#Servlet-Annotation)
  - [JSP Java Server Page](#JSP)
    - [Directive tag](#Directive-tag)
    - [Implicit Object](#Implicit-Object)
    - [Exception Handling](#Exception-Handling)
    - [Servlet get Model data](#Servlet-get-Model-data)
    - [JDBC fetch data from Database](#JDBC-fetch-data-from-Database)

## 概要

[目次](#目次)

### 開発環境設置

- Install Java JDK & eclipse IDE for Java EE Developers
- Install Apache Tomcat v9
  - Select Core・Zip and Source code Desitribution zip
- Create localhost server:
  - Select server → 　 server type
- Create Web Project in Eclipse
  - Select Dynamic Web project and key in the project name
  - you have to check `Generate web xml deployment descriptor`
  - all your code will be stored at `src`

### 基本的なアプリケーション

- Right click your project name -> select New -> HTML File -> File name and name it `index.html`
- index.html

```html
<form action="add">
  Enter 1st number : <input type="text" name="num1" /><br />
  Enter 2nd number : <input type="text" name="num2" /><br />
  <input type="submit" />
</form>
```

- Create Servlet class to interact with the index.html
- サーブレットは `HttpServletRequest` と `HttpServlet Response` の 2 つのオブジェクトを取ります

```java
public class AddServlet extends HttpServlet {
	public void service(HttpServletRequest req, HttpServletResponse res) throws IOException
	{
		int i = Integer.parseInt(req.getParameter("num1"));
		int j = Integer.parseInt(req.getParameter("num2"));
		int k = i+j;
		PrintWriter out = res.getWriter();
		out.println("result is " + k);
	}
}
```

- Create the connection between the `index.html` and `AddServlet.class` with `web.xml`

```xml
  <servlet>
  	<servlet-name>add</servlet-name>
  	<servlet-class>com.potatoscript.AddServlet</servlet-class>
  </servlet>
  <servlet-mapping>
  	<servlet-name>add</servlet-name>
  	<url-pattern>/add</url-pattern>
  </servlet-mapping>
```

- you can use `doPost` and `doGet` to control the

[目次](#目次)

### RequestDispatcher Calling Servlet from Servlet

- Same Website
  - RequestDispatcher

```java
//servlet 1
req.setAttribute("k",k);
RequestDispatcher rd = req.getRequestDispatcher("sq");
rd.forward(req, res);
```

```java
//servlet 2
int k = (int)req.getAttribute("k");
k = k*k;
PrintWriter out = res.getWriter();
out.println("result is " + k);
```

- Difference Website
  - sendRedirect (session manager)

```java
//servlet 1
res.sendRedirect("sq?k="+k);
```

```java
//servlet 2
int k = Integer.parseInt(req.getParameter("k"));
```

- HttpSession

```java
HttpSession session = req.getSession();
session.setAttribute("k", k);
res.sendRedirect("sq");
```

```java
HttpSession session = req.getSession();
int k = (int)session.getAttribute("k");
```

- Cookie

```java
Cookie cookie = new Cookie("k",k+"");
res.addCookie(cookie);
res.sendRedirect("sq");
```

```java
int k = 0;
Cookie cookies[] = req.getCookies();
for(Cookie c:cookies) {
    if(c.getName().equals("k")) {
        k = Integer.parseInt(c.getValue());
    }
}
```

[目次](#目次)

### ServletConfig & ServletContext

- Information shared by ServletConfig is for a specific servlet,
- while information shared by ServletContext is available for all servlets in the web application.

- ServletContext

```xml
<context-param>
    <param-name>name</param-name>
    <param-value>Bruce</param-value>
</context-param>
```

```java
ServletContext ctx = getServletContext();
String str = ctx.getInitParameter("name");
```

- ServletConfig

```xml
<servlet>
  	<servlet-name>home</servlet-name>
  	<servlet-class>com.potatoscript.MyServlet</servlet-class>

  	<init-param>
  		<param-name>name</param-name>
  		<param-value>Lim</param-value>
  	</init-param>

</servlet>
```

```java
ServletConfig ctx = getServletConfig();
String str = ctx.getInitParameter("name");
```

[目次](#目次)

### Servlet Annotation

- If you use annotation, then the deployment descriptor (web.xml) is not required.

```java
@WebServlet("/add")
public class AddServlet extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException
	{
    }
}
```

[目次](#目次)

### JSP

- Java Server Page
- JSP -> Servlet -> Tomcat
- JSP was translated from Servlet
- Install Netbeans to see the code behind of JSP in Servlet
- Four Tags : ①Directive, ②Declaration, ③Scriptlet, ④Expression

```jsp
<!-- ① Directive Tags-->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" errorPage="error.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
   <body>

      <!-- ② Declaration tag-->
      <%! int value = 100; %>

      <!-- ③ Scriptlet tag-->
      <%
         int i = Integer.parseInt(request.getParameter("num1"));
         out.printIn("Output : "+ i);
      %>

      <!-- ④ Expression tag-->
      <%= i  %>
   </body>
</html>
```

#### Directive tag

- The attribute type of Directive tag <%@ attribute = ""> @ page, @ include, @ taglib
  - language = "scripting lanaguage"
  - extends = "className"
  - import = "importList"
  - session = "true|false"
  - autoFlush = "true|false"
  - contentType = "text/html"
  - errorPage = "error_url"
  - isErrorPage = "true|false"
  - info = "information"
  - isELIgnored = "true|false"
  - isThreadSafe= "true|false"

#### Implicit Object

- Implicit Object in JSP

  - Build in Object (can be used in Scriptlet and Expression)
    　- Request (HttServletRequest)
  - Response (HttpServletResponse)
  - PageContext (PageContext)
    ````
      <%
        pageContext.setAttribute("name","lim", PageContext.SESSION_SCOPE);
      %>
    ```　
    ````
  - Out (JspWriter) PrintWriter object
  - Session (HttpSession)
  - Application (ServletContext)
  - Config (ServletConfig)

#### Exception Handling

- Exception Handling in JSP

  - try{}catch(Exception e){ out.println(e.getMessage())}
  - home.jsp

  ```jsp
  <%@ page language="java" errorPage="error.jsp"%>

    <%
       int x = 9/0;
    %>
  ```

  - error.jsp

  ```jsp
   <%@ page language="java" isErrorPage="true"%>
    ...
    <body>
      My Error
      <%= exception.getMessage() %>
    </body>
  ```

#### Servlet get Model data

- Use Servlet to get data from Model object

  - Create a model data

  ```java
  public class Student {
  	int rollno;
  	String name;
  	public Student(int rollno, String name) {
  		super();
  		this.rollno = rollno;
  		this.name = name;
  	}
  	public int getRollno() {
  		return rollno;
  	}
  	public void setRollno(int rollno) {
  		this.rollno = rollno;
  	}
  	public String getName() {
  		return name;
  	}
  	public void setName(String name) {
  		this.name = name;
  	}
  	@Override
  	public String toString() {
  		return "Student [rollno=" + rollno + ", name=" + name + ", getRollno()=" + getRollno() + ", getName()="
  				+ getName() + "]";
  	}
  }
  ```

  - Create a Servlet class

```java
public class MyServlet extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {

		//Student s = new Student(1, "Lim");
		List<Student> students = Arrays.asList(new Student(1,"Bruce"),new Student(2,"Lim"),new Student(3, "Ks"));

		req.setAttribute("students", students);
		RequestDispatcher rd = req.getRequestDispatcher("home.jsp");
		rd.forward(req, res);
	}
}
```

- Create a jsp named `home.jsp` to output the data
- you need to download `jstl-1.2.jar` and move them into lib folder of your project to use jstl

```jsp
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:forEach items="${students}" var="s">
	${s.name}<br>
</c:forEach>
```

#### JDBC fetch data from Database

- JDBC in JSP (fetch data from Database)
  　- download `postgresql-42.5.4.jar` and `jstl-1.2.jar` and move them into lib folder of your project

  ```jsp
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>

    <sql:setDataSource var="db" driver="org.postgresql.Driver" url="jdbc:postgresql://localhost:5432/potato" user="potato" password="potato" />
    <sql:query var="rs" dataSource="${db }">select * from public."Projects"</sql:query>

    <c:forEach items="${rs.rows}" var="project">
  	    <c:out value="${project.title }"></c:out><br>
    </c:forEach>

  ```
