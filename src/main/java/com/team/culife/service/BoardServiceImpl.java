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
	public List<BoardVO> selectList(PagingVO pvo, BoardVO vo) {
		return dao.selectList(pvo, vo);
	}

}
