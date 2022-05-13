package com.team.culife.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.team.culife.service.ReviewService;
import com.team.culife.vo.ReviewVO;

@RestController
public class ReviewController {
	@Inject
	ReviewService service;
	
	
	//¸®ºäµî·Ï
	@RequestMapping(value="/review/reviewWriteOk", method=RequestMethod.POST)
	public int writeOk(ReviewVO vo, HttpSession session) {
		vo.setMember_no((Integer)session.getAttribute("logNo"));
		return service.reviewWrite(vo);
	}
	
	//¸®ºä¸ñ·Ï
	@RequestMapping("/review/reviewList")
	public List<ReviewVO> list(String title){
		return service.reviewList(title);
	}
	
	//¸®ºä¼öÁ¤
	@PostMapping("/review/reviewEditOk")
	public int editOk(ReviewVO vo, HttpSession session) {
		vo.setMember_no((Integer)session.getAttribute("logNo"));
		return service.reviewEdit(vo);
	}
	
	//¸®ºä»èÁ¦
	@GetMapping("/review/reviewDel")
	public int delOk(int no, HttpSession session) {
		return service.reviewDel(no,(Integer)session.getAttribute("logNo"));
	}
}
