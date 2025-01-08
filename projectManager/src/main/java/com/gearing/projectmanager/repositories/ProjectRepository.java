package com.gearing.projectmanager.repositories;

import java.util.List;
import java.util.Optional;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.gearing.projectmanager.models.Project;
import com.gearing.projectmanager.models.User;

@Repository
public interface ProjectRepository extends CrudRepository<Project, Long>{
	List<Project> findAll();
	
	Optional<Project> findById(Long id);
	
	List<Project> findAllByTeamLead(User teamLead);
	
	List<Project> findAllByTeam(User user);
	
	List<Project> findByTeamNotContains(User user);
}
