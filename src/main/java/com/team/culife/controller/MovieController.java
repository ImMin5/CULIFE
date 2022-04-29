package com.team.culife.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.team.culife.service.MovieService;

@RestController
@RequestMapping("/movie/")
public class MovieController {
	
	@Inject
	MovieService service;
	
	//영화 메인페이지이동
	@GetMapping("movieList")
	public ModelAndView movieList(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("movie/movieList");
		return mav;
	}
	
	//영화 세부페이지이동
	@GetMapping("movieView")
	public ModelAndView movieView(int movie_id) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("movie/movieView");
		return mav;
	}
	

}