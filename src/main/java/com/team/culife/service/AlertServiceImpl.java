package com.team.culife.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.team.culife.dao.AlertDAO;
import com.team.culife.vo.AlertVO;

@Service
public class AlertServiceImpl implements AlertService {
	@Inject
	AlertDAO dao;
	
	@Override
	public List<AlertVO> alertSelectByMemberNo(int member_no) {
		return dao.alertSelectByMemberNo(member_no);
	}

	@Override
	public int alertInsert(int member_no, String content) {
		return dao.alertInsert(member_no, content);
	}

	@Override
	public int alertDeleteByNo(int no) {
		return dao.alertDeleteByNo(no);
	}

}
