# Java Servlet & JSP チュートリアル

- Web ベースのアプリケーションを開発するために、Java サーブレットを使用される
- Java API のすべてにアクセスすることができます

## 目次

- [概要](#概要)
  - [開発環境設置](#開発環境設置)
  - [基本的なアプリケーション](#基本的なアプリケーション)
- [構造](#構造)
  - [開発環境・ツール](#a-開発環境ツール)
- [著者](#d-著者)

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
