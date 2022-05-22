package com.team.culife.controller;

import java.io.Console;

import javax.inject.Inject;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.team.culife.service.AdminService;
import com.team.culife.service.AlertService;
import com.team.culife.vo.AdminPagingVO;
import com.team.culife.vo.AdminReviewVO;
import com.team.culife.vo.AuthorVO;
import com.team.culife.vo.BoardVO;
import com.team.culife.vo.MemberBanVO;
import com.team.culife.vo.MemberVO;

@RestController
@RequestMapping("/admin/*")
public class AdminController {
	@Inject
	AdminService service;
	@Inject
	AlertService arservice;

	// choi0429-관리자 접속 기본페이지(회원관리)
	@GetMapping("/memberList")
	public ModelAndView memberList(AdminPagingVO pVO) {
		ModelAndView mav = new ModelAndView();
		if(pVO.getSearchWord() != null && pVO.getSearchWord().equals("정지")) {
			pVO.setSearchWord("1");
		}
		if(pVO.getSearchWord() != null && pVO.getSearchWord().equals("정상")) {
			pVO.setSearchWord("0");
		}
		if(pVO.getSearchWord() != null && pVO.getSearchWord().equals("일반회원")) {
			pVO.setSearchWord("0");
		}
		if(pVO.getSearchWord() != null && pVO.getSearchWord().equals("작가")) {
			pVO.setSearchWord("1");
		}
		if(pVO.getSearchWord() != null && pVO.getSearchWord().equals("관리자")) {
			pVO.setSearchWord("2");
		}
		// 회원목록페이징
		pVO.setTotalRecord(service.totalRecord(pVO));
		mav.addObject("pVO", pVO);
		// 회원목록 불러오기
		mav.addObject("memberList", service.memberList(pVO));
		mav.setViewName("/admin/memberList");
		return mav;
	}

	// choi0429- 회원관리페이지 - 상태설정
	@GetMapping("/memberStatus")
	public ModelAndView memberStatus(MemberVO mVO, MemberBanVO mbVO, int no, String memberStatus) {
		ModelAndView mav = new ModelAndView();
		if (memberStatus.equals("ok")) {
			// 회원상태가 ok일때
			// member_ban에서 제거.
			mbVO.setMember_no(no);
			service.memberBanDel(mbVO);
			// member에서 status = 0으로 변경
			service.memberNor(mVO);
		} else if (memberStatus.equals("7")) {
			// 회원상태가 7일때
			// member에서 status = 1으로 변경
			service.memberBan(mVO);			
			// member_ban에서 ban날짜 설정
			mbVO.setAdd_date(Integer.parseInt(memberStatus));
			if(mbVO.getEnd_date() == "") {
				service.memberBanDate(mbVO);
			}else if(mbVO.getEnd_date() != "") {
				service.memberBanDateUp(mbVO);
			}
			
		} else if (memberStatus.equals("30")) {
			// 회원상태가 30일때
			// member에서 status = 1으로 변경
			service.memberBan(mVO);
			// member_ban에서 ban날짜 설정
			mbVO.setAdd_date(Integer.parseInt(memberStatus));
			if(mbVO.getEnd_date() == "") {
				service.memberBanDate(mbVO);
			}else if(mbVO.getEnd_date() != "") {
				service.memberBanDateUp(mbVO);
			}
		} else if (memberStatus.equals("del")) {
			service.memberDel(mVO);
		}
		mav.setViewName("redirect:/admin/memberList");
		return mav;
	}

	// choi0502-작가리스트 페이지로 이동
	@GetMapping("/authorList")
	public ModelAndView authorList(AdminPagingVO pVO) {
		ModelAndView mav = new ModelAndView();
		if(pVO.getSearchWord() != null && pVO.getSearchWord().equals("대기")) {
			pVO.setSearchWord("0");
		}
		if(pVO.getSearchWord() != null && pVO.getSearchWord().equals("승인")) {
			pVO.setSearchWord("1");
		}
		if(pVO.getSearchWord() != null && pVO.getSearchWord().equals("취소")) {
			pVO.setSearchWord("2");
		}
		// 작가목록목록페이징
		pVO.setTotalRecord(service.author_totalRecord(pVO));
		mav.addObject("pVO", pVO);
		// 작가목록 불러오기
		mav.addObject("authorList", service.authorList(pVO));

		mav.setViewName("/admin/authorList");
		return mav;
	}

	// choi0502-작가 승인
	@GetMapping("/authorUpgrade")
	public ModelAndView authorUpgrade(AuthorVO aVO) {
		ModelAndView mav = new ModelAndView();
		int member_no = aVO.getMember_no();
		String content = "작가신청이 승인되었습니다.";
		arservice.alertInsert(member_no, content);
		service.authorUpgrade(aVO);
		mav.setViewName("redirect:/admin/authorList");
		return mav;
	}

	// choi0502-작가 취소
	@GetMapping("/authorDelete")
	public ModelAndView authorDelete(AuthorVO aVO) {
		ModelAndView mav = new ModelAndView();
		int member_no = aVO.getMember_no();
		String content = aVO.getMsg();
		System.out.println("승인 취소 memberNo-->" + aVO.getMember_no());
		arservice.alertInsert(member_no, content);
		service.authorDown(aVO);
		mav.setViewName("redirect:/admin/authorList");
		return mav;
	}

