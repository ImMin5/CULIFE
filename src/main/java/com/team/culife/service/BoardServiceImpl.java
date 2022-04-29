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
	public List<BoardVO> selectList(PagingVO pvo, BoardVO vo, String keyword) {
		return dao.selectList(pvo, vo, keyword);
	}
	
	@Override
	public int selectTotalRecord(PagingVO pvo, BoardVO vo, String keyword ) {
		return dao.selectTotalRecord(pvo, vo, keyword);
	}

	@Override
	public BoardVO selectView(int no) {
		return dao.selectView(no);
	}

	@Override
	public void updateViews(int no) {
		dao.updateViews(no);
	}

	@Override
	public BoardVO getFileName(int no) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public BoardVO selectEditView(int no) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int updateEditView(BoardVO vo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteView(int no, String userid) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int insertPick(int no, String userid) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int plusBoardPick(int no) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deletePick(int no, String userid) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int minusBoardPick(int no) {
		// TODO Auto-generated method stub
		return 0;
	}
}