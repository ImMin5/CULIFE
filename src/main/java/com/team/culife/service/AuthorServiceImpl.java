package com.team.culife.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.team.culife.dao.AuthorDAO;
import com.team.culife.vo.AuthorVO;

@Service
public class AuthorServiceImpl implements AuthorService{
	@Inject
	AuthorDAO dao;
	
	@Override
	public AuthorVO authorSelectByName(String author) {
		return dao.authorSelectByName(author);
	}

}
