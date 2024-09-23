package com.tech.blog.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.tech.blog.dao.UserDao;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;


@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public RegisterServlet() {
        super();
    }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//fetch all data
		PrintWriter out=response.getWriter();
		response.setContentType("text/html");
		String check=request.getParameter("check");
		if(check==null) {
			out.println("box not checked !please tick on checkbox");
		}else {
			//if checked remaining data fetch here
			String name=request.getParameter("user_name");
			String email=request.getParameter("user_email");
			String password=request.getParameter("user_password");
			String gender=request.getParameter("user_gender");
			String about=request.getParameter("about");
			
			//crete user object and set all data to that object
			User user=new User(name,email,password,gender,about);
			
			//create userdao object
			UserDao dao=new UserDao(ConnectionProvider.getConnection());
			if(dao.saveUser(user)) {
				//save..
				out.println("data saved successfully");
				//response.sendRedirect("login_page.jsp");
			}else {
				out.println("some problem occured while inserting data..");
			}
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
