package com.team.culife.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.team.culife.dao.AdminDAO;
import com.team.culife.vo.AdminPagingVO;
import com.team.culife.vo.AdminReviewVO;
import com.team.culife.vo.AuthorVO;
import com.team.culife.vo.BoardVO;
import com.team.culife.vo.MemberBanVO;
import com.team.culife.vo.MemberVO;

@Service
public class AdminServiceImpl implements AdminService{
	@Inject
	AdminDAO dao;

	//회원목록
	@Override
	public List<MemberVO> memberList(AdminPagingVO pVO) {
		return dao.memberList(pVO);
	}
	@Override
	public int totalRecord(AdminPagingVO pVO) {
		return dao.totalRecord(pVO);
	}
	@Override
	public int memberDel(MemberVO mVO) {
		return dao.memberDel(mVO);
	}
	@Override
	public int memberNor(MemberVO mVO) {
		return dao.memberNor(mVO);
	}
	@Override
	public int memberBan(MemberVO mVO) {
		return dao.memberBan(mVO);
	}
	@Override
	public int memberBanDel(MemberBanVO mbVO) {
		return dao.memberBanDel(mbVO);
	}
	@Override
	public int memberBanDate(MemberBanVO mbVO) {
		return dao.memberBanDate(mbVO);
	}
	
	//작가목록
	@Override
	public List<AuthorVO> authorList(AdminPagingVO pVO) {
		return dao.authorList(pVO);
	}
	@Override
	public int author_totalRecord(AdminPagingVO pVO) {
		return dao.author_totalRecord(pVO);
	}
	@Override
	public int author_cnt(AuthorVO aVO) {
		return dao.author_cnt(aVO);
	}
	@Override
	public int authorUpgrade(AuthorVO aVO) {
		return dao.authorUpgrade(aVO);
	}
	@Override
	public int authorDown(AuthorVO aVO) {
		return dao.authorDown(aVO);
	}
	@Override
	public AuthorVO adminAuthorInfo(int no) {
		return dao.adminAuthorInfo(no);
	}
	//스케줄러
	@Override
	public void scheduleUpdate() {
		dao.scheduleUpdate();
	}
	@Override
	public void scheduleDelete() {
		dao.scheduleDelete();
	}
	
	//자유게시판목록
	@Override
	public List<BoardVO> adminBoardList(AdminPagingVO pVO) {
		return dao.adminBoardList(pVO);
	}
	@Override
	public int adminboard_totalRecord(AdminPagingVO pVO) {
		return dao.adminboard_totalRecord(pVO);
	}
	@Override
	public int adminBoardDel(BoardVO bVO) {
		return dao.adminBoardDel(bVO);
	}
	
	//문의사항게시판
	@Override
	public List<BoardVO> adminHelpList(AdminPagingVO pVO) {
		return dao.adminHelpList( pVO);
	}
	@Override
	public int adminhelp_totalRecord(AdminPagingVO pVO) {
		return dao.adminhelp_totalRecord(pVO);
	}
	@Override
	public int adminHelpDel(BoardVO bVO) {
		return dao.adminHelpDel(bVO);
	}
	
	//리뷰관리
	@Override
	public List<AdminReviewVO> adminReviewList(AdminPagingVO pVO) {
		return dao.adminReviewList(pVO);
	}
	@Override
	public int adminreview_totalRecord(AdminPagingVO pVO) {
		return dao.adminreview_totalRecord(pVO);
	}
	
	//영화리뷰 삭제
	@Override
	public int adminMovieReviewDel(AdminReviewVO arVO) {
		return dao.adminMovieReviewDel(arVO);
	}
	//연극리뷰 삭제
	@Override
	public int adminTheaterReviewDel(AdminReviewVO arVO) {
		return dao.adminTheaterReviewDel(arVO);
	}
	
	//신고관리
	@Override
	public List<AdminReviewVO> adminWarningList(AdminPagingVO pVO) {
		return dao.adminWarningList(pVO);
	}
	@Override
	public int adminwarning_totalRecord(AdminPagingVO pVO) {
		return dao.adminwarning_totalRecord(pVO);
	}
	
	//감상평관리
	@Override
	public List<AdminReviewVO> adminExReplyList(AdminPagingVO pVO) {
		return dao.adminExReplyList(pVO);
	}
	@Override
	public int adminexhibition_totalRecord(AdminPagingVO pVO) {
		return dao.adminexhibition_totalRecord(pVO);
	}
	@Override
	public int adminExReplyDel(AdminReviewVO arVO) {
		return dao.adminExReplyDel(arVO);
	}
	
	
	
	
	
	
}
