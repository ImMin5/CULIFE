package com.team.culife.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.team.culife.service.AlertService;
import com.team.culife.service.ReplyService;
import com.team.culife.vo.ReplyVO;

@RestController
public class ReplyController {
	
	@Inject
	ReplyService service;
	@Inject
	AlertService alertService;
	
	// 댓글 등록하기
	@PostMapping("/reply/writeOk")
	public int writeOk(ReplyVO vo,HttpSession session, @RequestParam(value="category", required=false)String category, @RequestParam(value="subject", required=false)String subject) {
		vo.setMember_no((Integer)session.getAttribute("logNo"));
		vo.setNickname((String)session.getAttribute("nickName"));
		
		if(category!= null && category.equals("help")) {
			alertService.alertInsert(vo.getMember_no(), "문의하신 '"+ subject+"'에 답변이 달렸습니다!.");
		}
		
		return service.insertReply(vo);
	}
	
	// 댓글 목록보이기
	@GetMapping("/reply/replyList")
	public List<ReplyVO> replyList(int no){

		return service.selectReplyList(no);
	}
	
	// 댓글 수정하기
	@PostMapping("/reply/editOk")
	@ResponseBody
	public int updateReply(ReplyVO vo, HttpSession session) {
		vo.setNickname((String)session.getAttribute("nickName"));
		return service.updateReply(vo);
	}
	
	//댓글 삭제하기
	@GetMapping("/reply/delOk")
	@ResponseBody
	public int deleteReply(int reply_no, int member_no) {
		return service.deleteReply(reply_no, member_no); 
	}
}