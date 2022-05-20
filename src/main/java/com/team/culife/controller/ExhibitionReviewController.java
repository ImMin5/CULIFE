package com.team.culife.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.team.culife.service.ExhibitionReviewService;
import com.team.culife.vo.ExhibitionReviewVO;

@RestController
public class ExhibitionReviewController {
	
	@Inject
	ExhibitionReviewService service;
	
	// 댓글 등록하기
	@PostMapping("/ex_review/writeOk")
	public int writeOk(ExhibitionReviewVO vo, HttpSession session) {
		vo.setMember_no((Integer)session.getAttribute("logNo"));
		vo.setNickname((String)session.getAttribute("nickName"));
		
		return service.insert_ExhibitionReview(vo);
	}
	
	// 댓글 목록보이기
	@GetMapping("/ex_review/reviewList")
	public List<ExhibitionReviewVO> select_ExhibitionReviewList(int no){

		return service.select_ExhibitionReviewList(no);
	}
	
	// 댓글 수정하기
	@PostMapping("/ex_review/editOk")
	@ResponseBody
	public int updateReply(ExhibitionReviewVO vo, HttpSession session) {
		vo.setNickname((String)session.getAttribute("nickName"));
		return service.update_ExhibitionReview(vo);
	}
	
	//댓글 삭제하기
	@GetMapping("/ex_review/delOk")
	@ResponseBody
	public int deleteReply(int exhibition_no, int member_no) {
		return service.delete_ExhibitionReview(exhibition_no, member_no); 
	}
}