package com.team.culife.controller;

import java.sql.SQLException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import com.team.culife.service.WarningService;
import com.team.culife.vo.WarningVO;

@RestController
public class WarningController {
	@Autowired
	private WarningService warningService;
	
	@GetMapping("/warning/{review_no}")
	public int warning(WarningVO vo, @PathVariable int review_no, HttpSession session) {
		System.out.println(review_no);
		vo.setMember_no((Integer)session.getAttribute("logNo"));
		vo.setReview_no(review_no);
		try {
			int n=warningService.warning(vo);
			return n;
		}catch(Exception e) {
			return -1;
		}
	}
}
