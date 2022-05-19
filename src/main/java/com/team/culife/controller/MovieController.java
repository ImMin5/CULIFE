package com.team.culife.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.team.culife.service.MovieReviewService;
import com.team.culife.service.MovieService;

@RestController
@RequestMapping("/movie/")
public class MovieController {
   
   @Inject
   MovieService service;

	@Inject
	MovieReviewService service2;
   //�쁺�솕 硫붿씤�럹�씠吏��씠�룞
   @GetMapping("movieList")
   public ModelAndView movieList(HttpSession session) {
      ModelAndView mav = new ModelAndView();
      mav.setViewName("movie/movieList");
      return mav;
   }

   //�쁺�솕 �꽭遺��럹�씠吏��씠�룞
   @GetMapping("movieView")
   public ModelAndView movieView(int movieId) {
      ModelAndView mav = new ModelAndView();
  	double mstar_avg = service2.MstarAvg(movieId);
      mav.addObject("movieId",movieId);
      mav.addObject("mstar_avg",mstar_avg);
      mav.setViewName("movie/movieView");
      return mav;
   }
   
   //�쁺�솕 寃��깋�럹�씠吏��씠�룞
   @GetMapping("movieSearch")
   public ModelAndView movieSearch(String searchMovie) {
      ModelAndView mav = new ModelAndView();
      mav.addObject("searchMovie", searchMovie);
      mav.setViewName("movie/movieSearch");
      return mav;
   }

}