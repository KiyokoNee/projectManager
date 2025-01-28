package com.gearing.projectmanager.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gearing.projectmanager.models.Project;
import com.gearing.projectmanager.models.Task;
import com.gearing.projectmanager.models.User;
import com.gearing.projectmanager.services.ProjectService;
import com.gearing.projectmanager.services.TaskService;
import com.gearing.projectmanager.services.UserService;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
@RequestMapping("/projects")
public class ProjectController {
	@Autowired
	private ProjectService projectServ;
	@Autowired
	private UserService userServ;
	@Autowired
	private TaskService taskServ;
	
	// All Get Requests
	@GetMapping("/new")
	public String projectForm(Model model, HttpSession session) {
		if(session.getAttribute("userId") == null)
			return "redirect:/";
		if(!model.containsAttribute("newProject"))
			model.addAttribute("newProject", new Project());
		
		return "createproject.jsp";
	}
	
	@GetMapping("/edit/{id}")
	public String projectEdit(Model model, @PathVariable Long id, HttpSession session) {
		Long userId = (Long)session.getAttribute("userId");
		Project project = projectServ.getProjectById(id);
		
		if(userId == null || project.getTeamLead().getId().compareTo(userId) != 0)
			return "redirect:/";
		if(!model.containsAttribute("currProject"))
			model.addAttribute("currProject", project);
		
		return "editproject.jsp";
	}
	
	@GetMapping("/{id}")
	public String projectDetails(Model model, @PathVariable Long id, HttpSession session) {
		Long userId = (Long)session.getAttribute("userId");
		Project project = projectServ.getProjectById(id);
		
		if(userId == null || project == null)
			return "redirect:/";
		
		model.addAttribute("project", project);
		
		return "projectdetails.jsp";
	}
	
	@GetMapping("/{id}/tasks")
	public String projectTasks(Model model, @PathVariable Long id, HttpSession session) {
		Long userId = (Long)session.getAttribute("userId");
		Project project = projectServ.getProjectById(id);
		
		if(userId == null || project == null)
			return "redirect:/";
		if(model.getAttribute("taskForm") == null)
			model.addAttribute("taskForm", new Task());
		
		model.addAttribute("project", project);
		model.addAttribute("canAddTasks", projectServ.projectContainsUser(id, userId));
		
		return "projecttasks.jsp";
	}
	
	// All Post Requests
	@PostMapping("/create")
	public String projectCreate(Model model, @Valid @ModelAttribute("newProject") Project newProject,
			BindingResult result, HttpSession session, RedirectAttributes redirectAttributes) {
		if(session.getAttribute("userId") == null)
			return "redirect:/";
		
		projectServ.createProject(newProject, result);
		
		if(result.hasErrors()) {
			// Set up flash data so we can redirect to the page with errors and data
			redirectAttributes.addFlashAttribute("org.springframework.validation.BindingResult.newProject", result);
			redirectAttributes.addFlashAttribute("newProject", newProject);
			
			return "redirect:/projects/new";
		}
		
		return "redirect:/dashboard";
	}
	
	@PostMapping("/{projectId}/tasks/add")
	public String taskCreate(Model model, @PathVariable Long projectId, @Valid @ModelAttribute("taskForm") Task taskForm,
			BindingResult result, HttpSession session, RedirectAttributes redirectAttributes) {
		if(session.getAttribute("userId") == null)
			return "redirect:/";

		if(result.hasErrors()) {
			// Set up flash data so we can redirect to the page with errors and data
			System.out.println(result.getAllErrors());
			redirectAttributes.addFlashAttribute("org.springframework.validation.BindingResult.taskForm", result);
			redirectAttributes.addFlashAttribute("taskForm", taskForm);
			
			return "redirect:/projects/" + projectId + "/tasks";
		}
		
		User user = userServ.findById((Long)session.getAttribute("userId"));
		Project project = projectServ.getProjectById(projectId);
		
		taskForm.setCreator(user);
		taskForm.setProject(project);
		taskServ.createTask(taskForm);
		
		return "redirect:/projects/" + projectId + "/tasks";
	}
	
	// All Put Requests
	@PutMapping("/update")
	public String projectUpdate(Model model, HttpSession session, @Valid @ModelAttribute("currProject") Project currProject, 
			BindingResult result, RedirectAttributes redirectAttributes) {
		Long userId = (Long)session.getAttribute("userId");
		if(userId == null || currProject.getTeamLead().getId().compareTo(userId) != 0)
			return "redirect:/dashboard";
		
		projectServ.updateProject(currProject, result);
		
		if(result.hasErrors()) {
			// Set up flash data so we can redirect to the page with errors and data
			redirectAttributes.addFlashAttribute("org.springframework.validation.BindingResult.currProject", result);
			redirectAttributes.addFlashAttribute("currProject", currProject);
			
			return "redirect:/projects/edit/" + currProject.getId();
		}
		
		return "redirect:/dashboard";
	}
	
	@PutMapping("/join/{id}")
	public String projectJoin(@PathVariable Long id, HttpSession session) {
		// Pull data to use for validation
		Long userId = (Long)session.getAttribute("userId");
		Project project = projectServ.getProjectById(id);
		
		// Reroute if user isn't supposed to access this path
		if(userId == null || project.getTeamLead().getId().compareTo(userId) == 0)
			return "redirect:/";
		
		projectServ.addUserToProject(id, userId);
		return "redirect:/dashboard";
	}
	
	@PutMapping("/leave/{id}")
	public String projectLeave(@PathVariable Long id, HttpSession session) {
		// Pull data to use for validation
		Long userId = (Long)session.getAttribute("userId");
		User user = userServ.findById(userId);
		Project project = projectServ.getProjectById(id);
		
		// Reroute if user isn't supposed to access this path
		if(userId == null || !project.getTeam().contains(user))
			return "redirect:/";
		
		projectServ.removeUserFromProject(id, userId);
		return "redirect:/dashboard";
	}
	
	// Any Delete Requests - WARNING: Be sure the services remove entity references before deletion if using FetchType.LAZY
	@DeleteMapping("/delete/{id}")
	public String projectDelete(@PathVariable Long id, HttpSession session) {
		// Pull data for validation
		Long userId = (Long)session.getAttribute("userId");
		Project project = projectServ.getProjectById(id);
		
		// Reroute if the path is invalid for the user
		if(userId == null || project.getTeamLead().getId().compareTo(userId) != 0)
			return "redirect:/";
		
		projectServ.deleteProject(project);
		return "redirect:/dashboard";
	}
}
