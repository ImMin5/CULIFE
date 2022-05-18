package com.team.culife.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.team.culife.dao.WarningDAO;
import com.team.culife.vo.WarningVO;

@Service
public class WarningServiceImpl implements WarningService{
	@Inject WarningDAO dao;

	@Override
	public int warning(WarningVO warning) {
		return dao.warning(warning);
	}
}
