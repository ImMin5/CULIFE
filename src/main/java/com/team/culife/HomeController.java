package com.team.culife;


import javax.inject.Inject;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.team.culife.service.BoardService;
import com.team.culife.vo.BoardVO;
import com.team.culife.vo.PagingVO;

@RestController
public class HomeController {
	@Inject
	BoardService service;
	
	@GetMapping("/")
	public ModelAndView home(PagingVO pVO, BoardVO vo) {
		ModelAndView mav = new ModelAndView();
		pVO.setRecordPerPage(5);
		mav.addObject("list", service.freeselectList(pVO));
		
		mav.setViewName("home");
		
		return mav;
	}
}
