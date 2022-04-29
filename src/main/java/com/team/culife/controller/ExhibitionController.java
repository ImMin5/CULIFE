package com.team.culife.controller;

import javax.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.team.culife.vo.ExhibitionVO;

@RestController
@RequestMapping("/exhibition/")
public class ExhibitionController {
	
	@GetMapping("authorApply")
	public ModelAndView movieList(HttpSession session, ExhibitionVO vo) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("exhibition/authorApply");
		System.out.println("nickname "+vo.getNickname());
		return mav;
	}
}
