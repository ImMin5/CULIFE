package com.team.culife.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.team.culife.vo.BoardVO;
import com.team.culife.vo.PagingVO;

@Mapper 
@Repository
public interface BoardDAO {

	// 글 등록
	public int boardInsert(BoardVO vo); 
	
	// 글 리스트 보이기
	public List<BoardVO> selectList(BoardVO vo);
	/*
	 * // 게시판의 레코드 개수 가져오기(페이징) public int selectTotalRecord(PagingVO pvo, BoardVO
	 * vo);
	 * 
	 * // 상세페이지(뷰) public BoardVO selectView(int no);
	 * 
	 * // 조회수 증가 public void updateViews(int no);
	 */
}