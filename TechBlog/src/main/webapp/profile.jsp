<%@page import="com.tech.blog.entities.Category"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.mysql.cj.conf.ConnectionPropertiesTransform"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page import="com.tech.blog.entities.User"%>
<%@page errorPage="error_page.jsp"%>
<%
User user = (User) session.getAttribute("currentUser");
if (user == null) {
	response.sendRedirect("login_page.jsp");
}
%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
</head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>

<!-- css -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

</head>
<body>
	<!-- Navbar start -->

	<!-- navbar -->
	<nav class="navbar navbar-expand-lg navbar-dark primary-background">
		<a class="navbar-brand" href="index.jsp"><span class="fa fa-flash"></span>Tech
			Blog</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item active"><a class="nav-link" href="#"><span
						class="fa fa-newspaper-o"></span> Forums <span class="sr-only">(current)</span></a>
				</li>
				<li class="nav-item"><a class="nav-link" href="#"></a></li>

				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
					role="button" data-toggle="dropdown" aria-haspopup="true"
					aria-expanded="true"> <span class="fa fa-address-book"></span>
						Categories
				</a>
					<div class="dropdown-menu" aria-labelledby="navbarDropdown">
						<a class="dropdown-item" href="#">Java</a> <a
							class="dropdown-item" href="#">Data Structure</a> <a
							class="dropdown-item" href="#">UI Technology</a>
					</div></li>

				<li class="nav-item"><a class="nav-link " href="#"> <span
						class="fa fa-volume-control-phone"></span> Contact
				</a></li>

				<li class="nav-item"><a class="nav-link " href="#"
					data-toggle="modal" data-target="#add-post-modal"> <span
						class="fas fa-book"></span> Do-Post
				</a></li>

			</ul>

			<ul class="navbar-nav mr-right">
				<li class="nav-item"><a class="nav-link" href="#!"
					data-toggle="modal" data-target="#profile-model"><sapn
							class="fa fa-user-circle"></sapn><%=user.getName()%></a></li>
				<li class="nav-item"><a class="nav-link" href="logoutservlet"><sapn
							class="fa "></sapn>log out</a></li>
			</ul>
		</div>
	</nav>
	<!-- navabar End -->



	<!--main body of the page-->
	<main>
		<div class="container mt-4">
			<div class="row">
				<!-- First column -->
				<div class="col-md-3">
					<div class="list-group">
						<a href="#" onclick="getPosts(0)" class="list-group-item list-group-item-action active">All Posts</a> 
							
							<%
								PostDao d=new PostDao(ConnectionProvider.getConnection());
								ArrayList<Category> list1=d.getAllCategories();
								
								for(Category cc:list1){
							%>
							<a href="#" onclick="getPosts(<%= cc.getCid() %>)" class="list-group-item list-group-item-action"><%=cc.getCname() %></a> 
							<%
								}
							%>
					</div>
				</div>

				<!-- Second column -->
				<div class="col-md-8">
					<!-- post -->
					<div class="container text-center" id="loader">
						<i class="fa fa-refresh fa-4x fa-spin"></i>
						<h3 class="mt-2">Loading...</h3>
					</div>
					
					<div class="container-fluid" id="post-container">
						
					</div>
				</div>
			</div>
		</div>
	</main>
	<!-- End main body of the page -->





	<!-- profile model start -->
	<!-- Modal -->
	<div class="modal fade" id="profile-model" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">

				<div class="modal-header primary-background text-white">
					<h5 class="modal-title" id="exampleModalLabel">Tech Blog</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<div class="container text-center">
						<img src="img/<%=user.getProfile()%>" class="img-fluid"
							style="border-radius: 50%; max-width: 100px"><br>

						<h4 class="model-title mt-3" id="exampleModelLabel"><%=user.getName()%></h4>


						<div id="profile-details">
							<!-- details -->
							<table class="table">

								<tbody>
									<tr>
										<th scope="row">Id :</th>
										<td><%=user.getId()%></td>

									</tr>
									<tr>
										<th scope="row">Email :</th>
										<td><%=user.getEmail()%></td>

									</tr>
									<tr>
										<th scope="row">Gender :</th>
										<td><%=user.getGender()%></td>
									</tr>

									<tr>
										<th scope="row">Status :</th>
										<td><%=user.getAbout()%></td>
									</tr>

									<tr>
										<th scope="row">Registered On:</th>
										<td><%=user.getDatetime().toString()%></td>
									</tr>
								</tbody>
							</table>
						</div>

						<!--profile edit -->
						<div id="profile-edit" style="display: none">
							<h4>Edit Carefully!</h4>

							<form action="EditServlet" method="post"
								enctype="multipart/form-data">
								<table class="table">
									<tr>
										<th>Id :</th>
										<td><%=user.getId()%></td>
									</tr>

									<tr>
										<th>Name :</th>
										<td><input type="text" name="user_name"
											class="form-control" value="<%=user.getName()%>"></td>
									</tr>

									<tr>
										<th>Email :</th>
										<td><input type="email" name="user_email"
											class="form-control" value="<%=user.getEmail()%>"></td>
									</tr>

									<tr>
										<th>Password :</th>
										<td><input type="password" name="user_password"
											class="form-control" value="<%=user.getPassword()%>"></td>
									</tr>

									<tr>
										<th>Gender :</th>
										<td><%=user.getGender().toUpperCase()%></td>
									</tr>

									<tr>
										<th>About :</th>
										<td><textarea class="form-cotrol" rows="2"
												name="user_about">
												<%=user.getAbout()%>
											</textarea></td>
									</tr>
									<tr>
										<th>New Profile Photo:</th>
										<td><input type="file" name="image" class="form-control"></td>
									</tr>
								</table>

								<div>
									<button class="btn btn-outline-primary">Save</button>
								</div>
							</form>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Close</button>
					<button id="edit-profile-button" type="button"
						class="btn btn-primary">Edit</button>
				</div>
			</div>
		</div>
	</div>
	<!--profile Model end  -->




	<!-- Add Do-Post Modal -->

	<div class="modal fade" id="add-post-modal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Provide the
						Post Details</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>

				<div class="modal-body">

					<form id="add-post-form" action="AddPostServlet" method="post">

						<div class="form-group">
							<select class="form-control" name="cid">
								<option selected disabled>------Select Category------</option>

								<%
								PostDao postdao = new PostDao(ConnectionProvider.getConnection());
								ArrayList<Category> list = postdao.getAllCategories();
								for (Category l : list) {
								%>
								<option value="<%=l.getCid()%>"><%=l.getCname()%></option>
								<%
								}
								%>

							</select>
						</div>
						<div class="form-group">
							<input name="pTitle" type="text" placeholder="Write Title"
								class="form-control">
						</div>

						<div class="form-group">
							<textarea name="pContent" class="form-control"
								style="height: 100px" placeholder="Write Content"></textarea>
						</div>

						<div class="form-group">
							<textarea name="pCode" class="form-control" style="height: 100px"
								placeholder="Write Your Program (if Any)"></textarea>
						</div>

						<!-- <div class="form-group">
							<label>Select Your Pic..</label><br> <input type="file"
								name="pic">
						</div>  -->

						<div class="container text-center">
							<button type="submit" class="btn btn-outline-primary">Post</button>
						</div>
					</form>
				</div>

			</div>
		</div>
	</div>
	<!-- End Do-Post Modal -->



	<!-- javaSricpt -->

	<script src="js/myjs.js" type="text/javascript"></script>
	<!-- <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
		integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
		crossorigin="anonymous"></script> -->

	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>

	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

	<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" 
	  crossorigin="anonymous"></script>

	<script
		src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js"
		integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js"
		integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
		crossorigin="anonymous">
		
	</script>

	<script>
		$(document).ready(function() {
			let editStatus = false;

			$('#edit-profile-button').click(function() {

				if (editStatus == false) {

					$("#profile-details").hide()

					$("#profile-edit").show();

					editStatus = true;
					$(this).text("Back");
				} else {
					$("#profile-details").show()

					$("#profile-edit").hide();
					editStatus = false;

					$(this).text("Edit");
				}
			})
		});
	</script>



	<!-- add post Js -->
	<!-- 	<script> 
		$(document).ready(function(e) {

			$("#add-post-form").on("submit", function(event) {
				//This code get called when code is submitted.....

				event.preventDefault();

				
				let form = new FormData(this);
				//now requesting to server

				$.ajax({
					url : "AddPostServlet",
					type : 'POST',
					data : form,
					success : function(data, textStatus, jqXHR) {
						//success
						
					},
					error : function(jqXHR, textStatus, errorThrown) {
						//error...
					},
					processData : false,
					contentType : false
				})
			})

		})
	</script>
	-->


<!-- Loading post using ajax -->
 <script>
 
 	function getPosts(catid){
 		
 		$("#loader").show();
 		$("#post-container").hide();
 		
 		$.ajax({
 			url: "load_post.jsp",
 			data:{cid:catid},
 			success: function(data, textStatus, jqXHR){
 				console.log(data);
 				$("#loader").hide();
 				$("#post-container").show();
 				$('#post-container').html(data);
 			}
 		})
 	}
 	
 	$(document).ready(function(e){
 		getPosts(0)	
 	})
 </script>
</body>
</html>