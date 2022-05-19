package com.team.culife.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import com.team.culife.service.MovieWarningService;
import com.team.culife.vo.MovieWarningVO;

@RestController
public class MovieWarningController {
	@Autowired
	private MovieWarningService mwarningService;
	
	@GetMapping("/mwarning/{review_no")
	public int mwarning(MovieWarningVO vo, @PathVariable int review_no, HttpSession session) {
		vo.setMember_no((Integer)session.getAttribute("logNo"));
		vo.setReview_no(review_no);
		try {
			int n = mwarningService.mwarning(vo);
			return n;
		}catch(Exception e) {
			return -1;
		}
	}
}
