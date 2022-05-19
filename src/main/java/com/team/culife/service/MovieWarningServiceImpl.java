package com.team.culife.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.team.culife.dao.MovieWarningDAO;
import com.team.culife.vo.MovieWarningVO;

@Service
public class MovieWarningServiceImpl implements MovieWarningService{
	@Inject MovieWarningDAO dao;
	
	@Override
	public int mwarning(MovieWarningVO warning) {
		return dao.mwarning(warning);
	}
}
