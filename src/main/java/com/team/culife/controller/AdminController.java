package com.team.culife.controller;

import javax.inject.Inject;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.team.culife.service.AdminService;
import com.team.culife.vo.AdminPagingVO;
import com.team.culife.vo.AuthorVO;
import com.team.culife.vo.BoardVO;
import com.team.culife.vo.MemberBanVO;
import com.team.culife.vo.MemberVO;

@RestController
@RequestMapping("/admin/*")
public class AdminController {
	@Inject
	AdminService service;
	
	//choi0429-관리자 접속 기본페이지(회원관리)
	@GetMapping("/memberList")
	public ModelAndView memberList(AdminPagingVO pVO) {
		ModelAndView mav = new ModelAndView();
		//회원목록페이징
		pVO.setTotalRecord(service.totalRecord(pVO));
		mav.addObject("pVO", pVO);
		//회원목록 불러오기
		mav.addObject("memberList", service.memberList(pVO));

		mav.setViewName("/admin/memberList");
		return mav;
	}
	
	//choi0429- 회원관리페이지 - 상태설정
	@GetMapping("/memberStatus")
	public ModelAndView memberStatus(MemberVO mVO, MemberBanVO mbVO, int no, String memberStatus) {
		ModelAndView mav = new ModelAndView();
		if(memberStatus.equals("ok")) {
			//회원상태가 ok일때
			//member_ban에서 제거.
			mbVO.setMember_no(no);
			service.memberBanDel(mbVO);
			//member에서 status = 0으로 변경
			service.memberNor(mVO);
		}else if(memberStatus.equals("7")){
			//회원상태가 7일때
			//member에서 status = 1으로 변경
			service.memberBan(mVO);
			//member_ban에서 ban날짜 설정
			mbVO.setAdd_date(Integer.parseInt(memberStatus));
			service.memberBanDate(mbVO);
		}else if(memberStatus.equals("30")){
			//회원상태가 30일때
			//member에서 status = 1으로 변경
			service.memberBan(mVO);
			//member_ban에서 ban날짜 설정
			mbVO.setAdd_date(Integer.parseInt(memberStatus));
			service.memberBanDate(mbVO);
		}else if(memberStatus.equals("del")){
			service.memberDel(mVO);
		}
		mav.setViewName("redirect:/admin/memberList");
		return mav;
	}
	
	//choi0502-작가리스트 페이지로 이동
	@GetMapping("/authorList")
	public ModelAndView authorList(AdminPagingVO pVO) {
		ModelAndView mav = new ModelAndView();
		//작가목록목록페이징
		pVO.setTotalRecord(service.author_totalRecord(pVO));
		mav.addObject("pVO", pVO);
		//작가목록 불러오기
		mav.addObject("authorList", service.authorList(pVO));
			
		mav.setViewName("/admin/authorList");
		return mav;
	}
	
	//choi0502-작가 승인
	@GetMapping("/authorUpgrade")
	public ModelAndView authorUpgrade(AuthorVO aVO) {
		ModelAndView mav = new ModelAndView();
		service.authorUpgrade(aVO);
		mav.setViewName("redirect:/admin/authorList");
		return mav;
	}
	
	//choi0502-작가 취소
	@GetMapping("/authorDelete")
	public ModelAndView authorDelete(AuthorVO aVO) {
		ModelAndView mav = new ModelAndView();
		service.authorDown(aVO);
		mav.setViewName("redirect:/admin/authorList");
		return mav;
	}
	
	//choi0502-자유게시판 불러오기
	@GetMapping("/adminBoardList")
	public ModelAndView adminBoardList(AdminPagingVO pVO) {
		ModelAndView mav = new ModelAndView();
		//작가목록목록페이징
		pVO.setTotalRecord(service.adminboard_totalRecord(pVO));
		mav.addObject("pVO", pVO);
		//자유게시판목록 불러오기
		mav.addObject("adminBoardList", service.adminBoardList(pVO));
		
		mav.setViewName("/admin/adminBoardList");
		return mav;
	}
	
	//choi0504-자유게시판 게시글삭제
	@GetMapping("/adminBoardDel")
	public ModelAndView adminBoardDel(BoardVO bVO) {
		ModelAndView mav = new ModelAndView();
		service.adminBoardDel(bVO);
		mav.setViewName("redirect:/admin/adminBoardList");
		return mav;
	}
}
