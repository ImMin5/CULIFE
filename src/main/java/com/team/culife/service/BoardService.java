package com.team.culife.service;

import java.util.List;

import com.team.culife.vo.BoardVO;
import com.team.culife.vo.PagingVO;

public interface BoardService {

	// 나눔,요청 글 등록
	public int boardInsert(BoardVO vo);
	
	// 글 리스트 보이기
	public List<BoardVO> selectList(PagingVO pvo, BoardVO vo, String keyword);
	
	// 게시판의 레코드 개수 가져오기(페이징)
	public int selectTotalRecord(PagingVO pvo, BoardVO vo, String keyword);
	
	// 상세페이지(뷰)
	public BoardVO selectView(int no);
	
	// 조회수 증가
	public void updateViews(int no);
	
	// 상세페이지를 수정,삭제할 때 필요한 파일명 구하기
	public BoardVO getFileName(int no);
	
	// 상세페이지 수정 폼
	public BoardVO selectEditView(int no);
	
	// 상세페이지 수정 DB연결
	public int updateEditView(BoardVO vo);
	
	// 상세페이지 삭제 
	public int deleteView(int no, String userid);
	
	// 찜하기 등록하기
	public int insertPick(int no, String userid);
	
	// 찜하기 등록 board DB 연결
	public int plusBoardPick(int no);
	
	// 찜하기 취소하기
	public int deletePick(int no, String userid);
	
	// 찜하기 취소 board DB 연결
	public int minusBoardPick(int no);
}