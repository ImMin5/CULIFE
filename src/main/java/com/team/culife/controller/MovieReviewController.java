package com.team.culife.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.team.culife.service.MovieReviewService;
import com.team.culife.vo.MovieReviewVO;

@RestController
public class MovieReviewController {
	@Inject
	MovieReviewService service;
	
	//영화리뷰등록
	@RequestMapping(value="/mreview/mreviewWriteOk", method=RequestMethod.POST)
	public int mwriteOk(MovieReviewVO vo, HttpSession session) {
		vo.setMember_no((Integer)session.getAttribute("logNo"));
		int cnt=service.oxMReview(vo.getMember_no(), vo.getMovie_id());
		if(cnt>0) {
			return -1;
		}
		return service.MreviewWrite(vo);
	}
	
	//영화리뷰목록
	@RequestMapping("/mreview/mreviewList")
	public Map<String, Object> mlist(Integer movie_id){
		double mstar_avg = service.MstarAvg(movie_id);
		int mreview_cnt = service.MreviewCnt(movie_id);
		List<MovieReviewVO> mlist = service.MreviewList(movie_id);
		Map<String, Object> map = new HashMap<>();
		map.put("reviewList", mlist);
		map.put("star_avg", mstar_avg);
		map.put("review_cnt", mreview_cnt);
		return map;
	}
	
	//영화리뷰수정
	@PostMapping("/mreview/mreviewEditOk")
	public int meditOk(MovieReviewVO vo, Integer score_star, HttpSession session) {
		vo.setMember_no((Integer)session.getAttribute("logNo"));
		return service.MreviewEdit(vo);
	}
	
	//영화리뷰삭제
	@GetMapping("/mreview/mreviewDel")
	public int mdelOk(int no, HttpSession session) {
		return service.MreviewDel(no, (Integer)session.getAttribute("logNo"));
	}
}
