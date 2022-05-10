package com.team.culife.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/online_exhibition")
public class OnlineExhibitionController {

	@GetMapping("onlineList")
	public ModelAndView onlineList() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("online_exhibition/onlineList");
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
