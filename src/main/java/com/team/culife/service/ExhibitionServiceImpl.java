package com.team.culife.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.team.culife.dao.ExhibitionDAO;
import com.team.culife.vo.ExhibitionVO;

@Service
public class ExhibitionServiceImpl implements ExhibitionService {

	@Inject
	ExhibitionDAO dao;
	
	@Override
	public int authorApplyWrite(ExhibitionVO vo) {
		return dao.authorApplyWrite(vo);
	}

	@Override
	public int authorMemberSelect(ExhibitionVO vo) {
		return dao.authorMemberSelect(vo);
	}

}
