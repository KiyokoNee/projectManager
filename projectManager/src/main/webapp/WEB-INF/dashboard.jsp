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
		<title>Project Manager Dashboard</title>
		<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css">
		<link rel="stylesheet" href="/css/style.css" />
    	<script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
	</head>
	<body class="w-75 mx-auto my-5">
		<div class="d-flex justify-content-between">
			<div>
				<h1>Welcome, <c:out value="${firstname}"></c:out>!</h1>
				<p class="fw-bold fst-italic mt-4">All Projects</p>
			</div>
			<div class="d-flex flex-column">
				<a href="/logout">Logout</a>
				<a href="/projects/new">+ New Project</a>
			</div>
		</div>
		<table class="table table-striped table-bordered">
			<thead>
				<tr>
					<th>Project</th>
					<th>Team Lead</th>
					<th>Due Date</th>
					<th class="text-center">Actions</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="project" items="${uninvolvedProjects}">
					<tr class="align-middle">
						<td><a href="/projects/${project.id}"><c:out value="${project.title}"></c:out></a></td>
						<td><c:out value="${project.teamLead.firstName}"></c:out></td>
						<td>
							<fmt:parseDate value="${project.dueDate }" pattern="yyyy-MM-dd" var="parsedDate" type="date" />
							<fmt:formatDate value="${parsedDate}" pattern="MMM dd, yyyy" />
						</td>
						<td class="text-center">
							<form method="post" action="/projects/join/${project.id}" >
								<input type="hidden" name="_method" value="put" />
								<button class="btn btn-link" type="submit">Join Team</button>
							</form>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<p class="fw-bold fst-italic mt-4">Your Projects</p>
		<table class="table table-striped table-bordered">
			<thead>
				<tr>
					<th>Project</th>
					<th>Team Lead</th>
					<th>Due Date</th>
					<th class="text-center">Actions</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="project" items="${involvedProjects}">
					<tr class="align-middle">
						<td><a href="/projects/${project.id}"><c:out value="${project.title}"></c:out></a></td>
						<td><c:out value="${project.teamLead.firstName}"></c:out></td>
						<td>
							<fmt:parseDate value="${project.dueDate }" pattern="yyyy-MM-dd" var="parsedDate" type="date" />
							<fmt:formatDate value="${parsedDate}" pattern="MMM dd, yyyy" />
						</td>
						<td class="text-center">
							<c:if test="${userId == project.teamLead.id}">
								<a href="/projects/edit/${project.id}">Edit</a>
							</c:if>
							<c:if test="${userId != project.teamLead.id}">
								<form method="post" action="/projects/leave/${project.id}" >
									<input type="hidden" name="_method" value="put" />
									<button class="btn btn-link" type="submit">Leave Team</button>
								</form>
							</c:if>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</body>
</html>