	// choi0513-작가 정보불러오기
	@GetMapping("/adminAuthorInfo")
	public AuthorVO adminAuthorInfo(int no) {
		return service.adminAuthorInfo(no);
	}

	// choi0502-자유게시판 불러오기
	@GetMapping("/adminBoardList")
	public ModelAndView adminBoardList(AdminPagingVO pVO) {
		ModelAndView mav = new ModelAndView();
		// 자유게시판목록페이징
		pVO.setTotalRecord(service.adminboard_totalRecord(pVO));
		mav.addObject("pVO", pVO);
		// 자유게시판목록 불러오기
		mav.addObject("adminBoardList", service.adminBoardList(pVO));

		mav.setViewName("/admin/adminBoardList");
		return mav;
	}

	// choi0504-자유게시판 게시글삭제
	@GetMapping("/adminBoardDel")
	public ModelAndView adminBoardDel(BoardVO bVO) {
		ModelAndView mav = new ModelAndView();
		service.adminBoardDel(bVO);
		mav.setViewName("redirect:/admin/adminBoardList");
		return mav;
	}

	// choi0506-문의게시판 페이지로 이동
	@GetMapping("/adminHelpList")
	public ModelAndView adminHelpList(AdminPagingVO pVO) {
		ModelAndView mav = new ModelAndView();
		// 문의사항목록페이징
		pVO.setTotalRecord(service.adminhelp_totalRecord(pVO));
		mav.addObject("pVO", pVO);
		// 문의사항목록 불러오기
		mav.addObject("adminHelpList", service.adminHelpList(pVO));

		mav.setViewName("/admin/adminHelpList");
		return mav;
	}

	// choi0504-문의게시판 게시글삭제
	@GetMapping("/adminHelpDel")
	public ModelAndView adminHelpDel(BoardVO bVO) {
		ModelAndView mav = new ModelAndView();
		service.adminHelpDel(bVO);
		mav.setViewName("redirect:/admin/adminHelpList");
		return mav;
	}

	// choi0512-리뷰게시판 페이지로 이동
	@GetMapping("/adminReviewList")
	public ModelAndView adminReviewList(AdminPagingVO pVO) {
		ModelAndView mav = new ModelAndView();
		// 리뷰목록 페이징
		pVO.setTotalRecord(service.adminreview_totalRecord(pVO));
		mav.addObject("pVO", pVO);
		// 리뷰목록 불러오기
		mav.addObject("adminReviewList", service.adminReviewList(pVO));

		mav.setViewName("/admin/adminReviewList");
		return mav;
	}

	// choi0512-리뷰게시판 게시글삭제
	@GetMapping("/adminReviewDel")
	public ModelAndView adminReviewDel(AdminReviewVO arVO) {
		ModelAndView mav = new ModelAndView();
		if (arVO.getMovie_noList() != null) {
			service.adminMovieReviewDel(arVO);
		}
		;
		if (arVO.getNoList() != null) {
			service.adminTheaterReviewDel(arVO);
		}
		;
		mav.setViewName("redirect:/admin/adminReviewList");
		return mav;
	}

	// choi0512-신고관리 페이지로 이동
	@GetMapping("/adminWarningList")
	public ModelAndView adminWarningList(AdminPagingVO pVO) {
		ModelAndView mav = new ModelAndView();
		// 문의사항목록페이징
		pVO.setTotalRecord(service.adminwarning_totalRecord(pVO));
		mav.addObject("pVO", pVO);
		// 문의사항목록 불러오기
		mav.addObject("adminWarningList", service.adminWarningList(pVO));

		mav.setViewName("/admin/adminWarningList");
		return mav;
	}

	// choi0512-신고관리 게시글삭제
	@GetMapping("/adminWarningDel")
	public ModelAndView adminWarningDel(AdminReviewVO arVO) {
		ModelAndView mav = new ModelAndView();
		if (arVO.getMovie_noList() != null) {
			service.adminMovieReviewDel(arVO);
		}
		;
		if (arVO.getNoList() != null) {
			service.adminTheaterReviewDel(arVO);
		}
		;
		mav.setViewName("redirect:/admin/adminWarningList");
		return mav;
	}

	// choi0512-감상평관리 페이지로 이동
	@GetMapping("/adminExReplyList")
	public ModelAndView adminExReplyList(AdminPagingVO pVO) {
		ModelAndView mav = new ModelAndView();
		// 문의사항목록페이징
		pVO.setTotalRecord(service.adminexhibition_totalRecord(pVO));
		mav.addObject("pVO", pVO);
		// 문의사항목록 불러오기
		mav.addObject("adminExReplyList", service.adminExReplyList(pVO));

		mav.setViewName("/admin/adminExReplyList");
		return mav;
	}

	// choi0512-감상평관리 게시글삭제
	@GetMapping("/adminExReplyDel")
	public ModelAndView adminExReplyDel(AdminReviewVO arVO) {
		ModelAndView mav = new ModelAndView();
		service.adminExReplyDel(arVO);
		mav.setViewName("redirect:/admin/adminExReplyList");
		return mav;
	}
}
