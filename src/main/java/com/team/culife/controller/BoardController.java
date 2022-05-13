package com.team.culife.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.team.culife.service.BoardService;
import com.team.culife.vo.BoardVO;
import com.team.culife.vo.PagingVO;

@RestController
@RequestMapping("/board/")
public class BoardController {
	@Inject
	BoardService service;
	
	ModelAndView mav = new ModelAndView();
	
	//자유게시판
	@GetMapping("freeBoardList")
	public ModelAndView freeboardList(PagingVO pVO) {
		mav.setViewName("/board/freeBoardList");
		return mav;
	}
	
	//자유게시판 게시글 등록 폼
	@GetMapping("freeBoardWrite")
	public ModelAndView freeBoardWrite() {
		mav.setViewName("board/freeBoardWrite");
		return mav;
	}
	
	//자유게시판 상세페이지 뷰
	@GetMapping("freeBoardView")
	public ModelAndView freeView(int no, String userid, HttpSession session) {
		// 조회수 증가
		service.updateViews(no);
			
		// 상세페이지 보이기(뷰 보이기)
		mav.addObject("viewVo", service.selectView(no));
		mav.setViewName("/board/freeBoardView");
		
		return mav;
	}
	
	//자유게시판 글등록 DB연결
		@PostMapping("rentBoardWriteOk")
		public ModelAndView rentWriteOk(BoardVO vo, HttpServletRequest request){
			// 현재 session에 있는 ID와 카테고리
			vo.setMember_no((int)request.getSession().getAttribute("logId")); 
			vo.setNickname((String)request.getSession().getAttribute("nickName")); 
			vo.setCategory("free");

			mav.addObject("vo", vo);
			mav.setViewName("board/boardWriteSuc");
			return mav;
		}
	//문의사항게시판
	@GetMapping("helpBoardList")
	public ModelAndView helpboardList(PagingVO pVO) {		
		mav.setViewName("/board/helpBoardList");
		return mav;	
	}
	//문의사항 게시글 등록 폼
	@GetMapping("helpBoardWrite")
	public ModelAndView helpBoardWrite() {
		mav.setViewName("board/helpBoardWrite");
		return mav;
	}
	// 대여 상세페이지 뷰
	@GetMapping("helpBoardView")
	public ModelAndView helpView(int no, String userid, HttpSession session) {
		// 조회수 증가
		service.updateViews(no);
			
		// 상세페이지 보이기(뷰 보이기)
		mav.addObject("viewVo", service.selectView(no));
		mav.setViewName("board/helpBoardView");
		
		return mav;
	}
}