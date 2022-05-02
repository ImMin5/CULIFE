package com.team.culife.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.team.culife.dao.MovieDAO;

@Service
public class MovieServiceImpl implements MovieService {
	@Inject
	MovieDAO dao;
}
