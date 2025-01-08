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
		<title>New Project</title>
		<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css">
		<link rel="stylesheet" href="/css/style.css" />
    	<script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
	</head>
	<body>
		<form:form class="full-form" modelAttribute="newProject" method="post" action="/projects/create" >
			<h2>Create a Project</h2>
			<input type="hidden" id="teamLead" name="teamLead" value="${userId}" />
			<span class="text-danger"><form:errors path="title" /></span>
			<div class="d-flex justify-content-between">
				<form:label path="title">Project Title: </form:label>
				<form:input path="title" />
			</div>	
			<span class="text-danger"><form:errors path="description" /></span>
			<div class="d-flex justify-content-between">
				<form:label path="description">Project Description: </form:label>
				<textarea id="description" name="description" ><c:out value="${newProject.description}"></c:out></textarea>
			</div>	
			<span class="text-danger"><form:errors path="dueDate" /></span>
			<div class="d-flex justify-content-between">
				<form:label path="dueDate">Due Date: </form:label>
				<input type="date" name="dueDate" value="${newProject.dueDate}" />
			</div>
			<div>
				<a class="btn btn-danger float-start" href="/dashboard">Cancel</a>
				<button class="btn btn-success float-end" type="submit">Submit</button>
			</div>
		</form:form>
	</body>
</html>