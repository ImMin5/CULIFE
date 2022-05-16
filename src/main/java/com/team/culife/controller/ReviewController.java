package com.team.culife.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
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
	
	//∏Æ∫‰µÓ∑œ
	@RequestMapping(value="/review/reviewWriteOk", method=RequestMethod.POST)
	public int writeOk(ReviewVO vo, HttpSession session) {
		
		vo.setMember_no((Integer)session.getAttribute("logNo"));
		int cnt=service.oxReview(vo.getMember_no(), vo.getTitle());
		if(cnt>0) {
			return -1;
		}
		return service.reviewWrite(vo);
	}
	
	//∏Æ∫‰∏Ò∑œ
	@RequestMapping("/review/reviewList")
	public Map<String, Object> list(String title){
		double star_avg = service.starAvg(title);	//∆Ú¡°
		int review_cnt = service.reviewCnt(title);		//∏Æ∫‰∞≥ºˆ
		List<ReviewVO> list=service.reviewList(title);
		Map<String, Object> map=new HashMap<>();
		map.put("reviewList", list);
		map.put("star_avg", star_avg);
		map.put("review_cnt", review_cnt);
		return map;
	}
	
	//∏Æ∫‰ºˆ¡§
	@PostMapping("/review/reviewEditOk")
	public int editOk(ReviewVO vo,Integer score_star,  Integer score_star2, HttpSession session) {
		vo.setMember_no((Integer)session.getAttribute("logNo"));
		return service.reviewEdit(vo);
	}
	
	//∏Æ∫‰ªË¡¶
	@GetMapping("/review/reviewDel")
	public int delOk(int no, HttpSession session) {
		return service.reviewDel(no,(Integer)session.getAttribute("logNo"));
	}
	
	/*
	 * //∏Æ∫‰»Æ¿Œ
	 * 
	 * @PostMapping("/oxReview/{title}") public int oxReview(@PathVariable String
	 * title, HttpSession session, ReviewVO review) { int cnt =
	 * service.oxReview(title); System.out.println(cnt); return cnt; }
	 */
}
