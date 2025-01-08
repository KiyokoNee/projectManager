package com.gearing.projectmanager.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gearing.projectmanager.models.Project;
import com.gearing.projectmanager.models.Task;
import com.gearing.projectmanager.repositories.TaskRepository;

@Service
public class TaskService {
	@Autowired
	private TaskRepository taskRepo;
	
	public List<Task> getAllByProject(Project project){
		return taskRepo.findAllByProject(project);
	}
	
	public Task createTask(Task task) {
		return taskRepo.save(task);
	}
	
	public void deleteTask(Task task) {
		taskRepo.delete(task);
	}
}
