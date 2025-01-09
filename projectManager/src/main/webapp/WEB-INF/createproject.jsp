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
	<body class="w-75 mx-auto my-5">
		<form:form class="w-50 mx-auto" modelAttribute="newProject" method="post" action="/projects/create" >
			<h2 class="mb-4">Create a Project</h2>
			<table class="table table-borderless">
				<tbody>
					<tr>
						<td><form:label path="title">Project Title: </form:label></td>
						<td>
							<form:input path="title" />
							<span class="text-danger"><form:errors path="title" /></span>
						</td>
					</tr>
					<tr>
						<td><form:label path="description">Project Description: </form:label></td>
						<td>
							<textarea id="description" name="description" ><c:out value="${newProject.description}"></c:out></textarea>
							<span class="text-danger"><form:errors path="description" /></span>
						</td>
					</tr>
					<tr>
						<td><form:label path="dueDate">Due Date: </form:label></td>
						<td>
							<input type="date" name="dueDate" value="${newProject.dueDate}" />
							<span class="text-danger"><form:errors path="dueDate" /></span>
						</td>
					</tr>
					<tr>
						<td><a class="btn btn-danger float-start" href="/dashboard">Cancel</a></td>
						<td class="text-center"><button class="btn btn-success" type="submit">Submit</button></td>
					</tr>
				</tbody>
			</table>
			<input type="hidden" id="teamLead" name="teamLead" value="${userId}" />
		</form:form>
	</body>
</html>