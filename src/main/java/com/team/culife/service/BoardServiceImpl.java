package com.team.culife.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.team.culife.dao.BoardDAO;
import com.team.culife.vo.BoardVO;
import com.team.culife.vo.PagingVO;

@Service
public class BoardServiceImpl implements BoardService {

	@Inject
	BoardDAO dao;

	@Override
	public int boardInsert(BoardVO vo) {
		return dao.boardInsert(vo);
	}

	@Override
	public void updateViews(int no) {
		dao.updateViews(no);
	}

	@Override
	public BoardVO selectView(int no) {
		return dao.selectView(no);
	}

	@Override
	public int selectTotalRecord(PagingVO pvo, BoardVO vo) {
		return dao.selectTotalRecord(pvo, vo);
	}

	@Override
	public BoardVO selectEditView(int no) {
		return dao.selectEditView(no);
	}

	@Override
	public int updateEditView(BoardVO vo) {
		return dao.updateEditViews(vo);
	}

	@Override
	public int deleteView(int no, int member_no) {
		return dao.deleteView(no, member_no);
	}

	@Override
	public int boardTotalRecord(PagingVO vo) {
		return dao.boardTotalRecord(vo);
	}

	@Override
	public List<BoardVO> boardSelectByMemberNo(PagingVO vo) {
		return dao.boardSelectByMemberNo(vo);
	}

	@Override
	public List<BoardVO> freeselectList(PagingVO pvo) {
		return dao.freeselectList(pvo);
	}

	@Override
	public List<BoardVO> helpselectList(PagingVO pvo) {
		return dao.helpselectList(pvo);
	}

}
