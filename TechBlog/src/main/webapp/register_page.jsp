<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Register Page</title>
<!-- css -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
.banner-background{
	clip-path: polygon(30% 0%, 70% 0%, 100% 0, 100% 94%, 67% 94%, 29% 91%, 0 94%, 0 0);
}
</style>
</head>
<body>
	<%@include file="normal_navbar.jsp" %>
	<main class="primary-background p-5 banner-background d-flex-align-item-center"style="height: 120vh">
		<div class="container">
			<div class="col-md-6 offset-md-3">
				<div class="card">
					
				<div class="card-header text-center primary-background text-white">
				<span class="fa fa-user-plus"></span>
					Register here
				</div>
				
				
				<div class="card-body">
					<form id="reg-form" action="RegisterServlet" method="get">
				  <div class="form-group">
				    <label for="username">User name</label>
				    <input name="user_name" type="text" class="form-control" id="username" aria-describedby="emailHelp" placeholder="User name">
				    <small id="emailHelp" class="form-text text-muted"></small>
				  </div>
				  <div class="form-group">
				  	<label for="email">Enter email</label>
				  	<input name="user_email"type="text" class="form-control" id="email" placeholder="Enter Email"/>
				  </div>
				  
				  <div class="form-group">
				    <label for="exampleInputPassword1">Password</label>
				    <input name="user_password" type="password" class="form-control" id="exampleInputPassword1" placeholder="Password">
				  </div>
				  
				  <div class="form-group">
				    <label for="gender">Select Gender</label><br>
				    <input type="radio" id="gender" name="user_gender" value="male">Male
				    <input type="radio"  id="gender" name="user_gender" value="female">Female
				  </div>
				  
				  <div class="form-group">
				  	<textarea name="about" id=""  rows="3" placeholder="Enter something about yourself.."></textarea>
				  </div>
				  
				  <div class="form-check">
				    <input name="check" type="checkbox" class="form-check-input" id="exampleCheck1">
				    <label class="form-check-label" for="exampleCheck1">agree terms and conditions</label>
				  </div>
				  <button type="submit" class="btn btn-primary">Sign up</button>
				</form>
				</div>
			
				</div>
			</div>
		</div>
	</main>


<!-- javaSricpt -->
	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" ></script>
  	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
	<script src="js/myjs.js" type="text/javascript"></script>
	
	<script>
		$(document).ready(function (){
			console.log("loaded........");	
		})	
		
		$('#reg-form').on('submit',function(event){
			//preventdefault used for not send this data to servlet
			event.preventDefault();
			
			let form=new FormData(this);
			
			
			//send register servlet
			$.ajax({
				url:"RegisterServlet",
				type:'POST',
				data: form,
				// success means like if
				success: function(data,textStatus,jqXHR){
					console.log(data)
				},
				//error means like else
				error: function(jqXHR,textStatus,errorThrown){
					console.log(jqXHR)
				},
				processData: false,
				contentType: false
			});
		});
	</script>
</body>
</html>