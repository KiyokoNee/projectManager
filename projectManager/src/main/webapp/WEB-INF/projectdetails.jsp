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
		<title>Project Details</title>
		<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css">
		<link rel="stylesheet" href="/css/style.css" />
    	<script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
	</head>
	<body class="mx-auto mt-5 w-75">
		<div class="d-flex justify-content-between mb-3">
			<h2>Project Details</h2>
			<a href="/">Dashboard</a>
		</div>
		<table class="table table-borderless">
			<tbody>
				<tr>
					<td>Project:</td>
					<td><c:out value="${project.title}"></c:out></td>
				</tr>
				<tr>
					<td>Description:</td>
					<td><c:out value="${project.description}"></c:out></td>
				</tr>
				<tr>
					<td>Due Date:</td>
					<td><c:out value="${project.dueDate}"></c:out></td>
				</tr>
			</tbody>
		</table>
		<a href="/projects/${project.id}/tasks">See tasks!</a>
		<form method="post" action="/projects/delete/${project.id}" >
			<input type="hidden" name="_method" value="delete" />
			<button class="btn btn-danger float-end" type="submit">Delete Project</button>
		</form>
	</body>
</html>