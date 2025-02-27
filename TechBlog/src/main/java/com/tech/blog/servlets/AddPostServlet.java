package com.tech.blog.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.tech.blog.dao.PostDao;
import com.tech.blog.entities.Post;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;



@WebServlet("/AddPostServlet")
@MultipartConfig
public class AddPostServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
  
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		PrintWriter out=response.getWriter();
		
	
		int cid=Integer.parseInt(request.getParameter("cid"));
		String pTitle = request.getParameter("pTitle");
		String pContent = request.getParameter("pContent");
		String pCode = request.getParameter("pCode");
		//Part part =request.getPart("pic");
		
		//getting current uesrid
		HttpSession session=request.getSession();
		User user=(User)session.getAttribute("currentUser");
		
		Post post=new Post(pTitle, pContent, pCode ,cid, user.getId());
		PostDao dao=new PostDao(ConnectionProvider.getConnection());
		
		if(dao.savePost(post)) {
			out.println("Done");
		}else{
			out.println("Some Error");
		}
	}

}
