<%@page import="com.tech.blog.entities.Post"%>
<%@page import="java.util.List"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.dao.PostDao"%>

<div class="row">
<%
	Thread.sleep(500);
	PostDao dao = new PostDao(ConnectionProvider.getConnection());

	int catid = Integer.parseInt(request.getParameter("cid"));
	
	List<Post> list= null;
	
	if(catid == 0){
		 list=dao.getAllPost();	
	}else{
		 list= dao.getAllPostById(catid);
	}
	
	if(list.size() == 0){
		out.println("Sorry! Currently we Have No Post In This Section...");
	}
	for(Post p:list){
		%>
		<div class="col-md-12">
			<div class="card mt-3">
				
					<div class="card-body">
						<h3><%= p.getpTitle() %></h3><br>
						<h6><%= p.getpContent()%></h6>
						<p><%=p.getpCode() %></p>
					</div>
			</div>
		</div>
		<%	
	}
%>
</div>