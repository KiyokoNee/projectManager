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
		<title>Tasks Page</title>
		<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css">
		<link rel="stylesheet" href="/css/style.css" />
    	<script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
	</head>
	<body class="w-75 mx-auto my-5">
		<div class="d-flex justify-content-between" >
			<h1>Project: <c:out value="${project.title}"></c:out></h1>
			<a href="/">Back to Dashboard</a>
		</div>
		<p>Project Lead: <c:out value="${project.teamLead.firstName}"></c:out></p>
		<c:if test="${canAddTasks}">	
			<form:form class="my-5 w-50" modelAttribute="taskForm" action="/projects/${project.id}/tasks/add" method="post">
				<table class="table table-borderless">
					<tbody>
						<tr>
							<td class="p-0"><form:label path="ticket">Add a task ticket for this team: </form:label></td>
							<td>
								<textarea cols="30" rows="7" name="ticket"><c:out value="${taskForm.ticket}"></c:out></textarea>
								<span class="text-danger"><form:errors path="ticket" /></span>
							</td>
						</tr>
						<tr>
							<td></td>
							<td><button class="btn btn-primary" type="submit">Submit</button></td>
						</tr>
					</tbody>
				</table>
				
			</form:form>
		</c:if>
		<div>
			<c:forEach var="task" items="${project.tasks}">
				<p class="fw-bold">Added by <c:out value="${task.creator.firstName}"></c:out> at <fmt:formatDate value="${task.createdAt}" pattern="K:mma MMM d"></fmt:formatDate>:</p>
				<p><c:out value="${task.ticket}"></c:out></p>
			</c:forEach>
		</div>
	</body>
</html>