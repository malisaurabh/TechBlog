package com.tech.blog.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.tech.blog.entities.Category;
import com.tech.blog.entities.Post;

public class PostDao {
	
	Connection conn;
	
	public PostDao(Connection conn) {
		this.conn = conn;
	}
	
	public ArrayList<Category> getAllCategories(){
		
		ArrayList<Category> list= new ArrayList<Category>();
		
		try {
			String q="select * from categories";
			Statement st=this.conn.createStatement();
			ResultSet rset=st.executeQuery(q);
			
			while(rset.next()) {
				int cid=rset.getInt("cid");
				String name=rset.getString("cname");
				String description = rset.getString("description");
				
				Category category = new Category(cid,name,description);
				list.add(category);
			}
			
		}catch(Exception ex) {
			ex.printStackTrace();
		}
		return list; 
	}
	
	
	public boolean savePost(Post p) {
		boolean f=false;
		
	try {
		String q="insert into posts (pTitle,pContent,pCode,catid,uid) values(?,?,?,?,?)";
		PreparedStatement pstmt=conn.prepareStatement(q);
				pstmt.setString(1, p.getpTitle());
				pstmt.setString(2, p.getpContent());
				pstmt.setString(3, p.getpCode());
				//pstmt.setString(4, p.getpPic());
				pstmt.setInt(4, p.getCatid());
				pstmt.setInt(5, p.getUserid());
				
				pstmt.executeUpdate();
				
				f=true;
	}catch(Exception e) {
		e.printStackTrace();
	}
		return f;
	}

	
	public List<Post> getAllPost(){
		
		List<Post> list=new ArrayList<>();
		//Fetch All Post
		
		try {
			
			PreparedStatement pstmt = conn.prepareStatement("select * from posts");
			
			ResultSet set=pstmt.executeQuery();
			
			while(set.next()) {
				int pid=set.getInt("pid");
				String pTitle = set.getString("pTitle");
				String pContent = set.getString("pContent");
				String pCode = set.getString("pCode");
				Timestamp date=set.getTimestamp("pDate");
				int catid = set.getInt("catid");
				int userid = set.getInt("uid");
				
				Post p=new Post(pid,pTitle, pContent, pCode, date, catid,userid);
				list.add(p);
			}
		
		}catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	
	public List<Post> getAllPostById(int catId){
		List<Post> list=new ArrayList<>();
		
		//Fetch all post by id
		
try {
			
			PreparedStatement pstmt = conn.prepareStatement("select * from posts where catId=?");
			pstmt.setInt(1, catId);
			
			ResultSet set=pstmt.executeQuery();
			
			while(set.next()) {
				int pid=set.getInt("pid");
				String pTitle = set.getString("pTitle");
				String pContent = set.getString("pContent");
				String pCode = set.getString("pCode");
				Timestamp date=set.getTimestamp("pDate");
				
				int userid = set.getInt("uid");
				
				Post p=new Post(pid,pTitle, pContent, pCode, date,userid);
				list.add(p);
			}
		
		}catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
}
