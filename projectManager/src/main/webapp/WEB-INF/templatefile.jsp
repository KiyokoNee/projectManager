<!-- Main page body template -->
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
		<title>Insert title here</title>
		<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css">
		<link rel="stylesheet" href="/css/style.css" />
    	<script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
	</head>
	<body>
		
	</body>
</html>

<!-- Table Display -->
		<table class="table table-striped table-bordered">
			<thead>
				<tr>
					<th>ID</th>
					<th>Name</th>
					<th>Actions</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach var="item" items="${items}">
					<tr>
						<td><c:out value="${item.id}"></c:out></td>
						<td><a href="/items/${item.id}"><c:out value="${item.name}"></c:out></a></td>
						<td>
							<c:if test="${item.user.id == userId }">
								<a href="/items/${item.id}/edit">Edit</a>
								<a href="/items/${item.id}/delete">Delete</a>
							</c:if>
							<c:if test="${item.user.id != userId}">
								<a href="/items/${item.id}/borrow">Borrow</a>
							</c:if>
						</td>
					</tr>
			</c:forEach>
			</tbody>
		</table>
		<!-- Basic Form Input -->
		<form:form class="full-form" modelAttribute="newBook" method="post" action="/books/add" >
			<h2>Register</h2>
			<input type="hidden" id="user" name="user" value="${userId}" />
			<span class="text-danger"><form:errors path="title" /></span>
			<div class="d-flex justify-content-between">
				<form:label path="title">Title: </form:label>
				<form:input path="title" />
			</div>	
			<span class="text-danger"><form:errors path="author" /></span>
			<div class="d-flex justify-content-between">
				<form:label path="author">Author: </form:label>
				<form:input path="author" />
			</div>	
			<span class="text-danger"><form:errors path="thoughts" /></span>
			<div class="d-flex justify-content-between">
				<form:label path="thoughts">Thoughts: </form:label>
				<form:input path="thoughts" />
			</div>
			<button class="btn btn-primary float-end" type="submit">Submit</button>
		</form:form>
		
		<!-- Basic Login Form -->
		<div id="forms" class="d-flex justify-content-evenly">
				<form:form class="small-form" modelAttribute="newUser" method="post" action="/register" >
					<h2>Register</h2>	
					<span class="text-danger"><form:errors path="username" /></span>
					<div class="d-flex justify-content-between">
						<form:label path="username">User Name: </form:label>
						<form:input path="username" />
					</div>	
					<span class="text-danger"><form:errors path="email" /></span>
					<div class="d-flex justify-content-between">
						<form:label path="email">Email: </form:label>
						<form:input path="email" />
					</div>	
					<span class="text-danger"><form:errors path="password" /></span>
					<div class="d-flex justify-content-between">
						<form:label path="password">Password: </form:label>
						<input type="password" name="password" />
					</div>	
					<span class="text-danger"><form:errors path="confirm" /></span>
					<div class="d-flex justify-content-between">
						<form:label path="confirm">Confirm Password: </form:label>
						<input type="password" name="confirm" />
					</div>
					<button class="btn btn-primary float-end" type="submit">Submit</button>
				</form:form>
				
				<form:form class="small-form" modelAttribute="newLogin" method="post" action="/login">
					<h2>Login</h2>
					<span class="text-danger"><form:errors path="email" /></span>
					<div class="d-flex justify-content-between">
						<form:label path="email">Email: </form:label>
						<form:input path="email" />
					</div>	
					<span class="text-danger"><form:errors path="password" /></span>
					<div class="d-flex justify-content-between">
						<form:label path="password">Password: </form:label>
						<input type="password" name="password" />
					</div>
					<button class="btn btn-primary float-end" type="submit">Submit</button>
				</form:form>
			</div>
			<!-- Select input dynamically filled -->
				<select id="studentid" name="studentid">
					<c:forEach var="student" items="${allStudents}">
						<option value="${student.id}"><c:out value="${student.name}"></c:out> <c:if test="${student.dorm != null}">(<c:out value="${student.dorm.name}"></c:out>)</c:if></option>
					</c:forEach>
				</select>