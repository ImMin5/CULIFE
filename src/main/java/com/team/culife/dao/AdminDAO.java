package com.team.culife.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.team.culife.vo.AdminPagingVO;
import com.team.culife.vo.AuthorVO;
import com.team.culife.vo.BoardVO;
import com.team.culife.vo.MemberBanVO;
import com.team.culife.vo.MemberVO;

@Mapper
@Repository
public interface AdminDAO {
	
	//회원목록 불러오기
	public List<MemberVO> memberList(AdminPagingVO pVO);
	//회원 카운트
	public int totalRecord(AdminPagingVO pVO);	
	//회원 탈퇴
	public int memberDel(MemberVO mVO);
	//회원상태: 정상
	public int memberNor(MemberVO mVO);
	//회원상태: 정지
	public int memberBan(MemberVO mVO);
	//회원상태: 정지날짜설정
	public int memberBanDate(MemberBanVO mbVO);
	//회원상태: member_ban에서 삭제
	public int memberBanDel(MemberBanVO mbVO);
	
	//작가목록 불러오기
	public List<AuthorVO> authorList(AdminPagingVO pVO);
	//작가 카운트
	public int author_totalRecord(AdminPagingVO pVO);
	//작가 승인
	public int authorUpgrade(AuthorVO aVO);
	//작가 취소
	public int authorDelete(AuthorVO mVO);
	
	//스케줄러 실행: member테이블 회원상태: 정상
	public void scheduleUpdate();
	//스케줄러 실행: member_ban테이블 회원정보 삭제
	public void scheduleDelete();
	
	//자유게시판목록 불러오기
	public List<BoardVO> adminBoardList(AdminPagingVO pVO);
	//자유게시판 카운트
	public int board_totalRecord(AdminPagingVO pVO);
	
	
}
