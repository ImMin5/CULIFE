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
	
<<<<<<< HEAD
	//영화 메인페이지이동
=======

>>>>>>> 91b63f93fa3ea0b5e565e4df9f3be20991445236
	@GetMapping("movieList")
	public ModelAndView movieList(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("movie/movieList");
		return mav;
	}
	
<<<<<<< HEAD
	//영화 세부페이지이동
=======

>>>>>>> 91b63f93fa3ea0b5e565e4df9f3be20991445236
	@GetMapping("movieView")
	public ModelAndView movieView(int movieId) {
		ModelAndView mav = new ModelAndView();
		mav.addObject("movieId",movieId);
		mav.setViewName("movie/movieView");
		return mav;
	}
	

}