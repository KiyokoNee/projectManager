package com.gearing.projectmanager.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gearing.projectmanager.models.LoginUser;
import com.gearing.projectmanager.models.Project;
import com.gearing.projectmanager.models.User;
import com.gearing.projectmanager.services.ProjectService;
import com.gearing.projectmanager.services.UserService;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
public class UserController {
	@Autowired
	private UserService userServ;
	@Autowired
	private ProjectService projectServ;
	
	@GetMapping("/")
	public String index(Model model, HttpSession session) {
		// Check if user is already logged in
		if(session.getAttribute("userId") != null)
			return "redirect:/dashboard";
		
		// Create form models if this isn't a failed login/registration attempt
		if(!model.containsAttribute("newUser"))
			model.addAttribute("newUser", new User());
		if(!model.containsAttribute("newLogin"))
			model.addAttribute("newLogin", new LoginUser());
		
		return "loginpage.jsp";
	}
	
	@PostMapping("/register")
	public String register(Model model, @Valid @ModelAttribute("newUser") User newUser,
			BindingResult result, RedirectAttributes redirectAttributes, HttpSession session) {
		// Attempt to register the new user
		userServ.register(newUser, result);
		
		// Due to pass by reference, we also get the errors from the register method
		if(result.hasErrors()) {
			// Set up flash data so we can redirect to the page with errors and data
			redirectAttributes.addFlashAttribute("org.springframework.validation.BindingResult.newUser", result);
			redirectAttributes.addFlashAttribute("newUser", newUser);
			redirectAttributes.addFlashAttribute("newLogin", new LoginUser());
			return "redirect:/";
		}
		
		// No errors, so store session id to log them in
		session.setAttribute("userId", newUser.getId());
		
		// Goes to welcome page if all works well
		return "redirect:/dashboard";
	}
	
	@PostMapping("/login")
	public String login(Model model, @Valid @ModelAttribute("newLogin") LoginUser newLogin,
			BindingResult result, RedirectAttributes redirectAttributes, HttpSession session) {
		// Attempt to login with the given information
		User loggedUser = userServ.login(newLogin, result);
		
		// Due to pass by reference, we also get the errors from the login method
		if(result.hasErrors()) {
			// Set up flash data so we can redirect to the page with errors and data
			redirectAttributes.addFlashAttribute("org.springframework.validation.BindingResult.newLogin", result);
			redirectAttributes.addFlashAttribute("newUser", new User());
			redirectAttributes.addFlashAttribute("newLogin", newLogin);
			return "redirect:/";
		}
		
		// No errors, so store session id to log them in
		session.setAttribute("userId", loggedUser.getId());
		
		// Go to welcome page if all goes well
		return "redirect:/dashboard";
	}
	
	@GetMapping("/dashboard")
	public String dashboard(HttpSession session, Model model) {
		Long userId = (Long) session.getAttribute("userId");
		User user = userServ.findById(userId);
		
		if(user == null) {
			return "redirect:/";
		}
		
		List<Project> uninvolvedProjects = projectServ.getProjectsByTeamExcludes(user);
		List<Project> involvedProjects = projectServ.getProjectByTeamIncludes(user);
		
		model.addAttribute("firstname", user.getFirstName());
		model.addAttribute("uninvolvedProjects", uninvolvedProjects);
		model.addAttribute("involvedProjects", involvedProjects);
		
		return "dashboard.jsp";
	}
	
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		
		return "redirect:/";
	}
}
