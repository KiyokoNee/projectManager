package com.gearing.projectmanager.services;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.validation.BindingResult;

import com.gearing.projectmanager.models.Project;
import com.gearing.projectmanager.models.Task;
import com.gearing.projectmanager.models.User;
import com.gearing.projectmanager.repositories.ProjectRepository;
import com.gearing.projectmanager.repositories.UserRepository;

@Service
public class ProjectService {
	@Autowired
	private ProjectRepository projectRepo;
	@Autowired
	private UserRepository userRepo;
	@Autowired
	private TaskService taskServ;
	
	public List<Project> getAllProjects(){
		return projectRepo.findAll();
	}
	
	public Project getProjectById(Long id) {
		return projectRepo.findById(id).isPresent() ? projectRepo.findById(id).get() : null;
	}
	
	public List<Project> getProjectsByTeamLead(User teamLead) {
		return projectRepo.findAllByTeamLead(teamLead);
	}
	
	public List<Project> getProjectsByTeam(User team) {
		return projectRepo.findAllByTeam(team);
	}
	
	public List<Project> getProjectsByTeamExcludes(User team) {
		List<Project> projects = projectRepo.findByTeamNotContains(team);
		projects.removeAll(getProjectsByTeamLead(team));
		
		return projects;
	}
	
	public boolean projectContainsUser(Long projectId, Long userId) {
		Optional<Project> optionalProject = projectRepo.findById(projectId);
		Optional<User> optionalUser = userRepo.findById(userId);
		
		if(optionalProject.isEmpty() || optionalUser.isEmpty())
			return false;
		
		Project project = optionalProject.get();
		User user = optionalUser.get();
		
		if(project.getTeam().contains(user) || project.getTeamLead().equals(user))
			return true;
		return false;
	}
	
	public List<Project> getProjectByTeamIncludes(User team) {
		List<Project> projects = getAllProjects();
		projects.removeAll(getProjectsByTeamExcludes(team));
		
		return projects;
	}
	
	public void addUserToProject(Long projectId, Long userId) {
		// Find the potential objects
		Optional<Project> optionalProject = projectRepo.findById(projectId);
		Optional<User> optionalUser = userRepo.findById(userId);
		
		// Return without doing anything if objects aren't valid
		if(optionalProject.isEmpty() || optionalUser.isEmpty())
			return;
		
		// Pull actual object data
		Project project = optionalProject.get();
		User user = optionalUser.get();
		
		// Update project with new user
		project.getTeam().add(user);
		projectRepo.save(project);
	}
	
	public void removeUserFromProject(Long projectId, Long userId) {
		// Find the potential objects
		Optional<Project> optionalProject = projectRepo.findById(projectId);
		Optional<User> optionalUser = userRepo.findById(userId);
		
		// Return without doing anything if objects aren't valid
		if(optionalProject.isEmpty() || optionalUser.isEmpty())
			return;
		
		// Pull actual object data
		Project project = optionalProject.get();
		User user = optionalUser.get();
		
		// Update project by removing user
		project.getTeam().remove(user);
		projectRepo.save(project);
	}
	
	public Project createProject(Project project, BindingResult result) {
		if(project.getDueDate() != null && project.getDueDate().isBefore(LocalDate.now()))
			result.rejectValue("dueDate", "error.dueDate", "The due date can't be before today!");
		if(result.hasErrors())
			return null;
		
		return projectRepo.save(project);
	}
	
	public Project updateProject(Project project, BindingResult result) {
		if(project.getDueDate() != null && project.getDueDate().isBefore(LocalDate.now()))
			result.rejectValue("dueDate", "error.dueDate", "The due date can't be before today!");
		if(result.hasErrors())
			return null;
		
		return projectRepo.save(project);
	}
	
	public void deleteProject(Project project) {
		project.getTeam().clear();
		taskServ.deleteTaskList(project.getTasks());
		projectRepo.save(project);
		
		projectRepo.delete(project);
	}
}
