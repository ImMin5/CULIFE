package com.team.culife.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.team.culife.vo.AdminPagingVO;
import com.team.culife.vo.AdminReviewVO;
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
	//회원상태: 정지날짜설정(업데이트)
	public int memberBanDateUp(MemberBanVO mbVO);
	//회원상태: member_ban에서 삭제
	public int memberBanDel(MemberBanVO mbVO);
	
	//작가목록 불러오기
	public List<AuthorVO> authorList(AdminPagingVO pVO);
	//작가 카운트
	public int author_totalRecord(AdminPagingVO pVO);
	//작가 신청 카운트
	public int author_cnt(AuthorVO aVO);
	//작가 승인
	public int authorUpgrade(AuthorVO aVO);
	//작가 취소
	public int authorDown(AuthorVO aVO);
	//작가 정보 불러오기
	public AuthorVO adminAuthorInfo(int no);
	
	//스케줄러 실행: member테이블 회원상태: 정상
	public void scheduleUpdate();
	//스케줄러 실행: member_ban테이블 회원정보 삭제
	public void scheduleDelete();
	
	//자유게시판목록 불러오기
	public List<BoardVO> adminBoardList(AdminPagingVO pVO);
	//자유게시판 카운트
	public int adminboard_totalRecord(AdminPagingVO pVO);
	//자유게시판: 게시글 삭제
	public int adminBoardDel(BoardVO bVO);
	
	//문의게시판목록 불러오기
	public List<BoardVO> adminHelpList(AdminPagingVO pVO);
	//문의게시판목록 카운트
	public int adminhelp_totalRecord(AdminPagingVO pVO);
	//문의게시판: 게시글 삭제
	public int adminHelpDel(BoardVO bVO);
	
	//리뷰게시판목록 불러오기
	public List<AdminReviewVO> adminReviewList(AdminPagingVO pVO);
	//리뷰게시판목록 카운트
	public int adminreview_totalRecord(AdminPagingVO pVO);
	
	//영화리뷰: 게시글 삭제
	public int adminMovieReviewDel(AdminReviewVO arVO);
	//연극리뷰: 게시글 삭제
	public int adminTheaterReviewDel(AdminReviewVO arVO);
	
	//신고목록 불러오기
	public List<AdminReviewVO> adminWarningList(AdminPagingVO pVO);
	//신고목록 카운트
	public int adminwarning_totalRecord(AdminPagingVO pVO);
	
	//감상평목록 불러오기
	public List<AdminReviewVO> adminExReplyList(AdminPagingVO pVO);
	//문의게시판목록 카운트
	public int adminexhibition_totalRecord(AdminPagingVO pVO);
	//감상평 삭제
	public int adminExReplyDel(AdminReviewVO arVO);
	
}
