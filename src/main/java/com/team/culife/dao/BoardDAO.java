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
	
	// 자유게시판 보이기
	public List<BoardVO> freeselectList(PagingVO pvo);
	// 문의사항 리스트
	public List<BoardVO> helpselectList(PagingVO pvo);
	
	// 글 내용
	public BoardVO selectView(int no);

	//	게시판의 레코드 개수 가져오기(페이징) 
	public int selectTotalRecord(PagingVO pvo, BoardVO vo);

	//조회수 증가
	public void updateViews(int no);

	// 글 내용 수정 폼
	public BoardVO selectEditView(int no);

	// 글 내용 수정DB연결
	public int updateEditViews(BoardVO vo);

	// 글 삭제
	public int deleteView(int no, int member_no);
	
	public int boardTotalRecord(PagingVO vo);
	
	public List<BoardVO> boardSelectByMemberNo(PagingVO vo);
}