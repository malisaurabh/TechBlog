package com.tech.blog.servlets;

import java.io.File;
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

import com.tech.blog.dao.UserDao;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;
import com.tech.blog.helper.Helper;


@WebServlet("/EditServlet")
@MultipartConfig
public class EditServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out=response.getWriter();
	
		// Fetch All Data for Edit profile details
		
		String username=request.getParameter("user_name");
		String useremail=request.getParameter("user_email");
		String userpassword=request.getParameter("user_password");
		String userabout = request.getParameter("user_about");
		Part part=request.getPart("image");
		String imageName =part.getSubmittedFileName();
		
		//get user from session
		
		HttpSession s=request.getSession();
		User user= (User)s.getAttribute("currentUser");
		user.setName(username);
		user.setEmail(useremail);
		user.setPassword(userpassword);
		user.setAbout(userabout);
		String oldFile = user.getProfile();
		user.setProfile(imageName);
		
		//Update Database
		
		UserDao userDao = new UserDao(ConnectionProvider.getConnection());
		boolean result=userDao.updateUser(user);
		if(result) {
				
				String picpath=request.getRealPath("/")+"img"+File.separator+user.getProfile();
				
				String oldpicpath=request.getRealPath("/")+"img"+File.separator+oldFile;
				//delete code
				Helper.deleteFile(oldpicpath);
				
				if(Helper.saveFile(part.getInputStream(),picpath)){
					out.println("Profile photo updated!");
				}
		}else {
			out.println("Not updated");
		}
	}	
}
