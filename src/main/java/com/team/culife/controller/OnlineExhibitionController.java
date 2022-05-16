package com.team.culife.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.team.culife.service.MemberService;
import com.team.culife.vo.MemberVO;

@Controller
@RequestMapping("/online_exhibition")
public class OnlineExhibitionController {
	@Inject
	MemberService memberService;

	@GetMapping("onlineList")
	public ModelAndView onlineList(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		Integer memberNo = (Integer)session.getAttribute("logNo");
		
		try {
			if(memberNo != null) {
				MemberVO mvo = memberService.memberSelectByNo(memberNo);
				mav.addObject("mvo", mvo);
				session.setAttribute("logNo", mvo.getNo());
				session.setAttribute("logNickname", mvo.getNickname());
				session.setAttribute("grade",mvo.getGrade());
				mav.setViewName("online_exhibition/onlineList");
			} else {
				System.out.println("로그인 바람");
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return mav;
	}
	@GetMapping("onlineAuthorList")
	public String onlineAuthorList() {
		return "online_exhibition/onlineAuthorList";
	}
	@GetMapping("onlineAuthorView")
	public String onlineAuthorView() {
		return "online_exhibition/onlineAuthorView";
	}
}
