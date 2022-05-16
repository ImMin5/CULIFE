package com.team.culife.service;

import java.util.List;

import com.team.culife.vo.BoardVO;
import com.team.culife.vo.PagingVO;

public interface BoardService {

	// 자유게시판,문의사항 글 등록
	public int boardInsert(BoardVO vo);
	
	// 글 리스트 보이기
	public List<BoardVO> selectList(PagingVO pvo);

	//조회수
	public void updateViews(int no);
	
	//상세페이지
	public BoardVO selectView(int no);
	
	//게시판의 레코드 개수 가져오기(페이징) 
	public int selectTotalRecord(PagingVO pvo, BoardVO vo);

	//상세페이지 수정 폼 
	public BoardVO selectEditView(int no);
	
	//상세페이지 수정 DB연결 
	public int updateEditView(BoardVO vo);
	 
	//상세페이지 삭제 
	public int deleteView(int no, int member_no);
	
	public int boardTotalRecord(PagingVO vo);
	
	public List<BoardVO> boardSelectByMemberNo(PagingVO vo);
}