package com.team.culife.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.team.culife.dao.ExhibitionDAO;
import com.team.culife.vo.ExhibitionVO;
import com.team.culife.vo.MemberVO;
import com.team.culife.vo.PagingVO;
import com.team.culife.vo.WorkVO;

@Service
public class ExhibitionServiceImpl implements ExhibitionService {

	@Inject
	ExhibitionDAO dao;

	@Override
	public int exhibitionWrite(ExhibitionVO vo) {
		return dao.exhibitionWrite(vo);
	}

	@Override
	public ExhibitionVO exhibitionSelect(int no) {
		return dao.exhibitionSelect(no);
	}

	@Override
	public ExhibitionVO exhibitionSelectByEndDate(int author_no) {
		return dao.exhibitionSelectByEndDate(author_no);
	}

	@Override
	public int workInsert(WorkVO vo) {
		return dao.workInsert(vo);
	}

	@Override
	public List<WorkVO> workSelectByExhibitionNo(int exhibition_no) {
		return dao.workSelectByExhibitionNo(exhibition_no);
	}

	@Override
	public int workUpdate(WorkVO vo) {
		return dao.workUpdate(vo);
	}

	@Override
	public int workTotalRecord(PagingVO vo) {
		return dao.workTotalRecord(vo);
	}

	@Override
	public List<WorkVO> workSelectByAuthorNo(PagingVO vo) {
		return dao.workSelectByAuthorNo(vo);
	}
	
	public WorkVO workSelectMaxWriteDate(int exhibition_no) {
		return dao.workSelectMaxWriteDate(exhibition_no);
	}

	@Override
	public int workDelete(WorkVO vo) {
		return dao.workDelete(vo);
	}
	

	
}
