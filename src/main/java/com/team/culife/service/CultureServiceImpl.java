package com.team.culife.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.team.culife.dao.CultureDAO;
import com.team.culife.vo.CultureVO;

@Service
public class CultureServiceImpl implements CultureService{
	@Inject CultureDAO dao;
	@Override
	public List<CultureVO> playList(String mt20id) {
		return dao.playList(mt20id);
	}

	@Override
	public List<CultureVO> musicalList(String mt20id) {
		return dao.musicalList(mt20id);
	}

	@Override
	public CultureVO cultureSelect(int no) {
		return dao.cultureSelect(no);
	}

}
