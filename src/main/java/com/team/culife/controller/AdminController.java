package com.team.culife.controller;

import javax.inject.Inject;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.team.culife.service.AdminService;
import com.team.culife.vo.MemberBanVO;
import com.team.culife.vo.MemberListPagingVO;
import com.team.culife.vo.MemberVO;

@RestController
@RequestMapping("/admin/*")
public class AdminController {
	@Inject
	AdminService service;
	
	//choi0429-관리자 접속 기본페이지(회원관리)
	@GetMapping("/memberList")
	public ModelAndView memberList(MemberListPagingVO pVO) {
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
}
