<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- c:out ; c:forEach etc. --> 
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!-- Formatting (dates) --> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>
<!-- form:form -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!-- for rendering errors on PUT routes -->
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Project Manager</title>
		<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css">
		<link rel="stylesheet" href="/css/style.css" />
    	<script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
	</head>
	<body class="w-75 mx-auto my-5">
			<div class="text-center">
				<h1 class="purple">Project Manager</h1>
				<p>A place for teams to manage projects.</p>
			</div>
			<div id="forms" class="d-flex justify-content-evenly">
				<form:form modelAttribute="newUser" method="post" action="/register" >
					<h2 class="my-3">Register</h2>	
					<div class="d-flex justify-content-between my-3">
						<form:label path="firstName">First Name: </form:label>
						<form:input path="firstName" />
					</div>
					<span class="text-danger my-3"><form:errors path="firstName" /></span>
					<div class="d-flex justify-content-between my-3">
						<form:label path="lastName">Last Name: </form:label>
						<form:input path="lastName" />
					</div>
					<span class="text-danger my-3"><form:errors path="lastName" /></span>
					<div class="d-flex justify-content-between my-3">
						<form:label path="email">Email: </form:label>
						<form:input path="email" />
					</div>
					<span class="text-danger my-3"><form:errors path="email" /></span>
					<div class="d-flex justify-content-between my-3">
						<form:label path="password">Password: </form:label>
						<input type="password" name="password" />
					</div>	
					<span class="text-danger my-3"><form:errors path="password" /></span>
					<div class="d-flex justify-content-between my-3">
						<form:label path="confirm">Confirm Password: </form:label>
						<input type="password" name="confirm" />
					</div>
					<span class="text-danger my-3"><form:errors path="confirm" /></span>
					<button class="btn btn-primary float-end" type="submit">Submit</button>
				</form:form>
				
				<form:form modelAttribute="newLogin" method="post" action="/login">
					<h2 class="my-3">Login</h2>
					<div class="d-flex justify-content-between my-3">
						<form:label path="email">Email: </form:label>
						<form:input path="email" />
					</div>
					<span class="text-danger my-3"><form:errors path="email" /></span>
					<div class="d-flex justify-content-between my-3">
						<form:label path="password">Password: </form:label>
						<input type="password" name="password" />
					</div>
					<span class="text-danger my-3"><form:errors path="password" /></span>
					<button class="btn btn-primary float-end" type="submit">Submit</button>
				</form:form>
			</div>
	</body>
</html>