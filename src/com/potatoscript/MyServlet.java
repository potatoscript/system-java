package com.potatoscript;

import java.io.IOException;

import java.io.PrintWriter;
import java.util.Arrays;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MyServlet extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
		PrintWriter out = res.getWriter();
		out.print("Hi ");
		//ServletContext ctx = getServletContext();
		ServletConfig ctx = getServletConfig();
		String str = ctx.getInitParameter("name");
		//out.println(str);
		
		
		//Student s = new Student(1, "Lim");
		List<Student> students = Arrays.asList(new Student(1,"Bruce"),new Student(2,"Lim"),new Student(3, "Ks"));
		
		req.setAttribute("students", students);
		RequestDispatcher rd = req.getRequestDispatcher("home.jsp");
		rd.forward(req, res);
		
		
		
	}

}
