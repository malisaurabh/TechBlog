package com.tech.blog.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.mysql.cj.protocol.Resultset;
import com.tech.blog.entities.User;

// this class used for interact with database or insert data in database
public class UserDao {

	private Connection con;
	
	// constructor
	public UserDao(Connection con) {
		this.con=con;
	}
	
	//method to insert user to database
	public boolean saveUser(User user) {
		//insert data to databse
		boolean f=false;
		try {
			// user-->database
			
			String query="insert into user(name,email,password,gender,about) values(?,?,?,?,?)";
			PreparedStatement pstmt=this.con.prepareStatement(query);
			pstmt.setString(1, user.getName());
			pstmt.setString(2, user.getEmail());
			pstmt.setString(3, user.getPassword());
			pstmt.setString(4, user.getGender());
			pstmt.setString(5, user.getAbout());
			
			pstmt.executeUpdate();
			f=true;
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return f;
	}
	
	
	//Get user by Email and password
	
	public User getUserByEmailAndPassword(String email, String password) {
		User user=null;
		
		try {
			
			String query = "select * from user where email=? and password=?";
			PreparedStatement pstmt =this.con.prepareStatement(query);
			pstmt.setString(1, email);
			pstmt.setString(2, password);
			
			ResultSet set=pstmt.executeQuery();
			
			if(set.next()) {
				
				user=new User();
				
				user.setId(set.getInt("id"));
				user.setName(set.getString("name"));
				user.setEmail(set.getString("email"));
				user.setPassword(set.getString("password"));
				user.setGender(set.getString("gender"));
				user.setAbout(set.getString("about"));
				user.setDatetime(set.getTimestamp("datetime"));
				user.setProfile(set.getString("profile"));			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return user;
	}


	public boolean updateUser(User user) {
		boolean f =true;
		try {
			
			String query="update user set name=? , email=? , password=? , gender=? , about=? , profile=? where id=?";
			
			PreparedStatement p=con.prepareStatement(query);
			p.setString(1, user.getName());
			p.setString(2, user.getEmail());
			p.setString(3, user.getPassword());
			p.setString(4, user.getGender());
			p.setString(5, user.getAbout());
			p.setString(6, user.getProfile());
			p.setInt(7, user.getId());
			
			p.executeUpdate();
			f=true;
		}catch(Exception e) {
			e.printStackTrace();
		}
		return f;
	}
}
