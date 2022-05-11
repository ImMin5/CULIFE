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
	
	
	//��۵��
	@RequestMapping(value="/review/reviewWriteOk", method=RequestMethod.POST)
	public int writeOk(ReviewVO vo, HttpSession session) {
		vo.setNo((Integer)session.getAttribute("logNo"));
		return service.reviewWrite(vo);
	}
	
	//��۸��
	@RequestMapping("/review/reviewList")
	public List<ReviewVO> list(String title){
		return service.reviewList(title);
	}
	
	//��ۼ���
	@PostMapping("review/reviewEditOk")
	public int editOk(ReviewVO vo, HttpSession session) {
		vo.setMember_no((Integer)session.getAttribute("logNo"));
		return service.reviewEdit(vo);
	}
	
	//��ۻ���
	@GetMapping("/review/reviewDel")
	public int delOk(int no, HttpSession session) {
		return service.reviewDel(no, (String)session.getAttribute("logNo"));
	}
}